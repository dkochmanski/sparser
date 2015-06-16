;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER COMMON-LISP) -*-
;;; Copyright (c) 2014-2015 SIFT LLC. All Rights Reserved
;;;
;;;    File: "proteins"
;;;  Module: "grammar/model/sl/biology/
;;; version: April 2015

;; initiated 9/8/14 lifting from other files
;; Made some of the proteins lower case, becasue both 
;; capitalized and lower case versions occur
;; 1/1/2015 attempt to fix problem with MEK not being defined as a word
;;  -- allow for members to be added to family after family is defined
;; attempt to get around order dependency for MEK1 and MEK -- BUT THAT WAS NOT THE BUG
;; OVER TO YOU, <<DAVID>>
;; 1/7/2015 added new "proteins" -- ubiquitin, hormone and histone, and stubs for mUbRAS and SAPK
;; new rule for protein --> (protein point-mutation) for "ubiquitin C77G"
;; 5/16/2015 add all of the protein information that is safe (does not redefine parens and brackets or defined words)
;;  about 1400 new proteins with several synonyms each
;; 5/30/2015 Give the MITRE-LINK the right UniProt: prefix,
;; add definitions for cadherin, Src, BCR-ABL and "poly(ADP–ribose)"

(in-package :sparser)

;;;---------------------------
;;; pattern-driven definition
;;;---------------------------

(defmacro define-protein (name IDS)
  (make-def-protein (cons name IDS)))

