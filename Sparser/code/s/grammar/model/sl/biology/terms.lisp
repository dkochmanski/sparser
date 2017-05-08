;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER COMMON-LISP) -*-
;;; Copyright (c) 2014-2017 SIFT LLC. All Rights Reserved
;;;
;;;    File: "terms"
;;;  Module: "grammar/model/sl/biology/
;;; version: January 2017

;; Initiated 7/23/14 by lifting proteins from NFkappaB experiment.
;; Moved proteins out to their own file 9/8/14
;;; temporary home for rules
;;; gene  --> mutate gene
;;; enzyme --> bio-process enzyme
;;; move out oncoogene to taxonomy, and mutate to be a verb (so mutated is a past participle)
;; 11/9/14 hack for ', in part,' and terms for g1,...,g5, 'as a consequence' and .exchange' as a bio-process
;; added critical, common, "tumor formation", first stab at "form", revised "condition", revised "G-domain"
;; 12/8/14 Starting cell lines and drugs
;; RJB 12/13/2014 ugly handling of variety, form and analog <<DAVID-- we have to talk about this>>
;; also ugly handling of "et al." to start making it a signal for references, 
;; and get rid of the interpretation of "al." as a bio-entity (couldn't even find where that cam from)
;; RJB 12/14/2014 Added a bunchof stand-in definitions for words that were primed by COMLEX, added cell-line definitions (some) -- need help from <<DAVID>>
;; add MEK/ERK and ERK/MEK as pathway designators, try to define S338 as a residue
;; diverse vocabulary hacking
;; 02/18/15 alphabetized terms
;; 4/24/2015 added subject variable for many adjectives that can be copular adjectives
;; 4/27/2015 improve handling of "serum" and "fetal calf serum" and "open reading frame" using def-synonym
;; 5/15/2015 substantial revision in taxonomy to drastically reduce the overloading of bio-process,
;;  provide bio-rhetorical as a marker for verbs that talk about belief and truth, bio-event for actions that are not bio-processes in the OBO sense, bio-relation for things like
;;  contain, sonstitute, etc.
;;  concomitant revision for things like thatcomp and whethercomp
;;  5/30/2015 Rename poorly named "predicate" to "bio-predication" and update dependencies
;;  bunch of vo cabulary tweaks for test set -- at the beginning of the file temporarily
;; 6/5/2015 DAVID!! There is a temporary fix for the problems with interpreting "the next day" -- make it into a polyword
;;  the underlying problem needs to be fixed (by you)
;; 6/8/2015 added a bunch of plasmids
;; 6/10/15 Commented out "c" and "h" for clobbering more frequent interpretations


(in-package :sparser)

(noun "http://" :super abstract) ;; avoid an NS error





(noun "cell adhesive  structure" :super cellular-location)





;;from pathway comments

(adj "open" :super bio-relation)
(define-category member :specializes biological ;; NOT SURE WHAT TO DO HERE
 :binds ((set biological))
 :realization
 (:noun "member"
        :of set))

(noun "chemical product" :super bio-chemical-entity)


;; below is needed because of a use of "transients" in the CURE corpus
(define-category transient-measurement :specializes bio-measurement
  :realization  (:noun ("transientXXX" :plural "transients"))) ;; don't pick up "transient" from COMLEX, and don't allow "transient" as a singular noun




;; Moved in from dossiers/modifiers.lisp
(define-adverb "biochemically")
(define-adverb "biologically")
(define-adverb "chemically")
(define-adverb "endosymbiotically")
(define-adverb "enzymatically")
(define-adverb "homeostatically")
(define-adverb "metabolically")
(define-adverb "mitotically")

(define-adjective "bioactive")
;; (define-adjective "biological") -- never never. Kills the mixin
(define-adjective "cancerous")
(define-adjective "catalytic")
(define-adjective "chromosomal") ;chromosome
(define-adjective "embryonic")
(define-adjective "endothelial") ; endothelium is noun
(define-adjective "epidermal")
(define-adjective "epigenetic")
(define-adjective "epithelial")
(define-adjective "extracellular" :form 'spatial-adjective)
(define-adjective "genetic")
(define-adjective "genomic") ;genome
(define-adjective "hematopoietic")
(define-adjective "heterotypic")
(define-adjective "histopathological")
(define-adjective "homeostatic")
(define-adjective "immune")
(define-adjective "immunosuppressive")
(define-adjective "intracellular" :form 'spatial-adjective)
(define-adjective "intratumoral" :form 'spatial-adjective)
(define-adjective "medical")
(define-adjective "metabolic")
(define-adjective "metastatic")
(define-adjective "mitochondrial")
(define-adjective "mitogenic")
(define-adjective "molecular")
(define-adjective "multicellular")
(define-adjective "necrotic")
(define-adjective "neoplastic")
;;(define-adjective "non-neoplastic")
(define-adjective "nonclonal")
(define-adjective "nonmutational")
(define-adjective "oncogenic")
(define-adjective "pericellular" :form 'spatial-adjective)
(define-adjective "peritumoral" :form 'spatial-adjective)
(define-adjective "physiologic")
(define-adjective "pituitary")
(define-adjective "premalignant")
(define-adjective "preneoplastic")
(define-adjective "proangiogenic")
(define-adjective "proapoptotic") ;should explicitly relate to apoptosis?
(define-adjective "proinflammatory") 
(define-adjective "proliferative") ;opposite: "antiproliferative" or "nonproliferative"
(define-adjective "proteolytic")
(define-adjective "renal") ;kidney
(define-adjective "replicative") 
(define-adjective "somatic")
(define-adjective "stromal") ;stroma
(define-adjective "telomeric") ;telomere
(define-adjective "therapeutic") ;related to therapy
(define-adjective "tractable")
(define-adjective "transcriptional") ;transcription: process
(define-adjective "transmembrane")
(define-adjective "tumorigenic") ;tumorigenesis





(noun "HA.11" :super epitope)

(noun "bradykinin" :super peptide)
(noun "Abeta" :super peptide)
(noun "AICAR" :super peptide)
(def-synonym abeta (:noun "amyloid beta"))
;; to be reviewed -- from Localization





(noun "dextran" :super polysaccharide)



(define-category equivalent :specializes bio-relation
  :realization
  (:adj "equivalent"
	:to theme))

(define-category prerequisite :specializes bio-relation
  :realization
  (:adj "prerequisite" ;;deacetylation of GR by HDAC2 may be prerequisite for GR association with the p65–NF-κB–activated complex
	:noun "prerequisite"
	:for theme))


;;lipids
;; in EGFR signaling comments
(noun ("DAG" "diacylglycerol") :super lipid)
(noun "Sphingosine" :super lipid)
(noun ("IP3" "inositol 1,4,5-triphosphate") :super phospholipid) 
(noun ("PIP2" "phosphatidylinositol 4,5-bisphosphate" "phosphatidylinositol-4,5-bisphosphate" "phosphoinositol 4,5-bisphosphate") :super phospholipid)
(noun ("PIP3" "phosphatidylinositol 3,4,5-triphosphate" "phosphatidylinositol-3,4,5-trisphosphate") :super phospholipid)




;; new nouns and verbs used in Ras model comments

(define-category coincident 
                 :specializes bio-relation
  :realization
  (:adj "coincident"
        :with theme))


(define-category guanyl-nucleotide-exchange :specializes nucleotide-exchange
  :realization
  (:noun "guanyl-nucleotide exchange"))

;;(noun "king" :super abstract) ;; actually an author's name, but treated as a verb because of morphology
(noun "bond" :super bio-entity) ;; chemical bond -- not 


;;/// N.b. the rule is written over the literal "fold"
(define-category n-fold :specializes measurement
  :binds ((number number))
  :realization
  (:noun "fold"
         :m number))
;; only used in phrases like nnn-fold, this is here to suppress the
;;  attempt to ascribe a biological meaning to the verb



(noun "adenocarcinoma" :super disease)
(noun "anaphylaxis" :super disease)
(noun "metaplasia" :super disease)
(noun "hyperplasia" :super disease)
(noun "anchor" :super molecule) ;; "cytoplasmic anchor"

(noun "carcinoma" :super cancer)
(noun "glioblastoma" :super cancer)
(noun "keratoacanthoma" :super cancer)
(noun "neurooblastoma" :super cancer)
(noun "NSCLC" :super cancer)
(def-synonym NSCLC (:noun "non-small cell lung cancer"))
(noun "non-small cell lung cancer" :super cancer)
(def-synonym NSCLC (:noun "non small cell lung cancer"))

(noun "isomerase" :super enzyme)
(noun "ligase" :super enzyme)
(noun "ubiquitinase" :super enzyme)
(noun "deubiquitinase" :super enzyme)
(noun "neurofibromatosis" :super disease)

(adj "mammalian" :super species)

(define-adverb "sterically")


;;proteins from comments -- TO-DO move out to proteins file and do correctly
(define-protein "LAMTOR2" ("LAMTOR2" "MEK partner 1" "MP1"))
(define-protein "LAMTOR3" ("LAMTOR3"))
(define-protein "KBTBD7 E3 RING" ("KBTBD7 E3 RING" ))
(define-protein "KBTB7_HUMAN" ("KBTBD7"))

;; strange words used in 493 articles -- leads to incorrect stemming in COMLEX lookups

#-allegro (noun "O2˙-" :super molecule) ;; :synonyms ("superoxide anion")
(noun "MeHg" :super molecule)
(def-synonym MeHg (:noun "methyl mercury"))
(noun "brain" :super bio-organ)
(noun "colon" :super bio-organ)
(noun "breast" :super bio-organ)
(noun "eye" :super bio-organ)
(noun "prostate" :super bio-organ)
(noun "kidney" :super bio-organ)
(define-category pancreas :specializes bio-organ
  :realization
  (:noun "pancreas" :adj "pancreatic"))

(define-category liver :specializes bio-organ
  :realization
  (:noun "liver" :adj "hepatic"))

(define-category lung :specializes bio-organ
  :realization
  (:noun "lung"))

(noun "trophectoderm" :super bio-organ)
(def-synonym trophectoderm (:noun "TE"))

(define-category inner_cell_mass :specializes bio-organ
              :realization (:noun "inner cell mass" ))
(def-synonym inner_cell_mass (:noun "ICM"))

(noun "lactate" :super molecule)

#-allegro (noun "pcDNA3.1-PPARγ" :super plasmid)
(noun "pcDNA3.1-Med1" :super plasmid)
(noun "pCMX-Med1" :super plasmid)
(noun "pcDNA3.1-PIMT" :super plasmid)
(noun "pcDNA3.1-PIMT-N" :super plasmid)
(noun "pCMV-PIMT-Flag" :super plasmid)
(noun "3XPPRE-Luc" :super plasmid)
(noun "GST-PIMT-N" :super plasmid)
(noun "GST-Med1-CRAF-BXB" :super plasmid)
(noun "pCMV-ERK2-HA" :super plasmid)


(noun "carcinogen" :super bio-agent)
;;(def-synonym not (:adj "non"))

(noun "CML" :super disease)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(noun "bar" :super abstract) 
;;Error: Comlex -- new POS combination for "#<word "bar">:: (NOUN PREP VERB)
;; DROPPING THIS CAUSES A MASSIVE ERROR ON CURE 38
(noun ("mouse" :plural "mice") :super species)
(noun "Xenopus" :super species)
(noun "zebrafish" :super species)


(noun "32P" :super molecule) 
;; actually an isotope -- need to adjust taxonomy 



(noun "abnormality" :super disease)

(define-category activator :specializes molecule
  :binds ((activated molecule))
  :realization
  (:noun "activator"
         :of activated))

(def-bio "adenine" nucleobase)
(noun "agonist":super molecule) ;; keyword: (ist N) ;; 
(define-category affinity :specializes bio-relation
     :binds ((object bio-entity))
     :realization
     (:noun "affinity"
            :for object))


;; Usually in a hyphenated construction. Idiomatically as a XXXXXXX
;; marker and generally: "anti-inflammatory"
(adj "anti" :super bio-predication)

(define-category antibody :specializes protein
  :binds ((antigen molecule))
  :realization
  (:noun ("antibody" "anti-")
         :m antigen
         :to antigen
         :for antigen))


(define-category assay :specializes measure
  :realization
  (:noun "assay"))
                

(noun "bacteria" :super species) ;; not really
(noun "binder" :super bio-entity)


;; OBE (noun "concentration" :super bio-scalar) ;;levels of incorporated 32P (January sentence 34)
;;(noun "condition" :super experimental-condition) OBE -- i taxonomy



(def-bio "cytosine" nucleobase)


(define-category data :specializes measurement
		 :realization
		 (:noun ("datum" :plural "data")))

;; "the DSB repair defect", "a defect in sensitivity to GAP–mediated regulation"
(noun "defect" :super bio-relation
      :realization 
      (:NOUN "defect"
             :m theme
             :in theme))

;; Something is deficient in something else. It needs that
;; thing but doesn't have it. Vitamin D, 
;; ERK#7 "to be dimerization-deficient in vitro"
(adj "deficient" :super bio-relation
  :realization
    (:adj "deficient"
     :noun "deficiency"
     :m theme
     :in theme))

(noun "derivative" :super molecule)
(noun "detail" :super abstract)

(noun "disorder" :super disease)


(noun "dynamics" :super bio-scalar)


(adj "effective" :super bio-relation
     :realization 
     (:adj "effective"
           :against theme
           :in theme
	   :on theme))

(define-category effector :specializes protein ;; NOT SURE WHAT THE RIGHT SUPER is
  :binds ((for-process bio-process))
  :realization
  (:noun "effector" 
         :for for-process
         :in for-process))


(noun "extent" :super bio-scalar) 

(define-category fact :specializes bio-rhetorical
      :mixins (bio-thatcomp)
      :realization
      (:noun "fact"))








(define-category fragment :specializes protein ;; not sure, but perhaps is always a protein -- can be phospohorylated
      :binds ((whole bio-entity)
              ;; bio-scalar is for "a  fragment of the same mass as ..."
              (measure (:or measurement bio-scalar)))
      :realization
      (:noun ("fragment" "subunit")
             :of whole
             :of measure))



;; keyword: (ive ADJ) 



(def-bio "guanine" nucleobase)


;; "However" is actually a subordinate conjunction.
;; It can appear in adverbial positions as an interjection
;;/// but the correct fix is in the grammar.

(noun "human" :super species)

(adj "ineffective" :super bio-relation
     :binds ((against biological))
     :realization 
     (:adj "ineffective"
           :against against)) ;; keyword: (ive ADJ) 

(define-category inhibitor :specializes drug
  :binds ((process (:or bio-process bio-mechanism))
          (protein protein))
  :realization (:noun "inhibitor" :m process :m protein :of process :of protein))


;; THIS NEEDS WORK
(define-category repressor :specializes inhibitor
  :realization (:noun "repressor"))

(define-category suppressor :specializes inhibitor
  :realization (:noun "suppressor"))

(define-category negative-regulator :specializes inhibitor
  :realization (:noun "negative regulator"))

(adj "insensitive" :super bio-relation
      :realization
      (:adj "insensitive"
             :to theme))
   
(noun "insensitivity" :super bio-scalar ;; HUH?
      :binds ((cause biological))
      :realization
      (:noun "insensitivity"
             :to cause))
(noun "insight" :super bio-rhetorical
      :binds ((concept biological))
      :realization
      (:noun "insight"
             :into concept))

;;In biochemistry, a protein ligand is an atom, a molecule or an ion that can bind to a specific site (the binding site) on a protein. 
(noun "ligand" :super bio-chemical-entity)

(noun "linker" :super molecule) ;; not sure if it is a protein or short stretch of DNA in the case used

(define-category lysate :specializes bio-entity
  :realization
  (:noun "lysate"))

(def-bio "adenine" nucleobase)
(noun "LPA" :super phospholipid)
(def-synonym lpa (:noun "lysophosphatidic acid"))

(noun "mass" :super bio-scalar)
           
(define-adverb "mechanistically")

(noun "membrane" :super cellular-location)
(noun "miR-26A" :super micro-rna)
(noun "miR-26A2" :super micro-rna)
(def-synonym miR-26A2
             (:noun "MIR26A2"))
(noun "miR-26A1" :super micro-rna)
(def-synonym miR-26A1
             (:noun "MIR26A1"))
(noun "mitogen" :super molecule)


(noun "mortality" :super bio-abstract) ;;/// relationship to "mortal" ??


(adj "necessary" :super bio-relation
     :binds ((condition biological)
             ;;(agent biological)
             (necessary-to biological))
     :realization 
     (:adj "necessary"
           :for necessary-to
           :to necessary-to
           :to-comp necessary-to))

(define-adverb "notably")

;; These three want to be synonyms
(noun "frame" :super bio-entity)
(noun "open reading frame" :super bio-entity)
(noun "open reading frames" :super open-reading-frame)
(def-synonym open-reading-frame (:noun "ORF")) ;; same as above -- need to figure out how to get the category spelling right

(define-category order-of-magnitude :specializes unit-of-measure
  :realization
  (:noun ("order of magnitude"
          :plural "orders of magnitude")))

(noun "paradox" :super bio-entity)

(noun "partner" :super bio-abstract)
(noun "patient" :super bio-entity)



(noun "phenotype" :super bio-entity)
(noun "plasma" :super cellular-location)
(noun "population" :super bio-entity
      :binds ((element biological))
      :realization
      (:noun "population"
             :of element))  

(adj "potent" :super bio-relation
  :realization 
  (:adj "potent"))



(noun "proportion" :super bio-scalar)
(noun "proto-oncogene" :super oncogene)

(noun "receptor" :super protein)
(noun "receptor protein" :super protein)
(noun "receptor protein-tyrosine kinase" :super kinase)
(adj "refractory" :super bio-relation
     :realization
     (:to theme))
     ;; keyword: (ory ADJ)


(adj "relative" :super bio-relation
     :restrict ((subject scalar-quality))
     :realization
     (:to theme))

(define-category resistant :specializes bio-relation
     :binds ((treatment (:or bio-process bio-entity)))
     :realization
     (:adj "resistant"
	   :noun "resistance"
           :to treatment))


(define-category responsive :specializes bio-relation
  :realization
  (:noun  "responsiveness"
          :adj "responsive"
          :verb "respond"
          :etf (sv)
          :to theme
          :m theme))

(noun "rna" :super molecule)

(noun "scaffold" :super protein) 
(noun "scale" :super bio-scalar)     
(adj "selective" :super bio-relation
     :realization (:for theme))

(adj "sensitive" :super bio-relation
      :realization
      (:adj "sensitive"
             :to theme))

(noun "sensitivity"  :super bio-scalar
      :binds ((cause biological))
      :realization
      (:noun "sensitivity"
             :to cause))


 
;; Jan 29 "two MAPK phosphorylation sites in ASPP1 and ASPP2."
;; Jan 14 "mutation of the primary site of monoubiquitination"
;; 16 "mUbRas, modified at a single site, "
(noun "site" :super molecular-location
  :binds ((process bio-process)
          (kinase protein)
	  (substrate protein)
	  ;;(kinase-or-substrate protein)
          (residue residue-on-protein))
  :realization
     (:noun "site"
      :m process
      :m residue
      :m kinase
      :m substrate
      ;;:m kinase-or-substrate
      :of process
      :for process
      :in substrate
      :on substrate
      :at residue))

(noun "docking site" :super site)

(adj "specific" :super bio-relation
     :binds ((situation biological)(beneficiary biological))
     :realization
     (:adj "specific"
           :to situation
           :for beneficiary))

(define-category substrate :specializes bio-chemical-entity
      :binds ((enzyme protein))
  :realization
  (:noun "substrate"
         :of enzyme
         :for enzyme))

(adj "suitable" :super bio-relation
     :realization
     (:adj "suitable"
           :for theme))





(noun "surface area" :super molecular-location)
(define-adverb "surprisingly")

(noun "throughput" :super measurement)

(noun "tissue" :super bio-organ)



(noun "tumor" :super non-cellular-location)
(adj "unable" :super bio-relation
     :binds ((capability bio-process))
     :realization
     (:adj "unable"
           :to-comp capability))
           

(adj "unresponsive" :super bio-relation
     :binds ((treatment (:or bio-process bio-entity)))
     :realization
     (:adj "unresponsive"
           :to treatment))

(adj "useful" :super bio-relation
     :binds ((purpose (:or bio-process bio-method)))
     :realization
     (:adj "useful"
           :for purpose))

;; need to handle "for X to Y" as a to-comp




;;;------------
;;; cell lines
;;;------------
; were expressed in HEK293T cells
; BRAF mutant thyroid cell lines
; HER2-amplified breast cancer cell lines
; breast carcinoma cell lines
; all six BRAF-mutant thyroid cancer cell lines
; increased basal HER3 in 8505C cells
; confirmed in a second cell line
; our panel of cancer cell lines (Figure 6A).
; the HCC827 NSCLC cell line


(def-synonym cell-line (:noun "line"))
(def-synonym cell-line (:noun "cell line"))
(def-synonym cell-line (:noun "cell"))
(def-synonym cell-line (:noun "cultured cell"))
(def-synonym cell-line (:noun "cultured cell line"))

(defun def-cell-line (line)
  (def-bio/expr line 'cell-line :takes-plurals nil))


(noun "keratin" :super cell-type) ;; NOT SURE THIS IS HOW IT IS BEING USED
(noun "keratinocyte" :super cell-type)
(def-cell-line "cancer cell")


(def-cell-line "A375")
(def-cell-line "A431D")
(def-cell-line "A431")
(def-cell-line "C140")
(def-cell-line "D04")
(def-cell-line "D25")
(def-cell-line "DU-145")
(def-cell-line "MM415")
(def-cell-line "MM485")
(def-cell-line "OUMS-23")
(def-cell-line "PC12") ;; want to get effect of  :synonyms ("PC 12") as well
(def-cell-line "RPMI-7951")
(def-cell-line "SkMel24")
(def-cell-line "SkMel28")
(def-cell-line "WM266.4")
(def-cell-line "WM852")
(def-cell-line "HeLa")
(def-cell-line "hBRIE")
(def-cell-line "HEK293")
(def-cell-line "HEK293T")
(def-cell-line "HKe3 ER:HRASV12")
(def-cell-line "HKe3 ER:HRAS12")
(def-cell-line "HKe3")
(def-cell-line "KNRK")
(def-cell-line "LAT-3YF")
(def-cell-line "LAT3YF")
(def-cell-line "MDCK")
(def-cell-line "MDA-MB-468")
(def-cell-line "NIH-3T3")
(def-cell-line "Saos2")
(def-cell-line "VMM12")
(def-cell-line "VMM18")
(def-cell-line "VMM39")
(def-cell-line "VMM5A")

;;(def-cell-type "mouse embryo fibroblast") ;; CORRECTED -- was not sure this is right -- it is a type of cell, but...
;;A fibroblast is a type of cell that synthesizes the extracellular matrix and collagen,[1] 
;; the structural framework (stroma) for animal tissues, and plays a critical role in wound healing. 
;; Fibroblasts are the most common cells of connective tissue in animals.
(noun "fibroblast" :super cell-type)
(noun "leukocyte" :super cell-type)
(noun "astroocyte" :super cell-type)
(noun "neuron" :super cell-type)


;;;------------------
;;; Units of measure
;;;------------------
;;-- see model/dossiers/units-of-measure.lisp for more forms.


(define-unit-of-measure "cm")
(define-unit-of-measure "dalton")
(define-unit-of-measure "kD")
(define-unit-of-measure "kb")
(define-unit-of-measure "mL")
(define-unit-of-measure "mg")
(define-unit-of-measure "ml")
(define-unit-of-measure "mg")
(define-unit-of-measure "mm")
(define-unit-of-measure "nM")
(define-unit-of-measure "ng")
(define-unit-of-measure "nm")
(define-unit-of-measure "pmol")
(define-unit-of-measure "pmol/min/mg")
(define-unit-of-measure "μm")
;;#+sbcl (define-unit-of-measure "μm")
;;(define-unit-of-measure "µm") this fails in ACL. Reading in UTF-8 ?



;;;-------------------------------------------------------
;;; Hacked up to 'get through' the 9/4/14 target abstract
;;;-------------------------------------------------------

(define-category document-part :specializes abstract)
(define-category bib-reference
   :specializes document-part) ;; to allow "et al." to be easily ignored

(define-category article-table
   :specializes document-part) ;; to allow "et al." to be easily ignored

(noun "et al." :super bib-reference)
(noun "et al.," :super bib-reference)

(noun "xref" :super bib-reference)


(define-category article-figure
  :specializes visual-representation
  :binds ((label two-part-label))
  :realization
  (:noun "figure"))

(def-synonym article-figure (:noun "Fig."))

(def-synonym article-figure (:noun "Fig"))

(define-category arrow :specializes visual-representation
		 :realization
		 (:noun "arrow"))

(define-category star :specializes visual-representation
		 :realization
		 (:noun "star"))

(define-category diagram :specializes visual-representation
		 :realization
		 (:noun "diagram"))


 
(def-cfr article-figure (article-figure two-part-label)
  :form proper-noun
  :referent (:head left-edge
             :bind (label right-edge)))

(def-cfr article-figure (article-figure number)
  :form proper-noun
  :referent (:head left-edge
             :bind (label right-edge)))


(noun "table" :super article-table)


(define-category article-table
  :specializes bio-abstract)


;;;------------------------------------------------------------------
;;; all remaining (including overlap with the nouns and verbs above)
;;;------------------------------------------------------------------
 

"auto" 
"binder"
"effect" 
"fate" 
"fig" 
"groups" 
"trials" 
; a {wide, large, extensive, big} variety of ..
;; "variety" is an "of quantifier" like "many" or "some"
;; Def-bio doesn't appreciate part of speech, so hacked the
;; Needs a whole model
;; activated forms of the Ras proteins
;; cellular "GO:0005623"
;; cytosolic "GO:0005829"
;; presenting plural version here. #52
;; these adverbs are added to make the simple subj+verb test succeed in the island-driving phase
;; we need better semantics for these <<DAVID>>
;;(noun "formation")
;;--- j5
;;--- j8
;;; new words to be defined -- were primed bhy COMLEX
;;adjective
;;adverb
;;need prep cases
;;noun
;;;POTENTIAL AMBIGUITIES TO BE SUPPRESSED
"express";;ambiguous between (ADJECTIVE :super bio-predication ADVERB NOUN VERB)
"show";;ambiguous between (NOUN VERB)
"describe"
"paradigm"
"maintain"
"keep";;ambiguous between (NOUN VERB)
"approach";;ambiguous between (NOUN VERB)
"elucidate"
"escape";;ambiguous between (NOUN VERB)
"fate";;ambiguous between (NOUN VERB)
"membrane"
"scaffold"
"know";;ambiguous between (NOUN VERB)
"component";;ambiguous between (ADJECTIVE NOUN)
"wild";;ambiguous between (ADJECTIVE ADVERB)
"type";;ambiguous between (NOUN VERB)
"dead";;ambiguous between (ADJECTIVE ADVERB)
"derivative";;ambiguous between (ADJECTIVE NOUN)
"effect";;ambiguous between (NOUN VERB)
"resistance"
"candidate"
"screen";;ambiguous between (NOUN VERB)
"group";;ambiguous between (NOUN VERB)
"constitute"
"response"
"engender"
"target";;ambiguous between (NOUN VERB)
"observation"
"assay";;ambiguous between (NOUN VERB)


  










