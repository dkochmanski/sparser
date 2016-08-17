;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1992-2005,2014-2016 David D. McDonald  -- all rights reserved
;;; extensions copyright (c) 2009 BBNT Solutions LLC. All Rights Reserved
;;;
;;;     File:  "rdata"
;;;   Module:  "objects;model:tree-families:"
;;;  version:  July 2016

;; initiated 8/4/92 v2.3, fleshed out 8/10, added more cases 8/31
;; 0.1 (5/25/93) changed what got stored, keeping around a dereferenced
;;      version of the rdata so that individuals could prompt rule definition
;; 0.2 (10/25) Allowed mappings to multiple categories
;;     (1/17/94) added :adjective as a option for heads. 5/24 added 'time-deictic'
;;     5/26 aded 'adverb'  10/6 added option for a label to be a word
;; 0.3 (10/20) rewrote 'time-deictic' as 'standalone-word'
;; 0.4 (11/1) hacked Setup-rdata to have rules be written even when the head word
;;      specifies a variable rather than a word
;; 1.0 (12/6/97) bumped on general principles given new work on psi.
;;     (7/5/98) modified Decode-rdata-mapping to allow lists of words.
;; 1.1 (7/12) provided for multiple definitions.
;;     (6/24/99) Added standalone rdata assembler to solve timing problems.
;;     (7/3) renamed it '1'.
;; 1.2 (9/3) Adjusted Dereference-rdata to use the symbol :no-head-word
;;      when there isn't one, instead of the value nil. This solved a problem
;;      with the rdata of currency.
;;     (9/30) Tweaked Decode-rdata-mapping to appreciate the possibility that
;;      a parameter could get the value :self.
;;     (11/18) Added :preposition to the list in Vet-rdata-keywords and
;;      dereference-rdata. (7/11/00) added :quantifier.  (4/11/05) added check 
;;      to Decode-rdata-mapping to allow symbols to pass on through if they're
;;      the names of functions. (7/23/09) Added interjection.
;; 1.3 (2/21/11) Added define-marker-category as another standalone def form
;;      where we're defining a minimal category along with its realization.
;; 1.4 (8/11/11) moved in define-realization from the workbench file it
;;      was in (interface/workbench/def-rule/save1.lisp). Refactored setup-
;;      rdata a bit to allow a standalone realization spec to add to the
;;      existing rules rather than replace them: define-additional-realization.
;;      8/16 fixed decode-rdata-mapping to accommodate references to variables
;;      that are in the category's parents. 9/6/11 propogated change to
;;      override-label in decode-rdata-mapping. 12/10/11 added :verb to the
;;      set of rdata keywords. 
;;      (2/11/12) Took :verb out of the keywords because it interferes with
;;      the binding of the parameters in dereference-rdata by blocking the
;;      binding of :main-verb (created a preference for :verb), so no verbs
;;      were getting realizations. (1/5/13) minor in-line doc.
;;     (3/7/13) added :method to go with :function in ever-appears-in-function-referent
;;      that lets us supply functions to the mappings as though they were
;;      conventional binding-parameters. 
;;     (11/18/13) Added some routines to root around inside realization data.
;; 1.5 (12/4/13) Modified deref-rdata-word to look at all slots and not just local ones.
;;     (12/26/13) Tweeked decode-rdata-mapping to notice an explicit category
;;      as the equivalent of :self. (2/1/14) Finished retrieve-word-constructor for
;;      use in abbreviation code.
;;     (5/12/14) Fixed error message in decode-rdata-mapping. 6/11/14 Added call
;;      in record ETF to the categories that use them inside dereference-rdata.
;;     (1/6/15) Modified setup-category-lemma to allow multiple words.
;;     (7/6/15) Commented out apparently no-op complain in decode-rdata-mapping
;;      that it wasn't getting a dotten pair. Need to come back to this and fix it.
;;     (9/22/15) added final value to setup-category-lemma now that it's being
;;      called by itself.
;;     (11/3/15) Tweaked deref-rdata-word to allow for multiple irregular words
;;  1/6/16 Folding in specifications for Mumble.
;;  2/26/15 reworked apply-mumble-rdata to pass all parameters through