(defparameter *prot-synonyms* (make-hash-table :test #'equal))

(defun get-protein-synonyms (id)
  (gethash id *prot-synonyms*))

(defun make-def-protein (IDS)
  (let
      ((bpid (best-protein-id IDS)))
    `(def-bio ,bpid
              protein
       :synonyms ,(loop for id in IDS unless (or (equal id bpid)(search " " id)) collect id)
       :MITRE-LINK ,(if (search "_" bpid)
                        (format nil "UNIPROT:~A" bpid)
                        bpid))))

(defun best-protein-id (ids)
  (or
   (loop for id in ids when (search "_HUMAN" id) do (return id))
   (loop for id in ids when (search "PR:" id) do (return id))
   (car ids)))

(defun simp-protein (dp)
  (if
   (consp (third dp))
   dp
   `(define-protein ,(second dp) ,(cddr dp))))

(defun all-proteins ()
  (loop for s in *all-sentences*
    append
    (loop for e in (second s)
      when (or
            (itypep e 'protein)
            (itypep e 'protein-family))
      collect e)))

(defun pro-name (pro)
  (let ((name (value-of 'name pro)))
    (cond((polyword-p name) (pw-pname name))
         ((word-p name)(word-pname name)))))

(defun prot-name (prot)
  (when prot
    (or
     (pro-name prot)
     (get-mitre-id prot))))

(defparameter *prot-ht* (make-hash-table :test #'equal))
(defparameter *prot-cts* nil)
(defparameter *prots* nil)
(defparameter *nil-prots* nil)
(defparameter *aps* nil)
(defparameter *aaps* nil)
(defparameter *naps* nil)
(defparameter *named-proteins* nil)
(defparameter *unique-named-substrates* nil)
(defparameter *poorly-identified-proteins* nil)

(defun protein-name-count (proteins)
  (clrhash *prot-ht*)
  (loop for p in proteins
    do
    (push p (gethash (prot-name p) *prot-ht*)))
  (setq *prot-cts* nil)
  (maphash #'(lambda(name prots) (push (list name (length prots)) *prot-cts*)) *prot-ht*)
  (setq *prot-cts* (sort *prot-cts* #'> :key #'second))
  *prot-ht*)

(defun poorly-identified-proteins()
  (declare (special *prots* *aps* *aaps* *naps* *named-proteins* *poorly-identified-proteins* 
                    *unique-named-substrates*))
  (length (setq *prots* (all-proteins)))
  (protein-name-count *prots*)
  (length (setq *nil-prots* (gethash nil *prot-ht*)))
  ;;(loop for i from 1 to 30 collect (print (retrieve-surface-string (nth i nil-prots))) (nth i nil-prots))
  (length (setq *aps* (all-phosphorylations)))
  (length (setq *aaps* (loop for a in *aps* when (get-protein-substrate (car a)) collect (car a))))
  (length (setq *naps* (loop for a in *aps* unless (get-protein-substrate (car a)) collect (car a))))
  (length 
   (setq *named-proteins* (loop for a in *aaps* when (prot-name (car (get-protein-substrate a))) 
                            collect (prot-name (car (get-protein-substrate a))))))
  (setq *unique-named-substrates* (remove-duplicates *named-proteins* :test #'equalp))
  (setq *poorly-identified-proteins*
        (loop for s in *unique-named-substrates* unless (or (search "PR:" s)(search "_" s)) collect s)))


(defun protein-desc (pro)
  (when (pro-name pro)
    (let
        ((st (semtree pro)))
      `(,(symbol-name (cat-symbol (car (indiv-type (car st))))) (:name ,(pro-name pro)),@(cdr st)))))



(defun reify-p-protein-and-make-edge (words start-pos end-pos)
  ;; Called from resolve-ns-pattern on (:single-cap :digits).
  ;; Looks for a "p" and if it finds it makes a protein. 
  ;; E.g "suggesting that p38 SAPK was active" in Jan #34
  (push-debug `(,words ,start-pos ,end-pos))
  (when (string= "p" (word-pname (first words)))
    ;; take template from reify-residue-and-make-edge
    (when *work-on-ns-patterns*
      (break "stub: possible p protein?"))))

;;;--------------------------------------------
;;; for (some of) the abstract in the proposal
;;;--------------------------------------------

;; found in the article set
#+ignore
(def-bio "E-cadherin" protein)



#+ignore
(def-bio "Src" protein :MITRE-LINK "UNIPROT:SRC_HUMAN")

(def-bio "BCR-ABL" protein)
(define-protein "PARP1_HUMAN" ("poly(ADP–ribose) 1"))
(define-protein "PARP2_HUMAN" ("poly(ADP–ribose) 2"))
(define-protein "PARP3_HUMAN" ("poly(ADP–ribose) 3"))


#+ignore
(def-bio "NFAT5_HUMAN" protein :synonyms ("NF-AT5" "NFAT5") :MITRE-LINK "NFAT5_HUMAN")


(define-protein "PKNA_MYCTU" ("pknA")) ;; bacterial protein -- have to look at why it shows up in the articles
(define-protein "GSTP1_HUMAN" ("Glutathione S-transferase P"))


;; from June test
(define-protein "TGS1_HUMAN" ("PIMT" "TGS1" "HCA137" "NCOA6IP"))
(noun  "actin" :super protein)
(noun  "catenin" :super protein-family)

(define-protein "KSYK_HUMAN" ("Syk"))

#+ignore
(def-bio "Akt" protein
  :long "Protein kinase B"
  :synonyms ("PKB")
  :identifier "PR:31749")

#+ignore
(def-bio "IGF" protein
  :long "Insulin-Like Growth Factor"
  :identifier "PR:05019")

#+ignore
(def-bio "nfkappab2" protein 
  :identifier "PR:000011178" 
  :greek "kappa")

(def-bio "NF-kappab" protein 
  :identifier "GO:0071159" 
  :greek "kappa")

(def-bio "p100" protein :identifier "PR:000011178")

#+ignore
(def-bio "p120" protein :synonyms ("p120 GAP" "p120GAP"))

(def-bio "p52" protein)  ;; :identifier ??

#+ignore
(def-bio "p53" protein
  :mitre-link "Uniprot:P04637")

(def-bio "p38 SAPK" protein)


(define-protein "EGFR" ("ERBB1"))
;;(def-bio "ERBB2" kinase)
;;(def-bio "ERBB3" kinase)


(def-bio "NIK" kinase 
  :long "NF-kappaB-inducing kinase" 
  :identifier "GO:0004704"
  :greek "kappa")

(def-bio "IKKalpha" kinase 
  :long "IkappaB kinase alpha" 
  :identifier "PR:000001775"
  :greek ("kappa" "alpha"))


;;;-----------------------------------
;;; for an example in the starter kit
;;;-----------------------------------


#+ignore
(def-bio "APC" protein) 
;; n.b. could be mouse APC for all we know w/o context

(def-bio "GSK-3" protein)




;;;------------------------
;;; GTP, GDP, GEFs & GAPs
;;;------------------------

(def-bio "GTP" nucleotide
  :identifier "CHEBI:15996"
  :mitre-link "PubChem:6830")

(def-bio "GDP" nucleotide 
  :identifier "CHEBI:17552"
  :mitre-link "PubChem:8977")

;; "GO:0006184" "GTP loading and deactivated upon hydrolysis" ?????
;;  or "GTP hydrolysis"

;; Guanine "CHEBI:16235"
;; nucleotide "CHEBI:36976"
(def-bio "GEF" protein :synonyms ("guanine nucleotide exchange factors"))



(def-bio "GAP" protein :synonyms ("GTPase activating proteins"))
;; "pproteins" to avoid a literal on "proteins"

;; compositional version of the long forms would be better
;;/// are these small molecules like GDP or are the larger? -- protein
;; And these are families of particulars, not the particulars that are
;;  actually doing participating in the reactions

(def-bio "RasGRF1" protein
  :synonyms ( "RASGRF1")
  :mitre-link "Uniprot:Q13972")

(def-bio "RapGEF2" protein
  :synonyms ( "RAPGEF2")
  :mitre-link "Uniprot:Q17RH5")

(def-bio "RapGEF3" protein
  :synonyms ("RAPGEF3")
  :mitre-link "Uniprot:O95398")

(def-bio "RapGEF4" protein
  :synonyms ("RAPGEF4")
  :mitre-link "Uniprot:Q8WZA2")

(def-bio "RAPGEF5" protein
  :synonyms ("RAPGEF5")
  :mitre-link "Uniprot:Q92565")

(def-bio "RapGEF6" protein
  :synonyms ( "RAPGEF6")
  :mitre-link "Uniprot:Q8TEU7")


(def-bio "RasGAP" protein
  :synonyms ("Ras-GAP" "Ras GAP"));; ditto, or beef up morphology



(def-bio "RAPGEFL1" protein
  :mitre-link "Uniprot:Q9UHV5")

(def-bio "RasGEF1A" protein
  :synonyms ("RASGEF1A")
  :mitre-link "Uniprot:Q8N9B8")

(def-bio "RasGEF1B" protein
  :synonyms ("RASGEF1B")
  :mitre-link "Uniprot:Q0VAM2")

(def-bio "RasGEF1C" protein
  :synonyms ("RASGEF1C")
  :mitre-link "Uniprot:Q8N431")


(def-bio "RasGEF" protein
  :synonyms ("Ras-GEF" "Ras GEF")) ;; should do that automagically




;;;----------------------------------------------------
;;; for the September 4th Reactome supporting abstract
;;;----------------------------------------------------

#| Need a coordinated model of a family of proteins that 
appreciates they are all of a kind, that numbers and other
filligre may be used to distinguish them, etc.
|#

;;--- the Ras family

(def-bio "KRas" protein 
  :synonyms ("K-Ras" "K-RAS")
  :identifier "PR:0000009442" ;; gene is "PR:P01116" 
  :mitre-link "Uniprot:P01116")

(def-bio "HRas" protein      ;; Harvey Ras
  :synonyms ("H-Ras" "H-RAS" "HRAS")
  :identifier "PR:000029705" ;; gene is "PR:P01112")
  :mitre-link "Uniprot:P01112:")

(def-bio "NRas" protein
  :synonyms ("N-Ras" "N-RAS" "NRAS")
  :identifier "PR:000011416" ;; gene is "PR:P01111"
  :mitre-link "Uniprot:P01111")


(def-family "Ras" ;;//// need capitalization hacks
  :members ("KRas" "HRas" "NRas")
  :identifier "GO:0003930"
  :synonyms ("RAS")
  :long "GTPase") ;; RAS small monomeric GTPase activity


;;--- the RAF family

(def-bio "ARaf" protein
  :synonyms ("ARAF" "A-Raf")
  :mitre-link "Uniprot:P10398")
	
(def-bio "BRaf" protein 
  :identifier "PR:000004801"
  :synonyms ("B-Raf" "B-RAF")
  ;mitre-link "Serine/threonine-protein kinase B-raf"
  :mitre-link "Uniprot:P15056")

(def-bio "CRaf" protein
  :synonyms ("C-Raf" "C-RAF" "c-Raf" "c-RAF")
  :mitre-link "Uniprot:P04049")



(def-bio "Raf CAAX" protein)

(def-bio "RasA1" protein
  :synonyms ("RASA1")
  :mitre-link "Uniprot:P20936")

(def-bio "RasA2" protein
  :synonyms ("RASA2")
  :mitre-link "Uniprot:Q15283")

(def-bio "RASA3" protein
  :synonyms ("RASA3")
  :mitre-link "Uniprot:Q14644")

	
	
(def-bio "RASAL1" protein
  :mitre-link "Uniprot:O95294")

(def-bio "RASAL2" protein
  :mitre-link "Uniprot:Q9UJF2")

(def-bio "RASA4" protein
  :mitre-link "Uniprot:O43374")
	
	
	
;;--- the MAPK family
;; These are specific to serine, threonine, and tyrosine
;; says the Wikipedia

(def-bio "ERK1" protein 
  :identifier "PR:000000104"
  :synonyms ("ERK1 kinase" "MAPK3"
             "erk1" "mapk3")
  :mitre-link "Uniprot:P27361")

(def-bio "ERK2" protein
  :synonyms ("erk2" "MAPK1" "mapk1")
  :mitre-link "Uniprot:P28482")


;; and many more: ERK3 (MAPK6) and ERK4 (MAPK4), etc.
;; I don't understand the Wikipedia write up well enough

(def-family "MAPK"
  :members ("ERK1" "ERK2")
  :long "mitogen activated protein kinase" 
  :synonyms ("ERK" "extracellular signal-regulated kinase"
             "erk"))
;;/// one of these needs refinement
(def-family "ERK"
  :members ("ERK1" "ERK2")
  :long "mitogen activated protein kinase"
  :synonyms ("ERK" "extracellular signal-regulated kinase"
             "erk"
             "mitogen-activated protein kinase"))

(def-bio "ERK1-4" protein) ;; mutated form of ERK


;;--- The MEK family
;; This is part of an attempt to get a word rule attached to the string "MEK"
;; define the family before the conflicting lexical items MEK1 and MEK2 are defined
;;  and then add them as family members later

(def-bio "MEK1" protein
  :mitre-link  "Uniprot:Q02750")

(def-bio "MEK2" protein
  :mitre-link "Uniprot:P36507")

(def-family "MEK" 
  :members ("MEK1" "MEK2")
  :synonyms ("MEK1/2"))



;;--- These are in Matt's list, but I don't
;;  know anything about them

(def-bio "ASPP2" protein
  ;;  :long "Apoptosis-stimulating of p53 protein 2"
  ;; This will form a literal on "protein" that blocks its
  ;; proper run for reason frustrating but as yet undiagnozed
  :synonyms ("Bbp" ;; Bcl2-binding protein
             "p53BP2") ;; tumor suppressor p53-binding protein 2
  ;; gene is TP53BP2
  :mitre-link "Uniprot:Q13625")
;; "ASPP2 plays a central role in regulation of apoptosis
;; and cell growth via its interactions. 
;; ASPP2 regulates TP53 by enhancing the DNA binding 
;; and transactivation function of TP53 on the promoters
;; of proapoptotic genes in vivo. 
;;ASPP2 binds to wild-type p53 
;; but fails to bind to mutant p53, 
;; suggesting that ASPP2 may be involved in the ability of 
;; wild-type p53 to suppress transformation. 
;; ASPP2 induces apoptosis but no cell cycle arrest.

;; in the text, but not Matt's list
(def-bio "ASPP1" protein)

(def-family "ASPP"
  :members ("ASPP1" "ASPP2")
  :synonyms ("apoptosis-stimulating protein of p53"))


(def-bio "ATG5" protein
  :mitre-link "Uniprot:Q9H1Y0")	

(def-bio "GFP" protein
  :mitre-link "Uniprot:P42212")	

(def-bio "green fluorescent protein" protein
  :mitre-link "Uniprot:P42212")	

(def-bio "RapGEF1" protein
  :synonyms ("RAPGEF1")
  :mitre-link "Uniprot:Q91ZZ2")

(def-bio "RALGPS2" protein
  :synonyms ("RALGPS2")
  :mitre-link "Uniprot:Q86X27")

(def-bio "RALGPS1" protein
  :mitre-link "Uniprot:Q5JS13")

(def-bio "Q12967" protein
  :mitre-link "Uniprot:RALGDS")

(def-bio "Q9P212" protein
  :mitre-link "Uniprot:PLCE1")

(def-bio "Q76NI1" protein
  :mitre-link "Uniprot:KNDC1")
	

(def-bio "RGL1" protein
  :mitre-link "Uniprot:Q9NZL6")
	

(def-bio "RasGRP1" protein
  :synonyms ("RASGRP1")
  :mitre-link "Uniprot:O95267")

(def-bio "RasGRP2" protein
  :synonyms ("RASGRP2")
  :mitre-link "Uniprot:Q7LDG7")

(def-bio "RasGRP3" protein
  :synonyms ("RASGRP3")
  :mitre-link "Uniprot:Q8IV61")

(def-bio "RasGRP4" protein
  :synonyms ("RASGRP4")
  :mitre-link "Uniprot:Q8TDF6")

(def-bio "RasGRF2" protein
  :synonyms ("RASGRF2")
  :mitre-link "Uniprot:O14827")
	
	
	
(def-bio "SOS1" protein
  :mitre-link "Uniprot:Q07889")
	

(def-bio "RGL2" protein
  :mitre-link "Uniprot:O15211")

(def-bio "RGL3" protein
  :mitre-link "Uniprot:Q3MIN7")

(def-bio "RGL4" protein
  :mitre-link "Uniprot:Q8IZJ4")
	
	
	

(def-bio "NF1" protein
  :mitre-link "Uniprot:P21359")
	

(def-bio "IQGAP1" protein
  :mitre-link "Uniprot:P46940")

(def-bio "IQGAP2" protein
  :mitre-link "Uniprot:Q13576")

(def-bio "IQGAP3" protein
  :mitre-link "Uniprot:Q86VI3")
	
	
	

(def-bio "GAPVD1" protein
  :mitre-link "Uniprot:Q14C86")

(def-bio "DAB2IP" protein
  :mitre-link "Uniprot:Q7VWQ8")

(def-bio "SOS2" protein
  :mitre-link "Uniprot:Q07890")
	
	

(def-bio "SYNGAP1" protein
  :mitre-link "Uniprot:Q96PV0")
	



;;-------------- well known mutated protein


(def-bio "V600EBRAF" protein ;; need to figure out how to represent this variant in the ontology
  :synonyms ("B-RAFV600E" "V600EB-RAF" "BRAFV600E"))

(def-bio "RasG12V" protein ;; this is a variant
 )

;;------------- From here on down it's miscelany that
;;  I don't know how to codify

(def-bio "MAP" protein)


(def-bio "COT/TPL2" protein) ;; see if defining this leads to sentence 53 working consistently when run twice.
(def-bio "cot" protein
  :synonyms ("COT" "MAP3K8"))
(def-bio "trypsin" protein)



(def-bio "mek1dd" protein)
(def-bio "brafv" protein)





(def-bio "PIK3CA" protein
  :identifier "PR:000012719")


;; http://en.wikipedia.org/wiki/Growth_factor
;; Again, it's a family, not a particular
(def-bio "growth factor" protein-family)
(def-bio "growth-factor" protein-family)
(def-bio "growth receptor" protein-family)



(noun "hormone" :super protein)
(noun "histone" :super protein)
(noun "histone 2B" :super protein)


(def-bio "SAPK" protein) ;; class of stress activated proteins
;;(def-bio "ASPP2" protein),nameprotein 
(def-bio "GST-ASPP2" protein)
(def-bio "phospho-ASPP2" protein)

(def-bio "Ras17N" protein)

;;; proteins missing from the MITRE parts list, but found in the 30 articles
(define-protein "4EBP1_HUMAN" ("4EBP1_HUMAN" "4EBP1"))
(define-protein "A9YLD1_MEDTR" ("AA8"))
(define-protein "APEX1_HUMAN" ("APEX1" "APE" "APE1" "APEX" "APX" "HAP1" "REF1"))
(define-protein "FKB1B_HUMAN" ("FKBP1B" "FKBP12.6" "FKBP1L" "FKBP9" "OTK4"))
(define-protein "ELAF_HUMAN" ("PI3" "WAP3" "WFDC14"))
(define-protein "SIR1_HUMAN" ("SIRT1" "SIR2L1"))
(define-protein "XRCC1_HUMAN" ("XRCC1"))
(define-protein "IF2A_HUMAN" ("eIF-2alpha" "eIF2a" "eIF2α" "CG9946"))
(define-protein "EIF3B_HUMAN" ("eIF3b" "EIF3S9"))
(define-protein "IMA1_HUMAN" ("KPNA2" "RCH1" "SRP1"))
(define-protein "DNLI3_HUMAN" ("LIG3" "Lig III" "LIG III"))
(define-protein "LAT_HUMAN" ("LAT" "pp36" "p36-38"))
(define-protein "PML_HUMAN" ("Promyelocytic leukemia protein" "RING finger protein"))


(define-protein "CTNA2_HUMAN" ("Alpha-catenin" "CTNNB" "CTNNB1" "α-catenin"))
(define-protein "PLAK_HUMAN" ("γ-catenin" "gamma-catenin" "γ-catenin/plakoglobin" "plakoglobin"))
(define-protein "ELK1_HUMAN" ("Elk-1"))
(define-protein "IRS1_HUMAN" ("IRS1" "IRS-1"))
(define-protein "NHRF1_HUMAN" ("Ezrin-radixin-moesin-binding phosphoprotein 50" "EBP50"))

;;;;; hugely long list from MITRE RAS_1 corpus
(define-protein "14-3-3" NIL)
(define-protein "1433B_HUMAN" ("YWHAB" "KCIP-1"))
(define-protein "1433E_HUMAN" ("14-3-3E" "YWHAE"))
(define-protein "1433F_HUMAN" ("YWHA1" "YWHAH"))
(define-protein "1433G_HUMAN" ("YWHAG" "KCIP-1"))
(define-protein "1433S_HUMAN" ("SFN" "HME1" "Stratifin"))
(define-protein "1433T_HUMAN" ("YWHAQ"))
(define-protein "1433Z_HUMAN" ("YWHAZ" "KCIP-1"))
(define-protein "1A03_HUMAN" ("HLAA" "HLA-A"))
(define-protein "1A24_HUMAN" ("Aw-24" "HLA-A" "HLAA"))
(define-protein "1B07_HUMAN" ("HLAB" "HLA-B"))
(define-protein "1B18_HUMAN" ("HLAB" "HLA-B"))
(define-protein "1B58_HUMAN" ("Bw-58" "HLAB" "HLA-B"))
(define-protein "1C06_HUMAN" ("HLAC" "HLA-C"))
(define-protein "2A5A_HUMAN" ("PPP2R5A" "PR61alpha"))
(define-protein "2A5B_HUMAN" ("PPP2R5B"))
(define-protein "2A5D_HUMAN" ("PPP2R5D"))
(define-protein "2A5E_HUMAN" ("PPP2R5E"))
(define-protein "2A5G_HUMAN" ("PPP2R5C" "KIAA0044"))
(define-protein "2AAA_HUMAN" ("PPP2R1A"))
(define-protein "2AAB_HUMAN" ("PPP2R1B"))
(define-protein "2ABA_HUMAN" ("PPP2R2A"))
(define-protein "2ABB_HUMAN" ("PPP2R2B"))
(define-protein "2ABD_HUMAN" ("PPP2R2D" "KIAA1541"))
(define-protein "2ABG_HUMAN" ("PPP2R2C" "IMYPNO1"))
(define-protein "3BP1_HUMAN" ("SH3BP1" "3BP-1"))
(define-protein "AAKB1_HUMAN" ("AMPKb" "AMPK" "PRKAB1"))
(define-protein "AAKG1_HUMAN" ("AMPKg" "PRKAG1"))
(define-protein "AAPK1_HUMAN" ("AMPK1" "PRKAA1"))
(define-protein "AB1IP_HUMAN" ("RIAM" "APBB1IP" "PREL1" "RARP-1" "RARP1" "PREL-1"))
(define-protein "ABI1_HUMAN" ("Abi-1" "SSH3BP1" "AblBP4" "e3B1" "Nap1BP" "ABI1"))
(define-protein "ABL2-RIN1" NIL)
(define-protein "ABL2_HUMAN" ("ARG" "ABLL" "ABL2"))
(define-protein "ABR_HUMAN" ("ABR"))
(define-protein "ACADV_HUMAN" ("ACADVL" "VLCAD"))
(define-protein "ACAP2_HUMAN" ("Cnt-b2" "CENTB2" "Centaurin-beta-2" "KIAA0041" "ACAP2"))
(define-protein "ACBD5_HUMAN" ("ACBD5" "KIAA1996"))
(define-protein "ACO11_HUMAN" ("ACOT11" "KIAA0707" "BFIT" "THEA"))
(define-protein "ACSF2_HUMAN" ("ACSF2"))
(define-protein "ACSL3_HUMAN" ("ACSL3" "ACS3" "FACL3" "LACS3"))
(define-protein "ACSL5_HUMAN" ("ACSL5" "ACS5" "FACL5"))
(define-protein "ACTB_HUMAN" ("ACTB" "Beta-actin"))
(define-protein "ACTN2_HUMAN" ("ACTN2"))
(define-protein "ACTN4_HUMAN" ("ACTN4"))
(define-protein "ACV1B_HUMAN" ("ACVR1B" "ALK-4" "ALK4" "ACTR-IB" "SKR2" "ACVRLK4"))
(define-protein "ACV1C_HUMAN" ("ALK7" "ACVR1C" "ACTR-IC" "ALK-7"))
(define-protein "ACVL1_HUMAN" ("ALK-1" "ACVRLK1" "ALK1" "TSR-I" "ACVRL1" "SKR3"))
(define-protein "ACVR1_HUMAN" ("ALK-2" "ACTR-I" "TSR-I" "ACVR1" "ACVRLK2" "SKR1"))
(define-protein "ADA10_HUMAN" ("MADM" "CD156c" "CDw156" "ADAM10" "KUZ"))
(define-protein "ADA17_HUMAN" ("CSVP" "ADAM17" "CD156b" "TACE"))
(define-protein "ADAP1_HUMAN" ("ADAP1" "Centaurin-alpha-1" "CENTA1" "Cnt-a1"))
(define-protein "ADAS_HUMAN" ("AGPS"))
(define-protein "ADDA_HUMAN" ("ADD1" "ADDA"))
(define-protein "ADDG_HUMAN" ("ADDL" "ADD3"))
(define-protein "ADH6_HUMAN" ("ADH6" ))
(define-protein "ADRM1_HUMAN" ("Gp110" "hRpn13" "GP110" "ADRM1" "ARM-1"))
(define-protein "ADT2_HUMAN" ("SLC25A5" "ANT2"))
(define-protein "AF-6" ("Afadin"))
(define-protein "AFAD_HUMAN" ("MLLT4" "AF6"))
(define-protein "AGK_HUMAN" ("hAGK" "AGK" "HsMuLK" "MuLK" "MULK"))
(define-protein "AGR2_HUMAN" ("AG2" "hAG-2" "AG-2" "AGR2" "HPC8"))
(define-protein "AGTR1_HUMAN" ("AT1" "AT2R1B" "AGTR1" "AT2R1" "AGTR1B" "AGTR1A" "AT1BR" "AT1AR"))
(define-protein "AHNK_HUMAN" ("PM227" "Desmoyokin" "AHNAK"))
(define-protein "AIDA_HUMAN" ("AIDA" "C1orf80"))
(define-protein "AIP_HUMAN" ("XAP2" "AIP" "XAP-2"))
(define-protein "AKAP9_HUMAN" ("KIAA0803" "AKAP350" "AKAP9" "AKAP-9" "CG-NAP" "AKAP450" "PRKA9"))
(define-protein "AKT1_HUMAN" ("PKB" "RAC" "RAC-PK-alpha" "AKT1"))
(define-protein "AKT2_HUMAN" ("RAC-PK-beta" "AKT2"))
(define-protein "AKT3_HUMAN" ("RAC-PK-gamma" "STK-2" "PKBG" "AKT3"))
(define-protein "AKTS1_HUMAN" ("PRAS40" "ECO:0000303|PubMed:16174443}" "AKT1S1"))
(define-protein "AL1B1_HUMAN" ("ALDH5" "ALDH1B1" "ALDHX"))
(define-protein "AMERL_HUMAN" ("AMMECR1L"))
(define-protein "AMHR2_HUMAN" ("MISR2" "MRII" "AMHR2" "AMHR" "MISRII"))
(define-protein "ANAG_HUMAN" ("NAG" "UFHSD1" "NAGLU" "N-acetyl-alpha-glucosaminidase"))
(define-protein "ANDR_HUMAN" ("DHTR" "NR3C4" "AR"))
(define-protein "ANFY1_HUMAN" ("Rank-5" "KIAA1255" "ANKFY1" "ANKHZN"))
(define-protein "ANGP1_HUMAN" ("KIAA0003" "ANGPT1" "ANG-1"))
(define-protein "ANR11_HUMAN" ("ANKRD11" "ANCO1"))
(define-protein "ANX11_HUMAN" ("Annexin-11" "CAP-50" "ANX11" "ANXA11"))
(define-protein "ANXA1_HUMAN" ("p35" "Chromobindin-9" "LPC1" "ANXA1" "ANX1" "Annexin-1" "Calpactin-2"))
(define-protein "ANXA2_HUMAN" ("p36" "CAL1H" "Chromobindin-8" "LPC2D" "ANXA2" "PAP-IV" "ANX2" "Annexin-2" "ANX2L4"))
(define-protein "ANXA3_HUMAN" ("Annexin-3" "ANX3" "ANXA3" "PAP-III"))
(define-protein "ANXA4_HUMAN" ("P32.5" "ANXA4" "Chromobindin-4" "PP4-X" "ANX4" "Annexin-4" "PAP-II"))
(define-protein "ANXA5_HUMAN" ("PAP-I" "CBP-I" "ENX2" "PP4" "ANXA5" "ANX5" "Annexin-5" "VAC-alpha"))
(define-protein "ANXA6_HUMAN" ("Annexin-6" "p68" "ANXA6" "Chromobindin-20" "ANX6" "p70" "Calphobindin-II" "CPB-II"))
(define-protein "ANXA7_HUMAN" ("Annexin-7" "ANXA7" "SNX" "Synexin" "ANX7"))
(define-protein "ANXA9_HUMAN" ("ANXA9" "ANX31" "Annexin-31" "Pemphaxin" "Annexin-9"))
(define-protein "AP1B1_HUMAN" ("ADTB1" "Beta-1-adaptin" "AP1B1" "CLAPB2" "BAM22"))
(define-protein "AP1G1_HUMAN" ("AP1G1" "ADTG" "Gamma1-adaptin" "CLAPG1"))
(define-protein "AP1M2_HUMAN" ("AP1M2" "Mu1B-adaptin"))
(define-protein "AP1S1_HUMAN" ("AP1S1" "AP19" "CLAPS1" "Sigma1A-adaptin"))
(define-protein "AP2A1_HUMAN" ("Alpha1-adaptin" "CLAPA1" "ADTAA" "AP2A1"))
(define-protein "AP2A2_HUMAN" ("HIP9" "KIAA0899" "ADTAB" "CLAPA2" "HYPJ" "HIP-9" "Alpha2-adaptin" "AP2A2"))
(define-protein "AP2B1_HUMAN" ("ADTB2" "AP105B" "Beta-adaptin" "Beta-2-adaptin" "CLAPB1" "AP2B1"))
(define-protein "AP2M1_HUMAN" ("KIAA0109" "CLAPM1" "Adaptin-mu2" "AP2M1"))
(define-protein "AP3B1_HUMAN" ("Beta-3A-adaptin" "AP3B1" "ADTB3A"))
(define-protein "AP3D1_HUMAN" ("Delta-adaptin" "AP3D1"))
(define-protein "AP3M1_HUMAN" ("AP3M1" "Mu3A-adaptin"))
(define-protein "AP3S1_HUMAN" ("Sigma-3A-adaptin" "CLAPS3" "AP3S1" "Sigma3A-adaptin"))
(define-protein "APC15_HUMAN" ("APC15" "ANAPC15" "C11orf51"))
(define-protein "APC7_HUMAN" ("APC7" "ANAPC7"))
(define-protein "AR6P1_HUMAN" ("ARL6IP1" "Aip-1" "ARL6IP" "KIAA0069"))
(define-protein "ARAF_HUMAN" ("ARAF" "PKS2" "ARAF1" "PKS"))
(define-protein "ARAP1_HUMAN" ("KIAA0782" "Centaurin-delta-2" "ARAP1" "Cnt-d2" "CENTD2"))
(define-protein "ARAP3_HUMAN" ("Centaurin-delta-3" "ARAP3" "Cnt-d3" "CENTD3"))
(define-protein "ARF1_HUMAN" ("ARF1"))
(define-protein "ARF3_HUMAN" ("ARF3"))
(define-protein "ARF4_HUMAN" ("ARF4" "ARF2"))
(define-protein "ARF5_HUMAN" ("ARF5"))
(define-protein "ARF6_HUMAN" ("ARF6"))
(define-protein "ARFRP_HUMAN" ("ARP" "ARFRP1" "ARP1"))
(define-protein "ARGAL_HUMAN" ("GrinchGEF" "GRINCHGEF" "KIAA1626" "ARHGEF10L"))
(define-protein "ARHG1_HUMAN" ("Sub1.5" "p115-RhoGEF" "p115RhoGEF" "ARHGEF1"))
(define-protein "ARHG2_HUMAN" ("LFP40" "GEF-H1" "KIAA0651" "ARHGEF2"))
(define-protein "ARHGQ_HUMAN" ("ARHGEF26" "SGEF"))
(define-protein "ARL15_HUMAN" ("ARL15" "ARFRP2"))
(define-protein "ARL1_HUMAN" ("ARL1"))
(define-protein "ARL2_HUMAN" ("ARL2"))
(define-protein "ARL5A_HUMAN" ("ARL5" "ARL5A" "ARFLP5"))
(define-protein "ARL8A_HUMAN" ("GIE2" "ARL10B" "ARL8A"))
(define-protein "ARL8B_HUMAN" ("ARL8B" "GIE1" "ARL10C"))
(define-protein "ASAH1_HUMAN" ("ASAH" "ACDase" "PHP32" "AC" "ASAH1"))
(define-protein "ASNA_HUMAN" ("ARSA" "hASNA-I" "TRC40" "hARSA-I" "ASNA1"))
(define-protein "ASPC1_HUMAN" ("RCC17" "ASPL" "UBXN9" "UBXD9" "TUG" "ASPSCR1"))
(define-protein "ASPP1_HUMAN" ("PPP1R13B" "ASPP1" "KIAA0771"))
(define-protein "ASXL1_HUMAN" ("ASXL1" "KIAA0978"))
(define-protein "AT1B3_HUMAN" ("CD298" "ATP1B3" "ATPB-3"))
(define-protein "ATG3_HUMAN" ("APG3-like" "hApg3" "ATG3" "APG3" "APG3L"))
(define-protein "ATG5_HUMAN" ("APG5L" "ATG5" "APG5-like" "ASP"))
(define-protein "ATG7_HUMAN" ("hAGP7" "ATG7" "APG7-like" "APG7L"))
(define-protein "ATM_HUMAN" ( "ATM"))
(define-protein "ATR_HUMAN" ("ATR" "FRP1"))
(define-protein "AURKA_HUMAN" ("AYK1" "ARK-1" "STK6" "AURA" "AURKA" "AIK" "IAK1" "AIRK1" "ARK1" "hARK1" "STK15" "BTAK"))
(define-protein "AVR2A_HUMAN" ("ACVR2A" "ACTR-IIA" "ACTRIIA" "ACVR2"))
(define-protein "AVR2B_HUMAN" ("ACVR2B" "ACTR-IIB"))
(define-protein "Akt" NIL)
(define-protein "B3GA3_HUMAN" ("GlcUAT-I" "GlcAT-I" "B3GAT3"))
(define-protein "BAIP2_HUMAN" ("IRS-58" "BAIAP2" "FLAF3" "IRSp53/58" "IRSp53"))
(define-protein "BAP29_HUMAN" ("BCAP29" "BAP29" "Bap29"))
(define-protein "BAP31_HUMAN" ("BCAP31" "Bap31" "p28" "DXS1357E" "BAP31"))
(define-protein "BAZ1A_HUMAN" ("hACF1" "ACF1" "WCRF180" "hWALp1" "BAZ1A"))
(define-protein "BAZ1B_HUMAN" ("WBSCR10" "hWALp2" "WBSCR9" "WBSC10" "BAZ1B" "WSTF"))
(define-protein "BCCIP_HUMAN" ("TOK1" "BCCIP"))
(define-protein "BCL2_HUMAN" ("BCL2"))
(define-protein "BET1_HUMAN" ("hBET1" "BET1"))
(define-protein "BIG1_HUMAN" ("ARFGEF1" "ARFGEP1" "BIG1"))
(define-protein "BIG2_HUMAN" ("ARFGEF2" "ARFGEP2" "BIG2"))
(define-protein "BIN1_HUMAN" ("AMPHL" "BIN1"))
(define-protein "BL1S1_HUMAN" ("GCN5L1" "BLOC1S1" "RT14" "BLOS1"))
(define-protein "BL1S2_HUMAN" ("CEAP" "BLOC1S2" "BLOS2"))
(define-protein "BL1S4_HUMAN" ("BLOC1S4" "CNO"))
(define-protein "BL1S5_HUMAN" ("BLOC1S5" "MUTED"))
(define-protein "BL1S6_HUMAN" ("Pallidin" "BLOC1S6" "PA" "PLDN"))
(define-protein "BLK_HUMAN" ( "BLK" "p55-Blk"))
(define-protein "BLNK_HUMAN" ("SLP65" "BLNK" "SLP-65" "BASH"))
(define-protein "BMP10_HUMAN" ("BMP-10" "BMP10"))
(define-protein "BMP15_HUMAN" ("BMP-15" "BMP15" "GDF-9B" "GDF9B"))
(define-protein "BMP1_HUMAN" ("PCP" "PCOLC" "BMP1" "BMP-1" "mTld"))
(define-protein "BMP2_HUMAN" ("BMP-2A" "BMP2A" "BMP2" "BMP-2"))
(define-protein "BMP3B_HUMAN" ("GDF10" "BMP-3B" "BIP" "GDF-10" "BMP3B"))
(define-protein "BMP3_HUMAN" ("BMP3" "Osteogenin" "BMP-3" "BMP-3A" "BMP3A"))
(define-protein "BMP4_HUMAN" ("DVR4" "BMP-2B" "BMP2B" "BMP4" "BMP-4"))
(define-protein "BMP5_HUMAN" ("BMP5" "BMP-5"))
(define-protein "BMP6_HUMAN" ("VGR-1" "BMP6" "VGR" "BMP-6" "VG-1-R"))
(define-protein "BMP7_HUMAN" ("OP1" "BMP7" "BMP-7" "OP-1"))
(define-protein "BMP8A_HUMAN" ("BMP8A" "BMP-8A"))
(define-protein "BMP8B_HUMAN" ("BMP8B" "BMP8" "OP-2" "BMP-8" "BMP-8B"))
(define-protein "BMPR2_HUMAN" ("BMPR-II" "PPH1" "BMPR-2" "BMPR2"))
(define-protein "BMR1A_HUMAN" ("ALK-3" "ALK3" "BMPR-1A" "CD292" "BMPR1A" "ACVRLK3" "SKR5"))
(define-protein "BMR1B_HUMAN" ("CDw293" "BMPR1B" "BMPR-1B"))
(define-protein "BPNT1_HUMAN" ("PIP" "BPNT1"))
(define-protein "BRAF_HUMAN" ("RAFB1" "p94" "BRAF1" "BRAF"))
(define-protein "BRAP_HUMAN" ("RNF52" "BRAP" "IMP" "BRAP2"))
(define-protein "BTC_HUMAN" ("BTC" "Betacellulin"))
(define-protein "BTK_HUMAN" ("BPK" "ATK" "AGMX1" "BTK"))
(define-protein "BZW1_HUMAN" ("KIAA0005" "BZAP45" "BZW1"))
(define-protein "BZW2_HUMAN" ("BZW2"))
(define-protein "C42S2_HUMAN" ("SPEC2" "CDC42SE2"))
(define-protein "CAB39_HUMAN" ("CAB39" "MO25" "MO25alpha"))
(define-protein "CAB45_HUMAN" ("CAB45" "SDF-4" "SDF4" "Cab45"))
(define-protein "CADH1_HUMAN" ("CDH1" "E-Cad/CTF3" "E-Cad/CTF2" "E-Cad/CTF1" "CD324" "UVO" "CDHE" "Uvomorulin" "E-cadherin"))
(define-protein "CALM_HUMAN" ("CAM3" "CAM2" "CAM1" "CALM" "CALM3" "CALM2" "CALM1" "CALML2" "CaM" "CAM" "CAMC" "CAMB" "CAMIII"))
(define-protein "CALR_HUMAN" ("CALR" "ERp60" "CRTC" "CRP55" "Calregulin" "grp60" "HACBP"))
(define-protein "CALU_HUMAN" ("Crocalbin" "CALU"))
(define-protein "CALX_HUMAN" ("p90" "CANX" "IP90"))
(define-protein "CAND1_HUMAN" ("KIAA0829" "CAND1" "TIP120A" "TIP120"))
(define-protein "CAPS2_HUMAN" ("KIAA1591" "CADPS2" "CAPS2" "CAPS-2"))
(define-protein "CAPZB_HUMAN" ("CAPZB"))
(define-protein "CASP_HUMAN" ("CUX1" "CUTL1"))
(define-protein "CAV1_HUMAN" ("CAV" "CAV1"))
(define-protein "CAV2_HUMAN" ("CAV2"))
(define-protein "CAZA1_HUMAN" ("CAPZA1"))
(define-protein "CBL_HUMAN" ( "CBL2" "CBL" "RNF55"))
(define-protein "CC28A_HUMAN" ("C6orf80" "CCRL1AP" "CCDC28A"))
(define-protein "CCAR2_HUMAN" ("CCAR2" "DBC1" "DBC.1" "DBC-1" "KIAA1967"))
(define-protein "CCD50_HUMAN" ("C3orf6" "CCDC50"))
(define-protein "CCNB3_HUMAN" ("CYCB3" "CCNB3"))
(define-protein "CCND1_HUMAN" ("BCL-1" "BCL1" "CCND1" "PRAD1"))
(define-protein "CCNG1_HUMAN" ("Cyclin-G" "CYCG1" "CCNG1" "CCNG"))
(define-protein "CD11A_HUMAN" ("CDC2L3" "CDC2L2" "CDK11A" "PITSLREB"))
(define-protein "CD2AP_HUMAN" ("CD2AP"))
(define-protein "CD44_HUMAN" ("CD44" "ECMR-III" "PGP-1" "MDU2" "MIC4" "HUTCH-I" "LHR" "CDw44" "MDU3" "PGP-I" "Epican"))
(define-protein "CD63_HUMAN" ("TSPAN30" "LAMP-3" "Tetraspanin-30" "Tspan-30" "MLA1" "OMA81H" "Granulophysin" "CD63"))
(define-protein "CD9_HUMAN" ("Tspan-29" "MRP-1" "Tetraspanin-29" "MIC3" "TSPAN29" "p24" "CD9"))
(define-protein "CDC23_HUMAN" ("ANAPC8" "CDC23" "APC8"))
(define-protein "CDC37_HUMAN" ("CDC37A" "p50Cdc37" "CDC37"))
(define-protein "CDC42_HUMAN" ("CDC42"))
(define-protein "CDC5L_HUMAN" ("KIAA0432" "CDC5L" "PCDC5RP"))
(define-protein "CDCP1_HUMAN" ("CDCP1" "TRASK" "SIMA135" "CD318"))
(define-protein "CDIPT_HUMAN" ( "PIS" "CDIPT" "PIS1"))
(define-protein "CDK1_HUMAN" ("CDK1" "Cdk1" "P34CDC2" "CDC2" "CDKN1" "CDC28A"))
(define-protein "CDK4_HUMAN" ( "PSK-J3" "CDK4"))
(define-protein "CDK5_HUMAN" ("CDKN5" "CDK5"))
(define-protein "CEBPB_HUMAN" ("LIP" "TCF5" "LAP" "TCF-5" "CEBPB"))
(define-protein "CENPV_HUMAN" ("CENP-V" "PRR6" "CENPV"))
(define-protein "CH033_HUMAN" ("C8orf33"))
(define-protein "CHD3_HUMAN" ("CHD-3" "hZFH" "Mi2-alpha" "CHD3"))
(define-protein "CHD4_HUMAN" ("CHD-4" "Mi2-beta" "CHD4"))
(define-protein "CHK1_HUMAN" ("CHEK1" "CHK1"))
(define-protein "CHK2_HUMAN" ("CHEK2" "CDS1" "CHK2" "Chk2" "RAD53"))
(define-protein "CHM1A_HUMAN" ("Vps46-1" "PCOLN3" "CHMP1a" "KIAA0047" "PRSM1" "CHMP1" "hVps46-1" "CHMP1A"))
(define-protein "CHM1B_HUMAN" ("CHMP1b" "CHMP1.5" "Vps46-2" "CHMP1B" "C18orf2" "hVps46-2"))
(define-protein "CHM2A_HUMAN" ("hVps2-1" "CHMP2A" "CHMP2" "Vps2-1" "CHMP2a" "BC2"))
(define-protein "CHM4B_HUMAN" ("SNF7-2" "CHMP4b" "C20orf178" "SHAX1" "hSnf7-2" "hVps32-2" "Vps32-2" "CHMP4B"))
(define-protein "CHMP5_HUMAN" ("hVps60" "Vps60" "SNF7DC2" "C9orf83" "CHMP5"))
(define-protein "CHMP6_HUMAN" ("VPS20" "Vps20" "hVps20" "CHMP6"))
(define-protein "CHP1_HUMAN" ("CHP1" "CHP"))
(define-protein "CI009_HUMAN" ("C9orf9"))
(define-protein "CIB1_HUMAN" ("CIBP" "CIB" "KIP" "Calmyrin" "CIB1" "PRKDCIP" "SIP2-28"))
(define-protein "CIR1_HUMAN" ("CIR" "Recepin" "CIR1"))
(define-protein "CISD2_HUMAN" ("Miner1" "ZCD2" "CISD2" "NAF-1" "CDGSH2" "ERIS"))
(define-protein "CKAP5_HUMAN" ("Ch-TOG" "CKAP5" "KIAA0097"))
(define-protein "CL045_HUMAN" ("C12orf45"))
(define-protein "CLAP2_HUMAN" ("hOrbit2" "KIAA0627" "CLASP2"))
(define-protein "CLCA_HUMAN" ("Lca" "CLTA"))
(define-protein "CLCN7_HUMAN" ("CLCN7" "ClC-7"))
(define-protein "CLH1_HUMAN" ("KIAA0034" "CLH-17" "CLTC" "CLH17" "CLTCL2"))
(define-protein "CLIC1_HUMAN" ("hRNCC" "NCC27" "CLIC1" "G6"))
(define-protein "CLIP4_HUMAN" ("CLIP4" "RSNL2"))
(define-protein "CLN5_HUMAN" ("CLN5"))
(define-protein "CND3_HUMAN" ("CAPG" "NYMEL3" "hCAP-G" "NCAPG"))
(define-protein "CNN2_HUMAN" ("CNN2"))
(define-protein "CNOT8_HUMAN" ("CAF2" "CNOT8" "CALIF" "POP2" "CALIFp" "Caf1b"))
(define-protein "CNPY3_HUMAN" ("CNPY3" "ERDA5" "TNRC5" "CTG4A" "PRAT4A"))
(define-protein "COBL1_HUMAN" ("COBLL1" "KIAA0977"))
(define-protein "COF1_HUMAN" ("CFL1" "p18" "CFL"))
(define-protein "COG3_HUMAN" ("p94" "SEC34" "COG3"))
(define-protein "COG4_HUMAN" ("COG4"))
(define-protein "COG5_HUMAN" ("GTC-90" "GTC90" "COG5" "GOLTC1"))
(define-protein "COMD3_HUMAN" ("C10orf8" "COMMD3" "BUP"))
(define-protein "COPA_HUMAN" ("COPA" "Xenin" "Proxenin" "HEP-COP" "HEPCOP" "Alpha-COP"))
(define-protein "COPB2_HUMAN" ("p102" "Beta'-COP" "COPB2"))
(define-protein "COPB_HUMAN" ("Beta-COP" "COPB1" "COPB"))
(define-protein "COPD_HUMAN" ("ARCN1" "Archain" "Delta-COP" "COPD"))
(define-protein "COPE_HUMAN" ("Epsilon-COP" "COPE"))
(define-protein "COPG1_HUMAN" ("COPG1" "Gamma-1-COP" "COPG"))
(define-protein "COPZ1_HUMAN" ("COPZ1" "COPZ"))
(define-protein "CPLX1_HUMAN" ("Synaphin-2" "CPLX1"))
(define-protein "CPNE1_HUMAN" ("CPNE1" "CPN1"))
(define-protein "CPNE3_HUMAN" ("CPNE3" "KIAA0636" "CPN3"))
(define-protein "CPT1A_HUMAN" ("CPT1-L" "CPTI-L" "CPT1" "CPT1A"))
(define-protein "CQ085_HUMAN" ("C17orf85"))
(define-protein "CSF2R_HUMAN" ("CDw116" "GMCSFR-alpha" "GM-CSF-R-alpha" "CSF2RY" "CSF2RA" "GMR-alpha" "CSF2R" "CD116"))
(define-protein "CSF2_HUMAN" ("CSF2" "Sargramostim" "GMCSF" "CSF" "GM-CSF" "Molgramostin"))
(define-protein "CSK22_HUMAN" ("CSNK2A2" "CK2A2"))
(define-protein "CSKP_HUMAN" ("hCASK" "CASK" "LIN2"))
(define-protein "CTNA1_HUMAN" ("CTNNA1"))
(define-protein "CTNB1_HUMAN" ("β-catenin" "Beta-catenin" "CTNNB" "CTNNB1"))
(define-protein "CTR1_HUMAN" ("ERR" "SLC7A1" "CAT1" "ATRC1" "CAT-1" "REC1L"))
(define-protein "CUL3_HUMAN" ("KIAA0617" "CUL3" "CUL-3"))
(define-protein "CYBP_HUMAN" ("SIP" "hCacyBP" "S100A6BP" "CACYBP" "CacyBP"))
(define-protein "CYFP1_HUMAN" ("p140sra-1" "CYFIP1" "Sra-1" "KIAA0068"))
(define-protein "CYH1_HUMAN" ("CYTH1" "PSCD1" "D17S811E"))
(define-protein "CYH2_HUMAN" ("PSCD2" "ARNO" "CYTH2" "PSCD2L"))
(define-protein "CYH3_HUMAN" ("PSCD3" "Grp1" "ARNO3" "GRP1" "CYTH3"))
(define-protein "CYTA_HUMAN" ("STF1" "STFA" "CSTA" "Stefin-A" "Cystatin-AS"))
(define-protein "CYTSA_HUMAN" ("SPECC1L" "KIAA0376" "CYTSA"))
(define-protein "CYTS_HUMAN" ("CST4" "Cystatin-4" "Cystatin-SA-III"))
(define-protein "CoA" NIL)
(define-protein "CoR" NIL)
(define-protein "DAB2P_HUMAN" ("KIAA1743" "AIP-1" "AF9Q34" "DAB2IP" "AIP1"))
(define-protein "DC1I1_HUMAN" ("DYNC1I1" "DNCI1" "DNCIC1"))
(define-protein "DC1I2_HUMAN" ("DYNC1I2" "DNCI2" "DNCIC2"))
(define-protein "DC1L1_HUMAN" ("DLC-A" "DNCLI1" "DYNC1LI1" "LIC1"))
(define-protein "DC1L2_HUMAN" ("LIC-2" "DNCLI2" "DYNC1LI2" "LIC2" "LIC53/55"))
(define-protein "DCTN2_HUMAN" ("DCTN-50" "DCTN50" "DCTN2"))
(define-protein "DCTN3_HUMAN" ("DCTN22" "DCTN3" "p22"))
(define-protein "DDX47_HUMAN" ("DDX47"))
(define-protein "DDX50_HUMAN" ("Gu-beta" "DDX50"))
(define-protein "DDX55_HUMAN" ("DDX55" "KIAA1595"))
(define-protein "DEAF1_HUMAN" ("ZMYND5" "Suppressin" "DEAF1" "SPN" "NUDR"))
(define-protein "DEN6B_HUMAN" ("DENND6B" "FAM116B"))
(define-protein "DEST_HUMAN" ("ACTDP" "ADF" "DSN" "DSTN"))
(define-protein "DEXI_HUMAN" ("DEXI" "MYLE"))
(define-protein "DGKK_HUMAN" ("DGKK" "DGK-kappa"))
(define-protein "DGKQ_HUMAN" ("DGKQ" "DAGK4" "DGK-theta"))
(define-protein "DGKZ_HUMAN" ("DAGK6" "DGKZ" "DGK-zeta"))
(define-protein "DIAP1_HUMAN" ("DRF1" "DIAP1" "DIAPH1"))
(define-protein "DIDO1_HUMAN" ("DIDO1" "C20orf158" "DIO-1" "DATF-1" "hDido1" "KIAA0333" "DATF1"))
(define-protein "DLG4_HUMAN" ("PSD95" "PSD-95" "SAP90" "DLG4" "SAP-90"))
(define-protein "DLK1_HUMAN" ("DLK" "FA1" "DLK1" "DLK-1" "pG2"))
(define-protein "DLL3_HUMAN" ("DLL3" "Delta3"))
(define-protein "DLL4_HUMAN" ("DLL4" "Delta4"))
(define-protein "DLRB1_HUMAN" ("BITH" "DNCL2A" "ROBLD1" "DYNLRB1" "BLP" "DNLC2A"))
(define-protein "DNJA3_HUMAN" ("hTid-1" "DNAJA3" "TID1" "HCA57"))
(define-protein "DNJB1_HUMAN" ("hDj-1" "HDJ1" "DNAJ1" "HSP40" "HSPF1" "DNAJB1"))
(define-protein "DNJC8_HUMAN" ("SPF31" "DNAJC8"))
(define-protein "DNM1L_HUMAN" ("Dymple" "DNM1L" "DLP1" "HdynIV" "DRP1" "DVLP"))
(define-protein "DNMBP_HUMAN" ("DNMBP" "KIAA1010"))
(define-protein "DOCK1_HUMAN" ("DOCK1" "DOCK180"))
(define-protein "DOCK5_HUMAN" ("DOCK5"))
(define-protein "DOCK6_HUMAN" ("KIAA1395" "DOCK6"))
(define-protein "DOP2_HUMAN" ("KIAA0933" "C21orf5" "DOPEY2"))
(define-protein "DP13B_HUMAN" ("APPL2" "Dip13-beta" "DIP13B"))
(define-protein "DPOLB_HUMAN" ("POLB"))
(define-protein "DRG1_HUMAN" ("NEDD3" "NEDD-3" "DRG1" "DRG-1"))
(define-protein "DTBP1_HUMAN" ("BLOC1S8" "DTNBP1" "Dysbindin-1"))
(define-protein "DUS23_HUMAN" ("LDP-3" "DUSP23" "VHZ" "LDP3"))
(define-protein "DUS3_HUMAN" ("VHR" "DUSP3"))
(define-protein "DUX3_HUMAN" ("DUX3"))
(define-protein "DYHC1_HUMAN" ("KIAA0325" "DYNC1H1" "DHC1" "DNCL" "DYHC" "DNECL" "DNCH1"))
(define-protein "DYL1_HUMAN" ("DYNLL1" "DNCL1" "HDLC1" "PIN" "DNCLC1" "DLC8" "DLC1"))
(define-protein "DYN2_HUMAN" ("DYN2" "DNM2"))
(define-protein "DYST_HUMAN" ("DST" "DMH" "DT" "BPA" "KIAA0728" "BP230" "BPAG1" "BP240"))
(define-protein "Delta" NIL)
(define-protein "E41L1_HUMAN" ("KIAA0338" "EPB41L1"))
(define-protein "E41L2_HUMAN" ("EPB41L2"))
(define-protein "E41L5_HUMAN" ("KIAA1548" "EPB41L5"))
(define-protein "E41LA_HUMAN" ("EPB41L4A" "EPB41L4"))
(define-protein "ECHA_HUMAN" ("TP-alpha" "HADH" "HADHA"))
(define-protein "ECHB_HUMAN" ("HADHB" "Beta-ketothiolase" "TP-beta"))
(define-protein "ECHP_HUMAN" ("PBFE" "EHHADH" "PBE" "ECHD"))
(define-protein "ECM29_HUMAN" ("ECM29" "KIAA0368" "Ecm29"))
(define-protein "ECSIT_HUMAN" ("ECSIT"))
(define-protein "EF1A1_HUMAN" ("EEF1A" "EF1A" "LENG7" "EF-1-alpha-1" "eEF1A-1" "EEF1A1" "EF-Tu"))
(define-protein "EFNB1_HUMAN" ("EPLG2" "EFL-3" "LERK-2" "ELK-L" "EFL3" "EFNB1" "LERK2"))
(define-protein "EFNB2_HUMAN" ("HTK-L" "LERK-5" "EFNB2" "EPLG5" "LERK5" "HTKL"))
(define-protein "EFNB3_HUMAN" ("LERK-8" "EFNB3" "EPLG8" "LERK8"))
(define-protein "EGFR" NIL)
(define-protein "EGFR_HUMAN" ("HER1" "EGFR" "ERBB" "ERBB1"))
(define-protein "EGF_HUMAN" ("EGF" "Urogastrone"))
(define-protein "EGLN1_HUMAN" ("HIF-PH2" "HPH-2" "SM-20" "C1orf12" "EGLN1" "PHD2"))
(define-protein "EHD1_HUMAN" ("EHD1" "Testilin" "hPAST1" "PAST" "PAST1"))
(define-protein "EHD4_HUMAN" ("EHD4" "HCA11" "HCA10" "PAST4"))
(define-protein "EI2BA_HUMAN" ("EIF2B1" "EIF2BA"))
(define-protein "EI2BB_HUMAN" ("EIF2B2" "S20I15" "EIF2BB" "S20III15"))
(define-protein "EI2BD_HUMAN" ("EIF2BD" "EIF2B4"))
(define-protein "EI2BE_HUMAN" ("EIF2BE" "EIF2B5"))
(define-protein "EI2BG_HUMAN" ("EIF2B3"))
(define-protein "EIF2D_HUMAN" ("EIF2D" "HCA56" "eIF2d" "LGTN" "Ligatin"))
(define-protein "EIF3M_HUMAN" ("EIF3M" "hFL-B5" "PCID1" "HFLB5" "eIF3m"))
(define-protein "ELAV1_HUMAN" ("HuR" "HUR" "ELAVL1"))
(define-protein "ELMO3_HUMAN" ("ELMO3"))
(define-protein "ELOF1_HUMAN" ("ELOF1"))
(define-protein "ENOA_HUMAN" ("MBPB1" "MPB-1" "NNE" "ENO1" "ENO1L1" "MPB1" "MBP-1"))
(define-protein "EPB42_HUMAN" ("EPB42" "P4.2" "E42P"))
(define-protein "EPCAM_HUMAN" ("EPCAM" "hEGP314" "Ep-CAM" "EGP314" "KSA" "M4S1" "CD326" "TACSTD1" "GA733-2" "M1S2" "EGP" "TROP1" "MIC18"))
(define-protein "EPHA2_HUMAN" ( "ECK" "EPHA2"))
(define-protein "EPHB1_HUMAN" ("hEK6" "HEK6" "ELK" "EK6" "EPHT2" "EPHB1" "NET"))
(define-protein "EPHB2_HUMAN" ("TYRO5" "HEK5" "EPTH3" "hEK5" "ERK" "EK5" "EPHB2" "DRT" "EPHT3"))
(define-protein "EPHB3_HUMAN" ("hEK2" "TYRO6" "ETK2" "HEK2" "EK2" "EPHB3"))
(define-protein "EPHB4_HUMAN" ("MYK1" "HTK" "EPHB4" "TYRO11"))
(define-protein "EPHB6_HUMAN" ("HEP" "EPHB6"))
(define-protein "EPS8_HUMAN" ("EPS8"))
(define-protein "ERAP1_HUMAN" ("APPILS" "A-LAP" "KIAA0525" "PILS-AP" "ARTS-1" "ERAP1" "ARTS1"))
(define-protein "ERBB2_HUMAN" ("NGL" "CD340" "p185erbB2" "MLN19" "ERBB2" "HER2" "NEU"))
(define-protein "ERBB3_HUMAN" ( "HER3" "ERBB3"))
(define-protein "ERBB4_HUMAN" ("s80HER4" "E4ICD" "HER4" "4ICD" "ERBB4" "p180erbB4"))
(define-protein "EREG_HUMAN" ("Epiregulin" "EPR" "EREG"))
(define-protein "ERGI1_HUMAN" ("KIAA1181" "ERGIC1" "ERGIC-32" "ERGIC32"))
(define-protein "ERGI2_HUMAN" ("ERV41" "PTX1" "ERGIC2"))
(define-protein "ERGI3_HUMAN" ("SDBCAG84" "ERV46" "ERGIC3" "C20orf47"))
(define-protein "ERLN1_HUMAN" ("ERLIN1" "KEO4" "C10orf69" "KE04" "SPFH1"))
(define-protein "ERLN2_HUMAN" ("ERLIN2" "C8orf2" "SPFH2"))
(define-protein "ES8L2_HUMAN" ("EPS8R2" "EPS8L2"))
(define-protein "ES8L3_HUMAN" ("EPS8R3" "EPS8L3"))
(define-protein "ESR1_HUMAN" ("ER" "ESR1" "ESR" "ER-alpha" "NR3A1"))
(define-protein "ESR2_HUMAN" ("NR3A2" "ESTRB" "ESR2" "ER-beta"))
(define-protein "ESX1_HUMAN" ("ESX1L" "ESX1" "ESX1R"))
(define-protein "ESYT1_HUMAN" ("FAM62A" "KIAA0747" "E-Syt1" "ESYT1" "MBC2"))
(define-protein "ETHE1_HUMAN" ("HSCO" "ETHE1"))
(define-protein "EXOC1_HUMAN" ("SEC3L1" "EXOC1" "SEC3"))
(define-protein "EXOC2_HUMAN" ("SEC5" "EXOC2" "SEC5L1"))
(define-protein "EXOC3_HUMAN" ("SEC6L1" "SEC6" "EXOC3"))
(define-protein "EXOC4_HUMAN" ("SEC8L1" "SEC8" "EXOC4" "KIAA1699"))
(define-protein "EXOC5_HUMAN" ("SEC10" "SEC10L1" "EXOC5" "hSec10"))
(define-protein "EXOC6_HUMAN" ("EXOC6" "SEC15A" "SEC15L1" "SEC15L"))
(define-protein "EXOC7_HUMAN" ("EXOC7" "KIAA1067" "EXO70"))
(define-protein "EXOC8_HUMAN" ("EXOC8"))
(define-protein "EXPH5_HUMAN" ("EXPH5" "SlaC2-b" "SLAC2B" "KIAA0624"))
(define-protein "EZRI_HUMAN" ("EZR" "Cytovillin" "p81" "VIL2" "Villin-2"))
(define-protein "Eph" NIL)
(define-protein "EphR" NIL)
(define-protein "Ephrin B" NIL)
(define-protein "F126B_HUMAN" ("FAM126B"))
(define-protein "FA21A_HUMAN" ("FAM21A"))
(define-protein "FA71C_HUMAN" ("FAM71C"))
(define-protein "FACR2_HUMAN" ("FAR2" "MLSTD1"))
(define-protein "FAK" NIL)
(define-protein "FAK1_HUMAN" ("p125FAK" "FAK" "pp125FAK" "PPP1R71" "FRNK" "PTK2" "FAK1"))
(define-protein "FAK2_HUMAN" ("CAKB" "RAFTK" "PYK2" "CADTK" "FAK2" "CAK-beta" "PTK2B"))
(define-protein "FANCI_HUMAN" ("KIAA1794" "FANCI"))
(define-protein "FBP1L_HUMAN" ("C1orf39" "FNBP1L" "Toca-1" "TOCA1"))
(define-protein "FBW1A_HUMAN" ("BTRCP" "BTRC" "FBW1A" "FBXW1A" "E3RSIkappaB"))
(define-protein "FCERA_HUMAN" ("FcERI" "FCER1A" "FCE1A"))
(define-protein "FCERB_HUMAN" ("FCER1B" "MS4A2" "FcERI" "APY" "IGER"))
(define-protein "FCERG_HUMAN" ("FCER1G" "FcRgamma"))
(define-protein "FCG2B_HUMAN" ("FcRII-b" "CD32" "Fc-gamma-RIIb" "CDw32" "FCG2" "FCGR2B" "IGFR2"))
(define-protein "FCHO2_HUMAN" ("FCHO2"))
(define-protein "FDFT_HUMAN" ("FDFT1" "SQS" "SS"))
(define-protein "FERM1_HUMAN" ("Kindlin-1" "C20orf42" "FERMT1" "Kindlerin" "KIND1" "URP1"))
(define-protein "FGD3_HUMAN" ("FGD3" "ZFYVE5"))
(define-protein "FGD4_HUMAN" ("FRABP" "FGD4" "ZFYVE6"))
(define-protein "FGF10_HUMAN" ("FGF10" "FGF-10"))
(define-protein "FGF12_HUMAN" ("FGF12B" "FGF12" "FGF-12" "FHF-1" "FHF1"))
(define-protein "FGF16_HUMAN" ("FGF16" "FGF-16"))
(define-protein "FGF17_HUMAN" ("FGF17" "FGF-17"))
(define-protein "FGF18_HUMAN" ("FGF18" "FGF-18" "zFGF5"))
(define-protein "FGF19_HUMAN" ("FGF19" "FGF-19"))
(define-protein "FGF1_HUMAN" ("HBGF-1" "aFGF" "FGF-1" "FGF1" "ECGF" "FGFA"))
(define-protein "FGF20_HUMAN" ("FGF20" "FGF-20"))
(define-protein "FGF22_HUMAN" ("FGF22" "FGF-22"))
(define-protein "FGF23_HUMAN" ("FGF-23" "HYPF" "Phosphatonin" "FGF23"))
(define-protein "FGF2_HUMAN" ("HBGF-2" "FGF-2" "FGF2" "FGFB" "bFGF"))
(define-protein "FGF3_HUMAN" ("FGF-3" "INT2" "FGF3" "HBGF-3"))
(define-protein "FGF4_HUMAN" ("HSTF1" "HBGF-4" "HST" "FGF4" "HST-1" "KS3" "FGF-4" "HSTF-1"))
(define-protein "FGF5_HUMAN" ("Smag-82" "FGF5" "FGF-5" "HBGF-5"))
(define-protein "FGF6_HUMAN" ("HSTF-2" "FGF-6" "FGF6" "HST-2" "HSTF2" "HST2" "HBGF-6"))
(define-protein "FGF7_HUMAN" ("FGF-7" "FGF7" "HBGF-7" "KGF"))
(define-protein "FGF8_HUMAN" ("AIGF" "FGF-8" "FGF8" "HBGF-8"))
(define-protein "FGF9_HUMAN" ("FGF-9" "FGF9" "HBGF-9" "GAF"))
(define-protein "FGFR1-4" NIL)
(define-protein "FGFR1_HUMAN" ("FLG" "FGFBR" "FLT-2" "FGFR1" "bFGF-R-1" "BFGFR" "FLT2" "HBGFR" "N-sam" "FGFR-1" "CEK" "CD331"))
(define-protein "FGFR2_HUMAN" ("BEK" "K-sam" "KSAM" "CD332" "KGFR" "FGFR-2" "FGFR2"))
(define-protein "FGFR3_HUMAN" ( "CD333" "JTK4" "FGFR-3" "FGFR3"))
(define-protein "FGFR4_HUMAN" ("TKF" "FGFR-4" "CD334" "JTK2" "FGFR4"))
(define-protein "FHOD1_HUMAN" ("FHOS1" "FHOS" "FHOD1"))
(define-protein "FIG4_HUMAN" ("KIAA0274" "FIG4" "SAC3"))
(define-protein "FLII_HUMAN" ("FLIL" "FLII"))
(define-protein "FLNA_HUMAN" ("Alpha-filamin" "FLN1" "ABP-280" "FLN-A" "FLNA" "FLN" "Filamin-1"))
(define-protein "FLNB_HUMAN" ("Fh1" "TABP" "FLN3" "Beta-filamin" "FLN-B" "FLNB" "FLN1L" "TAP" "Filamin-3" "ABP-278"))
(define-protein "FLNC_HUMAN" ("FLN2" "FLN-C" "FLNC" "ABPL" "ABP-L" "FLNc" "Filamin-2" "Gamma-filamin"))
(define-protein "FLOT1_HUMAN" ("FLOT1"))
(define-protein "FNTA_HUMAN" ("GGTase-I-alpha" "FTase-alpha" "FNTA"))
(define-protein "FNTB_HUMAN" ("FNTB" "FTase-beta"))
(define-protein "FOS_HUMAN" ("FOS" "G0S7"))
(define-protein "FRPD3_HUMAN" ("KIAA1817" "FRMPD3"))
(define-protein "FRS2_HUMAN" ("FRS2" "SNT-1"))
(define-protein "FRS3_HUMAN" ("FRS3" "SNT-2"))
(define-protein "FYN_HUMAN" ( "SLK" "p59-Fyn" "FYN"))
(define-protein "Fringe" NIL)
(define-protein "G3BP1_HUMAN" ("G3BP-1" "G3BP" "G3BP1"))
(define-protein "G3P_HUMAN" ("GAPDH" "GAPD"))
(define-protein "G45IP_HUMAN" ("PRG6" "MRP-L59" "MRPL59" "PLINP-1" "CRIF1" "PLINP1" "GADD45GIP1" "PLINP"))
(define-protein "G6PD_HUMAN" ("G6PD"))
(define-protein "GAB1_HUMAN" ("GAB1" "Gab1"))
(define-protein "GAB2_HUMAN" ("pp100" "GAB2" "KIAA0571"))
(define-protein "GAB3_HUMAN" ("GAB3"))
(define-protein "GALC_HUMAN" ("GALC" "GALCERase" "Galactosylceramidase"))
(define-protein "GAP" NIL)
(define-protein "GAPD1_HUMAN" ("GAPEX5" "GAPex-5" "KIAA1521" "RAP6" "GAPVD1"))
(define-protein "GAPR1_HUMAN" ("GAPR-1" "C9orf19" "GAPR1" "GLIPR2"))
(define-protein "GBB1_HUMAN" ("GNB1"))
(define-protein "GBB3_HUMAN" ("GNB3"))
(define-protein "GBF1_HUMAN" ("KIAA0248" "GBF1"))
(define-protein "GBG10_HUMAN" ("GNGT10" "GNG10"))
(define-protein "GBG12_HUMAN" ("GNG12"))
(define-protein "GBG2_HUMAN" ("GNG2"))
(define-protein "GBG3_HUMAN" ("GNGT3" "GNG3"))
(define-protein "GBG4_HUMAN" ("GNGT4" "GNG4"))
(define-protein "GBG5_HUMAN" ("GNGT5" "GNG5"))
(define-protein "GBG7_HUMAN" ("GNGT7" "GNG7"))
(define-protein "GBG8_HUMAN" ("GNGT9" "GNG9" "GNG8" "Gamma-9"))
(define-protein "GBLP_HUMAN" ("GNB2L1" "RACK1" "HLC-7"))
(define-protein "GCC1_HUMAN" ("GCC1"))
(define-protein "GCN1L_HUMAN" ("KIAA0219" "GCN1L1" "HsGCN1"))
(define-protein "GCP2_HUMAN" ("GCP2" "hGrip103" "h103p" "TUBGCP2" "hSpc97" "GCP-2" "hGCP2"))
(define-protein "GDF11_HUMAN" ("GDF-11" "GDF11" "BMP11" "BMP-11"))
(define-protein "GDF15_HUMAN" ("GDF15" "NAG-1" "GDF-15" "PTGFB" "MIC1" "PLAB" "MIC-1" "PDF" "NRG-1"))
(define-protein "GDF1_HUMAN" ("GDF-1" "GDF1"))
(define-protein "GDF2_HUMAN" ("GDF-2" "BMP-9" "BMP9" "GDF2"))
(define-protein "GDF3_HUMAN" ("GDF-3" "GDF3"))
(define-protein "GDF5_HUMAN" ("BMP14" "LAP-4" "BMP-14" "CDMP-1" "CDMP1" "Radotermin" "GDF-5" "GDF5"))
(define-protein "GDF6_HUMAN" ("GDF-6" "BMP13" "GDF6" "GDF16" "BMP-13"))
(define-protein "GDF7_HUMAN" ("GDF-7" "GDF7"))
(define-protein "GDF8_HUMAN" ("GDF-8" "MSTN" "GDF8" "Myostatin"))
(define-protein "GDF9_HUMAN" ("GDF-9" "GDF9"))
(define-protein "GDIB_HUMAN" ("GDI-2" "RABGDIB" "GDI2"))
(define-protein "GDNF_HUMAN" ("hGDNF" "GDNF" "ATF"))
(define-protein "GDS1_HUMAN" ("RAP1GDS1"))
(define-protein "GFRA1_HUMAN" ("GDNFRA" "GDNFR-alpha-1" "RETL1" "TRNR1" "GFRA1" "GFR-alpha-1"))
(define-protein "GLCM_HUMAN" ("Beta-glucocerebrosidase" "GLUC" "Alglucerase" "Beta-GC" "GBA" "Imiglucerase" "GC"))
(define-protein "GLP3L_HUMAN" ("GPP34R" "GOLPH3L"))
(define-protein "GLYR1_HUMAN" ("HIBDL" "NP60" "GLYR1"))
(define-protein "GNA13_HUMAN" ("GNA13"))
(define-protein "GNA14_HUMAN" ("GNA14"))
(define-protein "GNA15_HUMAN" ("GNA16" "GNA15"))
(define-protein "GNAI1_HUMAN" ("GNAI1"))
(define-protein "GNAI2_HUMAN" ("GNAI2" "GNAI2B"))
(define-protein "GNAO_HUMAN" ("GNAO1"))
(define-protein "GNAQ_HUMAN" ("GAQ" "GNAQ"))
(define-protein "GNAS1_HUMAN" ("GNAS" "GNAS1" "XLalphas"))
(define-protein "GNDS_HUMAN" ("RGF" "KIAA1308" "RalGDS" "RALGDS" "RalGEF"))
(define-protein "GNPAT_HUMAN" ("DHAP-AT" "DAPAT" "GNPAT" "DAP-AT" "Acyl-CoA:dihydroxyacetonephosphateacyltransferase" "DHAPAT"))
(define-protein "GOGA7_HUMAN" ("GCP16" "GOLGA7"))
(define-protein "GOLI4_HUMAN" ("GIMPc" "GPP130" "GOLIM4" "GIMPC" "GOLPH4"))
(define-protein "GOLP3_HUMAN" ("GOLPH3" "GPP34" "MIDAS"))
(define-protein "GOPC_HUMAN" ("PIST" "CAL" "FIG" "GOPC"))
(define-protein "GOSR1_HUMAN" ("GOS-28" "GOSR1" "GS28"))
(define-protein "GOSR2_HUMAN" ("Membrin" "GOSR2" "GS27"))
(define-protein "GOT1B_HUMAN" ("hGOT1a" "GOLT1B" "GOT1A" "GCT2"))
(define-protein "GPA33_HUMAN" ("GPA33"))
(define-protein "GPSM2_HUMAN" ("GPSM2" "LGN"))
(define-protein "GRAP1_HUMAN" ("GRIPAP1" "GRASP-1" "KIAA1167"))
(define-protein "GRAP2_HUMAN" ("GRAP2" "Grf-40" "GRID" "P38" "GRBX" "GRBLG" "GADS" "GRB2L"))
(define-protein "GRAP_HUMAN" ("GRAP"))
(define-protein "GRB10_HUMAN" ("KIAA0207" "GRB10" "GRBIR"))
(define-protein "GRB14_HUMAN" ("GRB14"))
(define-protein "GRB2_HUMAN" ("ASH" "GRB2"))
(define-protein "GRP1_HUMAN" ("RASGRP" "RASGRP1" "CalDAG-GEFII"))
(define-protein "GRP2_HUMAN" ("CDC25L" "hCDC25L" "MCG7" "RASGRP2" "CalDAG-GEFI"))
(define-protein "GRP3_HUMAN" ("GRP3" "RASGRP3" "KIAA0846"))
(define-protein "GRP4_HUMAN" ("RASGRP4"))
(define-protein "GRTP1_HUMAN" ("TBC1D6" "GRTP1"))
(define-protein "GSK3B_HUMAN" ( "GSK3B"))
(define-protein "GTPB1_HUMAN" ("GP-1" "GP1" "GTPBP1"))
(define-protein "GTR14_HUMAN" ("GLUT3" "SLC2A14" "GLUT14" "GLUT-14"))
(define-protein "GTR1_HUMAN" ("GLUT1" "GLUT-1" "SLC2A1"))
(define-protein "GTR3_HUMAN" ("GLUT3" "GLUT-3" "SLC2A3"))
(define-protein "Gab" NIL)
(define-protein "Galphaq" NIL)
(define-protein "Gbetagamma" NIL)
(define-protein "Grb2" NIL)
(define-protein "Grb7" NIL)
(define-protein "HAP28_HUMAN" ("HASPP28" "PDAP1" "PAP1" "PAP"))
(define-protein "HAUS1_HUMAN" ("HAUS1" "HEI-C" "CCDC5" "HEIC"))
(define-protein "HAUS3_HUMAN" ("HAUS3" "C4orf15"))
(define-protein "HAX1_HUMAN" ("HAX-1" "HS1BP1" "HAX1" "HSP1BP-1"))
(define-protein "HBEGF_HUMAN" ("DT-R" "HEGFL" "HB-EGF" "HBEGF" "DTS" "DTR"))
(define-protein "HCFC1_HUMAN" ("HFC1" "HCF-1" "HCF" "VCAF" "HCF1" "HCFC1" "CFF"))
(define-protein "HCK_HUMAN" ("HCK" "p61Hck" "p59-HCK/p60-HCK" "p59Hck"))
(define-protein "HDGR3_HUMAN" ("HDGFRP3" "HRP-3" "HDGF-2" "HDGF2"))
(define-protein "HD_HUMAN" ("HTT" "IT15" "HD"))
(define-protein "HGF_HUMAN" ("SF" "HPTA" "Hepatopoietin-A" "HGF"))
(define-protein "HGS_HUMAN" ("HGS" "HRS" "Hrs"))
(define-protein "HIP1R_HUMAN" ("HIP-12" "HIP1R" "KIAA0655" "HIP12"))
(define-protein "HIP1_HUMAN" ("HIP1" "HIP-I" "HIP-1"))
(define-protein "HLAH_HUMAN" ("HLA-12.4" "HLA-H" "HLA-AR" "HLAH"))
(define-protein "HMGB2_HUMAN" ("HMG2" "HMG-2" "HMGB2"))
(define-protein "HMGN3_HUMAN" ("HMGN3" "TRIP7" "TRIP-7"))
(define-protein "HNF4A_HUMAN" ("TCF-14" "TCF14" "HNF4" "HNF4A" "HNF-4-alpha" "NR2A1"))
(define-protein "HNRPC_HUMAN" ("HNRPC" "HNRNPC"))
(define-protein "HOOK1_HUMAN" ("HOOK1" "hHK1" "h-hook1"))
(define-protein "HOOK2_HUMAN" ("HOOK2" "hHK2" "h-hook2"))
(define-protein "HS90A_HUMAN" ("HSPC1" "LAP-2" "HSPCA" "HSP90AA1" "HSP90A" "HSP86"))
(define-protein "HSDL2_HUMAN" ("HSDL2" "C9orf99"))
(define-protein "HSP71_HUMAN" ("HSP70-1/HSP70-2" "HSPA1A" "HSPA1B" "HSP70.1/HSP70.2" "HSPA1" "HSX70"))
(define-protein "ICEF1_HUMAN" ("KIAA0403" "IPCEF1"))
(define-protein "ICMT_HUMAN" ("PPMT" "pcCMT" "PCCMT" "ICMT"))
(define-protein "IF1AY_HUMAN" ("eIF-4C" "EIF1AY"))
(define-protein "IF2B2_HUMAN" ("VICKZ2" "IMP-2" "IGF2BP2" "IMP2"))
(define-protein "IFNG_HUMAN" ("IFN-gamma" "IFNG"))
(define-protein "IFRD2_HUMAN" ("IFRD2"))
(define-protein "IGF1R_HUMAN" ( "IGF1R" "CD221"))
(define-protein "IGF1_HUMAN" ("IBP1" "IGF-I" "Somatomedin-C" "IGF1" "IGF-1" "MGF"))
(define-protein "IGS21_HUMAN" ("IGSF21" "IgSF21"))
(define-protein "IKZF3_HUMAN" ("IKZF3" "ZNFN1A3"))
(define-protein "IL1B_HUMAN" ("IL1B" "Catabolin" "IL1F2"))
(define-protein "IL2RA_HUMAN" ("IL2-RA" "IL2RA" "IL-2-RA" "CD25" "p55"))
(define-protein "IL2RB_HUMAN" ("IL2RB" "CD122" "IL-2RB" "p70-75" "p75"))
(define-protein "IL2RG_HUMAN" ("IL2RG" "CD132" "p64" "IL-2RG" "gammaC"))
(define-protein "IL2_HUMAN" ("IL2" "IL-2" "Aldesleukin" "TCGF"))
(define-protein "IL3RA_HUMAN" ("IL-3R-alpha" "IL3R" "CD123" "IL3RA" "IL-3RA"))
(define-protein "IL3RB_HUMAN" ("CDw131" "CSF2RB" "IL3RB" "IL5RB" "CD131"))
(define-protein "IL3_HUMAN" ("IL3" "IL-3" "MCGF"))
(define-protein "IL5RA_HUMAN" ("IL-5R-alpha" "IL-5RA" "CDw125" "IL5R" "CD125" "IL5RA"))
(define-protein "IL5_HUMAN" ("TRF" "IL5" "IL-5"))
(define-protein "ILF3_HUMAN" ("NF-AT-90" "TCP80" "DRBF" "ILF3" "NF90" "MPHOSPH4" "MPP4" "DRBP76" "NFAR"))
(define-protein "ILKAP_HUMAN" ("ILKAP"))
(define-protein "ILK_HUMAN" ("p59ILK" "ILK" "ILK1" "ILK-2" "ILK-1" "ILK2"))
(define-protein "IMB1_HUMAN" ("NTF97" "KPNB1" "Importin-90" "PTAC97"))
(define-protein "INHBA_HUMAN" ("INHBA" "EDF"))
(define-protein "INHBB_HUMAN" ("INHBB"))
(define-protein "INHBC_HUMAN" ("INHBC"))
(define-protein "INHBE_HUMAN" ("INHBE"))
(define-protein "INSR_HUMAN" ("IR" "INSR" "CD220"))
(define-protein "INS_HUMAN" ("INS"))
(define-protein "INT3_HUMAN" ("C1orf60" "Int3" "C1orf193" "INTS3" "SOSS-A"))
(define-protein "IQGA1_HUMAN" ("IQGAP1" "p195" "KIAA0051"))
(define-protein "IQGA2_HUMAN" ("IQGAP2"))
(define-protein "IQGA3_HUMAN" ("IQGAP3"))
(define-protein "IRAK1_HUMAN" ("IRAK1" "IRAK-1" "IRAK"))
(define-protein "IRAK2_HUMAN" ("IRAK2" "IRAK-2"))
(define-protein "IRF9_HUMAN" ("IRF-9" "ISGF3G" "IRF9"))
(define-protein "IRS1_HUMAN" ("IRS-1" "IRS1"))
(define-protein "IRS2_HUMAN" ("IRS-2" "IRS2"))
(define-protein "IST1_HUMAN" ("hIST1" "IST1" "KIAA0174"))
(define-protein "ITA2_HUMAN" ("CD49B" "ITGA2" "GPIa" "CD49b"))
(define-protein "ITA3_HUMAN" ("GAPB3" "CD49c" "MSK18" "ITGA3" "FRP-2"))
(define-protein "ITA6_HUMAN" ("ITGA6" "CD49f" "VLA-6" "Alpha6p"))
(define-protein "ITAV_HUMAN" ("VNRA" "MSK8" "CD51" "ITGAV"))
(define-protein "ITB1_HUMAN" ("ITGB1" "GPIIA" "MDF2" "FNRB" "CD29" "MSK12"))
(define-protein "ITB4_HUMAN" ("GP150" "CD104" "ITGB4"))
(define-protein "ITB5_HUMAN" ("ITGB5"))
(define-protein "ITSN1_HUMAN" ("ITSN1" "SH3D1A" "SH3P17" "ITSN"))
(define-protein "IWS1_HUMAN" ("IWS1" "IWS1L"))
(define-protein "JAG1_HUMAN" ("JAGL1" "CD339" "hJ1" "JAG1" "Jagged1"))
(define-protein "JAG2_HUMAN" ("JAG2" "hJ2" "Jagged2"))
(define-protein "JAK1_HUMAN" ("JAK1A" "JAK-1" "JAK1" "JAK1B"))
(define-protein "JAK2_HUMAN" ("JAK-2" "JAK2"))
(define-protein "JAK3_HUMAN" ("JAK-3" "JAK3" "L-JAK"))
(define-protein "JIP3_HUMAN" ("JIP-3" "JIP3" "MAPK8IP3" "KIAA1066"))
(define-protein "Jak2" NIL)
(define-protein "K1C18_HUMAN" ("Cytokeratin-18" "Keratin-18" "K18" "KRT18" "CK-18" "CYK18"))
(define-protein "KANL2_HUMAN" ("NSL2" "C12orf41" "KANSL2"))
(define-protein "KAP2_HUMAN" ("PRKAR2" "PRKAR2A" "PKR2"))
(define-protein "KBRS2_HUMAN" ("KBRAS2" "NKIRAS2" "KappaB-Ras2"))
(define-protein "KC1A_HUMAN" ("CSNK1A1" "CK1" "CKI-alpha"))
(define-protein "KC1D_HUMAN" ("CKId" "CSNK1D" "HCKID" "CKI-delta"))
(define-protein "KCC2A_HUMAN" ("CAMKA" "CAMK2A" "KIAA0968"))
(define-protein "KCC2B_HUMAN" ("CAMK2" "CAMK2B" "CAM2" "CAMKB"))
(define-protein "KCC2D_HUMAN" ("CAMK2D" "CAMKD"))
(define-protein "KCC2G_HUMAN" ("CAMK-II" "CAMK2G" "CAMK" "CAMKG"))
(define-protein "KDM4D_HUMAN" ("KDM4D" "JMJD2D" "JHDM3D"))
(define-protein "KHDR1_HUMAN" ("p68" "SAM68" "KHDRBS1" "Sam68"))
(define-protein "KI20B_HUMAN" ("KRMP1" "MPHOSPH1" "MPP1" "KIF20B" "CT90"))
(define-protein "KIF11_HUMAN" ("TRIP-5" "EG5" "KIF11" "TRIP5" "KNSL1"))
(define-protein "KIF1A_HUMAN" ("hUnc-104" "ATSV" "KIF1A" "C2orf20"))
(define-protein "KIF2A_HUMAN" ("KNS2" "KIF2A" "hK2" "KIF2" "Kinesin-2"))
(define-protein "KIF4A_HUMAN" ("KIF4" "KIF4A" "Chromokinesin-A"))
(define-protein "KIFC1_HUMAN" ("KIFC1" "KNSL2" "HSET"))
(define-protein "KINH_HUMAN" ("UKHC" "KIF5B" "KNS1" "KNS"))
(define-protein "KIT_HUMAN" ("CD117" "SCFR" "KIT" "PBT"))
(define-protein "KLC1_HUMAN" ("KNS2" "KLC1" "KLC"))
(define-protein "KLC2_HUMAN" ("KLC2"))
(define-protein "KLC4_HUMAN" ("KNSL8" "KLC4"))
(define-protein "KLF3_HUMAN" ("TEF-2" "BKLF" "KLF3"))
(define-protein "KLOTB_HUMAN" ("BetaKlotho" "BKL" "KLB"))
(define-protein "KLOT_HUMAN" ("KL"))
(define-protein "KNTC1_HUMAN" ("HsROD" "KIAA0166" "hRod" "Rod" "KNTC1"))
(define-protein "KPCA_HUMAN" ("PKCA" "PKC-alpha" "PKC-A" "PRKACA" "PRKCA"))
(define-protein "KPCB_HUMAN" ("PKCB" "PRKCB1" "PKC-B" "PKC-beta" "PRKCB"))
(define-protein "KPCD1_HUMAN" ("PRKD1" "PKD" "nPKC-D1" "PRKCM" "PKD1" "nPKC-mu"))
(define-protein "KPCD2_HUMAN" ("PRKD2" "nPKC-D2" "PKD2"))
(define-protein "KPCD3_HUMAN" ("EPK2" "PRKCN" "nPKC-nu" "PRKD3"))
(define-protein "KPCD_HUMAN" ("SDK1" "nPKC-delta" "PRKCD"))
(define-protein "KPCE_HUMAN" ("nPKC-epsilon" "PRKCE" "PKCE"))
(define-protein "KPCG_HUMAN" ("PKCG" "PKC-gamma" "PRKCG"))
(define-protein "KPCI_HUMAN" ("aPKC-lambda/iota" "PRKCI" "PRKC-lambda/iota" "nPKC-iota" "DXS1179E"))
(define-protein "KPCL_HUMAN" ("PKC-L" "PRKCL" "nPKC-eta" "PRKCH" "PKCL"))
(define-protein "KPCT_HUMAN" ("PRKCQ" "nPKC-theta" "PRKCT"))
(define-protein "KPCZ_HUMAN" ("nPKC-zeta" "PRKCZ" "PKC2"))
(define-protein "KPYM_HUMAN" ("OIP-3" "PKM" "OIP3" "p58" "THBP1" "CTHBP" "PKM2" "PK3" "PK2"))
(define-protein "KS6A1_HUMAN" ("MAPKAPK-1a" "S6K-alpha-1" "p90S6K" "RSK1" "MAPKAPK1A" "RSK-1" "RPS6KA1" "p90RSK1"))
(define-protein "KS6A3_HUMAN" ("pp90RSK2" "MAPKAPK-1b" "RPS6KA3" "S6K-alpha-3" "ISPK1" "RSK2" "MAPKAPK1B" "ISPK-1" "RSK-2" "p90RSK3"))
(define-protein "KS6A4_HUMAN" ( "RSKB" "MSK2" "RPS6KA4" "S6K-alpha-4"))
(define-protein "KS6A5_HUMAN" ("RSKL" "MSK1" "S6K-alpha-5" "RPS6KA5"))
(define-protein "KSR1_HUMAN" ("KSR1" "KSR"))
(define-protein "KSYK_HUMAN" ( "SYK" "p72-Syk"))
(define-protein "KTHY_HUMAN" ( "TYMK" "DTYMK" "CDC8" "TMPK"))
(define-protein "L2GL2_HUMAN" ("LLGL2" "HGL"))
(define-protein "LAMP1_HUMAN" ("LAMP1" "LAMP-1" "CD107a"))
(define-protein "LAMP2_HUMAN" ("LAMP2" "LAMP-2" "CD107b"))
(define-protein "LANC1_HUMAN" ("p40" "GPR69A" "LANCL1"))
(define-protein "LAP2_HUMAN" ("ERBIN" "Erbin" "LAP2" "ERBB2IP" "KIAA1225"))
(define-protein "LAT_HUMAN" ("pp36" "LAT" "p36-38"))
(define-protein "LBR_HUMAN" ("LMN2R" "LBR"))
(define-protein "LCK_HUMAN" ( "LSK" "p56-LCK" "LCK"))
(define-protein "LCP2_HUMAN" ("LCP2" "SLP76"))
(define-protein "LDHA_HUMAN" ("LDHA" "LDH-M" "LDH-A"))
(define-protein "LEG1_HUMAN" ("Galaptin" "Gal-1" "HPL" "HBL" "HLBP14" "LGALS1"))
(define-protein "LEG3_HUMAN" ("MAC2" "Gal-3" "GALBP" "L-31" "LGALS3"))
(define-protein "LEG4_HUMAN" ("Gal-4" "LGALS4" "L36LBP"))
(define-protein "LFNG_HUMAN" ("LFNG"))
(define-protein "LGMN_HUMAN" ("PRSC1" "LGMN"))
(define-protein "LGR5_HUMAN" ("GPR49" "GPR67" "LGR5"))
(define-protein "LIN7C_HUMAN" ("Veli-3" "LIN7C" "Lin-7C" "MALS-3" "VELI3" "MALS3"))
(define-protein "LMO7_HUMAN" ("LMO7" "LOMP" "FBX20" "LMO-7" "KIAA0858" "FBXO20"))
(define-protein "LNX1_HUMAN" ("LNX1" "LNX" "PDZRN2"))
(define-protein "LNX2_HUMAN" ("LNX2" "PDZRN1"))
(define-protein "LNXp80" NIL)
(define-protein "LPAR1_HUMAN" ("LPA1" "LPA-1" "EDG2" "LPAR1"))
(define-protein "LPPRC_HUMAN" ("LRP130" "LRPPRC" "GP130"))
(define-protein "LRBA_HUMAN" ("LRBA" "BGL" "CDC4L" "LBA"))
(define-protein "LRC59_HUMAN" ("p34" "LRRC59"))
(define-protein "LRCH4_HUMAN" ("LRCH4" "LRRN4" "LRRN1" "LRN"))
(define-protein "LRP10_HUMAN" ("LRP-10" "LRP10"))
(define-protein "LSG1_HUMAN" ("hLsg1" "LSG1"))
(define-protein "LTOR3_HUMAN" ("MAPKSP1" "Mp1" "MAP2K1IP1" "LAMTOR3"))
(define-protein "LYAG_HUMAN" ("GAA"))
(define-protein "LYN_HUMAN" ("p53Lyn" "LYN" "p56Lyn" "JTK8"))
(define-protein "Lgals1" ("Galectin-1"))
(define-protein "M2OM_HUMAN" ("OGCP" "SLC20A4" "SLC25A11"))
(define-protein "M3K1_HUMAN" ("MAP3K1" "MEKK1" "MEKK" "MAPKKK1"))
(define-protein "M3K4_HUMAN" ( "MTK1" "KIAA0213" "MEKK4" "MAPKKK4" "MAP3K4"))
(define-protein "M3KCL_HUMAN" ("MAP3K7CL" "C21orf7" "TAK1L"))
(define-protein "MAGG1_HUMAN" ("MAGEG1" "NDNL2" "HCA4"))
(define-protein "MAML1_HUMAN" ("MAML1" "KIAA0200" "Mam-1"))
(define-protein "MAN1_HUMAN" ("LEMD3" "MAN1"))
(define-protein "MAP1S_HUMAN" ("MAP-1S" "VCY2IP-1" "C19orf5" "MAP1S" "MAP8" "BPY2IP1" "VCY2IP1"))
(define-protein "MAPK2_HUMAN" ("MAPKAPK-2" "MK-2" "MK2" "MAPKAP-K2" "MAPKAPK2"))
(define-protein "MAPK3_HUMAN" ( "MAPKAPK-3" "MK-3" "MAPKAPK3" "3pK" "MAPKAP-K3"))
(define-protein "MAPK5_HUMAN" ("MK-5" "MAPKAP-K5" "MAPKAPK-5" "MAPKAPK5" "PRAK" "MK5"))
(define-protein "MARE1_HUMAN" ("MAPRE1" "EB1"))
(define-protein "MARK2_HUMAN" ("MARK2" "EMK1" "Par1b" "EMK-1" "Par-1b"))
(define-protein "MB12A_HUMAN" ("CFBP" "MVB12A" "FAM125A"))
(define-protein "MCM2_HUMAN" ("CCNL1" "KIAA0030" "CDCL1" "MCM2" "BM28"))
(define-protein "MD2L1_HUMAN" ("MAD2" "HsMAD2" "MAD2L1"))
(define-protein "MDM2_HUMAN" ( "MDM2" "Hdm2"))
(define-protein "MEK" NIL)
(define-protein "MEKK1/4" NIL)
(define-protein "MERL_HUMAN" ("Neurofibromin-2" "NF2" "Schwannomerlin" "SCH" "Schwannomin"))
(define-protein "MET_HUMAN" ("MET"))
(define-protein "MFNG_HUMAN" ("MFNG"))
(define-protein "MIF_HUMAN" ("MMIF" "GIF" "MIF" "GLIF"))
(define-protein "MIRO1_HUMAN" ("ARHT1" "MIRO-1" "hMiro-1" "RHOT1"))
(define-protein "MIRO2_HUMAN" ("ARHT2" "MIRO-2" "C16orf39" "RHOT2" "hMiro-2"))
(define-protein "MK01_HUMAN" ("ERT1" "p42-MAPK" "ERK-2" "ERK2" "PRKM1" "MAPK1" "PRKM2"))
(define-protein "MK03_HUMAN" ("ERK1" "PRKM3" "p44-MAPK" "ERK-1" "p44-ERK1" "ERT2" "MAPK3"))
(define-protein "MK07_HUMAN" ("ERK5" "PRKM7" "ERK-5" "MAPK7" "BMK1" "BMK-1"))
(define-protein "MK08_HUMAN" ("PRKM8" "SAPK1c" "SAPK1" "JNK-46" "JNK1" "MAPK8" "SAPK1C"))
(define-protein "MK13_HUMAN" ("MAPK13" "PRKM13" "SAPK4"))
(define-protein "MK14_HUMAN" ("CSBP2" "SAPK2A" "MAPK14" "CSPB1" "CSBP1" "SAPK2a" "CSBP" "MXI2"))
(define-protein "ML12A_HUMAN" ("MYL12A" "HEL-S-24" "MLC-2B" "MRLC3" "RLC" "MLCB"))
(define-protein "MLK3" NIL)
(define-protein "MMTA2_HUMAN" ("C1orf35" "MMTAG2" "hMMTAG2"))
(define-protein "MOB1B_HUMAN" ("MOB1B" "MOBKL1A" "Mob1B" "Mob1A" "MOB4A"))
(define-protein "MOES_HUMAN" ("MSN"))
(define-protein "MOGS_HUMAN" ("GCS1" "MOGS"))
(define-protein "MON2_HUMAN" ("SF21" "KIAA1040" "MON2"))
(define-protein "MP2K1_HUMAN" ("MEK1" "MAP2K1" "PRKMK1" "MKK1"))
(define-protein "MP2K2_HUMAN" ("MEK2" "MAP2K2" "PRKMK2" "MKK2"))
(define-protein "MP2K3_HUMAN" ("SAPKK2" "MEK3" "SKK2" "MAP2K3" "PRKMK3" "MKK3" "SAPKK-2"))
(define-protein "MP2K4_HUMAN" ("SEK1" "SAPKK1" "JNKK" "MEK4" "JNKK1" "PRKMK4" "SERK1" "MAP2K4" "MKK4" "SKK1" "SAPKK-1"))
(define-protein "MPCP_HUMAN" ("SLC25A3" "PHC" "PTP"))
(define-protein "MPIP1_HUMAN" ("CDC25A"))
(define-protein "MPIP2_HUMAN" ("CDC25HU2" "CDC25B"))
(define-protein "MPIP3_HUMAN" ("CDC25C"))
(define-protein "MRCKB_HUMAN" ("CDC42BPB" "KIAA1124" "CDC42BP-beta"))
(define-protein "MRCKG_HUMAN" ("DMPK2" "CDC42BPG" "MRCKG"))
(define-protein "MRI_HUMAN" ("MRI" "C7orf49"))
(define-protein "MRP_HUMAN" ("MARCKSL1" "Mac-MARCKS" "MRP" "MLP" "MacMARCKS"))
(define-protein "MS3L1_HUMAN" ("MSL3L1" "MSL3"))
(define-protein "MSPD2_HUMAN" ("MOSPD2"))
(define-protein "MTAP2_HUMAN" ("MAP2" "MAP-2"))
(define-protein "MTOR_HUMAN" ("RAPT1" "FRAP" "FRAP2" "RAFT1" "mTOR" "MTOR" "FRAP1"))
(define-protein "MUC13_HUMAN" ("MUC-13" "RECC" "MUC13" "DRCC1"))
(define-protein "MUC18_HUMAN" ("MCAM" "MUC18" "CD146"))
(define-protein "MVP_HUMAN" ("MVP" "LRP"))
(define-protein "MX1_HUMAN" ("IFI-78K" "MX1"))
(define-protein "MY18A_HUMAN" ("MYSPDZ" "KIAA0216" "MYO18A" "MAJN"))
(define-protein "MYB_HUMAN" ("MYB"))
(define-protein "MYC_HUMAN" ("BHLHE39" "bHLHe39" "MYC"))
(define-protein "MYH14_HUMAN" ("MYH14" "KIAA2034"))
(define-protein "MYH9_HUMAN" ("NMMHC-A" "MYH9" "NMMHC-IIA"))
(define-protein "MYL6B_HUMAN" ("MLC1sa" "MLC1SA" "MYL6B"))
(define-protein "MYL6_HUMAN" ("MLC-3" "LC17" "MYL6"))
(define-protein "MYO1A_HUMAN" ("MYO1A" "BBMI" "MIHC" "MYHL" "BBM-I"))
(define-protein "MYO1E_HUMAN" ("MYO1E" "Myosin-Ic" "MYO1C"))
(define-protein "MYO6_HUMAN" ("MYO6" "KIAA0389"))
(define-protein "MYO7B_HUMAN" ("MYO7B"))
(define-protein "MYOF_HUMAN" ("KIAA1207" "MYOF" "FER1L3"))
(define-protein "MYOME_HUMAN" ("KIAA0454" "MMGL" "PDE4DIP" "KIAA0477" "CMYA2"))
(define-protein "NAA15_HUMAN" ("NARG1" "NAA15" "TBDN100" "Tbdn100" "NATH" "GA19"))
(define-protein "NAAA_HUMAN" ("NAAA" "ASAHL" "PLT"))
(define-protein "NACA_HUMAN" ("NAC-alpha" "Alpha-NAC" "NACA"))
(define-protein "NC2A_HUMAN" ("NC2-alpha" "DRAP1"))
(define-protein "NCAM1_HUMAN" ("N-CAM-1" "NCAM-1" "NCAM" "CD56" "NCAM1"))
(define-protein "NCK1_HUMAN" ("NCK" "Nck-1" "NCK1"))
(define-protein "NCK2_HUMAN" ("GRB4" "Nck-2" "NCK2"))
(define-protein "NCOR2_HUMAN" ("SMRT" "SMAP270" "N-CoR2" "TRAC" "NCOR2" "CTG26"))
(define-protein "NEB2_HUMAN" ("Neurabin-II" "Spinophilin" "PPP1R9B" "PPP1R6"))
(define-protein "NEDD1_HUMAN" ("NEDD1" "NEDD-1"))
(define-protein "NEDD8_HUMAN" ("Neddylin" "NEDD-8"))
(define-protein "NEK6_HUMAN" ("NEK6"))
(define-protein "NEK9_HUMAN" ("NEK9" "NEK8" "NERCC" "KIAA1995" "Nek8"))
(define-protein "NEUL1_HUMAN" ("NEURL1" "NEURL1A" "RNF67" "NEURL" "h-neu"))
(define-protein "NEUL2_HUMAN" ("NEURL2" "C20orf163"))
(define-protein "NEUL4_HUMAN" ("KIAA1787" "NEURL4"))
(define-protein "NEUR1_HUMAN" ("NANH" "NEU1"))
(define-protein "NF1_HUMAN" ("NF1"))
(define-protein "NFL_HUMAN" ("NFL" "NF68" "NEFL" "NF-L"))
(define-protein "NGAP_HUMAN" ("RASAL2" "NGAP"))
(define-protein "NGF_HUMAN" ("Beta-NGF" "NGFB" "NGF"))
(define-protein "NHRF2_HUMAN" ("NHERF2" "NHERF-2" "SIP-1" "TKA-1" "SLC9A3R2"))
(define-protein "NIBL1_HUMAN" ("FAM129B" "MINERVA" "Meg-3" "C9orf88"))
(define-protein "NICA_HUMAN" ("NCSTN" "KIAA0253"))
(define-protein "NIPS1_HUMAN" ("NipSnap1" "NIPSNAP1"))
(define-protein "NIPS2_HUMAN" ("NipSnap2" "GBAS" "NIPSNAP2"))
(define-protein "NIcs" NIL)
(define-protein "NIct" NIL)
(define-protein "NLTP_HUMAN" ("SCP2" "SCP-chi" "SCP-2" "NSL-TP" "SCPX" "SCP-X"))
(define-protein "NOC2L_HUMAN" ("NOC2L" "NIR"))
(define-protein "NODAL_HUMAN" ("NODAL"))
(define-protein "NOL7_HUMAN" ("NOP27" "C6orf90" "NOL7"))
(define-protein "NOP16_HUMAN" ("NOP16"))
(define-protein "NOTC1_HUMAN" ("NICD" "hN1" "NEXT" "NOTCH1" "TAN1"))
(define-protein "NOTC2_HUMAN" ("hN2" "NOTCH2"))
(define-protein "NOTC3_HUMAN" ("NOTCH3"))
(define-protein "NOTC4_HUMAN" ("NOTCH4" "INT3" "hNotch4"))
(define-protein "NOX1_HUMAN" ("MOX-1" "NOX1" "MOX1" "NOH-1" "NOH1" "NOX-1"))
(define-protein "NO_VALUE" NIL)
(define-protein "NPM_HUMAN" ("NPM1" "Numatrin" "NPM"))
(define-protein "NR4A1_HUMAN" ("NAK1" "Nur77" "NR4A1" "HMR" "ST-59" "GFRP1"))
(define-protein "NRBP_HUMAN" ("NRBP" "NRBP1" "BCON3"))
(define-protein "NRF1_HUMAN" ("Alpha-pal" "NRF-1" "NRF1"))
(define-protein "NRG1_HUMAN" ("Pro-NRG1" "NRG1" "HRG" "HGL" "SMDF" "ARIA" "GGF" "heregulin" "neuregulin-1" "HRGA" "NDF"))
(define-protein "NRG2_HUMAN" ("NTAK" "Pro-NRG2" "NRG-2" "NRG2" "DON-1" "Neuregulin-2"))
(define-protein "NRG3_HUMAN" ("Pro-NRG3" "NRG-3" "NRG3" "Neuregulin-3"))
(define-protein "NRG4_HUMAN" ("Pro-NRG4" "NRG-4" "NRG4" "Neuregulin-4"))
(define-protein "NSDHL_HUMAN" ("H105E3" "NSDHL"))
(define-protein "NSF_HUMAN" ("NSF"))
(define-protein "NTF3_HUMAN" ("NT-3" "NGF-2" "NTF3" "HDNF"))
(define-protein "NTKL_HUMAN" ("TEIF" "CVAK90" "GKLP" "SCYL1" "TAPK" "TRAP" "NTKL"))
(define-protein "NTPCR_HUMAN" ("C1orf57" "NTPase" "NTPCR"))
(define-protein "NTRK3_HUMAN" ("GP145-TrkC" "Trk-C" "NTRK3" "TRKC"))
(define-protein "NUDC_HUMAN" ("NUDC"))
(define-protein "NUDT4_HUMAN" ("DIPP-2" "NUDT4" "DIPP2" "KIAA0487"))
(define-protein "NUMB_HUMAN" ("NUMB" "h-Numb"))
(define-protein "NUP50_HUMAN" ("NPAP60L" "NUP50"))
(define-protein "Nck" NIL)
(define-protein "Neuralized" NIL)
(define-protein "Next" NIL)
(define-protein "Notch" NIL)
(define-protein "OSB10_HUMAN" ("ORP10" "OSBP9" "ORP-10" "OSBPL10"))
(define-protein "OSB11_HUMAN" ("OSBP12" "ORP11" "ORP-11" "OSBPL11"))
(define-protein "OSBL3_HUMAN" ("ORP3" "ORP-3" "OSBPL3" "KIAA0704" "OSBP3"))
(define-protein "OSBL8_HUMAN" ("ORP-8" "OSBP10" "KIAA1451" "OSBPL8" "ORP8"))
(define-protein "OSBP1_HUMAN" ("OSBP1" "OSBP"))
(define-protein "OTU6B_HUMAN" ("DUBA5" "DUBA-5" "OTUD6B"))
(define-protein "OXSR1_HUMAN" ("KIAA1101" "OXSR1" "OSR1"))
(define-protein "P110ACT" NIL)
(define-protein "P2R3B_HUMAN" ("PPP2R3B" "PPP2R3L"))
(define-protein "P3C2A_HUMAN" ("PI3K-C2-alpha" "PIK3C2A"))
(define-protein "P3C2B_HUMAN" ("C2-PI3K" "PI3K-C2-beta" "PIK3C2B"))
(define-protein "P4R3A_HUMAN" ("SMEK1" "KIAA2010" "PPP4R3A" "PP4R3A"))
(define-protein "P73_HUMAN" ("P73" "TP73"))
(define-protein "P85A_HUMAN" ("PIK3R1" "GRB1"))
(define-protein "P85B_HUMAN" ("PIK3R2"))
(define-protein "PA24A_HUMAN" ("cPLA2" "CPLA2" "PLA2G4A" "Lysophospholipase" "PLA2G4"))
(define-protein "PA24B_HUMAN" ("PLA2G4B" "cPLA2-beta"))
(define-protein "PACN2_HUMAN" ("PACSIN2" "Syndapin-2" "Syndapin-II"))
(define-protein "PAK1_HUMAN" ("PAK1" "PAK-1" "Alpha-PAK" "p65-PAK"))
(define-protein "PAK2-PAK4" NIL)
(define-protein "PAK2_HUMAN" ("PAK-2" "p34" "Gamma-PAK" "p27" "PAK-2p27" "PAK-2p34" "PAK65" "p58" "C-t-PAK2" "PAK2"))
(define-protein "PAK3_HUMAN" ("Oligophrenin-3" "PAK-3" "OPHN3" "Beta-PAK" "PAK3"))
(define-protein "PAK4_HUMAN" ("PAK-4" "KIAA1142" "PAK4"))
(define-protein "PCAT2_HUMAN" ("LPCAT-2" "AGPAT11" "AYTL1" "LysoPAFAT" "LPAAT-alpha" "LPCAT2"))
(define-protein "PCLO_HUMAN" ("KIAA0559" "Aczonin" "PCLO" "ACZ"))
(define-protein "PCTL_HUMAN" ("StARD10" "PCTP-L" "SDCCAG28" "STARD10"))
(define-protein "PCYOX_HUMAN" ("PCL1" "PCYOX1" "KIAA0908"))
(define-protein "PDC10_HUMAN" ("CCM3" "TFAR15" "PDCD10"))
(define-protein "PDC6I_HUMAN" ("KIAA1375" "ALIX" "PDCD6IP" "Hp95" "AIP1"))
(define-protein "PDCD4_HUMAN" ("H731" "PDCD4"))
(define-protein "PDCD6_HUMAN" ("ALG2" "PDCD6"))
(define-protein "PDE6D_HUMAN" ("PDE6D" "PDED"))
(define-protein "PDGFA_HUMAN" ("PDGF1" "PDGFA" "PDGF-1"))
(define-protein "PDGFB_HUMAN" ("SIS" "PDGF2" "PDGFB" "Becaplermin" "PDGF-2"))
(define-protein "PDPK1_HUMAN" ( "PDPK1" "hPDK1" "PDK1"))
(define-protein "PDS5A_HUMAN" ("PDS5A" "SCC-112" "PDS5" "KIAA0648"))
(define-protein "PDS5B_HUMAN" ("PDS5B" "APRIN" "KIAA0979" "AS3"))
(define-protein "PDZD8_HUMAN" ("PDZK8" "PDZD8"))
(define-protein "PEBP1_HUMAN" ("PBP" "HCNPpp" "PEBP1" "PEBP" "HCNP" "RKIP" "PEBP-1"))
(define-protein "PEBP4_HUMAN" ("CORK1" "hPEBP4" "PEBP4" "PEBP-4"))
(define-protein "PELP1_HUMAN" ("HMX3" "PELP1" "MNAR"))
(define-protein "PERQ2_HUMAN" ("GIGYF2" "KIAA0642" "PERQ2" "TNRC15"))
(define-protein "PFKAL_HUMAN" ("ATP-PFK" "PFK-B" "PFK-L" "Phosphohexokinase" "PFKL"))
(define-protein "PFKAP_HUMAN" ("PFKF" "PFK-C" "ATP-PFK" "Phosphohexokinase" "PFKP" "PFK-P"))
(define-protein "PGAM1_HUMAN" ("PGAMA" "PGAM-B" "PGAM1"))
(define-protein "PGAM5_HUMAN" ("PGAM5"))
(define-protein "PGFRA_HUMAN" ( "PDGFR-2" "RHEPDGFRA" "PDGFRA" "PDGF-R-alpha" "PDGFR-alpha" "PDGFR2" "CD140a"))
(define-protein "PGFRB_HUMAN" ("PDGFR-1" "PDGFRB" "PDGFR-beta" "PDGFR" "PDGFR1" "CD140b" "PDGF-R-beta"))
(define-protein "PGH2_HUMAN" ("COX-2" "PTGS2" "PGHS-2" "COX2" "Cyclooxygenase-2"))
(define-protein "PGTB1_HUMAN" ("PGGT1B" "GGTase-I-beta"))
(define-protein "PHAR4_HUMAN" ("PHACTR4"))
(define-protein "PHB2_HUMAN" ("BAP" "D-prohibitin" "PHB2" "REA"))
(define-protein "PHB_HUMAN" ("PHB"))
(define-protein "PHLA2_HUMAN" ("PHLDA2" "BWR1C" "p17-BWR1C" "HLDA2" "TSSC3" "IPL"))
(define-protein "PHLA3_HUMAN" ("PHLDA3" "TIH1"))
(define-protein "PHLB1_HUMAN" ("PHLDB1" "KIAA0638" "LL5A"))
(define-protein "PI3K" ("PI3 kinase" "PI-3 kinase"))
(define-protein "PI3R4_HUMAN" ( "PIK3R4"))
(define-protein "PI3R5_HUMAN" ("p101-PI3K" "PIK3R5"))
(define-protein "PI3R6_HUMAN" ("p87PIKAP" "PIK3R6" "C17orf38"))
(define-protein "PICK1_HUMAN" ("PRKCABP" "PICK1"))
(define-protein "PIGS_HUMAN" ("PIGS"))
(define-protein "PIK3CA" NIL)
(define-protein "PIM1_HUMAN" ("PIM1"))
(define-protein "PIN1_HUMAN" ("PIN1"))
(define-protein "PIN4_HUMAN" ("hPar17" "Par14" "hPar14" "Parvulin-17" "Par17" "Parvulin-14" "hEPVH" "PIN4"))
(define-protein "PIPNA_HUMAN" ("PITPN" "PITPNA" "PI-TP-alpha"))
(define-protein "PIPNB_HUMAN" ("PI-TP-beta" "PITPNB"))
(define-protein "PIP_HUMAN" ("gp17" "GCDFP-15" "SABP" "PIP" "GPIP4" "GCDFP15"))
(define-protein "PITM1_HUMAN" ("NIR-2" "PITPNM" "PITPNM1" "NIR2" "DRES9"))
(define-protein "PK3C3_HUMAN" ("hVps34" "PIK3C3" "VPS34"))
(define-protein "PK3CA_HUMAN" ("p110alpha" "PI3K-alpha" "PIK3CA" "PI3Kalpha"))
(define-protein "PK3CB_HUMAN" ("p110beta" "PI3K-beta" "PI3Kbeta" "PI3KC2β" "PIK3CB" "PIK3C1"))
(define-protein "PK3CD_HUMAN" ("PI3Kdelta" "PIK3CD" "PI3K-delta" "p110delta"))
(define-protein "PK3CG_HUMAN" ("p110gamma" "PIK3CG" "PI3K-gamma" "p120-PI3K" "PI3Kgamma"))
(define-protein "PKC" NIL)
(define-protein "PKHA1_HUMAN" ("PLEKHA1" "TAPP1" "TAPP-1"))
(define-protein "PKHA2_HUMAN" ("PLEKHA2" "TAPP2" "TAPP-2"))
(define-protein "PKHA5_HUMAN" ("KIAA1686" "PEPP2" "PLEKHA5" "PEPP-2"))
(define-protein "PKHA7_HUMAN" ("PLEKHA7"))
(define-protein "PKHF2_HUMAN" ("EAPF" "PLEKHF2" "ZFYVE18" "Phafin-2" "Phafin2"))
(define-protein "PKHG3_HUMAN" ("KIAA0599" "PLEKHG3"))
(define-protein "PKHH1_HUMAN" ("KIAA1200" "PLEKHH1"))
(define-protein "PKN2_HUMAN" ("PKN2" "PRK2" "PRKCL2"))
(define-protein "PLC-epsilon-1" NIL)
(define-protein "PLCB1_HUMAN" ("PLC-154" "PLC-beta-1" "KIAA0581" "PLCB1" "PLC-I"))
(define-protein "PLCB2_HUMAN" ("PLC-beta-2" "PLCB2"))
(define-protein "PLCB3_HUMAN" ("PLC-beta-3" "PLCB3"))
(define-protein "PLCB4_HUMAN" ("PLC-beta-4" "PLCB4"))
(define-protein "PLCE1_HUMAN" ("PLCE" "KIAA1516" "PLCE1" "PLC-epsilon-1" "PPLC"))
(define-protein "PLCG1_HUMAN" ("PLC1" "PLC-gamma-1" "PLC-148" "PLC-II" "PLCG1"))
(define-protein "PLCG2_HUMAN" ("PLC-IV" "PLC-gamma-2" "PLCG2"))
(define-protein "PLCbetagamma" NIL)
(define-protein "PLCgamma" NIL)
(define-protein "PLEC_HUMAN" ("Plectin-1" "PLTN" "PCN" "PLEC" "PLEC1" "HD1"))
(define-protein "PLEK2_HUMAN" ("PLEK2"))
(define-protein "PLIN3_HUMAN" ("TIP47" "M6PRBP1" "PP17" "PLIN3"))
(define-protein "PLLP_HUMAN" ("PMLP" "PLLP" "TM4SF11"))
(define-protein "PLSI_HUMAN" ("I-plastin" "PLS1"))
(define-protein "PMF1_HUMAN" ("PMF1" "PMF-1"))
(define-protein "POTEE_HUMAN" ("A26C1A" "POTE2" "POTEE" "POTE-2"))
(define-protein "PP1A_HUMAN" ("PP-1A" "PPP1CA" "PPP1A"))
(define-protein "PP1B_HUMAN" ("PP-1B" "PPP1CB" "PPP1CD"))
(define-protein "PP1R7_HUMAN" ("SDS22" "PPP1R7"))
(define-protein "PP2A" NIL)
(define-protein "PP2AA_HUMAN" ("RP-C" "PPP2CA" "PP2A-alpha"))
(define-protein "PP2AB_HUMAN" ("PP2A-beta" "PPP2CB"))
(define-protein "PPAC_HUMAN" ("LMW-PTP" "LMW-PTPase" "ACP1"))
(define-protein "PPARA_HUMAN" ("NR1C1" "PPAR-alpha" "PPAR" "PPARA"))
(define-protein "PPARG_HUMAN" ("PPAR-gamma" "PPARG" "NR1C3"))
(define-protein "PPCT_HUMAN" ("STARD2" "StARD2" "PC-TP" "PCTP"))
(define-protein "PPGB_HUMAN" ("CTSA" "PPCA" "PPGB"))
(define-protein "PPM1A_HUMAN" ("PPM1A" "PPPM1A" "PP2C-alpha"))
(define-protein "PPM1B_HUMAN" ("PP2C-beta" "PP2CB" "PPM1B"))
(define-protein "PPP5_HUMAN" ("PP-T" "PP5" "PPP5" "PPP5C" "PPT"))
(define-protein "PPT1_HUMAN" ("PPT1" "PPT-1" "PPT"))
(define-protein "PRAF1_HUMAN" ("RABAC1" "PRA1" "PRAF1"))
(define-protein "PRAF2_HUMAN" ("PRAF2"))
(define-protein "PRKDC_HUMAN" ("DNA-PK" "HYRC" "DNPK1" "p460" "PRKDC" "DNA-PKcs" "HYRC1" ))
(define-protein "PRR15_HUMAN" ("PRR15"))
(define-protein "PSB2_HUMAN" ("PSMB2"))
(define-protein "PSMD4_HUMAN" ("ASF" "MCB1" "AF" "PSMD4"))
(define-protein "PSN1_HUMAN" ("AD3" "PS-1" "PS1-CTF12" "PSEN1" "PS1" "PSNL1"))
(define-protein "PTN11_HUMAN" ("SHPTP2" "PTPN11" "SHP-2" "PTP-1D" "SH-PTP3" "SH-PTP2" "PTP2C" "PTP-2C" "Shp2"))
(define-protein "PTN1_HUMAN" ("PTPN1" "PTP-1B" "PTP1B"))
(define-protein "PTN6_HUMAN" ("PTPN6" "PTP-1C" "PTP1C" "SH-PTP1" "HCP"))
(define-protein "PTN9_HUMAN" ("PTPN9"))
(define-protein "PTPRA_HUMAN" ("PTPRA" "PTPRL2" "PTPA" "R-PTP-alpha"))
(define-protein "PTTG_HUMAN" ("PTTG1IP" "PBF" "C21orf3" "C21orf1"))
(define-protein "R51A1_HUMAN" ("RAD51AP1" "PIR51"))
(define-protein "RAB10_HUMAN" ("RAB10"))
(define-protein "RAB12_HUMAN" ("RAB12"))
(define-protein "RAB13_HUMAN" ("RAB13"))
(define-protein "RAB14_HUMAN" ("RAB14"))
(define-protein "RAB15_HUMAN" ("RAB15"))
(define-protein "RAB17_HUMAN" ("RAB17"))
(define-protein "RAB18_HUMAN" ("RAB18"))
(define-protein "RAB19_HUMAN" ("RAB19B" "RAB19"))
(define-protein "RAB1A_HUMAN" ("RAB1A" "RAB1"))
(define-protein "RAB1B_HUMAN" ("RAB1B"))
(define-protein "RAB20_HUMAN" ("RAB20"))
(define-protein "RAB21_HUMAN" ("RAB21" "KIAA0118"))
(define-protein "RAB23_HUMAN" ("RAB23"))
(define-protein "RAB25_HUMAN" ("CATX8" "RAB25" "CATX-8"))
(define-protein "RAB2A_HUMAN" ("RAB2A" "RAB2"))
(define-protein "RAB35_HUMAN" ("RAB35" "RAB1C" "RAY"))
(define-protein "RAB43_HUMAN" ("RAB41" "RAB43"))
(define-protein "RAB5A_HUMAN" ("RAB5" "RAB5A"))
(define-protein "RAB5B_HUMAN" ("RAB5B"))
(define-protein "RAB5C_HUMAN" ("L1880" "RABL" "RAB5L" "RAB5C"))
(define-protein "RAB6A_HUMAN" ("RAB6" "RAB6A" "Rab-6"))
(define-protein "RAB7A_HUMAN" ("RAB7A" "RAB7"))
(define-protein "RAB8A_HUMAN" ("RAB8" "MEL" "RAB8A"))
(define-protein "RAB9A_HUMAN" ("RAB9A" "RAB9"))
(define-protein "RABE1_HUMAN" ("RABPT5" "RABPT5A" "RABEP1" "Rabaptin-5alpha" "Rabaptin-5" "Rabaptin-4" "RAB5EP"))
(define-protein "RABEK_HUMAN" ("p40" "RABEPK" "RAB9P40"))
(define-protein "RABL3_HUMAN" ("RABL3"))
(define-protein "RABL6_HUMAN" ("RBEL1" "RABL6" "PARF" "C9orf86"))
(define-protein "RABX5_HUMAN" ("RABEX5" "Rabex-5" "RAP1" "RABGEF1"))
(define-protein "RAC1_HUMAN" ("p21-Rac1" "RAC1" "TC25"))
(define-protein "RAC2_HUMAN" ("p21-Rac2" "RAC2" "GX"))
(define-protein "RAC3_HUMAN" ("p21-Rac3" "RAC3"))
(define-protein "RADI_HUMAN" ("RDX"))
(define-protein "RAF1" NIL)
(define-protein "RAF1-BRAF" NIL)
(define-protein "RAF1_HUMAN" ("RAF" "RAF1" "cRaf" "Raf-1"))
(define-protein "RAGP1_HUMAN" ("SD" "RanGAP1" "RANGAP1" "KIAA1835"))
(define-protein "RAI3_HUMAN" ("RAI3" "RAIG-1" "GPRC5A" "GPCR5A" "RAIG1"))
(define-protein "RAIN_HUMAN" ("Rain" "RASIP1"))
(define-protein "RALA_HUMAN" ("RALA" "RAL"))
(define-protein "RALB_HUMAN" ("RALB"))
(define-protein "RANB9_HUMAN" ("RanBP9" "BPM-L" "BPM90" "RANBP9" "RANBPM" "RanBP7" "RanBPM"))
(define-protein "RANG_HUMAN" ("RanBP1" "RANBP1"))
(define-protein "RAN_HUMAN" ("ARA24" "RAN"))
(define-protein "RAP1A_HUMAN" ("KREV1" "G-22K" "RAP1A" "C21KG"))
(define-protein "RAP1B_HUMAN" ("RAP1B"))
(define-protein "RAP2B_HUMAN" ("RAP2B"))
(define-protein "RAS4B_HUMAN" ("RASA4B"))
(define-protein "RASA1_HUMAN" ("RASA" "p120GAP" "RasGAP" "GAP" "RASA1"))
(define-protein "RASA2_HUMAN" ("RASA2" "RASGAP" "GAP1m" "GAP1M"))
(define-protein "RASF1_HUMAN" ("RASSF1" "RDA32"))
(define-protein "RASF2_HUMAN" ("RASSF2" "KIAA0168"))
(define-protein "RASF5_HUMAN" ("NORE1" "RASSF5" "RAPL"))
(define-protein "RASH_HUMAN" ("Ha-Ras" "p21ras" "HRAS1" "c-H-ras" "H-Ras-1" "HRAS"))
(define-protein "RASK_HUMAN" ("KRAS2" "c-K-ras" "c-Ki-ras" "RASK2" "Ki-Ras" "KRAS"))
(define-protein "RASL1_HUMAN" ("RASAL" "RASAL1"))
(define-protein "RASL2_HUMAN" ("KIAA0538" "GAPL" "RASA4" "CAPRI"))
(define-protein "RASM_HUMAN" ("RRAS3" "MRAS"))
(define-protein "RASN_HUMAN" ("NRAS" "HRAS1"))
(define-protein "RB11A_HUMAN" ("RAB11" "RAB11A" "YL8" "Rab-11"))
(define-protein "RB11B_HUMAN" ("RAB11B" "YPT3"))
(define-protein "RB33B_HUMAN" ("RAB33B"))
(define-protein "RB3GP_HUMAN" ("KIAA0066" "RAB3GAP" "Rab3-GAP" "RAB3GAP1"))
(define-protein "RBGPR_HUMAN" ("Rab3-GAP150" "KIAA0839" "RGAP-iso" "RAB3GAP2"))
(define-protein "RBL2A_HUMAN" ("RABL2A"))
(define-protein "RBP17_HUMAN" ("RANBP17"))
(define-protein "RBPJL_HUMAN" ("RBPSUHL" "RBPL" "RBPJL"))
(define-protein "RBX1_HUMAN" ( "Rbx1" "RNF75" "RBX1" "ROC1"))
(define-protein "RB_HUMAN" ("pp110" "Rb" "pRb" "p105-Rb" "RB1"))
(define-protein "RCAS1_HUMAN" ("RCAS1" "EBAG9"))
(define-protein "RCD1_HUMAN" ("CNOT9" "RCD1" "RQCD1" "Rcd-1"))
(define-protein "REPS1_HUMAN" ("REPS1"))
(define-protein "RERG_HUMAN" ("RERG"))
(define-protein "RET_HUMAN" ("RET" "CDHR16" "RET51" "PTC" "CDHF12"))
(define-protein "RGAP1_HUMAN" ("RACGAP1" "MGCRACGAP" "CYK4" "MgcRacGAP" "HsCYK-4" "KIAA1478"))
(define-protein "RGDSR_HUMAN" ("RGL4" "hRGR" "RGR"))
(define-protein "RGL1_HUMAN" ("KIAA0959" "RGL1" "RGL"))
(define-protein "RGL2_HUMAN" ("RGL2" "RAB2L"))
(define-protein "RGRF1_HUMAN" ("CDC25" "GNRP" "GRF1" "RASGRF1" "Ras-GRF1"))
(define-protein "RGRF2_HUMAN" ("Ras-GRF2" "GRF2" "RASGRF2"))
(define-protein "RGS12_HUMAN" ("RGS12"))
(define-protein "RGS14_HUMAN" ("RGS14"))
(define-protein "RHEB_HUMAN" ("RHEB" "RHEB2"))
(define-protein "RHG01_HUMAN" ("p50-RhoGAP" "CDC42GAP" "RHOGAP1" "ARHGAP1"))
(define-protein "RHG04_HUMAN" ("RHOGAP4" "p115" "KIAA0131" "ARHGAP4" "RGC1"))
(define-protein "RHG08_HUMAN" ("ARHGAP8"))
(define-protein "RHG17_HUMAN" ("RICH-1" "ARHGAP17" "RICH1"))
(define-protein "RHG18_HUMAN" ("ARHGAP18" "MacGAP"))
(define-protein "RHG35_HUMAN" ("ARHGAP35" "p190-A" "GRF-1" "GRLF1" "GRF1" "KIAA1722"))
(define-protein "RHOA_HUMAN" ("RHO12" "ARH12" "h12" "RHOA" "ARHA"))
(define-protein "RHOB_HUMAN" ("ARH6" "h6" "RHOB" "ARHB"))
(define-protein "RHOD_HUMAN" ("RHOD" "ARHD" "RhoHP1"))
(define-protein "RHOF_HUMAN" ("RIF" "RHOF" "ARHF"))
(define-protein "RHOG_HUMAN" ("RHOG" "ARHG"))
(define-protein "RIC8A_HUMAN" ("RIC8A"))
(define-protein "RIF1_HUMAN" ("RIF1"))
(define-protein "RIMS1_HUMAN" ("RAB3IP2" "RIM1" "KIAA0340" "RIMS1"))
(define-protein "RIN1_HUMAN" ("RIN1"))
(define-protein "RIN2_HUMAN" ("RIN2" "RASSF4"))
(define-protein "RINT1_HUMAN" ("RINT1" "HsRINT-1" "RINT-1"))
(define-protein "RIT2_HUMAN" ("RIN" "RIT2" "ROC2"))
(define-protein "RKIP" NIL)
(define-protein "RL22_HUMAN" ("EAP" "RPL22"))
(define-protein "RL23A_HUMAN" ("RPL23A"))
(define-protein "RL29_HUMAN" ("RPL29"))
(define-protein "RL30_HUMAN" ("RPL30"))
(define-protein "RL39L_HUMAN" ("RPL39L" "RPL39L1"))
(define-protein "RMND1_HUMAN" ("C6orf96" "RMND1"))
(define-protein "RN115_HUMAN" ("RNF115" "ZNF364"))
(define-protein "RNAP" ("RNAPII"))
(define-protein "RNH2B_HUMAN" ("DLEU8" "AGS2" "RNASEH2B"))
(define-protein "ROCK1_HUMAN" ("ROCK-I" "ROCK1" "p160ROCK"))
(define-protein "RPGF1_HUMAN" ("RAPGEF1" "GRF2"))
(define-protein "RPGF2_HUMAN" ("KIAA0313" "PDZ-GEF1" "PDZGEF1" "RA-GEF-1" "RAPGEF2" "CNrasGEF" "NRAPGEP"))
(define-protein "RPGF4_HUMAN" ("CGEF2" "RAPGEF4" "cAMP-GEFII" "EPAC2"))
(define-protein "RPN1_HUMAN" ("RPN-I" "Ribophorin-1" "RPN1"))
(define-protein "RPN2_HUMAN" ("RPN-II" "RIBIIR" "Ribophorin-2" "RPN2"))
(define-protein "RRAS2_HUMAN" ("TC21" "RRAS2"))
(define-protein "RRAS_HUMAN" ("RRAS" "p23"))
(define-protein "RS20_HUMAN" ("RPS20"))
(define-protein "RS28_HUMAN" ("RPS28"))
(define-protein "RSF1_HUMAN" ("RSF1" "Rsf-1" "HBXAP" "XAP8"))
(define-protein "RSLBA_HUMAN" ("RASL11A"))
(define-protein "RSRP1_HUMAN" ("RSRP1" "C1orf63"))
(define-protein "RSU1_HUMAN" ("Rsu-1" "RSP1" "RSP-1" "RSU1"))
(define-protein "RTN3_HUMAN" ("RTN3" "HAP" "NSPL2" "ASYIP" "NSPLII"))
(define-protein "RUFY1_HUMAN" ("RABIP4" "RUFY1" "ZFYVE12"))
(define-protein "RUXE_HUMAN" ("SmE" "Sm-E" "SNRPE" "snRNP-E"))
(define-protein "Rac" NIL)
(define-protein "Raf" NIL)
(define-protein "Raf-1" NIL)
(define-protein "RalGDS" NIL)
;;(define-protein "Ras" NIL)
(define-protein "Ras-GDP" NIL)
(define-protein "Ras-GTP" NIL)
(define-protein "RasGAP" NIL)
(define-protein "RasGRF1" NIL)
(define-protein "Rassf5" NIL)
(define-protein "S2533_HUMAN" ("BMSC-MCP" "SLC25A33" "HuBMSC-MCP"))
(define-protein "S61A1_HUMAN" ("SEC61A1" "SEC61A"))
(define-protein "SAP3_HUMAN" ("SAP-3" "GM2-AP" "GM2A"))
(define-protein "SAP_HUMAN" ("SAP-2" "SAP-1" "Saposin-B" "PSAP" "Saposin-D" "Saposin-C" "Co-beta-glucosidase" "Saposin-A" "Dispersin" "Saposin-B-Val" "GLBA" "SAP1" "CSAct"))
(define-protein "SAR1A_HUMAN" ("SARA" "SAR1A" "SAR1" "SARA1"))
(define-protein "SARNP_HUMAN" ("SARNP" "HCC1"))
(define-protein "SART3_HUMAN" ("TIP110" "SART3" "KIAA0156" "SART-3" "Tip110"))
(define-protein "SBP1_HUMAN" ("SBP56" "SBP" "SELENBP1" "SP56"))
(define-protein "SC22B_HUMAN" ("ERS-24" "SEC22L1" "SEC22B" "ERS24"))
(define-protein "SC23A_HUMAN" ("SEC23A"))
(define-protein "SC31A_HUMAN" ("KIAA0905" "SEC31A" "SEC31L1" "ABP125" "ABP130"))
(define-protein "SC61B_HUMAN" ("SEC61B"))
(define-protein "SC61G_HUMAN" ("SEC61G"))
(define-protein "SCAM1_HUMAN" ("SCAMP" "SCAMP1"))
(define-protein "SCAM2_HUMAN" ("SCAMP2"))
(define-protein "SCAM3_HUMAN" ("C1orf3" "SCAMP3" "PROPIN1"))
(define-protein "SCAM4_HUMAN" ("SCAMP4"))
(define-protein "SCFD1_HUMAN" ("STXBP1L2" "C14orf163" "KIAA0917" "SCFD1" "Sly1p"))
(define-protein "SCFD2_HUMAN" ("STXBP1L1" "SCFD2"))
(define-protein "SCF_HUMAN" ("KITLG" "sKITLG" "SCF" "MGF"))
(define-protein "SCPDL_HUMAN" ("SCCPDH"))
(define-protein "SCRB2_HUMAN" ("LIMPII" "LIMP2" "LGP85" "CD36L2" "CD36" "SCARB2"))
(define-protein "SDC1_HUMAN" ("SDC" "SDC1" "SYND1" "CD138"))
(define-protein "SDC2_HUMAN" ("SDC2" "Fibroglycan" "HSPG" "CD362" "HSPG1" "SYND2"))
(define-protein "SDC3_HUMAN" ("SDC3" "SYND3" "KIAA0468"))
(define-protein "SDC4_HUMAN" ("Amphiglycan" "SDC4" "SYND4"))
(define-protein "SDCB1_HUMAN" ("SYCL" "SDCBP" "MDA9" "TACIP18" "MDA-9"))
(define-protein "SEC20_HUMAN" ("NIP1" "TRG-8" "BNIP1" "SEC20L"))
(define-protein "SEP10_HUMAN" ("SEPT10"))
(define-protein "SEP11_HUMAN" ("SEPT11"))
(define-protein "SEP14_HUMAN" ("SEPT14"))
(define-protein "SEPT2_HUMAN" ("NEDD5" "NEDD-5" "KIAA0158" "DIFF6" "SEPT2"))
(define-protein "SEPT7_HUMAN" ("SEPT7" "CDC10"))
(define-protein "SEPT8_HUMAN" ("SEPT8" "KIAA0202"))
(define-protein "SEPT9_HUMAN" ("KIAA0991" "SEPT9" "MSF"))
(define-protein "SERA_HUMAN" ("PGDH3" "3-PGDH" "PHGDH"))
(define-protein "SFT2B_HUMAN" ("SFT2D2"))
(define-protein "SFT2C_HUMAN" ("SFT2D3"))
(define-protein "SFXN1_HUMAN" ("TCC" "SFXN1"))
(define-protein "SGK3_HUMAN" ("CISK" "SGKL" "SGK3"))
(define-protein "SGMR1_HUMAN" ("SR-BP" "OPRS1" "hSigmaR1" "Sigma1-receptor" "SIG-1R" "SIGMAR1" "SRBP" "Sigma1R"))
(define-protein "SGPL1_HUMAN" ("SGPL1" "KIAA1252" "hSPL" "S1PL"))
(define-protein "SH23A_HUMAN" ("SH2D3A" "NSP1"))
(define-protein "SH2B2_HUMAN" ("APS" "SH2B2"))
(define-protein "SH3G2_HUMAN" ("CNSA2" "Endophilin-1" "EEN-B1" "SH3D2A" "SH3GL2"))
(define-protein "SH3K1_HUMAN" ("CIN85" "SH3KBP1" "HSB-1" "CD2BP3"))
(define-protein "SHB_HUMAN" ("SHB"))
(define-protein "SHC" NIL)
(define-protein "SHC1_HUMAN" ("SHC" "SHC1" "SHCA"))
(define-protein "SHC2_HUMAN" ("SCK" "SHC2" "SHCB"))
(define-protein "SHC3_HUMAN" ("N-Shc" "SHC3" "NSHC" "SHCC"))
(define-protein "SHD_HUMAN" ("SHD"))
(define-protein "SHIP1_HUMAN" ("SIP-145" "SHIP" "SHIP1" "INPP5D" "SHIP-1" "p150Ship" "hp51CN"))
(define-protein "SHLB1_HUMAN" ("KIAA0491" "Bif-1" "SH3GLB1"))
(define-protein "SHLB2_HUMAN" ("KIAA1848" "SH3GLB2"))
(define-protein "SHOC2_HUMAN" ("SHOC2" "KIAA0862"))
(define-protein "SKP1_HUMAN" ("SIII" "OCP-II" "OCP-2" "TCEB1L" "p19A" "EMC19" "SKP1" "OCP2" "p19skp1" "SKP1A"))
(define-protein "SLAI2_HUMAN" ("SLAIN2" "KIAA1458"))
(define-protein "SMAD2_HUMAN" ("Smad2" "MADH2" "hSMAD2" "JV18-1" "SMAD2" "hMAD-2" "MADR2"))
(define-protein "SMAD4_HUMAN" ("Smad4" "DPC4" "MADH4" "hSMAD4" "SMAD4"))
(define-protein "SMC1A_HUMAN" ("SMC1A" "SMC1" "Sb1.8" "SMC1L1" "SB1.8" "SMC-1-alpha" "SMC-1A" "DXS423E" "KIAA0178"))
(define-protein "SMC2_HUMAN" ("SMC-2" "hCAP-E" "SMC2" "SMC2L1" "CAPE"))
(define-protein "SMC3_HUMAN" ("BMH" "Bamacan" "CSPG6" "SMC3L1" "SMC3" "SMC-3" "hCAP" "BAM"))
(define-protein "SMC4_HUMAN" ("SMC4L1" "SMC-4" "SMC4" "CAPC" "hCAP-C"))
(define-protein "SMUF2_HUMAN" ( "hSMURF2" "SMURF2"))
(define-protein "SNAA_HUMAN" ("NAPA" "SNAP-alpha" "SNAPA"))
(define-protein "SNAG_HUMAN" ("SNAPG" "SNAP-gamma" "NAPG"))
(define-protein "SNAPN_HUMAN" ("SNAPAP" "BLOC1S7" "SNAP25BP" "SNAPIN"))
(define-protein "SNF8_HUMAN" ("SNF8" "EAP30" "hVps22"))
(define-protein "SNG2_HUMAN" ("SYNGR2" "Cellugyrin"))
(define-protein "SNP23_HUMAN" ("SNAP23" "SNAP-23"))
(define-protein "SNP29_HUMAN" ("SNAP29" "SNAP-29"))
(define-protein "SNPH_HUMAN" ("SNPH" "KIAA0374"))
(define-protein "SNTB2_HUMAN" ("D16S2531E" "SNTL" "SNT2B2" "SNTB2" "Syntrophin-like" "Syntrophin-3" "SNT3"))
(define-protein "SNX12_HUMAN" ("SNX12"))
(define-protein "SNX13_HUMAN" ("SNX13" "KIAA0713" "RGS-PX1"))
(define-protein "SNX14_HUMAN" ("SNX14"))
(define-protein "SNX15_HUMAN" ("SNX15"))
(define-protein "SNX17_HUMAN" ("SNX17" "KIAA0064"))
(define-protein "SNX1_HUMAN" ("SNX1"))
(define-protein "SNX27_HUMAN" ("KIAA0488" "SNX27"))
(define-protein "SNX2_HUMAN" ("SNX2" "TRG-9"))
(define-protein "SNX3_HUMAN" ("SNX3"))
(define-protein "SNX4_HUMAN" ("SNX4"))
(define-protein "SNX5_HUMAN" ("SNX5"))
(define-protein "SNX6_HUMAN" ("SNX6"))
(define-protein "SNX7_HUMAN" ("SNX7"))
(define-protein "SNX8_HUMAN" ("SNX8"))
(define-protein "SNX9_HUMAN" ("SNX9" "SH3PX1" "SH3PXD3A"))
(define-protein "SO1B3_HUMAN" ("SLCO1B3" "OATP-8" "SLC21A8" "LST2" "OATP1B3" "OATP8" "LST-2"))
(define-protein "SOCS1_HUMAN" ("TIP3" "SSI1" "TIP-3" "SOCS1" "SSI-1" "JAB" "SOCS-1"))
(define-protein "SOCS3_HUMAN" ("SSI-3" "CIS3" "SOCS-3" "CIS-3" "SOCS3" "SSI3"))
(define-protein "SORCN_HUMAN" ("V19" "SRI" "CP-22" "CP22"))
(define-protein "SOS" NIL)
(define-protein "SOS1_HUMAN" ("SOS-1" "SOS1"))
(define-protein "SOS2_HUMAN" ("SOS-2" "SOS2"))
(define-protein "SP16H_HUMAN" ("FACTp140" "FACTP140" "FACT140" "hSPT16" "SUPT16H"))
(define-protein "SPAS2_HUMAN" ("SCR59" "p59scr" "SPATS2" "SPATA10"))
(define-protein "SPC24_HUMAN" ("SPBC24" "hSpc24" "SPC24"))
(define-protein "SPC25_HUMAN" ("SPBC25" "hSpc25" "SPC25"))
(define-protein "SPE39_HUMAN" ("VIPAR" "hSPE-39" "C14orf133" "SPE39" "VIPAS39"))
(define-protein "SPHK1_HUMAN" ( "SPHK1" "SPHK" "SPK"))
(define-protein "SPHK2_HUMAN" ( "SPHK2"))
(define-protein "SPK" NIL)
(define-protein "SPRE1_HUMAN" ("SPRED1" "hSpred1" "Spred-1"))
(define-protein "SPRE2_HUMAN" ("SPRED2" "Spred-2"))
(define-protein "SPRR4_HUMAN" ("SPRR4"))
(define-protein "SPTA1_HUMAN" ("SPTA1" "SPTA"))
(define-protein "SPTB1_HUMAN" ("SPTB1" "SPTB"))
(define-protein "SPTB2_HUMAN" ("SPTB2" "SPTBN1"))
(define-protein "SPTN1_HUMAN" ("SPTA2" "NEAS" "SPTAN1"))
(define-protein "SPTN2_HUMAN" ("SPTBN2" "KIAA0302" "SCA5"))
(define-protein "SPTN4_HUMAN" ("SPTBN4" "SPTBN3" "KIAA1642"))
(define-protein "SPTN5_HUMAN" ("HUBSPECV" "SPTBN5" "HUSPECV" "BSPECV"))
(define-protein "SPXN4_HUMAN" ("SPANX-N4" "SPANXN4"))
(define-protein "SPY2_HUMAN" ("Spry-2" "SPRY2"))
(define-protein "SQRD_HUMAN" ("SQRDL" "SQOR"))
(define-protein "SRC8_HUMAN" ("CTTN" "EMS1" "Amplaxin"))
(define-protein "SRC_HUMAN" ( "p60-Src" "SRC" "SRC1" "pp60c-src"))
(define-protein "SRP09_HUMAN" ("SRP9"))
(define-protein "SRP14_HUMAN" ("SRP14"))
(define-protein "SRP19_HUMAN" ("SRP19"))
(define-protein "SRP54_HUMAN" ("SRP54"))
(define-protein "SRP72_HUMAN" ("SRP72"))
(define-protein "SRPK1_HUMAN" ("SRPK1"))
(define-protein "SRSF5_HUMAN" ("SFRS5" "SRSF5" "HRS" "SRP40"))
(define-protein "SRSF9_HUMAN" ("SRSF9" "SFRS9" "SRP30C"))
(define-protein "SRTD1_HUMAN" ("SERTAD1" "TRIP-Br1" "SEI1" "SEI-1"))
(define-protein "SSRP1_HUMAN" ("FACTp80" "FACT80" "SSRP1" "hSSRP1" "T160"))
(define-protein "STA5A_HUMAN" ("STAT5" "STAT5A"))
(define-protein "STA5B_HUMAN" ("STAT5B"))
(define-protein "STAG1_HUMAN" ("STAG1" "SA1"))
(define-protein "STALP_HUMAN" ("AMSHLP" "KIAA1373" "STAMBPL1" "AMSH-LP"))
(define-protein "STAM1_HUMAN" ("STAM1" "STAM-1" "STAM"))
(define-protein "STAR5_HUMAN" ("STARD5" "StARD5"))
(define-protein "STAR7_HUMAN" ("StARD7" "GTT1" "STARD7"))
(define-protein "STAT" NIL)
(define-protein "STAT1_HUMAN" ("STAT1"))
(define-protein "STAT2_HUMAN" ("p113" "STAT2"))
(define-protein "STAT3_HUMAN" ("STAT3" "APRF"))
(define-protein "STAT4_HUMAN" ("STAT4"))
(define-protein "STAT6_HUMAN" ("STAT6"))
(define-protein "STK26_HUMAN" ("STK26" "MST4" "MASK" "MST-4"))
(define-protein "STK38_HUMAN" ("NDR1" "STK38"))
(define-protein "STK39_HUMAN" ("DCHT" "SPAK" "STK39"))
(define-protein "STML2_HUMAN" ("SLP-2" "STOML2" "Paratarg-7" "SLP2"))
(define-protein "STRUM_HUMAN" ("KIAA0196" "Strumpellin"))
(define-protein "STX12_HUMAN" ("STX12"))
(define-protein "STX16_HUMAN" ("STX16" "Syn16"))
(define-protein "STX17_HUMAN" ("STX17"))
(define-protein "STX18_HUMAN" ("STX18"))
(define-protein "STX3_HUMAN" ("STX3A" "STX3"))
(define-protein "STX4_HUMAN" ("STX4A" "STX4"))
(define-protein "STX5_HUMAN" ("STX5" "STX5A"))
(define-protein "STX7_HUMAN" ("STX7"))
(define-protein "STXB2_HUMAN" ("UNC18B" "Unc18-2" "Unc-18B" "STXBP2"))
(define-protein "STXB3_HUMAN" ("PSP" "Unc18-3" "Unc-18C" "STXBP3"))
(define-protein "SUH_HUMAN" ("RBP-JK" "IGKJRB" "CBF-1" "RBPJK" "RBPJ" "RBP-J" "RBPSUH" "IGKJRB1"))
(define-protein "SWP70_HUMAN" ("SWAP70" "KIAA0640" "SWAP-70"))
(define-protein "SYGP1_HUMAN" ("SYNGAP1" "KIAA1938"))
(define-protein "SYJ2B_HUMAN" ("SYNJ2BP" "OMP25"))
(define-protein "SYNE2_HUMAN" ("Syne-2" "SYNE2" "NUA" "KIAA1011"))
(define-protein "Shc" NIL)
(define-protein "TAGL2_HUMAN" ("TAGLN2" "KIAA0120"))
(define-protein "TAOK1_HUMAN" ("hKFC-B" "MAP3K16" "hTAOK1" "PSK2" "MARKK" "TAOK1" "PSK-2" "KIAA1361"))
(define-protein "TAOK3_HUMAN" ("TAOK3" "DPK" "JIK" "MAP3K18" "hKFC-A" "KDS"))
(define-protein "TAP1_HUMAN" ("Y3" "ABCB2" "APT1" "PSF1" "TAP1" "RING4" "PSF-1"))
(define-protein "TAP2_HUMAN" ("Y1" "ABCB3" "APT2" "RING11" "PSF2" "TAP2" "PSF-2"))
(define-protein "TB10B_HUMAN" ("TBC1D10B" "Rab27A-GAP-beta"))
(define-protein "TB22B_HUMAN" ("C6orf197" "TBC1D22B"))
(define-protein "TBC15_HUMAN" ("TBC1D15" "Rab7-GAP"))
(define-protein "TBC17_HUMAN" ("TBC1D17"))
(define-protein "TBC9B_HUMAN" ("TBC1D9B" "KIAA0676"))
(define-protein "TBCD1_HUMAN" ("TBC1D1" "KIAA1108"))
(define-protein "TBCD4_HUMAN" ("TBC1D4" "AS160" "KIAA0603"))
(define-protein "TCPH_HUMAN" ("CCT-eta" "CCT7" "CCTH" "TCP-1-eta" "NIP7-1"))
(define-protein "TEC_HUMAN" ( "TEC" "PSCTK4"))
(define-protein "TELO2_HUMAN" ("TELO2" "hCLK2" "KIAA0683"))
(define-protein "TERF1_HUMAN" ("TERF1" "TRF" "TRBF1" "PIN2" "TRF1"))
(define-protein "TFIP8_HUMAN" ("MDC-3.13" "NDED" "SCC-S2" "TNFAIP8"))
(define-protein "TFR1_HUMAN" ("CD71" "p90" "T9" "TfR" "sTfR" "TFRC" "TfR1" "TR" "Trfr"))
(define-protein "TGFA1_HUMAN" ("TRAP-1" "TRAP1" "TGFBRAP1"))
(define-protein "TGFB3_HUMAN" ("TGFB3" "TGF-beta-3" "LAP"))
(define-protein "TGFR1_HUMAN" ("TGFR-1" "ALK-5" "ALK5" "SKR4" "TGFBR1" "TbetaR-I"))
(define-protein "TGFR2_HUMAN" ("TGFBR2" "TGFR-2" "TbetaR-II"))
(define-protein "TGFbeta" NIL)
(define-protein "TGFbetareceptor I" NIL)
(define-protein "TGFbetareceptor II" NIL)
(define-protein "TIAM1_HUMAN" ("TIAM-1" "TIAM1"))
(define-protein "TIE2_HUMAN" ("TIE2" "TEK" "hTIE2" "VMCM" "VMCM1" "CD202b"))
(define-protein "TIF1A_HUMAN" ("RNF82" "TIF1-alpha" "TRIM24" "TIF1" "TIF1A"))
(define-protein "TIF1B_HUMAN" ("KRIP-1" "RNF96" "TRIM28" "KAP1" "KAP-1" "TIF1B" "TIF1-beta"))
(define-protein "TLL1_HUMAN" ("TLL1" "TLL"))
(define-protein "TLL2_HUMAN" ("KIAA0932" "TLL2"))
(define-protein "TLN1_HUMAN" ("KIAA1027" "TLN1" "TLN"))
(define-protein "TLN2_HUMAN" ("TLN2" "KIAA0320"))
(define-protein "TLR2_HUMAN" ("TIL4" "CD282" "TLR2"))
(define-protein "TLR9_HUMAN" ("CD289" "TLR9"))
(define-protein "TM109_HUMAN" ("Mitsugumin-23" "TMEM109" "Mg23"))
(define-protein "TM252_HUMAN" ("TMEM252" "C9orf71"))
(define-protein "TM9S1_HUMAN" ("TM9SF1" "hMP70"))
(define-protein "TMA7_HUMAN" ("CCDC72" "TMA7"))
(define-protein "TMED1_HUMAN" ("p24gamma1" "IL1RL1L" "IL1RL1LG" "Tp24" "TMED1"))
(define-protein "TMEDA_HUMAN" ("p24delta" "Tmp-21-I" "S31III125" "TMP21" "p24delta1" "S31I125" "TMED10" "p23"))
(define-protein "TMM33_HUMAN" ("DB83" "TMEM33"))
(define-protein "TMOD2_HUMAN" ("NTMOD" "N-Tmod" "TMOD2"))
(define-protein "TMOD3_HUMAN" ("U-Tmod" "TMOD3"))
(define-protein "TNFA_HUMAN" ("ICD2" "ICD1" "TNFA" "Cachectin" "NTF" "TNFSF2" "TNF-a" "TNF" "TNF-alpha"))
(define-protein "TNK1_HUMAN" ( "TNK1"))
(define-protein "TOM1_HUMAN" ("TOM1"))
(define-protein "TOM34_HUMAN" ("URCC3" "hTom34" "TOMM34"))
(define-protein "TOM70_HUMAN" ("KIAA0719" "TOMM70A" "TOM70"))
(define-protein "TPD52_HUMAN" ("TPD52"))
(define-protein "TPD54_HUMAN" ("TPD52L2" "hD54"))
(define-protein "TPM3_HUMAN" ("hTM5" "TPM3" "Tropomyosin-5" "Tropomyosin-3" "Gamma-tropomyosin"))
(define-protein "TPPC3_HUMAN" ("BET3" "TRAPPC3"))
(define-protein "TPPC4_HUMAN" ("Synbindin" "SBDN" "TRAPPC4"))
(define-protein "TPPC5_HUMAN" ("TRAPPC5"))
(define-protein "TPR_HUMAN" ("Megator" "TPR"))
(define-protein "TPX2_HUMAN" ("p100" "DIL-2" "DIL2" "TPX2" "C20orf2" "C20orf1" "HCA519"))
(define-protein "TRAF6_HUMAN" ( "TRAF6" "RNF85"))
(define-protein "TRI44_HUMAN" ("TRIM44" "DIPB"))
(define-protein "TRPV1_HUMAN" ("VR1" "TrpV1" "OTRPC1" "TRPV1"))
(define-protein "TRRAP_HUMAN" ("TRRAP" "PAF400" "STAF40" "PAF350/400"))
(define-protein "TS101_HUMAN" ("TSG101"))
(define-protein "TSC1_HUMAN" ("KIAA0243" "TSC" "TSC1"))
(define-protein "TSN8_HUMAN" ("TM4SF3" "Tspan-8" "TSPAN8"))
(define-protein "TT39B_HUMAN" ("TTC39B" "C9orf52"))
(define-protein "TTC19_HUMAN" ("TTC19"))
(define-protein "TTC1_HUMAN" ("TPR1" "TTC1"))
(define-protein "TTI1_HUMAN" ("SMG10" "TTI1" "KIAA0406"))
(define-protein "TTLL7_HUMAN" ( "TTLL7"))
(define-protein "TXLNA_HUMAN" ("TXLNA" "TXLN"))
(define-protein "TXLNG_HUMAN" ("TXLNG" "FIAT" "LSR5" "CXorf15" "ELRG"))
(define-protein "TXTP_HUMAN" ("SLC20A3" "CTP" "SLC25A1"))
(define-protein "Typical PKCs" NIL)
(define-protein "UBC_HUMAN" ("Ubiquitin" "UBC"))
(define-protein "UBD_HUMAN" ("FAT10" "Diubiquitin" "UBD"))
(define-protein "UBE2N_HUMAN" ("UbcH13" "Ubc13" "UBE2N" "BLU"))
(define-protein "UBE2S_HUMAN" ("E2-EPF" "E2EPF" "UBE2S"))
(define-protein "UBP8_HUMAN" ("hUBPy" "KIAA0055" "UBPY" "USP8"))
(define-protein "UBQL2_HUMAN" ("Chap1" "hPLIC-2" "UBQLN2" "PLIC-2" "PLIC2" "N4BP4"))
(define-protein "UCHL3_HUMAN" ("UCHL3" "UCH-L3"))
(define-protein "UCK2_HUMAN" ("UMPK" "UCK2"))
(define-protein "UD110_HUMAN" ("UGT1-10" "UGT1A10" "UGT1" "GNT1" "UGT1J" "UGT-1J" "UGT1.10" "UGT1*10"))
(define-protein "UD11_HUMAN" ("UGT-1A" "GNT1" "UGT1.1" "UGT1" "UGT1*1" "UGT1A" "UGT1A1" "UGT1-01" "hUG-BR1"))
(define-protein "UD13_HUMAN" ("UGT-1C" "GNT1" "UGT1.3" "UGT1" "UGT1C" "UGT1A3" "UGT1-03" "UGT1*3"))
(define-protein "UD16_HUMAN" ("UGT-1F" "UGT1.6" "GNT1" "UGT1" "UGT1F" "UGT1A6" "UGT1-06" "UGT1*6"))
(define-protein "UD17_HUMAN" ("UGT-1G" "UGT1.7" "GNT1" "UGT1" "UGT1G" "UGT1A7" "UGT1-07" "UGT1*7"))
(define-protein "UD18_HUMAN" ("UGT-1H" "UGT1.8" "GNT1" "UGT1" "UGT1H" "UGT1A8" "UGT1-08" "UGT1*8"))
(define-protein "UD19_HUMAN" ("lugP4" "UGT1.9" "GNT1" "UGT1" "UGT1I" "UGT1A9" "UGT1-09" "UGT-1I" "UGT1*9"))
(define-protein "UDB11_HUMAN" ("UGT2B11"))
(define-protein "UHRF1_HUMAN" ("hNp95" "hUHRF1" "NP95" "UHRF1" "HuNp95" "ICBP90" "RNF106"))
(define-protein "ULK3_HUMAN" ("ULK3"))
(define-protein "UN93B_HUMAN" ("UNC93B1" "hUNC93B1" "UNC93B" "UNC93" "Unc-93B1"))
(define-protein "URGCP_HUMAN" ("URG4" "URGCP" "KIAA1507"))
(define-protein "USE1_HUMAN" ("p31" "USE1L" "USE1"))
(define-protein "USH1C_HUMAN" ("USH1C" "AIE75"))
(define-protein "USO1_HUMAN" ("TAP" "USO1" "VDP"))
(define-protein "USP9X_HUMAN" ("DFFRX" "FAM" "USP9" "USP9X" "hFAM"))
(define-protein "VA0D1_HUMAN" ("ATP6D" "p39" "ATP6V0D1" "VPATPD"))
(define-protein "VAC14_HUMAN" ("TAX1BP2" "VAC14" "TRX"))
(define-protein "VAMP3_HUMAN" ("VAMP-3" "VAMP3" "Synaptobrevin-3" "SYB3" "CEB" "Cellubrevin"))
(define-protein "VAMP7_HUMAN" ("VAMP7" "SYBL1" "Ti-VAMP" "VAMP-7"))
(define-protein "VAMP8_HUMAN" ("VAMP8" "Endobrevin" "EDB" "VAMP-8"))
(define-protein "VAPA_HUMAN" ("VAPA" "VAP-A" "VAP-33" "VAMP-A" "VAP33"))
(define-protein "VAPB_HUMAN" ("VAMP-B/VAMP-C" "VAP-B/VAP-C" "VAPB"))
(define-protein "VASP_HUMAN" ("VASP"))
(define-protein "VAT1_HUMAN" ("VAT1"))
(define-protein "VATA_HUMAN" ("ATP6V1A1" "ATP6A1" "ATP6V1A" "VPP2"))
(define-protein "VATB2_HUMAN" ("ATP6B2" "ATP6V1B2" "HO57" "VPP3"))
(define-protein "VATC1_HUMAN" ("ATP6D" "ATP6C" "ATP6V1C1" "VATC"))
(define-protein "VATC2_HUMAN" ("ATP6V1C2"))
(define-protein "VATD_HUMAN" ("VATD" "ATP6M" "ATP6V1D"))
(define-protein "VATE1_HUMAN" ("ATP6E2" "p31" "ATP6E" "ATP6V1E1"))
(define-protein "VATG1_HUMAN" ("ATP6V1G1" "ATP6G1" "ATP6J" "ATP6G"))
(define-protein "VATH_HUMAN" ("NBP1" "ATP6V1H"))
(define-protein "VATL_HUMAN" ("ATP6C" "ATP6V0C" "ATP6L" "ATPL"))
(define-protein "VAV2_HUMAN" ("VAV-2" "VAV2"))
(define-protein "VAV_HUMAN" ("VAV" "VAV1"))
(define-protein "VCY1_HUMAN" ("BPY1" "VCY" "VCY1B" "VCY1A" "BPY1B"))
(define-protein "VISL1_HUMAN" ("VILIP" "VSNL1" "VLP-1" "HLP3" "VISL1"))
(define-protein "VP26A_HUMAN" ("VPS26A" "VPS26" "hVPS26"))
(define-protein "VP33A_HUMAN" ("VPS33A" "hVPS33A"))
(define-protein "VP33B_HUMAN" ("VPS33B" "hVPS33B"))
(define-protein "VP37B_HUMAN" ("hVps37B" "VPS37B"))
(define-protein "VPS11_HUMAN" ("hVPS11" "VPS11" "RNF108"))
(define-protein "VPS16_HUMAN" ("hVPS16" "VPS16"))
(define-protein "VPS18_HUMAN" ("hVPS18" "VPS18" "KIAA1475"))
(define-protein "VPS25_HUMAN" ("hVps25" "DERP9" "EAP20" "VPS25"))
(define-protein "VPS28_HUMAN" ("H-Vps28" "VPS28"))
(define-protein "VPS29_HUMAN" ("hVPS29" "VPS29"))
(define-protein "VPS35_HUMAN" ("hVPS35" "VPS35" "MEM3"))
(define-protein "VPS36_HUMAN" ("VPS36" "EAP45" "C13orf9"))
(define-protein "VPS39_HUMAN" ("TLP" "KIAA0770" "VAM6" "hVam6p" "VPS39"))
(define-protein "VPS45_HUMAN" ("VPS45" "h-VPS45" "hlVps45" "VPS45B" "VPS45A"))
(define-protein "VPS4A_HUMAN" ("VPS4" "VPS4-1" "hVPS4" "VPS4A"))
(define-protein "VPS51_HUMAN" ("ANG2" "C11orf3" "C11orf2" "FFR" "VPS51"))
(define-protein "VRK1_HUMAN" ("VRK1"))
(define-protein "VTA1_HUMAN" ("VTA1" "LIP5" "DRG-1" "SBP1" "C6orf55"))
(define-protein "VTI1A_HUMAN" ("Vti1-rp2" "VTI1A"))
(define-protein "WASF2_HUMAN" ("WASF2" "WAVE2"))
(define-protein "WASH2_HUMAN" ("WASH2P" "FAM39B"))
(define-protein "WASH7_HUMAN" ("SWIP" "KIAA1033"))
(define-protein "WASL_HUMAN" ("N-WASP" "WASL"))
(define-protein "WDFY1_HUMAN" ("FENS-1" "ZFYVE17" "WDF1" "KIAA1435" "WDFY1"))
(define-protein "WDFY3_HUMAN" ("KIAA0993" "Alfy" "WDFY3"))
(define-protein "WDR5_HUMAN" ("WDR5" "BIG3"))
(define-protein "WLS_HUMAN" ("GPR177" "C1orf139" "WLS" "EVI"))
(define-protein "XPO1_HUMAN" ("CRM1" "XPO1" "Exp1"))
(define-protein "XPO2_HUMAN" ("CSE1L" "CAS" "XPO2" "Exp2"))
(define-protein "XPO4_HUMAN" ("XPO4" "Exp4" "KIAA1721"))
(define-protein "XPO7_HUMAN" ("KIAA0745" "RANBP16" "XPO7" "Exp7"))
(define-protein "YES_HUMAN" ( "p61-Yes" "YES" "YES1"))
(define-protein "YIF1A_HUMAN" ("YIF1" "54TMp" "YIF1A" "HYIF1P" "54TM"))
(define-protein "YKT6_HUMAN" ("YKT6"))
(define-protein "ZBT12_HUMAN" ("NG35" "ZBTB12" "C6orf46" "G10"))
(define-protein "ZC3HF_HUMAN" ("DFRP1" "ZC3H15" "LEREPO4"))
(define-protein "ZDH17_HUMAN" ("HIP3" "DHHC-17" "HIP14" "KIAA0946" "ZDHHC17" "HIP-14" "HYPH" "HIP-3"))
(define-protein "ZFPL1_HUMAN" ("ZFPL1"))
(define-protein "ZFYV1_HUMAN" ("KIAA1589" "SR3" "DFCP1" "TAFF1" "ZFYVE1" "ZNFN2A1"))
(define-protein "ZHX2_HUMAN" ("RAF" "KIAA0854" "AFR1" "ZHX2"))
(define-protein "ZN239_HUMAN" ("HOK2" "MOK2" "ZNF239"))
(define-protein "ZNT9_HUMAN" ("C4orf1" "HuEL" "HUEL" "SLC30A9" "ZnT-9"))
(define-protein "ZO1_HUMAN" ("TJP1" "ZO1"))
(define-protein "ZO2_HUMAN" ("X104" "TJP2" "ZO2"))
(define-protein "ZW10_HUMAN" ("ZW10"))
(define-protein "ZWILC_HUMAN" ("ZWILCH" "hZwilch"))
(define-protein "ZWINT_HUMAN" ("ZWINT" "Zwint-1"))
(define-protein "a2abe5_human" ("HLA-C"))
(define-protein "b4dip2_human" ("ERBB2IP"))
(define-protein "b4dyu4_human" NIL)
(define-protein "b4e074_human" NIL)
(define-protein "byr2_schpo" ("SPBC2F12.01" "ste8" "SPBC1D7.05" "byr2"))
(define-protein "fnta_rat" ("Fnta" "FTase-alpha"))
(define-protein "fntb_rat" ("Fntb"))
(define-protein "gnds_mouse" ("Rgds" "Ralgds"))
(define-protein "gnds_rat" ("Ralgds"))
(define-protein "mSnx27" NIL)
(define-protein "mSnx31" NIL)
(define-protein "p110" NIL)
(define-protein "p14/19 ARF" NIL)
(define-protein "p27958-pro_0000037575" NIL)
(define-protein "p42/p44MAPKs" NIL)
(define-protein "praf1_mouse" ("Pra1" "Pra" "Prenylin" "Rabac1" "Praf1"))
(define-protein "q1zyl5_human" NIL)
(define-protein "q46342_closo" NIL)
(define-protein "q5ebh1-2" ("Rapl" "Nore1" "Rassf5"))
(define-protein "q95iz1_human" ("HLA-A"))
(define-protein "rasf5_mouse" ("Rapl" "Nore1" "Rassf5"))
(define-protein "rpgf4_mouse" ("Epac2" "Cgef2" "Rapgef4"))
;;(define-protein "14-3-3 family" NIL)
;;(define-protein "CaMKII family" NIL)
;;(define-protein "Gi family" NIL)
;;(define-protein "KRAS family" NIL)
;;(define-protein "PAK family" NIL)
;;(define-protein "Protein Kinase Byr2" NIL)
;;(define-protein "RAS family" NIL)
;;(define-protein "Serine/threonine-protein kinase B-raf" NIL)
;;(define-protein "Syndecan Family" NIL)


(def-family  "cyclooxygenase" :members ("PGH2_HUMAN"))
(def-family "Rho" :members ("RHOA_HUMAN" "RHOB_HUMAN" "RHOD_HUMAN" "RHOF_HUMAN" "RHOG_HUMAN"))

(defparameter *bio-ents* nil)
(defparameter *mitre-bio-ents* nil)

(defun new-bio-entities ()
  (let ((bes 
         (loop for a in *all-sentences* 
           append 
           (loop for i in (second a) when (member category::bio-entity (indiv-type i)) collect i)))
        (bbs nil))
    (setf *bio-ents* bes)
    
    (loop for b in bes do (pushnew (mitre-string b) bbs :test #'equal))
    (length (setq *mitre-bio-ents* (sort bbs #'string<)))))

