;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 2017 David D. McDonald  -- all rights reserved
;;;
;;;     File:  "binding-helpers"
;;;   Module:  "/interface/mumble/"
;;;  version:  September 2017

;; initiated 7/25/17 to hold all the auxiliary subroutines of the
;; realization procesure.

(in-package :mumble)

;;;-----------------------------------------------------------
;;; interface into Mumble's state at the time we make the dtn
;;;-----------------------------------------------------------

(defun current-position ()
  "Wraps the generation state variable *current-position*, which only
   has a value when Mumble has started instantiating and executing phrases.
   Returns nil if the variable does not have a meaningful value."
  (when (boundp '*current-position*)
    (when *current-position* ;; nil check
      *current-position*)))

(defun current-position-p (&rest labels)
  "Return true if the slot being generated has one of the given labels."
  (let ((slot (current-position)))
    (when slot
      (memq (name slot) labels))))

(defun current-position-is-top-level? ()
  "Is the current position something like turn or a similar
   main-clause holding slot like sentence, question, or s.
   If the current position isn't bound yet then we're in 
   declared to be at top level. 
      Controls application of command in the tense fn."
  (let ((slot (current-position)))
    (if (null slot)
      t
      (let ((name (name slot))) ;; the 1st label
        (memq name '(turn sentence question s paragraph))))))



(defun current-position-compatible-with-pos (pos-label)
  "Is the current syntactic position compatible with
   realizations of this particular part-of-speech?"
  (let ((slot (current-position)))
    (when slot
      (grammatically-compatible? slot pos-label))))

(defgeneric grammatically-compatible? (position pos)
  (:documentation "Are the grammatical constraints on this position
    compatible with realizations of this part of speech")
  (:method ((slot slot) (pos symbol))
    (let* ((table *slot-name-part-of-speech-table*)
           (labels-on-slot (labels slot))
           (label-names (loop for l in labels-on-slot
                           collect (name l))))
      (let ((entries (loop for name in label-names
                        when (assoc name table)
                        collect (cadr (assoc name table)))))
        (unless entries (warn "no slot-pos entry for ~a" label-names))
        (loop for entry in entries
           when (memq pos entry)
           do (return-from grammatically-compatible? t))
        nil))))

(defparameter *slot-name-part-of-speech-table*
  '((turn (verb noun adjective adverb))
    ;; grammatical-constraints (clause np vp pp adjp advp)
    (subject (noun)) ;; (np vp)
    (direct-object (noun)) ;; (np)
    (relative-clause (verb))
    )
  "Has the information we could otherwise glean (and abstract to
   the needed level) from the grammatical constraints on slot labels")


;;;----------------------
;;; poor man's def-trace
;;;----------------------

(defparameter *trace-archie* nil)

(defun sp::trace-realize () (setq *trace-archie* t))
(defun sp::untrace-realize () (setq *trace-archie* nil))

(defun tr (string &rest args)
  (when *trace-archie*
    (let ((doctored-string (string-append "~&" string "~%")))
      (apply #'format t doctored-string args))))

;;;-----------------------------------------
;;; special cases for realizing individuals
;;;-----------------------------------------

(defun pretty-bio-name (name)
  "Heuristically guess a nice name for a protein or other biological entity."
  (let ((syns (sp::get-bio-synonyms name)))
    (if syns
      (or (let ((human (search "_HUMAN" name))) ; prefer the synonym without the _HUMAN suffix
            (find (subseq name 0 human) syns :test #'string-equal))
          (first (stable-sort ; prefer shortest synonym
                  (cons name (copy-list syns))
                  #'< :key #'length)))
      ;; no synonyms, so look for removable parts
      (let ((index (search "_HUMAN" name)))
        (if index
          (subseq name 0 index)
          (subseq name (case (search "BIO-" name :test #'char-equal)
                         (0 4) ; elide bio-prefix
                         (t 0))))))))


;;---- dtn sources for particular cases

(defun realize-number (i)
  "Make a dtn for simple number words. For long, multi-word numbers recover
   the algorithm from grammar/numbers.lisp"
  (let* ((lisp-number (sp::value-of 'sp::value i))    
         (number-string (format nil "~r" lisp-number))
         ;; (format nil "~r" 1325) => "one thousand three hundred twenty-five"
         (word (word-for-string number-string 'number))
         (phrase (phrase-named 'bare-np-head))
         (dtn (make-dtn :referent i :resource phrase)))
    (tr "Realize-number: ~a" i)
    (make-complement-node 'n word dtn)
    dtn))


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
               (current-position-is-top-level?)
               (sp::missing-subject-vars referent)
               (let ((object-var (sp::bound-object-var referent)))
                 (and object-var (not (eq (sp::value-of object-var referent)
                                          sp::**lambda-var**)))))
      (command dtn))))

(defun heavy-predicate-p (i)
  "Return true if the individual is too heavy to be used as a premodifier.
   Applied to predication and location bindings in attach-via-binding"
  (and (sp::individual-p i)
       ;; Could it be a pp or a clause that has a subj or obj that's not lambda
       ;;/// how to test pp case -- e.g. for location?
       (includes-real-subj/obj? i)))

;; Original definition. Doesn't deal properly with "phosphorylated MEK"
;; Where that instance of phosphorylated should be deemed light.
       #+ignore(remove-if (lambda (b)
                    (or (eq (sp::binding-value b) sp::**lambda-var**)
                        (eq (sp::var-name (sp::binding-variable b)) 'sp::name)))
                          (sp::indiv-binds i))

(defun includes-real-subj/obj? (i)
  (let ((subject (loop for v in (sp::find-subject-vars i)
                    as value = (sp::value-of v i)
                    when value do (return value)))
        ;; ignoring possibilty of intransitives since we don't know
        ;; what the realization really would be
        (object (loop for v in (sp::find-object-vars i)
                   as value = (sp::value-of v i)
                   when value do (return value))))
    (when subject
      (when (eq subject sp::**lambda-var**)
        (setq subject nil)))
    (when object
      (when (eq object sp::**lambda-var**)
        (setq object nil)))
    (or subject object)))





;;--------- dtn modifiers
#| These take a dtn that was created by their caller and add to it.
Many use methods in derivation-trees/builders.lisp or make.lisp
to do the actual manipulation. These are called by cases in
attach-via-binding. |#

(defun attach-adjective (adjective dtn pos)
  (let ((adjp (make-dtn :referent adjective
                        :resource (phrase-named 'adjp)))
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
    (tr "Attaching adjective: ~a" adjective)
    (make-complement-node 'a adjective adjp)
    (make-adjunction-node (make-lexicalized-attachment ap adjp) dtn)))

(defun attach-pp (prep object dtn pos)
  (let ((pp (make-dtn :resource (prep prep)))
        (ap (ecase pos
              ((adjective noun) 'np-prep-adjunct)
              (verb 'vp-prep-complement))))
    (tr "Attaching a pp: ~a ~a" prep object)
    (make-complement-node 'prep-object object pp)
    (make-adjunction-node (make-lexicalized-attachment ap pp) dtn)))


(defun possibly-pronoun (item)
  "Wrapper around subject, object, and complement below."
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
  (tr "Attaching subject: ~a" subject)
  (make-complement-node 's (possibly-pronoun subject) dtn))

(defun attach-object (object dtn)
  (tr "Attaching object: ~a" object)
  (make-complement-node 'o (possibly-pronoun object) dtn))

(defun attach-complement (complement dtn)
  (tr "Attaching complement: ~a" complement)
  (make-complement-node 'c (possibly-pronoun complement) dtn))


