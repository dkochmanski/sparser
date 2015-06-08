;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 2014-2015  David D. McDonald  -- all rights reserved
;;;
;;;     File:  "pattern-gophers"
;;;   Module:  "analysers;psp:patterns:"
;;;  version:  May 2015

;; initiated 12/4/14 breaking out the patterns from uniform-scan1.
;; 4/15/15 modified resolve-hyphen-between-two-words to ignore syntax
;;  or form rules. 4/24/15 Debugged confustion in order of slash positions.
;; 5/15/15 Sited the handling of edges within patterns here for want of
;;  a better place. 
;; 5/30/2015 catch error caused by undefined words in resolve-hyphen-between-three-words before they get to make-hyphenated-triple

(in-package :sparser)

;;;----------------------------------------
;;; prebuilt-multiword edges w/in the span
;;;----------------------------------------

(defun ns-sort-out-pattern-with-edges (pattern start-pos end-pos edges words
                                       hyphen-positions slash-positions
                                       colon-positions other-punct)
  (push-debug `(,pattern ,start-pos ,end-pos ,edges ,hyphen-positions 
                ,slash-positions ,colon-positions ,other-punct))
  ;; "the RAS/Raf/MAPK pathway" Jan#41: (full forward-slash #<edge18 13 pathway 16>)
  (cond 
   ((= 1 (length edges))
    (let* ((edge-location (cond ((edge-p (car (last pattern))) :final)
                                ((edge-p (car pattern)) :initial)
                                (t :middle)))
           (remaining-pattern (case edge-location
                                (:final (nreverse (cdr (nreverse pattern))))
                                (:initial (cdr pattern))
                                (:middle 
                                 (loop for item in pattern
                                   unless (edge-p item) collect item))))
           (category (edge-category (car edges))))
      
      ;;//// Look for experts that can make useful sense of 
      ;; the rest of the pattern
      (cond
       ((and (eq edge-location :initial)
             (equal remaining-pattern '(:hyphen :lower)))
        (ns-sort-out-edge-hyphen-lower
         (car edges) start-pos end-pos words))
       (*work-on-ns-patterns*
        (push-debug `(,edge-location ,category ,remaining-pattern))
        (break "Work on one edge pattern"))
       (t
        (edge-that-punts-edge-inside-pattern words start-pos end-pos edges)))))
   (t
    (let ((remaining-pattern
           (loop for item in pattern
             unless (edge-p item) collect item)))
      (push-debug `(,remaining-pattern))
      (if *work-on-ns-patterns*
        (break "~a edges in ns pattern" (length edges))
        (edge-that-punts-edge-inside-pattern words start-pos end-pos edges))))))

(defun edge-that-punts-edge-inside-pattern (words start-pos end-pos edges)
  (let ((edge (make-edge-over-long-span
               start-pos
               end-pos
               (edge-category (car edges)) 
               :rule 'edge-that-punts-edge-inside-pattern
               :form (edge-form (car edges))
               :referent (edge-referent (car edges))
               :constituents edges
               :words words)))
    ;;/// trace goes here
    edge))


;;;---------
;;; slashes
;;;---------

(defun resolve-slash-pattern (pattern words 
                              slash-positions hyphen-positions 
                              pos-before pos-after)
  (if (null (cdr slash-positions)) ;; only one
    (one-slash-ns-patterns
     pattern words slash-positions hyphen-positions pos-before pos-after)
    (divide-and-recombine-ns-pattern-with-slash 
     pattern words slash-positions hyphen-positions pos-before pos-after)))

(defun one-slash-ns-patterns (pattern words 
                              slash-positions hyphen-positions 
                              pos-before pos-after)
  (if hyphen-positions
    (divide-and-recombine-ns-pattern-with-slash 
     pattern words slash-positions hyphen-positions pos-before pos-after)
    (cond
     ((equal pattern '(:lower :forward-slash :lower))
      (or (reify-amino-acid-pair words pos-before pos-after)
          (reify-ns-name-and-make-edge words pos-before pos-after)))

     ((equal pattern '(:mixed :digits :forward-slash :capitalized :digits))
      ;; recombinant COT induced pThr202/Tyr204 phosphorylation of ERK1 
      ;; in December #46
      ;; split on the single slash, look up the parts.
      ;; simpler than the multi-slash case.
      (when *work-on-ns-patterns*
        (break "finish pThr202/Tyr204")))

     ((equal pattern '(:full :forward-slash :full))
      (resolve-hyphen-between-two-terms pattern words pos-before pos-after))

     (*work-on-ns-patterns* 
      (push-debug `(,pattern ,pos-before ,pos-after))
      (break "New slash pattern to resolve: ~a" pattern))
     (t (tr :no-ns-pattern-matched) 
        nil))))


