;;; -*- Mode: Lisp; Syntax: Common-Lisp; Package: MUMBLE -*-
;;; Copyright (c) 2013-2016 David D. McDonald -- all rights reserved
;;;
;;;     File:  "binding-centric"
;;;   Module:  "interface;mumble;"
;;;  Version:  November 2016

;; Broken out from interface 4/7/13.
;; Completely rewritten 8/16 by AFP.

(in-package :mumble)

;;;--------------------------------------
;;; Realizations for Sparser individuals
;;;--------------------------------------

(defun pretty-bio-name (name)
  "Heuristically guess a nice name for a protein or other biological entity."
  (let ((syns (sp::get-bio-synonyms name)))
    (if syns
      (or (let ((human (search "_HUMAN" name)))
            (and human ; prefer the synonym without the _HUMAN suffix
                 (find (subseq name 0 human) syns :test #'string-equal)))
          (first (stable-sort ; prefer shortest synonym
                  (cons name (copy-list syns))
                  #'< :key #'length)))
      (subseq name (case (search "BIO-" name :test #'char-equal)
                     (0 4) ; elide bio-prefix
                     (t 0))))))

(defun sparser-pos (pos)
  "Translate a Mumble part-of-speech tag to the equivalent Sparser tag."
  (ecase pos
    (noun :common-noun)
    (verb :verb)
    (adjective :adjective)
    (preposition :prep)
    (interjection :interjection)))

(defvar *original-pos* nil
  "Guard against infinite mutual recursion in WORD-FOR.")

(defgeneric word-for (item pos)
  (:method ((item null) pos)
    (declare (ignore pos)))
  (:method ((item word) pos)
    (declare (ignore pos))
    item)
  (:method ((item string) pos)
    (word-for-string item pos))
  (:method ((item sp::word) pos)
    (sp::get-mumble-word-for-sparser-word item pos))
  (:method ((item sp::polyword) pos)
    (sp::get-mumble-word-for-sparser-word item pos))
  (:method ((item sp::referential-category) pos)
    "Try to get a head word for a category."
    (let ((head (sp::rdata-head-word item (sparser-pos pos))))
      (word-for (typecase head
                  (sp::lambda-variable (sp::lemma item (sparser-pos pos)))
                  (null (string-downcase (sp::cat-name item)))
                  (t head))
                pos)))
  (:method ((item sp::individual) pos)
    "Try to get a head word for an individual."
    (let ((head (or (sp::rdata-head-word item (sparser-pos pos))
                    (sp::lemma item (sparser-pos pos))
                    (sp::value-of 'sp::name item)
                    (sp::value-of 'sp::word item))))
      (and head (word-for head pos))))
  (:method :around ((item sp::individual) pos)
    "Treat biological entities and collections specially."
    (cond ((sp::itypep item 'sp::biological)
           (let ((word (call-next-method)))
             (and word
                  (word-for-string (pretty-bio-name (sp::pname word)) pos))))
          ((sp::itypep item 'sp::collection)
           (word-for (sp::value-of 'sp::type item) pos))
          (t (or (call-next-method) ; last-ditch effort
                 (word-for (string-downcase (sp::cat-name (sp::itype-of item))) pos)))))
  (:method :around (item (pos (eql 'adjective)))
    "Allow nouns as premodifiers."
    (or (call-next-method)
        (unless *original-pos*
          (let ((*original-pos* pos))
            (word-for item 'noun)))))
  (:method :around (item (pos (eql 'noun)))
    "Allow nouns as predications."
    (or (call-next-method)
        (unless *original-pos*
          (let ((*original-pos* pos))
            (word-for item 'adjective)))))
  (:method :around (item (pos (eql 'verb)))
    "Allow verbs as predications."
    (or (call-next-method)
        (word-for item 'adjective))))

(defun current-position-p (&rest labels)
  "Return true if the slot being generated has one of the given labels."
  (memq (name *current-position*) labels))

(defgeneric tense (object)
  (:documentation "Determine and attach tense to the given object.")
  (:method ((dtn derivation-tree-node) &aux (referent (referent dtn)))
    "Attach tense to the given DTN by inspecting its referent."
    (cond ((sp::value-of 'sp::past referent)
           (past-tense dtn))
          ((sp::value-of 'sp::progressive referent)
           (progressive dtn))
          ((sp::value-of 'sp::perfect referent)
           (had dtn))
          ((current-position-p 'adjective 'complement-of-be 'relative-clause)
           (past-tense dtn))
          (t (present-tense dtn))))
  (:method :after ((dtn derivation-tree-node) &aux (referent (referent dtn)))
    "Interpret a referent with an object but no subject as an imperative."
    (when (and (sp::individual-p referent)
               (sp::missing-subject-vars referent)
               (let ((object-var (sp::bound-object-var referent)))
                 (and object-var (not (eq (sp::value-of object-var referent)
                                          sp::**lambda-var**)))))
      (command dtn))))

(defun heavy-predicate-p (i)
  "Return true if the individual is too heavy to be used as a premodifier."
  (and (sp::individual-p i)
       (remove-if (lambda (b)
                    (or (eq (sp::binding-value b) sp::**lambda-var**)
                        (eq (sp::var-name (sp::binding-variable b)) 'sp::name)))
                  (sp::indiv-binds i))))

(defgeneric guess-pos (i)
  (:documentation "Guess the part of speech to be used for an individual.")
  (:method-combination or)
  (:method or ((i sp::individual))
    (cond ((let ((subject (sp::bound-subject-var i)))
             (and subject (eq (sp::value-of subject i) sp::**lambda-var**)))
           'adjective)
          ((or (sp::bound-subject-var i)
               (sp::bound-object-var i)
               (find sp::**lambda-var** (sp::indiv-binds i)
                     :key #'sp::binding-value))
           'verb)))
  (:method or ((i sp::referential-category))
    (cond ((or (sp::subject-variable i)
               (sp::object-variable i))
           'verb)))
  (:method or (i)
    (if (current-position-p 'adjective 'relative-clause)
      'adjective
      'noun)))

(defmethod realize ((i sp::individual))
  "Realize a Sparser individual. Since categories are not (yet) classes,
   and therefore cannot have specialized methods, special cases go here."
  (cond ((sp::itypep i 'sp::collection)
         (let ((items (sp::value-of 'sp::items i)))
           (if (null items)
             (plural (realize-via-bindings i :pos 'noun))
             (cl:labels ((conjoin (one &optional two &rest more)
                           (let ((conjunction
                                  (make-dtn :referent `(and ,one ,two)
                                            :resource (phrase-named
                                                       'two-item-conjunction))))
                             (make-complement-node 'one one conjunction)
                             (make-complement-node 'two two conjunction)
                             (if more
                               (apply #'conjoin conjunction more)
                               conjunction))))
               (apply #'conjoin items)))))
        ((sp::itypep i 'sp::number)
         (format nil "~r" (sp::value-of 'sp::value i)))
        ((sp::itypep i 'sp::polar-question)
         (discourse-unit (question (realize (sp::value-of 'sp::statement i)))))
        ((sp::itypep i 'sp::copular-predication)
         (let ((be (realize-via-bindings (sp::value-of 'sp::predicate i)
                                         :pos 'verb
                                         :resource (phrase-named 's-be-comp))))
           (attach-subject (sp::value-of 'sp::item i) be)
           (attach-complement (sp::value-of 'sp::value i) be)
           be))
        ((sp::itypep i 'sp::explicit-suggestion)
         (let ((dtn (realize-via-bindings (sp::value-of 'sp::suggestion i)))
               (m (sp::value-of 'sp::marker i))
               (ap 'initial-adverbial))
           (make-adjunction-node (make-lexicalized-attachment ap m) dtn)
           dtn))
        ((sp::itypep i 'sp::there-exists)
         (let ((be (realize-via-bindings (sp::value-of 'sp::predicate i)
                                         :pos 'verb
                                         :resource (phrase-named 's-be-comp))))
           (attach-subject (find-word "there" 'pronoun) be)
           (attach-complement (sp::value-of 'sp::value i) be)
           be))
        ((sp::itypep i 'sp::object-dependent-location) ;; 'end of the row'
         (apply-category-linked-phrase i))
        ((sp::itypep i 'sp::relative-location)
         (apply-category-linked-phrase i))
        (t (realize-via-bindings i))))

(defgeneric realize-via-bindings (i &key pos resource)
  (:method ((i sp::individual) &key
            (pos (guess-pos i))
            (resource (ecase pos
                        (adjective (word-for i pos))
                        (noun (noun (word-for i pos)))
                        (verb (verb (word-for i pos) 'svo)))))
    "Realize a Sparser individual as a DTN with its bindings attached."
    (loop with dtn = (make-dtn :referent i :resource resource)
          initially (case pos (verb (tense dtn)))
          for binding in (reverse (sp::indiv-binds i))
          as variable = (sp::binding-variable binding)
          as var-name = (sp::var-name variable)
          do (attach-via-binding binding var-name dtn pos)
          finally (return dtn))))

(defun attach-adjective (adjective dtn pos)
  (let ((adjp (make-dtn :referent adjective
                        :resource (phrase-named 'adjective-phrase)))
        (ap (ecase pos
              ((adjective noun) 'adjective)
              ((adverb verb)
               (if (sp::itypep adjective 'sp::intensifier)
                 'adverbial-preceding
                 (multiple-value-bind (head rpos)
                     (sp::rdata-head-word adjective t)
                   (declare (ignore head))
                   (case rpos
                     (:interjection 'adverbial-preceding)
                     (otherwise 'vp-final-adjunct))))))))
    (make-complement-node 'a adjective adjp)
    (make-adjunction-node (make-lexicalized-attachment ap adjp) dtn)))

(defun attach-pp (prep object dtn pos)
  (let ((pp (make-dtn :resource (prep prep)))
        (ap (ecase pos
              ((adjective noun) 'np-prep-adjunct)
              (verb 'vp-prep-complement))))
    (make-complement-node 'prep-object object pp)
    (make-adjunction-node (make-lexicalized-attachment ap pp) dtn)))

(defun possibly-pronoun (item)
  (cond ((sp::itypep item 'sp::pronoun/first/singular)
         (pronoun-named 'first-person-singular))
        ((sp::itypep item 'sp::pronoun/first/plural)
         (pronoun-named 'first-person-plural))
        ((sp::itypep item 'sp::pronoun/second)
         (pronoun-named 'second-person-singular))
        ((sp::itypep item 'sp::pronoun/plural)
         (pronoun-named 'third-person-plural))
        (t item)))

(defun attach-subject (subject dtn)
  (make-complement-node 's (possibly-pronoun subject) dtn))

(defun attach-object (object dtn)
  (make-complement-node 'o (possibly-pronoun object) dtn))

(defun attach-complement (complement dtn)
  (make-complement-node 'c (possibly-pronoun complement) dtn))

(defgeneric attach-via-binding (binding var-name dtn pos)
  (:method (binding var-name dtn pos)
    "Attach a binding as a subject, object, or prepositional phrase."
    (declare (ignore var-name))
    (declare (optimize debug))
    (let* ((individual (sp::binding-body binding))
           (variable (sp::binding-variable binding))
           (value (sp::binding-value binding))
           (subcats (stable-sort ; prefer shorter words
                     (typecase value
                       ((or sp::referential-category sp::individual)
                        (sp::find-subcat-labels value variable individual)))
                     #'< :key (lambda (label)
                                (etypecase label
                                  ((or string symbol)
                                   (length (string label)))
                                  ((or sp::word sp::polyword)
                                   (length (sp::pname label)))))))
           (prep (or (find-if #'sp::word-p subcats) ; prefer single words
                     (find-if #'sp::polyword-p subcats))))
      (cond ((eql value sp::**lambda-var**))
            ((or (eql variable (sp::subject-variable individual))
                 (find :subject subcats))
             (if (current-position-p 'complement-of-be)
               (attach-pp "by" value dtn pos) ; passive subject
               (attach-subject value dtn)))
            ((or (eql variable (sp::object-variable individual))
                 (find :object subcats))
             (attach-object value dtn))
            ((sp::itypep value 'sp::attribute-value) ; essentially a modifier
             (attach-adjective value dtn pos))
            (prep
             (attach-pp (sp::get-mumble-word-for-sparser-word prep 'preposition)
                        value dtn pos))
            ((find :thatcomp subcats)
             (make-adjunction-node
              (make-lexicalized-attachment 'restrictive-relative-clause value)
              dtn))
            ((find :m subcats)
             (attach-adjective value dtn pos)))))
  
  (:method (binding (var-name (eql 'sp::adverb)) dtn pos)
    "Attach an adverb."
    (attach-adjective (sp::binding-value binding) dtn pos))
  
  (:method (binding (var-name (eql 'sp::has-determiner)) dtn pos)
    "Attach a determiner."
    (declare (ignore pos))
    (case (sp::cat-name (sp::itype-of (sp::binding-value binding)))
      (sp::a (initially-indefinite dtn))
      (sp::the (always-definite dtn))
      (sp::that (attach-adjective "that" dtn 'noun))))
  
  (:method (binding (var-name (eql 'sp::modal)) dtn pos)
    "Attach a modal."
    (add-accessory dtn :tense-modal (word-for (sp::binding-value binding) pos) t))
  
  (:method (binding (var-name (eql 'sp::modifier)) dtn pos)
    "Attach a modifier as an adjective."
    (attach-adjective (sp::binding-value binding) dtn pos))
  
  (:method (binding (var-name (eql 'sp::negation)) dtn pos)
    "Attach a negation."
    (negate dtn))
  
  (:method (binding (var-name (eql 'cl:number)) dtn pos)
    "Attach a numeric quantifier as an adjective so it retains its determiner."
    (attach-adjective
     (let ((number (sp::binding-value binding)))
       (if (sp::itypep number 'sp::ordinal)
         (format nil "~:r" (sp::value-of 'sp::value (sp::value-of 'sp::number number)))
         (format nil "~r" (sp::value-of 'sp::value number))))
     dtn pos))
  
  (:method (binding (var-name (eql 'sp::position)) dtn pos)
    "Attach a position as a premodifier."
    (attach-adjective (sp::binding-value binding) dtn pos))
  
  (:method (binding (var-name (eql 'sp::predicate)) dtn pos)
    "Attach a predicate as a diff from the subject or object description."
    (loop with value = (sp::binding-value binding)
          with complement = (loop with s/o = (list (parameter-named 's)
                                                   (parameter-named 'o))
                                  for c in (complements dtn)
                                  when (and (find (phrase-parameter c) s/o)
                                            (sp::itypep (referent c)
                                                        (sp::itype-of value)))
                                  return (referent c))
          for binding in (set-difference (and (sp::individual-p value)
                                              (sp::indiv-binds value))
                                         (and (sp::individual-p complement)
                                              (sp::indiv-binds complement))
                                         :key #'sp::binding-variable)
       do (attach-adjective (sp::binding-value binding) dtn pos)))
  
  (:method (binding (var-name (eql 'sp::predication)) dtn pos)
    "Attach a predication as either a premodifier or a relative clause."
    (let* ((individual (sp::binding-body binding))
           (predicate (sp::binding-value binding)))
      (if (heavy-predicate-p predicate)
        (make-adjunction-node
         (make-lexicalized-attachment
          'restrictive-relative-clause
          (let ((be (make-dtn :referent predicate
                              :resource (phrase-named 's-be-comp))))
            (attach-subject individual be)
            (attach-complement predicate be)
            (present-tense be)))
         dtn)
        (attach-adjective predicate dtn pos))))
  
  (:method (binding (var-name (eql 'sp::quantifier)) dtn pos)
    "Attach a quantifier as a premodifier."
    (attach-adjective (sp::binding-value binding) dtn pos))

  (:method (binding (var-name (eql 'sp::parts)) dtn pos)
    "This variable is defined by partonomic and will hold a set -of- parts"
    (attach-pp (find-word "of") (sp::binding-value binding) dtn pos))
  
  (:method (binding (var-name (eql 'sp::time)) dtn pos)
    "Attach a time as an adverbial."
    (declare (ignore pos))
    (make-adjunction-node
     (make-lexicalized-attachment 'adverbial-preceding (sp::binding-value binding))
     dtn))
  
  (:method (binding (var-name (eql 'sp::location)) dtn pos)
    "Look at how the location will be realized and selected an attachment
     point that fits."
    (let* ((i (sp::binding-value binding))
           (label-realizing-i (realizing-label (realizing-resource i))))
      ;;(push-debug `(,i ,label-realizing-i ,binding)) (break "realize location slot")
      (let ((ap (case pos
                  (noun
                   (etypecase label-realizing-i
                     (word-label 'nominal-premodifier)
                     (node-label 'np-prep-complement)))
                  (otherwise 'vp-final-adjunct) ;; 'np-prep-complement)
                  )))
        (make-adjunction-node
         (make-lexicalized-attachment ap i)
         dtn)))))
    
