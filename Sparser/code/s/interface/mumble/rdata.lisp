;;; -*- Mode: Lisp; Syntax: Common-Lisp; Package: SPARSER; -*-
;;; Copyright (c) 2016-2017 David D. McDonald. All Rights Reserved.
;;;
;;;     File: "rdata"
;;;   Module: "interface;mumble;"
;;;  Version: July 2017

(in-package :sparser)

;;;--------------------------------------------
;;; Mumble information within shortcut schemes
;;;--------------------------------------------
#|  Infer variable-parameter maps by exploiting information stored
on the EFT family objects used by short-cut realizations. E.g

(define-category grow ...
  :realization
     (:verb ("grow" :past-tense "grown")
      :etf (svo-passive)) ... )



 information analogous to what we could state explicitly
|#

;;--- creating

(defun translate-mumble-phrase-data (phrase-exp)
  "Called from define-realization-scheme to decode and check
   the Mumble side of the mapping schema. This map is like the 
   maps in realization schema in that it records variable
   descriptors (e.g. subj-slot) rather than actual variables.
   The converstion to actual variables is done by make-mumble-mapping
   which is called by decode-shortcut-rdata.
     The value this returns becomes the value of the 'phrase'
   slot of the realization-scheme we're defining."
  (let* ((phrase-name (car phrase-exp))
         (phrase (m::phrase-named (mumble-symbol phrase-name)))
         (arg-pairs (cdr phrase-exp))
         (decoded-pairs
          (loop for (param-name . schematic-var) in arg-pairs
             as param = (m::parameter-named (mumble-symbol param-name))
             collect `(,param . ,schematic-var))))
    (cons phrase decoded-pairs)))


(defun setup-mumble-data (raw-data category rdata)
  "Called from the initialize-instance method of realization-data.
   Take the phrase and mapping prepared in decode-shortcut-data ('mdata')
   working from the information on the phrase and create the runtime 
   object that realize et al. will access. Store that on the 
   instance ('rdata')."
  (let ((head-data (rdata-head-words rdata)))
    (let ( m-readings ) ;; if multiple pos will get mulitple mdata
      (do ((pos (car head-data) (car rest))
           (word (cadr head-data) (cadr rest))
           (rest (cddr head-data) (cddr rest)))
          ((null pos))
        (let ((mdata (construct-mdata category pos word raw-data)))
          (push mdata m-readings)))
      (setf (mumble-rdata rdata) (nreverse m-readings)))))


(defun construct-mdata (category pos word raw-data)
  "If its a verb and there's a verb-oriented lp in the raw data we'll
   assume it gets the map. For other parts of speech we leave those
   fields empty and just use the lp we get from the word."
  ;;(lsp-break "pos = ~a word = ~a" pos word)
  (case pos
    (:verb
     (let* ((phrase (car raw-data))
            (map (cdr raw-data))
            (variables (loop for (parameter . variable) in map
                          collect variable))
            (param-var-map
             (loop for (parameter . variable) in map
                collect (make-instance 'mumble::parameter-variable-pair
                                       :var variable :param parameter))))
       (multiple-value-bind (m-head lp)
           (decode-rdata-head-data pos word category phrase)
         (make-instance 'm::mumble-rdata
                        :class category
                        :lp lp
                        :map param-var-map
                        :head m-head
                        :vars variables))))
    (:common-noun
     (multiple-value-bind (m-head lp)
         (decode-rdata-head-data pos word category)
       (make-instance 'm::mumble-rdata
                      :class category
                      :lp lp
                      :head m-head)))
    (:adjective
     (multiple-value-bind (m-head lp)
         (decode-rdata-head-data pos word category)
       (make-instance 'm::mumble-rdata
                      :class category
                      :lp lp
                      :head m-head)))
    (otherwise
     (lsp-break "Unanticipated part of speech in rdata: ~a" pos))))
  
  
(defun decode-rdata-head-data (pos word-data category &optional phrase)
  "The head information in realization-data is moderately complicated.
   This digests it and returns the mumble word that is the head and
   the corresponding lexicalized phrase."
  (multiple-value-bind (s-head-word irregulars)
      (etypecase word-data
        (cons (values (car word-data) (cdr word-data))) ;; or could be synonyms
        (word word-data)
        (polyword word-data))
    (declare (ignore irregulars)) ;;//// third arg in define-word/expr
    (multiple-value-bind (lp m-word m-pos)
        (make-resource-for-sparser-word s-head-word pos category phrase)
      (values m-word lp m-pos))))


;;--- retrieving

#| The realization of an individual is principally determined by its
lexicalized-phrase (see m::get-lexicalized-phrase). However, we may also
know how to realize the entire relation (category) that the individual
instantiates. 
   If there is more than one possible realization we have to select
among them on some basis. Presently we can do this by part of speech
and/or by which subcategorized arguments the individual binds. 
|#

#+:mumble
(defgeneric has-mumble-rdata (category &key pos)
  (:documentation "Return the mumble field in the category's rdata.
    If there are several realizations use the part of speech to
    discriminate among them.")
  
  (:method ((i individual) &key pos)
    (let ((mumble-rdata (has-mumble-rdata (itype-of i) :pos pos)))
      (when mumble-rdata
        (m::select-realization mumble-rdata i pos))))

  (:method ((c category) &key pos)
    (let ((rdata-field (rdata c)))
      (when rdata-field ;; does the category have any recorded realizations?
        (when (some #'mumble-rdata rdata-field)
          ;; do any have mumble realiation information on them?
          (let* ((relevant-rdata (loop for r in rdata-field
                                    when (mumble-rdata r)
                                    collect r))
                 (mumble-rdata (loop for rr in relevant-rdata
                                  collect (mumble-rdata rr))))
            (when mumble-rdata
              (when (consp mumble-rdata) ;; expected
                (unless (every #'m::mumble-rdata? mumble-rdata)
                  ;; could be a spurious extra level of parens
                  (if (and (= 1 (length mumble-rdata))
                           (m::mumble-rdata? (car (car mumble-rdata))))
                    (setq mumble-rdata (car mumble-rdata))
                    (error "Ill-formed rdata for mumble: ~a" mumble-rdata))))
              mumble-rdata )))))))


;;--- expedited access

(defgeneric mumble-data (unit)
  (:documentation "Return the mumble field of the unit
    if there is one.")
  (:method ((i individual)) (mumble-data (itype-of i)))
  (:method ((s symbol)) (mumble-data (category-named s :error-if-null)))
  (:method ((c referential-category))
    (let ((rdata (cat-realization c)))
      (when rdata (mumble-data rdata))))
  (:method ((list cons))
    (when (every #'(lambda (o) (typep o 'realization-data)) list)
      (mumble-data (car list))))
  (:method ((rdata realization-data)) (mumble-rdata rdata)))

(defgeneric mumble-map-data (unit)
  (:documentation "Does the mumble field of the unit include
     a data type that has a variables to parameters map?")
  (:method ((i individual)) (mumble-map-data (itype-of i)))
  (:method ((s symbol)) (mumble-map-data (category-named s :error-if-null)))
  (:method ((c referential-category)) (mumble-map-data (rdata c)))
  (:method ((no null)) nil)
  (:method ((list cons))
    (when (or (some #'(lambda (o) (typep o 'realization-data)) list)
              (some #'m::mumble-rdata? list))
      (mumble-map-data (car list))))
  (:method ((rdata realization-data)) (mumble-map-data (mumble-rdata rdata)))
  (:method ((clp m::category-linked-phrase))
    (when (m::parameter-variable-map clp) clp))
  (:method ((mrd m::mumble-rdata))
    (when (m::parameter-variable-map mrd) mrd))
  (:method ((msm m::multi-subcat-mdata)) msm))


;;;-----------------------------------------------
;;; Mumble information within rdata -- verb cases
;;;-----------------------------------------------

#| For explicit :mumble components within category realization data
e.g.
 (define-category ...
   :realization
     (...
      :mumble ("push" svo :s agent :o theme) ))

Field is noticed by setup-rdata, which calls apply-mumble-rdata to
the field. At this point the realization field of the category
has a value -- normally a single realization-data field -- though
it will only have been filled in if the rdata includes an etf and
a word. |#

(defgeneric includes-mumble-spec? (rdata)
  (:documentation "In setup-rdata gates whether we call apply-mumble-data")
  (:method ((rdata list))
    (if (keywordp (car rdata))
      (member :mumble rdata)
      (assq :mumble rdata))))

(defun apply-mumble-rdata (category rdata)
  "Called by setup-rdata to provide phrase and argument information
   for verbs. Look up the m-word, create the map, and create
   and store the lp and CLP.
   Called from setup-rdata when the mumble flag is up."
  ;; e.g. (:mumble ("build" svo :s agent :o artifact))
  ;;      (:mumble ("push" svo :s agent :o theme))
  ;;      (:mumble ((svo :s agent :o patient) 
  ;;                (svicomp :s agent :c theme)
  ;;                (svoicomp :s agent :o patient :c theme))
  ;; We get the s-exp just after the :mumble rdata keyword
  (let ((mumble-spec (cadr (if (keywordp (car rdata))
                             (member :mumble rdata)
                             (assq :mumble rdata)))))
    (when mumble-spec
      (assert (consp mumble-spec))
      (if (some #'keywordp mumble-spec) ;; Two-way split. One rspec vs. several
        (decode-one-mumble-spec category mumble-spec)
        (decode-multiple-mumble-specs category mumble-spec)))))

(defun decode-one-mumble-spec (category mumble-spec)
  (multiple-value-bind (clp lp m-word m-pos)
      (decode-mumble-spec category mumble-spec)
    (let ((rdata (rdatum-for-mdata category clp)))
      (setf (get-tag :mumble category) clp)
      (setf (mumble-rdata rdata) `(,clp))
      (when m-word
        (m::record-lexicalized-phrase category lp m-pos)
        (mumble::record-krisp-mapping m-word clp)))))

(defun decode-multiple-mumble-specs (category mumble-specs)
  "There are multiple mumble specifications on this category.
   Decode them all, and then distribute and store them so they
   can be found consistently."
  (let* ((mdata-list (loop for spec in mumble-specs
                        collect (decode-mumble-spec category spec)))
         (pairs (loop for mdata in mdata-list
                   as variables = (m::variables-consumed mdata)
                   collect (make-instance 'm::variable-mdata-pair
                                          :vars variables
                                          :mdata mdata)))
         (pair-mpos (loop for mdata in mdata-list
                       collect (m::lookup-pos mdata))))
    ;; If all same pos, then collect into single multi-mdata.
    ;; Otherwise distribute
    (if (ddm-util::all-the-same pair-mpos)
      (let* ((multi-data (make-instance 'm::multi-subcat-mdata
                                        :mpairs pairs))
             (rdata (rdatum-for-mdata category multi-data)))
        (setf (mumble-rdata rdata) multi-data)
        (setf (get-tag :mumble category) multi-data))
      (distribute-mdata-by-pos category pairs))))

(defun distribute-mdata-by-pos (category pairs)
  "The mdata is usually specific to part of speech. Identify the different
  readings in the realization of the category (verb, noun, adjective, pp)
  and record the approriate mdata on the appropriate rdata object.
  This could entail breaking down the multi-data into its individual CLP."
  (let ((pairs-pos (loop for pair in pairs
                      as m-pos = (m::lookup-pos pair)
                      collect `(,m-pos . pair))))
    (lsp-break "Multiple pos on mdata for ~a~%~a" category pairs-pos)))

(defun rdatum-for-mdata (category mdata)
  "The mumble rdata is for a particular part of speech. 
   Examine the realization-data objects on this category,
   identify which one is for the comparable reading."
  (let* ((m-pos (m::lookup-pos mdata))
         (s-pos (m::sparser-pos m-pos))
         (all-readings (rdata category))
         (rdatum (when all-readings (rdata/pos category s-pos))))
    (unless rdatum
      ;; At abstract levels there won't be any lexical information in the rdata
      (cond
        ((and all-readings (null (cdr all-readings)))
         (setq rdatum (car all-readings)))
        (all-readings
         (error "There is no reading on ~a for POS ~a" (sp::pname category) s-pos))
        (t (error "There is no realization-data object on ~a" (sp::pname category)))))
    rdatum))

;;--- decoder

(defun decode-mumble-spec (category mumble-spec)
  "Decode the symbols, and create the spec object. 
   Caller decides what to do with it.
   Separate cases (+/- whether it includes the verb)
   If there is no pname then either we have a case like relative-location
   where the variables supply all the parts, or we have an abstraction
   like a subcategorization mixin category."
  (let* ((pname (when (stringp (car mumble-spec)) (car mumble-spec)))
         (phrase&args (if pname (cdr mumble-spec) mumble-spec))
         m-word m-pos lp )
    (assert phrase&args)
    ;;//////  If we do these explicit mumble datams for anything other than
    ;; verbs then the syntax has to extend to include the pos
    (when pname
      (setq m-word (m::find-word pname 'm::verb)
            m-pos 'm::verb)
      (unless m-word
        (let ((sparser-word (resolve pname)))
          (assert sparser-word (pname)
                  "There is no word in Sparser for ~a" pname)
          (setq m-word (get-mumble-word-for-sparser-word sparser-word m-pos)))))

    (let* ((phrase-name (car phrase&args))
           (phrase (m::phrase-named (mumble-symbol phrase-name)))
           (p&v-pairs (cdr phrase&args)))                    
      (assert phrase (phrase-name) "There is no Mumble phrase named ~a." phrase-name)

      (let* ((map (loop for (param-name var-name) on p&v-pairs by #'cddr
                     as param = (m::parameter-named (mumble-symbol param-name))
                     as var = (etypecase var-name
                                (string (get-mumble-word-for-sparser-word
                                         (resolve var-name) nil))
                                (symbol
                                 (if (or (eq var-name :self) (eq var-name 'self))
                                   category
                                   (find-variable-for-category var-name category))))
                     do (progn
                          (assert var () "No variable named ~a in category ~a." var-name category)
                          (assert param () "No parameter named ~a in the phrase ~a." param-name phrase))
                     collect (make-instance 'mumble::parameter-variable-pair
                                            :var var
                                            :param param)))
             (variables (loop for pvp in map
                           as var = (m::corresponding-variable pvp)
                           when (typep var 'lambda-variable)
                           collect var))
             (clp (make-instance 'm::mumble-rdata
                    :class category
                    :map map
                    :vars variables)))
        (cond
          (m-word ;; add lexicalized phrase and head to CLP
           (setq lp (m::verb m-word phrase))
           (m::record-lexicalized-phrase category lp m-pos)
           (setf (m::linked-phrase clp) lp)
           (setf (m::head-word clp) m-word))
          (t ;; record just the phrase for use by inheritors
           (setf (m::linked-phrase clp) phrase)))
        
        ;;(lsp-break "decode -- look at clp")
        (values clp lp m-word m-pos)))))


;;;------------------------
;;; inheriting mumble data
;;;------------------------

(defgeneric inherits-mumble-data? (category)
  (:documentation "Abstracts away from the actual type check.
    Returns a category.")
  (:method ((name symbol))
    (inherits-mumble-data? (category-named name :error-if-missing)))
  (:method ((c referential-category))
    "Either we inherit from an explicit subcat pattern category
     such as control-verb, or our immediate supercategory has
     mumble-data recorded on it."
    (or (itypep c 'subcategorization-pattern)
        (let ((super (superc c)))
          (when (mumble-map-data super) super))))
  (:method ((c mixin-category)) nil))

(defun apply-inherited-mumble-data (category)
  "Look up the realization data on the class we inherit from and 
   apply it to this category, which we expect to at least have
   a lexical realization.  We copy the inherited rdata and augment 
   it with whatever local data there is. Modifying the copy as
   needed. Called from setup-rdata when the category being setup 
   satisfies inherits-mumble-data?"
  (let* ((category-inheriting-from (inherits-mumble-data? category))
         (inherited-rdata (get-tag :mumble category-inheriting-from))
         (local-rdata-field (rdata category))
         (local-rdata (when (null (cdr local-rdata-field))
                        (car local-rdata-field))))
    (unless local-rdata
      (warn "first case of multiple local rdata: ~a" category)
      ;;/// synonym for "seem" -- "appear" gets this. Two local rdata, one where
      ;; the head is "seem", the other where it's "appear"
      (if inherited-rdata
        (setq local-rdata (car local-rdata-field)) ;; just do the first one
        (return-from apply-inherited-mumble-data nil))) ;; punt
    
    (when inherited-rdata
      (let ((new-rdata (m::copy-instance inherited-rdata))
            (local-head-data (rdata-head-words local-rdata)))
        (unless local-head-data (error "Why isn't there a head word for ~a" category))
        
        (labels ((change-linked-category (mdata category)
                   (etypecase mdata
                     (m::mumble-rdata (setf (m::linked-category mdata) category))
                     (m::multi-subcat-mdata
                      (loop for pair in (m::mdata-pairs mdata)
                         as embedded-mdata = (m::mpair-mdata pair)
                         do (change-linked-category embedded-mdata category))))))
          (change-linked-category new-rdata category))
          
        (let* ((pos (car local-head-data))
               (mpos (mumble-pos pos))
               (s-word (cadr local-head-data))
               (m-word (get-mumble-word-for-sparser-word s-word mpos)))

          (flet ((lexicalize (phrase m-word)
                   ;; Could be all the cases in make-resource-for-sparser-word
                   ;; in principle, but rather than refactor just putting in the
                   ;; one's being used so far
                   (ecase pos
                     (:verb (m::verb m-word phrase))
                     (:common-noun (m::noun m-word phrase))
                     (:preposition (m::prep m-word))))

                 (replace-map-self-values (clp)
                   (let ((map (m::parameter-variable-map clp)))
                     (assert map)
                     (loop for pvp in map
                        as variable = (m::corresponding-variable pvp)
                        when (category-p variable)
                        do (setf (m::corresponding-variable pvp)
                                 m-word)))))                   

            ;; Modify (on the copy -- new-rdata) the head word and lp.
            ;; Store the new lp on the category. Also revise the maps
            ;; to ensure that self nodes (which show up as categories)
            ;; are replaced with the (mumble) head word.
            (etypecase new-rdata
              (m::mumble-rdata
               (multiple-value-bind (lp)
                   (lexicalize (m::linked-phrase new-rdata) m-word)
                 (setf (m::head-word new-rdata) m-word)
                 (setf (m::linked-phrase new-rdata) lp)
                 (replace-map-self-values new-rdata)
                 (m::record-lexicalized-phrase category lp mpos)))
                
              (m::multi-subcat-mdata
               ;; (push-debug `(,new-rdata)) (lsp-break "1")
               (dolist (pair (m::mdata-pairs new-rdata))
                 ;; pull out the phrase and lexicalize it
                 (let* ((mdata (m::mpair-mdata pair))
                        (phrase (m::linked-phrase mdata)))
                   (assert (typep phrase 'm::phrase)) ;; indicates +abstract
                   (multiple-value-bind (lp)
                       (lexicalize phrase m-word)
                     (setf (m::head-word mdata) m-word)
                     (setf (m::linked-phrase mdata) lp)
                     (replace-map-self-values mdata)
                     (m::record-lexicalized-phrase category lp mpos))))))

            (setf (mumble-rdata local-rdata) new-rdata) ;; belt & suspenders for now
            (setf (get-tag :mumble category) new-rdata)))))))






