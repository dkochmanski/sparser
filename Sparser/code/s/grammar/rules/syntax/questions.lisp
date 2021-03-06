;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER) -*-
;;; copyright (c) 2011,2016-2017 David D. McDonald  -- all rights reserved
;;; Copyright (c) 2009 BBNT Solutions LLC. All Rights Reserved
;;; 
;;;     File:  "questions"
;;;   Module:  "grammar;rules:syntax:"
;;;  Version:  October 2017

;; Broken out from /grammar/model/sl/checkpoint/rules 6/17/09
;; Elaborated through 7/23/09. 9/28/11 removed spatial-orientation
;; and cleaned up. Completely redesigned 8/16.

(in-package :sparser)

;;;---------------------
;;; question categories
;;;---------------------

(defparameter *debug-questions* nil
  "Should only be set when debugging. Signals an error so we can
   see what's going on. Usually paired with a warn.")

(defparameter *show-wh-problems* nil
  "Break about problems in creating WH question and other types.
   Usually in an if statement with a warn as the alternative.")


(define-category question
  :specializes linguistic
  :instantiates nil 
  :binds ((statement top))
  :documentation "Common base for questions of all sorts.
 The 'statement' variable holds the proposition or event that
 is being questioned. Think of it as the question restated in
 declarative form.
   Specializations elaborate this according to the kind of question
 being asked. The basic split is between polar questions and the
 diverse kinds of WH questions.")


(define-category polar-question
  :specializes question
  :instantiates :self 
  :index (:temporary :key statement))
  :documentation "This is a labeling category in that it does
 not add any refinements or extensions to question-core. It just
 labels the statement as a question: 'is it the case that <statement>'."


(define-category wh-question
  :specializes question
  :instantiates :self
  :binds ((wh :primitive category) ;; e.g. #<ref-category HOW>
          (var :primitive lambda-variable) ;; height, color
          ;;(focus ;; Trips variable for 'how <much> ..."
          #| the rest is the statement |# )
  ;;  :index (:temporary :sequential-keys wh attribute statement)
  :documentation "The primary aim of the var(iable) is to provide
 the information to answer the question: where would we find it
 in an individual. For a simple wh-question ('where is the ball?')
 that's assumed to be the variable associated with the WH.
   N.b. used to use add-category-to-individual to incorporate the
 type of the statement into the type of the whole interpretation
 but the k-method dispatch is going the second, statement category
 which confuses the realization process. Now only including the
 statement category when we're not a toplevel question.")

(define-category wh-question/attribute
  :specializes wh-question
  :instantiates :self
  :binds ((attribute attribute-value) ;; #<tall>, w/ var = height
          (other)) ;; "which pathways utilize SRF?"
  :documentation "We are asking about a particular, possibly arbitrary
 thematic argument of the statement. If it is a known type of
 attribute we take advantage of that to refine the choice of
 variable. For arbitrary, 'other', cases we have to dig around
 after we've finished the full parse.")

;;--- constructors

(defun make-wh-object (wh &key variable statement attribute other embedded)
  (declare (optimize debug))
  (push-debug `(,variable ,statement ,attribute ,other))
  (let* ((attribute-var
          (when attribute (variable-for-attribute attribute)))
         (var-to-use (or variable
                         attribute-var
                         (value-of 'variable wh))))
    (let ((q (define-an-individual
                 (if (or attribute other)
                   'wh-question/attribute 'wh-question)
                 :wh wh
                 :var var-to-use
                 :statement statement)))
      (when embedded
        ;; If we are an interior wh-clause, then we are going to 
        ;; compose with something, and it will be important to expose
        ;; the category of the statement as part of this individual.
        (when statement
          (setq q (add-category-to-individual q (itype-of statement)))))
      (when attribute
        (setq q (bind-variable 'attribute attribute q)))
      (when other
        (setq q (bind-variable 'other other q)))
      q)))

(defun extend-wh-object (q &key variable statement attribute)
  (when variable
    (setq q (bind-variable 'var variable q)))
  (when attribute
    (assert (itypep q 'wh-question/attribute))
    (setq q (bind-variable 'attribute attribute q))
    (let ((attr-variable (variable-for-attribute attribute)))
      (when attr-variable ;; how do we sugar possible revision here?
        (setq q (bind-variable 'var attr-variable q)))))
  (when statement
    (setq q (bind-variable 'statement statement q))
    #|(setq q (add-category-to-individual q (itype-of statement)))|# )
  q)


;;;------------------------------------
;;; call from post-analysis-operations
;;;------------------------------------

(defparameter *warn-when-can-not-formulate-question* nil
  "Turn on when debugging these. Otherwise it's presently noisy.")
;; (setq *warn-when-can-not-formulate-question* t)

(defun make-this-a-question-if-appropriate (sentence)
  "Called from post-analysis-operations after all parsing and
   contextual interpretation is finished. This is a generic
   check in that we don't already know that this sentence is
   supposed to be a question. We establish that within this call.
     The early pass by detect-early-information will have
   sorted its results (if any) on the sentence data structure
   which we access here via preposed-aux? and/or initial-wh?.
     If one of these holds we try to formulate a question
   from the sentence, which can be complicated depending on
   how well we've parsed it.
     Runs for side-effects."
  (declare (special category::question *show-wh-problems*))
  (when (or (preposed-aux?)
            (initial-wh?))
    (let* ((preposed? (preposed-aux?)) ;; make them into local flags
           (wh-initial? (initial-wh?))
           (start-pos (starts-at-pos sentence))
           (end-pos (ends-at-pos sentence))
           (edge (span-covered-by-one-edge?
                  (if preposed?
                    ;; just past the preposed aux -- not reliable with WH
                    (chart-position-after start-pos)
                    start-pos)
                  end-pos))
           (edges (all-tts start-pos end-pos)))
      ;; In most cases, the proposed aux will have been accommodated by
      ;; the operations in the post-vg-hook, though that's just for explicit
      ;; auxiliaries.
         
      ;; Look for heuristic ways we could get a full sentence
      ;; from a partial parse. The detection is in this cond.
      ;; The construction is mostly in the subroutines just below.
      (cond
        ((edge-p edge)
         (when preposed?
           ;; The wh-initial? case doesn't need further handling
           ;; when the sentence parsed completely.
           (let ((q (make-polar-question (edge-referent edge))))
             (let ((spanning-edge
                    (make-edge-over-long-span
                     start-pos end-pos
                     (edge-category edge)
                     :rule 'make-this-a-question-if-appropriate
                     :form category::question
                     :referent q)))
               spanning-edge))))

        ((and (= 1 (length edges))
              (eq (edge-category (car edges)) category::there-exists))
         (there-is-as-polar-question (car edges)))

        ((eq (edge-category (car edges)) category::there-exists)
         (sort-out-incompletely-parsed-there-is-q start-pos end-pos edges))

        ((and (= 3 (length edges))
              (edge-p (first edges))
              (itypep (edge-referent (first edges)) 'be))

         (cond ((member (cat-name (edge-form (third edges)))
                        '(adjp adjective comparative superlative
                          comparative-adjp superlative-adjp))
                ;; <is> <something> <adj>
                (make-polar-adjective-question start-pos end-pos edges))
               
               ((member (cat-name (edge-form (third edges)))
                        '(vp+ed vp+ing vg+ed vg+ing
                          vp+passive))
                ;; <is> <something> <x-ing?
                (make-polar-participle-question start-pos end-pos edges))

               ((and (noun-category? (second edges))
                     (noun-category? (third edges)))
                ;; "Is Selumetinib an inhibitor of MEK1?"
                (make-polar-copular-question start-pos end-pos edges))                                     

               (t
                (if *show-wh-problems*
                  (lsp-break "unhandled 3 edge question: ~a" edges)
                  (warn "unhandled 3 edge question: ~a" edges)))))

        (wh-initial? ;; use assimilate-subject (subj vp) to refine the variable
         (cond
           ((= 2 (length edges)) ;; take the second as the statement
            (wh-initial-two-edges wh-initial? edges start-pos end-pos))
           
           ((and (and (= 3 (length edges))
                      (edge-p (second edges))) ;; "How many blocks did you add to the row?"
                 (edge-over-aux? (second edges)))
            (wh-initial-three-edges wh-initial? edges start-pos end-pos))
           
           (t
            (if *show-wh-problems*
              (lsp-break "Could not resolve edges into a WH question: ~a" edges)
              (when *warn-when-can-not-formulate-question*
                (warn "Could not resolve edges into a WH question: ~a" edges))))))

        (preposed?
         (if *show-wh-problems*
           (lsp-break "Could not resolve edges into a polar question: ~a" edges)
           (when *warn-when-can-not-formulate-question*
             (warn "Could not resolve edges into a polar question: ~a" edges))))

        (t
         (if *show-wh-problems*
           (lsp-break "Could not resolve edges into a question: ~a~
                     ~%   preposed-aux = ~a  initial-wh = ~a"
                      edges preposed? wh-initial?)
           (when *warn-when-can-not-formulate-question*
             (warn "Could not resolve edges into a question: ~a~
                  ~%   preposed-aux = ~a  initial-wh = ~a"
                   edges preposed? wh-initial?))))))))


;;;--------------------------
;;; polar questions (yes/no)
;;;--------------------------

(defun make-initial-there-is-edge (preposed-aux-edge)
  "Called by detect-early-information when there is a preposed auxillary
   followed by the word 'there'. We select the correct edge over the
   'there' and  form a there-exists constituent"
  (let* ((start-pos (pos-edge-starts-at preposed-aux-edge))
         (there-pos (pos-edge-ends-at preposed-aux-edge))
         (ev (pos-starts-here there-pos))
         (there-edge (loop for edge in (all-edges-on ev)
                        when (eq (edge-category edge) category::syntactic-there)
                        return edge)))
    (assert there-edge)
    (let ((rule (multiply-edges there-edge preposed-aux-edge)))
      ;; n.b. we switch the order of the edges to make the rule happy
      (assert rule)
      (let ((edge (make-completed-binary-edge preposed-aux-edge
                                               there-edge
                                               rule)))
        ;; add trace
        edge))))



(defun make-polar-question (statement)
  "Abstracted constructor so it will done the same way every time."
  (find-or-make-individual
   'polar-question :statement statement))


;;--- cases called from make-this-a-question-if-appropriate

(defun there-is-as-polar-question (edge)
  "We have a complete parse as a there-exists statement. Throw another
   edge over it as a question -- same as fully-spanned case, which we don't
   get because of the check for pre-posed."
  (let* ((q (make-polar-question (edge-referent edge)))
         (respanning-edge
          (make-completed-unary-edge
           (edge-starts-at edge) ; starting-vector
           (edge-ends-at edge)   ; ending-vector
           'there-is-as-polar-question ; rule
           edge ; daughter
           (edge-category edge) ; category
           category::question ; form
           q))) ; referent
    respanning-edge))


;;/// need an exemplar
(defun sort-out-incompletely-parsed-there-is-q (start-pos end-pos edges)
  (if *debug-questions*
    (error "incomplete there-is question: ~a" edges)
    (warn "Incomplete there-is question: ~s"
          (string-of-words-between start-pos end-pos))))
   #+ignore (let ((e (make-edge-over-long-span
              start-pos end-pos
              (itype-of i)
              :rule 'make-polar-there-question
              :form category::question
              :referent q
              :constituents edges))) )





(defun make-polar-copular-question (start-pos end-pos edges)
  "Construct an instance of 'be' by directly invoking the rules"
  ;; (is) (Selumetinib) (an inhibitor of MEK1)
  (let* ((be (edge-referent (first edges)))  ;; is
         (subj (edge-referent (second edges))) ;; Selumetinib
         (obj (edge-referent (third edges))) ;; an inhibitor of MEK1
         ;; run the core of assimilate-np-to-v-as-object. Result in an instance of 'be'
         (i (assimilate-object be obj)))
    (setq i (bind-variable 'subject subj i))
    (let ((q (make-polar-question i)))
      (make-edge-over-long-span
       start-pos end-pos
       (itype-of i)
       :rule 'make-polar-copular-question
       :form category::question
       :referent q))))
         

    
(defun make-polar-adjective-question (start-pos end-pos edges)
  (let* ((be (edge-referent (first edges)))  ;; is
         (np (edge-referent (second edges))) ;; the ball
         (adj (edge-referent (third edges))) ;; red
         (*left-edge-into-reference* (first edges))
         (copular-adj (make-copular-adjective be adj))
         (copular-statement (when copular-adj
                              (assimilate-subject np copular-adj nil))))
    (declare (special *left-edge-into-reference*))
    ;; this is bound since make-copular-adjective needs to know the edge for the "BE"
    ;; to check if it is an infinitive
    (when copular-statement
      (let ((q (make-polar-question copular-statement)))
        (make-edge-over-long-span
         start-pos end-pos
         (itype-of copular-statement)
         :rule 'make-polar-adjective-question
         :form category::question
         :referent q)))))

(defun make-polar-participle-question (start-pos end-pos edges)
  (let* ((be (edge-referent (first edges)))  ;; is
         (np (edge-referent (second edges))) ;; the BRAF-NRAS complex
         (participle (edge-referent (third edges))) ;; sustained in time
         (*left-edge-into-reference* (first edges))
         (participle-vp (check-passive-and-add-tense/aspect be participle))
         (participle-statement
          (when participle-vp
            (assimilate-subject np participle-vp nil))))
    (declare (special *left-edge-into-reference*))
    ;; this is bound since make-copular-adjective needs to know the edge for the "BE"
    ;; to check if it is an infinitive
    (when participle-statement
      (let ((q (make-polar-question participle-statement)))
        (make-edge-over-long-span
         start-pos end-pos
         (itype-of participle-statement)
         :rule 'make-polar-participle-question
         :form category::question
         :referent q)))))



;;;--------------
;;; WH questions
;;;--------------
#| (p "What color is the block?")
   (p/s "Is the block on the table?")
   (p "Could we put on one more?")
   (p/s "Could we put on one more block?")
   (p "did we make a three block stack?")
   (p "How big is the stack?")
   (p "How many blocks did you add to the row?")
   (p "How many blocks are you adding to the row?") ;; "going to add"
   (p "How many blocks will you add to the row?")

;;-- embedded examples
(p/s "Tell me what you want to do now.")
(p "I couldn't find a place to put the block.") ;; purpose clause in wrong place
(p "Who should do it?")
(p "We don't know how to do that.") ;; bad infinitive


;;-- Bio examples

(p "How Important Are Scc1 and SA2 Phosphorylation In Vivo?.")
e11   HOW           1 "How Important " 3
e15   BE            3 "Are Scc1 and SA2 Phosphorylation In Vivo" 12

(p "Consistent with the critical role of VEGF and VEGFR2 in BPD, 
  human infants who die of BPD have little or no VEGF in their 
  lung epithelium.")
Error: New type of wh-obj passed in: #<ref-category INFANT>

(p "Is the ibogaine congener 18-Methoxycoronaridine safer than ibogaine?.")
;; was throwing an error because (third edges) was a word  #<word QUESTION-MARK>
;; no replicable 10/17

(p "Until now, it has been unclear how RAS could affect ASPP2 to enhance 
p53 function") ;; dry-run $40
From :id "PMC1702556" :corpus :jun15eval
   This wh-np has no aux per se and blew out the loop
(p "Whether all EGFR ectodomain mutants share a common mechanism of 
oncogenic receptor conversion warrants further study.")
9th June article
"How does fibrinogen binding to αIIbβ3 lead to activation of Src?"
"How is the specificity of Sos-1 directed toward Ras or Rac?"
"What type of nuclear speckles is containing the IKKε protein?"
"Where these phosphorylated tyrosine residues are included 
in later comparative analyses they are clearly distinguished."
"What can one conclude from the observation that a known activator 
of PCP signaling, XDshΔDIX, also activates three effectors of Wnt–Ca 2+ signaling?"
"Active Ras (Ras-GTP) triggers a number of signaling cascades, among which is 
the one connecting Ras to Rac, a member of the Rho subfamily of small GTPases."
|#

(defun delimit-and-label-initial-wh-term (pos-before wh-edge)
  "WH questions always also include inverting subject
   and auxiliary, where the auxiliary will occur right after the
   possibly lengthy WH phrase has finished. E.g. 'How many
   people will be going to the party?'. Starting with the 
   WH word, scan forward until you reach an aux. How to best
   divide up the region between the two largly depends on the
   identity of the WH and what its asking for.
      When detect-early-information calls this we collect
   the WH information and populate the object while we're
   walking along the sentence prefix. Then we record the fact
   that we have the wh-edge in hand on the sentence context."
  
  (let* ((wh-type (edge-referent wh-edge)) ;; the category 
         (next-pos (chart-position-after pos-before))
         (next-word (pos-terminal next-pos))
         (next-edge (highest-edge (pos-starts-here next-pos)))
         aux-edge  attr-edge  value-edge  other-edges)

    (flet ((cover-wh (q end-pos)
             "Make a phrase over the whole span of WH edges
              up to but not including the aux"
             (let ((edge
                    (make-edge-over-long-span
                     pos-before end-pos
                     (edge-category wh-edge)
                     :rule 'delimit-and-label-initial-wh-term
                     :form category::question-marker ;;/// needs more meliflous term
                     :referent q
                     :constituents (edges-between pos-before next-pos))))
               (record-initial-wh edge)
               (tr :wh-initial-edge edge q)
               edge)))
      (cond
        ((memq (cat-symbol wh-type) '(who why where when))
         ;; These won't (??) have extended wh phrases like the others
         (cover-wh (make-wh-object wh-type) next-pos))
        (t
         (loop ;; search ahead for the aux/modal, then assess
            (when *debug-questions*
              (format t "~&~a word = ~a, edge = ~a" next-pos next-word next-edge))
            (when (null next-edge) (return))
            (cond
              ((or (auxiliary-word? next-word)  ;; we've gone as far as we should
                   (verb-category? next-edge))
               (setq aux-edge next-edge)
               (return))
              ((itypep (edge-referent next-edge) 'attribute) ;; e.g. color
               (setq attr-edge next-edge))
              ((itypep (edge-referent next-edge) 'attribute-value) ;; "big"
               (setq value-edge next-edge))
              ((null (edge-referent next-edge)) ;; happens in cases like an edge over apostrophe-s
               (push next-edge other-edges))
              ((wh-is-declarative-heuristics next-edge)
               (return))
              (t (push next-edge other-edges)))
            ;;(lsp-break "old next-pos = ~a" next-pos)
            (setq next-pos (if next-edge                  
                             (rightmost (chart-position-after next-pos)
                                        (pos-edge-ends-at next-edge))
                             (chart-position-after next-edge))
                  next-word (pos-terminal next-pos)
                  next-edge (highest-edge (pos-starts-here next-pos))))

         (unless aux-edge
           (if *debug-questions*
             (error "No aux-edge with ~a" wh-type)
             (when *show-wh-problems*
               (warn "No aux-edge with ~a" wh-type))))
          
         (multiple-value-bind (attr other?)
             (cond
               (attr-edge ;; "what color is ..."
                (edge-referent attr-edge))
               (value-edge ;; "how big is the block?"
                (let ((value-class (itype-of (edge-referent value-edge)))) ;; size-value
                  (when value-class (value-of 'attribute value-class))))
               (other-edges ;; "How important is ..."
                (if (null (cdr other-edges))
                  (values (edge-referent (car other-edges)) t)
                  (when *debug-questions*
                    (error "Multiple 'other edges' in ~s: ~a" (current-string) other-edges)))))

           (let ((q (if attr
                      (if other?
                        (make-wh-object wh-type :other attr)
                        (make-wh-object wh-type :attribute attr))
                      (make-wh-object wh-type))))
              (cover-wh q next-pos))))))))

(defun wh-is-declarative-heuristics (next-edge)
  "Called by delimit-and-label-initial-wh-term w/in its accumulation loop.
   Strictly speaking we should probably scan ahead to see if there's an
   aux before we get to a main verb, or something else that would
   signal that we're not in a question."
  (is-pronoun? next-edge)) 


;; (p/s "What color is the block?")
(defun apply-question-marker (wh-edge vg-edge np-edge)
  "Called by DA rule, wh-be-thing, since parsing is going to be stymied by
   the aux/vg being in the wrong place. We take our cue from
   the verb and do it by hand, going directly to the interpretation"
  ;; meta-dot on compose-preposed-aux-into-predicate-adjp to get near
  ;; the right place in rules/DA/da-rules.lisp
  (declare (special category::copular-predicate category::s))
  (let ((vg (edge-referent vg-edge))
        (np (edge-referent np-edge))
        (wh (edge-referent wh-edge)))
     (cond ((itypep vg 'be)
           ;; we're asking about an attribute of the np
           ;; so we have to instantiate the copular-predication
           (let ((i (define-or-find-individual 'copular-predication
                        :predicate vg
                        :item np)))
             (let ((edge (make-binary-edge/explicit-rule-components
                          vg-edge ;; left
                          np-edge ;; right
                          :category category::copular-predicate
                          :form category::s  ;; vp? order is odd for a vp
                          :referent i)))
               (tr :wh-apply-question-marker edge)
               edge)))
           ;;((itypep vg 'do)
           ;; (p/s "What proteins does PLX-4720 target?")
           (t
            (if *debug-questions*
              (lsp-break "Don't know how to formulate a wh question whose vg is ~a" vg)
              (warn "Don't know how to formulate a wh question whose vg is ~a" vg))))))
             



;; This is the second time around after we're assembled
;; the pieces of the question. We can now set it up.
;; The call to compose is in make-subordinate-clause
;;   (p/s "What color is the block?")

(def-k-method compose ((wh category::wh-question) (i individual))
  (add-statement-to-wh-question wh i))

(def-k-method compose ((wh category::wh-question/attribute) (i individual))
  (add-statement-to-wh-question wh i))

(defun add-statement-to-wh-question (wh stmt)
  (declare (special category::question))
  (let ((q (extend-wh-object wh :statement stmt)))
    (revise-parent-edge :form category::question
                        :referent q)
    (tr :wh+individual-method q)
    q))


(defun wh-initial-two-edges (wh-initial? edges start-pos end-pos)
  (let* ((wh (edge-referent wh-initial?))
         (complement (edge-referent (second edges)))
         (q (compose wh complement)))
    (tr :make-this-a-question q)
    (unless q
      (error "WH compose didn't work or doesn't exist"))
    (make-edge-over-long-span
     start-pos end-pos
     (edge-category (second edges)) ;; ??
     :rule 'make-this-a-question-if-appropriate
     :form category::question
     :referent q)))

;; (p "where should I put the block?")
;;
(defun wh-initial-three-edges (wh-edge edges start-pos end-pos)
  "The second argument is an aux or a modal that has to be
   folded in to the statement (third edge) for its tense or
   aspect contribution. Not bothering to explicitly hook
   the aux edge into the tree."
  (let ((wh (edge-referent wh-edge))
        (aux (edge-referent (second edges)))
        (stmt (edge-referent (third edges))))
    (with-referent-edges (:l (second edges) :r (third edges))
      (setq stmt (add-tense/aspect-info-to-head aux stmt)))
    (let ((q (compose wh stmt)))
      (make-edge-over-long-span
       start-pos end-pos
       (edge-category (third edges)) ;; ??
       :rule 'make-this-a-question-if-appropriate
       :form category::question
       :referent q
       :constituents edges))))



;;;-------------------
;;; context predicate
;;;-------------------

(defun top-level-wh-question? (&aux (left-edge (left-edge-for-referent)))
  "Called from compose-wh-with-vp where we might be forming 
   a question or this might be a relative clause. Of course there are
   also embedded questions which function as if they were NPs where the
   distinction turn on whether there is aux-inversion.
      For now just a trivial test based on sentence position."
  (= 1 (pos-token-index (pos-edge-starts-at left-edge))))




#|
;;--- swallowing the inverted auxiliary into WH/be

(def-cfr WH/be (wh-pronoun be) ;; gets all the WH pronouns
  :form question-marker
  :referent (:daughter left-edge))

(def-cfr WH/be (wh-pronoun apostrophe-s) ;; gets all the WH pronouns
  :form question-marker
  :referent (:daughter left-edge))

(def-cfr WH/be (wh-pronoun do) ;; "where did you come from"
  :form question-marker
  :referent (:daughter left-edge))  |#

;(def-cfr WH/be (WH/be pronoun/second)
;  :form question-marker ;; unless we want to strand the "you" ??
;  :referent (:daughter left-edge
;	          :bind (participant . right-edge)))

;; "will"
; CATEGORY           #<mixin WILL>
; FORM               #<ref-category MODAL>
; REFERENT           #<mixin FUTURE>


;;--- Explicit cases motivated by the checkpoint domain
;;  This almost certainly has a clean generalization that can be cast
;; as a form rule, but I'm not certain yet what that would be. Need more
;; cases
#|
(def-cfr event (WH/be location)
  :form s
  :referent (:instantiate-individual question
             :with (type left-edge
                    content right-edge)))

(def-cfr event (WH/be individual)
  :form s
  :referent (:instantiate-individual question
             :with (type left-edge
		            content right-edge)))

(def-form-rule (WH/be verb+ing)
  :form s
  :referent (:instantiate-individual question
             :with (type left-edge
		            content right-edge)))

;; I think these next two need to be scrapped (cfg 13 Jul 09)

(def-cfr event (WH/be "from")
  :form s
  :referent (:instantiate-individual question
             :with (type left-edge
		            content right-edge)))

(def-cfr event (WH/be with-np)
  :form s
  :referent (:instantiate-individual question
             :with (type left-edge
		            content right-edge)))

;; This is a rather important one right here...

(def-cfr event (WH/be event)
  :form s
  :referent (:instantiate-individual question
             :with (type left-edge
		            content right-edge)))
|#
#|   Ignoring now (8/4/16) because it will likely succeed
     and distort things before they're done.
;; Handles commonly used (but not necessarily grammatical)
;; examples like "where you going" etc.

(def-form-rule (wh-pronoun verb+ing)
  :form s
  :referent (:instantiate-individual question
             :with (type left-edge
		            content right-edge)))

;(def-cfr WH/be (wh-pronoun pronoun/second)
;  :form question-marker
;  :referent (:daughter left-edge
;	     :bind (participant . right-edge)))
|#


#|   Harvest for patterns
;; For "why are you out today" -- really smacks into the
;; sticky psi issue though...

(def-cfr WH/be/you (WH/be pronoun/second)
  :form s
  :referent (:instantiate-individual question
             :with (type left-edge
		            participant right-edge)))

;; (def-cfr event (WH/be/you spatial-orientation) ;; flushed spatial-orientation
;;   :form s
;;   :referent (:head left-edge
;; 	     :bind (location . right-edge)))

(def-cfr event (WH/be/you deictic-location)
  :form s
  :referent (:head left-edge
	         :bind (location . right-edge)))

(def-cfr event (WH/be/you prep-location)
  :form s
  :referent (:head left-edge
	     :bind (location . right-edge)))

;; (def-cfr event (WH/be spatial-orientation) ;; flushed spatial-orientation 
;;   :form s
;;   :referent (:instantiate-individual question
;;              :with (type left-edge
;; 		    content right-edge)))

(def-cfr event (WH/be deictic-location)
  :form s
  :referent (:instantiate-individual question
             :with (type left-edge
		    content right-edge)))
|#

