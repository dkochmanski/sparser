;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 2013-2014 David D. McDonald  -- all rights reserved
;;; Copyright (c) 2007 BBNT Solutions LLC. All Rights Reserved
;;;
;;;     File:  "driver"
;;;   Module:  "analysers;psp:patterns:"
;;;  version:  1.0 November 2014

;; Broken out from driver 2/5/13. This code was developed with some
;; difficulty and confusion for the JTC/TRS project. Throwing out most
;; of it and reconstruing these results as names. 
;; 0.4 2/25/14 Modified to retain the interior punctuation.
;; 0.5 7/28/14 Turned parse-between-boundaries back on for "Ser1507"
;;     8/7/14 Debugged edge case (EOS) in sentence-final-punctuation-pattern?
;; 0.6 9/9/14 refactoring to make management simpler.
;; 0.7 10/9/14 Added scare quotes, debugged edge cases. 
;; 1.0 11/18/14 Bumped number to permit major revamp to fit into multi-
;;   pass scanning. 

(in-package :sparser)

;;;----------------
;;; gating globals
;;;----------------

(unless (boundp '*uniformly-scan-all-no-space-token-sequences*)
  (defparameter *uniformly-scan-all-no-space-token-sequences* nil
    "Gates this simpler alternative / complement to the pattern-driven
    scheme. Sort of a generic 'super' tokenizer"))

(unless (boundp '*parser-interior-of-no-space-token-sequence*)
  (defparameter *parser-interior-of-no-space-token-sequence* nil
    "Controls whether we try to parse the edges of the words
     inside the span."))
   

;;;---------------------------------------------------
;;; entry point from check-for/initiate-scan-patterns
;;;---------------------------------------------------

;; (trace-ns-sequences)

(defun collect-no-space-sequence-into-word (position)
  ;; called from check-for/initiate-scan-patterns when the gate is true
  ;; and no pattern-driven scan applied.
  (declare (special *source-exhausted* *source-start*))

  (when (= (pos-token-index position) 1) ;; spurious: source-start
    (return-from collect-no-space-sequence-into-word nil))

  (tr :no-space-sequence-started-at (chart-position-before position))
  ;; There is no space recorded on this position, so the word just
  ;; before it and the word on it have no whitespace between them
  (let* ((pos-before (chart-position-before position))
	 (word-before (pos-terminal pos-before))
	 (word-after (pos-terminal position))
	 (next-position (chart-position-after position))
         pattern  hyphen?  slash?  )

    (when (first-word-is-bracket-punct word-before) ;; ( [ { <
      (tr :ns-first-word-is-bracket-punct word-before position)
      (return-from collect-no-space-sequence-into-word
	nil))

    (unless word-after
      (if (null (pos-assessed? position))
	(then
	  (scan-next-position)
	  (setq word-after (pos-terminal position)))
        (else
         (push-debug `(,position))
         (break "NS -- new assessment case. position = ~a" position))))
    (tr :ns-considering-sequence-starting-with word-before word-after)

    (unless (has-been-status? ::preterminals-installed position)
      ;; pos-before = p2 (serine)
      ;; position = p3 (107)
      ;; unlikely, but better safe than sorry
      ;;//// test on something that would parse and has 3+ words
      (tr :ns-installing-terminal-edges word-after)
      (install-terminal-edges word-after position next-position))

    (when (second-word-not-in-ns-sequence word-after next-position)
      ;; e.g. sentence punctuation or EOS
      (tr :ns-second-word-not-in-ns-sequence word-after)
      (return-from collect-no-space-sequence-into-word
	nil))
    
    (when (first-or-second-word-is-bracket-punct word-before word-after)
      (tr :first-or-second-is-bracket-punct word-before word-after)
      (return-from collect-no-space-sequence-into-word
	nil))


    (when (eq word-before *the-punctuation-hyphen*)
      (push pos-before hyphen?))
    (when (eq word-before (punctuation-named #\/))
      (push pos-before slash?))
    (push (characterize-word-type pos-before word-before) pattern)

    (when (eq word-after *the-punctuation-hyphen*)
      (push position hyphen?))
    (when (eq word-after (punctuation-named #\/))
      (push position slash?))
    (push (characterize-word-type position word-after) pattern)

    ;; The first two words were just collected. 
    ;; This loop collects the rest.
    (let ((words `(,word-after ,word-before))) ;; n.b. reversed
      (setq position next-position)
      (loop
        (unless (pos-terminal next-position)
          (scan-next-position)
          (tr :ns-scanned-word (pos-terminal next-position)))

        (when (pos-preceding-whitespace next-position)
          (tr :ns-whitespace next-position)
          (return)) ;; we're done
          
        (let ((word (pos-terminal next-position)))
          (when (punctuation? word)
            (tr :ns-scanned-punctuation word)
            (cond
             ((eq word *the-punctuation-hyphen*)
              (push next-position hyphen?))
             ((eq word (punctuation-named #\/))
              (push next-position slash?))            
             (t
              (when (punctuation-terminates-no-space-sequence
                     word next-position)
                (tr :ns-terminating-punctuation word)
                (return)))))
             
          (push word words) ;(break "pos of word")
          (push (characterize-word-type position word) pattern)
          (tr :ns-adding-word word)

          (unless (has-been-status? ::preterminals-installed position)
            (tr :ns-installing-terminal-edges word)
            (install-terminal-edges word next-position
                                    (chart-position-after next-position)))
            
          (setq position next-position
                next-position (chart-position-after next-position))
            
          (when (eq (pos-terminal next-position)
                    *end-of-source*)
            (tr :ns-reached-eos-at next-position)
            (return))))

      ;; remove terminal punctuation, unless it's a hyphen
      (when (eq (pos-capitalization position) :punctuation)
        (unless (eq (pos-terminal position) *the-punctuation-hyphen*)
          (pop words)))

      (setq words (nreverse words))

      (post-accumulator-ns-handler
       words (nreverse pattern) pos-before next-position hyphen? slash?)

      (tr :ns-returning-position next-position)
      next-position)))


(defun post-accumulator-ns-handler (words pattern
                                    pos-before next-position
                                    hyphen? slash?)
  (or (resolve-ns-pattern pattern words pos-before next-position)

      (let ((layout
             (when *parser-interior-of-no-space-token-sequence*
               (tr :ns-parsing-between pos-before next-position)
               (parse-between-boundaries pos-before next-position))))
        (tr :ns-layout layout)
        ;;(push-debug `(,words ,pos-before ,next-position)) (break "layout = ~a" layout)
        ;; (setq words (car *) pos-before (cadr *) next-position (caddr *))
        ;; (print-flat-forest t pos-before next-position)

        (cond
         ((eq layout :single-span)) ;; Do nothing. It's already known
         ((eq layout :span-is-longer-than-segment)
          (error "no-space-sequence: bad positions somehow.~
                ~%   Parsed span goes beyond presumed boundaries.~
                ~%   start = ~a  end = ~a" pos-before next-position))
         ((and hyphen? slash?)
          (nospace-slash-and-hyphen-specialist 
           hyphen? slash? pos-before next-position))
         (hyphen?
          (nospace-hyphen-specialist hyphen? pos-before next-position))
         (slash?
          (nospace-slash-specialist slash? pos-before next-position))
         (t 
          ;; The cleanest conceptualization of things like M1A1 or
          ;; H1N1 is that they are names. So we take the words that
          ;; we've collected and make them the elemeents of the
          ;; sequence that defines the name, and we make the
          ;; corresponding egdge, reifying the identity of the name
          ;; in the model qua name, we would know what it names
          ;; if we understand the context.
          (reify-ns-name-and-make-edge words pos-before next-position))))))


;; New scheme
(defun reify-ns-name-and-make-edge (words pos-before next-position)
  ;; We make an instance of a spelled name with the words as its sequence.
  ;; We make a rule that treats the pnames of the words as a polyword,
  ;; and we make a category for that rule with that same spelling,
  ;; form is 'proper-name'.  Something makes me think this could
  ;; be problem down the line, but we can deal with it when it emerges.
  (multiple-value-bind (category rule referent)
                       (if *big-mechanism*
                         (reify-ns-name-as-bio-entity 
                          words pos-before next-position)
                         (reify-spelled-name words))
      (let ((edge
             (make-edge-over-long-span
              pos-before
              next-position
              category
              :rule rule
              :form (category-named 'proper-name)
              :referent referent
              :words words)))
        edge)))



;;;------------------------------------------------
;;; recognizing patterns in the character sequence
;;;------------------------------------------------

(defun characterize-word-type (position word)
  ;; return a indicator read by resolve-ns-pattern to identify
  ;; a general pattern with an established interpretation. 
  (let* ((caps (pos-capitalization position))
         (start-ev (pos-starts-here position))
         (top-edge (ev-top-node start-ev)))
    ;;(break "For ~s caps = ~a, top-edge = ~a" (word-pname word) caps top-edge)
    (case caps
      (:digits
       (if (= 1 (length (word-pname word)))
        :single-digit
        :digits))
      (:initial-letter-capitalized
      :capitalized) ;; "Gly", "Ras"
      (:single-capitalized-letter
       :single-cap)
      (:all-caps
       :full)
      (:mixed-case
       :mixed ) ;;(characterize-type-for-mixed-case word))
      (:lower-case
       :lower)
      (:punctuation
       (keyword-for-word word))
      (otherwise (break "~a is a new case to characterize for p~a and ~s~
                       ~%under ~a"
                        caps
                        (pos-token-index position) 
                        (word-pname word)
                        top-edge)))))
;;/// move
(defun keyword-for-word (word)
  (let ((symbol-in-word-package (word-symbol word)))
    (intern (symbol-name symbol-in-word-package)
            (find-package :keyword))))

(defparameter *work-on-ns-patterns* nil
  "Forces resolve-ns-pattern to return nil rather than complain
   that it's got an uncharacterized pattern.")
;; "the TGF-b pathway"  "PLX4032"
;; "MEK1 (also known as MAP2K1)"
;; "the Bcl-2/Bcl-xL proteins"  "SHOC2/Sur-8"
;; "EGFR-positive cells (EGFRhi)" "EGFR-hi"
;; "regulatory factors, such as IL-1a"
;; "BRAF(V600E)" "short hairpin RNA (shRNA)" "region Y-box 10 (SOX10)"
(defun resolve-ns-pattern (pattern words pos-before next-position)
  (push-debug `(,pattern ,words)) ;; (break "resolve pattern")
  (cond ;;/// turn into a macro, or interpret a structured list / structure
   ((equal pattern '(:full :single-digit)) ;; AF6
    (reify-ns-name-and-make-edge words pos-before next-position))
   (*work-on-ns-patterns*
    (push-debug `(,pattern ,words))
    (break "New pattern to resolve: ~a" pattern))
   (t nil))) ;; fall through



(defun characterize-type-for-mixed-case (word)
  (let* ((pname (word-pname word))
         (length (length pname))
         ends-in-s?    )
    (setq ends-in-s?
          (eql #\s (aref pname (1- length))))

    (when ends-in-s?
      ;; is the remainder a known word?
      )))

          


;;;-----------------------------------------
;;; reasons to abort or get out of the loop
;;;-----------------------------------------

(defun second-word-not-in-ns-sequence (word next-position)
  (declare (special *the-punctuation-period* *the-punctuation-colon*))
  (when (punctuation? word)
    (cond
      ((or (eq word *the-punctuation-period*)
	   (eq word (punctuation-named #\,))
	   (eq word *the-punctuation-colon*)
	   (eq word (punctuation-named #\;)))
       ;; more general than "." probably, but this is the canonical
       ;; case
       (unless (pos-terminal next-position)
	 (scan-next-position))
       (or (eq (pos-terminal next-position) *end-of-source*)
	   (pos-preceding-whitespace next-position)))
;;      ((eq word (punctuation-named #\/)) ;; cascades in signal pathways
;;       t)
      (t nil))))
      

(defun punctuation-terminates-no-space-sequence (word position)
  (declare (special *the-punctuation-period* *the-punctuation-colon*))
  (cond
    ((or (eq word *the-punctuation-period*)
	 (eq word (punctuation-named #\,))
	 (eq word (punctuation-named #\;))
	 (eq word *the-punctuation-colon*))
     ;; if there's a space after this character, we assume that
     ;; it's punctuation, otherwise it's part of the compound
     ;; terminal.
     (sentence-final-punctuation-pattern?
      (chart-position-after position)))
    ((or (eq word  (punctuation-named #\-))
	 (eq word (punctuation-named #\/))
         (eq word  (punctuation-named #\@)))
     nil)
    (t t)))


(defun sentence-final-punctuation-pattern? (position)
  (declare (special *source-exhausted*))
  (unless (pos-terminal position)
    (scan-next-position))
  (cond
   (*source-exhausted* t)
   ((eq (pos-terminal position) *end-of-source*) t)
   (t
    (let ((pos-after (chart-position-after position)))
      (unless (pos-terminal pos-after)
        (scan-next-position))
      (if (or (no-space-before-word? pos-after) ;; e.g. a URL
	      (not *source-exhausted*))
	  nil
	  t)))))


(defun first-word-is-bracket-punct (word1)
  (or (eq word1 (punctuation-named #\( ))
      (eq word1 (punctuation-named #\[ ))
      (eq word1 (punctuation-named #\{ ))
      (eq word1 (punctuation-named #\< ))

      (eq word1 (punctuation-named #\) ))
      (eq word1 (punctuation-named #\] ))
      (eq word1 (punctuation-named #\} ))
      (eq word1 (punctuation-named #\> ))))
      

(defun first-or-second-word-is-bracket-punct (word1 word2)
  (or (eq word1 (punctuation-named #\( ))
      (eq word1 (punctuation-named #\[ ))
      (eq word1 (punctuation-named #\{ ))
      (eq word1 (punctuation-named #\< ))
      
      (eq word1 (punctuation-named #\) ))
      (eq word1 (punctuation-named #\] ))
      (eq word1 (punctuation-named #\} ))
      (eq word1 (punctuation-named #\> ))

      (eq word2 (punctuation-named #\( ))
      (eq word2 (punctuation-named #\[ ))
      (eq word2 (punctuation-named #\{ ))
      (eq word2 (punctuation-named #\< ))

      (eq word2 (punctuation-named #\) ))
      (eq word2 (punctuation-named #\] ))
      (eq word2 (punctuation-named #\} ))
      (eq word2 (punctuation-named #\> ))

      ;; 10/7/14 slashes have dedicated treatment
      ;;(eq word1 (punctuation-named #\/ ))
      ;;(eq word2 (punctuation-named #\/ ))
      ))



;;;----------
;;; go-fer's
;;;----------

;; These are more of an flet style, but the caller is hard enough
;; to read already.

(defun polyword-ends-here (position)
  (let* ((ev (pos-ends-here position))
	 (top-edge (ev-top-node ev)))
    (when (and top-edge
	       (edge-p top-edge)) ;; vs. :multiple-initial-edges
      (when (polyword-p (edge-category top-edge))
	top-edge))))

(defun edge-ends-here (position)
  (let* ((ev (pos-ends-here position))
	 (top-edge (ev-top-node ev)))
    (when (and top-edge
	       (edge-p top-edge)) 
      top-edge)))

(defun move-ns-start-before-leading-pw (position)
  ;; return a position that backs away from the given position by 
  ;; length of the polyword
  (let ((edge (polyword-ends-here position)))
    (unless edge
      (break "Expected to have a pw edge end at ~a" position))
    (values (ev-position (edge-starts-at edge))
	    (edge-category edge))))

(defun move-ns-start-before-leading-edge (position)
  ;; return a position that backs away from the given position by 
  ;; length of the polyword
  (let ((edge (edge-ends-here position)))
    (unless edge
      (break "Expected to have an edge end at ~a" position))
    (values (ev-position (edge-starts-at edge))
	    edge)))