;;;------------
;;; head words
;;;------------

;;--- rdata-initialization entry point

(defun make-corresponding-lexical-resource (head-field category)
  "Only called from the initialize-instance method of realization-data;
   see make-realization-data.
 The 'head-word' was constructed by
   decode-rdata-heads. The goal is to arrange that every word
   that is mentioned in realization data of a category should 
   have a mumble word created for it. We ensure there's a sparser
   word first, then make its mumble equivalent."
  (declare (special *build-mumble-equivalents*))
  (when *build-mumble-equivalents*
    (let* ((pos-tag (car head-field))
           (word-or-variable (cadr head-field))
           (word (etypecase word-or-variable
                   ((or word polyword) word-or-variable)
                   (list (car word-or-variable))
                   (lambda-variable 
                    ;; Should we be doing words for variables?
                    ;; e.g. head-word = (:word #<variable name>)
                    (let ((lemma
                           (or (get-tag :lemma category)
                               (list :common-noun
                                     (let ((name (cat-name category)))
                                       (make-word :symbol name
                                                  :pname (string-downcase
                                                          (symbol-name name))))))))
                      (assert (= (length lemma) 2) (lemma) "Improper lemma.")
                      (setq pos-tag (car lemma))
                      (cadr lemma))))))
      (when word
        (make-corresponding-mumble-resource word pos-tag category)))))


;;--- general entry point

(defgeneric make-corresponding-mumble-resource (word pos-tag krisp-obj)
  (:documentation "Used when there isn't a mumble expression in the
 category's realization, but the caller has the word and part-of-speech 
 in hand:
    (a) The after method of make-rules-for-head
    (b) Old-style prepositions
    (c) quantifiers, attribute-value, pronouns
    (d) time/anaphors ('now')
    (e) directions
 Calls the standard lexicalized tree constructor and then records
 the result on the Krisp category or individual.
 Calls extend to look for possibility of inheriting more rdata from
 a parent or mixed-in category.")
  (:method :around (word pos-tag krisp-obj)
    (declare (special *build-mumble-equivalents*))
    (when *build-mumble-equivalents*
       (call-next-method)))
  
  (:method (word pos-tag (i individual))
    "Route for attributes"
    (multiple-value-bind (lp m-word m-pos)
        (make-resource-for-sparser-word word pos-tag i)
      (declare (ignore m-word))
      (when lp (m::record-lexicalized-phrase i lp m-pos))))
  
  (:method (word pos-tag (c category))
    "Route for lemmas, preposititions, make-rules-for-head"
    (multiple-value-bind (lp m-word m-pos)
        (make-resource-for-sparser-word word pos-tag c)
      (when lp
        (record/extend-mdata c lp m-pos m-word word pos-tag)))))


(defvar *recording-extended-mdata* nil
  "Flag to block recursion (infinite loop) while paths get debugged")

(defun record/extend-mdata (category lp m-pos m-word s-word s-pos)
  "Additional operations over category for mdata. 
    -- Record the lexicalized phrase
    -- If we're not in the scope of the category's rdata object's
   construction (i.e. the object exists and we can store stuff on
   its mumble field), then look for the possibility of inheriting
   map data from a super category."
  (declare (special *recording-extended-mdata* *during-rdata-initialization*))
  (when *recording-extended-mdata*
    (lsp-break "Potential loop on ~a mdata" category))
  (let ((*recording-extended-mdata* t))
    (declare (special *recording-extended-mdata*))

    ;; record the lp.
    (m::record-lexicalized-phrase category lp m-pos)

    (unless *during-rdata-initialization*
      (when (inherits-mumble-data? category)
        ;; To do this we need local head word data, which we
        ;; expect to get from the rdata object in the category's
        ;; realization. 

        ;; These shouldn't happen. If they do, then there's been
        ;; another path through setup-rdata -> mumble resources
        ;; that has to be accommodated.
        (unless (rdata category)
          (lsp-break "Why no realization on ~a?" category))
        (unless (rdata/pos category s-pos)
          (lsp-break "No head entry for ~a on ~a" s-pos category))

        ;;  Look for the possibiity of inheriting map data.
        (let ((mdata
               (if (inherits-mumble-data? category)
                 (apply-inherited-mumble-data category)
                 ))) ;;//// what would we build to help when there's no map.
          (values category lp mdata))))))


;;;-------------------------------
;;; making the lexicalized-phrase
;;;-------------------------------

(defun make-resource-for-sparser-word (word pos-tag category &optional verb-phrase)
  "Look up the corresponding mumble part of speech ('m-pos').
   Make the mumble word ('m-word'). Then create and record 
   lexicalized phrase to embed the word in the appropriate
   elementary tree (i.e. lexicalize the appropriate phrase).
   Record the lexicalized tree on the mumble word with its mumble-side
   pos. See Mumble/derivation-trees/builders.lisp for the lexicalized
   phrase creators." 
  (when (consp word) ;; irregulars e.g. ("bacterium" :plural "bacteria")
    ;; drop them on the floor for now. /// lookup Mumble rep of irregulars
    (setq word (car word)))
  (let ((m-pos (mumble-pos pos-tag)))
    (when m-pos
      (let* ((m-word (get-mumble-word-for-sparser-word word m-pos))
             (lp (or (m::get-lexicalized-phrase m-word m-pos)
                     (case pos-tag
                       (:adjective (m::adjective m-word))
                       ((:noun :common-noun) (m::noun m-word))
                       (:proper-noun (m::proper-noun m-word))
                       (:verb (m::verb m-word verb-phrase))
                       (:adverb (m::adverb m-word))
                       ((:prep :preposition) (m::prep m-word))
                       (:quantifier (m::quantifier m-word))
                       (:pronoun (m::pronoun m-word))
                       (:interjection (m::interjection m-word))))))
        (when lp
          (m::record-lexicalized-phrase m-word lp m-pos)
          (values lp
                  m-word
                  m-pos))))))

(defun mumble-pos (pos-tag) ;; keep in sync w/ sparser-pos in binding-centric
  "Translate a Sparser part of speech into the Mumble equivalent"
  ;; Other Mumble word labels: {past,present}-participle, {comparative,superlative}-adjective
  ;; abstract-noun, {interrogative,wh,relative}-pronoun, particle, complementizer,
  ;; exclamation, expletive, vocative, punctuation.
  (ecase pos-tag
    ((or :noun :common-noun) 'm::noun)
    (:proper-noun 'm::proper-noun)
    (:verb 'm::verb)
    (:modal 'm::modal)
    ((or :adj :adjective) 'm::adjective)
    ((or :adv :adverb) 'm::adverb)
    ((or :prep :preposition) 'm::preposition)
    (:determiner 'm::determiner)
    (:quantifier 'm::quantifier)
    (:pronoun 'm::pronoun)
    (:interjection 'm::interjection)
    (:number 'm::number)
    (:word nil)))

