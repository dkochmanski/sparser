;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 2013-2014 David D. McDonald  -- all rights reserved
;;; 
;;;     File:  "tuck"
;;;   Module:  "objects/chart/edge vectors/"
;;;  Version:  September 2014

;; Initiated 9/19/13 from code formerly in DA. 9/22/13 modifying it
;; to work in either direction. 9/29/14 fixed tuck-in-just-above to
;; work in both directions, not just leftwards

(in-package :sparser)


(defun tuck-new-edge-under-already-knit (subsumed-edge new-edge 
                                         dominating-edge direction)
  (declare (special *current-da-rule* *sentence-in-core*))
  ;; We looked under an edge, identified an edge along its
  ;; fringe (subsumed-edge), and composed that edge with one adjacent
  ;; to the right (left) to form a new edge (new-edge).
  ;; Now we have to reconstruct pointers so that the edge that
  ;; had dominated the subsumed one dominates the new pair.
  (push-debug `(,subsumed-edge ,new-edge ,dominating-edge ,direction))
  ;; (setq subsumed-edge (car *) new-edge (cadr *) dominating-edge (caddr *))  (break "tucking 1")

  ;; Cleanup the used-in of the subsumed-edge
  (cond
    ((null new-edge)
     (break "~&null new-edge when doing tuck-new-edge-under-already-knit")
     nil)
    (t
     (setf (edge-used-in subsumed-edge) new-edge)

     ;; plug in top-edge in place of subsumed-edge
     ;; this method creates lists of edges -- don't do that now
     (set-used-by new-edge dominating-edge)

     #|
     ;; replace old subsumed daughter (... presumes binary)
     (ecase direction
       (:right (setf (edge-right-daughter dominating-edge) new-edge))
       (:left  (setf (edge-left-daughter dominating-edge) new-edge)))
     |#

     (cond ((eq (edge-right-daughter dominating-edge) :long-span)
            (when (not (member subsumed-edge (edge-constituents dominating-edge)))
              (error "~%in tuck-new-edge-under-already-knit:~%
edge-constituents in dominating edge ~s ~%
does not contain subsumed-edge ~s~%" dominating-edge subsumed-edge))
            (setf (edge-constituents dominating-edge)
                  (subst new-edge subsumed-edge (edge-constituents dominating-edge))))
           ((eq direction :right)
            (unless (eq (edge-right-daughter dominating-edge) subsumed-edge)
              (error t "~%in tuck-new-edge-under-already-knit for rule ~s:~%
edge-right-daughter in dominating edge ~s ~%
is not subsumed-edge ~s in sentence:~%~s~%"
                      *current-da-rule* dominating-edge subsumed-edge
                      (sentence-string *sentence-in-core*)))
            (setf (edge-right-daughter dominating-edge) new-edge)) 
           ((eq direction :left)
            (unless (eq (edge-left-daughter dominating-edge) subsumed-edge)
              (error "~%in tuck-new-edge-under-already-knit:~%
edge-left-daughter in dominating edge ~s ~%
is not subsumed-edge ~s~%" dominating-edge subsumed-edge))
            (setf (edge-left-daughter dominating-edge) new-edge)))
     (let ((dominating-edge-ev
            (ecase direction
              (:right (edge-ends-at dominating-edge))
              (:left (edge-starts-at dominating-edge))))
           (new-edge-ev
            (ecase direction
              (:right (edge-ends-at new-edge))
              (:left (edge-starts-at new-edge)))))
       (push-debug `(,dominating-edge-ev ,new-edge-ev))
       ;; (setq dominating-edge-ev (car *) new-ev (cadr *)) (break "tucking 2")

       ;; Remove the dominating edge from its ends/start-at vector
       (if (eq dominating-edge (highest-edge dominating-edge-ev))
           (then ;; easy case
             (pop-topmost-edge dominating-edge-ev)
             ;; insert the dominating edge just above the top edge
             ;; at the end location
             (tuck-in-just-above new-edge-ev new-edge dominating-edge direction))
           (else
             ;; Several edges are above the edge now just above the
             ;; subsumed-edge. They all have to be repositioned (in order)
             ;; at the end-position of the top-edge where sit above it
             (move-edges-above-to-new-pos 
              subsumed-edge
              (ecase direction
                (:left (edge-starts-at subsumed-edge))
                (:right (edge-ends-at subsumed-edge)))
              new-edge-ev
              direction)))
       (when *description-lattice*
         (reinterpret-dominating-edges dominating-edge))
       ;;(break "and what else?")
       ;;/// We now have two edges that are adjacent that weren't before
       ;; so we should see if there's a rule and recompute the referent
       ))))


