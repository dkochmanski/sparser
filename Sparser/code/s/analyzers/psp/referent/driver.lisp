;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1991-1999,2011-2017 David D. McDonald  -- all rights reserved
;;; Copyright (c) 2007 BBNT Solutions LLC. All Rights Reserved
;;;
;;;      File:   "driver"
;;;    Module:   "analyzers;psp:referent:"
;;;   Version:   February 2017

;; broken out from all-in-one-file 11/28/91
;; 1.0 (8/28/92 v2.3) Added global referring to the referent returned.
;; 1.1 (10/24) flushed the out-of-date referent actions and added some
;;      cases in the new semantics
;; 1.2 (5/15/93) Switched to setq'ing *referent* because the actions have
;;      to change it.
;; 1.3 (8/4) added keyword args so that it could be driven off referents
;;      directly without having to have the left-edge.
;; 1.4 (1/6/94) added switch that would pre-empt everything
;; 1.5 (4/19/95) zero'ing *referent* at the start of each call.
;; 2.0 (3/22/98) direct referents now initiate psi's.
;;     (6/30) rethreaded to group common elements as part of handling annotations.
;;     (7/12) pulled them in favor of doing within the dispatches.
;; 2.1 (7/25) Because the psi keep going down the lattice as they get elaborated,
;;      changed to updating the referent with each action instead of just
;;      the first.
;; 2.2 (6/4/99) revised Referent-from-rule to pass more information through to
;;      the annotater, and cleaned up the now obsolete direct-pointer?
;; 2.3 (1/10/07) Refined decision for 2.1 so that only certain classes update
;;      the referent (cases from dm&p rules)
;;     (4/27/11) Cleanup. More on 5/10
;; 2.4 (7/22/13) Added some doc and the base of the redistribute method
;;     (8/14/13) More syntactic sugar.
;;     (10/10/13) Added final hook to incorporate the referent into the situation. 
;;     (3/31/14) Put real call for the c3 case. (4/7/14) Letting the result of
;;      the C3 call (which wraps a call to compose) override the referent.
;; 2.5 (1/2/2015) change referent-from-rule to refurn :abort-edge when the referent 
;;      computation fails, so that failed sub-categorization frames are not applied
;; 2.6 (4/19/15) Factored out walk-through-referent-actions from referent-from-rule
;;      so the guts of the loop were easier to read and as place to restructure
;;      the rule field to notice head+binding expressions and compose them
;;      into a new :head-and-bindings expression.

(in-package :sparser)

;;;---------
;;; globals
;;;---------

;; Lexically bound immediately when referent-from-rule is called
(defvar *left-edge-into-reference*  nil)
(defvar *right-edge-into-reference* nil)
(defvar *parent-edge-getting-reference* nil)
(defvar *rule-being-interpreted* nil)
(defvar left-referent nil)
(defvar right-referent nil)

;; Used in setting up annotations and keeping track
;; of which edge is which in routines that are sensitive
;; to head constituents
(defvar *head-edge* nil)
(defvar *arg-edge* nil)

;; Tracks the referent as it morphs when looping
;; through successive terms in the rule-field
(defvar *referent* nil)


;; For N-ary rules
(defvar first-daughter nil)
(defvar second-daughter nil)
(defvar third-daughter nil)
(defvar fourth-daughter nil)
(defvar fifth-daughter nil)
(defvar sixth-daughter nil)
(defvar seventh-daughter nil)
(defvar eighth-daughter nil)
(defvar ninth-daughter nil)
(defvar tenth-daughter nil)


(defparameter *no-referent-calculations* nil)


;;;------------
;;; the driver
;;;------------
         
