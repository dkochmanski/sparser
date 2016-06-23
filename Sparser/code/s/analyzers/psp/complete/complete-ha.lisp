;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1990-1991  Content Technologies Inc.
;;; copyright (c) 1993-1997,2013-2016  David D. McDonald  -- all rights reserved
;;; extensions copyright (c) 2007-2008 BBNT Solutions LLC. All Rights Reserved
;;;
;;;      File:   "complete HA"
;;;    Module:   "analyzers;psp:complete:"
;;;   Version:   June 2016

;; 1.1  (5/2 v1.8.4)  Modified Complete-edge to check the quiescent
;;      position of the forest-level parser
;; 1.2  (10/21 v2.0) Overhauled it to streamline/make-consistent the
;;      calling patterns & hooks.
;;      (11/1) put in *do-completion-actions* in place of *..action..*
;; 1.3 (7/14/92 v2.3) bumped version to 3 to go with changing the call
;;       for anaphor recording of edges.
;; 3.1 (5/3/93) added status setting to word completion routine
;; 3.2 (6/11) passed positions through to next stage
;; 3.3 (12/6) flushed the polyword case since it's subsumed by edges
;; 3.4 (6/6/94) added a optional subsumption test on edges
;; 3.5 (7/12) redefined the subsumption test as an alist to handle arbitrary depth
;;     (7/22) put a patch in it to get around a separate bug
;;     (10/13/97) put a model gate in Complete-edge/hugin.
;;     (2/5/07) converted e{type}case to use otherwise & break
;;     (7/14/08) Made "hugin" lowercase in anticipation of lower-casing
;;      all functions.
;;     (2/8/13) Fixed incorrect status setter
;;     (6/6/15) Added cache-local-edge-referent-pair to the edge case
;; 3.6 (6/8/15) Folded in polywords throughout.
;;      Diagnostics for edge-referents which are CONS cells --
;;        break is controlled by parameter *diagnose-consp-referents*
;;      Installed (note-surface-string edge) to provide information
;;        for cards.

(in-package :sparser)


;;;-----------
;;; the hook
;;;-----------

