;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER COMMON-LISP) -*-
;;; Copyright (c) 2014-2015 SIFT LLC. All Rights Reserved
;;;
;;;    File: "phenomena"
;;;  Module: "grammar/model/sl/biology/
;;; version: May 2015

;; Initiated 12/28/14 to handle moderately complicated notions
;; like cell line and mutation. Conformation and isoform and such
;; would go here. Reorganizes some items in terms. Incremental
;; extensions through 1/6/15
;; 1/9/2015 give ubiquitinate a site variable, and define "pro-apoptotic" as a subclass of "apoptotoic"
;; 1/14/2015 tweaks on N and C-terminus
;; 2/15/15 trying to make some headway with ubiquitination
;; 4/23/15 Pulled in dimer material from other files
;; 5/29/15 Added the rest of the Mitre-designated modification features

(in-package :sparser)

(define-realization-scheme pre-mod premodifier-adds-property 
  ;; used in quarter -- as are a number of other np patterns
  :head :common-noun
  :mapping ((property . modifier-slot)
            (np-head . :self)
            (modifier . modifier-v/r)))
;///// This is here because it was "forgotten" by the time we needed
; to use it (e.g. in signaling. Maybe the symbol was overwritten ?



(define-category modified-protein
  :specializes protein
  :instantiates protein
  :rule-label protein
  :documentation "Intended as representation of proteins
    with one or more post-translational modifications."
  :index (:temporary :sequential-keys protein modification)
  :binds ((protein (:or protein human-protein-family))
          (modification protein))) ;; hack for mUbRas

(define-category mutated-protein
  :specializes modified-protein
  :instantiates protein
  :rule-label protein
  :index (:temporary :sequential-keys protein modification)
  :binds ((protein protein)
          (mutation point-mutation)))


;;---------- signalling 
;; (setq *break-on-illegal-duplicate-rules* t)
; The def-synonym call is creating a rule it should be able
; to lookup and reuse because the lhs and rhs are eq/equal
; but the reuse existing rule case isn't being taken and
; it's instead mis-construed as a duplicate, which should
; require a different lhs. 

;; "RAS signalling"
;; a new mode of Ras activation in which signaling is sustained ...
(define-category signal
  :specializes bio-process
  ;;//// bind it explicitly? :obo-id "GO:0023052"  ;; reasonable stand-in
  :binds ((agent protein) ;;bio-entity) ;; what's doing the signalling
          (object (:or bio-process protein)))  ;; what's being signaled
  :index (:permanent :key agent) ;; 
  :realization 
    (:verb ("signal"  :present-participle "xxxsignaling") ;; block "signaling" as a verb
     :noun "signalling"
     :etf (svo-passive pre-mod)
     :m agent
     :s agent 
     :o object
     :to object))

(def-synonym signal ;; Jan.#26
   (:noun "signaling" 
          :etf pre-mod
          :m agent    
          :to object))




(define-category post-translational-modification :specializes bio-process
  :binds ((agent biological) ;; what causes it to happen
          (substrate (:or protein residue-on-protein)) ;; which protein now has ubiquitin on it
          (site residue-on-protein)) ;; which is attached here
  :realization (:noun "post-translational modification")
  )

(def-synonym post-translational-modification
     (:noun "post-transcriptional modification"))  
(def-synonym post-translational-modification
     (:noun "post-transcriptional fate"))  



(define-category phosphorylation-modification :specializes post-translational-modification)

(define-category acetylation
  :specializes post-translational-modification
  :instantiates self
  :index (:temporary :sequential-keys site substrate)
  :realization
  (:verb "acetylate" :noun "acetylation"
   :etf (svo-passive pre-mod)
   :s agent
   :o substrate
   :m site
   :of substrate
   :on site
   :at site))

(define-category farnesylation 
  :specializes post-translational-modification 
  :realization 
  (:verb "farnesylate"
         :noun "farnesylation"
         :etf (svo-passive pre-mod) 
         :s agent 
         :o substrate
         :m site
         :of substrate
         :on site
         :at site))

(define-category glycosylation 
 :specializes post-translational-modification 
  :realization 
    (:verb "glycosylate"
     :noun "glycosylation"
     :etf (svo-passive pre-mod) 
     :s agent 
     :o substrate
     :m site
     :of substrate
     :on site
     :at site))

(define-category hydoxylation 
 :specializes post-translational-modification 
  :realization 
    (:verb "hydoxylate"
     :noun "hydoxylation"
     :etf (svo-passive pre-mod) 
     :s agent 
     :o substrate
     :m site
     :of substrate
     :on site
     :at site))

