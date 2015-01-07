;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER COMMON-LISP) -*-
;;; Copyright (c) 2014-2015 SIFT LLC. All Rights Reserved
;;;
;;;    File: "phenomena"
;;;  Module: "grammar/model/sl/biology/
;;; version: January 2015

;; Initiated 12/28/14 to handle moderately complicated notions
;; like cell line and mutation. Conformation and isoform and such
;; would go here. Reorganizes some items in terms. Incremental
;; extensions through 1/6/15

(in-package :sparser)

(define-realization-scheme pre-mod premodifier-adds-property 
  ;; used in quarter -- as are a number of other np patterns
  :head :common-noun
  :mapping ((property . modifier-slot)
            (np-head . :self)
            (modifier . modifier-v/r)))

;;---------- signalling 
;; "RAS signalling"
;; a new mode of Ras activation in which signaling is sustained ...
(noun signaling
  :specializes bio-process
  :obo-id "GO:0023052"  ;; reasonable stand-in
  :binds ((agent bio-entity)) ;; what's doing the signalling
  :index (:permanent :key agent)
  :realization 
    (:etf pre-mod
     :noun "signaling"
     :m agent))

;;;-------------------
;;; protein terminals
;;;-------------------

; "located in both N- and C-terminal regions of p100"
; "via the ASPP2 N-terminus"

; There are two terminals, N and C, and they only make
; sense in a technical article when they're tied to 
; a particular protein.
; Semantically these are 'regions' in that they talk about
; things happening in these places. "region" is defined in
; dossiers/location-kinds.lisp as a region-type

(define-category protein-terminus
  :specializes bio-location
  :instantiates :self
  :lemma ((:common-noun "terminal")
          (:common-noun "terminus")))

;; not clear that we need a proper handling
;; of the molecule configuration, etc. that
;; differentiates N from C

(define-category N-terminal ;; amino-terminus
  :specializes protein-terminus
  :binds ((protein protein))
  :index (:permanent :key protein)
  :realization
    (:etf (pre-mod of-nominal)
     :noun ("N-terminal" "N-terminus")
     :o protein
     :m protein))

(define-category C-terminal ;; carboxyl-terminus
  :specializes protein-terminus
  :binds ((protein protein))
  :index (:permanent :key protein)
  :realization
    (:etf (pre-mod of-nominal)
     :noun ("C-terminal" "C-terminus")
     :o protein
     :m protein))


#|The convention for writing peptide sequences is 
to put the N-terminus on the left and write 
the sequence from N- to C-terminus. When the 
protein is translated from messenger RNA, 
it is created from N-terminus to C-terminus.|#



;;;----------
;;; Pathways
;;;----------
; diverse signaling pathways
; specific effector pathways
; specific effector pathway(s)
; the Raf/MEK/ERK pathway
; MAPK pathway inhibitors / inhibition

(define-category  pathway
  :specializes bio-entity
  :instantiates :self
  :mixins (type-marker biological)
  :binds ((protein-sequence sequence))
  :index (:permanent :key name)
  :lemma (:common-noun "pathway")
  :realization (:common-noun name)
  :documentation "Pathways are inhibited and activated
   which makes them more like entities than processes.
   They are named according to the sequence of proteins
   (protein families) in the causal chain.")

(define-category signaling-pathway
   :specializes pathway
   :instantiates :self
   :realization
  (:noun "signaling pathway"))


(defmacro def-pathway (&rest strings-naming-proteins)
  `(def-pathway/expr ',strings-naming-proteins))

(defun def-pathway/expr (strings-naming-proteins)
  (let ( proteins )
    (dolist (name strings-naming-proteins)
      (let ((protein (get-protein name)))
        (unless protein
          (error "Cannot identify a protein named ~s" name))
        (push protein proteins)))
    (setq proteins (nreverse proteins))
    (let ((sequence (create-sequence proteins))
          (name (create-slash-separated-string strings-naming-proteins)))
      (let ((i (find-or-make-individual 'pathway :name name)))
        ;;/// make a lowercase version?
        (bind-variable 'protein-sequence sequence i)
        i))))

;;//// move to string utilities
(defun create-slash-separated-string (strings)
  (let ( list )
    (do ((string (car strings) (car rest))
         (rest (cdr strings) (cdr rest)))
        ((null string))
      (push string list)
      (unless (null rest)
        (push "/" list)))
    (apply #'string-append (nreverse list))))

;(def-pathway "RAS" "Raf" "MAPK")
;(def-pathway "MEK" "ERK")



(define-category step
  :specializes bio-process
  :instantiates :self
  :index (:permanent :key name)
  :binds ((pathway pathway))
  :lemma (:common-noun "step")
  :realization (:common-noun name))



;;;-------------------------------
;;; transcription and its control
;;;-------------------------------
; the ZFN217 transcription factor
; and CtBP1/CtBP2 corepressors, CtBPs
; the HER3 promoter
; expression of HER3
; inhibition of HER3 transcription
; "enhances the transcription function of p53"

;;;-----------
;;; Apoptosis
;;;-----------
; "RAS can enhance the apoptotic function of p53"
; intracellular apoptotic signaling
; apoptotic signals
; the apoptosis pathway

(define-category apaptosis ;; aka cell death
  :specializes bio-process
  :lemma ((:common-noun "apaptosis")
          (:adjective "apoptotic")))