#| Hugin (??)
This is one of the oldest files in Sparser. When it was first written
there were three alternatives functions that could be run when an edge
or word was completed ("complete" comes from Earley's algorithm).
The other two were dropped from the load quite some time ago, leaving
this one, which was the 'smartest' of the three, mostly because of the
edge subsumption check and the use of the same algorithm in the
discourse update. 

Hugin ("HOO-gin") was one of the two ravens that aided Odin. The other
was Muninn. Hugin was the spirit of thought, Muninn of desire. 
They are often depicted as perching on Odin's shoulders.

See http://norse-mythology.org/gods-and-creatures/others/hugin-and-munin/
|#

(defun complete/hugin (obj
                       &optional position next-position)

  (when *do-completion-actions*
    (tr :completing obj position)
    (typecase obj
      (edge     (complete-edge/hugin obj))
      (word     (complete-word/hugin obj position next-position))
      (polyword (complete-word/hugin obj position next-position))
      (otherwise
       (break "Something other than an edge or a word passed ~
               to completion hook: ~a" obj)))))


;;;-------
;;; words
;;;-------

(defun complete-word/hugin (word
                            &optional position-before
                                      position-after)

  (check-for-completion-actions/word word
                                     position-before
                                     position-after)
  (when position-before
    (set-status :word-completed position-before))
  :complete )


;;;--------
;;; edges
;;;--------

(defun complete-edge/hugin (edge)
  (declare (special *do-anaphora*  ;; may be dynamically bound
                    *use-discourse-mentions*))

  (unless (subsumption-check/complete edge)
    ;;(push-debug `(,edge)) (lsp-break "~a passed the check" edge)
    (check-for-completion-actions/category (edge-category edge)
                                           edge))

  (valid-referent? edge) ;; error if null

  (when (or *use-discourse-mentions*
	    (and *include-model-facilities*
	     *pronouns* ;; the module is loaded
	     *do-anaphora*)) ;; we've not deliberately turned it off
    (add-subsuming-object-to-discourse-history edge))

  ;; Update forest level indexes
  (check-impact-on-quiescence-pointer edge)

  (when *use-discourse-mentions*
    (update-mention-links edge))

  (note-surface-string edge)

  (update-definite-determiner edge) ;; recording function

  (maybe-check-semantic-completeness edge)

  ;; keep this on the stack
  :complete )



;;;-------------------
;;; subsumption check
;;;-------------------

(defvar *instances-of-subsumption-relevant-edges* nil)

(define-per-run-init-form
  '(setq *instances-of-subsumption-relevant-edges* nil))


(defun subsumption-check/complete (edge)
  "It is convient occassionally to rewrite an edge as another edge
   over the identical span and with the same label. If that label
   has a completion action there is the potential for an infinite
   rewriting loop (but caught by the limit in edge-vectors). 
   This can be prevented by marking the label to inhibit the use
   of completion. This code checks for that. We let the first
   instance of one of these edges through, but block all later
   edges if the covers the same span."
  (let ((category (edge-category edge)))
    (when (get-tag :inhibit-completion-actions-of-subsumer category)
      (let ((entry
             (assoc category *instances-of-subsumption-relevant-edges*)))
        (if entry
          (let ((old-start (first (cdr entry)))
                (old-end   (second (cdr entry)))
                (new-start (pos-token-index (pos-edge-starts-at edge)))
                (new-end (pos-token-index (pos-edge-ends-at edge))))
            (let ((subsumes?
                   (unless (>= new-start old-end)
                     (and (<= new-start old-start)
                          (>= new-end old-end)))))
              (if subsumes?
	        (then
                  (rplacd entry `(,new-start ,new-end))
                  t )
                (else
                  (rplacd entry `(,new-start ,new-end))
                  nil ))))
          (else ;; no entry
            (push `(,category
                     . (,(pos-token-index (pos-edge-starts-at edge))
                         ,(pos-token-index (pos-edge-ends-at edge))))
                  *instances-of-subsumption-relevant-edges*)
            nil ))))))

(defun inhibit-completion-when-subsumes (label)
  ;; called from the grammar to setup the subsumption check
  ;; and inhibition on a specific label
  (setf (get-tag :inhibit-completion-actions-of-subsumer label) t)
  :done)




;;;-----------------------------
;;; various checks on referents
;;;-----------------------------

(defparameter *diagnose-consp-referents* nil)

(defun valid-referent? (edge)
  "Trap cases where an edge that should have a referent doesn't.
   And for the posibility of the referent being a cons"
  (declare (special category::punctuation category::dash word::|is|))
  (when (null (edge-referent edge))
    ;; It doesn't have a referent. Is that ok?
    (unless (or (polyword-p (edge-category edge))
                (eq (edge-form edge) category::punctuation)
                (eq (edge-category edge) category::dash)
                (eq (edge-category edge) word::|is|) ;; for CS rules in be.lisp
                (member (edge-rule edge)
                        '(:default-edge-over-paired-punctuation
                          :conjunction/identical-adjacent-labels
                          ;; happened once, in ""substrate like" and "regulatory" "
                          :appostrophe-fsa)))
      (push-debug `(,edge))
      (error "edge with null referent: ~a" edge)))
    
  (when (and *diagnose-consp-referents*
             (consp (edge-referent edge)))
    (break "referent is a CONS~ ~s" (edge-referent edge))))



(defparameter *check-semantic-completeness* nil)

(defun ignore-semantic-check? (rule)
  (declare (special *chunk* *ignored-semantic-check-rules*))
  (or (when (not (cfr-p rule))
        (cond
          ((polyword-p rule) t)
          ((eq rule 'sdm-span-segment)
           (format t "~&sdm-span-segment in complete-edge/hugin on ~s~&" *chunk*)
           t)
          ((member rule '(:number-fsa nospace-colon-specialist
			   make-hyphenated-pair 
                          :default-edge-over-paired-punctuation
                          knit-parens-into-neighbor
                          :conjunction/identical-adjacent-labels))
           t)))
      (null (cdr (cfr-rhs rule)))
      (loop for x in (cfr-rhs rule) thereis (not (category-p x)))
      (member (cat-name (car (cfr-rhs rule)))
	      '(that which syntactic-there be det))
      (member (mapcar #'cat-name (cfr-rhs rule))
	      *ignored-semantic-check-rules*
	      :test #'equal)))

(defparameter *ignored-semantic-check-rules*
  '((syntactic-there be)))

(defun maybe-check-semantic-completeness (edge)
  (when (and *check-semantic-completeness*
             (edge-rule edge)
             (not (ignore-semantic-check? (edge-rule edge))))
    (let ((left (edge-left-daughter edge))
          (right (edge-right-daughter edge)))
      (when (and (edge-p left)(edge-p right)
                 (individual-p (edge-referent left))
                 (individual-p (edge-referent right)))
        (let ((all-sem (semtree edge))
              (left-sem (norm-sem left))
              (right-sem (norm-sem right)))
          (cond
            ((not (contains-sem? all-sem left-sem))
             (if (and (consp left-sem)
                      (itypep (car left-sem) 'pronoun))
                 (format t "~&rule ~s loses semantics for pronoun ~s in ~a~&"
                         (edge-rule edge) left-sem
                         `(,(car all-sem) ,(second all-sem)  "..." ))
                 (lsp-break "check-semantic-completeness, all-sem does ~
                             not contain left-sem")))
            ((not (contains-sem? all-sem right-sem))
             (if (and (consp right-sem)
                      (itypep (car right-sem) 'pronoun))
                 (format t "~&rule ~s loses semantics for pronoun ~s in ~a~&"
                         (edge-rule edge) right-sem `(,(car all-sem) ,(second all-sem) "..." ) )
                 (lsp-break "check-semantic-completeness, all-sem does ~
                             not contain left-sem"))
             (lsp-break "check-semantic-completeness, all-sem does ~
                         not contain right-sem"))))))))

(defun norm-sem (i)
  (let ((sem (semtree i nil)))
    (cond
      ((not (consp sem)) sem) ;; e.g. 50, for the tree from #<number "50">
      ((or (itypep (car sem) 'prepositional-phrase)
	   (itypep (car sem) 'copular-pp))
       (semtree (value-of 'pobj (car sem))))
      ((itypep (car sem) 'to-comp)
       (semtree (value-of 'comp (car sem))))
      (t sem))))

(defun contains-sem? (all part)
  (cond
    ((not (consp part))
     ;; assume that it has been included -- e.g. a number
     t)
    ((and
      (itypep (car all) 'collection)
      (not (itypep (car all) 'hyphenated-pair)))
     (or
      (as-specific?  (car all)(car part))
      (member (car part) (value-of 'items (car all)))
      (contains-sem-in-bindings? all part)))
    ((as-specific? (car all) (car part)))
    (t (contains-sem-in-bindings? all part))))

(defun contains-sem-in-bindings? (all part)
  (loop for sall in (cdr all)
     thereis
       (and (consp (second sall))
	    (individual-p (car (second sall)))
	    (contains-sem? (second sall) part))))

