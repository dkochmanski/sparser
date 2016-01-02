;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 2015  David D. McDonald  -- all rights reserved
;;;
;;;     File:  "pattern-resolvers"
;;;   Module:  "analysers;psp:patterns:"
;;;  version:  November 2015

;; Initiated 11/12/15 to collect up and rationalized the subroutines
;; used after a pattern has matched to determine what we really have.
;; These typically build edges when they succeed.

(in-package :sparser)

;;;--------------------------
;;; look for a explicit rule 
;;;--------------------------

(defun composed-by-usable-rule (left-edge right-edge)
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
    (when usable-rule ;; "GTP-bound"
      (tr :ns-found-usable-rule rule)
      (let ((edge (make-completed-binary-edge left-edge right-edge rule)))
        (revise-form-of-nospace-edge-if-necessary edge right-edge)
        (tr :two-word-hyphen-edge edge)
        edge))))


;;;------------------------------------
;;; Combine them by binding a variable
;;;------------------------------------

;;--- predicate 

(defun second-imposes-relation-on-first? (right-ref right-edge)
  (declare (special category::verb+ed category::adjective category::verb+ing
                    category::verb+ed))
  (let* ((form (when (edge-p right-edge) 
                     (edge-form right-edge))))
    (when (or
           (eq form category::verb+ed)
           ;; assume passive
           (eq form category::verb+ing)
           (eq form category::adjective))
      ;; now figure out what variable on the second (right)
      ;; should be bound to the first (left)
      (let* ((vars (loop for sc in (super-categories-of right-ref)
                     append
                     (if (category-p sc)
                         (cat-slots sc) ;; what case??
                         (cat-slots (itype-of sc)))))
             (variable 
              (cond
               ((eq form category::verb+ed)
                (subject-variable right-ref))
               ((or
                 (eq form category::adjective)
                 (eq form category::verb+ing))
                ;; Get the slots on the category of the right-edge
                ;; and look for a variable that's not for subjects
                (let ((sv (subject-variable right-ref)))
                  (loop for v in vars 
                    when (not (eq v sv)) do (return v)))))))
        ;; Which variable this is really depends on the two referents.
        ;; For the induced example its an agent (= subject). But the
        ;; tyrosine goes on the site variable of the phosphoryate.
        ;; For right now, binding the subject and letting the chips
        ;; fall as they may. Elevating the right edge as the head
        ;; but making it an adjective overall. 
        (unless variable
          ;;/// clear motivation for structure on variables on perhaps
          ;; on the mixing in of categories for this same purpose
          ;; Default to modifier ??
          (setq variable
                ;; applies if there's just one variable on category
                (single-on-variable-on-category right-ref)))
        variable))))


;;--- follow-up routine that does it

;; "EphB1-induced", "tyrosine-phosphorylated"
(defun do-relation-between-first-and-second (left-ref right-ref 
                                             left-edge right-edge)
  (declare (special category::adjective category::verb+ed category::vp+ed))
  (tr :make-right-head-with-agent-left)
  (when (category-p right-ref)
    (setq right-ref (make-individual-for-dm&p right-ref)))
  (let* ((variable (second-imposes-relation-on-first? right-ref right-edge))
         (edge
          (make-ns-edge
           (pos-edge-starts-at left-edge)
           (pos-edge-ends-at right-edge)
           (edge-category right-edge)
           :form (if (eq (edge-form right-edge) category::verb+ed)
                     category::vp+ed
                     category::adjective)
           :referent (bind-dli-variable variable left-ref right-ref)
           :rule 'do-relation-between-first-and-second
           :constituents `(,left-edge ,right-edge))))
    (tr :no-space-made-edge edge)
    edge))



;;;------------------------------
;;; precursors to other routines
;;;------------------------------

(defun make-protein-pair/convert-bio-entity (start-pos end-pos
                                             edges words which-one)
  ;; Called from one-hyphen-ns-patterns 
  ;; /// compare to operation in multi-colon-ns-patterns 
  ;;  which shares a lot  
  (let* ((edge-to-convert (ecase which-one
                            (:right (third edges))
                            (:left (first edges)))))
    (convert-bio-entity-to-protein edge-to-convert) ;; converts the edge
    (make-protein-pair (first edges) (third edges) words start-pos end-pos)))
    

#+ignore ;; this version makes a collection rather than
   ;; a pair -- will be useful elsewhere for parts. 
(defun make-protein-pair/setup (edges start-pos end-pos)
  (let* ((proteins (list (edge-referent (first edges))
                         (edge-referent (third edges))))
         (i (find-or-make-individual 'collection
                                     :type category::protein
                                     :items proteins))
         (edge (make-ns-edge
                start-pos end-pos category::protein
                :referent i :rule 'make-protein-pair/convert-bio-entity
                :constituents edges)))
    edge))