(in-package :sparser)


;;;----------------------
;;; standalone def forms
;;;----------------------

(defmacro define-marker-category (category-name &key realization)
  "This amounts to reversible syntactic sugar for the light, 'glue'
   categories that don't add any content (variables) but indicate
   a context for a complement (folded into the realization by name)
   that controls how it's incorporated into larger phrases.
     The category that's created is just the minimal form of
   simple syntactic categories. For something substantive use
   full arguments with define-category."
  `(setup-rdata (find-or-make-category ',category-name) ',realization))

(defmacro define-realization (category-name &body realization &aux
                              (category (gensym))
                              (rdata (gensym)))
  `(let ((,category (category-named ',category-name t))
         (,rdata ',realization))
     (if (shortcut-rdata-p ,rdata)
       (setup-shortcut-rdata ,category ,rdata)
       (setup-rdata ,category ,rdata))))

(defmacro define-additional-realization (category &body rdata)
  `(let ((*deliberate-duplication* t))
    (declare (special *deliberate-duplication*))
    (define-realization ,category ,@rdata)))

(defmacro def-synonym (category (&rest rdata))
  `(define-additional-realization ,category ,@rdata))

;;;-----------------------------------------------------------
;;; entry point from the definition of a referential category
;;;-----------------------------------------------------------

(defvar *build-mumble-equivalents* t
  "Build Mumble realization information from category definitions.")

(defun setup-rdata (category rdata &key (delete t)
                    (mumble *build-mumble-equivalents*))
  "Called from decode-category-parameter-list as part of defining a category.
   This routine is responsible for decoding the realization data, and runs for
   side-effect on the category object.

   The routines in objects;model;tree-families;driver.lisp create the rules
   when individuals of the category are created. The function that actually
   makes the rules is make-rules-for-rdata."
  (let ((old-rules (get-rules category)))
    (etypecase (first rdata)
      (cons (setup-for-multiple-rdata category rdata))
      (keyword (setup-single-rdata category rdata)))

    (let ((new-rules (get-rules category)))
      (setf (get-rules category)
            (cond (delete
                   (mapc #'delete/cfr (set-difference old-rules new-rules))
                   new-rules)
                  (t (when *load-verbose*
                       (warn "Redefining rules for ~a: ~d old rule~:p, ~d new one~:p."
                             (pname category)
                             (length old-rules)
                             (length new-rules)))
                     (union old-rules new-rules))))))
  (when mumble
    (apply-mumble-rdata category rdata)))

(defun setup-single-rdata (category rdata)
  (check-rdata rdata)
  (dereference-and-store?-rdata-schema category rdata t))

(defun setup-for-multiple-rdata (category list-of-rdata)
  (let ( head-word  etf  mapping  rules  local-cases 
         all-schemas  all-rules )
    (dolist (rdata list-of-rdata)
      (check-rdata rdata)
      (multiple-value-setq (head-word etf mapping local-cases rules)
        (dereference-and-store?-rdata-schema category rdata nil)) ;; nil overrides store
      (push `(:schema (,head-word ,etf ,mapping ,local-cases))
            all-schemas)
      (setq all-rules (append rules all-rules)))
    (setf (cat-realization category)
          `(:rules ,all-rules ,@all-schemas))))


(defun dereference-and-store?-rdata-schema (category rdata store?)
  (multiple-value-bind (head-word etf mapping local-cases)
      (apply #'dereference-rdata category rdata)
    (let ((rules (make-rules-for-rdata ;; <<< does the work
                  category head-word etf mapping local-cases)))
      (if store?
        (record-realization-data
           category head-word etf mapping rules local-cases)        
        (values head-word etf mapping local-cases rules)))))


;;;----------------------------
;;; Recording realization data
;;;----------------------------

(defclass realization-data (named-object)
  ((category :initarg :category :accessor rdata-for
    :documentation "Backpointer to the category object.")
   (etf :initform nil :initarg :etf :accessor rdata-etf
    :documentation "Points to the etf if one was used.")
   (mapping :initform nil :initarg :map :accessor rdata-mapping
    :documentation "A completely dereferenced mapping from
      an individual as a instance of a category to the variables 
      used in that case.")
   (locals :initform nil :initarg :locals :accessor rdata-local-rules
    :documentation "The rules that are written out in direct form
      to cover cases not incorporated in the ETF of the realization.")
   (subcats :initform nil :accessor rdata-subcat-frames
    :documentation "List of all the known subcategorization patterns")
   (head-word :initform nil :initarg :head :accessor rdata-head
    :documentation "The word specified in the realization, if any.")
   (irregulars :initform nil :accessor rdata-head-irregulars
    :documentation "Plist of marked irregular forms.")
   (head-pos :initform nil :accessor rdata-head-pos
    :documentation "If there is a head word, this is its part of speech."))
  (:documentation "Compare to realization-scheme class in rules/
 tree-families/families.lisp or realization-node in objects/model/
 lattice-points/structure.lisp. Goal is to replace the haphazard
 distribution of category or individual level realization information
 as lists with a new one that is consistent and can be directly accessed."))

(defmethod print-object ((rr realization-data) stream)
  (print-unreadable-object (rr stream)
    (format stream "rdata for ~a" (cat-name (rdata-for rr)))))

(defun make-realization-data (category &rest args)
  "Make a realization data record and attach it to a category."
  (check-type category category)
  (setf (rdata category) (apply #'make-instance 'realization-data
                                :category category
                                args)))

(defun fom-realization-data (category &rest args)
  "Find or make a realization data record for a category."
  (check-type category category)
  (or (rdata category)
      (apply #'make-realization-data category args)))

(defgeneric rdata (item)
  (:documentation "Retrieve the realization data for a category designator.")
  (:method (item)
    (declare (ignore item)))
  (:method ((name symbol))
    (rdata (category-named name :error-if-nil)))
  (:method ((i individual))
    (rdata (itype-of i)))
  (:method ((c category))
    (get-tag :rdata c)))

(defgeneric (setf rdata) (rr item)
  (:documentation "Save the realization data record for a category designator.")
  (:method (rr (name symbol))
    (setf (rdata (category-named name :error-if-nil)) rr))
  (:method (rr (c category))
    (setf (get-tag :rdata c) rr)))

(defun record-realization-data (category head-word etf mapping rules local-cases)
  "Called by dereference-and-store?-rdata-schema to stash the rdata
   for later use in making rules, e.g. by apply-realization-schema-to-individual
   and its variants in driver.lisp"
  (let ((rr (make-realization-data category
                                   :etf etf
                                   :map mapping
                                   :locals local-cases)))
    (record-rdata-head rr head-word)
    ;; This is what the rule-creators are working from. 
    (setf (cat-realization category)
          `(:schema (,head-word ,etf ,mapping ,local-cases)
            :rules ,rules))
    rr))

(defun record-rdata-head (rr word)
  (etypecase word
    (null)
    ((or word polyword)
     (setf (rdata-head rr) word))
    (cons
     ;; (:adjective #<variable name>)
     (cond
       ((and (keywordp (car word)) (lambda-variable-p (cadr word)))
        (setf (rdata-head rr) (cadr word))
        (setf (rdata-head-pos rr) (car word)))
       ((and (keywordp (car word))
             (or (word-p (cadr word))
                 (polyword-p (cadr word))))
        (setf (rdata-head rr) (cadr word))
        (setf (rdata-head-pos rr) (car word)))
       ((and (keywordp (car word))
             (word-p (caadr word))
             (some #'keywordp (cdadr word)))
        (setf (rdata-head rr) (caadr word))
        (setf (rdata-head-pos rr) (car word))
        (setf (rdata-head-irregulars rr) (cdadr word)))
       ((and (listp word)
             (every #'(lambda (w) (or (word-p w) (polyword-p w))) word))
        (setf (rdata-head rr) (cadr word)))
       (t (error "Invalid head-word specification ~a." word))))))

(defgeneric add-subcats-to-rdata (category)
  (:documentation "Once its probably the case that all the subcat data 
    for a given realization has been accumulated, copy it over to the
    realization-data-record of the category, refactoring as needed.")
  (:method ((c category))
    (let ((rr (fom-realization-data c))
          (sf (get-subcategorization c)))
      (setf (rdata-subcat-frames rr) sf))))

(defgeneric rdata-head-word (item)
  (:method (item)
    (declare (ignore item)))
  (:method ((c category))
    (let ((head (rdata-head (rdata c))))
      (typecase head
        ((or word polyword) head))))
  (:method ((i individual))
    (let* ((rdata (rdata i))
           (head (and rdata (rdata-head rdata))))
      (etypecase head
        (null)
        ((or word polyword) head)
        (lambda-variable
         (let ((head-var (find head (indiv-binds i) :key #'binding-variable)))
           (and head-var (binding-value head-var))))))))

#| Notes for organizing the change-over

The etf, mapping, and word info tend to be used as a group,
and effectively control the entire process of creating the
semantic rules.  

The rules seem to just be accessed and handled as a group
They can be moved over to the plist routines that are used now
in all new code or easily revised code. Change these first.

--- Existing calls on the realization field of the category
    (where we stash instances of the class once we've changed over
avidsmcbookpro:s ddm$ grep "(cat-realization " **/*.lisp **/**/*.lisp **/**/**/*.lisp **/**/**/**/*.lisp **/**/**/**/**/*.lisp
interface/mumble/rnode-centric.lisp:  (let* ((realization-field (cat-realization c))
interface/mumble/rspec-gophers.lisp:  (let ((realization-field (cat-realization c)))
grammar/rules/CA/extract-subj.lisp:             (schema (cadr (member :schema (cat-realization type)))))
grammar/rules/CA/stranded-vp.lisp:         (rules (cadr (member :rules (cat-realization type)))))
grammar/rules/tree-families/shortcuts.lisp:          ;	(setf (cat-realization category)
grammar/rules/tree-families/shortcuts.lisp:          ;	      `(:synonyms ,words . ,(cat-realization category)))
objects/model/categories/define.lisp:  (cadr (member :rules (cat-realization category))))
objects/model/tree-families/driver.lisp:  (if (cat-realization category)
objects/model/tree-families/driver.lisp:  (let* ((rdata (cat-realization category))
objects/model/tree-families/driver.lisp:  (let ((realization-data (cat-realization category))
objects/model/tree-families/rdata.lisp:         (when (cat-realization category)
objects/model/tree-families/rdata.lisp:           (cadr (member :rules (cat-realization category))))))
objects/model/tree-families/rdata.lisp:           (cadr (member :rules (cat-realization category)))))
objects/model/tree-families/rdata.lisp:            (let ((cons-cell (member :rules (cat-realization category))))
objects/model/tree-families/rdata.lisp:    (setf (cat-realization category)
objects/model/tree-families/rdata.lisp:    (setf (cat-realization category)
objects/model/tree-families/rdata.lisp:  (let ((rdata  (cat-realization category)))
objects/model/tree-families/rdata.lisp:  (let ((rdata  (cat-realization category)))
objects/model/tree-families/rdata.lisp:  (when (cat-realization category)
objects/model/tree-families/rdata.lisp:    (let ((realization-data (cat-realization category))
grammar/model/core/kinds/object.lisp:	       (caadr (memq :rules (cat-realization category)))))))
grammar/model/core/places/regions.lisp:             (caadr (memq :rules (cat-realization category)))


|#


;;;-------------
;;; Data checks
;;;-------------

;;--- Check for legal keywords in realization field of a category

(deftype rdata-word-keyword ()
  '(member :verb :common-noun :proper-noun
           :quantifier :adjective :interjection
           :adverb :preposition :word))

(deftype rdata-keyword ()
  '(or rdata-word-keyword
       (member :tree-family :mapping :additional-rules :mumble)))

(defun check-rdata (rdata)
  (loop for (keyword value) on rdata by #'cddr
        do (check-type keyword rdata-keyword "a valid realization keyword")))


;;--- methods for other routines (like NLG) that need to examine schema

(defmethod retrieve-schema-forms ((category referential-category))
  (let ((rdata  (cat-realization category)))
    (when rdata
      (retrieve-schema-forms rdata))))

(defmethod retrieve-schema-forms ((realization-data cons))
  (loop for form in realization-data
    when (and (consp form) (eq (car form) :schema))
    collect (cadr form)))

(defmethod identify-schema-with-variable ((schema-forms cons) &optional break?)
  ;; (:schema ((:proper-noun . #<variable nname>) nil nil nil))
  (let ((value
         (loop for form in schema-forms
           as head-field = (first (second form))
           as value = (cdr head-field)
           when (lambda-variable-p value) return form)))
    (or value
        (when break?
          (error "No realization schema based on a variable. Check definitions")))))
#| For build in the blocks-world this is the list of schema-forms
  1.  (no-head-word #<etf VP+ADJUNCT> ((vg . #<ref-category BUILD>) (vp . #<ref-category BUILD>) (adjunct . #<ref-category PHYSICAL>) (slot . #<variable artifact>)) nil)
  2.  (no-head-word nil nil nil)
  3.  ((verb #<word "build"> past-tense #<word "built">) nil nil nil)
|#
(defmethod identify-schema-with-word ((schema-forms cons) &optional break?)
  ;; (:schema (((:common-noun . #<word "waypoint">) nil nil nil))
  (let ((value
         (loop for form in schema-forms
           when (and (consp (car form))
                     (word-p (cadr (car form))))
           ;; e.g. ((:verb #<word "build"> :past-tense #<word "built">) nil nil nil)
           return form)))
    (or value
        (when break?
          (error "No realization schema based on a variable. Check definitions")))))

;;--- The word case just by itself

(defgeneric lemma (item pos)
  (:method ((c category) pos)
    (getf (get-tag :lemma c) pos))
  (:method ((i individual) pos)
    (lemma (itype-of i) pos)))

(defgeneric (setf lemma) (word item pos)
  (:method (word (c category) pos)
    (setf (getf (get-tag :lemma c) pos) word)))

(defun setup-category-lemma (category lemmata)
  "Used when the name of a category is the same as some word,
e.g. 'comparative', and the realization field is used to provide
the rspec for the words of instances of the category."
  ;;/// look at apply-realization-schema-to-individual for part of
  ;; the old approach to this problem
  (loop for (keyword string) on lemmata by #'cddr
        do (unless (keywordp keyword) ;; friendly DWIM
             (setq keyword (intern (string keyword) :keyword)))
           (check-type keyword rdata-word-keyword "a valid realization keyword")
           (check-type string (or string cons))
           (let* ((head-word (deref-rdata-word string category))
                  (rules (make-head-word-rules keyword head-word category category)))
             (setf (lemma category keyword) head-word)
             (add-rules rules category))))


;;;------------------------------------------------
;;; the real driver: symbols -> objects by keyword
;;;------------------------------------------------

(defun dereference-rdata (category
                          &key ((:tree-family tf-name))
                               mapping
                               ((:verb verb-name))
                               ((:common-noun cn-name))
                               ((:proper-noun pn-name))
                               adjective
                               quantifier
                               interjection
                               adverb
                               preposition
                               word
                               additional-rules
                               mumble)
  "Convert symbols to objects for realization data. Returns the arguments
   to feed into make-rules-for-rdata."
  (declare (ignore mumble))
  ;; The primary mumble information is handled in setup-rdata, 
  ;; but here we need to handle word-level correspondences. 
  (let ((head-word
         ;; Since we're not going to instantiate the rules for these
         ;; right here, and since the next layer isn't keyword driven,
         ;; we have to encode the part-of-speech information here.
         (cond (verb-name
                (list :verb (deref-rdata-word verb-name category)))
               (cn-name
                (list :common-noun (deref-rdata-word cn-name category)))
               (adjective
                (list :adjective (deref-rdata-word adjective category)))
               (quantifier
                (list :quantifier (deref-rdata-word quantifier category)))
               (adverb
                (list :adverb (deref-rdata-word adverb category)))
               (interjection
                (list :interjection (deref-rdata-word interjection category)))
               (preposition
                (list :preposition (deref-rdata-word preposition category)))
               (word
                (list :word (deref-rdata-word word category)))
               (pn-name
                (list :proper-noun (deref-rdata-word pn-name category)))))
        (tf (and tf-name (exploded-tree-family-named tf-name))))

    (when head-word
      (make-corresponding-lexical-resource head-word category))

    (when tf
      (record-use-of-tf-by tf category))

    (values head-word
            tf
            (and tf (decode-rdata-mapping mapping category tf))
            (decode-additional-rules additional-rules))))

(defun deref-rdata-word (word category)
  "Recursively replace symbols with variables and strings with words."
  (etypecase word
    ((or word polyword keyword) word)
    (string (resolve-string-to-word/make word))
    (symbol (or (find-variable-for-category word category)
                (error "The symbol ~a does not correspond to a variable of ~a."
                       word category)))
    (cons (mapcar (lambda (word) (deref-rdata-word word category)) word))))

(defun decode-additional-rules (cases)
  "Additional rules don't use mappings. They use the names of categories, words,
   or variables directly. Given the way the rest of the modularity has worked out,
   all we have to do is look for strings and replace them since everything else
   will have been handled by replace-from-mapping even though it's really superfluous."
  (loop for (relation (lhs rhs . referent)) in cases
        collect `(,relation
                  (,lhs ,(loop for term in rhs
                               collect (if (stringp term)
                                         (resolve-string-to-word/make term)
                                         term))
                   ,@referent))))

(defun decode-rdata-mapping (mapping category tf)
  "Semantic parameters are decoded as variables.
   Syntactic labels are decoded as categories."
  (declare (optimize debug))
  (loop with parameters = (etf-parameters tf)
        with labels = (etf-labels tf)
        for (term . value) in mapping
        when (typep value '(cons * null))
          do (setq value (car value)) ; quietly fix a missing dot
        if (memq term parameters)
          collect (cons term
                        (or (and (eq value :self) category)
                            (find-variable-for-category value category)
                            (and (ever-appears-in-function-referent term tf)
                                 (coerce value 'function))
                            (error "No variable ~a in ~a for the parameter ~a."
                                   value category term)))
        else if (memq term labels)
          collect (cons term
                        (typecase value
                          ((eql :self) (or (override-label category) category))
                          (string (resolve-string-to-word/make value))
                          (list (loop for v in value
                                      collect (if (stringp v)
                                                (resolve-string-to-word/make v)
                                                (find-or-make-category-object v))))
                          (t (find-or-make-category-object value))))
        else
          do (error "Undefined term ~a in rdata mapping for ~a with ~a."
                    term category tf)))

(defun ever-appears-in-function-referent (term tf)
  "Check if a mapping term is a function or method for the given tree family.
   The alternative to this rather deep check is to add another field to etfs
   to hold this case of a simple symbol (the name of a function) that forestalls
   its interpretation as either a category or a variable."
  (loop for schr in (etf-cases tf)
        thereis (memq term (nth-value 1 ; property value
                            (get-properties (schr-referent schr)
                                            '(:function :method))))))
