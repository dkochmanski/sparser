;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER LISP) -*-
;;; copyright (c) 1992-2005,2011-2015 David D. McDonald  -- all rights reserved
;;; extensions copyright (c) 2007-2009 BBNT Solutions LLC. All Rights Reserved
;;;
;;;     File:  "driver"
;;;   Module:  "objects;model:tree-families:"
;;;  version:  2.3 March 2015

;; initiated 8/4/92, fleshed out 8/27, elaborated 8/31
;; fixed a bug in how lists of rules were accumulated 11/2
;; 0.1 (6/1/93 v2.3) Added possibility for a schema to use form rules
;;      in its mapping data
;;     (7/19) fixed glitch in treatment of category's plist
;; 0.2 (8/4) added relation to cfrs when they're instantiated
;; 0.3 (10/25) allowed multiple categories to be mapped to terms
;;     (1/17/94) added :adjective case as c&s of :word
;; 0.4 (3/21) added check that head-words are defined
;; 0.5 (4/29) improved the treatment of the :instantiate-individual referent instr.
;; 0.6 (5/24) added case of time-deictics. 5/26 added adverbs
;;     (10/17) propagated a change in arguments
;; 0.7 (10/20) rewrote the multiple-term rhs iterators
;; 0.8 (11/1) hacked Make-rules-for-rdata to check for the head word specifying
;;      a lambda variable rather than a word.
;; 0.9 (2/28/95) made changes to return value of inner loop of rule of schema 
;;      instantiation to make it a flat list of cfrs. Higher loop may need to
;;      check as well.
;;     (3/7) put in the higher loop
;; 0.10 (5/15) added eft-case-rule-form to be clever about the passive
;; 0.11 (7/28) tweeked the referent construction routines to accomodate single categories
;; 0.12 (12/6) fixed a policy bug in Construct-referent such that it had preferred 'head'
;;       to instantiate-individual stmts, which was wrong.
;; 1.0 (2/15/98) Redit Instantiate-rule-schema in terms of structures for the
;;      schematic cases. 2/16 added schema to each cfr made. 2/19 included
;;      residual case for 'additional-rules'. *schema-being-instantiated* added
;;      as a global 2/24. 3/7 fixed c&s bug in Construct-referent.
;; 1.1 (7/20) Reorganized the threading to match the reorg of the callers in
;;      rdata1 so that the rules are passed back up rather than being cached
;;      on the category within here. (7/23) re-org'd the multiply-through-rhs because
;;      it was overly complicated. Moved out the checking of old-rules to the
;;      caller in rdata1 because it the timing made it inflict colateral damage.
;; 1.2 (8/14/99) Tweaked Construct-referent and Massage-referent-schema to handle
;;      the case of :function referent schemas better. N.b. there's now a provision
;;      for zero or one argument to the function. This should be generalized.
;; 1.3 (9/3) Modified Apply-realization-schema-to-individual to accomodate a
;;      :no-head-word value for that field in rdata-schema.
;;     (3/31/05) touched it while debugging. (4/11) incorporated case of secondary
;;      function calls into Construct-referent - needed for general treatment of
;;      'fiscal' and the adjective-creates-subtype etf.
;; 1.4 (7/2/07) Added a define-rewriting-form-rule to go with every regular cfr
;;      that's instantiated when that makes sense. Guarded by *new-dm&p*.
;;     (8/7) replaced the guard with the more specific *infer-rewriting-form-rules*.
;; 1.5 (4/20/09) Reworked Construct-referent to look for mappings of subtype
;;     labels. Motivated by "get out of the car" and transitive/specializing-pp.
;; 1.6 (6/17/09) Lets the form derive from the schema as well as heuristically
;; 2.0 (7/24/09) Now that variables are lexicalized we have to pass the category
;;      down to the interpretation of the mapping to ensure that the correct,
;;      category-specific variables are used -- see decode-binding
;;     (10/8/09) Fixed bug in decode-binding. (4/6/11) cleaned up indents.
;; 2.1 (4/8/11) Put in switch to control formation of form rules when the
;;      rhs involves a form category. 9/9 put :method in, fixed but in 
;;      construct-referent for function case. 9/23 put method further in. 10/3 fixed
;;      bug in it (C&S).
;; 2.2 (4/3/13) Installed check for Chomsky adjunction in the inner loop.
;;     (6/13/13) Fixed case of :self as a variable in decode-binding. Flagged it
;;      as illegal. (8/12/14) added retrieve-single-rule-from-individual
;;     (9/9/14) retrieve-single-rule-from-individual got a case where there were
;;      two rules (independent bug?) so changed it's error to a cerror.
;;     1/5/2015 MAJOR CHANGE. Added new field rhs-forms to cfrs, and fill it 
;;       from the ETF schema. Used to check syntactic plausibility of rule applications
;; 2.3 (3/16/15) Broke i/r/s/-coordinate-chomsky-adjunction into the original case
;;      when the lhs is multiple (which doesn't handles multiple rhs elements!)
;;      and a simpler one-lhs case that calls the existing multiple-rhs function. 
;; 4/20/2015 create a list (*dont-check-forms-for-etf*) of etf names for which syntactic form-checking is turnes off
;;  Control check-rule-form -- it can be turned off for particular ETFs by calling
;;  dont-check-rule-form-for-etf-named with the name of the family


(in-package :sparser)

(defparameter *dont-check-forms-for-etf*
  '(ITEM+IDIOMATIC-HEAD)
  "If the head is idiomaticmatic, like '%' or 'percent'
   or 'old' as in '5 years old', you can't predict the
   form category of the head, so just trust the rule writer.")

(defun dont-check-rule-form-for-etf-named (etf-name)
  "Trust that the given ETF is not applied in inappropriate syntactic contexts,
   so don't apply compatible-form check in multiply-edges."
  (pushnew etf-name *dont-check-forms-for-etf*))


;;;-------------------------------------
;;; instantiating rdata for individuals
;;;-------------------------------------

(defun apply-single-category-rdata (individual category)
  ;; Called from define-individual
  (let ((realization-data (cat-realization category))
        rdata-schema  )
    (when realization-data 
      (when (eq (car realization-data) :rules)
        (setq realization-data (cdr realization-data)))
      (etypecase (first realization-data)
        (cons  ;; Multiple schemas
         (dolist (item realization-data)
           (when (and (consp item) (eq (first item) :schema))
             (setq rdata-schema (cadr item))
             (apply-realization-schema-to-individual
              individual category rdata-schema))))
        (keyword
         (case (first realization-data)
           (:rules)
           (:synonyms)
           (:schema
            (setq rdata-schema (second realization-data))
            (apply-realization-schema-to-individual
             individual category rdata-schema))
           (otherwise
            (push-debug `(,category ,individual ,realization-data))
            (error "New keyword at car of realization data for ~a"
                   category))))))))

(defun apply-distributed-realization-data (individual)
  ;; Called from define-individual when the *c3* flag is up.
  ;; Has to consider that category of the variable that binding a
  ;; particular value (only worrying about words for now) when
  ;; looking up the rschema that applies to it.
  (push-debug `(,individual))
  (dolist (b (indiv-binds individual))
    (let ((value (binding-value b)))
      (when (or (word-p value)
                (polyword-p value))
        (let* ((v (binding-variable b))
               (category (var-category v)))
          (apply-single-category-rdata individual category)
          ;; That category will be something like has-name, 
          ;; not the category of the individual, so some surgury
          ;; is needed.
          (let ((rs (rule-set-for value)))
            (unless rs 
              (push-debug `(,value)) 
              (error "Expected a rule-set on ~a" value))
            (let ((rule (car (rs-single-term-rewrites rs))))
              (unless rule
                (push-debug `(,rs ,value ,individual))
                (error "Expected a rule in the rule set of ~a" value))
              ;; I -think- this doesn't affect the indexing
              (setf (cfr-category rule) (itype-of individual))
              (push-debug `(,rule))
              (return-from apply-distributed-realization-data value))))))))


(defun apply-realization-schema-to-individual (individual
                                               category
                                               rdata-schema)
  
  ;; The rdata-schema is the value of the :schema key in the realization
  ;; field of the category.  We're applying a realization schema that was
  ;; defined for a category that defined its head-word as the value of one
  ;; of the variables that will be bound as the way to individuate
  ;; individuals. We take the word that has been bound to that
  ;; individuating variable, make it the head word, and instantiated the
  ;; rules that the schema defines.
  
  (let ((head-field (first rdata-schema))
        (etf         (second rdata-schema))
        (mapping     (third rdata-schema))
        (local-cases (fourth rdata-schema)))

    (flet ((head-schema-filled-with-words (field)
             ;; We have cases like "person" where we want to instantiate
             ;; new people but where the realization is used to provide
             ;; a word that names (refers to) the category.
             (some #'word-p field)))
    
      (let* ((no-head (eq head-field :no-head-word))
             (head-word-variable (unless no-head (cadr (first rdata-schema))))
             (head-word-type     (unless no-head (car (first rdata-schema))))
             (head-word (when head-word-variable
                          (value-of head-word-variable individual)))
             (head (unless no-head
                     (list head-word-type head-word))))

        (when (word-p head-word-variable)
          ;; another configuration that the head filled with words
          ;; is looking for. See waypoint  The schema arrangement
          ;; is flimsy right now.
          (setq head-word head-word-variable
                head (list head-word-type head-word)))

        (unless no-head
          (unless head-word
            (unless (head-schema-filled-with-words head-field)
              (break "Expected the individual ~A~
                    ~%to have a value for its ~A variable.~
                   ~%but it does not." individual head-word-variable))))
        (make-rules-for-rdata category
                              head
                              etf mapping local-cases
                              individual)))))


;;;-----------------
;;; the real driver
;;;-----------------

(defun make-rules-for-rdata (category head etf mapping local-cases
                             &optional individual)
  (let ((referent (or individual category))
        rules)
   (flet ((collect-rules (more-rules) (setq rules (append more-rules rules))))
     (collect-rules (make-head-word-rules t head category referent))
     (when etf
       (dolist (rule-schema (etf-cases etf))
         (collect-rules (instantiate-rule-schema rule-schema mapping category))))
     (when local-cases
       (dolist (rule-schema local-cases)
         (collect-rules (instantiate-rule-schema rule-schema mapping category
                                                 :local-cases? category)))))
   (add-rules rules referent)))


;;;---------------------------
;;; instantiating the schemas
;;;---------------------------

(defvar *cfrs* nil
  "Accumulates cfr objects as they are created by the various iterators below.
   Used to keep the iteration code clear.")

(defvar *schema-being-instantiated* nil
  "Bound in instantiate-rule-schema to fill the 'schema' field of the cfrs
   that are created.")

(defvar *Chomsky-adjunction-applies* nil
  "Bound by instantiate-rule-schema when it encounters a schema where
   the lhs category is included amoung the categories of the rhs.
   This case requires special handling when the rhs has a term with
   multiple categories.")

(defun instantiate-rule-schema (schema
                                mapping 
                                category
                                &key ((:local-cases? category-of-locals)))
  "Decodes the schema and sets up cross-the-board things such as the rule's
   form and referent. Decodes implicit multi-rules. Returns the list of
   cfr that are created. Real work done by i/r/s-make-the-rule."
  (let* ((additional-rule (consp schema))
         (relation (if additional-rule
                     (first schema)
                     (schr-relation schema)))
         (schematic-lhs (if additional-rule
                          (first (second schema))
                          (schr-lhs schema)))
         (schematic-rhs (if additional-rule
                          (second (second schema))
                          (schr-rhs schema)))
         (schematic-referent (if additional-rule
                               (cddr (second schema))
                               (schr-referent schema)))
         (schematic-form (unless additional-rule
                           (schr-form schema)))
         (lhs (replace-from-mapping schematic-lhs mapping category))
         (rhs (mapcar (lambda (label)
                        (replace-from-mapping label mapping category))
                      schematic-rhs))
         (form (or schematic-form (eft-case-rule-form schematic-lhs mapping)))
         (referent-schema (massage-referent-schema schematic-referent mapping))
         (referent (apply #'construct-referent mapping category category-of-locals
                          referent-schema))

         (*schema-being-instantiated* schema)
         (*Chomsky-adjunction-applies* (memq schematic-lhs schematic-rhs))
         (*cfrs* nil))
    ;; The iterators below push the rules that they make onto the
    ;; *cfrs* global to save us from the hassle of threading them back
    ;; through their return paths.

    (cond
     ;; Check whether one of the terms is a list, in which case
     ;; we multiply through the categories in the list across the
     ;; rest of the rule's components, making several rules rather
     ;; than just one.
     ((listp lhs)
      (if *Chomsky-adjunction-applies*
        (i/r/s/-coordinate-chomsky-adjunction lhs rhs form referent relation)
        (i/r/s-multiply-through/lhs lhs rhs form referent relation)))
     ((some #'listp rhs)
      (if *Chomsky-adjunction-applies*
        (i/r/s/-coordinate-chomsky-adjunction lhs rhs form referent relation)
        (i/r/s-multiply-through/rhs lhs rhs form referent relation)))
     (t (i/r/s-make-the-rule lhs rhs form referent relation)))

    (unless additional-rule
      ;; Pass the realization schema through to each rule.
      (dolist (cfr *cfrs*)
        (setf (cfr-schema cfr) schema)
        (unless (memq (etf-name (schr-tree-family schema))
                      *dont-check-forms-for-etf*)
          (setf (cfr-rhs-forms cfr) schematic-rhs))))

    *cfrs*))


(defun i/r/s/-coordinate-chomsky-adjunction (lhs rhs form referent relation)
  "The pattern of the schema is: foo -> bar foo, with the term for the lhs
   also appearing on the rhs. When that term is mapped to a list of
   categories, then we have to coordinate them so that we get coherent
   rules. Note that the lhs will also have a list value since it was
   the same term as the one on the right."
  (push-debug `(,lhs ,rhs ,form ,referent ,relation)) 
  ;; (setq lhs (car *) rhs (cadr *) form (caddr *) referent (cadddr *) relation (fifth *))
  (typecase lhs
    (category 
     (i/r/s-multiply-through/rhs lhs rhs form referent relation))
    ((or word polyword)
     (i/r/s-multiply-through/rhs lhs rhs form referent relation))
    (cons
     (if (cdr lhs) ;; more than one
       (coordinate-chomsky-adjunction-multiple-lhs
        lhs rhs form referent relation)
       (else
        ;; The elaborate coordination isn't necessary, so this
        ;; probably degrades to a case we already have
        (i/r/s-multiply-through/rhs (car lhs) rhs form referent relation))))
    (otherwise
     (error "Unanticipated type for lhs in rule: ~a~%~a"
            (type-of lhs) lhs))))


(defun coordinate-chomsky-adjunction-multiple-lhs (lhs rhs form referent relation)
  (flet ((find-list-term (flat-list)
           (loop for term in flat-list
             when (listp term) return term))
         (value-is-first-or-second (value list)
           (when (> (length list) 2)
             (error "Test only applies to length 2 lists, not ~a" list))
           (if (equal (car list) value) :first :second)))             
    (let* ((list-term (find-list-term rhs))
           (position (value-is-first-or-second list-term rhs))
           (other-term (if (eq position :first)
                         (cadr rhs)
                         (car rhs))))
      (dolist (term lhs)
        (let ((corresponding-rhs
               (if (eq position :first)
                 `(,term ,other-term)
                 `(,other-term ,term))))
          (i/r/s-make-the-rule
           term corresponding-rhs form referent relation))))))

(defun i/r/s-make-the-rule (lhs rhs form referent relation)
  ;; Used when there are no multiple terms in either the left
  ;; or righthand sides, or as the base case when there are.
  (declare (special *convert-eft-form-categories-to-form-rules*
                    *infer-rewriting-form-rules*))
  (let ((cfr
         (if (and *convert-eft-form-categories-to-form-rules*
                  (some #'(lambda (c)
                            (when (referential-category-p c)
                              (get-tag :form-category c)))
                        rhs))
           (def-form-rule/resolved rhs form nil referent)
           (define-cfr lhs rhs :form form :referent referent))))

    (when cfr
      (setf (get-tag :relation cfr) relation)
      (push cfr *cfrs*))

    (when *infer-rewriting-form-rules*
      ;; see if we can make an additional form rule by interpolating
      ;; from the naming conventions in the EFT
      (let ((form-cfr (define-rewriting-form-rule rhs form referent)))
	(when form-cfr
	  (push form-cfr *cfrs*))))))

(defun i/r/s-multiply-through/lhs (lhs rhs form referent relation)
  ;; the lhs is a list of categories rather than one. Multiply it
  ;; through using the routine that will also check whether the rhs
  ;; has lists of categories
  (dolist (category lhs)
    (i/r/s-multiply-through/rhs
     category rhs form referent relation)))

(defun i/r/s-multiply-through/rhs (lhs rhs form referent relation)
  (unless (= (length rhs) 2)
    (error "This routine only handles binary rules"))

  (let ((left (first rhs))
        (right (second rhs)))
    (cond
     ((consp left)
      (dolist (left-label left)
        (if (consp right)
          (dolist (right-label right)
            (i/r/s-make-the-rule lhs (list left-label right-label)
                                 form referent relation))
          (i/r/s-make-the-rule
           lhs (list left-label right) form referent relation))))
     ((consp right)
      (dolist (right-label right)
        (i/r/s-make-the-rule
         lhs (list left right-label) form referent relation)))
     (t
      (i/r/s-make-the-rule 
       lhs (list left right) form referent relation)))))


;;;----------------------------
;;; determining the form label
;;;----------------------------

(defun eft-case-rule-form (lhs-symbol mapping)
  ;; Called from instantiate-rule-schema. 
  (multiple-value-bind (category-name specialization)
                       (strip-specializing-slash lhs-symbol mapping)
    (if specialization
      (then
        (if (equal specialization "+ED")
          (cond ((eq category-name 'vg)
                 (category-named 'vg+passive))
                ((eq category-name 'vp)
                 (category-named 'vp+passive))
                (t (break "Assumption violation:  Only expected 'vg' or 'vp'~
                         ~%to be specialized with '+ed', but the label name~
                         ~%in this case is ~A" category-name)))
          (category-named category-name)))

      (category-named category-name))))


(defun interpolate-form-category-in-rhs-of-schema (rhs head-side schema)
  ;; We're making a rewriting form rule, so we're looking for a form category
  ;; that's implicit in the naming conventions of the labels in an ETF,
  ;; e.g. np/subject.
  ;;   If we find one (invariably 'np'), we return a new rhs using it instead
  ;; of the original 
  (let* ((schematic-rhs (schr-rhs schema))
	 (label-of-bound ;; the label of the consitituent that's folded into the head
	  (case head-side
	    (left-referent (second schematic-rhs))
	    (right-referent (first schematic-rhs))
	    (otherwise
	     (error "Bad threading - unreasonable value for an edge reference ~
                      within a referent: ~a" head-side)))))

    (when (symbolp label-of-bound) 
      ;; it's occasionally a word, e.g. (#<word "per"> unit-of-measure),
      ;; in which case we're not creating a new rhs so we return nil
      ;; to keep the caller (define-rewriting-form-rule) from making
      ;; a rule
      (let ((np? (search "NP/" (symbol-name label-of-bound) :test #'string-equal)))
	(when np?
	  ;; Just look for np options for now
	  (case head-side
	    (left-referent `(,(first rhs) ,(category-named 'np)))
	    (right-referent `(,(category-named 'np) ,(second rhs)))))))))







;;;------------------------------------
;;; hacking the referents to the cases
;;;------------------------------------

(defun massage-referent-schema (schema mapping)
  ;; Called from instantiate-rule-schema.
  ;; The number and pattern of arguments can be hard to fit
  ;; through the procrustian bed of "apply" in the call to actually
  ;; construct the referent, so we look for the odd cases that
  ;; won't fit the presumptions about numbers of arguments and
  ;; repackage them
  ;;    The argument is a list. The return value is another list.
  (if (= (length schema) 1)
    ;; Then it means the specification is a category by itself
    ;; but we have to package it in a list with a keyword marker
    ;; so that the call to Construct-referent will be happy.
    `(:single-return-value ,@schema)

    ;; it's the usual multiple keyword case
    (do ((keyword (first schema)
                  (first rest-of-schema))
         (argument (second schema)
                   (second rest-of-schema))
         (rest-of-schema (cddr schema)
                         (cddr rest-of-schema))
         accumulating-list )
        ((null keyword)
         (nreverse accumulating-list))
      
      (when (or (eq keyword :function)
                (eq keyword :method))
        (let ( mapped-expression  substitution )
          (dolist (item argument)
            (setq substitution (cdr (assoc item mapping :test #'eq)))
            (if substitution
              (push substitution mapped-expression)
              (push item mapped-expression)))
          (setq argument (nreverse mapped-expression))))

      (push keyword accumulating-list)
      (push argument accumulating-list))))




(defun construct-referent (mapping
                           category
                           category-of-locals
                           &key head
                                ((:instantiate-individual indiv))
                                subtype
                                binds
                                function
                                method
                                daughter
                                single-return-value
                           &aux referent-form
                                other-forms
                                new-type )

  ;; Called from instantiate-rule-schema to create the rule's referent
  ;; from the massaged schema.

  ;; 1st, establish what will be returned as the referent
  (setq referent-form
        (cond
         (single-return-value
          (let ((value (assoc single-return-value mapping :test #'eq)))
            (cdr value)))
         (indiv    ;; an 'instantiate-individual' instruction
          (setq new-type
                (if (assoc indiv mapping :test #'eq)
                  (cdr (assoc indiv mapping :test #'eq))
                  indiv))
          `(:instantiate-individual ,new-type))
         (head
          (let ((canonical-name
                 (canonical-ref-var head)))
            (unless canonical-name
              (break "Unexpected edge symbol used with head ~
                      argument: ~A" head))
            `(:head ,canonical-name)))
         (daughter
          (let ((canonical-name
                 (canonical-ref-var daughter)))
            (unless canonical-name
              (break "Unexpected edge symbol used with daughter ~
                      argument: ~A" daughter))
            `(:daughter ,canonical-name)))
         (function
          (let ((form
                 (if (cdr function)
                   `(:funcall ,(first function) ,(second function))
                   `(:funcall ,(first function)))))
            (setq function nil) ;; defang later check
            form))
         (t (break "No known referent form in rdata"))))

  (when subtype
    (let ((mapped (cdr (assoc subtype mapping :test #'eq))))
      (when mapped 
	(unless (category-p mapped)
	  (setq mapped (find-or-make-category mapped :mixin))))
      (push `(:subtype ,(or mapped subtype))
	    other-forms)))

  (when function 
    ;; passes through dispatch-on-rule-field-keys and ultimately
    ;; handled by ref/function
    (push `(:funcall  ,@function)
          other-forms))
  (when method
    (push `(:method ,@method)
          other-forms))

  (when binds
    (multiple-value-bind (decoded-plist decoded-pairs)
                         (decode-binding
                          binds mapping category category-of-locals)
      (declare (ignore decoded-plist))
      (if new-type
        (setq referent-form
              `(:instantiate-individual-with-binding
                ,new-type
                ,@decoded-pairs))  ;; decoded-plist  ??
        (push
         (if (cdr decoded-pairs) ;; more than one binding
           `(:bindings ,@decoded-pairs)
           `(:binding ,@decoded-pairs))
         other-forms))))

  (if (null other-forms)
    referent-form
    (cons referent-form (nreverse other-forms))))




(defun decode-binding (plist mapping category category-of-locals)

  (let ( value  variable  map-variable  decoded-plist  decoded-pairs )

    (do* ((var-symbol (pop plist) (pop remainder))
          (value-exp  (pop plist) (pop remainder))
          (remainder plist remainder))
         ((null var-symbol))

      (setq map-variable (cdr (assoc var-symbol mapping :test #'eq)))
      (when (eq map-variable category) ;; :self
        (push-debug `(,map-variable ,var-symbol ,category ,mapping))
        (error "Binding spec mapped to the category, not a variable:~
              ~%  ~a => ~a" var-symbol var-symbol))
       (setq variable
             (when map-variable
               (find-variable-for-category 
                (var-name map-variable) category)))

      ;; originally was this, where we use the var-symbol defined by
      ;; the etf to retrieve the variable. So we go another step
      ;; and make sure

;;      (push-debug `(,category ,variable)) (break "decode-binding")
      (when (null variable)
        (if category-of-locals
          ;; the schema that has this binding is local to the category
          ;; we're in the process of defining. This means it will
          ;; refer directly to its variables rather than generic names
          ;; of cases
          (unless (setq variable
                        (find var-symbol (cat-slots category-of-locals)
                              :key #'var-name))
            (error "The term ~A is neither in the mapping table nor the~
                    ~%variable list of the concept ~A"
                   var-symbol category-of-locals))
          (else
	    (push-debug `(,category ,var-symbol ,mapping))
            (error ;;"No equivalent for ~A in the mapping table"
	     "Cannot find a variable named ~a~%on the category ~a"
	     map-variable category))))

      (setq value (canonical-ref-var value-exp))
      (unless value
        (break "Value expression, ~A~
                ~%does not correspond to a canonical reference variable"
               value-exp))

      (push variable decoded-plist)
      (push value decoded-plist)
      (push `(,variable . ,value) decoded-pairs))

    (values (nreverse decoded-plist)
            (nreverse decoded-pairs))))
#|
  (let ((var-symbol (car pair))
        (value (cadr pair))
        variable )

    (setq variable (cdr (assoc var-symbol mapping :test #'eq)))

    (when (null variable)
      (if category-of-locals
        ;; the schema that has this binding is local to the category we're
        ;; in the process of defining. This means it will refer directly
        ;; to its variables rather than generic names of cases
        (unless (setq variable
                      (find var-symbol (cat-slots category-of-locals)
                            :key #'var-name))
          (error "The term ~A is neither in the mapping table nor the~
                  ~%variable list of the concept ~A"
                 variable category-of-locals))
        (else
          (error "No equivalent for ~A in the mapping table" var-symbol))))

    `(:binding ,variable
               ,(canonical-ref-var value)) ))
         |#