(defun referent-from-rule (left-edge
                           right-edge
                           parent-edge
                           rule
                           &key left-ref
                             right-ref )
  (declare (special *c3*))

  (setq *referent* nil) ;; cleanup from last time

  (cond
    ((or (eq rule :conjunction/identical-adjacent-labels)
         (eq rule :conjunction/identical-form-labels))
     (referent-of-two-conjoined-edges left-edge right-edge))

    (t
     (unless *no-referent-calculations*
       (let ((*left-edge-into-reference*       left-edge)
             (*right-edge-into-reference*      right-edge)
             (*parent-edge-getting-reference*  parent-edge)
             (*rule-being-interpreted*         rule)
             (*head-edge* nil) ;; set in ref/head
             (*arg-edge* nil)  ;; ditto
             (left-referent  (or left-ref
                                 (and (edge-p left-edge)
                                      (edge-referent left-edge))))
             (right-referent (or right-ref
                                 (and (edge-p right-edge)
                                      (edge-referent right-edge))))
             (rule-field (cfr-referent rule)))

         (declare (special 
                   *left-edge-into-reference* *right-edge-into-reference*
                   *parent-edge-getting-reference* *rule-being-interpreted*
                   *head-edge* *arg-edge*))
                        
         (when rule-field
           (if (listp rule-field)
             (then
               (if (listp (first rule-field))
                 (walk-through-referent-actions 
                  rule-field left-referent right-referent right-edge)
                 (else ;; just one action
                   (setq *referent*
                         (dispatch-on-rule-field-keys
                          rule-field left-referent right-referent right-edge)))))

             (else ;; direct pointer to referent
               (setq *referent* rule-field)
               (annotate-individual *referent* :immediate-referent)))

           (redistribute left-referent right-referent)

           (when *c3*
             (let ((result (incorporate-composition-into-situation 
                            left-referent right-referent 
                            *referent* rule parent-edge)))
               (when result
                 (unless (eq result *referent*)
                   (setq *referent* result)))))

           (if (null *referent*)
             :abort-edge
             *referent* )))))))

(defun walk-through-referent-actions  (rule-field 
                                       left-referent right-referent 
                                       right-edge)
  ;; Subroutine of referent-from-rule -- able to adjust what happens
  ;; in the succession of rule actions
  (declare (special *referent*))
  (when (and (assq :head rule-field)
             (assq :binding rule-field))
    ;; combine them. 
    (let* ((copy-of-rule-field (copy-list rule-field))
           (head-entry (cadr (assq :head copy-of-rule-field)))
           (binding-entry (cadr (assq :binding copy-of-rule-field)))
           new-rule-field  )
      (do* ((expression (car rule-field) (car rest))
            (keyword (car expression) (car expression))
            (value (cadr expression) (cadr expression))
            (rest (cdr rule-field) (cdr rest)))
          ((null keyword))
        (unless (or (eq keyword :head)
                    (eq keyword :binding))
          (push value new-rule-field)
          (push keyword new-rule-field)))

      (let ((composite `(:head-and-bindings ,head-entry ,binding-entry)))
        (if new-rule-field ;; some were left
          (setq new-rule-field (cons composite new-rule-field))
          (setq new-rule-field (list composite)))
        ;;(push-debug `(,new-rule-field ,rule-field)) (break " new rule field"))
        (setq rule-field new-rule-field))))

  (setq *referent* 
        (dispatch-on-rule-field-keys
         (first rule-field)
         left-referent right-referent right-edge))
  (let ( evolved-result )
    (dolist (ref-action (rest rule-field))
      (setq evolved-result
            (dispatch-on-rule-field-keys
             ref-action left-referent right-referent right-edge)))
    (when (typecase evolved-result
            (individual t)
            (referential-category t)
            (mixin-category t)
            (category t)
            (otherwise nil))
      (setq *referent* evolved-result))))



;;;------------------------------
;;; utility for mentions in tuck
;;;------------------------------

(defparameter *show-referent-for-edge-gaps* nil)