(define-category methylation 
 :specializes post-translational-modification 
  :realization 
    (:verb "methylate"
     :noun "methylation"
     :etf (svo-passive pre-mod) 
     :s agent 
     :o substrate
     :m site
     :of substrate
     :on site
     :at site))


;;--- "phosphorylate"
;; GO:0016310	
;; "activated IKKα phosphorylates specific serines"
;;  "The phosphorylation of these specific serines"
(define-category phosphorylate
  :specializes phosphorylation-modification
  :instantiates self
  :index (:permanent :sequential-keys site substrate)
  :realization
  (:verb "phosphorylate" :noun "phosphorylation"
   :etf (svo-passive pre-mod)
   :s agent
   :o substrate
   :m site ;; "T669 phosphorylation" in figure-7
   :of substrate
   :on site
   :at site))


(define-category auto-phosphorylate
  :specializes phosphorylation-modification
  :realization
  (:verb "auto-phosphorylate" :noun "auto-phosphorylation"
   :etf (sv)
   :s agent))

(def-synonym auto-phosphorylate
  (:verb "autophosphorylate" :noun "autophosphorylation"
   :etf (sv)
   :s agent))

(def-synonym auto-phosphorylate
             (:verb "autophosphosphorylate"
              :etf (sv) :s agent))

(define-category cis-auto-phosphorylate
  :specializes auto-phosphorylate
  :realization
  (:verb "cis-auto-phosphorylate" :noun "cis-auto-phosphorylation"
   :etf (sv)
   :s agent))
(def-synonym cis-auto-phosphorylate
             (:verb "cis-autophosphosphorylate"
              :etf (sv) :s agent
              :noun "cis-autophosphorylation"))

(define-category trans-auto-phosphorylate
  :specializes auto-phosphorylate
  :realization
  (:verb "trans-auto-phosphorylate" :noun "trans-auto-phosphorylation"
   :etf (sv)
   :s agent))
   
(def-synonym trans-auto-phosphorylate
             (:verb "trans-autophosphosphorylate"
                    :etf (sv) :s agent
                    :noun "trans-autophosphorylation"))

(define-category dephosphorylate
  :specializes post-translational-modification
  :realization
  (:verb "dephosphorylate" :noun "dephosphorylation"
   :etf (svo-passive)
   :s agent
   :o substrate
   :of substrate
   :at site))

(def-synonym dephosphorylate
  (:noun "dephophosphorylation" ;; misplelling from comments
   :s agent
   :o substrate
   :of substrate
   :at site))


(define-category transphosphorylate
  :specializes phosphorylation-modification
  :instantiates self
  :index (:permanent :sequential-keys site substrate)
  :realization
  (:verb "transphosphorylate" :noun "transphosphorylation"
   :etf (svo-passive pre-mod)
   :s agent
   :o substrate
   :m site ;; "T669 phosphorylation" in figure-7
   :of substrate
   :on site
   :at site))

(define-category hypersphosphorylate
  :specializes phosphorylation-modification
  :instantiates self
  :index (:permanent :sequential-keys site substrate)
  :realization
  (:verb "hyperphosphorylate" :noun "hyperphosphorylation"
   :etf (svo-passive pre-mod)
   :s agent
   :o substrate
   :m site ;; "T669 phosphorylation" in figure-7
   :of substrate
   :on site
   :at site))


(define-category ribosylation 
 :specializes post-translational-modification 
  :realization 
    (:verb "ribosylate"
     :noun "ribosylation"
     :etf (svo-passive pre-mod) 
     :s agent 
     :o substrate
     :m site
     :of substrate
     :on site
     :at site))

(define-category sumoylation 
 :specializes post-translational-modification 
  :realization 
    (:verb "sumoylate"
     :noun "sumoylation"
     :etf (svo-passive pre-mod) 
     :s agent 
     :o substrate
     :m site
     :of substrate
     :on site
     :at site))


; monoubiquitination increases the population 
;;  this process has this effect
; the enzymatic and chemical ubiquitination linkers 
; the monoubiquitinated and unmodified fractions of Ras
; the sensitivity of mUbRas
; our ability to easily generate mUbRas
; the c–terminus of Ubiquitin (Ubiquitin C77)
; Ras ligated to Ubiquitin C77
; ligated to Ubiquitin G76C. <--- point mutation
(def-bio "ubiquitin" protein)
;; not strictly true, but a reasonable approximation. 

(define-category ubiquitination
 :specializes post-translational-modification 
  :realization 
    (:verb "ubiquitinate"
     :noun "ubiquitination"
     :etf (svo-passive pre-mod) 
     :s agent 
     :o substrate
     :m site
     :of substrate
     :on site
     :at site))

