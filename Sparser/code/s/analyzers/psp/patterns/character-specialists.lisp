;;;-*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 2014 David D. McDonald  -- all rights reserved
;;; 
;;;     File:  "character-specialists"
;;;   Module:  "analysers;psp:patterns:"
;;;  version:  September 2014

;; Initiated 9/9/14 to hold specialists dispatched from the no-space
;; scan 

(in-package :sparser)

;;;----------
;;; hyphens
;;;----------

(defun nospace-hyphen-specialist (hyphen-position/s pos-before next-position)
  (push-debug `(,hyphen-position/s ,pos-before ,next-position))
  ;; (setq hyphen-position/s (car *) pos-before (cadr *) next-position (caddr *))
  (let ((hyphen-count (length hyphen-position/s))
        (phrase-length (- (pos-token-index next-position)
                          (pos-token-index pos-before))))
    (cond
     ((and (= hyphen-count 1)
           (= phrase-length 3))
      (let* ((hyphen-pos (car hyphen-position/s))
             (left-edge (left-treetop-at/edge hyphen-pos))
             (right-edge (right-treetop-at/edge
                          (chart-position-after hyphen-pos))))
        (let ((rule
               (or
                ;; Can we look and know which edge -should- be the
                ;; head? If we just assume its the right-edge and
                ;; the left-edge is the theme then we will prefer
                ;; a direct-object reading:
                (multiply-edges right-edge left-edge)
                ;; but it that doesn't work lets try the other order
                ;; just to get something (as better than nothing)
                (multiply-edges left-edge right-edge))))
          (if rule
            (make-completed-binary-edge left-edge right-edge rule)
            (else ;; make a structure if all else fails
             ;; but first alert to anticipated cases not working
             (make-hypenated-structure left-edge right-edge))))))
     (t
      (break "New case for hyphens~%  hyphen count = ~a~
            ~%  phrase-length = " hyphen-count phrase-length)))))



;;;---------
;;; slashes
;;;---------

(defun nospace-slash-specialist (slash-position/s pos-before next-position)
  (when (cdr slash-position/s)
    (push-debug `(,slash-position/s ,pos-before ,next-position))
    (break "stub: more than one slash"))
  (let ((left-edge (right-treetop-at/edge pos-before))
        (right-edge (left-treetop-at next-position)))
    (let ((i (find-or-make-individual 'slashed-pair
               :left (edge-referent left-edge)
               :right (edge-referent right-edge))))
      (when (eq (edge-category left-edge)
                (edge-category right-edge))
        (bind-variable 'type (edge-category left-edge)
                       i category::sequence))
      (let ((edge (make-edge-over-long-span
                   pos-before
                   next-position
                   category::slashed-pair
                   :rule 'nospace-slash-specialist
                   :form category::common-noun
                   :referent i
                   :constituents `(,left-edge ,right-edge))))
        ;;(break "look at edge")
        ;;/// trace goe here
        edge))))


;;;-----------------------
;;; single 'scare' quotes
;;;-----------------------

(defun scare-quote-specialist (leading-quote-pos words pos-before next-position)
  ;; It's reasonably clear what to do with scare quotes. At a minimum we move
  ;; the boundaries of the edge over word being quoted so it swallows the
  ;; single quote marks. Better than that would be recording the rhetorical
  ;; effect of do in this (which I don't know how to do). If the layout
  ;; is something different than that we just leave it for a debris collector
  (push-debug `(,leading-quote-pos ,words ,pos-before ,next-position))
  (when (and (eq leading-quote-pos pos-before)
             (eq (first words) (car (last words))))
    (when (= (length words) 3) ;; only one word
      (let* ((word-edge (left-treetop-at/only-edges next-position))
             (edge (make-edge-over-long-span
                    pos-before
                    (chart-position-after next-position)
                    (edge-category word-edge)
                    :rule 'scare-quote-specialist
                    :form (edge-form word-edge)
                    :referent (edge-referent word-edge)
                    :constituents words)))
        ;;/// trace goes here
        edge))))
              

