;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1992-1994,2016-2017 David D. McDonald  -- all rights reserved
;;;
;;;     File:  "initials"
;;;   Module:  "model;core:names:"
;;;  version:  August 2017 

;; 2.0 (11/10/92 v2.3)  Flushed the original and put in new semantics 
;;       version.
;; 4/20/16 Added handle-period-as-initial hack

(in-package :sparser)


;;;--------------
;;; the category
;;;--------------

(define-category initial
  :instantiates self
  :specializes  name
  :binds ((word :primitive word))  ;; /////// should inherit !!!!
  :index (:key word :permanent))
 



;;;---------------------------
;;; function to make them all
;;;---------------------------

(defun make-an-initial (string)
  (let ((word (resolve-string-to-word/make string)))
    (or (find-individual 'initial  :word word)
        (define-individual 'initial
          :word word))))

;;;-------
;;; cases
;;;-------

(mapc #'make-an-initial 
      '("A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M"
        "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z"))


#|----------------------------------- move these !!!!!!!!!!
;;;------------------------------
;;; abbreviations of first names
;;;------------------------------

(def-cfr "William" ("Wm."))
(def-cfr "George"  ("Geo."))       |#

(defun handle-period-as-initial (pos-before)
  "Called from period-hook in the case where it's determined
   that the period is not marking end of sentence."
  ;;/// This is for species names like "M. tuberculosis".
  ;; It would be better to make initials actually run,
  ;; but that doesn't look possible in a R3 configuration.
  ;; The position parameter is the one holding the period
  (declare (special category::single-capitalized-letter))
  (let* ((prior-pos (chart-position-before pos-before))
         (prior-word (pos-terminal prior-pos))
         (prior-caps (pos-capitalization prior-pos))
         (prior-edge (left-treetop-at/only-edges pos-before)))
    (when (or prior-edge ;; vs. a word
              (eq prior-caps :single-capitalized-letter))
      (unless prior-edge
        ;; In successive-sweeps, we'll encounter periods we'd like
        ;; to fold into initials before we introduce the edge
        ;; over single capitalized letters.
        (install-terminal-edges prior-word prior-pos pos-before) ;; returned nil ??///
        (let* ((edges (preterminal-edges prior-pos))
               (single-caps-edge
                (or
                 (find category::single-capitalized-letter edges
                       :key #'edge-category)
                 (find category::greek-letter edges :key #'edge-category))))
          (declare (special edges))
          (unless single-caps-edge
            (lsp-break "No caps in on ~a~%among ~a" prior-pos edges))
          (setq prior-edge single-caps-edge)))

      (when (eq (edge-category prior-edge)
                category::single-capitalized-letter)
        ;; adapted from grammar/rules/FSAs/initials.lisp
        ;; except that this isn't making an initials object.
        ;; Uses the capitalized letter as the referent.
        (let ((edge
               (make-chart-edge
                :starting-position (chart-position-before pos-before)
                :ending-position (chart-position-after pos-before)
                :left-daughter prior-edge
                :right-daughter (pos-terminal pos-before)
                :category (category-named 'initial)
                :form     (category-named 'proper-noun)
                :rule-name  :handle-period-as-initial
                :referent  (edge-referent prior-edge))))
          (tr :initial-made-edge edge)
          edge)))))