(define-category auto-ubiquitinate
  :specializes ubiquitination
  :realization
  (:verb "auto-ubiquitinate" :noun "auto-ubiquitination"
   :etf (sv)
   :s agent))

(def-synonym auto-ubiquitinate 
             (:verb "autoubiquitinate"
                    :etf (sv)
                    :noun "autoubiquitination"
                    :s agent))

;;;------------------------------
;;; mUbRas, monoubitutinated Ras
;;;------------------------------
;;///// This is a process/result pattern. This verb results
;; in a protein that has been ubiquitinated. (Has one or
;; more ubiquitin molecules attached to it.
;; Need to do this systematically

;; In Baker et al.
;; "we did not separate monoubiquitinated Ras (mUbRas) from ..."
;; Jan #1 "the effect of Ras monoubiquitination on ...
;; ... effect of Ras monoubiquitination on ...
;; Resulting version of Ras after adding one ubiquitin. 

;; strictly for the rule-label
(define-category monoubiquitination 
 :specializes post-translational-modification )

;;--- wrapper

(define-category  monoubiquitinated-protein
  :specializes modified-protein
  :instantiates self
  :bindings (modification (get-protein "ubiquitin"))
  ;;/// bindings go with a process, so this will need 
  ;; cleanup / merge when process/result is sorted out syntematically.
  :binds ((site residue-on-protein)
          ;; I dont' recall textual evidence for an agent
          ;; that causes the action (that leads to this result)
          ;; but the rule schema requires it
          ;; N.b. this is open in protein
          (agent biological))
  :documentation "Strictly speaking this is just a ubiquitinated
    protein since there no representation of the molecule count.
    I'd like another countable modification before venturing a
    conceptualization to use. Note that this is open in
    its value for the protein"
  :index (:permanent :key protein)
  :rule-label monoubiquitinate
  :realization 
  ;;/// only providing a realization for the result, not the process
  ;; that leads to the result
    (:verb "monoubiquitinate" 
     :noun "monoubiquitination"
     :etf (svo-passive pre-mod)
     :s agent 
     :o protein ;; "monoubiquitinated Ras"
     :m protein ;; Ras monoubiquitination
     :on protein ;; the effects of monoubiquitination on Ras are ...
          ;;/// that 'on' probably goes with 'effect'
     :at site))


(defun define-mUbRas ()
  ;; Defines the abbreviated form and creates the individual
  ;; that the composed form has to resolve to. 
  (let* ((ras (get-protein "Ras"))
         (i (find-or-make-individual 'monoubiquitinated-protein
               :protein ras))
         (word (resolve/make "mUbRas")))

    ;; want to pattern just like a vanila protein
    (let ((cfr (define-cfr category::protein `(,word)
                  :form category::proper-noun
                  :referent i)))
      (add-rule-to-individual cfr i)
      i)))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (define-mUbRas))


;;;-------------------
;;; protein terminals
;;;-------------------

#|The convention for writing peptide sequences is 
to put the N-terminus on the left and write 
the sequence from N- to C-terminus. When the 
protein is translated from messenger RNA, 
it is created from N-terminus to C-terminus.|#

; There are two terminals, N and C, and they only make
; sense in a technical article when they're tied to 
; a particular protein.
; Semantically these are 'regions' in that they talk about
; things happening in these places. "region" is defined in
; dossiers/location-kinds.lisp as a region-type


; "located in both N- and C-terminal regions of p100"
; "via the ASPP2 N-terminus"
; the amino terminus of β-catenin

(define-category protein-terminus
  :specializes molecular-location
  :instantiates :self
  :binds ((protein protein))
  :lemma ((:common-noun "terminal")
          (:common-noun "terminus"))
  :realization
    (:noun "terminal"
     :of protein))

;; not clear that we need a proper handling
;; of the molecule configuration, etc. that
;; differentiates N from C

;;//////////// These are essentially identical definitions
;; Meed a macro or something 

(define-category N-terminal ;; amino-terminus
  :specializes protein-terminus
  :binds ((protein (:or protein bio-entity)))
  :index (:permanent :key protein)
  :realization
    (:etf (pre-mod)
     :noun ("n-terminal" "n-terminus" "N-terminal" "N-terminus"
            "amino terminus")
     ;;:o protein
     :m protein
     :of protein))

(define-category C-terminal ;; carboxyl-terminus
  :specializes protein-terminus
  :binds ((protein protein))
  :index (:permanent :key protein)
  :realization
    (:etf (pre-mod)
     :noun ("c-terminal" "c-terminus" "C-terminal" "C-terminus") ; 
     ;;:o protein
     :m protein
     :of protein))




;;;----------
;;; Pathways
;;;----------
; diverse signaling pathways
; specific effector pathways
; specific effector pathway(s)
; the Raf/MEK/ERK pathway
; MAPK pathway inhibitors / inhibition

(define-category  pathway
  :specializes bio-mechanism
  :instantiates :self
  :mixins (type-marker biological)
  :binds ((protein-sequence sequence)
          (pathwayComponent) (pathwayOrder) 
          (organism (:or organism species)))
  :index (:permanent :key name)
  :lemma (:common-noun "pathway")
  :realization (:common-noun name)
  :documentation "Pathways are inhibited and activated
   which makes them more like entities than processes.
   They are named according to the sequence of proteins
   (protein families) in the causal chain.")

(define-category PathwayStep :specializes bio-process
  :binds ((pathway pathway)
          (nextStep PathwayStep)       
          (stepProcess (:or control pathway catalysis 
                            biochemical-reaction bio-transport)))
  :instantiates :self
  :index (:permanent :key name)
  :lemma (:common-noun "step")
  :realization (:common-noun name))

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
          (error "Cannot identify a protein named ~s~
                ~%Maybe extend get-protein to an additional ~
                  caps variant?" name))
        (push protein proteins)))
    (setq proteins (nreverse proteins))
    (let ((sequence (create-sequence proteins))
          (name (create-slash-separated-string strings-naming-proteins)))
      (let ((i (find-or-make-individual 'pathway :name name)))
        ;;/// make a lowercase version?
        (setq i (bind-dli-variable 'protein-sequence sequence i))
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

(def-pathway "Ras" "Raf" "MAPK")

(def-pathway "MEK" "ERK")

(def-pathway "Raf" "MAPK")


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
; Wikipedia for 'transcription factor'
;    factor – a substance, such as a protein, that contributes to 
;      the cause of a specific biochemical reaction or bodily process
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


(define-category apoptosis  ;; aka cell death
  :specializes bio-process
  :binds ((process bio-process)(object biological)) ;; should be cell
  :realization
  (:etf pre-mod
        :noun "apoptosis" :adj "apoptotic"
        :m process
        :of object
        :in object))

(define-category  autophagy;; like apoptosis
  :specializes bio-process
  :binds ((process bio-process)(object biological)) ;; should be cell
  :realization
  (:etf pre-mod
        :noun "autophagy" 
        :m process
        :of object))

(define-category senescence ;; aka cell death
  :specializes bio-process
  :binds ((process bio-process)(object biological)) ;; should be cell
  :realization
  (:etf pre-mod
        :noun "senescence" :adj "senescent"
        :m process
        :of object
        :in object))


(adj "pro-apoptotic" :super apoptosis)



;;; accumulation 

; that ERK1 nuclear accumulation increased
; ERK1-4 ... accumulated in the nucleus to the same level as ...


;;;-----------------------------------
;;; dimers and their fellow travelers 
;;;-----------------------------------

;;------------------------ binding ----------------
; Have to include binding here because dimerize inherits 
; from it and this file is loaded before the verbs are
;/// We could change that.

;; "GTP-binding" "GO:00055525
;; from http://www.ebi.ac.uk/QuickGO/GTerm?id=GO:0005525
;; "interacting selectively and non-covalently with GTP"
;;
(define-category binding  :specializes molecular-function
  ;;:obo-id 
  :bindings (uid "GO:0005488")
  ;; "<binder> binds to <binde>" the subject moves
  :binds ((binder (:or molecule protein-domain bio-entity))
          (bindee (:or molecule protein-domain bio-entity))
          (binding-set (:or molecule protein-domain)) ;; this is conjunctive, as in "binding between X and Y"
          (direct-bindee molecule)(site molecular-location)
          (domain protein-domain)
          (cell-site cellular-location))
  :realization 
  (:verb ("bind" :past-tense "bound" :present-participle "binding") ;; xxx is to prevent "binding" being a verb form
         :noun "binding"
         :etf (svo-passive) 
         :s binder
         :o  direct-bindee
         :to bindee
         :of bindee
         :via site
         :at site
         :at cell-site
         :to cell-site
         :with bindee
         :through domain
         :between binding-set))

(delete-verb-cfr (resolve "assemble"))
(delete-verb-cfr (resolve "assembles"))
(delete-verb-cfr (resolve "assembled"))
(delete-verb-cfr (resolve "assembling"))

(define-category assemble
    :specializes binding
    :binds ((binder (:or protein molecule protein-domain bio-entity))
            (bindee (:or protein molecule protein-domain bio-entity))
            (result bio-complex))
    :realization
    (:verb "assemble" ;; keyword: ENDS-IN-ED 
	   :noun "assembly"
	   :etf (svo-passive)
	   :s binder
	   :o bindee
           :into result
           :of bindee))

;; added in notion of direct-bindee for "A binds B" as opposed to "A binds to B"


; From the ERK abstract:
; #1 "Dimerization-independent" (in title)
; #6 "dimerization of ERK"
; #7 "shown consistently to be dimerization-deficient in vitro"
; #7 "dimerization of ERK1"
; #8 "did not detect dimerization of GFP-ERK1-WT upon activation"
; #10 "is a consequence of delayed phosphorylation of ERK by MEK rather than dimerization."
(define-category dimerize :specializes binding
  :binds ((monomer protein))
  :realization
  (:verb "dimerize" 
   :noun "dimerization"
   :etf (sv of-nominal)
   :s monomer
   :o monomer
   :of monomer
   :with monomer))

(define-category heterodimerize :specializes binding
  :binds ((monomer protein))
  :realization
  (:verb "heterodimerize" 
   :noun "heterodimerization"
   :etf (sv of-nominal)
   :s monomer
   :o monomer
   :of monomer
   :with monomer))

(define-category homodimerize :specializes binding
  :binds ((monomer protein))
  :realization
  (:verb "homodimerize" 
   :noun "homodimerization"
   :etf (sv of-nominal)
   :s monomer
   :o monomer
   :of monomer
   :with monomer))

(define-category homo/heterodimerize :specializes binding
  :binds ((monomer protein))
  :realization
  (:verb "homo/heterodimerize" 
   :noun "homo/heterodimerization"
   :etf (sv of-nominal)
   :s monomer
   :o monomer
   :of monomer
   :with monomer))


(define-category bio-complex 
  ;; changed -- complexes are not molecules, but associated groups of
  ;; molecules, often preteins, but not always
  :specializes bio-chemical-entity
  :mixins (reactome-category)
  :binds ((component (:or bio-complex small-molecule protein))
          (componentstoichiometry stoichiometry)) 
  :realization
  (:noun "complex"
         :etf pre-mod
         :premod component
         :m component
         :with component
         :of component
         :between component))

(define-category tricomplex
  :specializes bio-complex
  :mixins (reactome-category)
  :binds ((component (:or bio-complex small-molecule protein))
          (componentstoichiometry stoichiometry)) 
  :realization
  (:noun "tricomplex"
         :etf pre-mod
         :premod component
         :m component
         :with component
         :of component
         :between component))


; From the ERK abstract:
; #1 "Dimerization-independent" (in title)
; #6 "dimerization of ERK"
; #7 "shown consistently to be dimerization-deficient in vitro"
; #7 "dimerization of ERK1"
; #8 "did not detect dimerization of GFP-ERK1-WT upon activation"
; #10 "is a consequence of delayed phosphorylation of ERK by MEK rather than dimerization."
(define-category dimerize
  :specializes binding
  :binds ((monomer protein))
  :realization
  (:verb "dimerize" 
   :noun "dimerization"
   :etf (sv of-nominal)
   :s monomer
   :o monomer
   :of monomer))


(define-category dimer
  :specializes bio-complex
  :binds ((component (:or bio-complex small-molecule protein))
          (componentstoichiometry stoichiometry)) 
  :realization
  (:noun "dimer"
         :etf pre-mod
         :premod component
         :m component
         :with component
         :of component
         :between component))



(define-category heterodimer
  :specializes bio-complex
  :binds ((component (:or bio-complex small-molecule protein))
          (componentstoichiometry stoichiometry)) 
  :realization
  (:noun "heterodimer"
         :etf pre-mod
         :premod component
         :m component
         :with component
         :of component
         :between component))

; Dec32: C-RAF activation and heterodimerization with B-RAF constitute critical components
; Dec33: endogenous C-RAF:B-RAF heterodimers
(define-category heterodimerization
  :specializes bio-process
  :instantiates :self
  :lemma (:common-noun "heterodimerization"))


(define-category homodimer
  :specializes bio-complex
  :binds ((component (:or bio-complex small-molecule protein))
          (componentstoichiometry stoichiometry)) 
  :realization
  (:noun "homodimer"
         :etf pre-mod
         :premod component
         :m component
         :with component
         :of component
         :between component))

; Dec32: C-RAF activation and heterodimerization with B-RAF constitute critical components
; Dec33: endogenous C-RAF:B-RAF heterodimers
(define-category homodimerization
  :specializes bio-process
  :instantiates :self
  :lemma (:common-noun "homorodimerization"))