(defun reinterpret-dominating-edges (edge &optional *visited*)
  (declare (special *sentence-in-core* *visited*))
  (let ((new-ref (referent-for-edge edge)))
    (cond ((null new-ref)
           (warn "reinterpretation of edge ~s failed in reinterpret-dominating-edges by producing null interpretation~% in ~s~%" edge
                 (sentence-string *sentence-in-core*)))
          ((eq new-ref :abort-edge)
           (warn "reinterpretation of edge ~s failed in reinterpret-dominating-edges by producing :abort-edge interpretation~% in ~s~%" edge 
                 (sentence-string *sentence-in-core*)))

          (t
           (setf (edge-referent edge) new-ref)
           (if (edge-mention edge)
               (if (typep (edge-mention edge) 'discourse-mention)
                   (setf (base-description (edge-mention edge)) new-ref))
               (warn "null edge-mention on edge ~s in ~%~s"
                     edge (sentence-string *sentence-in-core*)))
           (let ((parent (edge-used-in edge)))
             (cond ((edge-p parent)
                    (when (member parent *visited*)
		      ;; happens in
		      ;; <give example here>
                      (error "circular-loop in reinterpret-dominating-edges"))
                    (reinterpret-dominating-edges parent (cons parent *visited*)))
                   ((null parent) ;; reached the topmost edge
                    nil)
                   ((consp parent)
                    (error "multiple parent edges in reinterpret-dominating-edges for ~s,~%~s~%" edge parent))
                   (t (lsp-break "what is going on with the used-in for ~s~%" edge))))))))
        

(defun move-edges-above-to-new-pos (above-this-one
                                    old-edge-vector new-edge-vector
                                    direction)
  (push-debug `(,above-this-one ,old-edge-vector ,new-edge-vector))
  
  (let* ((index (index-of-edge-in-vector above-this-one old-edge-vector)))
    ;;(break "index = ~a" index)
    (let ((edges-to-move (edges-higher-than old-edge-vector index)))
      (push-debug `(,edges-to-move))
      ;;(break "edges-to-move")
      (dolist (edge edges-to-move)
        (ecase direction
          (:left (setf (edge-starts-at edge) new-edge-vector))
          (:right (setf (edge-ends-at edge) new-edge-vector))))
      (loop for edge in edges-to-move
        do (knit-edge-into-position edge new-edge-vector)))))


(defun tuck-in-just-above (ev edge-below edge-above direction)
  ;; Assumes that the edge-below (top-edge) is already in the ev.
  ;; We add the edge-above (dominating-edge) just above it
  ;; in the vector and adjust things accordingly. 
  (push-debug `(,ev ,edge-below ,edge-above))
  ;;  (setq ev (car *) edge-below (cadr *) edge-above (caddr *))
  (ecase direction
    (:left
     (let ((below-starts-at (edge-starts-at edge-below)))
       (setf (edge-starts-at edge-above) below-starts-at)
       (knit-edge-into-position edge-above below-starts-at)))
    (:right
     (let ((below-ends-at (edge-ends-at edge-below)))
       (setf (edge-ends-at edge-above) ev)
       (knit-edge-into-position edge-above below-ends-at)))))

(defun pop-topmost-edge (ev)
  "Remove the topmost edge from this vector and adjust
   the other fields to fit."
  (let* ((topmost (ev-top-node ev))
         (index (index-of-edge-in-vector topmost ev))
         (count (ev-number-of-edges ev))
         (array (ev-edge-vector ev)))
    (setf (aref array index) nil) ;; remove it
    (setf (ev-number-of-edges ev) (1- count)) ;; adjust count
    (let ((next-item-down (aref array (1- index))))
      (setf (ev-top-node ev) next-item-down))))