(defun referent-for-edge (edge)
  "Used by reinterpret-dominating-edges to reapply the rule
   that created the edge. Presently we can't always do
   it because :long-span edges often don't have a record
   of their constituents and we've not set up DA rules
   to facilitate this. Returns the new referent of the
   edge."
  (cond ((and (symbolp (edge-rule edge))
              (eq :long-span (edge-right-daughter edge)))
         ;; Not enough information to reapply the rule
         (when *show-referent-for-edge-gaps*
           (format t "~% referent-for-edge appplied to a da-rule ~
                      edge ~s~% with rule ~s and constituents ~s~%"
                   edge (edge-rule edge) (edge-constituents edge)))
         (edge-referent edge))
        
        ((eq :long-span (edge-right-daughter edge))
         (when *show-referent-for-edge-gaps*
           (format t "~% referent-for-edge appplied to a da-rule ~
                      edge ~s~% with rule ~s and constituents ~s~%"
                   edge (edge-rule edge) (edge-constituents edge)))
         (edge-referent edge))
        
        ((lambda-abstraction-edge? edge)
         (apply-lambda-abstraction
          (edge-referent edge) ;; the *lambda-abstraction* edge
          ;; the underlying edge whose interpretation may 
          (edge-referent (edge-left-daughter edge))
          edge))
        
        (t
         (let ((*current-chunk* 'dummy-chunk))
           ;; To fake out NP chunk rules that check to see that
           ;; they are in a chunk e.g. funtion verb-noun-coumpount
           (referent-from-rule
            (edge-left-daughter edge)
            (edge-right-daughter edge)
            edge
            (edge-rule edge))))))
   
(defun lambda-abstraction-edge? (edge)
  (declare (special category::lambda-form))
  (and (eq (edge-right-daughter edge) :single-term)
       (eq (edge-form edge) category::lambda-form)))

(defun apply-lambda-abstraction (old-lambda-pred new-pred-form edge)
  (declare (special **lambda-var**))
  (let* ((lambda-variable
          (loop for b in (indiv-binds old-lambda-pred)
                when (eq **lambda-var** (binding-value b))
                do (return (binding-variable b))))
         (new-lambda-form
          (when lambda-variable
            (create-predication-by-binding-only
             lambda-variable ;; var parameter
             **lambda-var**  ;; val
             new-pred-form   ;; pred
             ))))
    new-lambda-form))


;;;---------------------------------
;;; syntactic sugar for the globals
;;;---------------------------------

(defun left-edge-for-referent ()
  (or *left-edge-into-reference*
      (error "Left edge isn't bound now")))

(defun right-edge-for-referent ()
  (or *right-edge-into-reference*
      (error "Right edge isn't bound now")))

(defun parent-edge-for-referent ()
  (when (deactivated? *parent-edge-getting-reference*)
    (lsp-break "parent-edge-for-referent is ~s~%" *parent-edge-getting-reference*))
  (or *parent-edge-getting-reference*
      (error "*parent-edge-getting-reference* isn't bound now")))

(defun rule-being-interpreted ()
  (or *rule-being-interpreted*
      (error "*rule-being-interpreted* isn't bound now")))

#| Example from wh-initial-three-edges, which operates outside
of the context of applying a specific rules, and therefore not
in the scope of referent-from-rule.
    (with-referent-edges (:l (second edges) :r (third edges))
      (setq stmt (add-tense/aspect-info-to-head aux stmt)))  |#
(defmacro with-referent-edges (bindings &body body)
  (let ((left (cadr (memq :l bindings)))
        (right (cadr (memq :r bindings)))
        (parent (cadr (memq :p bindings))))
    `(let ((*left-edge-into-reference* ,left)
           (*right-edge-into-reference* ,right)
           (*parent-edge-getting-reference* ,parent))
       (declare (special *left-edge-into-reference*
                         *right-edge-into-reference*
                         *parent-edge-getting-reference*))
       ,@body)))


(defun pair-context ()
  "Convenient routine to use in traces and while debugging"
  (let ((left (left-edge-for-referent))
        (right (right-edge-for-referent)))
    (when (and left right)
      (format nil "e~a + e~a"
              (edge-position-in-resource-array left)
              (edge-position-in-resource-array right)))))


;;;--------------------------
;;; operating over the edges
;;;--------------------------

(defparameter *warn-on-unbound-parent-edge* nil)

(defun revise-parent-edge (&key category form referent)
  (if (and *parent-edge-getting-reference*
           (not (deactivated? *parent-edge-getting-reference*)))
      (let ((edge (parent-edge-for-referent)))
        (revise-edge edge category form referent))
      (when *warn-on-unbound-parent-edge*
        (warn "revise-parent-edge called when *parent-edge-getting-reference* ~
           is inactive or not bound -- possibly in da-rule"))))

(defun revise-left-edge-into-rule (&key category form referent)
  (let ((edge (left-edge-for-referent)))
    (revise-edge edge category form referent)))

(defun revise-right-edge-into-rule (&key category form referent)
  (let ((edge (right-edge-for-referent)))
    (revise-edge edge category form referent)))

(defun revise-edge (edge category form referent)
  (when category
    (setf (edge-category edge) category))
  (when form
    (setf (edge-form edge) form))
  (when referent
    (set-edge-referent edge referent))
  edge)



;;;-------------------------
;;; redistributing bindings
;;;-------------------------

(def-k-function redistribute (left-referent right-referent)
  ;; or should it be head and arg ??
  (:documentation "Provides a mechanism for part of the referent of
    one edge (i.e. one or more bindings) to be transfered to the
    referent of the other edge.")
  (:method (left right)
    (declare (ignore left right))))