;; (p "the Raf/MEK/ERK pathway.") 
;;  (p "For example, SHOC2/Sur-8 bridges.")
;; "PI3K/AKT signaling"
(defun divide-and-recombine-ns-pattern-with-slash (pattern words 
                                                   slash-positions hyphen-positions 
                                                   pos-before pos-after)
  ;; Assumes that slash has precedence over any other punctuation,
  ;; so it does a resolve-pattern of each of the segements between
  ;; slashes and then recombines them into a slash-structure along the
  ;; lines of make-hyphenated-structure and such.
  ;;//// slashes often indicate two proteins that differ in just
  ;; their suffix. What's that pattern?
  ;; At this point the terminals are covered by edges. They probably
  ;; have what we want. A second time around they certainly will.

  (push-debug `(,slash-positions ,pos-before ,pos-after ,words ,pattern))
  ;; (setq slash-positions (car *) pos-before (cadr *) pos-after (caddr *) words (cadddr *) pattern (nth 4 *))
  (tr :slash-ns-pattern pos-before pos-after)
  (when *trace-ns-sequences* (tts))

  (setq slash-positions (nreverse slash-positions)) ;;(break "slash-position = ~a" slash-positions)

  (cond 
   ((eq (first slash-positions) pos-before)
    (when *work-on-ns-patterns*
      (error "New case: Slash is initial term in no-space region between p~a and p~a"
             (pos-token-index pos-before) (pos-token-index pos-after))))

   ((eq (car (last pattern)) :forward-slash) ;; it's final
    ;; and it's probably a mistake in the source: "c-Raf/ MAPK-mediated [6]."
    (cond
     ((not (= 1 (length slash-positions)))
      (when *work-on-ns-patterns*
        (error "New case: more than one slash in a slash-final pattern")))
     (t
      (let* ((pos-after-minus-1 (chart-position-before pos-after))
             ;; 1st do the check that would have been done w/o the slash
             (edge? (span-covered-by-one-edge? pos-before pos-after-minus-1)))
        (or edge?
            (else
              ;;/// I can't think of a meaningfull version of this pattern so
              ;; dropping the slash on the floor and shrinking the pattern to let
              ;; the ordinary hyphen-handler do it's thing
              (setq pattern (nreverse (cdr (nreverse pattern)))
                    words (nreverse (cdr (nreverse words))))
              (resolve-hyphen-pattern pattern words hyphen-positions 
                                      pos-before pos-after-minus-1)))))))

   (t ;; slash(s) somewhere in the middle   
    (let* ((segment-start pos-before)
           segment-pattern  segments  remainder )
    (multiple-value-setq (segment-pattern remainder)
      (pop-up-to-slash pattern))
    (dolist (slash-pos slash-positions)
      (let ((resolution (resolve-slash-segment 
                         segment-pattern hyphen-positions segment-start slash-pos)))
        (unless resolution
          (push-debug `(,segment-pattern ,segment-start ,slash-pos))
          (error "pattern resolver called by slash returned nil ~
                  on ~a" segment-pattern))
        (push resolution segments)
        (setq segment-start (chart-position-after slash-pos))
        (multiple-value-setq (segment-pattern remainder)
          (pop-up-to-slash remainder))))
      (push (resolve-slash-segment segment-pattern hyphen-positions segment-start pos-after)
            segments)
      (package-slashed-sequence
       (nreverse segments) words pos-before pos-after)))))


