;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 2011-2016 David D. McDonald  -- all rights reserved
;;;
;;;      File:   "ref-method"
;;;    Module:   "analyzers;psp:referent:"
;;;   Version:   April 2016

;; created 9/1/11. 10/3 Adapting to getting categories as arguments, e.g.
;; in the case of prepositions. 11/8/12 Adjusted argument order to match
;; order in the rule. 1/18/13 Removed the block from *grok* so it would
;; actually run. Cleaned up. 7/1/13 Added def-k-method as syntactic sugar
;; to hide the uglyness. 7/21/13 Refactored to set a method-setup that
;; can be used independently of referent specifications and moved them
;; out to the rest of that machinery. 8/22/13 Put in a check so methods
;; aren't applied to words. 5/30/14 Added a trace. Pulled the constraint
;; that neigher referent can be a word.

(in-package :sparser)

;;;---------------------------------------
;;; Call from dispatch-on-rule-field-keys
;;;---------------------------------------

(defun ref/method (rule-field left-referent right-referent)
  (declare (special *shadows-to-individuals*))

  (cond
    (*clos* ;; flag controling whether we construct methods

     ;; Assuming two-argument binary rules for now
     (unless (= 3 (length rule-field))
       (error "Method calls restricted to two arguments.~
         ~%%This is different:~%   ~a" rule-field))
    
     (let ((method (car rule-field)))
       (tr :calling-method method)
       (setup-args-and-call-k-method 
           left-referent right-referent
         (let ((referent
                ;; Have to get the order of arguments correct
                (cond
                  ((equal (cdr rule-field) '(left-referent right-referent))
                   (funcall method left-shadow right-shadow))
                  ((equal (cdr rule-field) '(right-referent left-referent))
                   (funcall method right-shadow left-shadow))
                  (t (push-debug `(,rule-field))
                     (error "Unanticipated layout of the rule field ~
                            in a method call:~%  ~a" (cdr rule-field))))))
           referent))))
    (t
     ;; If we can't apply the method we still have to provide
     ;; a referent. Most of these are right headed, so if we're
     ;; going to ignore one of the arguments, this seems best.
     right-referent)))

