;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 2016 David D. McDonald  -- all rights reserved
;;; 
;;;     File:  "post-vg-hook"
;;;   Module:  "grammar;rules:syntax:"
;;;  Version:  August 2016

;; Initiated 8/9/16

(in-package :sparser)


;;;-----------------
;;;     hook
;;;-----------------

(define-segment-finished-action (vg vg+ing vg+ed vg+passive
                                 verb verb+s verb+present verb+past
                                 verb+passive modal)
    :vg-actions verb-group-final-actions)

(defun verb-group-final-actions (vg-edge)
  (when (memq (edge-form vg-edge) ;; see note on the global
              *plausible-vg-categories*)
    #+ignore(fold-in-preposed-auxiliary vg-edge)
    #+ignore(record-verb-tense vg-edge)
    (generalize-vg-segment-edge vg-edge)))


;;;---------------------------
;;; fold aux back into the vg
;;;---------------------------

(defun fold-in-preposed-auxiliary (vg-edge)
  (when (preposed-aux?)
    (multiple-value-bind (auxiliary aux-pos aux-form)
        (preposed-aux?)
      (push-debug `(,vg-edge ,auxiliary ,aux-pos ,aux-form))
      (lsp-break "fold the preposed aux ~a into ~a"
                 auxiliary vg-edge))))


;;;--------------
;;; record tense
;;;--------------

(defun record-verb-tense (vg-edge)
  "If the referent of this edge does not have a tense/aspect-vector
   individual already bound to its 'aspect variable, then look at
   this edge and its daughters, figure out the tense/aspect they
   imply, and give it one."
  (let ((i (edge-referent vg-edge)))
    (unless (value-of 'aspect i)
      (flet ((assign-tense (edge)
               (let ((tense (tense-implied-by-verb-edge edge))
                     (v (make-an-individual 'tense/aspect-vector)))
                 (ecase tense
                   (:present
                    (setq v (bind-variable 'present category::present v)))
                   (:past
                    (setq v (bind-variable 'past category::past v)))
                   (:progressive
                    (setq v (bind-variable 'progressive category::progressive v)))
                   (:perfect
                    (setq v (bind-variable 'perfect category::perfect v))))
                 (let ((new-i
                        (bind-variable 'aspect v i)))
                   (setf (edge-referent vg-edge) new-i)))))

      (let ((left (edge-left-daughter vg-edge))
            (right (edge-right-daughter vg-edge)))
        ;; If there's a left daughther then it is probably
        ;; carrying the tense -- "is phosphorylated" vs.
        ;; "was phorphylated". Otherwise it's either
        ;; here on the vp-edge or on the single daughter.
        ;; If the left daughter is also composite then
        ;; lets hope the syntax functions took care of it.
        ;;/// Note that there's an interaction with the
        ;; the 'category elevation' that happens in the
        ;; segment processing before we get to this point.
        ;; Which means it should be reviewed in light of all this.

        (cond
          ((keywordp right) ;; i.e. :single-term
           ;; there's no left edge
           (assign-tense vg-edge))

          ((and (edge-p left) (edge-p right))
           (if (memq (edge-form left) *plausible-vg-categories*)
             (assign-tense left) ;; "preferentially interact"
             (assign-tense right)))
          
          (t 
           (push-debug `(,left ,right))
           (lsp-break "new configuration of daughters ~
                       in vg that doesn't record tense: ~a"
                      vg-edge))))))))


(defun tense-implied-by-verb-edge (edge)
  "Given a word-level verb edge, what tense/aspect is implied
   by its form label?"
  (let ((form (edge-form edge)))
    (ecase (cat-symbol form)
      (category::verb :present) ;; can we rely on this?
      (category::verb+s :present)
      (category::verb+ed :perfect)
      (category::verb+ing :progressive)
      (category::verb+present :present)
      (category::verb+past :past)
      (category::verb+passive
       ;; doesn't make sense really, but giving it a value anyway
       :past)
      (category::vg+ed :past)
      (category::vg+ing :progressive))))


;;;-----------------------
;;; Maybe change the form
;;;-----------------------

(defun generalize-vg-segment-edge (vg-edge)
  "Elevates the form of the edge if necessary. In other configurations
   generalize-segment-edge-form-if-needed would have done this."
  (let* ((form-category (edge-form vg-edge))
         (form-symbol (when form-category (cat-symbol form-category))))
    (case form-symbol
      ;; unchanged
      (category::vp)
      (category::vg)
      (category::vg+ing)
      (category::vg+ed)
      (category::vp+ing)
      (category::vp+ed)
      (category::vg+passive)

      ;; changed
      ((category::verb 
        category::verb+s 
        category::verb+present
        category::verb+past
        category::verb+passive
        category::modal)
       (setf (edge-form vg-edge) category::vg))
      ((category::verb+ing)
       (setf (edge-form vg-edge) category::vg+ing))
      ((category::verb+ed)
       (setf (edge-form vg-edge) category::vg+ed)))))