(defun pop-up-to-slash (pattern)
  ;; Subroutine of divide-and-recombine-ns-pattern-with-slash but might
  ;; make a useful utility with a bit of abstraction
  (let ((slash-index (position :forward-slash pattern)))
    ;;(push-debug `(,pattern ,slash-index)) (break "index = ~a" slash-index)
    ;; (setq pattern (car *) slash-index (cadr *))
    (if slash-index
      (values (subseq pattern 0 slash-index)
              (subseq pattern (1+ slash-index)))
      (values pattern nil))))


(defun resolve-slash-segment (segment-pattern hyphen-positions start-pos end-pos)
  (tr :resolve-slash-segment segment-pattern start-pos end-pos)
  (let ((single-edge (span-covered-by-one-edge? start-pos end-pos)))
    ;; is there one edge between the start of this portion and
    ;; the position of the slash? Then we're done
    (cond
     (single-edge
      (tr :slash-segment-covered single-edge)
      single-edge)
     (t
      (tr :slash-recursive-resolution)
      (let ((words (words-between start-pos end-pos)))        
        (resolve-non-slash-ns-pattern 
         segment-pattern words hyphen-positions start-pos end-pos))))))

(defun resolve-non-slash-ns-pattern (pattern words hyphen-positions
                                     pos-before pos-after) 
  (tr :trying-to-resolve-ns-pattern pattern)
  (let ((relevant-hyphen-positions
         (when hyphen-positions 
           (loop for pos in hyphen-positions 
             when (position-is-between pos pos-before pos-after)
             collect pos))))
  
    (or (when relevant-hyphen-positions
          (resolve-hyphen-pattern 
           pattern words relevant-hyphen-positions pos-before pos-after))
        (resolve-ns-pattern pattern words pos-before pos-after)
        (reify-ns-name-and-make-edge words pos-before pos-after))))


;; endogenous C-RAF:B-RAF heterodimers
(defun divide-and-recombine-ns-pattern-with-colon (pattern words 
                                                   colon-positions hyphen-positions 
                                                   pos-before pos-after)
  (declare (ignore hyphen-positions colon-positions pattern))
  ;;(push-debug `(,hyphen-positions ,colon-positions ,pos-before ,pos-after ,words ,pattern))
  (let ((treetops (treetops-between pos-before pos-after)))
    (cond
     ((= (length treetops) 3)
      ;; nothing to do, there's already a parse of the consituents to either 
      ;; side of the colon
      (make-word-colon-word-structure (first treetops) (third treetops)))
     (*work-on-ns-patterns*
      (push-debug `(,treetops))
      (break "colon+hyphen stub: have to construct one of the constituents"))
     (t ;; bail
      (reify-ns-name-and-make-edge words pos-before pos-after)))))

;;;--------
;;; hyphen
;;;--------

(defun resolve-hyphen-between-two-words (pattern words
                                         pos-before pos-after)
  ;; Have to distinguish between anticipated cases where the edges would
  ;; compose except for the hypen between the words and cases 
  ;; like "Sur-8" where it's the name of a protein
  ;;(push-debug `(,pos-before ,pos-after ,pattern))
  (tr :resolve-hyphen-between-two-words words)
  (let ((left-edge (right-treetop-at/edge pos-before))
        (right-edge (left-treetop-at/edge pos-after)))
    ;; lifted from nospace-hyphen-specialist
    ;;(push-debug `(,left-edge ,right-edge)) ;;(break "???")
    (let* ((rule (or (multiply-edges left-edge right-edge)
                     (multiply-edges right-edge left-edge)))
           ;; We only want rules that create real relationships.
           ;; There will always be a syntactic rule, so that rules
           ;; out the possibility of looking for a salient literal
           ;; which would be Very Bad since they are informative.
           ;; Form rules are half generic, particularly for adjective
           ;; so I'm ruling those out too.
           (usable-rule (unless (syntactic-rule? rule)
                          (unless (form-rule? rule)
                            rule))))
      (cond
       (usable-rule ;; "GTP-bound"
        (let ((edge (make-completed-binary-edge left-edge right-edge rule)))
          ;;(push-debug `(,right-edge ,edge))
          (revise-form-of-nospace-edge-if-necessary edge right-edge)
          (tr :two-word-hyphen-edge edge)))
       ((some-word-is-a-salient-hyphenated-literal words)
        (compose-salient-hyphenated-literals ;; "re-activate"
         pattern words pos-before pos-after))
       ((and (edge-p left-edge)
             (edge-p right-edge))
        ;; if either is a word then the assumptions of 
        ;; make-hyphenated-structure that it has edges to work with
        ;; and we should really fall through and fail the ns search.
        (tr :defaulting-two-word-hyphen)
        ;; make a structure if all else fails
        ;; but first alert to anticipated cases not working
        (make-hyphenated-structure left-edge right-edge))        
       (*work-on-ns-patterns*
        (push-debug `(,left-edge ,right-edge ,pattern ,words))
        (break "One of the 'edges' is actual a (undefined?) word"))
       (t ;; bail
        (reify-ns-name-and-make-edge words pos-before pos-after))))))

(defun resolve-hyphen-between-two-terms (pattern words
                                         pos-before pos-after)
  ;; It's likely that the two connected words are names,
  ;; so we won't assume that they might be connected by rules
  ;; but more like some generalized meaning between the two. 
  ;; (N.b. also used with the separator is a slash)
  (declare (ignore pattern))
  (tr :resolve-hyphen-between-two-terms words)
  (let* ((left-edge (right-treetop-at/edge pos-before))
         (right-edge (left-treetop-at/edge pos-after))
         (left-ref (edge-referent left-edge))
         (right-ref (edge-referent right-edge)))
    (cond
     ((not ;; might be a word 
       (or (individual-p left-ref) 
           (category-p left-ref)))
      (make-bio-pair left-ref right-ref words
                     left-edge right-edge
                     pos-before pos-after))
     ((or (itypep left-ref 'protein)
          (itypep left-ref 'bio-family) ;; RAS-GTP
          (itypep left-ref 'small-molecule) ;; GTP-GDP ???
          (itypep left-ref 'nucleotide))
      (make-protein-pair left-ref right-ref words
                         left-edge right-edge
                         pos-before pos-after))
     ((itypep left-ref 'amino-acid)
      (reify-amino-acid-pair words pos-before pos-after))
     (t (make-bio-pair left-ref right-ref words
                       left-edge right-edge
                       pos-before pos-after)))))


(defun resolve-hyphen-between-three-words (pattern words
                                           pos-before pos-after)
  ;; Should look for standard patterns, especially on the
  ;; middle word. ///Postponing that effort so we can make some
  ;; progress. E.g GAP–to–Ras
  (declare (special words pos-before pos-after)(ignore pattern))
  (tr :resolve-hyphens-between-three-words words)
  (let ((left-edge (right-treetop-at/edge pos-before))
        (right-edge (left-treetop-at/edge pos-after))
        (middle-edge (right-treetop-at/edge 
                      (chart-position-after 
                       (chart-position-after pos-before)))))
    (cond
     ((or (not (edge-p left-edge))
          (not (edge-p middle-edge))
          (not (edge-p right-edge)))
      (when *work-on-ns-patterns*
        (break "non-edge in make-hyphenated-triple, ~s ~s ~s" 
               left-edge middle-edge right-edge)))
     (t
      (make-hyphenated-triple left-edge middle-edge right-edge)))))

    

