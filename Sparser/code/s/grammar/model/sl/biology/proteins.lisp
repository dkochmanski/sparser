;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER COMMON-LISP) -*-
;;; Copyright (c) 2014-2015 SIFT LLC. All Rights Reserved
;;;
;;;    File: "proteins"
;;;  Module: "grammar/model/sl/biology/
;;; version: June 2015

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
;; 6/28/15 un-ignored p53
;; 7/6/2015 Support for macro def-ras2-protein to mark proteins that are mentioned in the MITRE RAS 2-hop model


(in-package :sparser)

;;;--------------------------------------------
;;; for (some of) the abstract in the proposal
;;;--------------------------------------------

;; found in the article set



(def-bio "BCR-ABL" protein)
(define-protein "PARP1_HUMAN" ("poly(ADP–ribose) 1"))
(define-protein "PARP2_HUMAN" ("poly(ADP–ribose) 2"))
(define-protein "PARP3_HUMAN" ("poly(ADP–ribose) 3"))
(define-protein "ARBK1_HUMAN" ("Beta-ARK-1" "βARK1"))
;;(define-protein "SRC_HUMAN" ("Src"))
(define-protein "SNIP1_HUMAN" ("SNIP1"))


(DEFINE-PROTEIN "NFAT5_HUMAN" ("NFAT5" "Nuclear factor of activated T-cells 5"))

(define-protein "PKNA_MYCTU" ("pknA")) ;; bacterial protein -- have to look at why it shows up in the articles
(define-protein "GSTP1_HUMAN" ("Glutathione S-transferase P"))


;; from June test
(define-protein "TGS1_HUMAN" ("PIMT" "TGS1" "HCA137" "NCOA6IP" "NCoA6IP"))
(noun  "actin" :super protein)



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

;;(def-bio "p53" protein :mitre-link "Uniprot:P04637")

(def-bio "p38 SAPK" protein)


;;(define-protein "EGFR" ("ERBB1"))
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

;;(def-bio "GSK-3" protein)




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



;;(def-bio "GAP" protein :synonyms ("GTPase activating proteins"))
;; "pproteins" to avoid a literal on "proteins"

;; compositional version of the long forms would be better
;;/// are these small molecules like GDP or are the larger? -- protein
;; And these are families of particulars, not the particulars that are
;;  actually doing participating in the reactions

(def-bio "RasGRF1" protein :synonyms ( "RASGRF1") :mitre-link "Uniprot:Q13972")

(def-bio "RapGEF2" protein :synonyms ( "RAPGEF2") :mitre-link "Uniprot:Q17RH5")

(def-bio "RapGEF3" protein :synonyms ("RAPGEF3") :mitre-link "Uniprot:O95398")

(def-bio "RapGEF4" protein
  :synonyms ("RAPGEF4")
  :mitre-link "Uniprot:Q8WZA2")

(def-bio "RAPGEF5" protein
  :synonyms ("RAPGEF5")
  :mitre-link "Uniprot:Q92565")

(def-bio "RapGEF6" protein
  :synonyms ( "RAPGEF6")
  :mitre-link "Uniprot:Q8TEU7")

;;(def-bio "RasGAP" protein :synonyms ("Ras-GAP" "Ras GAP"));; ditto, or beef up morphology



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
#+ignore
(def-bio "KRas" protein 
  :synonyms ("K-Ras" "K-RAS")
  :identifier "PR:0000009442" ;; gene is "PR:P01116" 
  :mitre-link "Uniprot:P01116")

#+ignore
(def-bio "HRas" protein      ;; Harvey Ras
  :synonyms ("H-Ras" "H-RAS" "HRAS")
  :identifier "PR:000029705" ;; gene is "PR:P01112")
  :mitre-link "Uniprot:P01112:")
#+ignore
(def-bio "NRas" protein
  :synonyms ("N-Ras" "N-RAS" "NRAS")
  :identifier "PR:000011416" ;; gene is "PR:P01111"
  :mitre-link "Uniprot:P01111")


 ;; RAS small monomeric GTPase activity


(def-bio "Raf CAAX" protein)

;;(def-bio "RasA1" protein :synonyms ("RASA1") :mitre-link "Uniprot:P20936")
;;(def-bio "RasA2" protein  :synonyms ("RASA2")  :mitre-link "Uniprot:Q15283")
;;(def-bio "RASA4" protein :mitre-link "Uniprot:O43374")	
;;(def-bio "RASAL1" protein  :mitre-link "Uniprot:O95294")
;;(def-bio "RASAL2" protein  :mitre-link "Uniprot:Q9UJF2")



(def-bio "RASA3" protein
  :synonyms ("RASA3")
  :mitre-link "Uniprot:Q14644")

;; and many more: ERK3 (MAPK6) and ERK4 (MAPK4), etc.
;; I don't understand the Wikipedia write up well enough



(def-bio "ERK1-4" protein) ;; mutated form of ERK




;;--- These are in Matt's list, but I don't
;;  know anything about them

#+ignore
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
;;(def-bio "ASPP1" protein)




(def-bio "ATG5" protein
  :mitre-link "Uniprot:Q9H1Y0")	

(def-bio "GFP" protein
  :mitre-link "Uniprot:P42212")	

(def-bio "green fluorescent protein" protein
  :mitre-link "Uniprot:P42212")	

;;(def-bio "RapGEF1" protein :synonyms ("RAPGEF1") :mitre-link "Uniprot:Q91ZZ2")

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
	

;;(def-bio "RGL1" protein :mitre-link "Uniprot:Q9NZL6")
	

;;(def-bio "RasGRP1" protein :synonyms ("RASGRP1") :mitre-link "Uniprot:O95267")
;;(def-bio "RasGRP2" protein :synonyms ("RASGRP2") :mitre-link "Uniprot:Q7LDG7")
;;(def-bio "RasGRP3" protein :synonyms ("RASGRP3") :mitre-link "Uniprot:Q8IV61")
;;(def-bio "RasGRP4" protein :synonyms ("RASGRP4") :mitre-link "Uniprot:Q8TDF6")
;;(def-bio "RasGRF2" protein :synonyms ("RASGRF2") :mitre-link "Uniprot:O14827")
;;(def-bio "SOS1" protein :mitre-link "Uniprot:Q07889")
	

;;(def-bio "RGL2" protein :mitre-link "Uniprot:O15211")

(def-bio "RGL3" protein
  :mitre-link "Uniprot:Q3MIN7")

(def-bio "RGL4" protein
  :mitre-link "Uniprot:Q8IZJ4")
	
	
	

;;(def-bio "NF1" protein :mitre-link "Uniprot:P21359")
	

#+ignore
(def-bio "IQGAP1" protein
  :mitre-link "Uniprot:P46940")

(def-bio "IQGAP2" protein
  :mitre-link "Uniprot:Q13576")

(def-bio "IQGAP3" protein
  :mitre-link "Uniprot:Q86VI3")
	
	
	

(def-bio "GAPVD1" protein
  :mitre-link "Uniprot:Q14C86")

;;(def-bio "DAB2IP" protein :mitre-link "Uniprot:Q7VWQ8")
;;(def-bio "SOS2" protein :mitre-link "Uniprot:Q07890")
;;(def-bio "SYNGAP1" protein :mitre-link "Uniprot:Q96PV0")
	



;;-------------- well known mutated protein


(def-bio "V600EBRAF" protein ;; need to figure out how to represent this variant in the ontology
  :synonyms ("B-RAFV600E" "V600EB-RAF" "BRAFV600E"))

(def-bio "RasG12V" protein ;; this is a variant
 )

;;------------- From here on down it's miscelany that
;;  I don't know how to codify

(def-bio "MAP" protein)

#+ignore
(def-bio "COT/TPL2" protein) ;; see if defining this leads to sentence 53 working consistently when run twice.

(DEFINE-PROTEIN "COT/TPL2" ("M3K8_HUMAN" "Mitogen-activated protein kinase kinase kinase 8"))

(def-bio "cot" protein
  :synonyms ("COT" "MAP3K8"))
(def-bio "trypsin" protein)



(def-bio "mek1dd" protein)
(def-bio "brafv" protein)





;;(def-bio "PIK3CA" protein :identifier "PR:000012719")






(noun "hormone" :super protein)
(noun "histone" :super protein)
(noun "histone 2B" :super protein)


(def-bio "SAPK" protein) ;; class of stress activated proteins
;;(def-bio "ASPP2" protein),nameprotein 
(def-bio "GST-ASPP2" protein)
(def-bio "phospho-ASPP2" protein)
(define-protein "AZIN1_HUMAN" ("Az"))



(def-bio "Ras17N" protein)

<<<<<<< .mine
=======
<<<<<<< .mine
>>>>>>> .r4471

=======
>>>>>>> .r4470
(define-protein "14-3-3" NIL) 
<<<<<<< .mine
(define-protein "1433B_HUMAN" ("´-" "14-3-3 protein beta/alpha" "Protein 1054" "Protein kinase C inhibitor protein 1" "KCIP-1"))
(define-protein "1433G_HUMAN" ("B/cdk1" "14-3-3 protein gamma" "Protein kinase C inhibitor protein 1" "KCIP-1"))
(define-protein "1B27_HUMAN" ("subtypes" "HLA class I histocompatibility antigen, B-27 alpha chain" "MHC class I antigen B*27"))
(define-protein "1B51_HUMAN" ("etc" "HLA class I histocompatibility antigen, B-51 alpha chain" "MHC class I antigen B*51"))
=======
<<<<<<< .mine
(define-protein "1433B_HUMAN" ("14-3-3 protein beta/alpha" "Protein 1054" "Protein kinase C inhibitor protein 1" "KCIP-1"))
(define-protein "1433G_HUMAN" ("B/cdk1" "14-3-3 protein gamma" "Protein kinase C inhibitor protein 1" "KCIP-1"))
(define-protein "1B27_HUMAN" ("subtypes" "HLA class I histocompatibility antigen, B-27 alpha chain" "MHC class I antigen B*27"))
(define-protein "1B51_HUMAN" ("etc" "HLA class I histocompatibility antigen, B-51 alpha chain" "MHC class I antigen B*51"))
=======
(define-protein "1433B_HUMAN" ("14-3-3 protein beta/alpha" "Protein 1054" "Protein kinase C inhibitor protein 1" "KCIP-1"))
(define-protein "1433G_HUMAN" ("14-3-3 protein gamma" "Protein kinase C inhibitor protein 1" "KCIP-1"))
(define-protein "1B27_HUMAN" ("HLA class I histocompatibility antigen, B-27 alpha chain" "MHC class I antigen B*27"))
(define-protein "1B51_HUMAN" ("HLA class I histocompatibility antigen, B-51 alpha chain" "MHC class I antigen B*51"))
>>>>>>> .r4470
>>>>>>> .r4471
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
(define-protein "2B1B_HUMAN" ("HLA class II histocompatibility antigen, DRB1-11 beta chain" "DR-5" "DR5" "DRw11" "MHC class II antigen DRB1*11"))
<<<<<<< .mine
(define-protein "3BHS2_HUMAN" ("3β-HSD" "3 beta-hydroxysteroid dehydrogenase/Delta 5-->4-isomerase type 2" "3 beta-hydroxysteroid dehydrogenase/Delta 5-->4-isomerase type II" "3-beta-HSD II" "3-beta-HSD adrenal and gonadal type"))
=======
<<<<<<< .mine
(define-protein "3BHS2_HUMAN" ("3β-HSD" "3 beta-hydroxysteroid dehydrogenase/Delta 5-->4-isomerase type 2" "3 beta-hydroxysteroid dehydrogenase/Delta 5-->4-isomerase type II" "3-beta-HSD II" "3-beta-HSD adrenal and gonadal type"))
=======
(define-protein "3BHS2_HUMAN" ("3 beta-hydroxysteroid dehydrogenase/Delta 5-->4-isomerase type 2" "3 beta-hydroxysteroid dehydrogenase/Delta 5-->4-isomerase type II" "3-beta-HSD II" "3-beta-HSD adrenal and gonadal type"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "3BP1_HUMAN" ("SH3BP1" "3BP-1")) 
<<<<<<< .mine
(define-protein "3BP2_HUMAN" ("phosphatidylinositols" "SH3 domain-binding protein 2" "3BP-2"))
(define-protein "3BP5_HUMAN" ("phospho-JNK" "SH3 domain-binding protein 5" "SH3BP-5" "SH3 domain-binding protein that preferentially associates with BTK"))
(define-protein "3MG_HUMAN" ("aag" "DNA-3-methyladenine glycosylase" "3-alkyladenine DNA glycosylase" "3-methyladenine DNA glycosidase" "ADPG" "N-methylpurine-DNA glycosylase"))
(define-protein "41_HUMAN" ("Band4.1" "EPB4.1" "4.1R" "P4.1" "band4.1" "band4.1 protein"))
=======
<<<<<<< .mine
(define-protein "3BP2_HUMAN" ("phosphatidylinositols" "SH3 domain-binding protein 2" "3BP-2"))
(define-protein "3BP5_HUMAN" ("phospho-JNK" "SH3 domain-binding protein 5" "SH3BP-5" "SH3 domain-binding protein that preferentially associates with BTK"))
(define-protein "3MG_HUMAN" ("aag" "DNA-3-methyladenine glycosylase" "3-alkyladenine DNA glycosylase" "3-methyladenine DNA glycosidase" "ADPG" "N-methylpurine-DNA glycosylase"))
(define-protein "41_HUMAN" ("Band4.1" "EPB4.1" "4.1R" "P4.1" "band4.1" "band4.1 protein"))
=======
(define-protein "3BP2_HUMAN" ("SH3 domain-binding protein 2" "3BP-2"))
(define-protein "3BP5_HUMAN" ("SH3 domain-binding protein 5" "SH3BP-5" "SH3 domain-binding protein that preferentially associates with BTK"))
(define-protein "3MG_HUMAN" ("DNA-3-methyladenine glycosylase" "3-alkyladenine DNA glycosylase" "3-methyladenine DNA glycosidase" "ADPG" "N-methylpurine-DNA glycosylase"))
(define-protein "41_HUMAN" ("Band4.1" "EPB4.1" "4.1R" "P4.1" "band4.1" "band4.1 protein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "4EBP1_HUMAN" ("4EBP1_HUMAN" "4EBP1")) 
<<<<<<< .mine
(define-protein "5HT3A_HUMAN" ("5-HT" "5-hydroxytryptamine receptor 3A" "5-HT3-A" "5-HT3A" "5-hydroxytryptamine receptor 3" "5-HT-3" "5-HT3R" "Serotonin receptor 3A" "Serotonin-gated ion channel receptor"))
=======
<<<<<<< .mine
(define-protein "5HT3A_HUMAN" ("5-HT" "5-hydroxytryptamine receptor 3A" "5-HT3-A" "5-HT3A" "5-hydroxytryptamine receptor 3" "5-HT-3" "5-HT3R" "Serotonin receptor 3A" "Serotonin-gated ion channel receptor"))
=======
(define-protein "5HT3A_HUMAN" ("5-hydroxytryptamine receptor 3A" "5-HT3-A" "5-HT3A" "5-hydroxytryptamine receptor 3" "5-HT-3" "5-HT3R" "Serotonin receptor 3A" "Serotonin-gated ion channel receptor"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "5NT3A_HUMAN" ("Cytosolic 5'-nucleotidase 3A" "Cytosolic 5'-nucleotidase 3" "Cytosolic 5'-nucleotidase III" "cN-III" "Pyrimidine 5'-nucleotidase 1" "P5'N-1" "P5N-1" "PN-I" "Uridine 5'-monophosphate hydrolase 1" "p36"))
<<<<<<< .mine
(define-protein "A0A024R4B6_HUMAN" ("ATG16" "ATG16 autophagy related 16-like 1 (S. cerevisiae), isoform CRA_f"))
(define-protein "A0A089GI72_9POLY" ("PITT1" "LT"))
(define-protein "A0A089N7W1_HPV16" ("IR4" "Major capsid protein L1"))
(define-protein "A0A0A7RBU2_9HIV1" ("gjs" "Polymerase"))
(define-protein "A0A0B5H903_9ADEN" ("301a" "Hexon"))
(define-protein "A0FKN4_HUMAN" ("mmtv" "Wingless-type MMTV integration site family member 5A variant 2"))
(define-protein "A25_VAR67" ("A2" "Protein A2.5"))
=======
<<<<<<< .mine
(define-protein "A0A024R4B6_HUMAN" ("ATG16" "ATG16 autophagy related 16-like 1 (S. cerevisiae), isoform CRA_f"))
(define-protein "A0A089GI72_9POLY" ("PITT1" "LT"))
(define-protein "A0A089N7W1_HPV16" ("IR4" "Major capsid protein L1"))
(define-protein "A0A0A7RBU2_9HIV1" ("gjs" "Polymerase"))
(define-protein "A0A0B5H903_9ADEN" ("301a" "Hexon"))
(define-protein "A0FKN4_HUMAN" ("mmtv" "Wingless-type MMTV integration site family member 5A variant 2"))
(define-protein "A25_VAR67" ("A2" "Protein A2.5"))
=======
(define-protein "A0A024R4B6_HUMAN" ("ATG16 autophagy related 16-like 1 (S. cerevisiae), isoform CRA_f"))
(define-protein "A0A089GI72_9POLY" ("LT"))
(define-protein "A0A089N7W1_HPV16" ("Major capsid protein L1"))
(define-protein "A0A0A7RBU2_9HIV1" ("Polymerase"))
(define-protein "A0A0B5H903_9ADEN" ("Hexon"))
(define-protein "A0FKN4_HUMAN" ("Wingless-type MMTV integration site family member 5A variant 2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "A25_VAR67" ("Protein A2.5"))
(define-protein "A2GL_HUMAN" ("Leucine-rich alpha-2-glycoprotein" "LRG"))
<<<<<<< .mine
(define-protein "A2GL_HUMAN" ("Lrg1" "Leucine-rich alpha-2-glycoprotein" "LRG"))
(define-protein "A2NVG1_HUMAN" ("mahlavu" "H.sapiens Mahlavu hepatocellular carcinoma hhc(M) DNA"))
(define-protein "A2Q6Z4_9HIV1" ("U0126" "Env protein"))
(define-protein "A4D275_HUMAN" ("Arpc1b" "Actin related protein 2/3 complex, subunit 1B, 41kDa" "Actin related protein 2/3 complex, subunit 1B, 41kDa, isoform CRA_a" "cDNA, FLJ95695, Homo sapiens actin related protein 2/3 complex, subunit 1B, 41kDa(ARPC1B), mRNA"))
(define-protein "A4ZJ37_9HIV1" ("D35" "Pol protein"))
(define-protein "A4_HUMAN" ("γ-secretase" "Amyloid beta A4 protein" "ABPP" "APPI" "APP" "Alzheimer disease amyloid protein" "Cerebral vascular amyloid peptide" "CVAP" "PreA4" "Protease nexin-II" "PN-II"))
(define-protein "A5PLL0_HUMAN" ("Cpt1b" "CPT1B protein"))
(define-protein "A8KA19_HUMAN" ("trnas" "cDNA FLJ75831, highly similar to Homo sapiens exportin, tRNA (nuclear export receptor for tRNAs) (XPOT), mRNA"))
=======
<<<<<<< .mine
(define-protein "A2GL_HUMAN" ("Lrg1" "Leucine-rich alpha-2-glycoprotein" "LRG"))
(define-protein "A2NVG1_HUMAN" ("mahlavu" "H.sapiens Mahlavu hepatocellular carcinoma hhc(M) DNA"))
(define-protein "A2Q6Z4_9HIV1" ("U0126" "Env protein"))
(define-protein "A4D275_HUMAN" ("Arpc1b" "Actin related protein 2/3 complex, subunit 1B, 41kDa" "Actin related protein 2/3 complex, subunit 1B, 41kDa, isoform CRA_a" "cDNA, FLJ95695, Homo sapiens actin related protein 2/3 complex, subunit 1B, 41kDa(ARPC1B), mRNA"))
(define-protein "A4ZJ37_9HIV1" ("D35" "Pol protein"))
(define-protein "A4_HUMAN" ("γ-secretase" "Amyloid beta A4 protein" "ABPP" "APPI" "APP" "Alzheimer disease amyloid protein" "Cerebral vascular amyloid peptide" "CVAP" "PreA4" "Protease nexin-II" "PN-II"))
(define-protein "A5PLL0_HUMAN" ("Cpt1b" "CPT1B protein"))
(define-protein "A8KA19_HUMAN" ("trnas" "cDNA FLJ75831, highly similar to Homo sapiens exportin, tRNA (nuclear export receptor for tRNAs) (XPOT), mRNA"))
=======
(define-protein "A2NVG1_HUMAN" ("H.sapiens Mahlavu hepatocellular carcinoma hhc(M) DNA"))
(define-protein "A2Q6Z4_9HIV1" ("Env protein"))
(define-protein "A4D275_HUMAN" ("Actin related protein 2/3 complex, subunit 1B, 41kDa" "Actin related protein 2/3 complex, subunit 1B, 41kDa, isoform CRA_a" "cDNA, FLJ95695, Homo sapiens actin related protein 2/3 complex, subunit 1B, 41kDa(ARPC1B), mRNA"))
(define-protein "A4ZJ37_9HIV1" ("Pol protein"))
(define-protein "A4_HUMAN" ("Amyloid beta A4 protein" "ABPP" "APPI" "APP" "Alzheimer disease amyloid protein" "Cerebral vascular amyloid peptide" "CVAP" "PreA4" "Protease nexin-II" "PN-II"))
(define-protein "A5PLL0_HUMAN" ("CPT1B protein"))
(define-protein "A8KA19_HUMAN" ("cDNA FLJ75831, highly similar to Homo sapiens exportin, tRNA (nuclear export receptor for tRNAs) (XPOT), mRNA"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "A9YLD1_MEDTR" ("AA8")) 
(define-protein "AAKB1_HUMAN" ("AMPKb" "AMPK" "PRKAB1")) 
(define-protein "AAKG1_HUMAN" ("AMPKg" "PRKAG1")) 
(define-protein "AAPK1_HUMAN" ("AMPK1" "PRKAA1")) 
<<<<<<< .mine
(define-protein "AAPK2_HUMAN" ("hmgcr" "5'-AMP-activated protein kinase catalytic subunit alpha-2" "AMPK subunit alpha-2" "Acetyl-CoA carboxylase kinase" "ACACA kinase" "Hydroxymethylglutaryl-CoA reductase kinase" "HMGCR kinase"))
=======
<<<<<<< .mine
(define-protein "AAPK2_HUMAN" ("hmgcr" "5'-AMP-activated protein kinase catalytic subunit alpha-2" "AMPK subunit alpha-2" "Acetyl-CoA carboxylase kinase" "ACACA kinase" "Hydroxymethylglutaryl-CoA reductase kinase" "HMGCR kinase"))
=======
(define-protein "AAPK2_HUMAN" ("5'-AMP-activated protein kinase catalytic subunit alpha-2" "AMPK subunit alpha-2" "Acetyl-CoA carboxylase kinase" "ACACA kinase" "Hydroxymethylglutaryl-CoA reductase kinase" "HMGCR kinase"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "AB1IP_HUMAN" ("RIAM" "APBB1IP" "PREL1" "RARP-1" "RARP1" "PREL-1")) 
<<<<<<< .mine
(define-protein "ABCA4_HUMAN" ("chloroquine" "Retinal-specific ATP-binding cassette transporter" "ATP-binding cassette sub-family A member 4" "RIM ABC transporter" "RIM protein" "RmP" "Stargardt disease protein"))
(define-protein "ABCB5_HUMAN" ("rhodamine" "ATP-binding cassette sub-family B member 5" "ABCB5 P-gp" "P-glycoprotein ABCB5"))
(define-protein "ABCC8_HUMAN" ("hyperglycemia" "ATP-binding cassette sub-family C member 8" "Sulfonylurea receptor 1"))
=======
<<<<<<< .mine
(define-protein "ABCA4_HUMAN" ("chloroquine" "Retinal-specific ATP-binding cassette transporter" "ATP-binding cassette sub-family A member 4" "RIM ABC transporter" "RIM protein" "RmP" "Stargardt disease protein"))
(define-protein "ABCB5_HUMAN" ("rhodamine" "ATP-binding cassette sub-family B member 5" "ABCB5 P-gp" "P-glycoprotein ABCB5"))
(define-protein "ABCC8_HUMAN" ("hyperglycemia" "ATP-binding cassette sub-family C member 8" "Sulfonylurea receptor 1"))
=======
(define-protein "ABCA4_HUMAN" ("Retinal-specific ATP-binding cassette transporter" "ATP-binding cassette sub-family A member 4" "RIM ABC transporter" "RIM protein" "RmP" "Stargardt disease protein"))
(define-protein "ABCB5_HUMAN" ("ATP-binding cassette sub-family B member 5" "ABCB5 P-gp" "P-glycoprotein ABCB5"))
(define-protein "ABCC8_HUMAN" ("ATP-binding cassette sub-family C member 8" "Sulfonylurea receptor 1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ABCG1_HUMAN" ("ATP-binding cassette sub-family G member 1" "ATP-binding cassette transporter 8" "White protein homolog"))
<<<<<<< .mine
(define-protein "ABI1_HUMAN" ("v-abl" "Abl interactor 1" "Abelson interactor 1" "Abi-1" "Abl-binding protein 4" "AblBP4" "Eps8 SH3 domain-binding protein" "Eps8-binding protein" "Nap1-binding protein" "Nap1BP" "Spectrin SH3 domain-binding protein 1" "e3B1"))
(define-protein "ABL1_HUMAN" ("c-abl" "Tyrosine-protein kinase ABL1" "Abelson murine leukemia viral oncogene homolog 1" "Abelson tyrosine-protein kinase 1" "Proto-oncogene c-Abl" "p150"))
=======
<<<<<<< .mine
(define-protein "ABI1_HUMAN" ("v-abl" "Abl interactor 1" "Abelson interactor 1" "Abi-1" "Abl-binding protein 4" "AblBP4" "Eps8 SH3 domain-binding protein" "Eps8-binding protein" "Nap1-binding protein" "Nap1BP" "Spectrin SH3 domain-binding protein 1" "e3B1"))
(define-protein "ABL1_HUMAN" ("c-abl" "Tyrosine-protein kinase ABL1" "Abelson murine leukemia viral oncogene homolog 1" "Abelson tyrosine-protein kinase 1" "Proto-oncogene c-Abl" "p150"))
=======
(define-protein "ABI1_HUMAN" ("Abl interactor 1" "Abelson interactor 1" "Abi-1" "Abl-binding protein 4" "AblBP4" "Eps8 SH3 domain-binding protein" "Eps8-binding protein" "Nap1-binding protein" "Nap1BP" "Spectrin SH3 domain-binding protein 1" "e3B1"))
(define-protein "ABL1_HUMAN" ("Tyrosine-protein kinase ABL1" "Abelson murine leukemia viral oncogene homolog 1" "Abelson tyrosine-protein kinase 1" "Proto-oncogene c-Abl" "p150"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ABL2-RIN1" NIL) 
<<<<<<< .mine
(define-protein "ACACA_HUMAN" ("acc" "Acetyl-CoA carboxylase 1" "ACC1" "ACC-alpha"))
(define-protein "ACADL_HUMAN" ("acadl" "Long-chain specific acyl-CoA dehydrogenase, mitochondrial" "LCAD"))
=======
<<<<<<< .mine
(define-protein "ACACA_HUMAN" ("acc" "Acetyl-CoA carboxylase 1" "ACC1" "ACC-alpha"))
(define-protein "ACADL_HUMAN" ("acadl" "Long-chain specific acyl-CoA dehydrogenase, mitochondrial" "LCAD"))
=======
(define-protein "ACACA_HUMAN" ("Acetyl-CoA carboxylase 1" "ACC1" "ACC-alpha"))
(define-protein "ACADL_HUMAN" ("Long-chain specific acyl-CoA dehydrogenase, mitochondrial" "LCAD"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ACADV_HUMAN" ("ACADVL" "VLCAD")) 
(define-protein "ACAP2_HUMAN" ("Cnt-b2" "CENTB2" "Centaurin-beta-2" "KIAA0041" "ACAP2")) 
(define-protein "ACBD5_HUMAN" ("ACBD5" "KIAA1996")) 
<<<<<<< .mine
(define-protein "ACHA7_HUMAN" ("SH-SY5Y" "Neuronal acetylcholine receptor subunit alpha-7"))
(define-protein "ACINU_HUMAN" ("acinus" "Apoptotic chromatin condensation inducer in the nucleus" "Acinus"))
=======
<<<<<<< .mine
(define-protein "ACHA7_HUMAN" ("SH-SY5Y" "Neuronal acetylcholine receptor subunit alpha-7"))
(define-protein "ACINU_HUMAN" ("acinus" "Apoptotic chromatin condensation inducer in the nucleus" "Acinus"))
=======
(define-protein "ACHA7_HUMAN" ("Neuronal acetylcholine receptor subunit alpha-7"))
(define-protein "ACINU_HUMAN" ("Apoptotic chromatin condensation inducer in the nucleus" "Acinus"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ACK1_HUMAN" ("Activated CDC42 kinase 1" "ACK-1" "Tyrosine kinase non-receptor protein 2"))
<<<<<<< .mine
(define-protein "ACK1_HUMAN" ("monoubiquitin" "Activated CDC42 kinase 1" "ACK-1" "Tyrosine kinase non-receptor protein 2"))
(define-protein "ACKR1_HUMAN" ("heterozygotes" "Atypical chemokine receptor 1" "Duffy antigen/chemokine receptor" "Fy glycoprotein" "GpFy" "Glycoprotein D" "Plasmodium vivax receptor"))
(define-protein "ACKR2_HUMAN" ("d6" "Atypical chemokine receptor 2" "C-C chemokine receptor D6" "Chemokine receptor CCR-10" "Chemokine receptor CCR-9" "Chemokine-binding protein 2" "Chemokine-binding protein D6"))
=======
<<<<<<< .mine
(define-protein "ACK1_HUMAN" ("monoubiquitin" "Activated CDC42 kinase 1" "ACK-1" "Tyrosine kinase non-receptor protein 2"))
(define-protein "ACKR1_HUMAN" ("heterozygotes" "Atypical chemokine receptor 1" "Duffy antigen/chemokine receptor" "Fy glycoprotein" "GpFy" "Glycoprotein D" "Plasmodium vivax receptor"))
(define-protein "ACKR2_HUMAN" ("d6" "Atypical chemokine receptor 2" "C-C chemokine receptor D6" "Chemokine receptor CCR-10" "Chemokine receptor CCR-9" "Chemokine-binding protein 2" "Chemokine-binding protein D6"))
=======
(define-protein "ACKR1_HUMAN" ("Atypical chemokine receptor 1" "Duffy antigen/chemokine receptor" "Fy glycoprotein" "GpFy" "Glycoprotein D" "Plasmodium vivax receptor"))
(define-protein "ACKR2_HUMAN" ("Atypical chemokine receptor 2" "C-C chemokine receptor D6" "Chemokine receptor CCR-10" "Chemokine receptor CCR-9" "Chemokine-binding protein 2" "Chemokine-binding protein D6"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ACO11_HUMAN" ("ACOT11" "KIAA0707" "BFIT" "THEA")) 
<<<<<<< .mine
(define-protein "ACOX1_HUMAN" ("aox" "Peroxisomal acyl-coenzyme A oxidase 1" "AOX" "Palmitoyl-CoA oxidase" "Straight-chain acyl-CoA oxidase" "SCOX"))
=======
<<<<<<< .mine
(define-protein "ACOX1_HUMAN" ("aox" "Peroxisomal acyl-coenzyme A oxidase 1" "AOX" "Palmitoyl-CoA oxidase" "Straight-chain acyl-CoA oxidase" "SCOX"))
=======
(define-protein "ACOX1_HUMAN" ("Peroxisomal acyl-coenzyme A oxidase 1" "AOX" "Palmitoyl-CoA oxidase" "Straight-chain acyl-CoA oxidase" "SCOX"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ACSF2_HUMAN" ("ACSF2")) 
(define-protein "ACSL3_HUMAN" ("ACSL3" "ACS3" "FACL3" "LACS3")) 
(define-protein "ACSL5_HUMAN" ("ACSL5" "ACS5" "FACL5")) 
<<<<<<< .mine
(define-protein "ACTA_HUMAN" ("α-Actin" "Actin, aortic smooth muscle" "Alpha-actin-2" "Cell growth-inhibiting gene 46 protein"))
=======
<<<<<<< .mine
(define-protein "ACTA_HUMAN" ("α-Actin" "Actin, aortic smooth muscle" "Alpha-actin-2" "Cell growth-inhibiting gene 46 protein"))
=======
(define-protein "ACTA_HUMAN" ("Actin, aortic smooth muscle" "Alpha-actin-2" "Cell growth-inhibiting gene 46 protein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ACTB_HUMAN" ("ACTB" "Beta-actin")) 
<<<<<<< .mine
(define-protein "ACTN1_HUMAN" ("α-actinin" "Alpha-actinin-1" "Alpha-actinin cytoskeletal isoform" "F-actin cross-linking protein" "Non-muscle alpha-actinin-1"))
=======
<<<<<<< .mine
(define-protein "ACTN1_HUMAN" ("α-actinin" "Alpha-actinin-1" "Alpha-actinin cytoskeletal isoform" "F-actin cross-linking protein" "Non-muscle alpha-actinin-1"))
=======
(define-protein "ACTN1_HUMAN" ("Alpha-actinin-1" "Alpha-actinin cytoskeletal isoform" "F-actin cross-linking protein" "Non-muscle alpha-actinin-1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ACTN4_HUMAN" ("ACTN4")) 
<<<<<<< .mine
(define-protein "ACV1B_HUMAN" ("activin" "Activin receptor type-1B" "Activin receptor type IB" "ACTR-IB" "Activin receptor-like kinase 4" "ALK-4" "Serine/threonine-protein kinase receptor R2" "SKR2"))
(define-protein "ADA10_HUMAN" ("IL-1α" "Disintegrin and metalloproteinase domain-containing protein 10" "ADAM 10" "CDw156" "Kuzbanian protein homolog" "Mammalian disintegrin-metalloprotease"))
(define-protein "ADA12_HUMAN" ("syndecans" "Disintegrin and metalloproteinase domain-containing protein 12" "ADAM 12" "Meltrin-alpha"))
(define-protein "ADA15_HUMAN" ("αvβ3" "Disintegrin and metalloproteinase domain-containing protein 15" "ADAM 15" "Metalloprotease RGD disintegrin protein" "Metalloproteinase-like, disintegrin-like, and cysteine-rich protein 15" "MDC-15" "Metargidin"))
(define-protein "ADA17_HUMAN" ("TNF-α" "Disintegrin and metalloproteinase domain-containing protein 17" "ADAM 17" "Snake venom-like protease" "TNF-alpha convertase" "TNF-alpha-converting enzyme"))
=======
<<<<<<< .mine
(define-protein "ACV1B_HUMAN" ("activin" "Activin receptor type-1B" "Activin receptor type IB" "ACTR-IB" "Activin receptor-like kinase 4" "ALK-4" "Serine/threonine-protein kinase receptor R2" "SKR2"))
(define-protein "ADA10_HUMAN" ("IL-1α" "Disintegrin and metalloproteinase domain-containing protein 10" "ADAM 10" "CDw156" "Kuzbanian protein homolog" "Mammalian disintegrin-metalloprotease"))
(define-protein "ADA12_HUMAN" ("syndecans" "Disintegrin and metalloproteinase domain-containing protein 12" "ADAM 12" "Meltrin-alpha"))
(define-protein "ADA15_HUMAN" ("αvβ3" "Disintegrin and metalloproteinase domain-containing protein 15" "ADAM 15" "Metalloprotease RGD disintegrin protein" "Metalloproteinase-like, disintegrin-like, and cysteine-rich protein 15" "MDC-15" "Metargidin"))
(define-protein "ADA17_HUMAN" ("TNF-α" "Disintegrin and metalloproteinase domain-containing protein 17" "ADAM 17" "Snake venom-like protease" "TNF-alpha convertase" "TNF-alpha-converting enzyme"))
=======
(define-protein "ACV1B_HUMAN" ("Activin receptor type-1B" "Activin receptor type IB" "ACTR-IB" "Activin receptor-like kinase 4" "ALK-4" "Serine/threonine-protein kinase receptor R2" "SKR2"))
(define-protein "ADA10_HUMAN" ("Disintegrin and metalloproteinase domain-containing protein 10" "ADAM 10" "CDw156" "Kuzbanian protein homolog" "Mammalian disintegrin-metalloprotease"))
(define-protein "ADA12_HUMAN" ("Disintegrin and metalloproteinase domain-containing protein 12" "ADAM 12" "Meltrin-alpha"))
(define-protein "ADA15_HUMAN" ("Disintegrin and metalloproteinase domain-containing protein 15" "ADAM 15" "Metalloprotease RGD disintegrin protein" "Metalloproteinase-like, disintegrin-like, and cysteine-rich protein 15" "MDC-15" "Metargidin"))
(define-protein "ADA17_HUMAN" ("Disintegrin and metalloproteinase domain-containing protein 17" "ADAM 17" "Snake venom-like protease" "TNF-alpha convertase" "TNF-alpha-converting enzyme"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ADAS_HUMAN" ("AGPS")) 
<<<<<<< .mine
(define-protein "ADA_HUMAN" ("adenosine" "Adenosine deaminase" "Adenosine aminohydrolase"))
=======
<<<<<<< .mine
(define-protein "ADA_HUMAN" ("adenosine" "Adenosine deaminase" "Adenosine aminohydrolase"))
=======
(define-protein "ADA_HUMAN" ("Adenosine deaminase" "Adenosine aminohydrolase"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ADDA_HUMAN" ("ADD1" "ADDA")) 
(define-protein "ADDG_HUMAN" ("ADDL" "ADD3")) 
(define-protein "ADH6_HUMAN" ("ADH6")) 
<<<<<<< .mine
(define-protein "ADH7_HUMAN" ("ethanol" "Alcohol dehydrogenase class 4 mu/sigma chain" "Alcohol dehydrogenase class IV mu/sigma chain" "Gastric alcohol dehydrogenase" "Retinol dehydrogenase"))
(define-protein "ADIPL_HUMAN" ("Full-length" "Adipolin" "Adipose-derived insulin-sensitizing factor" "Complement C1q tumor necrosis factor-related protein 12"))
(define-protein "ADIPO_HUMAN" ("adipoq" "Adiponectin" "30 kDa adipocyte complement-related protein" "Adipocyte complement-related 30 kDa protein" "ACRP30" "Adipocyte, C1q and collagen domain-containing protein" "Adipose most abundant gene transcript 1 protein" "apM-1" "Gelatin-binding protein"))
=======
<<<<<<< .mine
(define-protein "ADH7_HUMAN" ("ethanol" "Alcohol dehydrogenase class 4 mu/sigma chain" "Alcohol dehydrogenase class IV mu/sigma chain" "Gastric alcohol dehydrogenase" "Retinol dehydrogenase"))
(define-protein "ADIPL_HUMAN" ("Full-length" "Adipolin" "Adipose-derived insulin-sensitizing factor" "Complement C1q tumor necrosis factor-related protein 12"))
(define-protein "ADIPO_HUMAN" ("adipoq" "Adiponectin" "30 kDa adipocyte complement-related protein" "Adipocyte complement-related 30 kDa protein" "ACRP30" "Adipocyte, C1q and collagen domain-containing protein" "Adipose most abundant gene transcript 1 protein" "apM-1" "Gelatin-binding protein"))
=======
(define-protein "ADH7_HUMAN" ("Alcohol dehydrogenase class 4 mu/sigma chain" "Alcohol dehydrogenase class IV mu/sigma chain" "Gastric alcohol dehydrogenase" "Retinol dehydrogenase"))
(define-protein "ADIPL_HUMAN" ("Adipolin" "Adipose-derived insulin-sensitizing factor" "Complement C1q tumor necrosis factor-related protein 12"))
(define-protein "ADIPO_HUMAN" ("Adiponectin" "30 kDa adipocyte complement-related protein" "Adipocyte complement-related 30 kDa protein" "ACRP30" "Adipocyte, C1q and collagen domain-containing protein" "Adipose most abundant gene transcript 1 protein" "apM-1" "Gelatin-binding protein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ADRM1_HUMAN" ("Gp110" "hRpn13" "GP110" "ADRM1" "ARM-1")) 
<<<<<<< .mine
(define-protein "ADX_HUMAN" ("cycloheximide" "Adrenodoxin, mitochondrial" "Adrenal ferredoxin" "Ferredoxin-1" "Hepatoredoxin"))
=======
<<<<<<< .mine
(define-protein "ADX_HUMAN" ("cycloheximide" "Adrenodoxin, mitochondrial" "Adrenal ferredoxin" "Ferredoxin-1" "Hepatoredoxin"))
=======
(define-protein "ADX_HUMAN" ("Adrenodoxin, mitochondrial" "Adrenal ferredoxin" "Ferredoxin-1" "Hepatoredoxin"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "AF-6" ("Afadin")) 
(define-protein "AFAD_HUMAN" ("MLLT4" "AF6")) 
<<<<<<< .mine
(define-protein "AFAP1_HUMAN" ("MCF-10A" "Actin filament-associated protein 1" "110 kDa actin filament-associated protein" "AFAP-110"))
(define-protein "AGAP2_HUMAN" ("ye" "Arf-GAP with GTPase, ANK repeat and PH domain-containing protein 2" "AGAP-2" "Centaurin-gamma-1" "Cnt-g1" "GTP-binding and GTPase-activating protein 2" "GGAP2" "Phosphatidylinositol 3-kinase enhancer" "PIKE"))
=======
<<<<<<< .mine
(define-protein "AFAP1_HUMAN" ("MCF-10A" "Actin filament-associated protein 1" "110 kDa actin filament-associated protein" "AFAP-110"))
(define-protein "AGAP2_HUMAN" ("ye" "Arf-GAP with GTPase, ANK repeat and PH domain-containing protein 2" "AGAP-2" "Centaurin-gamma-1" "Cnt-g1" "GTP-binding and GTPase-activating protein 2" "GGAP2" "Phosphatidylinositol 3-kinase enhancer" "PIKE"))
=======
(define-protein "AFAP1_HUMAN" ("Actin filament-associated protein 1" "110 kDa actin filament-associated protein" "AFAP-110"))
(define-protein "AGAP2_HUMAN" ("Arf-GAP with GTPase, ANK repeat and PH domain-containing protein 2" "AGAP-2" "Centaurin-gamma-1" "Cnt-g1" "GTP-binding and GTPase-activating protein 2" "GGAP2" "Phosphatidylinositol 3-kinase enhancer" "PIKE"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "AGK_HUMAN" ("hAGK" "AGK" "HsMuLK" "MuLK" "MULK")) 
<<<<<<< .mine
(define-protein "AGO1_HUMAN" ("sirnas" "Protein argonaute-1" "Argonaute1" "hAgo1" "Argonaute RISC catalytic component 1" "Eukaryotic translation initiation factor 2C 1" "eIF-2C 1" "eIF2C 1" "Putative RNA-binding protein Q99"))
(define-protein "AGO2_HUMAN" ("sirna" "Protein argonaute-2" "Argonaute2" "hAgo2" "Argonaute RISC catalytic component 2" "Eukaryotic translation initiation factor 2C 2" "eIF-2C 2" "eIF2C 2" "PAZ Piwi domain protein" "PPD" "Protein slicer"))
=======
<<<<<<< .mine
(define-protein "AGO1_HUMAN" ("sirnas" "Protein argonaute-1" "Argonaute1" "hAgo1" "Argonaute RISC catalytic component 1" "Eukaryotic translation initiation factor 2C 1" "eIF-2C 1" "eIF2C 1" "Putative RNA-binding protein Q99"))
(define-protein "AGO2_HUMAN" ("sirna" "Protein argonaute-2" "Argonaute2" "hAgo2" "Argonaute RISC catalytic component 2" "Eukaryotic translation initiation factor 2C 2" "eIF-2C 2" "eIF2C 2" "PAZ Piwi domain protein" "PPD" "Protein slicer"))
=======
(define-protein "AGO1_HUMAN" ("Protein argonaute-1" "Argonaute1" "hAgo1" "Argonaute RISC catalytic component 1" "Eukaryotic translation initiation factor 2C 1" "eIF-2C 1" "eIF2C 1" "Putative RNA-binding protein Q99"))
(define-protein "AGO2_HUMAN" ("Protein argonaute-2" "Argonaute2" "hAgo2" "Argonaute RISC catalytic component 2" "Eukaryotic translation initiation factor 2C 2" "eIF-2C 2" "eIF2C 2" "PAZ Piwi domain protein" "PPD" "Protein slicer"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "AGR2_HUMAN" ("AG2" "hAG-2" "AG-2" "AGR2" "HPC8")) 
<<<<<<< .mine
(define-protein "AGRF4_HUMAN" ("F4" "Adhesion G protein-coupled receptor F4" "G-protein coupled receptor 115" "G-protein coupled receptor PGR18"))
(define-protein "AGRG5_HUMAN" ("pgr" "Adhesion G-protein coupled receptor G5" "G-protein coupled receptor 114" "G-protein coupled receptor PGR27"))
=======
<<<<<<< .mine
(define-protein "AGRF4_HUMAN" ("F4" "Adhesion G protein-coupled receptor F4" "G-protein coupled receptor 115" "G-protein coupled receptor PGR18"))
(define-protein "AGRG5_HUMAN" ("pgr" "Adhesion G-protein coupled receptor G5" "G-protein coupled receptor 114" "G-protein coupled receptor PGR27"))
=======
(define-protein "AGRF4_HUMAN" ("Adhesion G protein-coupled receptor F4" "G-protein coupled receptor 115" "G-protein coupled receptor PGR18"))
(define-protein "AGRG5_HUMAN" ("Adhesion G-protein coupled receptor G5" "G-protein coupled receptor 114" "G-protein coupled receptor PGR27"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "AGTR2_HUMAN" ("Type-2 angiotensin II receptor" "Angiotensin II type-2 receptor" "AT2"))
(define-protein "AHNK_HUMAN" ("PM227" "Desmoyokin" "AHNAK")) 
(define-protein "AIDA_HUMAN" ("AIDA" "C1orf80")) 
<<<<<<< .mine
(define-protein "AIF1_HUMAN" ("aif" "Allograft inflammatory factor 1" "AIF-1" "Ionized calcium-binding adapter molecule 1" "Protein G1"))
(define-protein "AINX_HUMAN" ("α-internexin" "Alpha-internexin" "Alpha-Inx" "66 kDa neurofilament protein" "NF-66" "Neurofilament-66" "Neurofilament 5"))
=======
<<<<<<< .mine
(define-protein "AIF1_HUMAN" ("aif" "Allograft inflammatory factor 1" "AIF-1" "Ionized calcium-binding adapter molecule 1" "Protein G1"))
(define-protein "AINX_HUMAN" ("α-internexin" "Alpha-internexin" "Alpha-Inx" "66 kDa neurofilament protein" "NF-66" "Neurofilament-66" "Neurofilament 5"))
=======
(define-protein "AIF1_HUMAN" ("Allograft inflammatory factor 1" "AIF-1" "Ionized calcium-binding adapter molecule 1" "Protein G1"))
(define-protein "AINX_HUMAN" ("Alpha-internexin" "Alpha-Inx" "66 kDa neurofilament protein" "NF-66" "Neurofilament-66" "Neurofilament 5"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "AIP_HUMAN" ("XAP2" "AIP" "XAP-2")) 
<<<<<<< .mine
(define-protein "AJUBA_HUMAN" ("ajuba" "LIM domain-containing protein ajuba"))
(define-protein "AK1C1_HUMAN" ("dht" "Aldo-keto reductase family 1 member C1" "20-alpha-hydroxysteroid dehydrogenase" "20-alpha-HSD" "Chlordecone reductase homolog HAKRC" "Dihydrodiol dehydrogenase 1/2" "DD1/DD2" "High-affinity hepatic bile acid-binding protein" "HBAB" "Indanol dehydrogenase" "Trans-1,2-dihydrobenzene-1,2-diol dehydrogenase"))
(define-protein "AKAP1_HUMAN" ("A-kinase" "A-kinase anchor protein 1, mitochondrial" "A-kinase anchor protein 149 kDa" "AKAP 149" "Dual specificity A-kinase-anchoring protein 1" "D-AKAP-1" "Protein kinase A-anchoring protein 1" "PRKA1" "Spermatid A-kinase anchor protein 84" "S-AKAP84"))
(define-protein "AKT1_HUMAN" ("Akt/protein" "RAC-alpha serine/threonine-protein kinase" "Protein kinase B" "PKB" "Protein kinase B alpha" "PKB alpha" "Proto-oncogene c-Akt" "RAC-PK-alpha"))
=======
<<<<<<< .mine
(define-protein "AJUBA_HUMAN" ("ajuba" "LIM domain-containing protein ajuba"))
(define-protein "AK1C1_HUMAN" ("dht" "Aldo-keto reductase family 1 member C1" "20-alpha-hydroxysteroid dehydrogenase" "20-alpha-HSD" "Chlordecone reductase homolog HAKRC" "Dihydrodiol dehydrogenase 1/2" "DD1/DD2" "High-affinity hepatic bile acid-binding protein" "HBAB" "Indanol dehydrogenase" "Trans-1,2-dihydrobenzene-1,2-diol dehydrogenase"))
(define-protein "AKAP1_HUMAN" ("A-kinase" "A-kinase anchor protein 1, mitochondrial" "A-kinase anchor protein 149 kDa" "AKAP 149" "Dual specificity A-kinase-anchoring protein 1" "D-AKAP-1" "Protein kinase A-anchoring protein 1" "PRKA1" "Spermatid A-kinase anchor protein 84" "S-AKAP84"))
(define-protein "AKT1_HUMAN" ("Akt/protein" "RAC-alpha serine/threonine-protein kinase" "Protein kinase B" "PKB" "Protein kinase B alpha" "PKB alpha" "Proto-oncogene c-Akt" "RAC-PK-alpha"))
=======
(define-protein "AJUBA_HUMAN" ("LIM domain-containing protein ajuba"))
(define-protein "AK1C1_HUMAN" ("Aldo-keto reductase family 1 member C1" "20-alpha-hydroxysteroid dehydrogenase" "20-alpha-HSD" "Chlordecone reductase homolog HAKRC" "Dihydrodiol dehydrogenase 1/2" "DD1/DD2" "High-affinity hepatic bile acid-binding protein" "HBAB" "Indanol dehydrogenase" "Trans-1,2-dihydrobenzene-1,2-diol dehydrogenase"))
(define-protein "AKAP1_HUMAN" ("A-kinase anchor protein 1, mitochondrial" "A-kinase anchor protein 149 kDa" "AKAP 149" "Dual specificity A-kinase-anchoring protein 1" "D-AKAP-1" "Protein kinase A-anchoring protein 1" "PRKA1" "Spermatid A-kinase anchor protein 84" "S-AKAP84"))
(define-protein "AKT1_HUMAN" ("RAC-alpha serine/threonine-protein kinase" "Protein kinase B" "PKB" "Protein kinase B alpha" "PKB alpha" "Proto-oncogene c-Akt" "RAC-PK-alpha"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "AKT2_HUMAN" ("RAC-beta serine/threonine-protein kinase" "Protein kinase Akt-2" "Protein kinase B beta" "PKB beta" "RAC-PK-beta"))
<<<<<<< .mine
(define-protein "AKT3_HUMAN" ("pervanadate" "RAC-gamma serine/threonine-protein kinase" "Protein kinase Akt-3" "Protein kinase B gamma" "PKB gamma" "RAC-PK-gamma" "STK-2"))
=======
<<<<<<< .mine
(define-protein "AKT3_HUMAN" ("pervanadate" "RAC-gamma serine/threonine-protein kinase" "Protein kinase Akt-3" "Protein kinase B gamma" "PKB gamma" "RAC-PK-gamma" "STK-2"))
=======
(define-protein "AKT3_HUMAN" ("RAC-gamma serine/threonine-protein kinase" "Protein kinase Akt-3" "Protein kinase B gamma" "PKB gamma" "RAC-PK-gamma" "STK-2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "AKTS1_HUMAN" ("PRAS40" "ECO:0000303|PubMed:16174443}" "AKT1S1")) 
(define-protein "AKTS1_HUMAN" ("Proline-rich AKT1 substrate 1" "40 kDa proline-rich AKT substrate"))
<<<<<<< .mine
(define-protein "AL1A2_HUMAN" ("RALDH2" "Retinal dehydrogenase 2" "RALDH 2" "RalDH2" "Aldehyde dehydrogenase family 1 member A2" "Retinaldehyde-specific dehydrogenase type 2" "RALDH(II)"))
=======
<<<<<<< .mine
(define-protein "AL1A2_HUMAN" ("RALDH2" "Retinal dehydrogenase 2" "RALDH 2" "RalDH2" "Aldehyde dehydrogenase family 1 member A2" "Retinaldehyde-specific dehydrogenase type 2" "RALDH(II)"))
=======
(define-protein "AL1A2_HUMAN" ("Retinal dehydrogenase 2" "RALDH 2" "RalDH2" "Aldehyde dehydrogenase family 1 member A2" "Retinaldehyde-specific dehydrogenase type 2" "RALDH(II)"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "AL1B1_HUMAN" ("ALDH5" "ALDH1B1" "ALDHX")) 
<<<<<<< .mine
(define-protein "AL2SA_HUMAN" ("2SA" "Amyotrophic lateral sclerosis 2 chromosomal region candidate gene 11 protein"))
(define-protein "AL5AP_HUMAN" ("leukotrienes" "Arachidonate 5-lipoxygenase-activating protein" "FLAP" "MK-886-binding protein"))
(define-protein "ALEX_HUMAN" ("exon" "Protein ALEX" "Alternative gene product encoded by XL-exon"))
=======
<<<<<<< .mine
(define-protein "AL2SA_HUMAN" ("2SA" "Amyotrophic lateral sclerosis 2 chromosomal region candidate gene 11 protein"))
(define-protein "AL5AP_HUMAN" ("leukotrienes" "Arachidonate 5-lipoxygenase-activating protein" "FLAP" "MK-886-binding protein"))
(define-protein "ALEX_HUMAN" ("exon" "Protein ALEX" "Alternative gene product encoded by XL-exon"))
=======
(define-protein "AL2SA_HUMAN" ("Amyotrophic lateral sclerosis 2 chromosomal region candidate gene 11 protein"))
(define-protein "AL5AP_HUMAN" ("Arachidonate 5-lipoxygenase-activating protein" "FLAP" "MK-886-binding protein"))
(define-protein "ALEX_HUMAN" ("Protein ALEX" "Alternative gene product encoded by XL-exon"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ALKB5_HUMAN" ("RNA demethylase ALKBH5" "Alkylated DNA repair protein alkB homolog 5" "Alpha-ketoglutarate-dependent dioxygenase alkB homolog 5"))
<<<<<<< .mine
(define-protein "ALS_HUMAN" ("labile" "Insulin-like growth factor-binding protein complex acid labile subunit" "ALS"))
=======
<<<<<<< .mine
(define-protein "ALS_HUMAN" ("labile" "Insulin-like growth factor-binding protein complex acid labile subunit" "ALS"))
=======
(define-protein "ALS_HUMAN" ("Insulin-like growth factor-binding protein complex acid labile subunit" "ALS"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "AMERL_HUMAN" ("AMMECR1L")) 
<<<<<<< .mine
(define-protein "AMHR2_HUMAN" ("anti-" "Anti-Muellerian hormone type-2 receptor" "Anti-Muellerian hormone type II receptor" "AMH type II receptor" "MIS type II receptor" "MISRII" "MRII"))
=======
<<<<<<< .mine
(define-protein "AMHR2_HUMAN" ("anti-" "Anti-Muellerian hormone type-2 receptor" "Anti-Muellerian hormone type II receptor" "AMH type II receptor" "MIS type II receptor" "MISRII" "MRII"))
=======
(define-protein "AMHR2_HUMAN" ("Anti-Muellerian hormone type-2 receptor" "Anti-Muellerian hormone type II receptor" "AMH type II receptor" "MIS type II receptor" "MISRII" "MRII"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ANAG_HUMAN" ("NAG" "UFHSD1" "NAGLU" "N-acetyl-alpha-glucosaminidase")) 
(define-protein "ANFY1_HUMAN" ("Rank-5" "KIAA1255" "ANKFY1" "ANKHZN")) 
<<<<<<< .mine
(define-protein "ANGT_HUMAN" ("angiotensinogen" "Angiotensinogen" "Serpin A8"))
(define-protein "ANKR2_HUMAN" ("Ankrd2" "Ankyrin repeat domain-containing protein 2" "Skeletal muscle ankyrin repeat protein" "hArpp"))
(define-protein "ANM7_HUMAN" ("prmt" "Protein arginine N-methyltransferase 7" "Histone-arginine N-methyltransferase PRMT7" "[Myelin basic protein]-arginine N-methyltransferase PRMT7"))
(define-protein "ANO7_HUMAN" ("lncap" "Anoctamin-7" "Dresden transmembrane protein of the prostate" "D-TMPP" "IPCA-5" "New gene expressed in prostate" "Prostate cancer-associated protein 5" "Transmembrane protein 16G"))
=======
<<<<<<< .mine
(define-protein "ANGT_HUMAN" ("angiotensinogen" "Angiotensinogen" "Serpin A8"))
(define-protein "ANKR2_HUMAN" ("Ankrd2" "Ankyrin repeat domain-containing protein 2" "Skeletal muscle ankyrin repeat protein" "hArpp"))
(define-protein "ANM7_HUMAN" ("prmt" "Protein arginine N-methyltransferase 7" "Histone-arginine N-methyltransferase PRMT7" "[Myelin basic protein]-arginine N-methyltransferase PRMT7"))
(define-protein "ANO7_HUMAN" ("lncap" "Anoctamin-7" "Dresden transmembrane protein of the prostate" "D-TMPP" "IPCA-5" "New gene expressed in prostate" "Prostate cancer-associated protein 5" "Transmembrane protein 16G"))
=======
(define-protein "ANGT_HUMAN" ("Angiotensinogen" "Serpin A8"))
(define-protein "ANKR2_HUMAN" ("Ankyrin repeat domain-containing protein 2" "Skeletal muscle ankyrin repeat protein" "hArpp"))
(define-protein "ANM7_HUMAN" ("Protein arginine N-methyltransferase 7" "Histone-arginine N-methyltransferase PRMT7" "[Myelin basic protein]-arginine N-methyltransferase PRMT7"))
(define-protein "ANO7_HUMAN" ("Anoctamin-7" "Dresden transmembrane protein of the prostate" "D-TMPP" "IPCA-5" "New gene expressed in prostate" "Prostate cancer-associated protein 5" "Transmembrane protein 16G"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ANR11_HUMAN" ("ANKRD11" "ANCO1")) 
<<<<<<< .mine
(define-protein "ANS1B_HUMAN" ("siRNA-mediated" "Ankyrin repeat and sterile alpha motif domain-containing protein 1B" "Amyloid-beta protein intracellular domain-associated protein 1" "AIDA-1" "E2A-PBX1-associated protein" "EB-1"))
=======
<<<<<<< .mine
(define-protein "ANS1B_HUMAN" ("siRNA-mediated" "Ankyrin repeat and sterile alpha motif domain-containing protein 1B" "Amyloid-beta protein intracellular domain-associated protein 1" "AIDA-1" "E2A-PBX1-associated protein" "EB-1"))
=======
(define-protein "ANS1B_HUMAN" ("Ankyrin repeat and sterile alpha motif domain-containing protein 1B" "Amyloid-beta protein intracellular domain-associated protein 1" "AIDA-1" "E2A-PBX1-associated protein" "EB-1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ANX11_HUMAN" ("Annexin-11" "CAP-50" "ANX11" "ANXA11")) 
(define-protein "ANXA1_HUMAN" ("p35" "Chromobindin-9" "LPC1" "ANXA1" "ANX1" "Annexin-1" "Calpactin-2")) 
(define-protein "ANXA2_HUMAN" ("p36" "CAL1H" "Chromobindin-8" "LPC2D" "ANXA2" "PAP-IV" "ANX2" "Annexin-2" "ANX2L4")) 
(define-protein "ANXA3_HUMAN" ("Annexin-3" "ANX3" "ANXA3" "PAP-III")) 
(define-protein "ANXA4_HUMAN" ("P32.5" "ANXA4" "Chromobindin-4" "PP4-X" "ANX4" "Annexin-4" "PAP-II")) 
(define-protein "ANXA5_HUMAN" ("PAP-I" "CBP-I" "ENX2" "PP4" "ANXA5" "ANX5" "Annexin-5" "VAC-alpha")) 
(define-protein "ANXA6_HUMAN" ("Annexin-6" "p68" "ANXA6" "Chromobindin-20" "ANX6" "p70" "Calphobindin-II" "CPB-II")) 
(define-protein "ANXA7_HUMAN" ("Annexin-7" "ANXA7" "SNX" "Synexin" "ANX7")) 
(define-protein "ANXA9_HUMAN" ("ANXA9" "ANX31" "Annexin-31" "Pemphaxin" "Annexin-9")) 
(define-protein "AOC1_HUMAN" ("Amiloride-sensitive amine oxidase [copper-containing]" "DAO" "Diamine oxidase" "Amiloride-binding protein 1" "Amine oxidase copper domain-containing protein 1" "Histaminase" "Kidney amine oxidase" "KAO"))
<<<<<<< .mine
(define-protein "AOC3_HUMAN" ("adipocytes" "Membrane primary amine oxidase" "Copper amine oxidase" "HPAO" "Semicarbazide-sensitive amine oxidase" "SSAO" "Vascular adhesion protein 1" "VAP-1"))
(define-protein "AOXA_HUMAN" ("raloxifene" "Aldehyde oxidase" "Aldehyde oxidase 1" "Azaheterocycle hydroxylase"))
=======
<<<<<<< .mine
(define-protein "AOC3_HUMAN" ("adipocytes" "Membrane primary amine oxidase" "Copper amine oxidase" "HPAO" "Semicarbazide-sensitive amine oxidase" "SSAO" "Vascular adhesion protein 1" "VAP-1"))
(define-protein "AOXA_HUMAN" ("raloxifene" "Aldehyde oxidase" "Aldehyde oxidase 1" "Azaheterocycle hydroxylase"))
=======
(define-protein "AOC3_HUMAN" ("Membrane primary amine oxidase" "Copper amine oxidase" "HPAO" "Semicarbazide-sensitive amine oxidase" "SSAO" "Vascular adhesion protein 1" "VAP-1"))
(define-protein "AOXA_HUMAN" ("Aldehyde oxidase" "Aldehyde oxidase 1" "Azaheterocycle hydroxylase"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "AP1B1_HUMAN" ("ADTB1" "Beta-1-adaptin" "AP1B1" "CLAPB2" "BAM22")) 
(define-protein "AP1G1_HUMAN" ("AP1G1" "ADTG" "Gamma1-adaptin" "CLAPG1")) 
(define-protein "AP1M2_HUMAN" ("AP1M2" "Mu1B-adaptin")) 
(define-protein "AP1S1_HUMAN" ("AP1S1" "AP19" "CLAPS1" "Sigma1A-adaptin")) 
(define-protein "AP2A1_HUMAN" ("Alpha1-adaptin" "CLAPA1" "ADTAA" "AP2A1")) 
(define-protein "AP2A2_HUMAN" ("HIP9" "KIAA0899" "ADTAB" "CLAPA2" "HYPJ" "HIP-9" "Alpha2-adaptin" "AP2A2")) 
(define-protein "AP2B1_HUMAN" ("ADTB2" "AP105B" "Beta-adaptin" "Beta-2-adaptin" "CLAPB1" "AP2B1")) 
(define-protein "AP2M1_HUMAN" ("KIAA0109" "CLAPM1" "Adaptin-mu2" "AP2M1")) 
<<<<<<< .mine
(define-protein "AP2S1_HUMAN" ("AP-" "AP-2 complex subunit sigma" "Adaptor protein complex AP-2 subunit sigma" "Adaptor-related protein complex 2 subunit sigma" "Clathrin assembly protein 2 sigma small chain" "Clathrin coat assembly protein AP17" "Clathrin coat-associated protein AP17" "HA2 17 kDa subunit" "Plasma membrane adaptor AP-2 17 kDa protein" "Sigma2-adaptin"))
=======
<<<<<<< .mine
(define-protein "AP2S1_HUMAN" ("AP-" "AP-2 complex subunit sigma" "Adaptor protein complex AP-2 subunit sigma" "Adaptor-related protein complex 2 subunit sigma" "Clathrin assembly protein 2 sigma small chain" "Clathrin coat assembly protein AP17" "Clathrin coat-associated protein AP17" "HA2 17 kDa subunit" "Plasma membrane adaptor AP-2 17 kDa protein" "Sigma2-adaptin"))
=======
(define-protein "AP2S1_HUMAN" ("AP-2 complex subunit sigma" "Adaptor protein complex AP-2 subunit sigma" "Adaptor-related protein complex 2 subunit sigma" "Clathrin assembly protein 2 sigma small chain" "Clathrin coat assembly protein AP17" "Clathrin coat-associated protein AP17" "HA2 17 kDa subunit" "Plasma membrane adaptor AP-2 17 kDa protein" "Sigma2-adaptin"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "AP3B1_HUMAN" ("Beta-3A-adaptin" "AP3B1" "ADTB3A")) 
(define-protein "AP3D1_HUMAN" ("Delta-adaptin" "AP3D1")) 
(define-protein "AP3M1_HUMAN" ("AP3M1" "Mu3A-adaptin")) 
(define-protein "AP3S1_HUMAN" ("Sigma-3A-adaptin" "CLAPS3" "AP3S1" "Sigma3A-adaptin")) 
<<<<<<< .mine
(define-protein "AP4E1_HUMAN" ("AP4" "AP-4 complex subunit epsilon-1" "AP-4 adaptor complex subunit epsilon" "Adaptor-related protein complex 4 subunit epsilon-1" "Epsilon subunit of AP-4" "Epsilon-adaptin"))
=======
<<<<<<< .mine
(define-protein "AP4E1_HUMAN" ("AP4" "AP-4 complex subunit epsilon-1" "AP-4 adaptor complex subunit epsilon" "Adaptor-related protein complex 4 subunit epsilon-1" "Epsilon subunit of AP-4" "Epsilon-adaptin"))
=======
(define-protein "AP4E1_HUMAN" ("AP-4 complex subunit epsilon-1" "AP-4 adaptor complex subunit epsilon" "Adaptor-related protein complex 4 subunit epsilon-1" "Epsilon subunit of AP-4" "Epsilon-adaptin"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "APAF_HUMAN" ("Apoptotic protease-activating factor 1" "APAF-1"))
(define-protein "APAF_HUMAN" ("procaspase-9" "Apoptotic protease-activating factor 1" "APAF-1"))
(define-protein "APC15_HUMAN" ("APC15" "ANAPC15" "C11orf51")) 
(define-protein "APC7_HUMAN" ("APC7" "ANAPC7")) 
(define-protein "APEX1_HUMAN" ("APEX1" "APE" "APE1" "APEX" "APX" "HAP1" "REF1")) 
<<<<<<< .mine
(define-protein "APLF_HUMAN" ("palf" "Aprataxin and PNK-like factor" "Apurinic-apyrimidinic endonuclease APLF" "PNK and APTX-like FHA domain-containing protein" "XRCC1-interacting protein 1"))
(define-protein "APOA1_HUMAN" ("apoA-I" "Apolipoprotein A-I" "Apo-AI" "ApoA-I" "Apolipoprotein A1"))
(define-protein "APOA2_HUMAN" ("apolipoproteins" "Apolipoprotein A-II" "Apo-AII" "ApoA-II" "Apolipoprotein A2"))
(define-protein "APOA5_HUMAN" ("apoav" "Apolipoprotein A-V" "Apo-AV" "ApoA-V" "Apolipoprotein A5" "Regeneration-associated protein 3"))
(define-protein "APOBR_HUMAN" ("antipeptide" "Apolipoprotein B receptor" "Apolipoprotein B-100 receptor" "Apolipoprotein B-48 receptor" "Apolipoprotein B48 receptor" "apoB-48R"))
(define-protein "APOC1_HUMAN" ("perhaps" "Apolipoprotein C-I" "Apo-CI" "ApoC-I" "Apolipoprotein C1"))
(define-protein "APRIO_HUMAN" ("homogenate" "Alternative prion protein" "AltPrP"))
(define-protein "APR_HUMAN" ("pma" "Phorbol-12-myristate-13-acetate-induced protein 1" "PMA-induced protein 1" "Immediate-early-response protein APR" "Protein Noxa"))
=======
<<<<<<< .mine
(define-protein "APLF_HUMAN" ("palf" "Aprataxin and PNK-like factor" "Apurinic-apyrimidinic endonuclease APLF" "PNK and APTX-like FHA domain-containing protein" "XRCC1-interacting protein 1"))
(define-protein "APOA1_HUMAN" ("apoA-I" "Apolipoprotein A-I" "Apo-AI" "ApoA-I" "Apolipoprotein A1"))
(define-protein "APOA2_HUMAN" ("apolipoproteins" "Apolipoprotein A-II" "Apo-AII" "ApoA-II" "Apolipoprotein A2"))
(define-protein "APOA5_HUMAN" ("apoav" "Apolipoprotein A-V" "Apo-AV" "ApoA-V" "Apolipoprotein A5" "Regeneration-associated protein 3"))
(define-protein "APOBR_HUMAN" ("antipeptide" "Apolipoprotein B receptor" "Apolipoprotein B-100 receptor" "Apolipoprotein B-48 receptor" "Apolipoprotein B48 receptor" "apoB-48R"))
(define-protein "APOC1_HUMAN" ("perhaps" "Apolipoprotein C-I" "Apo-CI" "ApoC-I" "Apolipoprotein C1"))
(define-protein "APRIO_HUMAN" ("homogenate" "Alternative prion protein" "AltPrP"))
(define-protein "APR_HUMAN" ("pma" "Phorbol-12-myristate-13-acetate-induced protein 1" "PMA-induced protein 1" "Immediate-early-response protein APR" "Protein Noxa"))
=======
(define-protein "APLF_HUMAN" ("Aprataxin and PNK-like factor" "Apurinic-apyrimidinic endonuclease APLF" "PNK and APTX-like FHA domain-containing protein" "XRCC1-interacting protein 1"))
(define-protein "APOA1_HUMAN" ("Apolipoprotein A-I" "Apo-AI" "ApoA-I" "Apolipoprotein A1"))
(define-protein "APOA2_HUMAN" ("Apolipoprotein A-II" "Apo-AII" "ApoA-II" "Apolipoprotein A2"))
(define-protein "APOA5_HUMAN" ("Apolipoprotein A-V" "Apo-AV" "ApoA-V" "Apolipoprotein A5" "Regeneration-associated protein 3"))
(define-protein "APOBR_HUMAN" ("Apolipoprotein B receptor" "Apolipoprotein B-100 receptor" "Apolipoprotein B-48 receptor" "Apolipoprotein B48 receptor" "apoB-48R"))
(define-protein "APOC1_HUMAN" ("Apolipoprotein C-I" "Apo-CI" "ApoC-I" "Apolipoprotein C1"))
(define-protein "APRIO_HUMAN" ("Alternative prion protein" "AltPrP"))
(define-protein "APR_HUMAN" ("Phorbol-12-myristate-13-acetate-induced protein 1" "PMA-induced protein 1" "Immediate-early-response protein APR" "Protein Noxa"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ARAP1_HUMAN" ("KIAA0782" "Centaurin-delta-2" "ARAP1" "Cnt-d2" "CENTD2")) 
(define-protein "ARBK1_HUMAN" ("Beta-adrenergic receptor kinase 1" "Beta-ARK-1" "G-protein coupled receptor kinase 2"))
<<<<<<< .mine
(define-protein "ARBK1_HUMAN" ("isoproterenol" "Beta-adrenergic receptor kinase 1" "Beta-ARK-1" "G-protein coupled receptor kinase 2"))
(define-protein "ARC1B_HUMAN" ("Arp2/3" "Actin-related protein 2/3 complex subunit 1B" "Arp2/3 complex 41 kDa subunit" "p41-ARC"))
(define-protein "AREG_HUMAN" ("areg" "Amphiregulin" "AR" "Colorectum cell-derived growth factor" "CRDGF"))
=======
<<<<<<< .mine
(define-protein "ARBK1_HUMAN" ("isoproterenol" "Beta-adrenergic receptor kinase 1" "Beta-ARK-1" "G-protein coupled receptor kinase 2"))
(define-protein "ARC1B_HUMAN" ("Arp2/3" "Actin-related protein 2/3 complex subunit 1B" "Arp2/3 complex 41 kDa subunit" "p41-ARC"))
(define-protein "AREG_HUMAN" ("areg" "Amphiregulin" "AR" "Colorectum cell-derived growth factor" "CRDGF"))
=======
(define-protein "ARC1B_HUMAN" ("Actin-related protein 2/3 complex subunit 1B" "Arp2/3 complex 41 kDa subunit" "p41-ARC"))
(define-protein "AREG_HUMAN" ("Amphiregulin" "AR" "Colorectum cell-derived growth factor" "CRDGF"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ARF3_HUMAN" ("ARF3")) 
<<<<<<< .mine
(define-protein "ARFG1_HUMAN" ("ArfGAP1" "ADP-ribosylation factor GTPase-activating protein 1" "ARF GAP 1" "ADP-ribosylation factor 1 GTPase-activating protein" "ARF1 GAP" "ARF1-directed GTPase-activating protein"))
=======
<<<<<<< .mine
(define-protein "ARFG1_HUMAN" ("ArfGAP1" "ADP-ribosylation factor GTPase-activating protein 1" "ARF GAP 1" "ADP-ribosylation factor 1 GTPase-activating protein" "ARF1 GAP" "ARF1-directed GTPase-activating protein"))
=======
(define-protein "ARFG1_HUMAN" ("ADP-ribosylation factor GTPase-activating protein 1" "ARF GAP 1" "ADP-ribosylation factor 1 GTPase-activating protein" "ARF1 GAP" "ARF1-directed GTPase-activating protein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ARFRP_HUMAN" ("ARP" "ARFRP1" "ARP1")) 
<<<<<<< .mine
(define-protein "ARF_HUMAN" ("p14Arf" "Tumor suppressor ARF" "Alternative reading frame" "ARF" "Cyclin-dependent kinase inhibitor 2A" "p14ARF"))
(define-protein "ARHG1_HUMAN" ("gα" "Rho guanine nucleotide exchange factor 1" "115 kDa guanine nucleotide exchange factor" "p115-RhoGEF" "p115RhoGEF" "Sub1.5"))
(define-protein "ARHG3_HUMAN" ("platelets" "Rho guanine nucleotide exchange factor 3" "Exchange factor found in platelets and leukemic and neuronal tissues" "XPLN"))
(define-protein "ARHG6_HUMAN" ("α-PIX" "Rho guanine nucleotide exchange factor 6" "Alpha-Pix" "COOL-2" "PAK-interacting exchange factor alpha" "Rac/Cdc42 guanine nucleotide exchange factor 6"))
(define-protein "ARHG7_HUMAN" ("βpix" "Rho guanine nucleotide exchange factor 7" "Beta-Pix" "COOL-1" "PAK-interacting exchange factor beta" "p85"))
=======
<<<<<<< .mine
(define-protein "ARF_HUMAN" ("p14Arf" "Tumor suppressor ARF" "Alternative reading frame" "ARF" "Cyclin-dependent kinase inhibitor 2A" "p14ARF"))
(define-protein "ARHG1_HUMAN" ("gα" "Rho guanine nucleotide exchange factor 1" "115 kDa guanine nucleotide exchange factor" "p115-RhoGEF" "p115RhoGEF" "Sub1.5"))
(define-protein "ARHG3_HUMAN" ("platelets" "Rho guanine nucleotide exchange factor 3" "Exchange factor found in platelets and leukemic and neuronal tissues" "XPLN"))
(define-protein "ARHG6_HUMAN" ("α-PIX" "Rho guanine nucleotide exchange factor 6" "Alpha-Pix" "COOL-2" "PAK-interacting exchange factor alpha" "Rac/Cdc42 guanine nucleotide exchange factor 6"))
(define-protein "ARHG7_HUMAN" ("βpix" "Rho guanine nucleotide exchange factor 7" "Beta-Pix" "COOL-1" "PAK-interacting exchange factor beta" "p85"))
=======
(define-protein "ARF_HUMAN" ("Tumor suppressor ARF" "Alternative reading frame" "ARF" "Cyclin-dependent kinase inhibitor 2A" "p14ARF"))
(define-protein "ARHG1_HUMAN" ("Rho guanine nucleotide exchange factor 1" "115 kDa guanine nucleotide exchange factor" "p115-RhoGEF" "p115RhoGEF" "Sub1.5"))
(define-protein "ARHG3_HUMAN" ("Rho guanine nucleotide exchange factor 3" "Exchange factor found in platelets and leukemic and neuronal tissues" "XPLN"))
(define-protein "ARHG6_HUMAN" ("Rho guanine nucleotide exchange factor 6" "Alpha-Pix" "COOL-2" "PAK-interacting exchange factor alpha" "Rac/Cdc42 guanine nucleotide exchange factor 6"))
(define-protein "ARHG7_HUMAN" ("Rho guanine nucleotide exchange factor 7" "Beta-Pix" "COOL-1" "PAK-interacting exchange factor beta" "p85"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ARHGQ_HUMAN" ("ARHGEF26" "SGEF")) 
<<<<<<< .mine
(define-protein "ARI1A_HUMAN" ("SWI1" "AT-rich interactive domain-containing protein 1A" "ARID domain-containing protein 1A" "B120" "BRG1-associated factor 250" "BAF250" "BRG1-associated factor 250a" "BAF250A" "Osa homolog 1" "hOSA1" "SWI-like protein" "SWI/SNF complex protein p270" "SWI/SNF-related, matrix-associated, actin-dependent regulator of chromatin subfamily F member 1" "hELD"))
=======
<<<<<<< .mine
(define-protein "ARI1A_HUMAN" ("SWI1" "AT-rich interactive domain-containing protein 1A" "ARID domain-containing protein 1A" "B120" "BRG1-associated factor 250" "BAF250" "BRG1-associated factor 250a" "BAF250A" "Osa homolog 1" "hOSA1" "SWI-like protein" "SWI/SNF complex protein p270" "SWI/SNF-related, matrix-associated, actin-dependent regulator of chromatin subfamily F member 1" "hELD"))
=======
(define-protein "ARI1A_HUMAN" ("AT-rich interactive domain-containing protein 1A" "ARID domain-containing protein 1A" "B120" "BRG1-associated factor 250" "BAF250" "BRG1-associated factor 250a" "BAF250A" "Osa homolog 1" "hOSA1" "SWI-like protein" "SWI/SNF complex protein p270" "SWI/SNF-related, matrix-associated, actin-dependent regulator of chromatin subfamily F member 1" "hELD"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ARL15_HUMAN" ("ARL15" "ARFRP2")) 
(define-protein "ARL1_HUMAN" ("ARL1")) 
(define-protein "ARL2_HUMAN" ("ARL2")) 
(define-protein "ARL5A_HUMAN" ("ARL5" "ARL5A" "ARFLP5")) 
(define-protein "ARL8A_HUMAN" ("GIE2" "ARL10B" "ARL8A")) 
(define-protein "ARL8B_HUMAN" ("ARL8B" "GIE1" "ARL10C")) 
(define-protein "ARP3_HUMAN" ("Actin-related protein 3" "Actin-like protein 3"))
(define-protein "ARRB1_HUMAN" ("Beta-arrestin-1" "Arrestin beta-1"))
<<<<<<< .mine
(define-protein "ARRB1_HUMAN" ("β-arrestin1" "Beta-arrestin-1" "Arrestin beta-1"))
(define-protein "ARRB2_HUMAN" ("Arrestin-2" "Beta-arrestin-2" "Arrestin beta-2"))
(define-protein "ARRC_HUMAN" ("arrestin-3" "Arrestin-C" "Cone arrestin" "C-arrestin" "cArr" "Retinal cone arrestin-3" "X-arrestin"))
=======
<<<<<<< .mine
(define-protein "ARRB1_HUMAN" ("β-arrestin1" "Beta-arrestin-1" "Arrestin beta-1"))
(define-protein "ARRB2_HUMAN" ("Arrestin-2" "Beta-arrestin-2" "Arrestin beta-2"))
(define-protein "ARRC_HUMAN" ("arrestin-3" "Arrestin-C" "Cone arrestin" "C-arrestin" "cArr" "Retinal cone arrestin-3" "X-arrestin"))
=======
(define-protein "ARRB2_HUMAN" ("Beta-arrestin-2" "Arrestin beta-2"))
(define-protein "ARRC_HUMAN" ("Arrestin-C" "Cone arrestin" "C-arrestin" "cArr" "Retinal cone arrestin-3" "X-arrestin"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ARRD3_HUMAN" ("Arrestin domain-containing protein 3" "TBP-2-like inducible membrane protein" "TLIMP"))
<<<<<<< .mine
(define-protein "ARVC_HUMAN" ("arvcf" "Armadillo repeat protein deleted in velo-cardio-facial syndrome"))
=======
<<<<<<< .mine
(define-protein "ARVC_HUMAN" ("arvcf" "Armadillo repeat protein deleted in velo-cardio-facial syndrome"))
=======
(define-protein "ARVC_HUMAN" ("Armadillo repeat protein deleted in velo-cardio-facial syndrome"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ASAH1_HUMAN" ("ASAH" "ACDase" "PHP32" "AC" "ASAH1")) 
<<<<<<< .mine
(define-protein "ASAP1_HUMAN" ("Arf-1" "Arf-GAP with SH3 domain, ANK repeat and PH domain-containing protein 1" "130 kDa phosphatidylinositol 4,5-bisphosphate-dependent ARF1 GTPase-activating protein" "ADP-ribosylation factor-directed GTPase-activating protein 1" "ARF GTPase-activating protein 1" "Development and differentiation-enhancing factor 1" "DEF-1" "Differentiation-enhancing factor 1" "PIP2-dependent ARF1 GAP"))
(define-protein "ASCC3_HUMAN" ("p200" "Activating signal cointegrator 1 complex subunit 3" "ASC-1 complex subunit p200" "ASC1p200" "Helicase, ATP binding 1" "Trip4 complex subunit p200"))
=======
<<<<<<< .mine
(define-protein "ASAP1_HUMAN" ("Arf-1" "Arf-GAP with SH3 domain, ANK repeat and PH domain-containing protein 1" "130 kDa phosphatidylinositol 4,5-bisphosphate-dependent ARF1 GTPase-activating protein" "ADP-ribosylation factor-directed GTPase-activating protein 1" "ARF GTPase-activating protein 1" "Development and differentiation-enhancing factor 1" "DEF-1" "Differentiation-enhancing factor 1" "PIP2-dependent ARF1 GAP"))
(define-protein "ASCC3_HUMAN" ("p200" "Activating signal cointegrator 1 complex subunit 3" "ASC-1 complex subunit p200" "ASC1p200" "Helicase, ATP binding 1" "Trip4 complex subunit p200"))
=======
(define-protein "ASAP1_HUMAN" ("Arf-GAP with SH3 domain, ANK repeat and PH domain-containing protein 1" "130 kDa phosphatidylinositol 4,5-bisphosphate-dependent ARF1 GTPase-activating protein" "ADP-ribosylation factor-directed GTPase-activating protein 1" "ARF GTPase-activating protein 1" "Development and differentiation-enhancing factor 1" "DEF-1" "Differentiation-enhancing factor 1" "PIP2-dependent ARF1 GAP"))
(define-protein "ASCC3_HUMAN" ("Activating signal cointegrator 1 complex subunit 3" "ASC-1 complex subunit p200" "ASC1p200" "Helicase, ATP binding 1" "Trip4 complex subunit p200"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ASNA_HUMAN" ("ARSA" "hASNA-I" "TRC40" "hARSA-I" "ASNA1")) 
(define-protein "ASPC1_HUMAN" ("RCC17" "ASPL" "UBXN9" "UBXD9" "TUG" "ASPSCR1")) 
<<<<<<< .mine
(define-protein "ASPH_HUMAN" ("asparaginyl" "Aspartyl/asparaginyl beta-hydroxylase" "Aspartate beta-hydroxylase" "ASP beta-hydroxylase" "Peptide-aspartate beta-dioxygenase"))
(define-protein "ASPN_HUMAN" ("aspn" "Asporin" "Periodontal ligament-associated protein 1" "PLAP-1"))
(define-protein "ASTL_HUMAN" ("BB94" "Astacin-like metalloendopeptidase" "Oocyte astacin" "Ovastacin"))
=======
<<<<<<< .mine
(define-protein "ASPH_HUMAN" ("asparaginyl" "Aspartyl/asparaginyl beta-hydroxylase" "Aspartate beta-hydroxylase" "ASP beta-hydroxylase" "Peptide-aspartate beta-dioxygenase"))
(define-protein "ASPN_HUMAN" ("aspn" "Asporin" "Periodontal ligament-associated protein 1" "PLAP-1"))
(define-protein "ASTL_HUMAN" ("BB94" "Astacin-like metalloendopeptidase" "Oocyte astacin" "Ovastacin"))
=======
(define-protein "ASPH_HUMAN" ("Aspartyl/asparaginyl beta-hydroxylase" "Aspartate beta-hydroxylase" "ASP beta-hydroxylase" "Peptide-aspartate beta-dioxygenase"))
(define-protein "ASPN_HUMAN" ("Asporin" "Periodontal ligament-associated protein 1" "PLAP-1"))
(define-protein "ASTL_HUMAN" ("Astacin-like metalloendopeptidase" "Oocyte astacin" "Ovastacin"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ASXL1_HUMAN" ("ASXL1" "KIAA0978")) 
<<<<<<< .mine
(define-protein "AT1A1_HUMAN" ("α1-subunit" "Sodium/potassium-transporting ATPase subunit alpha-1" "Na(+)/K(+) ATPase alpha-1 subunit" "Sodium pump subunit alpha-1"))
=======
<<<<<<< .mine
(define-protein "AT1A1_HUMAN" ("α1-subunit" "Sodium/potassium-transporting ATPase subunit alpha-1" "Na(+)/K(+) ATPase alpha-1 subunit" "Sodium pump subunit alpha-1"))
=======
(define-protein "AT1A1_HUMAN" ("Sodium/potassium-transporting ATPase subunit alpha-1" "Na(+)/K(+) ATPase alpha-1 subunit" "Sodium pump subunit alpha-1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "AT1B3_HUMAN" ("CD298" "ATP1B3" "ATPB-3")) 
<<<<<<< .mine
(define-protein "ATAD2_HUMAN" ("5-FU" "ATPase family AAA domain-containing protein 2" "AAA nuclear coregulator cancer-associated protein" "ANCCA"))
=======
<<<<<<< .mine
(define-protein "ATAD2_HUMAN" ("5-FU" "ATPase family AAA domain-containing protein 2" "AAA nuclear coregulator cancer-associated protein" "ANCCA"))
=======
(define-protein "ATAD2_HUMAN" ("ATPase family AAA domain-containing protein 2" "AAA nuclear coregulator cancer-associated protein" "ANCCA"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ATF2_HUMAN" ("Cyclic AMP-dependent transcription factor ATF-2" "cAMP-dependent transcription factor ATF-2" "Activating transcription factor 2" "Cyclic AMP-responsive element-binding protein 2" "CREB-2" "cAMP-responsive element-binding protein 2" "HB16" "Histone acetyltransferase ATF2" "cAMP response element-binding protein CRE-BP1"))
<<<<<<< .mine
(define-protein "ATF2_HUMAN" ("cre" "Cyclic AMP-dependent transcription factor ATF-2" "cAMP-dependent transcription factor ATF-2" "Activating transcription factor 2" "Cyclic AMP-responsive element-binding protein 2" "CREB-2" "cAMP-responsive element-binding protein 2" "HB16" "Histone acetyltransferase ATF2" "cAMP response element-binding protein CRE-BP1"))
(define-protein "ATG12_HUMAN" ("Atg12" "Ubiquitin-like protein ATG12" "Autophagy-related protein 12" "APG12-like"))
=======
<<<<<<< .mine
(define-protein "ATF2_HUMAN" ("cre" "Cyclic AMP-dependent transcription factor ATF-2" "cAMP-dependent transcription factor ATF-2" "Activating transcription factor 2" "Cyclic AMP-responsive element-binding protein 2" "CREB-2" "cAMP-responsive element-binding protein 2" "HB16" "Histone acetyltransferase ATF2" "cAMP response element-binding protein CRE-BP1"))
(define-protein "ATG12_HUMAN" ("Atg12" "Ubiquitin-like protein ATG12" "Autophagy-related protein 12" "APG12-like"))
=======
(define-protein "ATG12_HUMAN" ("Ubiquitin-like protein ATG12" "Autophagy-related protein 12" "APG12-like"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ATG13_HUMAN" ("Autophagy-related protein 13"))
(define-protein "ATG3_HUMAN" ("APG3-like" "hApg3" "ATG3" "APG3" "APG3L")) 
(define-protein "ATG5_HUMAN" ("APG5L" "ATG5" "APG5-like" "ASP")) 
(define-protein "ATG7_HUMAN" ("hAGP7" "ATG7" "APG7-like" "APG7L")) 
(define-protein "ATM_HUMAN" ("ATM")) 
<<<<<<< .mine
(define-protein "ATN1_HUMAN" ("atrophin-1" "Atrophin-1" "Dentatorubral-pallidoluysian atrophy protein"))
(define-protein "ATPA_HUMAN" ("·ATP" "ATP synthase subunit alpha, mitochondrial"))
(define-protein "ATRIP_HUMAN" ("·ATRIP" "ATR-interacting protein" "ATM and Rad3-related-interacting protein"))
(define-protein "ATR_HUMAN" ("wortmannin" "Serine/threonine-protein kinase ATR" "Ataxia telangiectasia and Rad3-related protein" "FRAP-related protein 1"))
(define-protein "ATS2_HUMAN" ("TS2" "A disintegrin and metalloproteinase with thrombospondin motifs 2" "ADAM-TS 2" "ADAM-TS2" "ADAMTS-2" "Procollagen I N-proteinase" "PC I-NP" "Procollagen I/II amino propeptide-processing enzyme" "Procollagen N-endopeptidase" "pNPI"))
(define-protein "ATX3_HUMAN" ("Ataxin-3" "Machado-Joseph disease protein 1" "Spinocerebellar ataxia type 3 protein"))
(define-protein "AUHM_HUMAN" ("auh" "Methylglutaconyl-CoA hydratase, mitochondrial" "AU-specific RNA-binding enoyl-CoA hydratase" "AU-binding protein/enoyl-CoA hydratase"))
=======
<<<<<<< .mine
(define-protein "ATN1_HUMAN" ("atrophin-1" "Atrophin-1" "Dentatorubral-pallidoluysian atrophy protein"))
(define-protein "ATPA_HUMAN" ("·ATP" "ATP synthase subunit alpha, mitochondrial"))
(define-protein "ATRIP_HUMAN" ("·ATRIP" "ATR-interacting protein" "ATM and Rad3-related-interacting protein"))
(define-protein "ATR_HUMAN" ("wortmannin" "Serine/threonine-protein kinase ATR" "Ataxia telangiectasia and Rad3-related protein" "FRAP-related protein 1"))
(define-protein "ATS2_HUMAN" ("TS2" "A disintegrin and metalloproteinase with thrombospondin motifs 2" "ADAM-TS 2" "ADAM-TS2" "ADAMTS-2" "Procollagen I N-proteinase" "PC I-NP" "Procollagen I/II amino propeptide-processing enzyme" "Procollagen N-endopeptidase" "pNPI"))
(define-protein "ATX3_HUMAN" ("Ataxin-3" "Machado-Joseph disease protein 1" "Spinocerebellar ataxia type 3 protein"))
(define-protein "AUHM_HUMAN" ("auh" "Methylglutaconyl-CoA hydratase, mitochondrial" "AU-specific RNA-binding enoyl-CoA hydratase" "AU-binding protein/enoyl-CoA hydratase"))
=======
(define-protein "ATN1_HUMAN" ("Atrophin-1" "Dentatorubral-pallidoluysian atrophy protein"))
(define-protein "ATPA_HUMAN" ("ATP synthase subunit alpha, mitochondrial"))
(define-protein "ATRIP_HUMAN" ("ATR-interacting protein" "ATM and Rad3-related-interacting protein"))
(define-protein "ATR_HUMAN" ("Serine/threonine-protein kinase ATR" "Ataxia telangiectasia and Rad3-related protein" "FRAP-related protein 1"))
(define-protein "ATS2_HUMAN" ("A disintegrin and metalloproteinase with thrombospondin motifs 2" "ADAM-TS 2" "ADAM-TS2" "ADAMTS-2" "Procollagen I N-proteinase" "PC I-NP" "Procollagen I/II amino propeptide-processing enzyme" "Procollagen N-endopeptidase" "pNPI"))
(define-protein "ATX3_HUMAN" ("Ataxin-3" "Machado-Joseph disease protein 1" "Spinocerebellar ataxia type 3 protein"))
(define-protein "AUHM_HUMAN" ("Methylglutaconyl-CoA hydratase, mitochondrial" "AU-specific RNA-binding enoyl-CoA hydratase" "AU-binding protein/enoyl-CoA hydratase"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "AURKA_HUMAN" ("AYK1" "ARK-1" "STK6" "AURA" "AURKA" "AIK" "IAK1" "AIRK1" "ARK1" "hARK1" "STK15" "BTAK")) 
<<<<<<< .mine
(define-protein "AURKB_HUMAN" ("Aurora-B" "Aurora kinase B" "Aurora 1" "Aurora- and IPL1-like midbody-associated protein 1" "AIM-1" "Aurora/IPL1-related kinase 2" "ARK-2" "Aurora-related kinase 2" "STK-1" "Serine/threonine-protein kinase 12" "Serine/threonine-protein kinase 5" "Serine/threonine-protein kinase aurora-B"))
(define-protein "AVEN_HUMAN" ("aven" "Cell death regulator Aven"))
(define-protein "AXIN1_HUMAN" ("Axin–" "Axin-1" "Axis inhibition protein 1" "hAxin"))
(define-protein "AXIN2_HUMAN" ("Axin2" "Axin-2" "Axin-like protein" "Axil" "Axis inhibition protein 2" "Conductin"))
(define-protein "AZIN1_HUMAN" ("antizyme" "Antizyme inhibitor 1" "AZI" "Ornithine decarboxylase antizyme inhibitor"))
(define-protein "B0ZG58_9HIV1" ("C62" "Protein Nef"))
(define-protein "B1_HHV6Z" ("B1" "Protein B1"))
=======
<<<<<<< .mine
(define-protein "AURKB_HUMAN" ("Aurora-B" "Aurora kinase B" "Aurora 1" "Aurora- and IPL1-like midbody-associated protein 1" "AIM-1" "Aurora/IPL1-related kinase 2" "ARK-2" "Aurora-related kinase 2" "STK-1" "Serine/threonine-protein kinase 12" "Serine/threonine-protein kinase 5" "Serine/threonine-protein kinase aurora-B"))
(define-protein "AVEN_HUMAN" ("aven" "Cell death regulator Aven"))
(define-protein "AXIN1_HUMAN" ("Axin–" "Axin-1" "Axis inhibition protein 1" "hAxin"))
(define-protein "AXIN2_HUMAN" ("Axin2" "Axin-2" "Axin-like protein" "Axil" "Axis inhibition protein 2" "Conductin"))
(define-protein "AZIN1_HUMAN" ("antizyme" "Antizyme inhibitor 1" "AZI" "Ornithine decarboxylase antizyme inhibitor"))
(define-protein "B0ZG58_9HIV1" ("C62" "Protein Nef"))
(define-protein "B1_HHV6Z" ("B1" "Protein B1"))
=======
(define-protein "AURKB_HUMAN" ("Aurora kinase B" "Aurora 1" "Aurora- and IPL1-like midbody-associated protein 1" "AIM-1" "Aurora/IPL1-related kinase 2" "ARK-2" "Aurora-related kinase 2" "STK-1" "Serine/threonine-protein kinase 12" "Serine/threonine-protein kinase 5" "Serine/threonine-protein kinase aurora-B"))
(define-protein "AVEN_HUMAN" ("Cell death regulator Aven"))
(define-protein "AXIN1_HUMAN" ("Axin-1" "Axis inhibition protein 1" "hAxin"))
(define-protein "AXIN2_HUMAN" ("Axin-2" "Axin-like protein" "Axil" "Axis inhibition protein 2" "Conductin"))
(define-protein "AZIN1_HUMAN" ("Antizyme inhibitor 1" "AZI" "Ornithine decarboxylase antizyme inhibitor"))
(define-protein "B0ZG58_9HIV1" ("Protein Nef"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "B1_HHV6Z" ("Protein B1"))
<<<<<<< .mine
(define-protein "B2L11_HUMAN" ("bim" "Bcl-2-like protein 11" "Bcl2-L-11" "Bcl2-interacting mediator of cell death"))
(define-protein "B2LA1_HUMAN" ("Bfl-1" "Bcl-2-related protein A1" "Bcl-2-like protein 5" "Bcl2-L-5" "Hemopoietic-specific early response protein" "Protein BFL-1" "Protein GRS"))
(define-protein "B2_HHV6Z" ("B2" "Protein B2"))
=======
<<<<<<< .mine
(define-protein "B2L11_HUMAN" ("bim" "Bcl-2-like protein 11" "Bcl2-L-11" "Bcl2-interacting mediator of cell death"))
(define-protein "B2LA1_HUMAN" ("Bfl-1" "Bcl-2-related protein A1" "Bcl-2-like protein 5" "Bcl2-L-5" "Hemopoietic-specific early response protein" "Protein BFL-1" "Protein GRS"))
(define-protein "B2_HHV6Z" ("B2" "Protein B2"))
=======
(define-protein "B2L11_HUMAN" ("Bcl-2-like protein 11" "Bcl2-L-11" "Bcl2-interacting mediator of cell death"))
(define-protein "B2LA1_HUMAN" ("Bcl-2-related protein A1" "Bcl-2-like protein 5" "Bcl2-L-5" "Hemopoietic-specific early response protein" "Protein BFL-1" "Protein GRS"))
(define-protein "B2_HHV6Z" ("Protein B2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "B3GA3_HUMAN" ("GlcUAT-I" "GlcAT-I" "B3GAT3")) 
(define-protein "B3GN3_HUMAN" ("N-acetyllactosaminide beta-1,3-N-acetylglucosaminyltransferase 3" "Beta-1,3-galactosyl-O-glycosyl-glycoprotein beta-1,3-N-acetylglucosaminyltransferase" "Beta-1,3-galactosyltransferase 8" "Beta-1,3-GalTase 8" "Beta3Gal-T8" "Beta3GalT8" "b3Gal-T8" "Beta-3-Gx-T8" "Core 1 extending beta-1,3-N-acetylglucosaminyltransferase" "Core1-beta3GlcNAcT" "Transmembrane protein 3" "UDP-Gal:beta-GlcNAc beta-1,3-galactosyltransferase 8" "UDP-GlcNAc:betaGal beta-1,3-N-acetylglucosaminyltransferase 3" "BGnT-3" "Beta-1,3-Gn-T3" "Beta-1,3-N-acetylglucosaminyltransferase 3" "Beta3Gn-T3" "UDP-galactose:beta-N-acetylglucosamine beta-1,3-galactosyltransferase 8"))
<<<<<<< .mine
(define-protein "B3GN3_HUMAN" ("β1" "N-acetyllactosaminide beta-1,3-N-acetylglucosaminyltransferase 3" "Beta-1,3-galactosyl-O-glycosyl-glycoprotein beta-1,3-N-acetylglucosaminyltransferase" "Beta-1,3-galactosyltransferase 8" "Beta-1,3-GalTase 8" "Beta3Gal-T8" "Beta3GalT8" "b3Gal-T8" "Beta-3-Gx-T8" "Core 1 extending beta-1,3-N-acetylglucosaminyltransferase" "Core1-beta3GlcNAcT" "Transmembrane protein 3" "UDP-Gal:beta-GlcNAc beta-1,3-galactosyltransferase 8" "UDP-GlcNAc:betaGal beta-1,3-N-acetylglucosaminyltransferase 3" "BGnT-3" "Beta-1,3-Gn-T3" "Beta-1,3-N-acetylglucosaminyltransferase 3" "Beta3Gn-T3" "UDP-galactose:beta-N-acetylglucosamine beta-1,3-galactosyltransferase 8"))
(define-protein "B3KRT9_HUMAN" ("mSin3a" "cDNA FLJ34915 fis, clone NT2RP7001283, highly similar to Homo sapiens mSin3A-associated protein 130 (SAP130), mRNA"))
(define-protein "B3_HHV6Z" ("B3" "Protein B3"))
=======
<<<<<<< .mine
(define-protein "B3GN3_HUMAN" ("β1" "N-acetyllactosaminide beta-1,3-N-acetylglucosaminyltransferase 3" "Beta-1,3-galactosyl-O-glycosyl-glycoprotein beta-1,3-N-acetylglucosaminyltransferase" "Beta-1,3-galactosyltransferase 8" "Beta-1,3-GalTase 8" "Beta3Gal-T8" "Beta3GalT8" "b3Gal-T8" "Beta-3-Gx-T8" "Core 1 extending beta-1,3-N-acetylglucosaminyltransferase" "Core1-beta3GlcNAcT" "Transmembrane protein 3" "UDP-Gal:beta-GlcNAc beta-1,3-galactosyltransferase 8" "UDP-GlcNAc:betaGal beta-1,3-N-acetylglucosaminyltransferase 3" "BGnT-3" "Beta-1,3-Gn-T3" "Beta-1,3-N-acetylglucosaminyltransferase 3" "Beta3Gn-T3" "UDP-galactose:beta-N-acetylglucosamine beta-1,3-galactosyltransferase 8"))
(define-protein "B3KRT9_HUMAN" ("mSin3a" "cDNA FLJ34915 fis, clone NT2RP7001283, highly similar to Homo sapiens mSin3A-associated protein 130 (SAP130), mRNA"))
(define-protein "B3_HHV6Z" ("B3" "Protein B3"))
=======
(define-protein "B3KRT9_HUMAN" ("cDNA FLJ34915 fis, clone NT2RP7001283, highly similar to Homo sapiens mSin3A-associated protein 130 (SAP130), mRNA"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "B3_HHV6Z" ("Protein B3"))
(define-protein "B4DLR8_HUMAN" ("NAD(P)H dehydrogenase [quinone] 1" "cDNA FLJ50573, highly similar to Homo sapiens NAD(P)H dehydrogenase, quinone 1 (NQO1), transcript variant 3, mRNA"))
<<<<<<< .mine
(define-protein "B4DLR8_HUMAN" ("Nqo1" "NAD(P)H dehydrogenase [quinone] 1" "cDNA FLJ50573, highly similar to Homo sapiens NAD(P)H dehydrogenase, quinone 1 (NQO1), transcript variant 3, mRNA"))
(define-protein "B4DRY8_HUMAN" ("3-NT" "cDNA FLJ56788, moderately similar to Mus musculus 5'-nucleotidase domain containing 3 (Nt5dc3), transcript variant 2, mRNA"))
(define-protein "B5MC53_HUMAN" ("transgene" "MpV17 transgene, murine homolog, glomerulosclerosis, isoform CRA_f" "Protein Mpv17"))
(define-protein "B5TKC2_HUMAN" ("gyrus" "Estrogen receptor alpha cingulate gyrus isoform"))
(define-protein "B7TEU4_9HIV1" ("pS170" "Pol protein"))
(define-protein "B7TEZ7_9HIV1" ("pS368" "Pol protein"))
(define-protein "B7ZA85_HUMAN" ("Brca1" "Breast cancer type 1 susceptibility protein" "cDNA, FLJ79099, highly similar to Homo sapiens breast cancer 1, early onset (BRCA1), transcript variant BRCA1-delta 11b, mRNA"))
=======
<<<<<<< .mine
(define-protein "B4DLR8_HUMAN" ("Nqo1" "NAD(P)H dehydrogenase [quinone] 1" "cDNA FLJ50573, highly similar to Homo sapiens NAD(P)H dehydrogenase, quinone 1 (NQO1), transcript variant 3, mRNA"))
(define-protein "B4DRY8_HUMAN" ("3-NT" "cDNA FLJ56788, moderately similar to Mus musculus 5'-nucleotidase domain containing 3 (Nt5dc3), transcript variant 2, mRNA"))
(define-protein "B5MC53_HUMAN" ("transgene" "MpV17 transgene, murine homolog, glomerulosclerosis, isoform CRA_f" "Protein Mpv17"))
(define-protein "B5TKC2_HUMAN" ("gyrus" "Estrogen receptor alpha cingulate gyrus isoform"))
(define-protein "B7TEU4_9HIV1" ("pS170" "Pol protein"))
(define-protein "B7TEZ7_9HIV1" ("pS368" "Pol protein"))
(define-protein "B7ZA85_HUMAN" ("Brca1" "Breast cancer type 1 susceptibility protein" "cDNA, FLJ79099, highly similar to Homo sapiens breast cancer 1, early onset (BRCA1), transcript variant BRCA1-delta 11b, mRNA"))
=======
(define-protein "B4DRY8_HUMAN" ("cDNA FLJ56788, moderately similar to Mus musculus 5'-nucleotidase domain containing 3 (Nt5dc3), transcript variant 2, mRNA"))
(define-protein "B5MC53_HUMAN" ("MpV17 transgene, murine homolog, glomerulosclerosis, isoform CRA_f" "Protein Mpv17"))
(define-protein "B5TKC2_HUMAN" ("Estrogen receptor alpha cingulate gyrus isoform"))
(define-protein "B7TEU4_9HIV1" ("Pol protein"))
(define-protein "B7TEZ7_9HIV1" ("Pol protein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "B7ZA85_HUMAN" ("Breast cancer type 1 susceptibility protein" "cDNA, FLJ79099, highly similar to Homo sapiens breast cancer 1, early onset (BRCA1), transcript variant BRCA1-delta 11b, mRNA"))
<<<<<<< .mine
(define-protein "B8YNW1_HUMAN" ("HNF-1α" "Hepatocyte nuclear factor 1 alpha"))
=======
<<<<<<< .mine
(define-protein "B8YNW1_HUMAN" ("HNF-1α" "Hepatocyte nuclear factor 1 alpha"))
=======
(define-protein "B8YNW1_HUMAN" ("Hepatocyte nuclear factor 1 alpha"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "B9TX31_HUMAN" ("Mediator complex subunit MED25 variant MED25_i4" "Mediator of RNA polymerase II transcription subunit 25"))
(define-protein "BACH1_HUMAN" ("BACH-1" "Transcription regulator protein BACH1" "BTB and CNC homolog 1" "HA2303"))
(define-protein "BACH1_HUMAN" ("Transcription regulator protein BACH1" "BTB and CNC homolog 1" "HA2303"))
<<<<<<< .mine
(define-protein "BAD_HUMAN" ("bcl-xL" "Bcl2-associated agonist of cell death" "BAD" "Bcl-2-binding component 6" "Bcl-2-like protein 8" "Bcl2-L-8" "Bcl-xL/Bcl-2-associated death promoter" "Bcl2 antagonist of cell death"))
=======
<<<<<<< .mine
(define-protein "BAD_HUMAN" ("bcl-xL" "Bcl2-associated agonist of cell death" "BAD" "Bcl-2-binding component 6" "Bcl-2-like protein 8" "Bcl2-L-8" "Bcl-xL/Bcl-2-associated death promoter" "Bcl2 antagonist of cell death"))
=======
(define-protein "BAD_HUMAN" ("Bcl2-associated agonist of cell death" "BAD" "Bcl-2-binding component 6" "Bcl-2-like protein 8" "Bcl2-L-8" "Bcl-xL/Bcl-2-associated death promoter" "Bcl2 antagonist of cell death"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "BAIP2_HUMAN" ("IRS-58" "BAIAP2" "FLAF3" "IRSp53/58" "IRSp53")) 
<<<<<<< .mine
(define-protein "BAKOR_HUMAN" ("ATG14L" "Beclin 1-associated autophagy-related key regulator" "Barkor" "Autophagy-related protein 14-like protein" "Atg14L"))
(define-protein "BAK_HUMAN" ("bak" "Bcl-2 homologous antagonist/killer" "Apoptosis regulator BAK" "Bcl-2-like protein 7" "Bcl2-L-7"))
=======
<<<<<<< .mine
(define-protein "BAKOR_HUMAN" ("ATG14L" "Beclin 1-associated autophagy-related key regulator" "Barkor" "Autophagy-related protein 14-like protein" "Atg14L"))
(define-protein "BAK_HUMAN" ("bak" "Bcl-2 homologous antagonist/killer" "Apoptosis regulator BAK" "Bcl-2-like protein 7" "Bcl2-L-7"))
=======
(define-protein "BAKOR_HUMAN" ("Beclin 1-associated autophagy-related key regulator" "Barkor" "Autophagy-related protein 14-like protein" "Atg14L"))
(define-protein "BAK_HUMAN" ("Bcl-2 homologous antagonist/killer" "Apoptosis regulator BAK" "Bcl-2-like protein 7" "Bcl2-L-7"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "BAP29_HUMAN" ("BCAP29" "BAP29" "Bap29")) 
(define-protein "BAP31_HUMAN" ("BCAP31" "Bap31" "p28" "DXS1357E" "BAP31")) 
(define-protein "BAZ1A_HUMAN" ("hACF1" "ACF1" "WCRF180" "hWALp1" "BAZ1A")) 
(define-protein "BAZ1B_HUMAN" ("WBSCR10" "hWALp2" "WBSCR9" "WBSC10" "BAZ1B" "WSTF")) 
(define-protein "BBS4_HUMAN" ("Bardet-Biedl syndrome 4 protein"))
<<<<<<< .mine
(define-protein "BCAP_HUMAN" ("phosphoinositide" "Phosphoinositide 3-kinase adapter protein 1" "B-cell adapter for phosphoinositide 3-kinase" "B-cell phosphoinositide 3-kinase adapter protein 1"))
=======
<<<<<<< .mine
(define-protein "BCAP_HUMAN" ("phosphoinositide" "Phosphoinositide 3-kinase adapter protein 1" "B-cell adapter for phosphoinositide 3-kinase" "B-cell phosphoinositide 3-kinase adapter protein 1"))
=======
(define-protein "BCAP_HUMAN" ("Phosphoinositide 3-kinase adapter protein 1" "B-cell adapter for phosphoinositide 3-kinase" "B-cell phosphoinositide 3-kinase adapter protein 1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "BCCIP_HUMAN" ("TOK1" "BCCIP")) 
<<<<<<< .mine
(define-protein "BCL10_HUMAN" ("Bcl-x" "B-cell lymphoma/leukemia 10" "B-cell CLL/lymphoma 10" "Bcl-10" "CARD-containing molecule enhancing NF-kappa-B" "CARD-like apoptotic protein" "hCLAP" "CED-3/ICH-1 prodomain homologous E10-like regulator" "CIPER" "Cellular homolog of vCARMEN" "cCARMEN" "Cellular-E10" "c-E10" "Mammalian CARD-containing adapter molecule E10" "mE10"))
=======
<<<<<<< .mine
(define-protein "BCL10_HUMAN" ("Bcl-x" "B-cell lymphoma/leukemia 10" "B-cell CLL/lymphoma 10" "Bcl-10" "CARD-containing molecule enhancing NF-kappa-B" "CARD-like apoptotic protein" "hCLAP" "CED-3/ICH-1 prodomain homologous E10-like regulator" "CIPER" "Cellular homolog of vCARMEN" "cCARMEN" "Cellular-E10" "c-E10" "Mammalian CARD-containing adapter molecule E10" "mE10"))
=======
(define-protein "BCL10_HUMAN" ("B-cell lymphoma/leukemia 10" "B-cell CLL/lymphoma 10" "Bcl-10" "CARD-containing molecule enhancing NF-kappa-B" "CARD-like apoptotic protein" "hCLAP" "CED-3/ICH-1 prodomain homologous E10-like regulator" "CIPER" "Cellular homolog of vCARMEN" "cCARMEN" "Cellular-E10" "c-E10" "Mammalian CARD-containing adapter molecule E10" "mE10"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "BCL2_HUMAN" ("Apoptosis regulator Bcl-2"))
(define-protein "BCL2_HUMAN" ("BCL2" "Bcl2")) 
(define-protein "BCL6_HUMAN" ("B-cell lymphoma 6 protein" "BCL-6" "B-cell lymphoma 5 protein" "BCL-5" "Protein LAZ-3" "Zinc finger and BTB domain-containing protein 27" "Zinc finger protein 51"))
<<<<<<< .mine
(define-protein "BCL6_HUMAN" ("corepressors" "B-cell lymphoma 6 protein" "BCL-6" "B-cell lymphoma 5 protein" "BCL-5" "Protein LAZ-3" "Zinc finger and BTB domain-containing protein 27" "Zinc finger protein 51"))
(define-protein "BCLF1_HUMAN" ("btf" "Bcl-2-associated transcription factor 1" "Btf"))
=======
<<<<<<< .mine
(define-protein "BCL6_HUMAN" ("corepressors" "B-cell lymphoma 6 protein" "BCL-6" "B-cell lymphoma 5 protein" "BCL-5" "Protein LAZ-3" "Zinc finger and BTB domain-containing protein 27" "Zinc finger protein 51"))
(define-protein "BCLF1_HUMAN" ("btf" "Bcl-2-associated transcription factor 1" "Btf"))
=======
(define-protein "BCLF1_HUMAN" ("Bcl-2-associated transcription factor 1" "Btf"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "BET1_HUMAN" ("hBET1" "BET1")) 
<<<<<<< .mine
(define-protein "BEX2_HUMAN" ("Bex2" "Protein BEX2" "Brain-expressed X-linked protein 2" "hBex2"))
(define-protein "BHE40_HUMAN" ("chondrocytes" "Class E basic helix-loop-helix protein 40" "bHLHe40" "Class B basic helix-loop-helix protein 2" "bHLHb2" "Differentially expressed in chondrocytes protein 1" "DEC1" "Enhancer-of-split and hairy-related protein 2" "SHARP-2" "Stimulated by retinoic acid gene 13 protein"))
(define-protein "BID_HUMAN" ("P11" "BH3-interacting domain death agonist" "p22 BID" "BID"))
=======
<<<<<<< .mine
(define-protein "BEX2_HUMAN" ("Bex2" "Protein BEX2" "Brain-expressed X-linked protein 2" "hBex2"))
(define-protein "BHE40_HUMAN" ("chondrocytes" "Class E basic helix-loop-helix protein 40" "bHLHe40" "Class B basic helix-loop-helix protein 2" "bHLHb2" "Differentially expressed in chondrocytes protein 1" "DEC1" "Enhancer-of-split and hairy-related protein 2" "SHARP-2" "Stimulated by retinoic acid gene 13 protein"))
(define-protein "BID_HUMAN" ("P11" "BH3-interacting domain death agonist" "p22 BID" "BID"))
=======
(define-protein "BEX2_HUMAN" ("Protein BEX2" "Brain-expressed X-linked protein 2" "hBex2"))
(define-protein "BHE40_HUMAN" ("Class E basic helix-loop-helix protein 40" "bHLHe40" "Class B basic helix-loop-helix protein 2" "bHLHb2" "Differentially expressed in chondrocytes protein 1" "DEC1" "Enhancer-of-split and hairy-related protein 2" "SHARP-2" "Stimulated by retinoic acid gene 13 protein"))
(define-protein "BID_HUMAN" ("BH3-interacting domain death agonist" "p22 BID" "BID"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "BIG1_HUMAN" ("ARFGEF1" "ARFGEP1" "BIG1")) 
(define-protein "BIG2_HUMAN" ("ARFGEF2" "ARFGEP2" "BIG2")) 
<<<<<<< .mine
(define-protein "BIG3_HUMAN" ("ARF-GEFs" "Brefeldin A-inhibited guanine nucleotide-exchange protein 3"))
=======
<<<<<<< .mine
(define-protein "BIG3_HUMAN" ("ARF-GEFs" "Brefeldin A-inhibited guanine nucleotide-exchange protein 3"))
=======
(define-protein "BIG3_HUMAN" ("Brefeldin A-inhibited guanine nucleotide-exchange protein 3"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "BIN1_HUMAN" ("AMPHL" "BIN1")) 
(define-protein "BIRC2_HUMAN" ("Baculoviral IAP repeat-containing protein 2" "C-IAP1" "IAP homolog B" "Inhibitor of apoptosis protein 2" "IAP-2" "hIAP-2" "hIAP2" "RING finger protein 48" "TNFR2-TRAF-signaling complex protein 2"))
<<<<<<< .mine
(define-protein "BIRC2_HUMAN" ("c-IAP-1" "Baculoviral IAP repeat-containing protein 2" "C-IAP1" "IAP homolog B" "Inhibitor of apoptosis protein 2" "IAP-2" "hIAP-2" "hIAP2" "RING finger protein 48" "TNFR2-TRAF-signaling complex protein 2"))
(define-protein "BIRC3_HUMAN" ("cIAP2" "Baculoviral IAP repeat-containing protein 3" "Apoptosis inhibitor 2" "API2" "C-IAP2" "IAP homolog C" "Inhibitor of apoptosis protein 1" "IAP-1" "hIAP-1" "hIAP1" "RING finger protein 49" "TNFR2-TRAF-signaling complex protein 1"))
(define-protein "BIRC5_HUMAN" ("survivin" "Baculoviral IAP repeat-containing protein 5" "Apoptosis inhibitor 4" "Apoptosis inhibitor survivin"))
(define-protein "BKRB2_HUMAN" ("BK2" "B2 bradykinin receptor" "B2R" "BK-2 receptor"))
=======
<<<<<<< .mine
(define-protein "BIRC2_HUMAN" ("c-IAP-1" "Baculoviral IAP repeat-containing protein 2" "C-IAP1" "IAP homolog B" "Inhibitor of apoptosis protein 2" "IAP-2" "hIAP-2" "hIAP2" "RING finger protein 48" "TNFR2-TRAF-signaling complex protein 2"))
(define-protein "BIRC3_HUMAN" ("cIAP2" "Baculoviral IAP repeat-containing protein 3" "Apoptosis inhibitor 2" "API2" "C-IAP2" "IAP homolog C" "Inhibitor of apoptosis protein 1" "IAP-1" "hIAP-1" "hIAP1" "RING finger protein 49" "TNFR2-TRAF-signaling complex protein 1"))
(define-protein "BIRC5_HUMAN" ("survivin" "Baculoviral IAP repeat-containing protein 5" "Apoptosis inhibitor 4" "Apoptosis inhibitor survivin"))
(define-protein "BKRB2_HUMAN" ("BK2" "B2 bradykinin receptor" "B2R" "BK-2 receptor"))
=======
(define-protein "BIRC3_HUMAN" ("Baculoviral IAP repeat-containing protein 3" "Apoptosis inhibitor 2" "API2" "C-IAP2" "IAP homolog C" "Inhibitor of apoptosis protein 1" "IAP-1" "hIAP-1" "hIAP1" "RING finger protein 49" "TNFR2-TRAF-signaling complex protein 1"))
(define-protein "BIRC5_HUMAN" ("Baculoviral IAP repeat-containing protein 5" "Apoptosis inhibitor 4" "Apoptosis inhibitor survivin"))
(define-protein "BKRB2_HUMAN" ("B2 bradykinin receptor" "B2R" "BK-2 receptor"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "BL1S1_HUMAN" ("GCN5L1" "BLOC1S1" "RT14" "BLOS1")) 
(define-protein "BL1S2_HUMAN" ("CEAP" "BLOC1S2" "BLOS2")) 
(define-protein "BL1S4_HUMAN" ("BLOC1S4" "CNO")) 
(define-protein "BL1S5_HUMAN" ("BLOC1S5" "MUTED")) 
(define-protein "BL1S6_HUMAN" ("Pallidin" "BLOC1S6" "PA" "PLDN")) 
<<<<<<< .mine
(define-protein "BLNK_HUMAN" ("homology" "B-cell linker protein" "B-cell adapter containing a SH2 domain protein" "B-cell adapter containing a Src homology 2 domain protein" "Cytoplasmic adapter protein" "Src homology 2 domain-containing leukocyte protein of 65 kDa" "SLP-65"))
(define-protein "BLVRB_HUMAN" ("nadph" "Flavin reductase (NADPH)" "FR" "Biliverdin reductase B" "BVR-B" "Biliverdin-IX beta-reductase" "Green heme-binding protein" "GHBP" "NADPH-dependent diaphorase" "NADPH-flavin reductase" "FLR"))
(define-protein "BMI1_HUMAN" ("Bmi1" "Polycomb complex protein BMI-1" "Polycomb group RING finger protein 4" "RING finger protein 51"))
=======
<<<<<<< .mine
(define-protein "BLNK_HUMAN" ("homology" "B-cell linker protein" "B-cell adapter containing a SH2 domain protein" "B-cell adapter containing a Src homology 2 domain protein" "Cytoplasmic adapter protein" "Src homology 2 domain-containing leukocyte protein of 65 kDa" "SLP-65"))
(define-protein "BLVRB_HUMAN" ("nadph" "Flavin reductase (NADPH)" "FR" "Biliverdin reductase B" "BVR-B" "Biliverdin-IX beta-reductase" "Green heme-binding protein" "GHBP" "NADPH-dependent diaphorase" "NADPH-flavin reductase" "FLR"))
(define-protein "BMI1_HUMAN" ("Bmi1" "Polycomb complex protein BMI-1" "Polycomb group RING finger protein 4" "RING finger protein 51"))
=======
(define-protein "BLNK_HUMAN" ("B-cell linker protein" "B-cell adapter containing a SH2 domain protein" "B-cell adapter containing a Src homology 2 domain protein" "Cytoplasmic adapter protein" "Src homology 2 domain-containing leukocyte protein of 65 kDa" "SLP-65"))
(define-protein "BLVRB_HUMAN" ("Flavin reductase (NADPH)" "FR" "Biliverdin reductase B" "BVR-B" "Biliverdin-IX beta-reductase" "Green heme-binding protein" "GHBP" "NADPH-dependent diaphorase" "NADPH-flavin reductase" "FLR"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "BMI1_HUMAN" ("Polycomb complex protein BMI-1" "Polycomb group RING finger protein 4" "RING finger protein 51"))
<<<<<<< .mine
(define-protein "BMP10_HUMAN" ("ALK6" "Bone morphogenetic protein 10" "BMP-10"))
(define-protein "BN3D2_HUMAN" ("mirna" "Pre-miRNA 5'-monophosphate methyltransferase" "BCDIN3 domain-containing protein"))
=======
<<<<<<< .mine
(define-protein "BMP10_HUMAN" ("ALK6" "Bone morphogenetic protein 10" "BMP-10"))
(define-protein "BN3D2_HUMAN" ("mirna" "Pre-miRNA 5'-monophosphate methyltransferase" "BCDIN3 domain-containing protein"))
=======
(define-protein "BMP10_HUMAN" ("Bone morphogenetic protein 10" "BMP-10"))
(define-protein "BN3D2_HUMAN" ("Pre-miRNA 5'-monophosphate methyltransferase" "BCDIN3 domain-containing protein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "BPNT1_HUMAN" ("PIP" "BPNT1")) 
<<<<<<< .mine
(define-protein "BPTF_HUMAN" ("H3K4Me3" "Nucleosome-remodeling factor subunit BPTF" "Bromodomain and PHD finger-containing transcription factor" "Fetal Alz-50 clone 1 protein" "Fetal Alzheimer antigen"))
=======
<<<<<<< .mine
(define-protein "BPTF_HUMAN" ("H3K4Me3" "Nucleosome-remodeling factor subunit BPTF" "Bromodomain and PHD finger-containing transcription factor" "Fetal Alz-50 clone 1 protein" "Fetal Alzheimer antigen"))
=======
(define-protein "BPTF_HUMAN" ("Nucleosome-remodeling factor subunit BPTF" "Bromodomain and PHD finger-containing transcription factor" "Fetal Alz-50 clone 1 protein" "Fetal Alzheimer antigen"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "BRAP_HUMAN" ("RNF52" "BRAP" "IMP" "BRAP2")) 
<<<<<<< .mine
(define-protein "BRF2_HUMAN" ("egcg" "Transcription factor IIIB 50 kDa subunit" "TFIIIB50" "hTFIIIB50" "B-related factor 2" "BRF-2" "hBRFU"))
=======
<<<<<<< .mine
(define-protein "BRF2_HUMAN" ("egcg" "Transcription factor IIIB 50 kDa subunit" "TFIIIB50" "hTFIIIB50" "B-related factor 2" "BRF-2" "hBRFU"))
=======
(define-protein "BRF2_HUMAN" ("Transcription factor IIIB 50 kDa subunit" "TFIIIB50" "hTFIIIB50" "B-related factor 2" "BRF-2" "hBRFU"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "BRM1L_HUMAN" ("Breast cancer metastasis-suppressor 1-like protein" "BRMS1-homolog protein p40" "BRMS1-like protein p40"))
<<<<<<< .mine
(define-protein "BRS3_HUMAN" ("bombesin" "Bombesin receptor subtype-3" "BRS-3"))
(define-protein "BRSK2_HUMAN" ("Serine/Threonine" "Serine/threonine-protein kinase BRSK2" "Brain-selective kinase 2" "Brain-specific serine/threonine-protein kinase 2" "BR serine/threonine-protein kinase 2" "Serine/threonine-protein kinase 29" "Serine/threonine-protein kinase SAD-A"))
(define-protein "BST2_HUMAN" ("cytometry" "Bone marrow stromal antigen 2" "BST-2" "HM1.24 antigen" "Tetherin"))
(define-protein "BTG2_HUMAN" ("pERK1/2" "Protein BTG2" "BTG family member 2" "NGF-inducible anti-proliferative protein PC3"))
(define-protein "BUB1B_HUMAN" ("pcs" "Mitotic checkpoint serine/threonine-protein kinase BUB1 beta" "MAD3/BUB1-related protein kinase" "hBUBR1" "Mitotic checkpoint kinase MAD3L" "Protein SSK1"))
(define-protein "BUB1_HUMAN" ("Bub1" "Mitotic checkpoint serine/threonine-protein kinase BUB1" "hBUB1" "BUB1A"))
(define-protein "BUB3_HUMAN" ("Bub3" "Mitotic checkpoint protein BUB3"))
(define-protein "BWR1B_HUMAN" ("antisense" "Beckwith-Wiedemann syndrome chromosomal region 1 candidate gene B protein" "Organic cation transporter-like protein 2 antisense protein" "Solute carrier family 22 member 1-like antisense protein" "Solute carrier family 22 member 18 antisense protein" "p27-Beckwith-Wiedemann region 1 B" "p27-BWR1B"))
=======
<<<<<<< .mine
(define-protein "BRS3_HUMAN" ("bombesin" "Bombesin receptor subtype-3" "BRS-3"))
(define-protein "BRSK2_HUMAN" ("Serine/Threonine" "Serine/threonine-protein kinase BRSK2" "Brain-selective kinase 2" "Brain-specific serine/threonine-protein kinase 2" "BR serine/threonine-protein kinase 2" "Serine/threonine-protein kinase 29" "Serine/threonine-protein kinase SAD-A"))
(define-protein "BST2_HUMAN" ("cytometry" "Bone marrow stromal antigen 2" "BST-2" "HM1.24 antigen" "Tetherin"))
(define-protein "BTG2_HUMAN" ("pERK1/2" "Protein BTG2" "BTG family member 2" "NGF-inducible anti-proliferative protein PC3"))
(define-protein "BUB1B_HUMAN" ("pcs" "Mitotic checkpoint serine/threonine-protein kinase BUB1 beta" "MAD3/BUB1-related protein kinase" "hBUBR1" "Mitotic checkpoint kinase MAD3L" "Protein SSK1"))
(define-protein "BUB1_HUMAN" ("Bub1" "Mitotic checkpoint serine/threonine-protein kinase BUB1" "hBUB1" "BUB1A"))
(define-protein "BUB3_HUMAN" ("Bub3" "Mitotic checkpoint protein BUB3"))
(define-protein "BWR1B_HUMAN" ("antisense" "Beckwith-Wiedemann syndrome chromosomal region 1 candidate gene B protein" "Organic cation transporter-like protein 2 antisense protein" "Solute carrier family 22 member 1-like antisense protein" "Solute carrier family 22 member 18 antisense protein" "p27-Beckwith-Wiedemann region 1 B" "p27-BWR1B"))
=======
(define-protein "BRS3_HUMAN" ("Bombesin receptor subtype-3" "BRS-3"))
(define-protein "BRSK2_HUMAN" ("Serine/threonine-protein kinase BRSK2" "Brain-selective kinase 2" "Brain-specific serine/threonine-protein kinase 2" "BR serine/threonine-protein kinase 2" "Serine/threonine-protein kinase 29" "Serine/threonine-protein kinase SAD-A"))
(define-protein "BST2_HUMAN" ("Bone marrow stromal antigen 2" "BST-2" "HM1.24 antigen" "Tetherin"))
(define-protein "BTG2_HUMAN" ("Protein BTG2" "BTG family member 2" "NGF-inducible anti-proliferative protein PC3"))
(define-protein "BUB1B_HUMAN" ("Mitotic checkpoint serine/threonine-protein kinase BUB1 beta" "MAD3/BUB1-related protein kinase" "hBUBR1" "Mitotic checkpoint kinase MAD3L" "Protein SSK1"))
(define-protein "BUB1_HUMAN" ("Mitotic checkpoint serine/threonine-protein kinase BUB1" "hBUB1" "BUB1A"))
(define-protein "BUB3_HUMAN" ("Mitotic checkpoint protein BUB3"))
(define-protein "BWR1B_HUMAN" ("Beckwith-Wiedemann syndrome chromosomal region 1 candidate gene B protein" "Organic cation transporter-like protein 2 antisense protein" "Solute carrier family 22 member 1-like antisense protein" "Solute carrier family 22 member 18 antisense protein" "p27-Beckwith-Wiedemann region 1 B" "p27-BWR1B"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "BZW1_HUMAN" ("KIAA0005" "BZAP45" "BZW1")) 
(define-protein "BZW2_HUMAN" ("BZW2")) 
<<<<<<< .mine
(define-protein "C0SQ93_HUMAN" ("errγ" "Bisphenol A receptor ERRgamma2"))
(define-protein "C11B2_HUMAN" ("aldosterone" "Cytochrome P450 11B2, mitochondrial" "Aldosterone synthase" "ALDOS" "Aldosterone-synthesizing enzyme" "CYPXIB2" "Cytochrome P-450Aldo" "Cytochrome P-450C18" "Steroid 18-hydroxylase"))
(define-protein "C163A_HUMAN" ("macrophages" "Scavenger receptor cysteine-rich type 1 protein M130" "Hemoglobin scavenger receptor"))
(define-protein "C1GLC_HUMAN" ("cosmc" "C1GALT1-specific chaperone 1" "C38H2-like protein 1" "C38H2-L1" "Core 1 beta1,3-galactosyltransferase 2" "C1Gal-T2" "C1GalT2" "Core 1 beta3-Gal-T2" "Core 1 beta3-galactosyltransferase-specific molecular chaperone"))
(define-protein "C1GLT_HUMAN" ("T-synthase" "Glycoprotein-N-acetylgalactosamine 3-beta-galactosyltransferase 1" "B3Gal-T8" "Core 1 O-glycan T-synthase" "Core 1 UDP-galactose:N-acetylgalactosamine-alpha-R beta 1,3-galactosyltransferase 1" "Beta-1,3-galactosyltransferase" "Core 1 beta1,3-galactosyltransferase 1" "C1GalT1" "Core 1 beta3-Gal-T1"))
=======
<<<<<<< .mine
(define-protein "C0SQ93_HUMAN" ("errγ" "Bisphenol A receptor ERRgamma2"))
(define-protein "C11B2_HUMAN" ("aldosterone" "Cytochrome P450 11B2, mitochondrial" "Aldosterone synthase" "ALDOS" "Aldosterone-synthesizing enzyme" "CYPXIB2" "Cytochrome P-450Aldo" "Cytochrome P-450C18" "Steroid 18-hydroxylase"))
(define-protein "C163A_HUMAN" ("macrophages" "Scavenger receptor cysteine-rich type 1 protein M130" "Hemoglobin scavenger receptor"))
(define-protein "C1GLC_HUMAN" ("cosmc" "C1GALT1-specific chaperone 1" "C38H2-like protein 1" "C38H2-L1" "Core 1 beta1,3-galactosyltransferase 2" "C1Gal-T2" "C1GalT2" "Core 1 beta3-Gal-T2" "Core 1 beta3-galactosyltransferase-specific molecular chaperone"))
(define-protein "C1GLT_HUMAN" ("T-synthase" "Glycoprotein-N-acetylgalactosamine 3-beta-galactosyltransferase 1" "B3Gal-T8" "Core 1 O-glycan T-synthase" "Core 1 UDP-galactose:N-acetylgalactosamine-alpha-R beta 1,3-galactosyltransferase 1" "Beta-1,3-galactosyltransferase" "Core 1 beta1,3-galactosyltransferase 1" "C1GalT1" "Core 1 beta3-Gal-T1"))
=======
(define-protein "C0SQ93_HUMAN" ("Bisphenol A receptor ERRgamma2"))
(define-protein "C11B2_HUMAN" ("Cytochrome P450 11B2, mitochondrial" "Aldosterone synthase" "ALDOS" "Aldosterone-synthesizing enzyme" "CYPXIB2" "Cytochrome P-450Aldo" "Cytochrome P-450C18" "Steroid 18-hydroxylase"))
(define-protein "C163A_HUMAN" ("Scavenger receptor cysteine-rich type 1 protein M130" "Hemoglobin scavenger receptor"))
(define-protein "C1GLC_HUMAN" ("C1GALT1-specific chaperone 1" "C38H2-like protein 1" "C38H2-L1" "Core 1 beta1,3-galactosyltransferase 2" "C1Gal-T2" "C1GalT2" "Core 1 beta3-Gal-T2" "Core 1 beta3-galactosyltransferase-specific molecular chaperone"))
(define-protein "C1GLT_HUMAN" ("Glycoprotein-N-acetylgalactosamine 3-beta-galactosyltransferase 1" "B3Gal-T8" "Core 1 O-glycan T-synthase" "Core 1 UDP-galactose:N-acetylgalactosamine-alpha-R beta 1,3-galactosyltransferase 1" "Beta-1,3-galactosyltransferase" "Core 1 beta1,3-galactosyltransferase 1" "C1GalT1" "Core 1 beta3-Gal-T1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "C1QBP_HUMAN" ("Complement component 1 Q subcomponent-binding protein, mitochondrial" "ASF/SF2-associated protein p32" "Glycoprotein gC1qBP" "C1qBP" "Hyaluronan-binding protein 1" "Mitochondrial matrix protein p32" "gC1q-R protein" "p33"))
<<<<<<< .mine
(define-protein "C1QBP_HUMAN" ("mam33" "Complement component 1 Q subcomponent-binding protein, mitochondrial" "ASF/SF2-associated protein p32" "Glycoprotein gC1qBP" "C1qBP" "Hyaluronan-binding protein 1" "Mitochondrial matrix protein p32" "gC1q-R protein" "p33"))
(define-protein "C2CD5_HUMAN" ("cdp" "C2 domain-containing protein 5" "C2 domain-containing phosphoprotein of 138 kDa"))
(define-protein "C2TA_HUMAN" ("mhc" "MHC class II transactivator" "CIITA"))
(define-protein "C3VI15_9HIV1" ("IR3" "Protease"))
=======
<<<<<<< .mine
(define-protein "C1QBP_HUMAN" ("mam33" "Complement component 1 Q subcomponent-binding protein, mitochondrial" "ASF/SF2-associated protein p32" "Glycoprotein gC1qBP" "C1qBP" "Hyaluronan-binding protein 1" "Mitochondrial matrix protein p32" "gC1q-R protein" "p33"))
(define-protein "C2CD5_HUMAN" ("cdp" "C2 domain-containing protein 5" "C2 domain-containing phosphoprotein of 138 kDa"))
(define-protein "C2TA_HUMAN" ("mhc" "MHC class II transactivator" "CIITA"))
(define-protein "C3VI15_9HIV1" ("IR3" "Protease"))
=======
(define-protein "C2CD5_HUMAN" ("C2 domain-containing protein 5" "C2 domain-containing phosphoprotein of 138 kDa"))
(define-protein "C2TA_HUMAN" ("MHC class II transactivator" "CIITA"))
(define-protein "C3VI15_9HIV1" ("Protease"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "C42S2_HUMAN" ("SPEC2" "CDC42SE2")) 
<<<<<<< .mine
(define-protein "C43BP_HUMAN" ("lipids" "Collagen type IV alpha-3-binding protein" "Ceramide transfer protein" "hCERT" "Goodpasture antigen-binding protein" "GPBP" "START domain-containing protein 11" "StARD11" "StAR-related lipid transfer protein 11"))
(define-protein "C5MKY7_HCMV" ("egfp" "Enhanced green fluorescent protein"))
(define-protein "C6FX96_9HIV1" ("18h" "Envelope glycoprotein gp160" "Endogenous retrovirus group K member 113 Env polyprotein" "Endogenous retrovirus group K member 13-1 Env polyprotein" "Endogenous retrovirus group K member 18 Env polyprotein" "Endogenous retrovirus group K member 19 Env polyprotein" "Endogenous retrovirus group K member 21 Env polyprotein" "Endogenous retrovirus group K member 24 Env polyprotein" "Endogenous retrovirus group K member 25 Env polyprotein" "Endogenous retrovirus group K member 6 Env polyprotein" "Endogenous retrovirus group K member 8 Env polyprotein" "Endogenous retrovirus group K member 9 Env polyprotein" "Envelope glycoprotein gp160"))
(define-protein "C9JY79_HUMAN" ("β-spectrin" "Non-erythrocytic beta-spectrin 4" "Spectrin beta chain, non-erythrocytic 4"))
(define-protein "CAAP1_HUMAN" ("janicke" "Caspase activity and apoptosis inhibitor 1" "Conserved anti-apoptotic protein" "CAAP"))
=======
<<<<<<< .mine
(define-protein "C43BP_HUMAN" ("lipids" "Collagen type IV alpha-3-binding protein" "Ceramide transfer protein" "hCERT" "Goodpasture antigen-binding protein" "GPBP" "START domain-containing protein 11" "StARD11" "StAR-related lipid transfer protein 11"))
(define-protein "C5MKY7_HCMV" ("egfp" "Enhanced green fluorescent protein"))
(define-protein "C6FX96_9HIV1" ("18h" "Envelope glycoprotein gp160" "Endogenous retrovirus group K member 113 Env polyprotein" "Endogenous retrovirus group K member 13-1 Env polyprotein" "Endogenous retrovirus group K member 18 Env polyprotein" "Endogenous retrovirus group K member 19 Env polyprotein" "Endogenous retrovirus group K member 21 Env polyprotein" "Endogenous retrovirus group K member 24 Env polyprotein" "Endogenous retrovirus group K member 25 Env polyprotein" "Endogenous retrovirus group K member 6 Env polyprotein" "Endogenous retrovirus group K member 8 Env polyprotein" "Endogenous retrovirus group K member 9 Env polyprotein" "Envelope glycoprotein gp160"))
(define-protein "C9JY79_HUMAN" ("β-spectrin" "Non-erythrocytic beta-spectrin 4" "Spectrin beta chain, non-erythrocytic 4"))
(define-protein "CAAP1_HUMAN" ("janicke" "Caspase activity and apoptosis inhibitor 1" "Conserved anti-apoptotic protein" "CAAP"))
=======
(define-protein "C43BP_HUMAN" ("Collagen type IV alpha-3-binding protein" "Ceramide transfer protein" "hCERT" "Goodpasture antigen-binding protein" "GPBP" "START domain-containing protein 11" "StARD11" "StAR-related lipid transfer protein 11"))
(define-protein "C5MKY7_HCMV" ("Enhanced green fluorescent protein"))
(define-protein "C6FX96_9HIV1" ("Envelope glycoprotein gp160" "Endogenous retrovirus group K member 113 Env polyprotein" "Endogenous retrovirus group K member 13-1 Env polyprotein" "Endogenous retrovirus group K member 18 Env polyprotein" "Endogenous retrovirus group K member 19 Env polyprotein" "Endogenous retrovirus group K member 21 Env polyprotein" "Endogenous retrovirus group K member 24 Env polyprotein" "Endogenous retrovirus group K member 25 Env polyprotein" "Endogenous retrovirus group K member 6 Env polyprotein" "Endogenous retrovirus group K member 8 Env polyprotein" "Endogenous retrovirus group K member 9 Env polyprotein" "Envelope glycoprotein gp160"))
(define-protein "C9JY79_HUMAN" ("Non-erythrocytic beta-spectrin 4" "Spectrin beta chain, non-erythrocytic 4"))
(define-protein "CAAP1_HUMAN" ("Caspase activity and apoptosis inhibitor 1" "Conserved anti-apoptotic protein" "CAAP"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CAB39_HUMAN" ("CAB39" "MO25" "MO25alpha")) 
(define-protein "CAB45_HUMAN" ("CAB45" "SDF-4" "SDF4" "Cab45")) 
<<<<<<< .mine
(define-protein "CAC1E_HUMAN" ("Cacna1e" "Voltage-dependent R-type calcium channel subunit alpha-1E" "Brain calcium channel II" "BII" "Calcium channel, L type, alpha-1 polypeptide, isoform 6" "Voltage-gated calcium channel subunit alpha Cav2.3"))
=======
<<<<<<< .mine
(define-protein "CAC1E_HUMAN" ("Cacna1e" "Voltage-dependent R-type calcium channel subunit alpha-1E" "Brain calcium channel II" "BII" "Calcium channel, L type, alpha-1 polypeptide, isoform 6" "Voltage-gated calcium channel subunit alpha Cav2.3"))
=======
(define-protein "CAC1E_HUMAN" ("Voltage-dependent R-type calcium channel subunit alpha-1E" "Brain calcium channel II" "BII" "Calcium channel, L type, alpha-1 polypeptide, isoform 6" "Voltage-gated calcium channel subunit alpha Cav2.3"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CADH1_HUMAN" ("Cadherin-1" "CAM 120/80" "Epithelial cadherin" "E-cadherin" "Uvomorulin"))
<<<<<<< .mine
(define-protein "CADH1_HUMAN" ("E-cad" "Cadherin-1" "CAM 120/80" "Epithelial cadherin" "E-cadherin" "Uvomorulin"))
(define-protein "CADH4_HUMAN" ("cadherin-4" "Cadherin-4" "Retinal cadherin" "R-CAD" "R-cadherin"))
(define-protein "CAH9_HUMAN" ("CA-9" "Carbonic anhydrase 9" "Carbonate dehydratase IX" "Carbonic anhydrase IX" "CA-IX" "CAIX" "Membrane antigen MN" "P54/58N" "Renal cell carcinoma-associated antigen G250" "RCC-associated antigen G250" "pMW1"))
=======
<<<<<<< .mine
(define-protein "CADH1_HUMAN" ("E-cad" "Cadherin-1" "CAM 120/80" "Epithelial cadherin" "E-cadherin" "Uvomorulin"))
(define-protein "CADH4_HUMAN" ("cadherin-4" "Cadherin-4" "Retinal cadherin" "R-CAD" "R-cadherin"))
(define-protein "CAH9_HUMAN" ("CA-9" "Carbonic anhydrase 9" "Carbonate dehydratase IX" "Carbonic anhydrase IX" "CA-IX" "CAIX" "Membrane antigen MN" "P54/58N" "Renal cell carcinoma-associated antigen G250" "RCC-associated antigen G250" "pMW1"))
=======
(define-protein "CADH4_HUMAN" ("Cadherin-4" "Retinal cadherin" "R-CAD" "R-cadherin"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CAH9_HUMAN" ("Carbonic anhydrase 9" "Carbonate dehydratase IX" "Carbonic anhydrase IX" "CA-IX" "CAIX" "Membrane antigen MN" "P54/58N" "Renal cell carcinoma-associated antigen G250" "RCC-associated antigen G250" "pMW1"))
(define-protein "CALR_HUMAN" ("CALR" "ERp60" "CRTC" "CRP55" "Calregulin" "grp60" "HACBP")) 
(define-protein "CALU_HUMAN" ("Crocalbin" "CALU")) 
(define-protein "CALX_HUMAN" ("p90" "CANX" "IP90")) 
<<<<<<< .mine
(define-protein "CAMP_HUMAN" ("LL-37" "Cathelicidin antimicrobial peptide" "18 kDa cationic antimicrobial protein" "CAP-18" "hCAP-18"))
(define-protein "CAN2_HUMAN" ("m-calpain" "Calpain-2 catalytic subunit" "Calcium-activated neutral proteinase 2" "CANP 2" "Calpain M-type" "Calpain large polypeptide L2" "Calpain-2 large subunit" "Millimolar-calpain" "M-calpain"))
(define-protein "CAN3_HUMAN" ("ncl" "Calpain-3" "Calcium-activated neutral proteinase 3" "CANP 3" "Calpain L3" "Calpain p94" "Muscle-specific calcium-activated neutral protease 3" "New calpain 1" "nCL-1"))
=======
<<<<<<< .mine
(define-protein "CAMP_HUMAN" ("LL-37" "Cathelicidin antimicrobial peptide" "18 kDa cationic antimicrobial protein" "CAP-18" "hCAP-18"))
(define-protein "CAN2_HUMAN" ("m-calpain" "Calpain-2 catalytic subunit" "Calcium-activated neutral proteinase 2" "CANP 2" "Calpain M-type" "Calpain large polypeptide L2" "Calpain-2 large subunit" "Millimolar-calpain" "M-calpain"))
(define-protein "CAN3_HUMAN" ("ncl" "Calpain-3" "Calcium-activated neutral proteinase 3" "CANP 3" "Calpain L3" "Calpain p94" "Muscle-specific calcium-activated neutral protease 3" "New calpain 1" "nCL-1"))
=======
(define-protein "CAMP_HUMAN" ("Cathelicidin antimicrobial peptide" "18 kDa cationic antimicrobial protein" "CAP-18" "hCAP-18"))
(define-protein "CAN2_HUMAN" ("Calpain-2 catalytic subunit" "Calcium-activated neutral proteinase 2" "CANP 2" "Calpain M-type" "Calpain large polypeptide L2" "Calpain-2 large subunit" "Millimolar-calpain" "M-calpain"))
(define-protein "CAN3_HUMAN" ("Calpain-3" "Calcium-activated neutral proteinase 3" "CANP 3" "Calpain L3" "Calpain p94" "Muscle-specific calcium-activated neutral protease 3" "New calpain 1" "nCL-1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CAND1_HUMAN" ("KIAA0829" "CAND1" "TIP120A" "TIP120")) 
<<<<<<< .mine
(define-protein "CAP7_HUMAN" ("synergizes" "Azurocidin" "Cationic antimicrobial protein CAP37" "Heparin-binding protein" "HBP"))
=======
<<<<<<< .mine
(define-protein "CAP7_HUMAN" ("synergizes" "Azurocidin" "Cationic antimicrobial protein CAP37" "Heparin-binding protein" "HBP"))
=======
(define-protein "CAP7_HUMAN" ("Azurocidin" "Cationic antimicrobial protein CAP37" "Heparin-binding protein" "HBP"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CAPS2_HUMAN" ("KIAA1591" "CADPS2" "CAPS2" "CAPS-2")) 
(define-protein "CAPSD_HEVHY" ("Capsid protein" "Protein ORF2" "pORF2"))
(define-protein "CAPSD_HEVHY" ("ORF2" "Capsid protein" "Protein ORF2" "pORF2"))
(define-protein "CAPZB_HUMAN" ("CAPZB")) 
<<<<<<< .mine
(define-protein "CARF_HUMAN" ("MG132" "CDKN2A-interacting protein" "Collaborator of ARF"))
(define-protein "CASB_HUMAN" ("β-casein" "Beta-casein"))
=======
<<<<<<< .mine
(define-protein "CARF_HUMAN" ("MG132" "CDKN2A-interacting protein" "Collaborator of ARF"))
(define-protein "CASB_HUMAN" ("β-casein" "Beta-casein"))
=======
(define-protein "CARF_HUMAN" ("CDKN2A-interacting protein" "Collaborator of ARF"))
(define-protein "CASB_HUMAN" ("Beta-casein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CASL_HUMAN" ("Enhancer of filamentation 1" "hEF1" "CRK-associated substrate-related protein" "CAS-L" "CasL" "Cas scaffolding protein family member 2" "Neural precursor cell expressed developmentally down-regulated protein 9" "NEDD-9" "Renal carcinoma antigen NY-REN-12" "p105"))
(define-protein "CASL_HUMAN" ("Fyn/Src" "Enhancer of filamentation 1" "hEF1" "CRK-associated substrate-related protein" "CAS-L" "CasL" "Cas scaffolding protein family member 2" "Neural precursor cell expressed developmentally down-regulated protein 9" "NEDD-9" "Renal carcinoma antigen NY-REN-12" "p105"))
(define-protein "CASP3_HUMAN" ("Caspase-3" "CASP-3" "Apopain" "Cysteine protease CPP32" "CPP-32" "Protein Yama" "SREBP cleavage activity 1" "SCA-1"))
<<<<<<< .mine
(define-protein "CASP3_HUMAN" ("caspase-3" "Caspase-3" "CASP-3" "Apopain" "Cysteine protease CPP32" "CPP-32" "Protein Yama" "SREBP cleavage activity 1" "SCA-1"))
(define-protein "CASP7_HUMAN" ("Mch3" "Caspase-7" "CASP-7" "Apoptotic protease Mch-3" "CMH-1" "ICE-like apoptotic protease 3" "ICE-LAP3"))
=======
<<<<<<< .mine
(define-protein "CASP3_HUMAN" ("caspase-3" "Caspase-3" "CASP-3" "Apopain" "Cysteine protease CPP32" "CPP-32" "Protein Yama" "SREBP cleavage activity 1" "SCA-1"))
(define-protein "CASP7_HUMAN" ("Mch3" "Caspase-7" "CASP-7" "Apoptotic protease Mch-3" "CMH-1" "ICE-like apoptotic protease 3" "ICE-LAP3"))
=======
(define-protein "CASP7_HUMAN" ("Caspase-7" "CASP-7" "Apoptotic protease Mch-3" "CMH-1" "ICE-like apoptotic protease 3" "ICE-LAP3"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CASP9_HUMAN" ("Caspase-9" "CASP-9" "Apoptotic protease Mch-6" "Apoptotic protease-activating factor 3" "APAF-3" "ICE-like apoptotic protease 6" "ICE-LAP6"))
(define-protein "CASP9_HUMAN" ("procaspase3" "Caspase-9" "CASP-9" "Apoptotic protease Mch-6" "Apoptotic protease-activating factor 3" "APAF-3" "ICE-like apoptotic protease 6" "ICE-LAP6"))
(define-protein "CASP_HUMAN" ("CUX1" "CUTL1")) 
<<<<<<< .mine
(define-protein "CASS4_HUMAN" ("efs" "Cas scaffolding protein family member 4" "HEF-like protein" "HEF1-EFS-p130Cas-like protein" "HEPL"))
(define-protein "CATG_HUMAN" ("DFP-" "Cathepsin G" "CG"))
=======
<<<<<<< .mine
(define-protein "CASS4_HUMAN" ("efs" "Cas scaffolding protein family member 4" "HEF-like protein" "HEF1-EFS-p130Cas-like protein" "HEPL"))
(define-protein "CATG_HUMAN" ("DFP-" "Cathepsin G" "CG"))
=======
(define-protein "CASS4_HUMAN" ("Cas scaffolding protein family member 4" "HEF-like protein" "HEF1-EFS-p130Cas-like protein" "HEPL"))
(define-protein "CATG_HUMAN" ("Cathepsin G" "CG"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CAV1_HUMAN" ("CAV" "CAV1")) 
(define-protein "CAV1_HUMAN" ("Caveolin-1"))
(define-protein "CAZA1_HUMAN" ("CAPZA1")) 
<<<<<<< .mine
(define-protein "CBG_HUMAN" ("cortisol" "Corticosteroid-binding globulin" "CBG" "Serpin A6" "Transcortin"))
(define-protein "CBLB_HUMAN" ("Cbl-b" "E3 ubiquitin-protein ligase CBL-B" "Casitas B-lineage lymphoma proto-oncogene b" "RING finger protein 56" "SH3-binding protein CBL-B" "Signal transduction protein CBL-B"))
(define-protein "CBL_HUMAN" ("v-Cbl" "E3 ubiquitin-protein ligase CBL" "Casitas B-lineage lymphoma proto-oncogene" "Proto-oncogene c-Cbl" "RING finger protein 55" "Signal transduction protein CBL"))
(define-protein "CBP_HUMAN" ("crebbp" "CREB-binding protein"))
(define-protein "CBX1_HUMAN" ("heterochromatin" "Chromobox protein homolog 1" "HP1Hsbeta" "Heterochromatin protein 1 homolog beta" "HP1 beta" "Heterochromatin protein p25" "M31" "Modifier 1 protein" "p25beta"))
(define-protein "CBY1_HUMAN" ("cby" "Protein chibby homolog 1" "ARPP-binding protein" "Cytosolic leucine-rich protein" "PIGEA-14" "PKD2 interactor, Golgi and endoplasmic reticulum-associated 1"))
=======
<<<<<<< .mine
(define-protein "CBG_HUMAN" ("cortisol" "Corticosteroid-binding globulin" "CBG" "Serpin A6" "Transcortin"))
(define-protein "CBLB_HUMAN" ("Cbl-b" "E3 ubiquitin-protein ligase CBL-B" "Casitas B-lineage lymphoma proto-oncogene b" "RING finger protein 56" "SH3-binding protein CBL-B" "Signal transduction protein CBL-B"))
(define-protein "CBL_HUMAN" ("v-Cbl" "E3 ubiquitin-protein ligase CBL" "Casitas B-lineage lymphoma proto-oncogene" "Proto-oncogene c-Cbl" "RING finger protein 55" "Signal transduction protein CBL"))
(define-protein "CBP_HUMAN" ("crebbp" "CREB-binding protein"))
(define-protein "CBX1_HUMAN" ("heterochromatin" "Chromobox protein homolog 1" "HP1Hsbeta" "Heterochromatin protein 1 homolog beta" "HP1 beta" "Heterochromatin protein p25" "M31" "Modifier 1 protein" "p25beta"))
(define-protein "CBY1_HUMAN" ("cby" "Protein chibby homolog 1" "ARPP-binding protein" "Cytosolic leucine-rich protein" "PIGEA-14" "PKD2 interactor, Golgi and endoplasmic reticulum-associated 1"))
=======
(define-protein "CBG_HUMAN" ("Corticosteroid-binding globulin" "CBG" "Serpin A6" "Transcortin"))
(define-protein "CBLB_HUMAN" ("E3 ubiquitin-protein ligase CBL-B" "Casitas B-lineage lymphoma proto-oncogene b" "RING finger protein 56" "SH3-binding protein CBL-B" "Signal transduction protein CBL-B"))
(define-protein "CBL_HUMAN" ("E3 ubiquitin-protein ligase CBL" "Casitas B-lineage lymphoma proto-oncogene" "Proto-oncogene c-Cbl" "RING finger protein 55" "Signal transduction protein CBL"))
(define-protein "CBP_HUMAN" ("CREB-binding protein"))
(define-protein "CBX1_HUMAN" ("Chromobox protein homolog 1" "HP1Hsbeta" "Heterochromatin protein 1 homolog beta" "HP1 beta" "Heterochromatin protein p25" "M31" "Modifier 1 protein" "p25beta"))
(define-protein "CBY1_HUMAN" ("Protein chibby homolog 1" "ARPP-binding protein" "Cytosolic leucine-rich protein" "PIGEA-14" "PKD2 interactor, Golgi and endoplasmic reticulum-associated 1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CC28A_HUMAN" ("C6orf80" "CCRL1AP" "CCDC28A")) 
<<<<<<< .mine
(define-protein "CC50A_HUMAN" ("perifosine" "Cell cycle control protein 50A" "P4-ATPase flippase complex beta subunit TMEM30A" "Transmembrane protein 30A"))
=======
<<<<<<< .mine
(define-protein "CC50A_HUMAN" ("perifosine" "Cell cycle control protein 50A" "P4-ATPase flippase complex beta subunit TMEM30A" "Transmembrane protein 30A"))
=======
(define-protein "CC50A_HUMAN" ("Cell cycle control protein 50A" "P4-ATPase flippase complex beta subunit TMEM30A" "Transmembrane protein 30A"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CCAR1_HUMAN" ("Cell division cycle and apoptosis regulator protein 1" "Cell cycle and apoptosis regulatory protein 1" "CARP-1" "Death inducer with SAP domain"))
(define-protein "CCAR2_HUMAN" ("CCAR2" "DBC1" "DBC.1" "DBC-1" "KIAA1967")) 
(define-protein "CCD50_HUMAN" ("C3orf6" "CCDC50")) 
(define-protein "CCDC6_HUMAN" ("Coiled-coil domain-containing protein 6" "Papillary thyroid carcinoma-encoded protein" "Protein H4"))
<<<<<<< .mine
(define-protein "CCL11_HUMAN" ("eotaxin" "Eotaxin" "C-C motif chemokine 11" "Eosinophil chemotactic protein" "Small-inducible cytokine A11"))
(define-protein "CCL1_HUMAN" ("I-309" "C-C motif chemokine 1" "Small-inducible cytokine A1" "T lymphocyte-secreted protein I-309"))
=======
<<<<<<< .mine
(define-protein "CCL11_HUMAN" ("eotaxin" "Eotaxin" "C-C motif chemokine 11" "Eosinophil chemotactic protein" "Small-inducible cytokine A11"))
(define-protein "CCL1_HUMAN" ("I-309" "C-C motif chemokine 1" "Small-inducible cytokine A1" "T lymphocyte-secreted protein I-309"))
=======
(define-protein "CCL11_HUMAN" ("Eotaxin" "C-C motif chemokine 11" "Eosinophil chemotactic protein" "Small-inducible cytokine A11"))
(define-protein "CCL1_HUMAN" ("C-C motif chemokine 1" "Small-inducible cytokine A1" "T lymphocyte-secreted protein I-309"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CCL2_HUMAN" ("C-C motif chemokine 2" "HC11" "Monocyte chemoattractant protein 1" "Monocyte chemotactic and activating factor" "MCAF" "Monocyte chemotactic protein 1" "MCP-1" "Monocyte secretory protein JE" "Small-inducible cytokine A2"))
<<<<<<< .mine
(define-protein "CCL3_HUMAN" ("MIP-1β" "C-C motif chemokine 3" "G0/G1 switch regulatory protein 19-1" "Macrophage inflammatory protein 1-alpha" "MIP-1-alpha" "PAT 464.1" "SIS-beta" "Small-inducible cytokine A3" "Tonsillar lymphocyte LD78 alpha protein"))
(define-protein "CCL5_HUMAN" ("rantes" "C-C motif chemokine 5" "EoCP" "Eosinophil chemotactic cytokine" "SIS-delta" "Small-inducible cytokine A5" "T cell-specific protein P228" "TCP228" "T-cell-specific protein RANTES"))
(define-protein "CCL7_HUMAN" ("CCL7" "C-C motif chemokine 7" "Monocyte chemoattractant protein 3" "Monocyte chemotactic protein 3" "MCP-3" "NC28" "Small-inducible cytokine A7"))
=======
<<<<<<< .mine
(define-protein "CCL3_HUMAN" ("MIP-1β" "C-C motif chemokine 3" "G0/G1 switch regulatory protein 19-1" "Macrophage inflammatory protein 1-alpha" "MIP-1-alpha" "PAT 464.1" "SIS-beta" "Small-inducible cytokine A3" "Tonsillar lymphocyte LD78 alpha protein"))
(define-protein "CCL5_HUMAN" ("rantes" "C-C motif chemokine 5" "EoCP" "Eosinophil chemotactic cytokine" "SIS-delta" "Small-inducible cytokine A5" "T cell-specific protein P228" "TCP228" "T-cell-specific protein RANTES"))
(define-protein "CCL7_HUMAN" ("CCL7" "C-C motif chemokine 7" "Monocyte chemoattractant protein 3" "Monocyte chemotactic protein 3" "MCP-3" "NC28" "Small-inducible cytokine A7"))
=======
(define-protein "CCL3_HUMAN" ("C-C motif chemokine 3" "G0/G1 switch regulatory protein 19-1" "Macrophage inflammatory protein 1-alpha" "MIP-1-alpha" "PAT 464.1" "SIS-beta" "Small-inducible cytokine A3" "Tonsillar lymphocyte LD78 alpha protein"))
(define-protein "CCL5_HUMAN" ("C-C motif chemokine 5" "EoCP" "Eosinophil chemotactic cytokine" "SIS-delta" "Small-inducible cytokine A5" "T cell-specific protein P228" "TCP228" "T-cell-specific protein RANTES"))
(define-protein "CCL7_HUMAN" ("C-C motif chemokine 7" "Monocyte chemoattractant protein 3" "Monocyte chemotactic protein 3" "MCP-3" "NC28" "Small-inducible cytokine A7"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CCNB1_HUMAN" ("G2/mitotic-specific cyclin-B1"))
(define-protein "CCNB3_HUMAN" ("CYCB3" "CCNB3")) 
(define-protein "CCND1_HUMAN" ("G1/S-specific cyclin-D1" "B-cell lymphoma 1 protein" "BCL-1" "BCL-1 oncogene" "PRAD1 oncogene"))
(define-protein "CCND1_HUMAN" ("cyclinD1" "G1/S-specific cyclin-D1" "B-cell lymphoma 1 protein" "BCL-1" "BCL-1 oncogene" "PRAD1 oncogene"))
(define-protein "CCNE1_HUMAN" ("G1/S-specific cyclin-E1"))
(define-protein "CCNG1_HUMAN" ("Cyclin-G" "CYCG1" "CCNG1" "CCNG")) 
<<<<<<< .mine
(define-protein "CCR1_HUMAN" ("MIP-1α" "C-C chemokine receptor type 1" "C-C CKR-1" "CC-CKR-1" "CCR-1" "CCR1" "HM145" "LD78 receptor" "Macrophage inflammatory protein 1-alpha receptor" "MIP-1alpha-R" "RANTES-R"))
(define-protein "CCR2_HUMAN" ("C-C chemokine receptor type 2" "C-C CKR-2" "CC-CKR-2" "CCR-2" "CCR2" "Monocyte chemoattractant protein 1 receptor" "MCP-1-R"))
(define-protein "CCR3_HUMAN" ("C-C chemokine receptor type 3" "C-C CKR-3" "CC-CKR-3" "CCR-3" "CCR3" "CKR3" "Eosinophil eotaxin receptor"))
=======
<<<<<<< .mine
(define-protein "CCR1_HUMAN" ("MIP-1α" "C-C chemokine receptor type 1" "C-C CKR-1" "CC-CKR-1" "CCR-1" "CCR1" "HM145" "LD78 receptor" "Macrophage inflammatory protein 1-alpha receptor" "MIP-1alpha-R" "RANTES-R"))
(define-protein "CCR2_HUMAN" ("C-C chemokine receptor type 2" "C-C CKR-2" "CC-CKR-2" "CCR-2" "CCR2" "Monocyte chemoattractant protein 1 receptor" "MCP-1-R"))
(define-protein "CCR3_HUMAN" ("C-C chemokine receptor type 3" "C-C CKR-3" "CC-CKR-3" "CCR-3" "CCR3" "CKR3" "Eosinophil eotaxin receptor"))
=======
(define-protein "CCR1_HUMAN" ("C-C chemokine receptor type 1" "C-C CKR-1" "CC-CKR-1" "CCR-1" "CCR1" "HM145" "LD78 receptor" "Macrophage inflammatory protein 1-alpha receptor" "MIP-1alpha-R" "RANTES-R"))
(define-protein "CCR2_HUMAN" ("C-C chemokine receptor type 2" "C-C CKR-2" "CC-CKR-2" "CCR-2" "CCR2" "Monocyte chemoattractant protein 1 receptor" "MCP-1-R"))
(define-protein "CCR3_HUMAN" ("C-C chemokine receptor type 3" "C-C CKR-3" "CC-CKR-3" "CCR-3" "CCR3" "CKR3" "Eosinophil eotaxin receptor"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CCR5_HUMAN" ("C-C chemokine receptor type 5" "C-C CKR-5" "CC-CKR-5" "CCR-5" "CCR5" "CHEMR13" "HIV-1 fusion coreceptor"))
<<<<<<< .mine
(define-protein "CCR7_HUMAN" ("CCR7" "C-C chemokine receptor type 7" "C-C CKR-7" "CC-CKR-7" "CCR-7" "BLR2" "CDw197" "Epstein-Barr virus-induced G-protein coupled receptor 1" "EBI1" "EBV-induced G-protein coupled receptor 1" "MIP-3 beta receptor"))
(define-protein "CCS_HUMAN" ("ccs" "Copper chaperone for superoxide dismutase" "Superoxide dismutase copper chaperone"))
=======
<<<<<<< .mine
(define-protein "CCR7_HUMAN" ("CCR7" "C-C chemokine receptor type 7" "C-C CKR-7" "CC-CKR-7" "CCR-7" "BLR2" "CDw197" "Epstein-Barr virus-induced G-protein coupled receptor 1" "EBI1" "EBV-induced G-protein coupled receptor 1" "MIP-3 beta receptor"))
(define-protein "CCS_HUMAN" ("ccs" "Copper chaperone for superoxide dismutase" "Superoxide dismutase copper chaperone"))
=======
(define-protein "CCR7_HUMAN" ("C-C chemokine receptor type 7" "C-C CKR-7" "CC-CKR-7" "CCR-7" "BLR2" "CDw197" "Epstein-Barr virus-induced G-protein coupled receptor 1" "EBI1" "EBV-induced G-protein coupled receptor 1" "MIP-3 beta receptor"))
(define-protein "CCS_HUMAN" ("Copper chaperone for superoxide dismutase" "Superoxide dismutase copper chaperone"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CD11A_HUMAN" ("CDC2L3" "CDC2L2" "CDK11A" "PITSLREB")) 
<<<<<<< .mine
(define-protein "CD177_HUMAN" ("hna" "CD177 antigen" "Human neutrophil alloantigen 2a" "HNA-2a" "NB1 glycoprotein" "NB1 GP" "Polycythemia rubra vera protein 1" "PRV-1"))
(define-protein "CD19_HUMAN" ("Tyr-378" "B-lymphocyte antigen CD19" "B-lymphocyte surface antigen B4" "Differentiation antigen CD19" "T-cell surface antigen Leu-12"))
=======
<<<<<<< .mine
(define-protein "CD177_HUMAN" ("hna" "CD177 antigen" "Human neutrophil alloantigen 2a" "HNA-2a" "NB1 glycoprotein" "NB1 GP" "Polycythemia rubra vera protein 1" "PRV-1"))
(define-protein "CD19_HUMAN" ("Tyr-378" "B-lymphocyte antigen CD19" "B-lymphocyte surface antigen B4" "Differentiation antigen CD19" "T-cell surface antigen Leu-12"))
=======
(define-protein "CD177_HUMAN" ("CD177 antigen" "Human neutrophil alloantigen 2a" "HNA-2a" "NB1 glycoprotein" "NB1 GP" "Polycythemia rubra vera protein 1" "PRV-1"))
(define-protein "CD19_HUMAN" ("B-lymphocyte antigen CD19" "B-lymphocyte surface antigen B4" "Differentiation antigen CD19" "T-cell surface antigen Leu-12"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CD2AP_HUMAN" ("CD2AP")) 
<<<<<<< .mine
(define-protein "CD3D_HUMAN" ("TCR-ζ" "T-cell surface glycoprotein CD3 delta chain" "T-cell receptor T3 delta chain"))
(define-protein "CD3E_HUMAN" ("OKT3" "T-cell surface glycoprotein CD3 epsilon chain" "T-cell surface antigen T3/Leu-4 epsilon chain"))
(define-protein "CD47_HUMAN" ("oa" "Leukocyte surface antigen CD47" "Antigenic surface determinant protein OA3" "Integrin-associated protein" "IAP" "Protein MER6"))
(define-protein "CD4_HUMAN" ("CD4" "T-cell surface glycoprotein CD4" "T-cell surface antigen T4/Leu-3"))
(define-protein "CD59_HUMAN" ("min" "CD59 glycoprotein" "1F5 antigen" "20 kDa homologous restriction factor" "HRF-20" "HRF20" "MAC-inhibitory protein" "MAC-IP" "MEM43 antigen" "Membrane attack complex inhibition factor" "MACIF" "Membrane inhibitor of reactive lysis" "MIRL" "Protectin"))
=======
<<<<<<< .mine
(define-protein "CD3D_HUMAN" ("TCR-ζ" "T-cell surface glycoprotein CD3 delta chain" "T-cell receptor T3 delta chain"))
(define-protein "CD3E_HUMAN" ("OKT3" "T-cell surface glycoprotein CD3 epsilon chain" "T-cell surface antigen T3/Leu-4 epsilon chain"))
(define-protein "CD47_HUMAN" ("oa" "Leukocyte surface antigen CD47" "Antigenic surface determinant protein OA3" "Integrin-associated protein" "IAP" "Protein MER6"))
(define-protein "CD4_HUMAN" ("CD4" "T-cell surface glycoprotein CD4" "T-cell surface antigen T4/Leu-3"))
(define-protein "CD59_HUMAN" ("min" "CD59 glycoprotein" "1F5 antigen" "20 kDa homologous restriction factor" "HRF-20" "HRF20" "MAC-inhibitory protein" "MAC-IP" "MEM43 antigen" "Membrane attack complex inhibition factor" "MACIF" "Membrane inhibitor of reactive lysis" "MIRL" "Protectin"))
=======
(define-protein "CD3D_HUMAN" ("T-cell surface glycoprotein CD3 delta chain" "T-cell receptor T3 delta chain"))
(define-protein "CD3E_HUMAN" ("T-cell surface glycoprotein CD3 epsilon chain" "T-cell surface antigen T3/Leu-4 epsilon chain"))
(define-protein "CD47_HUMAN" ("Leukocyte surface antigen CD47" "Antigenic surface determinant protein OA3" "Integrin-associated protein" "IAP" "Protein MER6"))
(define-protein "CD4_HUMAN" ("T-cell surface glycoprotein CD4" "T-cell surface antigen T4/Leu-3"))
(define-protein "CD59_HUMAN" ("CD59 glycoprotein" "1F5 antigen" "20 kDa homologous restriction factor" "HRF-20" "HRF20" "MAC-inhibitory protein" "MAC-IP" "MEM43 antigen" "Membrane attack complex inhibition factor" "MACIF" "Membrane inhibitor of reactive lysis" "MIRL" "Protectin"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CD63_HUMAN" ("TSPAN30" "LAMP-3" "Tetraspanin-30" "Tspan-30" "MLA1" "OMA81H" "Granulophysin" "CD63")) 
<<<<<<< .mine
(define-protein "CD79A_HUMAN" ("mb-1" "B-cell antigen receptor complex-associated protein alpha chain" "Ig-alpha" "MB-1 membrane glycoprotein" "Membrane-bound immunoglobulin-associated protein" "Surface IgM-associated protein"))
(define-protein "CD79B_HUMAN" ("Ig-β" "B-cell antigen receptor complex-associated protein beta chain" "B-cell-specific glycoprotein B29" "Ig-beta" "Immunoglobulin-associated B29 protein"))
(define-protein "CD7_HUMAN" ("T-cell" "T-cell antigen CD7" "GP40" "T-cell leukemia antigen" "T-cell surface antigen Leu-9" "TP41"))
=======
<<<<<<< .mine
(define-protein "CD79A_HUMAN" ("mb-1" "B-cell antigen receptor complex-associated protein alpha chain" "Ig-alpha" "MB-1 membrane glycoprotein" "Membrane-bound immunoglobulin-associated protein" "Surface IgM-associated protein"))
(define-protein "CD79B_HUMAN" ("Ig-β" "B-cell antigen receptor complex-associated protein beta chain" "B-cell-specific glycoprotein B29" "Ig-beta" "Immunoglobulin-associated B29 protein"))
(define-protein "CD7_HUMAN" ("T-cell" "T-cell antigen CD7" "GP40" "T-cell leukemia antigen" "T-cell surface antigen Leu-9" "TP41"))
=======
(define-protein "CD79A_HUMAN" ("B-cell antigen receptor complex-associated protein alpha chain" "Ig-alpha" "MB-1 membrane glycoprotein" "Membrane-bound immunoglobulin-associated protein" "Surface IgM-associated protein"))
(define-protein "CD79B_HUMAN" ("B-cell antigen receptor complex-associated protein beta chain" "B-cell-specific glycoprotein B29" "Ig-beta" "Immunoglobulin-associated B29 protein"))
(define-protein "CD7_HUMAN" ("T-cell antigen CD7" "GP40" "T-cell leukemia antigen" "T-cell surface antigen Leu-9" "TP41"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CD81_HUMAN" ("CD81 antigen" "26 kDa cell surface protein TAPA-1" "Target of the antiproliferative antibody 1" "Tetraspanin-28" "Tspan-28"))
<<<<<<< .mine
(define-protein "CD81_HUMAN" ("SR-B1" "CD81 antigen" "26 kDa cell surface protein TAPA-1" "Target of the antiproliferative antibody 1" "Tetraspanin-28" "Tspan-28"))
(define-protein "CD8A_HUMAN" ("CD8" "T-cell surface glycoprotein CD8 alpha chain" "T-lymphocyte differentiation antigen T8/Leu-2"))
=======
<<<<<<< .mine
(define-protein "CD81_HUMAN" ("SR-B1" "CD81 antigen" "26 kDa cell surface protein TAPA-1" "Target of the antiproliferative antibody 1" "Tetraspanin-28" "Tspan-28"))
(define-protein "CD8A_HUMAN" ("CD8" "T-cell surface glycoprotein CD8 alpha chain" "T-lymphocyte differentiation antigen T8/Leu-2"))
=======
(define-protein "CD8A_HUMAN" ("T-cell surface glycoprotein CD8 alpha chain" "T-lymphocyte differentiation antigen T8/Leu-2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CD9_HUMAN" ("Tspan-29" "MRP-1" "Tetraspanin-29" "MIC3" "TSPAN29" "p24" "CD9")) 
<<<<<<< .mine
(define-protein "CDC16_HUMAN" ("cyclosome" "Cell division cycle protein 16 homolog" "Anaphase-promoting complex subunit 6" "APC6" "CDC16 homolog" "CDC16Hs" "Cyclosome subunit 6"))
(define-protein "CDC20_HUMAN" ("cdc20" "Cell division cycle protein 20 homolog" "p55CDC"))
=======
<<<<<<< .mine
(define-protein "CDC16_HUMAN" ("cyclosome" "Cell division cycle protein 16 homolog" "Anaphase-promoting complex subunit 6" "APC6" "CDC16 homolog" "CDC16Hs" "Cyclosome subunit 6"))
(define-protein "CDC20_HUMAN" ("cdc20" "Cell division cycle protein 20 homolog" "p55CDC"))
=======
(define-protein "CDC16_HUMAN" ("Cell division cycle protein 16 homolog" "Anaphase-promoting complex subunit 6" "APC6" "CDC16 homolog" "CDC16Hs" "Cyclosome subunit 6"))
(define-protein "CDC20_HUMAN" ("Cell division cycle protein 20 homolog" "p55CDC"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CDC23_HUMAN" ("ANAPC8" "CDC23" "APC8")) 
<<<<<<< .mine
(define-protein "CDC27_HUMAN" ("cdc27" "Cell division cycle protein 27 homolog" "Anaphase-promoting complex subunit 3" "APC3" "CDC27 homolog" "CDC27Hs" "H-NUC"))
(define-protein "CDC37_HUMAN" ("egfrviii" "Hsp90 co-chaperone Cdc37" "Hsp90 chaperone protein kinase-targeting subunit" "p50Cdc37"))
(define-protein "CDC42_HUMAN" ("cerione" "Cell division control protein 42 homolog" "G25K GTP-binding protein"))
=======
<<<<<<< .mine
(define-protein "CDC27_HUMAN" ("cdc27" "Cell division cycle protein 27 homolog" "Anaphase-promoting complex subunit 3" "APC3" "CDC27 homolog" "CDC27Hs" "H-NUC"))
(define-protein "CDC37_HUMAN" ("egfrviii" "Hsp90 co-chaperone Cdc37" "Hsp90 chaperone protein kinase-targeting subunit" "p50Cdc37"))
(define-protein "CDC42_HUMAN" ("cerione" "Cell division control protein 42 homolog" "G25K GTP-binding protein"))
=======
(define-protein "CDC27_HUMAN" ("Cell division cycle protein 27 homolog" "Anaphase-promoting complex subunit 3" "APC3" "CDC27 homolog" "CDC27Hs" "H-NUC"))
(define-protein "CDC37_HUMAN" ("Hsp90 co-chaperone Cdc37" "Hsp90 chaperone protein kinase-targeting subunit" "p50Cdc37"))
(define-protein "CDC42_HUMAN" ("Cell division control protein 42 homolog" "G25K GTP-binding protein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CDC5L_HUMAN" ("KIAA0432" "CDC5L" "PCDC5RP")) 
(define-protein "CDCP1_HUMAN" ("CDCP1" "TRASK" "SIMA135" "CD318")) 
(define-protein "CDIPT_HUMAN" ("PIS" "CDIPT" "PIS1")) 
(define-protein "CDK1_HUMAN" ("CDK1" "Cdk1" "P34CDC2" "CDC2" "CDKN1" "CDC28A")) 
(define-protein "CDK2_HUMAN" ("Cyclin-dependent kinase 2" "Cell division protein kinase 2" "p33 protein kinase" "CDK2" "Cdk2"))
<<<<<<< .mine
(define-protein "CDK2_HUMAN" ("Myc–kinase" "Cyclin-dependent kinase 2" "Cell division protein kinase 2" "p33 protein kinase"))
=======
<<<<<<< .mine
(define-protein "CDK2_HUMAN" ("Myc–kinase" "Cyclin-dependent kinase 2" "Cell division protein kinase 2" "p33 protein kinase"))
=======
(define-protein "CDK2_HUMAN" ("Cyclin-dependent kinase 2" "Cell division protein kinase 2" "p33 protein kinase"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CDK4_HUMAN" ("PSK-J3" "CDK4")) 
(define-protein "CDK5_HUMAN" ("CDKN5" "CDK5")) 
(define-protein "CDK6_HUMAN" ("Cyclin-dependent kinase 6" "Cell division protein kinase 6" "Serine/threonine-protein kinase PLSTIRE"))
<<<<<<< .mine
(define-protein "CDK6_HUMAN" ("cdk6" "Cyclin-dependent kinase 6" "Cell division protein kinase 6" "Serine/threonine-protein kinase PLSTIRE"))
(define-protein "CDKAL_HUMAN" ("A37" "Threonylcarbamoyladenosine tRNA methylthiotransferase" "CDK5 regulatory subunit-associated protein 1-like 1" "tRNA-t(6)A37 methylthiotransferase"))
(define-protein "CDN1A_HUMAN" ("waf" "Cyclin-dependent kinase inhibitor 1" "CDK-interacting protein 1" "Melanoma differentiation-associated protein 6" "MDA-6" "p21"))
(define-protein "CDN1C_HUMAN" ("p21Cip1" "Cyclin-dependent kinase inhibitor 1C" "Cyclin-dependent kinase inhibitor p57" "p57Kip2"))
(define-protein "CDN2A_HUMAN" ("p16Ink4a" "Cyclin-dependent kinase inhibitor 2A" "Cyclin-dependent kinase 4 inhibitor A" "CDK4I" "Multiple tumor suppressor 1" "MTS-1" "p16-INK4a" "p16-INK4" "p16INK4A"))
(define-protein "CDN2B_HUMAN" ("Ink4B" "Cyclin-dependent kinase 4 inhibitor B" "Multiple tumor suppressor 2" "MTS-2" "p14-INK4b" "p15-INK4b" "p15INK4B"))
(define-protein "CDN2C_HUMAN" ("ink4c" "Cyclin-dependent kinase 4 inhibitor C" "Cyclin-dependent kinase 6 inhibitor" "p18-INK4c" "p18-INK6"))
(define-protein "CDO1_HUMAN" ("cdo" "Cysteine dioxygenase type 1" "Cysteine dioxygenase type I" "CDO" "CDO-I"))
=======
<<<<<<< .mine
(define-protein "CDK6_HUMAN" ("cdk6" "Cyclin-dependent kinase 6" "Cell division protein kinase 6" "Serine/threonine-protein kinase PLSTIRE"))
(define-protein "CDKAL_HUMAN" ("A37" "Threonylcarbamoyladenosine tRNA methylthiotransferase" "CDK5 regulatory subunit-associated protein 1-like 1" "tRNA-t(6)A37 methylthiotransferase"))
(define-protein "CDN1A_HUMAN" ("waf" "Cyclin-dependent kinase inhibitor 1" "CDK-interacting protein 1" "Melanoma differentiation-associated protein 6" "MDA-6" "p21"))
(define-protein "CDN1C_HUMAN" ("p21Cip1" "Cyclin-dependent kinase inhibitor 1C" "Cyclin-dependent kinase inhibitor p57" "p57Kip2"))
(define-protein "CDN2A_HUMAN" ("p16Ink4a" "Cyclin-dependent kinase inhibitor 2A" "Cyclin-dependent kinase 4 inhibitor A" "CDK4I" "Multiple tumor suppressor 1" "MTS-1" "p16-INK4a" "p16-INK4" "p16INK4A"))
(define-protein "CDN2B_HUMAN" ("Ink4B" "Cyclin-dependent kinase 4 inhibitor B" "Multiple tumor suppressor 2" "MTS-2" "p14-INK4b" "p15-INK4b" "p15INK4B"))
(define-protein "CDN2C_HUMAN" ("ink4c" "Cyclin-dependent kinase 4 inhibitor C" "Cyclin-dependent kinase 6 inhibitor" "p18-INK4c" "p18-INK6"))
(define-protein "CDO1_HUMAN" ("cdo" "Cysteine dioxygenase type 1" "Cysteine dioxygenase type I" "CDO" "CDO-I"))
=======
(define-protein "CDKAL_HUMAN" ("Threonylcarbamoyladenosine tRNA methylthiotransferase" "CDK5 regulatory subunit-associated protein 1-like 1" "tRNA-t(6)A37 methylthiotransferase"))
(define-protein "CDN1A_HUMAN" ("Cyclin-dependent kinase inhibitor 1" "CDK-interacting protein 1" "Melanoma differentiation-associated protein 6" "MDA-6" "p21"))
(define-protein "CDN1C_HUMAN" ("Cyclin-dependent kinase inhibitor 1C" "Cyclin-dependent kinase inhibitor p57" "p57Kip2"))
(define-protein "CDN2A_HUMAN" ("Cyclin-dependent kinase inhibitor 2A" "Cyclin-dependent kinase 4 inhibitor A" "CDK4I" "Multiple tumor suppressor 1" "MTS-1" "p16-INK4a" "p16-INK4" "p16INK4A"))
(define-protein "CDN2B_HUMAN" ("Cyclin-dependent kinase 4 inhibitor B" "Multiple tumor suppressor 2" "MTS-2" "p14-INK4b" "p15-INK4b" "p15INK4B"))
(define-protein "CDN2C_HUMAN" ("Cyclin-dependent kinase 4 inhibitor C" "Cyclin-dependent kinase 6 inhibitor" "p18-INK4c" "p18-INK6"))
(define-protein "CDO1_HUMAN" ("Cysteine dioxygenase type 1" "Cysteine dioxygenase type I" "CDO" "CDO-I"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CDR2_HUMAN" ("Cerebellar degeneration-related protein 2" "Major Yo paraneoplastic antigen" "Paraneoplastic cerebellar degeneration-associated antigen"))
(define-protein "CDT1_HUMAN" ("Cdt1" "DNA replication factor Cdt1" "Double parked homolog" "DUP"))
(define-protein "CDT1_HUMAN" ("DNA replication factor Cdt1" "Double parked homolog" "DUP"))
<<<<<<< .mine
(define-protein "CE192_HUMAN" ("centrosomes" "Centrosomal protein of 192 kDa" "Cep192"))
(define-protein "CEBPA_HUMAN" ("C/EBPα" "CCAAT/enhancer-binding protein alpha" "C/EBP alpha"))
(define-protein "CEBPB_HUMAN" ("EBP-β" "CCAAT/enhancer-binding protein beta" "C/EBP beta" "Liver activator protein" "LAP" "Liver-enriched inhibitory protein" "LIP" "Nuclear factor NF-IL6" "Transcription factor 5" "TCF-5"))
(define-protein "CEBPZ_HUMAN" ("ccaat" "CCAAT/enhancer-binding protein zeta" "CCAAT-box-binding transcription factor" "CBF" "CCAAT-binding factor"))
=======
<<<<<<< .mine
(define-protein "CE192_HUMAN" ("centrosomes" "Centrosomal protein of 192 kDa" "Cep192"))
(define-protein "CEBPA_HUMAN" ("C/EBPα" "CCAAT/enhancer-binding protein alpha" "C/EBP alpha"))
(define-protein "CEBPB_HUMAN" ("EBP-β" "CCAAT/enhancer-binding protein beta" "C/EBP beta" "Liver activator protein" "LAP" "Liver-enriched inhibitory protein" "LIP" "Nuclear factor NF-IL6" "Transcription factor 5" "TCF-5"))
(define-protein "CEBPZ_HUMAN" ("ccaat" "CCAAT/enhancer-binding protein zeta" "CCAAT-box-binding transcription factor" "CBF" "CCAAT-binding factor"))
=======
(define-protein "CE192_HUMAN" ("Centrosomal protein of 192 kDa" "Cep192"))
(define-protein "CEBPA_HUMAN" ("CCAAT/enhancer-binding protein alpha" "C/EBP alpha"))
(define-protein "CEBPB_HUMAN" ("CCAAT/enhancer-binding protein beta" "C/EBP beta" "Liver activator protein" "LAP" "Liver-enriched inhibitory protein" "LIP" "Nuclear factor NF-IL6" "Transcription factor 5" "TCF-5"))
(define-protein "CEBPZ_HUMAN" ("CCAAT/enhancer-binding protein zeta" "CCAAT-box-binding transcription factor" "CBF" "CCAAT-binding factor"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CELF2_HUMAN" ("CUGBP Elav-like family member 2" "CELF-2" "Bruno-like protein 3" "CUG triplet repeat RNA-binding protein 2" "CUG-BP2" "CUG-BP- and ETR-3-like factor 2" "ELAV-type RNA-binding protein 3" "ETR-3" "Neuroblastoma apoptosis-related RNA-binding protein" "hNAPOR" "RNA-binding protein BRUNOL-3"))
<<<<<<< .mine
(define-protein "CELR3_HUMAN" ("celsr" "Cadherin EGF LAG seven-pass G-type receptor 3" "Cadherin family member 11" "Epidermal growth factor-like protein 1" "EGF-like protein 1" "Flamingo homolog 1" "hFmi1" "Multiple epidermal growth factor-like domains protein 2" "Multiple EGF-like domains protein 2"))
(define-protein "CENPA_HUMAN" ("cenpa" "Histone H3-like centromeric protein A" "Centromere autoantigen A" "Centromere protein A" "CENP-A"))
(define-protein "CENPJ_HUMAN" ("P4" "Centromere protein J" "CENP-J" "Centrosomal P4.1-associated protein" "LAG-3-associated protein" "LYST-interacting protein 1"))
(define-protein "CENPN_HUMAN" ("centromeres" "Centromere protein N" "CENP-N" "Interphase centromere complex protein 32"))
=======
<<<<<<< .mine
(define-protein "CELR3_HUMAN" ("celsr" "Cadherin EGF LAG seven-pass G-type receptor 3" "Cadherin family member 11" "Epidermal growth factor-like protein 1" "EGF-like protein 1" "Flamingo homolog 1" "hFmi1" "Multiple epidermal growth factor-like domains protein 2" "Multiple EGF-like domains protein 2"))
(define-protein "CENPA_HUMAN" ("cenpa" "Histone H3-like centromeric protein A" "Centromere autoantigen A" "Centromere protein A" "CENP-A"))
(define-protein "CENPJ_HUMAN" ("P4" "Centromere protein J" "CENP-J" "Centrosomal P4.1-associated protein" "LAG-3-associated protein" "LYST-interacting protein 1"))
(define-protein "CENPN_HUMAN" ("centromeres" "Centromere protein N" "CENP-N" "Interphase centromere complex protein 32"))
=======
(define-protein "CELR3_HUMAN" ("Cadherin EGF LAG seven-pass G-type receptor 3" "Cadherin family member 11" "Epidermal growth factor-like protein 1" "EGF-like protein 1" "Flamingo homolog 1" "hFmi1" "Multiple epidermal growth factor-like domains protein 2" "Multiple EGF-like domains protein 2"))
(define-protein "CENPA_HUMAN" ("Histone H3-like centromeric protein A" "Centromere autoantigen A" "Centromere protein A" "CENP-A"))
(define-protein "CENPJ_HUMAN" ("Centromere protein J" "CENP-J" "Centrosomal P4.1-associated protein" "LAG-3-associated protein" "LYST-interacting protein 1"))
(define-protein "CENPN_HUMAN" ("Centromere protein N" "CENP-N" "Interphase centromere complex protein 32"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CENPV_HUMAN" ("CENP-V" "PRR6" "CENPV")) 
<<<<<<< .mine
(define-protein "CEP97_HUMAN" ("modulators" "Centrosomal protein of 97 kDa" "Cep97" "Leucine-rich repeat and IQ domain-containing protein 2"))
(define-protein "CETN2_HUMAN" ("centrin" "Centrin-2" "Caltractin isoform 1"))
(define-protein "CFLAR_HUMAN" ("cflar" "CASP8 and FADD-like apoptosis regulator" "Caspase homolog" "CASH" "Caspase-eight-related protein" "Casper" "Caspase-like apoptosis regulatory protein" "CLARP" "Cellular FLICE-like inhibitory protein" "c-FLIP" "FADD-like antiapoptotic molecule 1" "FLAME-1" "Inhibitor of FLICE" "I-FLICE" "MACH-related inducer of toxicity" "MRIT" "Usurpin"))
=======
<<<<<<< .mine
(define-protein "CEP97_HUMAN" ("modulators" "Centrosomal protein of 97 kDa" "Cep97" "Leucine-rich repeat and IQ domain-containing protein 2"))
(define-protein "CETN2_HUMAN" ("centrin" "Centrin-2" "Caltractin isoform 1"))
(define-protein "CFLAR_HUMAN" ("cflar" "CASP8 and FADD-like apoptosis regulator" "Caspase homolog" "CASH" "Caspase-eight-related protein" "Casper" "Caspase-like apoptosis regulatory protein" "CLARP" "Cellular FLICE-like inhibitory protein" "c-FLIP" "FADD-like antiapoptotic molecule 1" "FLAME-1" "Inhibitor of FLICE" "I-FLICE" "MACH-related inducer of toxicity" "MRIT" "Usurpin"))
=======
(define-protein "CEP97_HUMAN" ("Centrosomal protein of 97 kDa" "Cep97" "Leucine-rich repeat and IQ domain-containing protein 2"))
(define-protein "CETN2_HUMAN" ("Centrin-2" "Caltractin isoform 1"))
(define-protein "CFLAR_HUMAN" ("CASP8 and FADD-like apoptosis regulator" "Caspase homolog" "CASH" "Caspase-eight-related protein" "Casper" "Caspase-like apoptosis regulatory protein" "CLARP" "Cellular FLICE-like inhibitory protein" "c-FLIP" "FADD-like antiapoptotic molecule 1" "FLAME-1" "Inhibitor of FLICE" "I-FLICE" "MACH-related inducer of toxicity" "MRIT" "Usurpin"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CH033_HUMAN" ("C8orf33")) 
<<<<<<< .mine
(define-protein "CH10_HUMAN" ("groes" "10 kDa heat shock protein, mitochondrial" "Hsp10" "10 kDa chaperonin" "Chaperonin 10" "CPN10" "Early-pregnancy factor" "EPF"))
(define-protein "CH3L1_HUMAN" ("oligomers" "Chitinase-3-like protein 1" "39 kDa synovial protein" "Cartilage glycoprotein 39" "CGP-39" "GP-39" "hCGP-39" "YKL-40"))
(define-protein "CH60_HUMAN" ("rubisco" "60 kDa heat shock protein, mitochondrial" "60 kDa chaperonin" "Chaperonin 60" "CPN60" "Heat shock protein 60" "HSP-60" "Hsp60" "HuCHA60" "Mitochondrial matrix protein P1" "P60 lymphocyte protein"))
=======
<<<<<<< .mine
(define-protein "CH10_HUMAN" ("groes" "10 kDa heat shock protein, mitochondrial" "Hsp10" "10 kDa chaperonin" "Chaperonin 10" "CPN10" "Early-pregnancy factor" "EPF"))
(define-protein "CH3L1_HUMAN" ("oligomers" "Chitinase-3-like protein 1" "39 kDa synovial protein" "Cartilage glycoprotein 39" "CGP-39" "GP-39" "hCGP-39" "YKL-40"))
(define-protein "CH60_HUMAN" ("rubisco" "60 kDa heat shock protein, mitochondrial" "60 kDa chaperonin" "Chaperonin 60" "CPN60" "Heat shock protein 60" "HSP-60" "Hsp60" "HuCHA60" "Mitochondrial matrix protein P1" "P60 lymphocyte protein"))
=======
(define-protein "CH10_HUMAN" ("10 kDa heat shock protein, mitochondrial" "Hsp10" "10 kDa chaperonin" "Chaperonin 10" "CPN10" "Early-pregnancy factor" "EPF"))
(define-protein "CH3L1_HUMAN" ("Chitinase-3-like protein 1" "39 kDa synovial protein" "Cartilage glycoprotein 39" "CGP-39" "GP-39" "hCGP-39" "YKL-40"))
(define-protein "CH60_HUMAN" ("60 kDa heat shock protein, mitochondrial" "60 kDa chaperonin" "Chaperonin 60" "CPN60" "Heat shock protein 60" "HSP-60" "Hsp60" "HuCHA60" "Mitochondrial matrix protein P1" "P60 lymphocyte protein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CHD3_HUMAN" ("CHD-3" "hZFH" "Mi2-alpha" "CHD3")) 
(define-protein "CHD4_HUMAN" ("CHD-4" "Mi2-beta" "CHD4")) 
(define-protein "CHK1_HUMAN" ("Serine/threonine-protein kinase Chk1" "CHK1 checkpoint homolog" "Cell cycle checkpoint kinase" "Checkpoint kinase-1"))
(define-protein "CHK2_HUMAN" ("CHEK2" "CDS1" "CHK2" "Chk2" "RAD53")) 
<<<<<<< .mine
(define-protein "CHLE_HUMAN" ("bche" "Cholinesterase" "Acylcholine acylhydrolase" "Butyrylcholine esterase" "Choline esterase II" "Pseudocholinesterase"))
=======
<<<<<<< .mine
(define-protein "CHLE_HUMAN" ("bche" "Cholinesterase" "Acylcholine acylhydrolase" "Butyrylcholine esterase" "Choline esterase II" "Pseudocholinesterase"))
=======
(define-protein "CHLE_HUMAN" ("Cholinesterase" "Acylcholine acylhydrolase" "Butyrylcholine esterase" "Choline esterase II" "Pseudocholinesterase"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CHM1A_HUMAN" ("Vps46-1" "PCOLN3" "CHMP1a" "KIAA0047" "PRSM1" "CHMP1" "hVps46-1" "CHMP1A")) 
(define-protein "CHM1B_HUMAN" ("CHMP1b" "CHMP1.5" "Vps46-2" "CHMP1B" "C18orf2" "hVps46-2")) 
(define-protein "CHM2A_HUMAN" ("hVps2-1" "CHMP2A" "CHMP2" "Vps2-1" "CHMP2a" "BC2")) 
(define-protein "CHM4B_HUMAN" ("SNF7-2" "CHMP4b" "C20orf178" "SHAX1" "hSnf7-2" "hVps32-2" "Vps32-2" "CHMP4B")) 
(define-protein "CHMP5_HUMAN" ("hVps60" "Vps60" "SNF7DC2" "C9orf83" "CHMP5")) 
(define-protein "CHMP6_HUMAN" ("VPS20" "Vps20" "hVps20" "CHMP6")) 
(define-protein "CHP1_HUMAN" ("CHP1" "CHP")) 
(define-protein "CI009_HUMAN" ("C9orf9")) 
(define-protein "CIB1_HUMAN" ("CIBP" "CIB" "KIP" "Calmyrin" "CIB1" "PRKDCIP" "SIP2-28")) 
<<<<<<< .mine
(define-protein "CIC_HUMAN" ("cic" "Protein capicua homolog"))
(define-protein "CIDEA_HUMAN" ("cidea" "Cell death activator CIDE-A" "Cell death-inducing DFFA-like effector A"))
(define-protein "CIP2A_HUMAN" ("cip2A" "Protein CIP2A" "Cancerous inhibitor of PP2A" "p90 autoantigen"))
=======
<<<<<<< .mine
(define-protein "CIC_HUMAN" ("cic" "Protein capicua homolog"))
(define-protein "CIDEA_HUMAN" ("cidea" "Cell death activator CIDE-A" "Cell death-inducing DFFA-like effector A"))
(define-protein "CIP2A_HUMAN" ("cip2A" "Protein CIP2A" "Cancerous inhibitor of PP2A" "p90 autoantigen"))
=======
(define-protein "CIC_HUMAN" ("Protein capicua homolog"))
(define-protein "CIDEA_HUMAN" ("Cell death activator CIDE-A" "Cell death-inducing DFFA-like effector A"))
(define-protein "CIP2A_HUMAN" ("Protein CIP2A" "Cancerous inhibitor of PP2A" "p90 autoantigen"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CISD2_HUMAN" ("Miner1" "ZCD2" "CISD2" "NAF-1" "CDGSH2" "ERIS")) 
(define-protein "CKAP5_HUMAN" ("Ch-TOG" "CKAP5" "KIAA0097")) 
(define-protein "CL045_HUMAN" ("C12orf45")) 
(define-protein "CLAP2_HUMAN" ("hOrbit2" "KIAA0627" "CLASP2")) 
<<<<<<< .mine
(define-protein "CLC4K_HUMAN" ("fungi" "C-type lectin domain family 4 member K" "Langerin"))
(define-protein "CLC6A_HUMAN" ("C-type lectin domain family 6 member A" "C-type lectin superfamily member 10" "Dendritic cell-associated C-type lectin 2" "DC-associated C-type lectin 2" "Dectin-2"))
(define-protein "CLCA2_HUMAN" ("monolayers" "Calcium-activated chloride channel regulator 2" "Calcium-activated chloride channel family member 2" "hCLCA2" "Calcium-activated chloride channel protein 3" "CaCC-3" "hCaCC-3"))
=======
<<<<<<< .mine
(define-protein "CLC4K_HUMAN" ("fungi" "C-type lectin domain family 4 member K" "Langerin"))
(define-protein "CLC6A_HUMAN" ("C-type lectin domain family 6 member A" "C-type lectin superfamily member 10" "Dendritic cell-associated C-type lectin 2" "DC-associated C-type lectin 2" "Dectin-2"))
(define-protein "CLCA2_HUMAN" ("monolayers" "Calcium-activated chloride channel regulator 2" "Calcium-activated chloride channel family member 2" "hCLCA2" "Calcium-activated chloride channel protein 3" "CaCC-3" "hCaCC-3"))
=======
(define-protein "CLC4K_HUMAN" ("C-type lectin domain family 4 member K" "Langerin"))
(define-protein "CLC6A_HUMAN" ("C-type lectin domain family 6 member A" "C-type lectin superfamily member 10" "Dendritic cell-associated C-type lectin 2" "DC-associated C-type lectin 2" "Dectin-2"))
(define-protein "CLCA2_HUMAN" ("Calcium-activated chloride channel regulator 2" "Calcium-activated chloride channel family member 2" "hCLCA2" "Calcium-activated chloride channel protein 3" "CaCC-3" "hCaCC-3"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CLCA_HUMAN" ("Lca" "CLTA")) 
<<<<<<< .mine
(define-protein "CLCN5_HUMAN" ("proteinuria" "H(+)/Cl(-) exchange transporter 5" "Chloride channel protein 5" "ClC-5" "Chloride transporter ClC-5"))
=======
<<<<<<< .mine
(define-protein "CLCN5_HUMAN" ("proteinuria" "H(+)/Cl(-) exchange transporter 5" "Chloride channel protein 5" "ClC-5" "Chloride transporter ClC-5"))
=======
(define-protein "CLCN5_HUMAN" ("H(+)/Cl(-) exchange transporter 5" "Chloride channel protein 5" "ClC-5" "Chloride transporter ClC-5"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CLCN7_HUMAN" ("CLCN7" "ClC-7")) 
<<<<<<< .mine
(define-protein "CLD1_HUMAN" ("claudin-1" "Claudin-1" "Senescence-associated epithelial membrane protein"))
=======
<<<<<<< .mine
(define-protein "CLD1_HUMAN" ("claudin-1" "Claudin-1" "Senescence-associated epithelial membrane protein"))
=======
(define-protein "CLD1_HUMAN" ("Claudin-1" "Senescence-associated epithelial membrane protein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CLH1_HUMAN" ("KIAA0034" "CLH-17" "CLTC" "CLH17" "CLTCL2")) 
(define-protein "CLIC1_HUMAN" ("hRNCC" "NCC27" "CLIC1" "G6")) 
<<<<<<< .mine
(define-protein "CLIP1_HUMAN" ("CLIP170" "CAP-Gly domain-containing linker protein 1" "Cytoplasmic linker protein 1" "Cytoplasmic linker protein 170 alpha-2" "CLIP-170" "Reed-Sternberg intermediate filament-associated protein" "Restin"))
=======
<<<<<<< .mine
(define-protein "CLIP1_HUMAN" ("CLIP170" "CAP-Gly domain-containing linker protein 1" "Cytoplasmic linker protein 1" "Cytoplasmic linker protein 170 alpha-2" "CLIP-170" "Reed-Sternberg intermediate filament-associated protein" "Restin"))
=======
(define-protein "CLIP1_HUMAN" ("CAP-Gly domain-containing linker protein 1" "Cytoplasmic linker protein 1" "Cytoplasmic linker protein 170 alpha-2" "CLIP-170" "Reed-Sternberg intermediate filament-associated protein" "Restin"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CLIP4_HUMAN" ("CLIP4" "RSNL2")) 
<<<<<<< .mine
(define-protein "CLK1_HUMAN" ("Clk1" "Dual specificity protein kinase CLK1" "CDC-like kinase 1"))
=======
<<<<<<< .mine
(define-protein "CLK1_HUMAN" ("Clk1" "Dual specificity protein kinase CLK1" "CDC-like kinase 1"))
=======
(define-protein "CLK1_HUMAN" ("Dual specificity protein kinase CLK1" "CDC-like kinase 1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CLN5_HUMAN" ("CLN5")) 
<<<<<<< .mine
(define-protein "CLPX_HUMAN" ("clpx" "ATP-dependent Clp protease ATP-binding subunit clpX-like, mitochondrial"))
(define-protein "CLSPN_HUMAN" ("claspin" "Claspin" "hClaspin"))
(define-protein "CLU_HUMAN" ("mitochondria" "Clustered mitochondria protein homolog"))
(define-protein "CMGA_HUMAN" ("cga" "Chromogranin-A" "CgA" "Pituitary secretory protein I" "SP-I"))
(define-protein "CNBP1_HUMAN" ("icat" "Beta-catenin-interacting protein 1" "Inhibitor of beta-catenin and Tcf-4"))
(define-protein "CND1_HUMAN" ("bipartite" "Condensin complex subunit 1" "Chromosome condensation-related SMC-associated protein 1" "Chromosome-associated protein D2" "hCAP-D2" "Non-SMC condensin I complex subunit D2" "XCAP-D2 homolog"))
=======
<<<<<<< .mine
(define-protein "CLPX_HUMAN" ("clpx" "ATP-dependent Clp protease ATP-binding subunit clpX-like, mitochondrial"))
(define-protein "CLSPN_HUMAN" ("claspin" "Claspin" "hClaspin"))
(define-protein "CLU_HUMAN" ("mitochondria" "Clustered mitochondria protein homolog"))
(define-protein "CMGA_HUMAN" ("cga" "Chromogranin-A" "CgA" "Pituitary secretory protein I" "SP-I"))
(define-protein "CNBP1_HUMAN" ("icat" "Beta-catenin-interacting protein 1" "Inhibitor of beta-catenin and Tcf-4"))
(define-protein "CND1_HUMAN" ("bipartite" "Condensin complex subunit 1" "Chromosome condensation-related SMC-associated protein 1" "Chromosome-associated protein D2" "hCAP-D2" "Non-SMC condensin I complex subunit D2" "XCAP-D2 homolog"))
=======
(define-protein "CLPX_HUMAN" ("ATP-dependent Clp protease ATP-binding subunit clpX-like, mitochondrial"))
(define-protein "CLSPN_HUMAN" ("Claspin" "hClaspin"))
(define-protein "CLU_HUMAN" ("Clustered mitochondria protein homolog"))
(define-protein "CMGA_HUMAN" ("Chromogranin-A" "CgA" "Pituitary secretory protein I" "SP-I"))
(define-protein "CNBP1_HUMAN" ("Beta-catenin-interacting protein 1" "Inhibitor of beta-catenin and Tcf-4"))
(define-protein "CND1_HUMAN" ("Condensin complex subunit 1" "Chromosome condensation-related SMC-associated protein 1" "Chromosome-associated protein D2" "hCAP-D2" "Non-SMC condensin I complex subunit D2" "XCAP-D2 homolog"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CND3_HUMAN" ("CAPG" "NYMEL3" "hCAP-G" "NCAPG")) 
(define-protein "CNN2_HUMAN" ("CNN2")) 
<<<<<<< .mine
(define-protein "CNO11_HUMAN" ("C2ORF29" "CCR4-NOT transcription complex subunit 11"))
(define-protein "CNOT1_HUMAN" ("Not1" "CCR4-NOT transcription complex subunit 1" "CCR4-associated factor 1" "Negative regulator of transcription subunit 1 homolog" "NOT1H" "hNOT1"))
(define-protein "CNOT3_HUMAN" ("orthologs" "CCR4-NOT transcription complex subunit 3" "CCR4-associated factor 3" "Leukocyte receptor cluster member 2"))
(define-protein "CNOT4_HUMAN" ("ligases" "CCR4-NOT transcription complex subunit 4" "CCR4-associated factor 4" "E3 ubiquitin-protein ligase CNOT4" "Potential transcriptional repressor NOT4Hp"))
(define-protein "CNOT6_HUMAN" ("Ccr4" "CCR4-NOT transcription complex subunit 6" "CCR4 carbon catabolite repression 4-like" "Carbon catabolite repressor protein 4 homolog" "Cytoplasmic deadenylase"))
(define-protein "CNOT7_HUMAN" ("Caf1" "CCR4-NOT transcription complex subunit 7" "BTG1-binding factor 1" "CCR4-associated factor 1" "CAF-1" "Caf1a"))
=======
<<<<<<< .mine
(define-protein "CNO11_HUMAN" ("C2ORF29" "CCR4-NOT transcription complex subunit 11"))
(define-protein "CNOT1_HUMAN" ("Not1" "CCR4-NOT transcription complex subunit 1" "CCR4-associated factor 1" "Negative regulator of transcription subunit 1 homolog" "NOT1H" "hNOT1"))
(define-protein "CNOT3_HUMAN" ("orthologs" "CCR4-NOT transcription complex subunit 3" "CCR4-associated factor 3" "Leukocyte receptor cluster member 2"))
(define-protein "CNOT4_HUMAN" ("ligases" "CCR4-NOT transcription complex subunit 4" "CCR4-associated factor 4" "E3 ubiquitin-protein ligase CNOT4" "Potential transcriptional repressor NOT4Hp"))
(define-protein "CNOT6_HUMAN" ("Ccr4" "CCR4-NOT transcription complex subunit 6" "CCR4 carbon catabolite repression 4-like" "Carbon catabolite repressor protein 4 homolog" "Cytoplasmic deadenylase"))
(define-protein "CNOT7_HUMAN" ("Caf1" "CCR4-NOT transcription complex subunit 7" "BTG1-binding factor 1" "CCR4-associated factor 1" "CAF-1" "Caf1a"))
=======
(define-protein "CNO11_HUMAN" ("CCR4-NOT transcription complex subunit 11"))
(define-protein "CNOT1_HUMAN" ("CCR4-NOT transcription complex subunit 1" "CCR4-associated factor 1" "Negative regulator of transcription subunit 1 homolog" "NOT1H" "hNOT1"))
(define-protein "CNOT3_HUMAN" ("CCR4-NOT transcription complex subunit 3" "CCR4-associated factor 3" "Leukocyte receptor cluster member 2"))
(define-protein "CNOT4_HUMAN" ("CCR4-NOT transcription complex subunit 4" "CCR4-associated factor 4" "E3 ubiquitin-protein ligase CNOT4" "Potential transcriptional repressor NOT4Hp"))
(define-protein "CNOT6_HUMAN" ("CCR4-NOT transcription complex subunit 6" "CCR4 carbon catabolite repression 4-like" "Carbon catabolite repressor protein 4 homolog" "Cytoplasmic deadenylase"))
(define-protein "CNOT7_HUMAN" ("CCR4-NOT transcription complex subunit 7" "BTG1-binding factor 1" "CCR4-associated factor 1" "CAF-1" "Caf1a"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CNOT8_HUMAN" ("CAF2" "CNOT8" "CALIF" "POP2" "CALIFp" "Caf1b")) 
(define-protein "CNPY3_HUMAN" ("CNPY3" "ERDA5" "TNRC5" "CTG4A" "PRAT4A")) 
<<<<<<< .mine
(define-protein "CO3_HUMAN" ("c-" "Complement C3" "C3 and PZP-like alpha-2-macroglobulin domain-containing protein 1"))
(define-protein "CO4A2_HUMAN" ("αvβ5" "Collagen alpha-2(IV) chain"))
(define-protein "CO4A4_HUMAN" ("collagens" "Collagen alpha-4(IV) chain"))
=======
<<<<<<< .mine
(define-protein "CO3_HUMAN" ("c-" "Complement C3" "C3 and PZP-like alpha-2-macroglobulin domain-containing protein 1"))
(define-protein "CO4A2_HUMAN" ("αvβ5" "Collagen alpha-2(IV) chain"))
(define-protein "CO4A4_HUMAN" ("collagens" "Collagen alpha-4(IV) chain"))
=======
(define-protein "CO3_HUMAN" ("Complement C3" "C3 and PZP-like alpha-2-macroglobulin domain-containing protein 1"))
(define-protein "CO4A2_HUMAN" ("Collagen alpha-2(IV) chain"))
(define-protein "CO4A4_HUMAN" ("Collagen alpha-4(IV) chain"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "COBL1_HUMAN" ("COBLL1" "KIAA0977")) 
(define-protein "COF1_HUMAN" ("CFL1" "p18" "CFL")) 
(define-protein "COG4_HUMAN" ("COG4")) 
(define-protein "COG5_HUMAN" ("Conserved oligomeric Golgi complex subunit 5" "COG complex subunit 5" "13S Golgi transport complex 90 kDa subunit" "GTC-90" "Component of oligomeric Golgi complex 5" "Golgi transport complex 1"))
(define-protein "COG5_HUMAN" ("GTC-90" "GTC90" "COG5" "GOLTC1")) 
(define-protein "COHA1_HUMAN" ("Collagen alpha-1(XVII) chain" "180 kDa bullous pemphigoid antigen 2" "Bullous pemphigoid antigen 2"))
(define-protein "COHA1_HUMAN" ("kda" "Collagen alpha-1(XVII) chain" "180 kDa bullous pemphigoid antigen 2" "Bullous pemphigoid antigen 2"))
(define-protein "COMD3_HUMAN" ("C10orf8" "COMMD3" "BUP")) 
<<<<<<< .mine
(define-protein "COMP_HUMAN" ("collagen-1" "Cartilage oligomeric matrix protein" "COMP" "Thrombospondin-5" "TSP5"))
=======
<<<<<<< .mine
(define-protein "COMP_HUMAN" ("collagen-1" "Cartilage oligomeric matrix protein" "COMP" "Thrombospondin-5" "TSP5"))
=======
(define-protein "COMP_HUMAN" ("Cartilage oligomeric matrix protein" "COMP" "Thrombospondin-5" "TSP5"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "COPA_HUMAN" ("COPA" "Xenin" "Proxenin" "HEP-COP" "HEPCOP" "Alpha-COP")) 
(define-protein "COPB2_HUMAN" ("p102" "Beta'-COP" "COPB2")) 
(define-protein "COPB_HUMAN" ("Beta-COP" "COPB1" "COPB")) 
(define-protein "COPD_HUMAN" ("ARCN1" "Archain" "Delta-COP" "COPD")) 
(define-protein "COPE_HUMAN" ("Epsilon-COP" "COPE")) 
(define-protein "COPG1_HUMAN" ("COPG1" "Gamma-1-COP" "COPG")) 
(define-protein "COPZ1_HUMAN" ("COPZ1" "COPZ")) 
<<<<<<< .mine
(define-protein "COQ6_HUMAN" ("Q10" "Ubiquinone biosynthesis monooxygenase COQ6, mitochondrial" "Coenzyme Q10 monooxygenase 6"))
(define-protein "COR1A_HUMAN" ("p57" "Coronin-1A" "Coronin-like protein A" "Clipin-A" "Coronin-like protein p57" "Tryptophan aspartate-containing coat protein" "TACO"))
(define-protein "COX3_HUMAN" ("coxiii" "Cytochrome c oxidase subunit 3" "Cytochrome c oxidase polypeptide III"))
=======
<<<<<<< .mine
(define-protein "COQ6_HUMAN" ("Q10" "Ubiquinone biosynthesis monooxygenase COQ6, mitochondrial" "Coenzyme Q10 monooxygenase 6"))
(define-protein "COR1A_HUMAN" ("p57" "Coronin-1A" "Coronin-like protein A" "Clipin-A" "Coronin-like protein p57" "Tryptophan aspartate-containing coat protein" "TACO"))
(define-protein "COX3_HUMAN" ("coxiii" "Cytochrome c oxidase subunit 3" "Cytochrome c oxidase polypeptide III"))
=======
(define-protein "COQ6_HUMAN" ("Ubiquinone biosynthesis monooxygenase COQ6, mitochondrial" "Coenzyme Q10 monooxygenase 6"))
(define-protein "COR1A_HUMAN" ("Coronin-1A" "Coronin-like protein A" "Clipin-A" "Coronin-like protein p57" "Tryptophan aspartate-containing coat protein" "TACO"))
(define-protein "COX3_HUMAN" ("Cytochrome c oxidase subunit 3" "Cytochrome c oxidase polypeptide III"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CP11A_HUMAN" ("Cholesterol side-chain cleavage enzyme, mitochondrial" "CYPXIA1" "Cholesterol desmolase" "Cytochrome P450 11A1" "Cytochrome P450(scc)"))
<<<<<<< .mine
(define-protein "CP11A_HUMAN" ("pregnenolone" "Cholesterol side-chain cleavage enzyme, mitochondrial" "CYPXIA1" "Cholesterol desmolase" "Cytochrome P450 11A1" "Cytochrome P450(scc)"))
(define-protein "CP131_HUMAN" ("CEP131" "Centrosomal protein of 131 kDa" "5-azacytidine-induced protein 1" "Pre-acrosome localization protein 1"))
(define-protein "CP19A_HUMAN" ("androstenedione" "Aromatase" "CYPXIX" "Cytochrome P-450AROM" "Cytochrome P450 19A1" "Estrogen synthase"))
=======
<<<<<<< .mine
(define-protein "CP11A_HUMAN" ("pregnenolone" "Cholesterol side-chain cleavage enzyme, mitochondrial" "CYPXIA1" "Cholesterol desmolase" "Cytochrome P450 11A1" "Cytochrome P450(scc)"))
(define-protein "CP131_HUMAN" ("CEP131" "Centrosomal protein of 131 kDa" "5-azacytidine-induced protein 1" "Pre-acrosome localization protein 1"))
(define-protein "CP19A_HUMAN" ("Aromatase" "CYPXIX" "Cytochrome P-450AROM" "Cytochrome P450 19A1" "Estrogen synthase"))
=======
(define-protein "CP131_HUMAN" ("Centrosomal protein of 131 kDa" "5-azacytidine-induced protein 1" "Pre-acrosome localization protein 1"))
(define-protein "CP19A_HUMAN" ("Aromatase" "CYPXIX" "Cytochrome P-450AROM" "Cytochrome P450 19A1" "Estrogen synthase"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CP1A1_HUMAN" ("Cytochrome P450 1A1" "CYPIA1" "Cytochrome P450 form 6" "Cytochrome P450-C" "Cytochrome P450-P1"))
<<<<<<< .mine
(define-protein "CP1A1_HUMAN" ("pyrene" "Cytochrome P450 1A1" "CYPIA1" "Cytochrome P450 form 6" "Cytochrome P450-C" "Cytochrome P450-P1"))
(define-protein "CP1B1_HUMAN" ("17β-estradiol" "Cytochrome P450 1B1" "CYPIB1"))
=======
<<<<<<< .mine
(define-protein "CP1A1_HUMAN" ("pyrene" "Cytochrome P450 1A1" "CYPIA1" "Cytochrome P450 form 6" "Cytochrome P450-C" "Cytochrome P450-P1"))
(define-protein "CP1B1_HUMAN" ("17β-estradiol" "Cytochrome P450 1B1" "CYPIB1"))
=======
(define-protein "CP1B1_HUMAN" ("Cytochrome P450 1B1" "CYPIB1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CP2J2_HUMAN" ("Cytochrome P450 2J2" "Arachidonic acid epoxygenase" "CYPIIJ2"))
<<<<<<< .mine
(define-protein "CP3A4_HUMAN" ("CYP3A" "Cytochrome P450 3A4" "1,8-cineole 2-exo-monooxygenase" "Albendazole monooxygenase" "Albendazole sulfoxidase" "CYPIIIA3" "CYPIIIA4" "Cytochrome P450 3A3" "Cytochrome P450 HLp" "Cytochrome P450 NF-25" "Cytochrome P450-PCN1" "Nifedipine oxidase" "Quinine 3-monooxygenase" "Taurochenodeoxycholate 6-alpha-hydroxylase"))
=======
<<<<<<< .mine
(define-protein "CP3A4_HUMAN" ("CYP3A" "Cytochrome P450 3A4" "1,8-cineole 2-exo-monooxygenase" "Albendazole monooxygenase" "Albendazole sulfoxidase" "CYPIIIA3" "CYPIIIA4" "Cytochrome P450 3A3" "Cytochrome P450 HLp" "Cytochrome P450 NF-25" "Cytochrome P450-PCN1" "Nifedipine oxidase" "Quinine 3-monooxygenase" "Taurochenodeoxycholate 6-alpha-hydroxylase"))
=======
(define-protein "CP3A4_HUMAN" ("Cytochrome P450 3A4" "1,8-cineole 2-exo-monooxygenase" "Albendazole monooxygenase" "Albendazole sulfoxidase" "CYPIIIA3" "CYPIIIA4" "Cytochrome P450 3A3" "Cytochrome P450 HLp" "Cytochrome P450 NF-25" "Cytochrome P450-PCN1" "Nifedipine oxidase" "Quinine 3-monooxygenase" "Taurochenodeoxycholate 6-alpha-hydroxylase"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CP7A1_HUMAN" ("Cholesterol 7-alpha-monooxygenase" "CYPVII" "Cholesterol 7-alpha-hydroxylase" "Cytochrome P450 7A1"))
(define-protein "CPLX1_HUMAN" ("Synaphin-2" "CPLX1")) 
(define-protein "CPNE1_HUMAN" ("CPNE1" "CPN1")) 
(define-protein "CPNE3_HUMAN" ("CPNE3" "KIAA0636" "CPN3")) 
<<<<<<< .mine
(define-protein "CPSF5_HUMAN" ("hdacs" "Cleavage and polyadenylation specificity factor subunit 5" "Cleavage and polyadenylation specificity factor 25 kDa subunit" "CFIm25" "CPSF 25 kDa subunit" "Nucleoside diphosphate-linked moiety X motif 21" "Nudix motif 21" "Pre-mRNA cleavage factor Im 25 kDa subunit"))
=======
<<<<<<< .mine
(define-protein "CPSF5_HUMAN" ("hdacs" "Cleavage and polyadenylation specificity factor subunit 5" "Cleavage and polyadenylation specificity factor 25 kDa subunit" "CFIm25" "CPSF 25 kDa subunit" "Nucleoside diphosphate-linked moiety X motif 21" "Nudix motif 21" "Pre-mRNA cleavage factor Im 25 kDa subunit"))
=======
(define-protein "CPSF5_HUMAN" ("Cleavage and polyadenylation specificity factor subunit 5" "Cleavage and polyadenylation specificity factor 25 kDa subunit" "CFIm25" "CPSF 25 kDa subunit" "Nucleoside diphosphate-linked moiety X motif 21" "Nudix motif 21" "Pre-mRNA cleavage factor Im 25 kDa subunit"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CPT1A_HUMAN" ("CPT1-L" "CPTI-L" "CPT1" "CPT1A")) 
<<<<<<< .mine
(define-protein "CPZIP_HUMAN" ("capz" "CapZ-interacting protein" "Protein kinase substrate CapZIP" "RCSD domain-containing protein 1"))
=======
<<<<<<< .mine
(define-protein "CPZIP_HUMAN" ("capz" "CapZ-interacting protein" "Protein kinase substrate CapZIP" "RCSD domain-containing protein 1"))
=======
(define-protein "CPZIP_HUMAN" ("CapZ-interacting protein" "Protein kinase substrate CapZIP" "RCSD domain-containing protein 1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CQ085_HUMAN" ("C17orf85")) 
<<<<<<< .mine
(define-protein "CR1_HUMAN" ("C3b" "Complement receptor type 1" "C3b/C4b receptor"))
(define-protein "CRBA1_HUMAN" ("A3" "Beta-crystallin A3"))
(define-protein "CRBB2_HUMAN" ("punctate" "Beta-crystallin B2" "Beta-B2 crystallin" "Beta-crystallin Bp"))
=======
<<<<<<< .mine
(define-protein "CR1_HUMAN" ("C3b" "Complement receptor type 1" "C3b/C4b receptor"))
(define-protein "CRBA1_HUMAN" ("A3" "Beta-crystallin A3"))
(define-protein "CRBB2_HUMAN" ("punctate" "Beta-crystallin B2" "Beta-B2 crystallin" "Beta-crystallin Bp"))
=======
(define-protein "CR1_HUMAN" ("Complement receptor type 1" "C3b/C4b receptor"))
(define-protein "CRBA1_HUMAN" ("Beta-crystallin A3"))
(define-protein "CRBB2_HUMAN" ("Beta-crystallin B2" "Beta-B2 crystallin" "Beta-crystallin Bp"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CREB1_HUMAN" ("Cyclic AMP-responsive element-binding protein 1" "CREB-1" "cAMP-responsive element-binding protein 1"))
<<<<<<< .mine
(define-protein "CRGC_HUMAN" ("crystallin" "Gamma-crystallin C" "Gamma-C-crystallin" "Gamma-crystallin 2-1" "Gamma-crystallin 3"))
(define-protein "CRLF1_HUMAN" ("FN3" "Cytokine receptor-like factor 1" "Cytokine-like factor 1" "CLF-1" "ZcytoR5"))
(define-protein "CRLF3_HUMAN" ("Myc-tagged" "Cytokine receptor-like factor 3" "Cytokine receptor-like molecule 9" "CREME-9" "Cytokine receptor-related protein 4" "Type I cytokine receptor-like factor p48"))
(define-protein "CRTC3_HUMAN" ("transducers" "CREB-regulated transcription coactivator 3" "Transducer of regulated cAMP response element-binding protein 3" "TORC-3" "Transducer of CREB protein 3"))
(define-protein "CRY1_HUMAN" ("versa" "Cryptochrome-1"))
(define-protein "CSAG2_HUMAN" ("RPMI8226" "Chondrosarcoma-associated gene 2/3 protein" "Cancer/testis antigen 24.2" "CT24.2" "Taxol-resistant-associated gene 3 protein" "TRAG-3"))
(define-protein "CSC1_HUMAN" ("CSC-1" "Calcium permeable stress-gated cation channel 1" "Transmembrane protein 63C"))
(define-protein "CSF1R_HUMAN" ("dfg" "Macrophage colony-stimulating factor 1 receptor" "CSF-1 receptor" "CSF-1-R" "CSF-1R" "M-CSF-R" "Proto-oncogene c-Fms"))
(define-protein "CSF3R_HUMAN" ("G-CSF" "Granulocyte colony-stimulating factor receptor" "G-CSF receptor" "G-CSF-R"))
=======
<<<<<<< .mine
(define-protein "CRGC_HUMAN" ("crystallin" "Gamma-crystallin C" "Gamma-C-crystallin" "Gamma-crystallin 2-1" "Gamma-crystallin 3"))
(define-protein "CRLF1_HUMAN" ("FN3" "Cytokine receptor-like factor 1" "Cytokine-like factor 1" "CLF-1" "ZcytoR5"))
(define-protein "CRLF3_HUMAN" ("Myc-tagged" "Cytokine receptor-like factor 3" "Cytokine receptor-like molecule 9" "CREME-9" "Cytokine receptor-related protein 4" "Type I cytokine receptor-like factor p48"))
(define-protein "CRTC3_HUMAN" ("transducers" "CREB-regulated transcription coactivator 3" "Transducer of regulated cAMP response element-binding protein 3" "TORC-3" "Transducer of CREB protein 3"))
(define-protein "CRY1_HUMAN" ("versa" "Cryptochrome-1"))
(define-protein "CSAG2_HUMAN" ("RPMI8226" "Chondrosarcoma-associated gene 2/3 protein" "Cancer/testis antigen 24.2" "CT24.2" "Taxol-resistant-associated gene 3 protein" "TRAG-3"))
(define-protein "CSC1_HUMAN" ("CSC-1" "Calcium permeable stress-gated cation channel 1" "Transmembrane protein 63C"))
(define-protein "CSF1R_HUMAN" ("dfg" "Macrophage colony-stimulating factor 1 receptor" "CSF-1 receptor" "CSF-1-R" "CSF-1R" "M-CSF-R" "Proto-oncogene c-Fms"))
(define-protein "CSF3R_HUMAN" ("G-CSF" "Granulocyte colony-stimulating factor receptor" "G-CSF receptor" "G-CSF-R"))
=======
(define-protein "CRGC_HUMAN" ("Gamma-crystallin C" "Gamma-C-crystallin" "Gamma-crystallin 2-1" "Gamma-crystallin 3"))
(define-protein "CRLF1_HUMAN" ("Cytokine receptor-like factor 1" "Cytokine-like factor 1" "CLF-1" "ZcytoR5"))
(define-protein "CRLF3_HUMAN" ("Cytokine receptor-like factor 3" "Cytokine receptor-like molecule 9" "CREME-9" "Cytokine receptor-related protein 4" "Type I cytokine receptor-like factor p48"))
(define-protein "CRTC3_HUMAN" ("CREB-regulated transcription coactivator 3" "Transducer of regulated cAMP response element-binding protein 3" "TORC-3" "Transducer of CREB protein 3"))
(define-protein "CRY1_HUMAN" ("Cryptochrome-1"))
(define-protein "CSAG2_HUMAN" ("Chondrosarcoma-associated gene 2/3 protein" "Cancer/testis antigen 24.2" "CT24.2" "Taxol-resistant-associated gene 3 protein" "TRAG-3"))
(define-protein "CSC1_HUMAN" ("Calcium permeable stress-gated cation channel 1" "Transmembrane protein 63C"))
(define-protein "CSF1R_HUMAN" ("Macrophage colony-stimulating factor 1 receptor" "CSF-1 receptor" "CSF-1-R" "CSF-1R" "M-CSF-R" "Proto-oncogene c-Fms"))
(define-protein "CSF3R_HUMAN" ("Granulocyte colony-stimulating factor receptor" "G-CSF receptor" "G-CSF-R"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CSK22_HUMAN" ("CSNK2A2" "CK2A2")) 
(define-protein "CSKP_HUMAN" ("hCASK" "CASK" "LIN2")) 
<<<<<<< .mine
(define-protein "CSK_HUMAN" ("sfks" "Tyrosine-protein kinase CSK" "C-Src kinase" "Protein-tyrosine kinase CYL"))
(define-protein "CSMD1_HUMAN" ("sushi" "CUB and sushi domain-containing protein 1" "CUB and sushi multiple domains protein 1"))
(define-protein "CSN1_HUMAN" ("signalosome" "COP9 signalosome complex subunit 1" "SGN1" "Signalosome subunit 1" "G protein pathway suppressor 1" "GPS-1" "JAB1-containing signalosome subunit 1" "Protein MFH"))
(define-protein "CSN8_HUMAN" ("COP9" "COP9 signalosome complex subunit 8" "SGN8" "Signalosome subunit 8" "COP9 homolog" "hCOP9" "JAB1-containing signalosome subunit 8"))
(define-protein "CSPG4_HUMAN" ("proteoglycan" "Chondroitin sulfate proteoglycan 4" "Chondroitin sulfate proteoglycan NG2" "Melanoma chondroitin sulfate proteoglycan" "Melanoma-associated chondroitin sulfate proteoglycan"))
(define-protein "CSTF3_HUMAN" ("Hat2" "Cleavage stimulation factor subunit 3" "CF-1 77 kDa subunit" "Cleavage stimulation factor 77 kDa subunit" "CSTF 77 kDa subunit" "CstF-77"))
(define-protein "CTCF_HUMAN" ("ctcf" "Transcriptional repressor CTCF" "11-zinc finger protein" "CCCTC-binding factor" "CTCFL paralog"))
(define-protein "CTDS1_HUMAN" ("Scp1" "Carboxy-terminal domain RNA polymerase II polypeptide A small phosphatase 1" "Nuclear LIM interactor-interacting factor 3" "NLI-IF" "NLI-interacting factor 3" "Small C-terminal domain phosphatase 1" "SCP1" "Small CTD phosphatase 1"))
(define-protein "CTF1_HUMAN" ("cardiotrophin-1" "Cardiotrophin-1" "CT-1"))
(define-protein "CTNA1_HUMAN" ("αE-catenin" "Catenin alpha-1" "Alpha E-catenin" "Cadherin-associated protein" "Renal carcinoma antigen NY-REN-13"))
(define-protein "CTND2_HUMAN" ("δ-Catenin" "Catenin delta-2" "Delta-catenin" "GT24" "Neural plakophilin-related ARM-repeat protein" "NPRAP" "Neurojungin"))
(define-protein "CTNL1_HUMAN" ("α-catenin" "Alpha-catulin" "Alpha-catenin-related protein" "ACRP" "Catenin alpha-like protein 1"))
(define-protein "CTRB2_HUMAN" ("chymotrypsin" "Chymotrypsinogen B2"))
(define-protein "CUL1_HUMAN" ("Cul1" "Cullin-1" "CUL-1"))
(define-protein "CUL2_HUMAN" ("Cullin-2" "CUL-2"))
=======
<<<<<<< .mine
(define-protein "CSK_HUMAN" ("sfks" "Tyrosine-protein kinase CSK" "C-Src kinase" "Protein-tyrosine kinase CYL"))
(define-protein "CSMD1_HUMAN" ("sushi" "CUB and sushi domain-containing protein 1" "CUB and sushi multiple domains protein 1"))
(define-protein "CSN1_HUMAN" ("signalosome" "COP9 signalosome complex subunit 1" "SGN1" "Signalosome subunit 1" "G protein pathway suppressor 1" "GPS-1" "JAB1-containing signalosome subunit 1" "Protein MFH"))
(define-protein "CSN8_HUMAN" ("COP9" "COP9 signalosome complex subunit 8" "SGN8" "Signalosome subunit 8" "COP9 homolog" "hCOP9" "JAB1-containing signalosome subunit 8"))
(define-protein "CSPG4_HUMAN" ("proteoglycan" "Chondroitin sulfate proteoglycan 4" "Chondroitin sulfate proteoglycan NG2" "Melanoma chondroitin sulfate proteoglycan" "Melanoma-associated chondroitin sulfate proteoglycan"))
(define-protein "CSTF3_HUMAN" ("Hat2" "Cleavage stimulation factor subunit 3" "CF-1 77 kDa subunit" "Cleavage stimulation factor 77 kDa subunit" "CSTF 77 kDa subunit" "CstF-77"))
(define-protein "CTCF_HUMAN" ("ctcf" "Transcriptional repressor CTCF" "11-zinc finger protein" "CCCTC-binding factor" "CTCFL paralog"))
(define-protein "CTDS1_HUMAN" ("Scp1" "Carboxy-terminal domain RNA polymerase II polypeptide A small phosphatase 1" "Nuclear LIM interactor-interacting factor 3" "NLI-IF" "NLI-interacting factor 3" "Small C-terminal domain phosphatase 1" "SCP1" "Small CTD phosphatase 1"))
(define-protein "CTF1_HUMAN" ("cardiotrophin-1" "Cardiotrophin-1" "CT-1"))
(define-protein "CTNA1_HUMAN" ("αE-catenin" "Catenin alpha-1" "Alpha E-catenin" "Cadherin-associated protein" "Renal carcinoma antigen NY-REN-13"))
(define-protein "CTND2_HUMAN" ("δ-Catenin" "Catenin delta-2" "Delta-catenin" "GT24" "Neural plakophilin-related ARM-repeat protein" "NPRAP" "Neurojungin"))
(define-protein "CTNL1_HUMAN" ("α-catenin" "Alpha-catulin" "Alpha-catenin-related protein" "ACRP" "Catenin alpha-like protein 1"))
(define-protein "CTRB2_HUMAN" ("chymotrypsin" "Chymotrypsinogen B2"))
(define-protein "CUL1_HUMAN" ("Cul1" "Cullin-1" "CUL-1"))
(define-protein "CUL2_HUMAN" ("Cullin-2" "CUL-2"))
=======
(define-protein "CSK_HUMAN" ("Tyrosine-protein kinase CSK" "C-Src kinase" "Protein-tyrosine kinase CYL"))
(define-protein "CSMD1_HUMAN" ("CUB and sushi domain-containing protein 1" "CUB and sushi multiple domains protein 1"))
(define-protein "CSN1_HUMAN" ("COP9 signalosome complex subunit 1" "SGN1" "Signalosome subunit 1" "G protein pathway suppressor 1" "GPS-1" "JAB1-containing signalosome subunit 1" "Protein MFH"))
(define-protein "CSN8_HUMAN" ("COP9 signalosome complex subunit 8" "SGN8" "Signalosome subunit 8" "COP9 homolog" "hCOP9" "JAB1-containing signalosome subunit 8"))
(define-protein "CSPG4_HUMAN" ("Chondroitin sulfate proteoglycan 4" "Chondroitin sulfate proteoglycan NG2" "Melanoma chondroitin sulfate proteoglycan" "Melanoma-associated chondroitin sulfate proteoglycan"))
(define-protein "CSTF3_HUMAN" ("Cleavage stimulation factor subunit 3" "CF-1 77 kDa subunit" "Cleavage stimulation factor 77 kDa subunit" "CSTF 77 kDa subunit" "CstF-77"))
(define-protein "CTCF_HUMAN" ("Transcriptional repressor CTCF" "11-zinc finger protein" "CCCTC-binding factor" "CTCFL paralog"))
(define-protein "CTDS1_HUMAN" ("Carboxy-terminal domain RNA polymerase II polypeptide A small phosphatase 1" "Nuclear LIM interactor-interacting factor 3" "NLI-IF" "NLI-interacting factor 3" "Small C-terminal domain phosphatase 1" "SCP1" "Small CTD phosphatase 1"))
(define-protein "CTF1_HUMAN" ("Cardiotrophin-1" "CT-1"))
(define-protein "CTNA1_HUMAN" ("Catenin alpha-1" "Alpha E-catenin" "Cadherin-associated protein" "Renal carcinoma antigen NY-REN-13"))
(define-protein "CTND2_HUMAN" ("Catenin delta-2" "Delta-catenin" "GT24" "Neural plakophilin-related ARM-repeat protein" "NPRAP" "Neurojungin"))
(define-protein "CTNL1_HUMAN" ("Alpha-catulin" "Alpha-catenin-related protein" "ACRP" "Catenin alpha-like protein 1"))
(define-protein "CTRB2_HUMAN" ("Chymotrypsinogen B2"))
(define-protein "CUL1_HUMAN" ("Cullin-1" "CUL-1"))
(define-protein "CUL2_HUMAN" ("Cullin-2" "CUL-2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CUL3_HUMAN" ("KIAA0617" "CUL3" "CUL-3")) 
<<<<<<< .mine
(define-protein "CUL4A_HUMAN" ("Cul4A" "Cullin-4A" "CUL-4A"))
(define-protein "CUL4B_HUMAN" ("CUL4b" "Cullin-4B" "CUL-4B"))
(define-protein "CUL7_HUMAN" ("Cul7" "Cullin-7" "CUL-7"))
=======
<<<<<<< .mine
(define-protein "CUL4A_HUMAN" ("Cul4A" "Cullin-4A" "CUL-4A"))
(define-protein "CUL4B_HUMAN" ("CUL4b" "Cullin-4B" "CUL-4B"))
(define-protein "CUL7_HUMAN" ("Cul7" "Cullin-7" "CUL-7"))
=======
(define-protein "CUL4A_HUMAN" ("Cullin-4A" "CUL-4A"))
(define-protein "CUL4B_HUMAN" ("Cullin-4B" "CUL-4B"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CUL7_HUMAN" ("Cullin-7" "CUL-7"))
<<<<<<< .mine
(define-protein "CX3C1_HUMAN" ("microglia" "CX3C chemokine receptor 1" "C-X3-C CKR-1" "CX3CR1" "Beta chemokine receptor-like 1" "CMK-BRL-1" "CMK-BRL1" "Fractalkine receptor" "G-protein coupled receptor 13" "V28"))
(define-protein "CXA3_HUMAN" ("connexins" "Gap junction alpha-3 protein" "Connexin-46" "Cx46"))
(define-protein "CXCL2_HUMAN" ("Cxcl2" "C-X-C motif chemokine 2" "Growth-regulated protein beta" "Gro-beta" "Macrophage inflammatory protein 2-alpha" "MIP2-alpha"))
(define-protein "CXCL7_HUMAN" ("neutrophil" "Platelet basic protein" "PBP" "C-X-C motif chemokine 7" "Leukocyte-derived growth factor" "LDGF" "Macrophage-derived growth factor" "MDGF" "Small-inducible cytokine B7"))
(define-protein "CXCR3_HUMAN" ("IP10" "C-X-C chemokine receptor type 3" "CXC-R3" "CXCR-3" "CKR-L2" "G protein-coupled receptor 9" "Interferon-inducible protein 10 receptor" "IP-10 receptor"))
(define-protein "CY1_HUMAN" ("C1" "Cytochrome c1, heme protein, mitochondrial" "Complex III subunit 4" "Complex III subunit IV" "Cytochrome b-c1 complex subunit 4" "Ubiquinol-cytochrome-c reductase complex cytochrome c1 subunit" "Cytochrome c-1"))
(define-protein "CY24A_HUMAN" ("cytochrome" "Cytochrome b-245 light chain" "Cytochrome b(558) alpha chain" "Cytochrome b558 subunit alpha" "Neutrophil cytochrome b 22 kDa polypeptide" "Superoxide-generating NADPH oxidase light chain subunit" "p22 phagocyte B-cytochrome" "p22-phox" "p22phox"))
(define-protein "CY24B_HUMAN" ("gp91" "Cytochrome b-245 heavy chain" "CGD91-phox" "Cytochrome b(558) subunit beta" "Cytochrome b558 subunit beta" "Heme-binding membrane glycoprotein gp91phox" "NADPH oxidase 2" "Neutrophil cytochrome b 91 kDa polypeptide" "Superoxide-generating NADPH oxidase heavy chain subunit" "gp91-1" "gp91-phox" "p22 phagocyte B-cytochrome"))
=======
<<<<<<< .mine
(define-protein "CX3C1_HUMAN" ("microglia" "CX3C chemokine receptor 1" "C-X3-C CKR-1" "CX3CR1" "Beta chemokine receptor-like 1" "CMK-BRL-1" "CMK-BRL1" "Fractalkine receptor" "G-protein coupled receptor 13" "V28"))
(define-protein "CXA3_HUMAN" ("connexins" "Gap junction alpha-3 protein" "Connexin-46" "Cx46"))
(define-protein "CXCL2_HUMAN" ("Cxcl2" "C-X-C motif chemokine 2" "Growth-regulated protein beta" "Gro-beta" "Macrophage inflammatory protein 2-alpha" "MIP2-alpha"))
(define-protein "CXCL7_HUMAN" ("neutrophil" "Platelet basic protein" "PBP" "C-X-C motif chemokine 7" "Leukocyte-derived growth factor" "LDGF" "Macrophage-derived growth factor" "MDGF" "Small-inducible cytokine B7"))
(define-protein "CXCR3_HUMAN" ("IP10" "C-X-C chemokine receptor type 3" "CXC-R3" "CXCR-3" "CKR-L2" "G protein-coupled receptor 9" "Interferon-inducible protein 10 receptor" "IP-10 receptor"))
(define-protein "CY1_HUMAN" ("C1" "Cytochrome c1, heme protein, mitochondrial" "Complex III subunit 4" "Complex III subunit IV" "Cytochrome b-c1 complex subunit 4" "Ubiquinol-cytochrome-c reductase complex cytochrome c1 subunit" "Cytochrome c-1"))
(define-protein "CY24A_HUMAN" ("cytochrome" "Cytochrome b-245 light chain" "Cytochrome b(558) alpha chain" "Cytochrome b558 subunit alpha" "Neutrophil cytochrome b 22 kDa polypeptide" "Superoxide-generating NADPH oxidase light chain subunit" "p22 phagocyte B-cytochrome" "p22-phox" "p22phox"))
(define-protein "CY24B_HUMAN" ("gp91" "Cytochrome b-245 heavy chain" "CGD91-phox" "Cytochrome b(558) subunit beta" "Cytochrome b558 subunit beta" "Heme-binding membrane glycoprotein gp91phox" "NADPH oxidase 2" "Neutrophil cytochrome b 91 kDa polypeptide" "Superoxide-generating NADPH oxidase heavy chain subunit" "gp91-1" "gp91-phox" "p22 phagocyte B-cytochrome"))
=======
(define-protein "CX3C1_HUMAN" ("CX3C chemokine receptor 1" "C-X3-C CKR-1" "CX3CR1" "Beta chemokine receptor-like 1" "CMK-BRL-1" "CMK-BRL1" "Fractalkine receptor" "G-protein coupled receptor 13" "V28"))
(define-protein "CXA3_HUMAN" ("Gap junction alpha-3 protein" "Connexin-46" "Cx46"))
(define-protein "CXCL2_HUMAN" ("C-X-C motif chemokine 2" "Growth-regulated protein beta" "Gro-beta" "Macrophage inflammatory protein 2-alpha" "MIP2-alpha"))
(define-protein "CXCL7_HUMAN" ("Platelet basic protein" "PBP" "C-X-C motif chemokine 7" "Leukocyte-derived growth factor" "LDGF" "Macrophage-derived growth factor" "MDGF" "Small-inducible cytokine B7"))
(define-protein "CXCR3_HUMAN" ("C-X-C chemokine receptor type 3" "CXC-R3" "CXCR-3" "CKR-L2" "G protein-coupled receptor 9" "Interferon-inducible protein 10 receptor" "IP-10 receptor"))
(define-protein "CY1_HUMAN" ("Cytochrome c1, heme protein, mitochondrial" "Complex III subunit 4" "Complex III subunit IV" "Cytochrome b-c1 complex subunit 4" "Ubiquinol-cytochrome-c reductase complex cytochrome c1 subunit" "Cytochrome c-1"))
(define-protein "CY24A_HUMAN" ("Cytochrome b-245 light chain" "Cytochrome b(558) alpha chain" "Cytochrome b558 subunit alpha" "Neutrophil cytochrome b 22 kDa polypeptide" "Superoxide-generating NADPH oxidase light chain subunit" "p22 phagocyte B-cytochrome" "p22-phox" "p22phox"))
(define-protein "CY24B_HUMAN" ("Cytochrome b-245 heavy chain" "CGD91-phox" "Cytochrome b(558) subunit beta" "Cytochrome b558 subunit beta" "Heme-binding membrane glycoprotein gp91phox" "NADPH oxidase 2" "Neutrophil cytochrome b 91 kDa polypeptide" "Superoxide-generating NADPH oxidase heavy chain subunit" "gp91-1" "gp91-phox" "p22 phagocyte B-cytochrome"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CYBP_HUMAN" ("SIP" "hCacyBP" "S100A6BP" "CACYBP" "CacyBP")) 
(define-protein "CYFP1_HUMAN" ("p140sra-1" "CYFIP1" "Sra-1" "KIAA0068")) 
(define-protein "CYTA_HUMAN" ("STF1" "STFA" "CSTA" "Stefin-A" "Cystatin-AS")) 
<<<<<<< .mine
(define-protein "CYTB_HUMAN" ("C91" "Cystatin-B" "CPI-B" "Liver thiol proteinase inhibitor" "Stefin-B"))
=======
<<<<<<< .mine
(define-protein "CYTB_HUMAN" ("C91" "Cystatin-B" "CPI-B" "Liver thiol proteinase inhibitor" "Stefin-B"))
=======
(define-protein "CYTB_HUMAN" ("Cystatin-B" "CPI-B" "Liver thiol proteinase inhibitor" "Stefin-B"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "CYTSA_HUMAN" ("SPECC1L" "KIAA0376" "CYTSA")) 
(define-protein "CYTS_HUMAN" ("CST4" "Cystatin-4" "Cystatin-SA-III")) 
<<<<<<< .mine
(define-protein "D2IE15_9PICO" ("K54" "Genome polyprotein"))
(define-protein "D2IE16_9PICO" ("K63" "Genome polyprotein"))
(define-protein "D2KZ36_HUMAN" ("jmdp" "MHC class I antigen"))
(define-protein "D2XWF1_9HIV1" ("p286" "Envelope glycoprotein"))
(define-protein "D2XYZ5_9VIRU" ("imi" "VP1 protein"))
=======
<<<<<<< .mine
(define-protein "D2IE15_9PICO" ("K54" "Genome polyprotein"))
(define-protein "D2IE16_9PICO" ("K63" "Genome polyprotein"))
(define-protein "D2KZ36_HUMAN" ("jmdp" "MHC class I antigen"))
(define-protein "D2XWF1_9HIV1" ("p286" "Envelope glycoprotein"))
(define-protein "D2XYZ5_9VIRU" ("VP1 protein"))
=======
(define-protein "D2IE15_9PICO" ("Genome polyprotein"))
(define-protein "D2IE16_9PICO" ("Genome polyprotein"))
(define-protein "D2KZ36_HUMAN" ("MHC class I antigen"))
(define-protein "D2XWF1_9HIV1" ("Envelope glycoprotein"))
(define-protein "D2XYZ5_9VIRU" ("VP1 protein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "DACH1_HUMAN" ("Dachshund homolog 1" "Dach1"))
(define-protein "DACT1_HUMAN" ("Dapper homolog 1" "hDPR1" "Dapper antagonist of catenin 1" "Hepatocellular carcinoma novel gene 3 protein"))
<<<<<<< .mine
(define-protein "DAF_HUMAN" ("DAF-2" "Complement decay-accelerating factor"))
(define-protein "DAPK2_HUMAN" ("anoikis" "Death-associated protein kinase 2" "DAP kinase 2" "DAP-kinase-related protein 1" "DRP-1"))
(define-protein "DAZ1_HUMAN" ("daz" "Deleted in azoospermia protein 1"))
=======
<<<<<<< .mine
(define-protein "DAF_HUMAN" ("DAF-2" "Complement decay-accelerating factor"))
(define-protein "DAPK2_HUMAN" ("anoikis" "Death-associated protein kinase 2" "DAP kinase 2" "DAP-kinase-related protein 1" "DRP-1"))
(define-protein "DAZ1_HUMAN" ("daz" "Deleted in azoospermia protein 1"))
=======
(define-protein "DAF_HUMAN" ("Complement decay-accelerating factor"))
(define-protein "DAPK2_HUMAN" ("Death-associated protein kinase 2" "DAP kinase 2" "DAP-kinase-related protein 1" "DRP-1"))
(define-protein "DAZ1_HUMAN" ("Deleted in azoospermia protein 1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "DAZP2_HUMAN" ("DAZ-associated protein 2" "Deleted in azoospermia-associated protein 2"))
<<<<<<< .mine
(define-protein "DAZP2_HUMAN" ("Dazap2" "DAZ-associated protein 2" "Deleted in azoospermia-associated protein 2"))
(define-protein "DBLOH_HUMAN" ("Smac/DIABLO" "Diablo homolog, mitochondrial" "Direct IAP-binding protein with low pI" "Second mitochondria-derived activator of caspase" "Smac"))
(define-protein "DBP_HUMAN" ("albumin" "D site-binding protein" "Albumin D box-binding protein" "Albumin D-element-binding protein" "Tax-responsive enhancer element-binding protein 302" "TaxREB302"))
=======
<<<<<<< .mine
(define-protein "DAZP2_HUMAN" ("Dazap2" "DAZ-associated protein 2" "Deleted in azoospermia-associated protein 2"))
(define-protein "DBLOH_HUMAN" ("Smac/DIABLO" "Diablo homolog, mitochondrial" "Direct IAP-binding protein with low pI" "Second mitochondria-derived activator of caspase" "Smac"))
(define-protein "DBP_HUMAN" ("albumin" "D site-binding protein" "Albumin D box-binding protein" "Albumin D-element-binding protein" "Tax-responsive enhancer element-binding protein 302" "TaxREB302"))
=======
(define-protein "DBLOH_HUMAN" ("Diablo homolog, mitochondrial" "Direct IAP-binding protein with low pI" "Second mitochondria-derived activator of caspase" "Smac"))
(define-protein "DBP_HUMAN" ("D site-binding protein" "Albumin D box-binding protein" "Albumin D-element-binding protein" "Tax-responsive enhancer element-binding protein 302" "TaxREB302"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "DC1I1_HUMAN" ("DYNC1I1" "DNCI1" "DNCIC1")) 
(define-protein "DC1I2_HUMAN" ("DYNC1I2" "DNCI2" "DNCIC2")) 
(define-protein "DC1L1_HUMAN" ("DLC-A" "DNCLI1" "DYNC1LI1" "LIC1")) 
(define-protein "DC1L2_HUMAN" ("LIC-2" "DNCLI2" "DYNC1LI2" "LIC2" "LIC53/55")) 
<<<<<<< .mine
(define-protein "DCAF6_HUMAN" ("arcap" "DDB1- and CUL4-associated factor 6" "Androgen receptor complex-associated protein" "ARCAP" "IQ motif and WD repeat-containing protein 1" "Nuclear receptor interaction protein" "NRIP"))
(define-protein "DCBD2_HUMAN" ("subline" "Discoidin, CUB and LCCL domain-containing protein 2" "CUB, LCCL and coagulation factor V/VIII-homology domains protein 1" "Endothelial and smooth muscle cell-derived neuropilin-like protein"))
(define-protein "DCC_HUMAN" ("DCC-" "Netrin receptor DCC" "Colorectal cancer suppressor" "Immunoglobulin superfamily DCC subclass member 1" "Tumor suppressor protein DCC"))
=======
<<<<<<< .mine
(define-protein "DCAF6_HUMAN" ("arcap" "DDB1- and CUL4-associated factor 6" "Androgen receptor complex-associated protein" "ARCAP" "IQ motif and WD repeat-containing protein 1" "Nuclear receptor interaction protein" "NRIP"))
(define-protein "DCBD2_HUMAN" ("subline" "Discoidin, CUB and LCCL domain-containing protein 2" "CUB, LCCL and coagulation factor V/VIII-homology domains protein 1" "Endothelial and smooth muscle cell-derived neuropilin-like protein"))
(define-protein "DCC_HUMAN" ("DCC-" "Netrin receptor DCC" "Colorectal cancer suppressor" "Immunoglobulin superfamily DCC subclass member 1" "Tumor suppressor protein DCC"))
=======
(define-protein "DCAF6_HUMAN" ("DDB1- and CUL4-associated factor 6" "Androgen receptor complex-associated protein" "ARCAP" "IQ motif and WD repeat-containing protein 1" "Nuclear receptor interaction protein" "NRIP"))
(define-protein "DCBD2_HUMAN" ("Discoidin, CUB and LCCL domain-containing protein 2" "CUB, LCCL and coagulation factor V/VIII-homology domains protein 1" "Endothelial and smooth muscle cell-derived neuropilin-like protein"))
(define-protein "DCC_HUMAN" ("Netrin receptor DCC" "Colorectal cancer suppressor" "Immunoglobulin superfamily DCC subclass member 1" "Tumor suppressor protein DCC"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "DCE1_HUMAN" ("Glutamate decarboxylase 1" "67 kDa glutamic acid decarboxylase" "GAD-67" "Glutamate decarboxylase 67 kDa isoform"))
<<<<<<< .mine
(define-protein "DCNL1_HUMAN" ("carcinomas" "DCN1-like protein 1" "DCUN1 domain-containing protein 1" "Defective in cullin neddylation protein 1-like protein 1" "Squamous cell carcinoma-related oncogene"))
(define-protein "DCOR_HUMAN" ("paralogue" "Ornithine decarboxylase" "ODC"))
=======
<<<<<<< .mine
(define-protein "DCNL1_HUMAN" ("carcinomas" "DCN1-like protein 1" "DCUN1 domain-containing protein 1" "Defective in cullin neddylation protein 1-like protein 1" "Squamous cell carcinoma-related oncogene"))
(define-protein "DCOR_HUMAN" ("paralogue" "Ornithine decarboxylase" "ODC"))
=======
(define-protein "DCNL1_HUMAN" ("DCN1-like protein 1" "DCUN1 domain-containing protein 1" "Defective in cullin neddylation protein 1-like protein 1" "Squamous cell carcinoma-related oncogene"))
(define-protein "DCOR_HUMAN" ("Ornithine decarboxylase" "ODC"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "DCTN2_HUMAN" ("DCTN-50" "DCTN50" "DCTN2")) 
(define-protein "DCTN3_HUMAN" ("DCTN22" "DCTN3" "p22")) 
(define-protein "DDIT3_HUMAN" ("CHOP10" "DNA damage-inducible transcript 3 protein" "DDIT-3" "C/EBP zeta" "C/EBP-homologous protein" "CHOP" "C/EBP-homologous protein 10" "CHOP-10" "CCAAT/enhancer-binding protein homologous protein" "Growth arrest and DNA damage-inducible protein GADD153"))
(define-protein "DDIT3_HUMAN" ("DNA damage-inducible transcript 3 protein" "DDIT-3" "C/EBP zeta" "C/EBP-homologous protein" "CHOP" "C/EBP-homologous protein 10" "CHOP-10" "CCAAT/enhancer-binding protein homologous protein" "Growth arrest and DNA damage-inducible protein GADD153"))
<<<<<<< .mine
(define-protein "DDR1_HUMAN" ("rtk" "Epithelial discoidin domain-containing receptor 1" "Epithelial discoidin domain receptor 1" "CD167 antigen-like family member A" "Cell adhesion kinase" "Discoidin receptor tyrosine kinase" "HGK2" "Mammary carcinoma kinase 10" "MCK-10" "Protein-tyrosine kinase 3A" "Protein-tyrosine kinase RTK-6" "TRK E" "Tyrosine kinase DDR" "Tyrosine-protein kinase CAK"))
(define-protein "DDX17_HUMAN" ("p72" "Probable ATP-dependent RNA helicase DDX17" "DEAD box protein 17" "DEAD box protein p72" "RNA-dependent helicase p72"))
(define-protein "DDX41_HUMAN" ("abs" "Probable ATP-dependent RNA helicase DDX41" "DEAD box protein 41" "DEAD box protein abstrakt homolog"))
=======
<<<<<<< .mine
(define-protein "DDR1_HUMAN" ("rtk" "Epithelial discoidin domain-containing receptor 1" "Epithelial discoidin domain receptor 1" "CD167 antigen-like family member A" "Cell adhesion kinase" "Discoidin receptor tyrosine kinase" "HGK2" "Mammary carcinoma kinase 10" "MCK-10" "Protein-tyrosine kinase 3A" "Protein-tyrosine kinase RTK-6" "TRK E" "Tyrosine kinase DDR" "Tyrosine-protein kinase CAK"))
(define-protein "DDX17_HUMAN" ("p72" "Probable ATP-dependent RNA helicase DDX17" "DEAD box protein 17" "DEAD box protein p72" "RNA-dependent helicase p72"))
(define-protein "DDX41_HUMAN" ("abs" "Probable ATP-dependent RNA helicase DDX41" "DEAD box protein 41" "DEAD box protein abstrakt homolog"))
=======
(define-protein "DDR1_HUMAN" ("Epithelial discoidin domain-containing receptor 1" "Epithelial discoidin domain receptor 1" "CD167 antigen-like family member A" "Cell adhesion kinase" "Discoidin receptor tyrosine kinase" "HGK2" "Mammary carcinoma kinase 10" "MCK-10" "Protein-tyrosine kinase 3A" "Protein-tyrosine kinase RTK-6" "TRK E" "Tyrosine kinase DDR" "Tyrosine-protein kinase CAK"))
(define-protein "DDX17_HUMAN" ("Probable ATP-dependent RNA helicase DDX17" "DEAD box protein 17" "DEAD box protein p72" "RNA-dependent helicase p72"))
(define-protein "DDX41_HUMAN" ("Probable ATP-dependent RNA helicase DDX41" "DEAD box protein 41" "DEAD box protein abstrakt homolog"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "DDX47_HUMAN" ("DDX47")) 
(define-protein "DDX50_HUMAN" ("Gu-beta" "DDX50")) 
(define-protein "DDX55_HUMAN" ("DDX55" "KIAA1595")) 
(define-protein "DEAF1_HUMAN" ("ZMYND5" "Suppressin" "DEAF1" "SPN" "NUDR")) 
<<<<<<< .mine
(define-protein "DEK_HUMAN" ("dek" "Protein DEK"))
=======
<<<<<<< .mine
(define-protein "DEK_HUMAN" ("dek" "Protein DEK"))
=======
(define-protein "DEK_HUMAN" ("Protein DEK"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "DEN6B_HUMAN" ("DENND6B" "FAM116B")) 
<<<<<<< .mine
(define-protein "DESP_HUMAN" ("dpi" "Desmoplakin" "DP" "250/210 kDa paraneoplastic pemphigus antigen"))
=======
<<<<<<< .mine
(define-protein "DESP_HUMAN" ("dpi" "Desmoplakin" "DP" "250/210 kDa paraneoplastic pemphigus antigen"))
=======
(define-protein "DESP_HUMAN" ("Desmoplakin" "DP" "250/210 kDa paraneoplastic pemphigus antigen"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "DEXI_HUMAN" ("DEXI" "MYLE")) 
<<<<<<< .mine
(define-protein "DFFA_HUMAN" ("Ser-315" "DNA fragmentation factor subunit alpha" "DNA fragmentation factor 45 kDa subunit" "DFF-45" "Inhibitor of CAD" "ICAD"))
=======
<<<<<<< .mine
(define-protein "DFFA_HUMAN" ("Ser-315" "DNA fragmentation factor subunit alpha" "DNA fragmentation factor 45 kDa subunit" "DFF-45" "Inhibitor of CAD" "ICAD"))
=======
(define-protein "DFFA_HUMAN" ("DNA fragmentation factor subunit alpha" "DNA fragmentation factor 45 kDa subunit" "DFF-45" "Inhibitor of CAD" "ICAD"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "DGKK_HUMAN" ("DGKK" "DGK-kappa")) 
(define-protein "DGKQ_HUMAN" ("DGKQ" "DAGK4" "DGK-theta")) 
(define-protein "DGKZ_HUMAN" ("DAGK6" "DGKZ" "DGK-zeta")) 
<<<<<<< .mine
(define-protein "DHAS1_HUMAN" ("dhrs" "Putative uncharacterized protein DHRS4-AS1" "DHRS4 antisense RNA 1" "DHRS4 antisense gene protein 1"))
(define-protein "DHB11_HUMAN" ("metabolites" "Estradiol 17-beta-dehydrogenase 11" "17-beta-hydroxysteroid dehydrogenase 11" "17-beta-HSD 11" "17bHSD11" "17betaHSD11" "17-beta-hydroxysteroid dehydrogenase XI" "17-beta-HSD XI" "17betaHSDXI" "Cutaneous T-cell lymphoma-associated antigen HD-CL-03" "CTCL-associated antigen HD-CL-03" "Dehydrogenase/reductase SDR family member 8" "Retinal short-chain dehydrogenase/reductase 2" "retSDR2" "Short chain dehydrogenase/reductase family 16C member 2"))
(define-protein "DHB1_HUMAN" ("estradiol" "Estradiol 17-beta-dehydrogenase 1" "17-beta-hydroxysteroid dehydrogenase type 1" "17-beta-HSD 1" "20 alpha-hydroxysteroid dehydrogenase" "20-alpha-HSD" "E2DH" "Placental 17-beta-hydroxysteroid dehydrogenase" "Short chain dehydrogenase/reductase family 28C member 1"))
(define-protein "DHI1_HUMAN" ("11β-HSD1" "Corticosteroid 11-beta-dehydrogenase isozyme 1" "11-beta-hydroxysteroid dehydrogenase 1" "11-DH" "11-beta-HSD1" "Short chain dehydrogenase/reductase family 26C member 1"))
(define-protein "DHI2_HUMAN" ("R-250" "Corticosteroid 11-beta-dehydrogenase isozyme 2" "11-beta-hydroxysteroid dehydrogenase type 2" "11-DH2" "11-beta-HSD2" "11-beta-hydroxysteroid dehydrogenase type II" "11-HSD type II" "11-beta-HSD type II" "NAD-dependent 11-beta-hydroxysteroid dehydrogenase" "11-beta-HSD" "Short chain dehydrogenase/reductase family 9C member 3"))
(define-protein "DIA1_HUMAN" ("Akt-induced" "Deleted in autism protein 1" "Golgi Protein of 49 kDa" "GoPro49" "Hypoxia and AKT-induced stem cell factor" "HASF"))
=======
<<<<<<< .mine
(define-protein "DHAS1_HUMAN" ("dhrs" "Putative uncharacterized protein DHRS4-AS1" "DHRS4 antisense RNA 1" "DHRS4 antisense gene protein 1"))
(define-protein "DHB11_HUMAN" ("metabolites" "Estradiol 17-beta-dehydrogenase 11" "17-beta-hydroxysteroid dehydrogenase 11" "17-beta-HSD 11" "17bHSD11" "17betaHSD11" "17-beta-hydroxysteroid dehydrogenase XI" "17-beta-HSD XI" "17betaHSDXI" "Cutaneous T-cell lymphoma-associated antigen HD-CL-03" "CTCL-associated antigen HD-CL-03" "Dehydrogenase/reductase SDR family member 8" "Retinal short-chain dehydrogenase/reductase 2" "retSDR2" "Short chain dehydrogenase/reductase family 16C member 2"))
(define-protein "DHB1_HUMAN" ("estradiol" "Estradiol 17-beta-dehydrogenase 1" "17-beta-hydroxysteroid dehydrogenase type 1" "17-beta-HSD 1" "20 alpha-hydroxysteroid dehydrogenase" "20-alpha-HSD" "E2DH" "Placental 17-beta-hydroxysteroid dehydrogenase" "Short chain dehydrogenase/reductase family 28C member 1"))
(define-protein "DHI1_HUMAN" ("11β-HSD1" "Corticosteroid 11-beta-dehydrogenase isozyme 1" "11-beta-hydroxysteroid dehydrogenase 1" "11-DH" "11-beta-HSD1" "Short chain dehydrogenase/reductase family 26C member 1"))
(define-protein "DHI2_HUMAN" ("R-250" "Corticosteroid 11-beta-dehydrogenase isozyme 2" "11-beta-hydroxysteroid dehydrogenase type 2" "11-DH2" "11-beta-HSD2" "11-beta-hydroxysteroid dehydrogenase type II" "11-HSD type II" "11-beta-HSD type II" "NAD-dependent 11-beta-hydroxysteroid dehydrogenase" "11-beta-HSD" "Short chain dehydrogenase/reductase family 9C member 3"))
(define-protein "DIA1_HUMAN" ("Akt-induced" "Deleted in autism protein 1" "Golgi Protein of 49 kDa" "GoPro49" "Hypoxia and AKT-induced stem cell factor" "HASF"))
=======
(define-protein "DHAS1_HUMAN" ("Putative uncharacterized protein DHRS4-AS1" "DHRS4 antisense RNA 1" "DHRS4 antisense gene protein 1"))
(define-protein "DHB11_HUMAN" ("Estradiol 17-beta-dehydrogenase 11" "17-beta-hydroxysteroid dehydrogenase 11" "17-beta-HSD 11" "17bHSD11" "17betaHSD11" "17-beta-hydroxysteroid dehydrogenase XI" "17-beta-HSD XI" "17betaHSDXI" "Cutaneous T-cell lymphoma-associated antigen HD-CL-03" "CTCL-associated antigen HD-CL-03" "Dehydrogenase/reductase SDR family member 8" "Retinal short-chain dehydrogenase/reductase 2" "retSDR2" "Short chain dehydrogenase/reductase family 16C member 2"))
(define-protein "DHB1_HUMAN" ("Estradiol 17-beta-dehydrogenase 1" "17-beta-hydroxysteroid dehydrogenase type 1" "17-beta-HSD 1" "20 alpha-hydroxysteroid dehydrogenase" "20-alpha-HSD" "E2DH" "Placental 17-beta-hydroxysteroid dehydrogenase" "Short chain dehydrogenase/reductase family 28C member 1"))
(define-protein "DHI1_HUMAN" ("Corticosteroid 11-beta-dehydrogenase isozyme 1" "11-beta-hydroxysteroid dehydrogenase 1" "11-DH" "11-beta-HSD1" "Short chain dehydrogenase/reductase family 26C member 1"))
(define-protein "DHI2_HUMAN" ("Corticosteroid 11-beta-dehydrogenase isozyme 2" "11-beta-hydroxysteroid dehydrogenase type 2" "11-DH2" "11-beta-HSD2" "11-beta-hydroxysteroid dehydrogenase type II" "11-HSD type II" "11-beta-HSD type II" "NAD-dependent 11-beta-hydroxysteroid dehydrogenase" "11-beta-HSD" "Short chain dehydrogenase/reductase family 9C member 3"))
(define-protein "DIA1_HUMAN" ("Deleted in autism protein 1" "Golgi Protein of 49 kDa" "GoPro49" "Hypoxia and AKT-induced stem cell factor" "HASF"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "DIAP1_HUMAN" ("Protein diaphanous homolog 1" "Diaphanous-related formin-1" "DRF1"))
<<<<<<< .mine
(define-protein "DIAP1_HUMAN" ("mDia1" "Protein diaphanous homolog 1" "Diaphanous-related formin-1" "DRF1"))
(define-protein "DIAP3_HUMAN" ("mdia" "Protein diaphanous homolog 3" "Diaphanous-related formin-3" "DRF3" "MDia2"))
(define-protein "DICER_HUMAN" ("dicer" "Endoribonuclease Dicer" "Helicase with RNase motif" "Helicase MOI"))
=======
<<<<<<< .mine
(define-protein "DIAP1_HUMAN" ("mDia1" "Protein diaphanous homolog 1" "Diaphanous-related formin-1" "DRF1"))
(define-protein "DIAP3_HUMAN" ("mdia" "Protein diaphanous homolog 3" "Diaphanous-related formin-3" "DRF3" "MDia2"))
(define-protein "DICER_HUMAN" ("dicer" "Endoribonuclease Dicer" "Helicase with RNase motif" "Helicase MOI"))
=======
(define-protein "DIAP3_HUMAN" ("Protein diaphanous homolog 3" "Diaphanous-related formin-3" "DRF3" "MDia2"))
(define-protein "DICER_HUMAN" ("Endoribonuclease Dicer" "Helicase with RNase motif" "Helicase MOI"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "DIDO1_HUMAN" ("DIDO1" "C20orf158" "DIO-1" "DATF-1" "hDido1" "KIAA0333" "DATF1")) 
<<<<<<< .mine
(define-protein "DISC1_HUMAN" ("dentate" "Disrupted in schizophrenia 1 protein"))
(define-protein "DJB11_HUMAN" ("GFP-" "DnaJ homolog subfamily B member 11" "APOBEC1-binding protein 2" "ABBP-2" "DnaJ protein homolog 9" "ER-associated DNAJ" "ER-associated Hsp40 co-chaperone" "Endoplasmic reticulum DNA J domain-containing protein 3" "ER-resident protein ERdj3" "ERdj3" "ERj3p" "HEDJ" "Human DnaJ protein 9" "hDj-9" "PWP1-interacting protein 4"))
(define-protein "DJC11_HUMAN" ("DnaJC11" "DnaJ homolog subfamily C member 11"))
(define-protein "DKK1_HUMAN" ("LRP5/6" "Dickkopf-related protein 1" "Dickkopf-1" "Dkk-1" "hDkk-1" "SK"))
(define-protein "DLG2_HUMAN" ("PSD-93" "Disks large homolog 2" "Channel-associated protein of synapse-110" "Chapsyn-110" "Postsynaptic density protein PSD-93"))
=======
<<<<<<< .mine
(define-protein "DISC1_HUMAN" ("dentate" "Disrupted in schizophrenia 1 protein"))
(define-protein "DJB11_HUMAN" ("GFP-" "DnaJ homolog subfamily B member 11" "APOBEC1-binding protein 2" "ABBP-2" "DnaJ protein homolog 9" "ER-associated DNAJ" "ER-associated Hsp40 co-chaperone" "Endoplasmic reticulum DNA J domain-containing protein 3" "ER-resident protein ERdj3" "ERdj3" "ERj3p" "HEDJ" "Human DnaJ protein 9" "hDj-9" "PWP1-interacting protein 4"))
(define-protein "DJC11_HUMAN" ("DnaJC11" "DnaJ homolog subfamily C member 11"))
(define-protein "DKK1_HUMAN" ("LRP5/6" "Dickkopf-related protein 1" "Dickkopf-1" "Dkk-1" "hDkk-1" "SK"))
(define-protein "DLG2_HUMAN" ("PSD-93" "Disks large homolog 2" "Channel-associated protein of synapse-110" "Chapsyn-110" "Postsynaptic density protein PSD-93"))
=======
(define-protein "DISC1_HUMAN" ("Disrupted in schizophrenia 1 protein"))
(define-protein "DJB11_HUMAN" ("DnaJ homolog subfamily B member 11" "APOBEC1-binding protein 2" "ABBP-2" "DnaJ protein homolog 9" "ER-associated DNAJ" "ER-associated Hsp40 co-chaperone" "Endoplasmic reticulum DNA J domain-containing protein 3" "ER-resident protein ERdj3" "ERdj3" "ERj3p" "HEDJ" "Human DnaJ protein 9" "hDj-9" "PWP1-interacting protein 4"))
(define-protein "DJC11_HUMAN" ("DnaJ homolog subfamily C member 11"))
(define-protein "DKK1_HUMAN" ("Dickkopf-related protein 1" "Dickkopf-1" "Dkk-1" "hDkk-1" "SK"))
(define-protein "DLG2_HUMAN" ("Disks large homolog 2" "Channel-associated protein of synapse-110" "Chapsyn-110" "Postsynaptic density protein PSD-93"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "DLL1_HUMAN" ("Delta-like protein 1" "Drosophila Delta homolog 1" "Delta1" "H-Delta-1"))
(define-protein "DLL1_HUMAN" ("Dll1" "Delta-like protein 1" "Drosophila Delta homolog 1" "Delta1" "H-Delta-1"))
(define-protein "DLRB1_HUMAN" ("BITH" "DNCL2A" "ROBLD1" "DYNLRB1" "BLP" "DNLC2A")) 
(define-protein "DLX4_HUMAN" ("Homeobox protein DLX-4" "Beta protein 1" "Homeobox protein DLX-7" "Homeobox protein DLX-8"))
<<<<<<< .mine
(define-protein "DMD_HUMAN" ("dystrophin" "Dystrophin"))
(define-protein "DNJA1_HUMAN" ("anisomycin" "DnaJ homolog subfamily A member 1" "DnaJ protein homolog 2" "HSDJ" "Heat shock 40 kDa protein 4" "Heat shock protein J2" "HSJ-2" "Human DnaJ protein 2" "hDj-2"))
(define-protein "DNJA2_HUMAN" ("cochaperones" "DnaJ homolog subfamily A member 2" "Cell cycle progression restoration gene 3 protein" "Dnj3" "Dj3" "HIRA-interacting protein 4" "Renal carcinoma antigen NY-REN-14"))
=======
<<<<<<< .mine
(define-protein "DMD_HUMAN" ("dystrophin" "Dystrophin"))
(define-protein "DNJA1_HUMAN" ("anisomycin" "DnaJ homolog subfamily A member 1" "DnaJ protein homolog 2" "HSDJ" "Heat shock 40 kDa protein 4" "Heat shock protein J2" "HSJ-2" "Human DnaJ protein 2" "hDj-2"))
(define-protein "DNJA2_HUMAN" ("cochaperones" "DnaJ homolog subfamily A member 2" "Cell cycle progression restoration gene 3 protein" "Dnj3" "Dj3" "HIRA-interacting protein 4" "Renal carcinoma antigen NY-REN-14"))
=======
(define-protein "DMD_HUMAN" ("Dystrophin"))
(define-protein "DNJA1_HUMAN" ("DnaJ homolog subfamily A member 1" "DnaJ protein homolog 2" "HSDJ" "Heat shock 40 kDa protein 4" "Heat shock protein J2" "HSJ-2" "Human DnaJ protein 2" "hDj-2"))
(define-protein "DNJA2_HUMAN" ("DnaJ homolog subfamily A member 2" "Cell cycle progression restoration gene 3 protein" "Dnj3" "Dj3" "HIRA-interacting protein 4" "Renal carcinoma antigen NY-REN-14"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "DNJA3_HUMAN" ("hTid-1" "DNAJA3" "TID1" "HCA57")) 
(define-protein "DNJB1_HUMAN" ("hDj-1" "HDJ1" "DNAJ1" "HSP40" "HSPF1" "DNAJB1")) 
<<<<<<< .mine
(define-protein "DNJC2_HUMAN" ("N-terminally" "DnaJ homolog subfamily C member 2" "M-phase phosphoprotein 11" "Zuotin-related factor 1"))
=======
<<<<<<< .mine
(define-protein "DNJC2_HUMAN" ("N-terminally" "DnaJ homolog subfamily C member 2" "M-phase phosphoprotein 11" "Zuotin-related factor 1"))
=======
(define-protein "DNJC2_HUMAN" ("DnaJ homolog subfamily C member 2" "M-phase phosphoprotein 11" "Zuotin-related factor 1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "DNJC3_HUMAN" ("DnaJ homolog subfamily C member 3" "Endoplasmic reticulum DNA J domain-containing protein 6" "ER-resident protein ERdj6" "ERdj6" "Interferon-induced, double-stranded RNA-activated protein kinase inhibitor" "Protein kinase inhibitor of 58 kDa" "Protein kinase inhibitor p58"))
(define-protein "DNJC8_HUMAN" ("SPF31" "DNAJC8")) 
(define-protein "DNLI3_HUMAN" ("LIG3" "Lig III" "LIG III")) 
(define-protein "DNM1L_HUMAN" ("Dymple" "DNM1L" "DLP1" "HdynIV" "DRP1" "DVLP")) 
<<<<<<< .mine
(define-protein "DNM3A_HUMAN" ("DNMT3a" "DNA (cytosine-5)-methyltransferase 3A" "Dnmt3a" "DNA methyltransferase HsaIIIA" "DNA MTase HsaIIIA" "M.HsaIIIA"))
(define-protein "DNM3B_HUMAN" ("DNMT3b" "DNA (cytosine-5)-methyltransferase 3B" "Dnmt3b" "DNA methyltransferase HsaIIIB" "DNA MTase HsaIIIB" "M.HsaIIIB"))
(define-protein "DNMT1_HUMAN" ("DNMT-1" "DNA (cytosine-5)-methyltransferase 1" "Dnmt1" "CXXC-type zinc finger protein 9" "DNA methyltransferase HsaI" "DNA MTase HsaI" "M.HsaI" "MCMT"))
=======
<<<<<<< .mine
(define-protein "DNM3A_HUMAN" ("DNMT3a" "DNA (cytosine-5)-methyltransferase 3A" "Dnmt3a" "DNA methyltransferase HsaIIIA" "DNA MTase HsaIIIA" "M.HsaIIIA"))
(define-protein "DNM3B_HUMAN" ("DNMT3b" "DNA (cytosine-5)-methyltransferase 3B" "Dnmt3b" "DNA methyltransferase HsaIIIB" "DNA MTase HsaIIIB" "M.HsaIIIB"))
(define-protein "DNMT1_HUMAN" ("DNMT-1" "DNA (cytosine-5)-methyltransferase 1" "Dnmt1" "CXXC-type zinc finger protein 9" "DNA methyltransferase HsaI" "DNA MTase HsaI" "M.HsaI" "MCMT"))
=======
(define-protein "DNM3A_HUMAN" ("DNA (cytosine-5)-methyltransferase 3A" "Dnmt3a" "DNA methyltransferase HsaIIIA" "DNA MTase HsaIIIA" "M.HsaIIIA"))
(define-protein "DNM3B_HUMAN" ("DNA (cytosine-5)-methyltransferase 3B" "Dnmt3b" "DNA methyltransferase HsaIIIB" "DNA MTase HsaIIIB" "M.HsaIIIB"))
(define-protein "DNMT1_HUMAN" ("DNA (cytosine-5)-methyltransferase 1" "Dnmt1" "CXXC-type zinc finger protein 9" "DNA methyltransferase HsaI" "DNA MTase HsaI" "M.HsaI" "MCMT"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "DOCK5_HUMAN" ("DOCK5")) 
<<<<<<< .mine
(define-protein "DOK3_HUMAN" ("Dok-3" "Docking protein 3" "Downstream of tyrosine kinase 3"))
=======
<<<<<<< .mine
(define-protein "DOK3_HUMAN" ("Dok-3" "Docking protein 3" "Downstream of tyrosine kinase 3"))
=======
(define-protein "DOK3_HUMAN" ("Docking protein 3" "Downstream of tyrosine kinase 3"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "DOP2_HUMAN" ("KIAA0933" "C21orf5" "DOPEY2")) 
(define-protein "DP13B_HUMAN" ("APPL2" "Dip13-beta" "DIP13B")) 
(define-protein "DPOLB_HUMAN" ("POLB")) 
<<<<<<< .mine
(define-protein "DQB2_HUMAN" ("subregions" "HLA class II histocompatibility antigen, DQ beta 2 chain" "HLA class II histocompatibility antigen, DX beta chain" "MHC class II antigen DQB2"))
(define-protein "DRD5_HUMAN" ("dopamine" "D(1B) dopamine receptor" "D(5) dopamine receptor" "D1beta dopamine receptor" "Dopamine D5 receptor"))
=======
<<<<<<< .mine
(define-protein "DQB2_HUMAN" ("subregions" "HLA class II histocompatibility antigen, DQ beta 2 chain" "HLA class II histocompatibility antigen, DX beta chain" "MHC class II antigen DQB2"))
(define-protein "DRD5_HUMAN" ("dopamine" "D(1B) dopamine receptor" "D(5) dopamine receptor" "D1beta dopamine receptor" "Dopamine D5 receptor"))
=======
(define-protein "DQB2_HUMAN" ("HLA class II histocompatibility antigen, DQ beta 2 chain" "HLA class II histocompatibility antigen, DX beta chain" "MHC class II antigen DQB2"))
(define-protein "DRD5_HUMAN" ("D(1B) dopamine receptor" "D(5) dopamine receptor" "D1beta dopamine receptor" "Dopamine D5 receptor"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "DRG1_HUMAN" ("NEDD3" "NEDD-3" "DRG1" "DRG-1")) 
<<<<<<< .mine
(define-protein "DSC3_HUMAN" ("Dsc3" "Desmocollin-3" "Cadherin family member 3" "Desmocollin-4" "HT-CP"))
=======
<<<<<<< .mine
(define-protein "DSC3_HUMAN" ("Dsc3" "Desmocollin-3" "Cadherin family member 3" "Desmocollin-4" "HT-CP"))
=======
(define-protein "DSC3_HUMAN" ("Desmocollin-3" "Cadherin family member 3" "Desmocollin-4" "HT-CP"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "DSG1_HUMAN" ("Desmoglein-1" "Cadherin family member 4" "Desmosomal glycoprotein 1" "DG1" "DGI" "Pemphigus foliaceus antigen"))
<<<<<<< .mine
(define-protein "DSG2_HUMAN" ("Dsg2" "Desmoglein-2" "Cadherin family member 5" "HDGC"))
=======
<<<<<<< .mine
(define-protein "DSG2_HUMAN" ("Dsg2" "Desmoglein-2" "Cadherin family member 5" "HDGC"))
=======
(define-protein "DSG2_HUMAN" ("Desmoglein-2" "Cadherin family member 5" "HDGC"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "DSG3_HUMAN" ("Desmoglein-3" "130 kDa pemphigus vulgaris antigen" "PVA" "Cadherin family member 6"))
<<<<<<< .mine
(define-protein "DSPP_HUMAN" ("dspp" "Dentin sialophosphoprotein"))
(define-protein "DSRAD_HUMAN" ("adar" "Double-stranded RNA-specific adenosine deaminase" "DRADA" "136 kDa double-stranded RNA-binding protein" "p136" "Interferon-inducible protein 4" "IFI-4" "K88DSRBP"))
=======
<<<<<<< .mine
(define-protein "DSPP_HUMAN" ("dspp" "Dentin sialophosphoprotein"))
(define-protein "DSRAD_HUMAN" ("adar" "Double-stranded RNA-specific adenosine deaminase" "DRADA" "136 kDa double-stranded RNA-binding protein" "p136" "Interferon-inducible protein 4" "IFI-4" "K88DSRBP"))
=======
(define-protein "DSPP_HUMAN" ("Dentin sialophosphoprotein"))
(define-protein "DSRAD_HUMAN" ("Double-stranded RNA-specific adenosine deaminase" "DRADA" "136 kDa double-stranded RNA-binding protein" "p136" "Interferon-inducible protein 4" "IFI-4" "K88DSRBP"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "DSS1_HUMAN" ("26S proteasome complex subunit DSS1" "Deleted in split hand/split foot protein 1" "Split hand/foot deleted protein 1" "Split hand/foot malformation type 1 protein"))
(define-protein "DTBP1_HUMAN" ("BLOC1S8" "DTNBP1" "Dysbindin-1")) 
(define-protein "DTL_HUMAN" ("Cdt2" "Denticleless protein homolog" "DDB1- and CUL4-associated factor 2" "Lethal(2) denticleless protein homolog" "Retinoic acid-regulated nuclear matrix-associated protein"))
(define-protein "DTL_HUMAN" ("Denticleless protein homolog" "DDB1- and CUL4-associated factor 2" "Lethal(2) denticleless protein homolog" "Retinoic acid-regulated nuclear matrix-associated protein"))
<<<<<<< .mine
(define-protein "DUOX1_HUMAN" ("forskolin" "Dual oxidase 1" "Large NOX 1" "Long NOX 1" "NADPH thyroid oxidase 1" "Thyroid oxidase 1"))
(define-protein "DUOX2_HUMAN" ("hudson" "Dual oxidase 2" "Large NOX 2" "Long NOX 2" "NADH/NADPH thyroid oxidase p138-tox" "NADPH oxidase/peroxidase DUOX2" "NADPH thyroid oxidase 2" "Thyroid oxidase 2" "p138 thyroid oxidase"))
=======
<<<<<<< .mine
(define-protein "DUOX1_HUMAN" ("forskolin" "Dual oxidase 1" "Large NOX 1" "Long NOX 1" "NADPH thyroid oxidase 1" "Thyroid oxidase 1"))
(define-protein "DUOX2_HUMAN" ("hudson" "Dual oxidase 2" "Large NOX 2" "Long NOX 2" "NADH/NADPH thyroid oxidase p138-tox" "NADPH oxidase/peroxidase DUOX2" "NADPH thyroid oxidase 2" "Thyroid oxidase 2" "p138 thyroid oxidase"))
=======
(define-protein "DUOX1_HUMAN" ("Dual oxidase 1" "Large NOX 1" "Long NOX 1" "NADPH thyroid oxidase 1" "Thyroid oxidase 1"))
(define-protein "DUOX2_HUMAN" ("Dual oxidase 2" "Large NOX 2" "Long NOX 2" "NADH/NADPH thyroid oxidase p138-tox" "NADPH oxidase/peroxidase DUOX2" "NADPH thyroid oxidase 2" "Thyroid oxidase 2" "p138 thyroid oxidase"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "DUS1_HUMAN" ("Dual specificity protein phosphatase 1" "Dual specificity protein phosphatase hVH1" "Mitogen-activated protein kinase phosphatase 1" "MAP kinase phosphatase 1" "MKP-1" "Protein-tyrosine phosphatase CL100"))
(define-protein "DUS23_HUMAN" ("LDP-3" "DUSP23" "VHZ" "LDP3")) 
(define-protein "DUS3_HUMAN" ("VHR" "DUSP3")) 
(define-protein "DUS6_HUMAN" ("Dual specificity protein phosphatase 6" "Dual specificity protein phosphatase PYST1" "Mitogen-activated protein kinase phosphatase 3" "MAP kinase phosphatase 3" "MKP-3"))
(define-protein "DUX3_HUMAN" ("DUX3")) 
<<<<<<< .mine
(define-protein "DUX4C_HUMAN" ("miR-133a" "Double homeobox protein 4C" "Double homeobox protein 4, centromeric" "DUX4c" "Double homeobox protein 4-like protein 9"))
(define-protein "DVL2_HUMAN" ("dsh" "Segment polarity protein dishevelled homolog DVL-2" "Dishevelled-2" "DSH homolog 2"))
=======
<<<<<<< .mine
(define-protein "DUX4C_HUMAN" ("miR-133a" "Double homeobox protein 4C" "Double homeobox protein 4, centromeric" "DUX4c" "Double homeobox protein 4-like protein 9"))
(define-protein "DVL2_HUMAN" ("dsh" "Segment polarity protein dishevelled homolog DVL-2" "Dishevelled-2" "DSH homolog 2"))
=======
(define-protein "DUX4C_HUMAN" ("Double homeobox protein 4C" "Double homeobox protein 4, centromeric" "DUX4c" "Double homeobox protein 4-like protein 9"))
(define-protein "DVL2_HUMAN" ("Segment polarity protein dishevelled homolog DVL-2" "Dishevelled-2" "DSH homolog 2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "DYHC1_HUMAN" ("KIAA0325" "DYNC1H1" "DHC1" "DNCL" "DYHC" "DNECL" "DNCH1")) 
<<<<<<< .mine
(define-protein "DYHC2_HUMAN" ("isotype-" "Cytoplasmic dynein 2 heavy chain 1" "Cytoplasmic dynein 2 heavy chain" "Dynein cytoplasmic heavy chain 2" "Dynein heavy chain 11" "hDHC11" "Dynein heavy chain isotype 1B"))
=======
<<<<<<< .mine
(define-protein "DYHC2_HUMAN" ("isotype-" "Cytoplasmic dynein 2 heavy chain 1" "Cytoplasmic dynein 2 heavy chain" "Dynein cytoplasmic heavy chain 2" "Dynein heavy chain 11" "hDHC11" "Dynein heavy chain isotype 1B"))
=======
(define-protein "DYHC2_HUMAN" ("Cytoplasmic dynein 2 heavy chain 1" "Cytoplasmic dynein 2 heavy chain" "Dynein cytoplasmic heavy chain 2" "Dynein heavy chain 11" "hDHC11" "Dynein heavy chain isotype 1B"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "DYL1_HUMAN" ("DYNLL1" "DNCL1" "HDLC1" "PIN" "DNCLC1" "DLC8" "DLC1")) 
<<<<<<< .mine
(define-protein "DYLT1_HUMAN" ("Tctex-1" "Dynein light chain Tctex-type 1" "Protein CW-1" "T-complex testis-specific protein 1 homolog"))
(define-protein "DYN1_HUMAN" ("dynamin-1" "Dynamin-1"))
=======
<<<<<<< .mine
(define-protein "DYLT1_HUMAN" ("Tctex-1" "Dynein light chain Tctex-type 1" "Protein CW-1" "T-complex testis-specific protein 1 homolog"))
(define-protein "DYN1_HUMAN" ("dynamin-1" "Dynamin-1"))
=======
(define-protein "DYLT1_HUMAN" ("Dynein light chain Tctex-type 1" "Protein CW-1" "T-complex testis-specific protein 1 homolog"))
(define-protein "DYN1_HUMAN" ("Dynamin-1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "DYRK2_HUMAN" ("Dual specificity tyrosine-phosphorylation-regulated kinase 2"))
(define-protein "DYST_HUMAN" ("DST" "DMH" "DT" "BPA" "KIAA0728" "BP230" "BPAG1" "BP240")) 
<<<<<<< .mine
(define-protein "E2AK1_HUMAN" ("heme" "Eukaryotic translation initiation factor 2-alpha kinase 1" "Heme-controlled repressor" "HCR" "Heme-regulated eukaryotic initiation factor eIF-2-alpha kinase" "Heme-regulated inhibitor" "Hemin-sensitive initiation factor 2-alpha kinase"))
(define-protein "E2ERX5_EBVG" ("Y28" "Latent membrane protein 2A"))
(define-protein "E2F1Z4_9HIV1" ("PP3" "Envelope glycoprotein"))
=======
<<<<<<< .mine
(define-protein "E2AK1_HUMAN" ("heme" "Eukaryotic translation initiation factor 2-alpha kinase 1" "Heme-controlled repressor" "HCR" "Heme-regulated eukaryotic initiation factor eIF-2-alpha kinase" "Heme-regulated inhibitor" "Hemin-sensitive initiation factor 2-alpha kinase"))
(define-protein "E2ERX5_EBVG" ("Y28" "Latent membrane protein 2A"))
(define-protein "E2F1Z4_9HIV1" ("PP3" "Envelope glycoprotein"))
=======
(define-protein "E2AK1_HUMAN" ("Eukaryotic translation initiation factor 2-alpha kinase 1" "Heme-controlled repressor" "HCR" "Heme-regulated eukaryotic initiation factor eIF-2-alpha kinase" "Heme-regulated inhibitor" "Hemin-sensitive initiation factor 2-alpha kinase"))
(define-protein "E2ERX5_EBVG" ("Latent membrane protein 2A"))
(define-protein "E2F1Z4_9HIV1" ("Envelope glycoprotein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "E2F1_HUMAN" ("Transcription factor E2F1" "E2F-1" "PBR3" "Retinoblastoma-associated protein 1" "RBAP-1" "Retinoblastoma-binding protein 3" "RBBP-3" "pRB-binding protein E2F-1"))
(define-protein "E3GL_ADE05" ("Early E3 18.5 kDa glycoprotein" "E3-19K" "E3gp 19 kDa" "E19" "GP19K"))
(define-protein "E41L1_HUMAN" ("KIAA0338" "EPB41L1")) 
(define-protein "E41L2_HUMAN" ("EPB41L2")) 
(define-protein "E41L5_HUMAN" ("KIAA1548" "EPB41L5")) 
(define-protein "E41LA_HUMAN" ("EPB41L4A" "EPB41L4")) 
<<<<<<< .mine
(define-protein "EBP2_HUMAN" ("EBP-2" "Probable rRNA-processing protein EBP2" "EBNA1-binding protein 2" "Nucleolar protein p40"))
=======
<<<<<<< .mine
(define-protein "EBP2_HUMAN" ("EBP-2" "Probable rRNA-processing protein EBP2" "EBNA1-binding protein 2" "Nucleolar protein p40"))
=======
(define-protein "EBP2_HUMAN" ("Probable rRNA-processing protein EBP2" "EBNA1-binding protein 2" "Nucleolar protein p40"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ECHA_HUMAN" ("TP-alpha" "HADH" "HADHA")) 
(define-protein "ECHB_HUMAN" ("HADHB" "Beta-ketothiolase" "TP-beta")) 
(define-protein "ECHP_HUMAN" ("PBFE" "EHHADH" "PBE" "ECHD")) 
(define-protein "ECM29_HUMAN" ("ECM29" "KIAA0368" "Ecm29")) 
<<<<<<< .mine
(define-protein "ECSCR_HUMAN" ("chemotaxis" "Endothelial cell-specific chemotaxis regulator" "Apoptosis regulator through modulating IAP expression" "ARIA" "Endothelial cell-specific molecule 2"))
=======
<<<<<<< .mine
(define-protein "ECSCR_HUMAN" ("chemotaxis" "Endothelial cell-specific chemotaxis regulator" "Apoptosis regulator through modulating IAP expression" "ARIA" "Endothelial cell-specific molecule 2"))
=======
(define-protein "ECSCR_HUMAN" ("Endothelial cell-specific chemotaxis regulator" "Apoptosis regulator through modulating IAP expression" "ARIA" "Endothelial cell-specific molecule 2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ECSIT_HUMAN" ("ECSIT")) 
(define-protein "ECT2_HUMAN" ("Protein ECT2" "Epithelial cell-transforming sequence 2 oncogene"))
<<<<<<< .mine
(define-protein "EDC3_HUMAN" ("N2" "Enhancer of mRNA-decapping protein 3" "LSM16 homolog" "YjeF N-terminal domain-containing protein 2" "YjeF_N2" "hYjeF_N2" "YjeF domain-containing protein 1"))
(define-protein "EDN1_HUMAN" ("endothelin-1" "Endothelin-1" "Preproendothelin-1" "PPET1"))
(define-protein "EDNRA_HUMAN" ("AR-" "Endothelin-1 receptor" "Endothelin A receptor" "ET-A" "ETA-R" "hET-AR"))
(define-protein "EEA1_HUMAN" ("EEA-1" "Early endosome antigen 1" "Endosome-associated protein p162" "Zinc finger FYVE domain-containing protein 2"))
=======
<<<<<<< .mine
(define-protein "EDC3_HUMAN" ("N2" "Enhancer of mRNA-decapping protein 3" "LSM16 homolog" "YjeF N-terminal domain-containing protein 2" "YjeF_N2" "hYjeF_N2" "YjeF domain-containing protein 1"))
(define-protein "EDN1_HUMAN" ("endothelin-1" "Endothelin-1" "Preproendothelin-1" "PPET1"))
(define-protein "EDNRA_HUMAN" ("AR-" "Endothelin-1 receptor" "Endothelin A receptor" "ET-A" "ETA-R" "hET-AR"))
(define-protein "EEA1_HUMAN" ("EEA-1" "Early endosome antigen 1" "Endosome-associated protein p162" "Zinc finger FYVE domain-containing protein 2"))
=======
(define-protein "EDC3_HUMAN" ("Enhancer of mRNA-decapping protein 3" "LSM16 homolog" "YjeF N-terminal domain-containing protein 2" "YjeF_N2" "hYjeF_N2" "YjeF domain-containing protein 1"))
(define-protein "EDN1_HUMAN" ("Endothelin-1" "Preproendothelin-1" "PPET1"))
(define-protein "EDNRA_HUMAN" ("Endothelin-1 receptor" "Endothelin A receptor" "ET-A" "ETA-R" "hET-AR"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "EEA1_HUMAN" ("Early endosome antigen 1" "Endosome-associated protein p162" "Zinc finger FYVE domain-containing protein 2"))
<<<<<<< .mine
(define-protein "EED_HUMAN" ("PRC2" "Polycomb protein EED" "hEED" "WD protein associating with integrin cytoplasmic tails 1" "WAIT-1"))
=======
<<<<<<< .mine
(define-protein "EED_HUMAN" ("PRC2" "Polycomb protein EED" "hEED" "WD protein associating with integrin cytoplasmic tails 1" "WAIT-1"))
=======
(define-protein "EED_HUMAN" ("Polycomb protein EED" "hEED" "WD protein associating with integrin cytoplasmic tails 1" "WAIT-1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "EF1A1_HUMAN" ("EEF1A" "EF1A" "LENG7" "EF-1-alpha-1" "eEF1A-1" "EEF1A1" "EF-Tu")) 
<<<<<<< .mine
(define-protein "EF1A2_HUMAN" ("eEF1A2" "Elongation factor 1-alpha 2" "EF-1-alpha-2" "Eukaryotic elongation factor 1 A-2" "eEF1A-2" "Statin-S1"))
(define-protein "EFHD2_HUMAN" ("WEHI-231" "EF-hand domain-containing protein D2" "Swiprosin-1"))
(define-protein "EFNB1_HUMAN" ("EphrinB1" "Ephrin-B1" "EFL-3" "ELK ligand" "ELK-L" "EPH-related receptor tyrosine kinase ligand 2" "LERK-2"))
(define-protein "EFNB2_HUMAN" ("ephrinb" "Ephrin-B2" "EPH-related receptor tyrosine kinase ligand 5" "LERK-5" "HTK ligand" "HTK-L"))
(define-protein "EGF_HUMAN" ("EGF-" "Pro-epidermal growth factor" "EGF"))
=======
<<<<<<< .mine
(define-protein "EF1A2_HUMAN" ("eEF1A2" "Elongation factor 1-alpha 2" "EF-1-alpha-2" "Eukaryotic elongation factor 1 A-2" "eEF1A-2" "Statin-S1"))
(define-protein "EFHD2_HUMAN" ("WEHI-231" "EF-hand domain-containing protein D2" "Swiprosin-1"))
(define-protein "EFNB1_HUMAN" ("EphrinB1" "Ephrin-B1" "EFL-3" "ELK ligand" "ELK-L" "EPH-related receptor tyrosine kinase ligand 2" "LERK-2"))
(define-protein "EFNB2_HUMAN" ("ephrinb" "Ephrin-B2" "EPH-related receptor tyrosine kinase ligand 5" "LERK-5" "HTK ligand" "HTK-L"))
(define-protein "EGF_HUMAN" ("EGF-" "Pro-epidermal growth factor" "EGF"))
=======
(define-protein "EF1A2_HUMAN" ("Elongation factor 1-alpha 2" "EF-1-alpha-2" "Eukaryotic elongation factor 1 A-2" "eEF1A-2" "Statin-S1"))
(define-protein "EFHD2_HUMAN" ("EF-hand domain-containing protein D2" "Swiprosin-1"))
(define-protein "EFNB1_HUMAN" ("Ephrin-B1" "EFL-3" "ELK ligand" "ELK-L" "EPH-related receptor tyrosine kinase ligand 2" "LERK-2"))
(define-protein "EFNB2_HUMAN" ("Ephrin-B2" "EPH-related receptor tyrosine kinase ligand 5" "LERK-5" "HTK ligand" "HTK-L"))
(define-protein "EGF_HUMAN" ("Pro-epidermal growth factor" "EGF"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "EGLN1_HUMAN" ("HIF-PH2" "HPH-2" "SM-20" "C1orf12" "EGLN1" "PHD2")) 
<<<<<<< .mine
(define-protein "EGLN3_HUMAN" ("hifs" "Egl nine homolog 3" "HPH-1" "Hypoxia-inducible factor prolyl hydroxylase 3" "HIF-PH3" "HIF-prolyl hydroxylase 3" "HPH-3" "Prolyl hydroxylase domain-containing protein 3" "PHD3"))
=======
<<<<<<< .mine
(define-protein "EGLN3_HUMAN" ("hifs" "Egl nine homolog 3" "HPH-1" "Hypoxia-inducible factor prolyl hydroxylase 3" "HIF-PH3" "HIF-prolyl hydroxylase 3" "HPH-3" "Prolyl hydroxylase domain-containing protein 3" "PHD3"))
=======
(define-protein "EGLN3_HUMAN" ("Egl nine homolog 3" "HPH-1" "Hypoxia-inducible factor prolyl hydroxylase 3" "HIF-PH3" "HIF-prolyl hydroxylase 3" "HPH-3" "Prolyl hydroxylase domain-containing protein 3" "PHD3"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "EGR1_HUMAN" ("Early growth response protein 1" "EGR-1" "AT225" "Nerve growth factor-induced protein A" "NGFI-A" "Transcription factor ETR103" "Transcription factor Zif268" "Zinc finger protein 225" "Zinc finger protein Krox-24"))
(define-protein "EGR1_HUMAN" ("zif/268" "Early growth response protein 1" "EGR-1" "AT225" "Nerve growth factor-induced protein A" "NGFI-A" "Transcription factor ETR103" "Transcription factor Zif268" "Zinc finger protein 225" "Zinc finger protein Krox-24"))
(define-protein "EHD1_HUMAN" ("EHD1" "Testilin" "hPAST1" "PAST" "PAST1")) 
(define-protein "EHD4_HUMAN" ("EHD4" "HCA11" "HCA10" "PAST4")) 
<<<<<<< .mine
(define-protein "EHMT2_HUMAN" ("G9a" "Histone-lysine N-methyltransferase EHMT2" "Euchromatic histone-lysine N-methyltransferase 2" "HLA-B-associated transcript 8" "Histone H3-K9 methyltransferase 3" "H3-K9-HMTase 3" "Lysine N-methyltransferase 1C" "Protein G9a"))
(define-protein "EI24_HUMAN" ("etoposide" "Etoposide-induced protein 2.4 homolog" "p53-induced gene 8 protein"))
=======
<<<<<<< .mine
(define-protein "EHMT2_HUMAN" ("G9a" "Histone-lysine N-methyltransferase EHMT2" "Euchromatic histone-lysine N-methyltransferase 2" "HLA-B-associated transcript 8" "Histone H3-K9 methyltransferase 3" "H3-K9-HMTase 3" "Lysine N-methyltransferase 1C" "Protein G9a"))
(define-protein "EI24_HUMAN" ("etoposide" "Etoposide-induced protein 2.4 homolog" "p53-induced gene 8 protein"))
=======
(define-protein "EHMT2_HUMAN" ("Histone-lysine N-methyltransferase EHMT2" "Euchromatic histone-lysine N-methyltransferase 2" "HLA-B-associated transcript 8" "Histone H3-K9 methyltransferase 3" "H3-K9-HMTase 3" "Lysine N-methyltransferase 1C" "Protein G9a"))
(define-protein "EI24_HUMAN" ("Etoposide-induced protein 2.4 homolog" "p53-induced gene 8 protein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "EI2BA_HUMAN" ("EIF2B1" "EIF2BA")) 
(define-protein "EI2BB_HUMAN" ("EIF2B2" "S20I15" "EIF2BB" "S20III15")) 
(define-protein "EI2BD_HUMAN" ("EIF2BD" "EIF2B4")) 
(define-protein "EI2BE_HUMAN" ("EIF2BE" "EIF2B5")) 
(define-protein "EI2BG_HUMAN" ("EIF2B3")) 
<<<<<<< .mine
(define-protein "EIF1A_HUMAN" ("U87MG" "Probable RNA-binding protein EIF1AD" "Eukaryotic translation initiation factor 1A domain-containing protein" "Haponin"))
=======
<<<<<<< .mine
(define-protein "EIF1A_HUMAN" ("U87MG" "Probable RNA-binding protein EIF1AD" "Eukaryotic translation initiation factor 1A domain-containing protein" "Haponin"))
=======
(define-protein "EIF1A_HUMAN" ("Probable RNA-binding protein EIF1AD" "Eukaryotic translation initiation factor 1A domain-containing protein" "Haponin"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "EIF2D_HUMAN" ("EIF2D" "HCA56" "eIF2d" "LGTN" "Ligatin")) 
(define-protein "EIF3B_HUMAN" ("eIF3b" "EIF3S9")) 
<<<<<<< .mine
(define-protein "EIF3G_HUMAN" ("factor-3" "Eukaryotic translation initiation factor 3 subunit G" "eIF3g" "Eukaryotic translation initiation factor 3 RNA-binding subunit" "eIF-3 RNA-binding subunit" "Eukaryotic translation initiation factor 3 subunit 4" "eIF-3-delta" "eIF3 p42" "eIF3 p44"))
=======
<<<<<<< .mine
(define-protein "EIF3G_HUMAN" ("factor-3" "Eukaryotic translation initiation factor 3 subunit G" "eIF3g" "Eukaryotic translation initiation factor 3 RNA-binding subunit" "eIF-3 RNA-binding subunit" "Eukaryotic translation initiation factor 3 subunit 4" "eIF-3-delta" "eIF3 p42" "eIF3 p44"))
=======
(define-protein "EIF3G_HUMAN" ("Eukaryotic translation initiation factor 3 subunit G" "eIF3g" "Eukaryotic translation initiation factor 3 RNA-binding subunit" "eIF-3 RNA-binding subunit" "Eukaryotic translation initiation factor 3 subunit 4" "eIF-3-delta" "eIF3 p42" "eIF3 p44"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "EIF3M_HUMAN" ("EIF3M" "hFL-B5" "PCID1" "HFLB5" "eIF3m")) 
(define-protein "ELAF_HUMAN" ("PI3" "WAP3" "WFDC14")) 
(define-protein "ELAV1_HUMAN" ("HuR" "HUR" "ELAVL1")) 
(define-protein "ELK1_HUMAN" ("Elk-1")) 
<<<<<<< .mine
(define-protein "ELK4_HUMAN" ("Elk4" "ETS domain-containing protein Elk-4" "Serum response factor accessory protein 1" "SAP-1" "SRF accessory protein 1"))
=======
<<<<<<< .mine
(define-protein "ELK4_HUMAN" ("Elk4" "ETS domain-containing protein Elk-4" "Serum response factor accessory protein 1" "SAP-1" "SRF accessory protein 1"))
=======
(define-protein "ELK4_HUMAN" ("ETS domain-containing protein Elk-4" "Serum response factor accessory protein 1" "SAP-1" "SRF accessory protein 1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ELMO3_HUMAN" ("ELMO3")) 
(define-protein "ELOF1_HUMAN" ("ELOF1")) 
<<<<<<< .mine
(define-protein "ELOV5_HUMAN" ("FA-" "Elongation of very long chain fatty acids protein 5" "3-keto acyl-CoA synthase ELOVL5" "ELOVL fatty acid elongase 5" "ELOVL FA elongase 5" "Fatty acid elongase 1" "hELO1" "Very-long-chain 3-oxoacyl-CoA synthase 5"))
(define-protein "EMC10_HUMAN" ("inm" "ER membrane protein complex subunit 10" "Hematopoietic signal peptide-containing membrane domain-containing protein 1"))
(define-protein "EMD_HUMAN" ("emerin" "Emerin"))
(define-protein "ENAH_HUMAN" ("mena" "Protein enabled homolog"))
(define-protein "ENK18_HUMAN" ("K110" "Endogenous retrovirus group K member 18 Env polyprotein" "Envelope polyprotein" "HERV-K(C1a) envelope protein" "HERV-K110 envelope protein" "HERV-K18 envelope protein" "HERV-K18 superantigen" "HERV-K_1q23.3 provirus ancestral Env polyprotein" "IDDMK1,2 22 envelope protein" "IDDMK1,2 22 superantigen"))
(define-protein "ENKUR_HUMAN" ("enkur" "Enkurin"))
=======
<<<<<<< .mine
(define-protein "ELOV5_HUMAN" ("FA-" "Elongation of very long chain fatty acids protein 5" "3-keto acyl-CoA synthase ELOVL5" "ELOVL fatty acid elongase 5" "ELOVL FA elongase 5" "Fatty acid elongase 1" "hELO1" "Very-long-chain 3-oxoacyl-CoA synthase 5"))
(define-protein "EMC10_HUMAN" ("inm" "ER membrane protein complex subunit 10" "Hematopoietic signal peptide-containing membrane domain-containing protein 1"))
(define-protein "EMD_HUMAN" ("emerin" "Emerin"))
(define-protein "ENAH_HUMAN" ("mena" "Protein enabled homolog"))
(define-protein "ENK18_HUMAN" ("K110" "Endogenous retrovirus group K member 18 Env polyprotein" "Envelope polyprotein" "HERV-K(C1a) envelope protein" "HERV-K110 envelope protein" "HERV-K18 envelope protein" "HERV-K18 superantigen" "HERV-K_1q23.3 provirus ancestral Env polyprotein" "IDDMK1,2 22 envelope protein" "IDDMK1,2 22 superantigen"))
(define-protein "ENKUR_HUMAN" ("enkur" "Enkurin"))
=======
(define-protein "ELOV5_HUMAN" ("Elongation of very long chain fatty acids protein 5" "3-keto acyl-CoA synthase ELOVL5" "ELOVL fatty acid elongase 5" "ELOVL FA elongase 5" "Fatty acid elongase 1" "hELO1" "Very-long-chain 3-oxoacyl-CoA synthase 5"))
(define-protein "EMC10_HUMAN" ("ER membrane protein complex subunit 10" "Hematopoietic signal peptide-containing membrane domain-containing protein 1"))
(define-protein "EMD_HUMAN" ("Emerin"))
(define-protein "ENAH_HUMAN" ("Protein enabled homolog"))
(define-protein "ENK18_HUMAN" ("Endogenous retrovirus group K member 18 Env polyprotein" "Envelope polyprotein" "HERV-K(C1a) envelope protein" "HERV-K110 envelope protein" "HERV-K18 envelope protein" "HERV-K18 superantigen" "HERV-K_1q23.3 provirus ancestral Env polyprotein" "IDDMK1,2 22 envelope protein" "IDDMK1,2 22 superantigen"))
(define-protein "ENKUR_HUMAN" ("Enkurin"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ENOA_HUMAN" ("MBPB1" "MPB-1" "NNE" "ENO1" "ENO1L1" "MPB1" "MBP-1")) 
<<<<<<< .mine
(define-protein "ENPL_HUMAN" ("protein-90" "Endoplasmin" "94 kDa glucose-regulated protein" "GRP-94" "Heat shock protein 90 kDa beta member 1" "Tumor rejection antigen 1" "gp96 homolog"))
(define-protein "ENTP1_HUMAN" ("ecto" "Ectonucleoside triphosphate diphosphohydrolase 1" "NTPDase 1" "Ecto-ATP diphosphohydrolase 1" "Ecto-ATPDase 1" "Ecto-ATPase 1" "Ecto-apyrase" "Lymphoid cell activation antigen"))
(define-protein "EP400_HUMAN" ("Swi2/Snf2" "E1A-binding protein p400" "CAG repeat protein 32" "Domino homolog" "hDomino" "Trinucleotide repeat-containing gene 12 protein" "p400 kDa SWI2/SNF2-related protein"))
(define-protein "EPAS1_HUMAN" ("Hif2a" "Endothelial PAS domain-containing protein 1" "EPAS-1" "Basic-helix-loop-helix-PAS protein MOP2" "Class E basic helix-loop-helix protein 73" "bHLHe73" "HIF-1-alpha-like factor" "HLF" "Hypoxia-inducible factor 2-alpha" "HIF-2-alpha" "HIF2-alpha" "Member of PAS protein 2" "PAS domain-containing protein 2"))
=======
<<<<<<< .mine
(define-protein "ENPL_HUMAN" ("protein-90" "Endoplasmin" "94 kDa glucose-regulated protein" "GRP-94" "Heat shock protein 90 kDa beta member 1" "Tumor rejection antigen 1" "gp96 homolog"))
(define-protein "ENTP1_HUMAN" ("ecto" "Ectonucleoside triphosphate diphosphohydrolase 1" "NTPDase 1" "Ecto-ATP diphosphohydrolase 1" "Ecto-ATPDase 1" "Ecto-ATPase 1" "Ecto-apyrase" "Lymphoid cell activation antigen"))
(define-protein "EP400_HUMAN" ("Swi2/Snf2" "E1A-binding protein p400" "CAG repeat protein 32" "Domino homolog" "hDomino" "Trinucleotide repeat-containing gene 12 protein" "p400 kDa SWI2/SNF2-related protein"))
(define-protein "EPAS1_HUMAN" ("Hif2a" "Endothelial PAS domain-containing protein 1" "EPAS-1" "Basic-helix-loop-helix-PAS protein MOP2" "Class E basic helix-loop-helix protein 73" "bHLHe73" "HIF-1-alpha-like factor" "HLF" "Hypoxia-inducible factor 2-alpha" "HIF-2-alpha" "HIF2-alpha" "Member of PAS protein 2" "PAS domain-containing protein 2"))
=======
(define-protein "ENPL_HUMAN" ("Endoplasmin" "94 kDa glucose-regulated protein" "GRP-94" "Heat shock protein 90 kDa beta member 1" "Tumor rejection antigen 1" "gp96 homolog"))
(define-protein "ENTP1_HUMAN" ("Ectonucleoside triphosphate diphosphohydrolase 1" "NTPDase 1" "Ecto-ATP diphosphohydrolase 1" "Ecto-ATPDase 1" "Ecto-ATPase 1" "Ecto-apyrase" "Lymphoid cell activation antigen"))
(define-protein "EP400_HUMAN" ("E1A-binding protein p400" "CAG repeat protein 32" "Domino homolog" "hDomino" "Trinucleotide repeat-containing gene 12 protein" "p400 kDa SWI2/SNF2-related protein"))
(define-protein "EPAS1_HUMAN" ("Endothelial PAS domain-containing protein 1" "EPAS-1" "Basic-helix-loop-helix-PAS protein MOP2" "Class E basic helix-loop-helix protein 73" "bHLHe73" "HIF-1-alpha-like factor" "HLF" "Hypoxia-inducible factor 2-alpha" "HIF-2-alpha" "HIF2-alpha" "Member of PAS protein 2" "PAS domain-containing protein 2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "EPB42_HUMAN" ("EPB42" "P4.2" "E42P")) 
(define-protein "EPCAM_HUMAN" ("EPCAM" "hEGP314" "Ep-CAM" "EGP314" "KSA" "M4S1" "CD326" "TACSTD1" "GA733-2" "M1S2" "EGP" "TROP1" "MIC18")) 
<<<<<<< .mine
(define-protein "EPHB1_HUMAN" ("interactors" "Ephrin type-B receptor 1" "ELK" "EPH tyrosine kinase 2" "EPH-like kinase 6" "EK6" "hEK6" "Neuronally-expressed EPH-related tyrosine kinase" "NET" "Tyrosine-protein kinase receptor EPH-2"))
(define-protein "EPS15_HUMAN" ("Eps15" "Epidermal growth factor receptor substrate 15" "Protein Eps15" "Protein AF-1p"))
=======
<<<<<<< .mine
(define-protein "EPHB1_HUMAN" ("interactors" "Ephrin type-B receptor 1" "ELK" "EPH tyrosine kinase 2" "EPH-like kinase 6" "EK6" "hEK6" "Neuronally-expressed EPH-related tyrosine kinase" "NET" "Tyrosine-protein kinase receptor EPH-2"))
(define-protein "EPS15_HUMAN" ("Eps15" "Epidermal growth factor receptor substrate 15" "Protein Eps15" "Protein AF-1p"))
=======
(define-protein "EPHB1_HUMAN" ("Ephrin type-B receptor 1" "ELK" "EPH tyrosine kinase 2" "EPH-like kinase 6" "EK6" "hEK6" "Neuronally-expressed EPH-related tyrosine kinase" "NET" "Tyrosine-protein kinase receptor EPH-2"))
(define-protein "EPS15_HUMAN" ("Epidermal growth factor receptor substrate 15" "Protein Eps15" "Protein AF-1p"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ERAP1_HUMAN" ("APPILS" "A-LAP" "KIAA0525" "PILS-AP" "ARTS-1" "ERAP1" "ARTS1")) 
(define-protein "ERBB2_HUMAN" ("Receptor tyrosine-protein kinase erbB-2" "Metastatic lymph node gene 19 protein" "MLN 19" "Proto-oncogene Neu" "Proto-oncogene c-ErbB-2" "Tyrosine kinase-type cell surface receptor HER2" "p185erbB2"))
(define-protein "ERBB2_HUMAN" ("c-erbB-2" "Receptor tyrosine-protein kinase erbB-2" "Metastatic lymph node gene 19 protein" "MLN 19" "Proto-oncogene Neu" "Proto-oncogene c-ErbB-2" "Tyrosine kinase-type cell surface receptor HER2" "p185erbB2"))
(define-protein "ERBB3_HUMAN" ("EGF-R" "Receptor tyrosine-protein kinase erbB-3" "Proto-oncogene-like protein c-ErbB-3" "Tyrosine kinase-type cell surface receptor HER3"))
(define-protein "ERBB3_HUMAN" ("Receptor tyrosine-protein kinase erbB-3" "Proto-oncogene-like protein c-ErbB-3" "Tyrosine kinase-type cell surface receptor HER3"))
(define-protein "ERBB4_HUMAN" ("ErbB-4" "Receptor tyrosine-protein kinase erbB-4" "Proto-oncogene-like protein c-ErbB-4" "Tyrosine kinase-type cell surface receptor HER4" "p180erbB4"))
(define-protein "ERBB4_HUMAN" ("Receptor tyrosine-protein kinase erbB-4" "Proto-oncogene-like protein c-ErbB-4" "Tyrosine kinase-type cell surface receptor HER4" "p180erbB4"))
<<<<<<< .mine
(define-protein "ERC6L_HUMAN" ("bj" "DNA excision repair protein ERCC-6-like" "ATP-dependent helicase ERCC6-like" "PLK1-interacting checkpoint helicase" "Tumor antigen BJ-HCC-15"))
=======
<<<<<<< .mine
(define-protein "ERC6L_HUMAN" ("bj" "DNA excision repair protein ERCC-6-like" "ATP-dependent helicase ERCC6-like" "PLK1-interacting checkpoint helicase" "Tumor antigen BJ-HCC-15"))
=======
(define-protein "ERC6L_HUMAN" ("DNA excision repair protein ERCC-6-like" "ATP-dependent helicase ERCC6-like" "PLK1-interacting checkpoint helicase" "Tumor antigen BJ-HCC-15"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ERCC1_HUMAN" ("DNA excision repair protein ERCC-1"))
<<<<<<< .mine
(define-protein "ERCC2_HUMAN" ("xpd" "TFIIH basal transcription factor complex helicase XPD subunit" "Basic transcription factor 2 80 kDa subunit" "BTF2 p80" "CXPD" "DNA excision repair protein ERCC-2" "DNA repair protein complementing XP-D cells" "TFIIH basal transcription factor complex 80 kDa subunit" "TFIIH 80 kDa subunit" "TFIIH p80" "Xeroderma pigmentosum group D-complementing protein"))
(define-protein "ERCC3_HUMAN" ("xpb" "TFIIH basal transcription factor complex helicase XPB subunit" "Basic transcription factor 2 89 kDa subunit" "BTF2 p89" "DNA excision repair protein ERCC-3" "DNA repair protein complementing XP-B cells" "TFIIH basal transcription factor complex 89 kDa subunit" "TFIIH 89 kDa subunit" "TFIIH p89" "Xeroderma pigmentosum group B-complementing protein"))
=======
<<<<<<< .mine
(define-protein "ERCC2_HUMAN" ("xpd" "TFIIH basal transcription factor complex helicase XPD subunit" "Basic transcription factor 2 80 kDa subunit" "BTF2 p80" "CXPD" "DNA excision repair protein ERCC-2" "DNA repair protein complementing XP-D cells" "TFIIH basal transcription factor complex 80 kDa subunit" "TFIIH 80 kDa subunit" "TFIIH p80" "Xeroderma pigmentosum group D-complementing protein"))
(define-protein "ERCC3_HUMAN" ("xpb" "TFIIH basal transcription factor complex helicase XPB subunit" "Basic transcription factor 2 89 kDa subunit" "BTF2 p89" "DNA excision repair protein ERCC-3" "DNA repair protein complementing XP-B cells" "TFIIH basal transcription factor complex 89 kDa subunit" "TFIIH 89 kDa subunit" "TFIIH p89" "Xeroderma pigmentosum group B-complementing protein"))
=======
(define-protein "ERCC2_HUMAN" ("TFIIH basal transcription factor complex helicase XPD subunit" "Basic transcription factor 2 80 kDa subunit" "BTF2 p80" "CXPD" "DNA excision repair protein ERCC-2" "DNA repair protein complementing XP-D cells" "TFIIH basal transcription factor complex 80 kDa subunit" "TFIIH 80 kDa subunit" "TFIIH p80" "Xeroderma pigmentosum group D-complementing protein"))
(define-protein "ERCC3_HUMAN" ("TFIIH basal transcription factor complex helicase XPB subunit" "Basic transcription factor 2 89 kDa subunit" "BTF2 p89" "DNA excision repair protein ERCC-3" "DNA repair protein complementing XP-B cells" "TFIIH basal transcription factor complex 89 kDa subunit" "TFIIH 89 kDa subunit" "TFIIH p89" "Xeroderma pigmentosum group B-complementing protein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ERGI1_HUMAN" ("KIAA1181" "ERGIC1" "ERGIC-32" "ERGIC32")) 
(define-protein "ERGI2_HUMAN" ("ERV41" "PTX1" "ERGIC2")) 
(define-protein "ERGI3_HUMAN" ("SDBCAG84" "ERV46" "ERGIC3" "C20orf47")) 
(define-protein "ERLN1_HUMAN" ("ERLIN1" "KEO4" "C10orf69" "KE04" "SPFH1")) 
(define-protein "ERLN2_HUMAN" ("ERLIN2" "C8orf2" "SPFH2")) 
(define-protein "ES8L2_HUMAN" ("EPS8R2" "EPS8L2")) 
(define-protein "ES8L3_HUMAN" ("EPS8R3" "EPS8L3")) 
<<<<<<< .mine
(define-protein "ESR1_HUMAN" ("erα" "Estrogen receptor" "ER" "ER-alpha" "Estradiol receptor" "Nuclear receptor subfamily 3 group A member 1"))
(define-protein "ESR2_HUMAN" ("erβ" "Estrogen receptor beta" "ER-beta" "Nuclear receptor subfamily 3 group A member 2"))
=======
<<<<<<< .mine
(define-protein "ESR1_HUMAN" ("erα" "Estrogen receptor" "ER" "ER-alpha" "Estradiol receptor" "Nuclear receptor subfamily 3 group A member 1"))
(define-protein "ESR2_HUMAN" ("erβ" "Estrogen receptor beta" "ER-beta" "Nuclear receptor subfamily 3 group A member 2"))
=======
(define-protein "ESR1_HUMAN" ("Estrogen receptor" "ER" "ER-alpha" "Estradiol receptor" "Nuclear receptor subfamily 3 group A member 1"))
(define-protein "ESR2_HUMAN" ("Estrogen receptor beta" "ER-beta" "Nuclear receptor subfamily 3 group A member 2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ESX1_HUMAN" ("ESX1L" "ESX1" "ESX1R")) 
(define-protein "ESYT1_HUMAN" ("FAM62A" "KIAA0747" "E-Syt1" "ESYT1" "MBC2")) 
<<<<<<< .mine
(define-protein "ETBR2_HUMAN" ("LP2" "Prosaposin receptor GPR37L1" "Endothelin B receptor-like protein 2" "ETBR-LP-2" "G-protein coupled receptor 37-like 1"))
=======
<<<<<<< .mine
(define-protein "ETBR2_HUMAN" ("LP2" "Prosaposin receptor GPR37L1" "Endothelin B receptor-like protein 2" "ETBR-LP-2" "G-protein coupled receptor 37-like 1"))
=======
(define-protein "ETBR2_HUMAN" ("Prosaposin receptor GPR37L1" "Endothelin B receptor-like protein 2" "ETBR-LP-2" "G-protein coupled receptor 37-like 1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ETHE1_HUMAN" ("HSCO" "ETHE1")) 
<<<<<<< .mine
(define-protein "ETS1_HUMAN" ("Ets1" "Protein C-ets-1" "p54"))
=======
<<<<<<< .mine
(define-protein "ETS1_HUMAN" ("Ets1" "Protein C-ets-1" "p54"))
=======
(define-protein "ETS1_HUMAN" ("Protein C-ets-1" "p54"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ETV4_HUMAN" ("ETS translocation variant 4" "Adenovirus E1A enhancer-binding protein" "E1A-F" "Polyomavirus enhancer activator 3 homolog" "Protein PEA3"))
<<<<<<< .mine
(define-protein "ETV4_HUMAN" ("PEA3" "ETS translocation variant 4" "Adenovirus E1A enhancer-binding protein" "E1A-F" "Polyomavirus enhancer activator 3 homolog" "Protein PEA3"))
(define-protein "ETV5_HUMAN" ("erm" "ETS translocation variant 5" "Ets-related protein ERM"))
(define-protein "EXC6B_HUMAN" ("Sec15B" "Exocyst complex component 6B" "Exocyst complex component Sec15B" "SEC15-like protein 2"))
=======
<<<<<<< .mine
(define-protein "ETV4_HUMAN" ("PEA3" "ETS translocation variant 4" "Adenovirus E1A enhancer-binding protein" "E1A-F" "Polyomavirus enhancer activator 3 homolog" "Protein PEA3"))
(define-protein "ETV5_HUMAN" ("erm" "ETS translocation variant 5" "Ets-related protein ERM"))
(define-protein "EXC6B_HUMAN" ("Sec15B" "Exocyst complex component 6B" "Exocyst complex component Sec15B" "SEC15-like protein 2"))
=======
(define-protein "ETV5_HUMAN" ("ETS translocation variant 5" "Ets-related protein ERM"))
(define-protein "EXC6B_HUMAN" ("Exocyst complex component 6B" "Exocyst complex component Sec15B" "SEC15-like protein 2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "EXOC1_HUMAN" ("SEC3L1" "EXOC1" "SEC3")) 
(define-protein "EXOC2_HUMAN" ("SEC5" "EXOC2" "SEC5L1")) 
(define-protein "EXOC3_HUMAN" ("SEC6L1" "SEC6" "EXOC3")) 
(define-protein "EXOC4_HUMAN" ("SEC8L1" "SEC8" "EXOC4" "KIAA1699")) 
(define-protein "EXOC5_HUMAN" ("SEC10" "SEC10L1" "EXOC5" "hSec10")) 
(define-protein "EXOC6_HUMAN" ("EXOC6" "SEC15A" "SEC15L1" "SEC15L")) 
(define-protein "EXOC7_HUMAN" ("EXOC7" "KIAA1067" "EXO70")) 
(define-protein "EXOC8_HUMAN" ("EXOC8")) 
<<<<<<< .mine
(define-protein "EXOS9_HUMAN" ("scl" "Exosome complex component RRP45" "Autoantigen PM/Scl 1" "Exosome component 9" "P75 polymyositis-scleroderma overlap syndrome-associated autoantigen" "Polymyositis/scleroderma autoantigen 1" "Polymyositis/scleroderma autoantigen 75 kDa" "PM/Scl-75"))
=======
<<<<<<< .mine
(define-protein "EXOS9_HUMAN" ("scl" "Exosome complex component RRP45" "Autoantigen PM/Scl 1" "Exosome component 9" "P75 polymyositis-scleroderma overlap syndrome-associated autoantigen" "Polymyositis/scleroderma autoantigen 1" "Polymyositis/scleroderma autoantigen 75 kDa" "PM/Scl-75"))
=======
(define-protein "EXOS9_HUMAN" ("Exosome complex component RRP45" "Autoantigen PM/Scl 1" "Exosome component 9" "P75 polymyositis-scleroderma overlap syndrome-associated autoantigen" "Polymyositis/scleroderma autoantigen 1" "Polymyositis/scleroderma autoantigen 75 kDa" "PM/Scl-75"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "EXPH5_HUMAN" ("EXPH5" "SlaC2-b" "SLAC2B" "KIAA0624")) 
(define-protein "EZRI_HUMAN" ("EZR" "Cytovillin" "p81" "VIL2" "Villin-2")) 
(define-protein "F126B_HUMAN" ("FAM126B")) 
<<<<<<< .mine
(define-protein "F13B_HUMAN" ("fibrin" "Coagulation factor XIII B chain" "Fibrin-stabilizing factor B subunit" "Protein-glutamine gamma-glutamyltransferase B chain" "Transglutaminase B chain"))
(define-protein "F5H9G3_HHV8" ("K11" "V-IRF-2 protein"))
=======
<<<<<<< .mine
(define-protein "F13B_HUMAN" ("fibrin" "Coagulation factor XIII B chain" "Fibrin-stabilizing factor B subunit" "Protein-glutamine gamma-glutamyltransferase B chain" "Transglutaminase B chain"))
(define-protein "F5H9G3_HHV8" ("K11" "V-IRF-2 protein"))
=======
(define-protein "F13B_HUMAN" ("Coagulation factor XIII B chain" "Fibrin-stabilizing factor B subunit" "Protein-glutamine gamma-glutamyltransferase B chain" "Transglutaminase B chain"))
(define-protein "F5H9G3_HHV8" ("K11" "V-IRF-2 protein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "FA21A_HUMAN" ("FAM21A")) 
<<<<<<< .mine
(define-protein "FA21C_HUMAN" ("cscs" "WASH complex subunit FAM21C" "Vaccinia virus penetration factor" "VPEF"))
=======
<<<<<<< .mine
(define-protein "FA21C_HUMAN" ("cscs" "WASH complex subunit FAM21C" "Vaccinia virus penetration factor" "VPEF"))
=======
(define-protein "FA21C_HUMAN" ("WASH complex subunit FAM21C" "Vaccinia virus penetration factor" "VPEF"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "FA71C_HUMAN" ("FAM71C")) 
<<<<<<< .mine
(define-protein "FABD_HUMAN" ("mcat" "Malonyl-CoA-acyl carrier protein transacylase, mitochondrial" "MCT" "Mitochondrial malonyl CoA:ACP acyltransferase" "Mitochondrial malonyltransferase" "[Acyl-carrier-protein] malonyltransferase"))
(define-protein "FACD2_HUMAN" ("aphidicolin" "Fanconi anemia group D2 protein" "Protein FACD2"))
=======
<<<<<<< .mine
(define-protein "FABD_HUMAN" ("mcat" "Malonyl-CoA-acyl carrier protein transacylase, mitochondrial" "MCT" "Mitochondrial malonyl CoA:ACP acyltransferase" "Mitochondrial malonyltransferase" "[Acyl-carrier-protein] malonyltransferase"))
(define-protein "FACD2_HUMAN" ("aphidicolin" "Fanconi anemia group D2 protein" "Protein FACD2"))
=======
(define-protein "FABD_HUMAN" ("Malonyl-CoA-acyl carrier protein transacylase, mitochondrial" "MCT" "Mitochondrial malonyl CoA:ACP acyltransferase" "Mitochondrial malonyltransferase" "[Acyl-carrier-protein] malonyltransferase"))
(define-protein "FACD2_HUMAN" ("Fanconi anemia group D2 protein" "Protein FACD2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "FACR2_HUMAN" ("FAR2" "MLSTD1")) 
<<<<<<< .mine
(define-protein "FADD_HUMAN" ("procaspase-8" "FAS-associated death domain protein" "FAS-associating death domain-containing protein" "Growth-inhibiting gene 3 protein" "Mediator of receptor induced toxicity" "Protein FADD"))
(define-protein "FAK1_HUMAN" ("FAK-" "Focal adhesion kinase 1" "FADK 1" "Focal adhesion kinase-related nonkinase" "FRNK" "Protein phosphatase 1 regulatory subunit 71" "PPP1R71" "Protein-tyrosine kinase 2" "p125FAK" "pp125FAK"))
(define-protein "FAK2_HUMAN" ("cakβ" "Protein-tyrosine kinase 2-beta" "Calcium-dependent tyrosine kinase" "CADTK" "Calcium-regulated non-receptor proline-rich tyrosine kinase" "Cell adhesion kinase beta" "CAK-beta" "CAKB" "Focal adhesion kinase 2" "FADK 2" "Proline-rich tyrosine kinase 2" "Related adhesion focal tyrosine kinase" "RAFTK"))
=======
<<<<<<< .mine
(define-protein "FADD_HUMAN" ("procaspase-8" "FAS-associated death domain protein" "FAS-associating death domain-containing protein" "Growth-inhibiting gene 3 protein" "Mediator of receptor induced toxicity" "Protein FADD"))
(define-protein "FAK1_HUMAN" ("FAK-" "Focal adhesion kinase 1" "FADK 1" "Focal adhesion kinase-related nonkinase" "FRNK" "Protein phosphatase 1 regulatory subunit 71" "PPP1R71" "Protein-tyrosine kinase 2" "p125FAK" "pp125FAK"))
(define-protein "FAK2_HUMAN" ("cakβ" "Protein-tyrosine kinase 2-beta" "Calcium-dependent tyrosine kinase" "CADTK" "Calcium-regulated non-receptor proline-rich tyrosine kinase" "Cell adhesion kinase beta" "CAK-beta" "CAKB" "Focal adhesion kinase 2" "FADK 2" "Proline-rich tyrosine kinase 2" "Related adhesion focal tyrosine kinase" "RAFTK"))
=======
(define-protein "FADD_HUMAN" ("FAS-associated death domain protein" "FAS-associating death domain-containing protein" "Growth-inhibiting gene 3 protein" "Mediator of receptor induced toxicity" "Protein FADD"))
(define-protein "FAK1_HUMAN" ("Focal adhesion kinase 1" "FADK 1" "Focal adhesion kinase-related nonkinase" "FRNK" "Protein phosphatase 1 regulatory subunit 71" "PPP1R71" "Protein-tyrosine kinase 2" "p125FAK" "pp125FAK"))
(define-protein "FAK2_HUMAN" ("Protein-tyrosine kinase 2-beta" "Calcium-dependent tyrosine kinase" "CADTK" "Calcium-regulated non-receptor proline-rich tyrosine kinase" "Cell adhesion kinase beta" "CAK-beta" "CAKB" "Focal adhesion kinase 2" "FADK 2" "Proline-rich tyrosine kinase 2" "Related adhesion focal tyrosine kinase" "RAFTK"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "FAN1_HUMAN" ("Fanconi-associated nuclease 1" "FANCD2/FANCI-associated nuclease 1" "hFAN1" "Myotubularin-related protein 15"))
<<<<<<< .mine
(define-protein "FAN1_HUMAN" ("replication/repair" "Fanconi-associated nuclease 1" "FANCD2/FANCI-associated nuclease 1" "hFAN1" "Myotubularin-related protein 15"))
(define-protein "FANCF_HUMAN" ("fancf" "Fanconi anemia group F protein" "Protein FACF"))
=======
<<<<<<< .mine
(define-protein "FAN1_HUMAN" ("replication/repair" "Fanconi-associated nuclease 1" "FANCD2/FANCI-associated nuclease 1" "hFAN1" "Myotubularin-related protein 15"))
(define-protein "FANCF_HUMAN" ("fancf" "Fanconi anemia group F protein" "Protein FACF"))
=======
(define-protein "FANCF_HUMAN" ("Fanconi anemia group F protein" "Protein FACF"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "FANCI_HUMAN" ("KIAA1794" "FANCI")) 
<<<<<<< .mine
(define-protein "FAS_HUMAN" ("fasn" "Fatty acid synthase"))
(define-protein "FBLN4_HUMAN" ("Tyr-267" "EGF-containing fibulin-like extracellular matrix protein 2" "Fibulin-4" "FIBL-4" "Protein UPH1"))
(define-protein "FBLN5_HUMAN" ("emphysema" "Fibulin-5" "FIBL-5" "Developmental arteries and neural crest EGF-like protein" "Dance" "Urine p50 protein" "UP50"))
(define-protein "FBN1_HUMAN" ("fbn" "Fibrillin-1"))
=======
<<<<<<< .mine
(define-protein "FAS_HUMAN" ("fasn" "Fatty acid synthase"))
(define-protein "FBLN4_HUMAN" ("Tyr-267" "EGF-containing fibulin-like extracellular matrix protein 2" "Fibulin-4" "FIBL-4" "Protein UPH1"))
(define-protein "FBLN5_HUMAN" ("emphysema" "Fibulin-5" "FIBL-5" "Developmental arteries and neural crest EGF-like protein" "Dance" "Urine p50 protein" "UP50"))
(define-protein "FBN1_HUMAN" ("fbn" "Fibrillin-1"))
=======
(define-protein "FAS_HUMAN" ("Fatty acid synthase"))
(define-protein "FBLN4_HUMAN" ("EGF-containing fibulin-like extracellular matrix protein 2" "Fibulin-4" "FIBL-4" "Protein UPH1"))
(define-protein "FBLN5_HUMAN" ("Fibulin-5" "FIBL-5" "Developmental arteries and neural crest EGF-like protein" "Dance" "Urine p50 protein" "UP50"))
(define-protein "FBN1_HUMAN" ("Fibrillin-1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "FBP1L_HUMAN" ("C1orf39" "FNBP1L" "Toca-1" "TOCA1")) 
(define-protein "FBW1A_HUMAN" ("BTRCP" "BTRC" "FBW1A" "FBXW1A" "E3RSIkappaB")) 
<<<<<<< .mine
(define-protein "FBW1B_HUMAN" ("βtrcp" "F-box/WD repeat-containing protein 11" "F-box and WD repeats protein beta-TrCP2" "F-box/WD repeat-containing protein 1B" "Homologous to Slimb protein" "HOS"))
(define-protein "FBX42_HUMAN" ("jfk" "F-box only protein 42" "Just one F-box and Kelch domain-containing protein"))
=======
<<<<<<< .mine
(define-protein "FBW1B_HUMAN" ("βtrcp" "F-box/WD repeat-containing protein 11" "F-box and WD repeats protein beta-TrCP2" "F-box/WD repeat-containing protein 1B" "Homologous to Slimb protein" "HOS"))
(define-protein "FBX42_HUMAN" ("jfk" "F-box only protein 42" "Just one F-box and Kelch domain-containing protein"))
=======
(define-protein "FBW1B_HUMAN" ("F-box/WD repeat-containing protein 11" "F-box and WD repeats protein beta-TrCP2" "F-box/WD repeat-containing protein 1B" "Homologous to Slimb protein" "HOS"))
(define-protein "FBX42_HUMAN" ("F-box only protein 42" "Just one F-box and Kelch domain-containing protein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "FBXW7_HUMAN" ("F-box/WD repeat-containing protein 7" "Archipelago homolog" "hAgo" "F-box and WD-40 domain-containing protein 7" "F-box protein FBX30" "SEL-10" "hCdc4"))
(define-protein "FBXW8_HUMAN" ("F-box/WD repeat-containing protein 8" "F-box and WD-40 domain-containing protein 8" "F-box only protein 29"))
<<<<<<< .mine
(define-protein "FBXW8_HUMAN" ("Fbxw8" "F-box/WD repeat-containing protein 8" "F-box and WD-40 domain-containing protein 8" "F-box only protein 29"))
(define-protein "FCER2_HUMAN" ("sCD23" "Low affinity immunoglobulin epsilon Fc receptor" "BLAST-2" "C-type lectin domain family 4 member J" "Fc-epsilon-RII" "Immunoglobulin E-binding factor" "Lymphocyte IgE receptor"))
(define-protein "FCERG_HUMAN" ("FcRγ-" "High affinity immunoglobulin epsilon receptor subunit gamma" "Fc receptor gamma-chain" "FcRgamma" "Fc-epsilon RI-gamma" "IgE Fc receptor subunit gamma" "FceRI gamma"))
(define-protein "FCG2B_HUMAN" ("fcγrii" "Low affinity immunoglobulin gamma Fc region receptor II-b" "IgG Fc receptor II-b" "CDw32" "Fc-gamma RII-b" "Fc-gamma-RIIb" "FcRII-b"))
(define-protein "FCG3A_HUMAN" ("fcγriiia" "Low affinity immunoglobulin gamma Fc region receptor III-A" "CD16a antigen" "Fc-gamma RIII-alpha" "Fc-gamma RIII" "Fc-gamma RIIIa" "FcRIII" "FcRIIIa" "FcR-10" "IgG Fc receptor III-2"))
(define-protein "FCGRN_HUMAN" ("igg" "IgG receptor FcRn large subunit p51" "FcRn" "IgG Fc fragment receptor transporter alpha chain" "Neonatal Fc receptor"))
=======
<<<<<<< .mine
(define-protein "FBXW8_HUMAN" ("Fbxw8" "F-box/WD repeat-containing protein 8" "F-box and WD-40 domain-containing protein 8" "F-box only protein 29"))
(define-protein "FCER2_HUMAN" ("sCD23" "Low affinity immunoglobulin epsilon Fc receptor" "BLAST-2" "C-type lectin domain family 4 member J" "Fc-epsilon-RII" "Immunoglobulin E-binding factor" "Lymphocyte IgE receptor"))
(define-protein "FCERG_HUMAN" ("FcRγ-" "High affinity immunoglobulin epsilon receptor subunit gamma" "Fc receptor gamma-chain" "FcRgamma" "Fc-epsilon RI-gamma" "IgE Fc receptor subunit gamma" "FceRI gamma"))
(define-protein "FCG2B_HUMAN" ("fcγrii" "Low affinity immunoglobulin gamma Fc region receptor II-b" "IgG Fc receptor II-b" "CDw32" "Fc-gamma RII-b" "Fc-gamma-RIIb" "FcRII-b"))
(define-protein "FCG3A_HUMAN" ("fcγriiia" "Low affinity immunoglobulin gamma Fc region receptor III-A" "CD16a antigen" "Fc-gamma RIII-alpha" "Fc-gamma RIII" "Fc-gamma RIIIa" "FcRIII" "FcRIIIa" "FcR-10" "IgG Fc receptor III-2"))
(define-protein "FCGRN_HUMAN" ("igg" "IgG receptor FcRn large subunit p51" "FcRn" "IgG Fc fragment receptor transporter alpha chain" "Neonatal Fc receptor"))
=======
(define-protein "FCER2_HUMAN" ("Low affinity immunoglobulin epsilon Fc receptor" "BLAST-2" "C-type lectin domain family 4 member J" "Fc-epsilon-RII" "Immunoglobulin E-binding factor" "Lymphocyte IgE receptor"))
(define-protein "FCERG_HUMAN" ("High affinity immunoglobulin epsilon receptor subunit gamma" "Fc receptor gamma-chain" "FcRgamma" "Fc-epsilon RI-gamma" "IgE Fc receptor subunit gamma" "FceRI gamma"))
(define-protein "FCG2B_HUMAN" ("Low affinity immunoglobulin gamma Fc region receptor II-b" "IgG Fc receptor II-b" "CDw32" "Fc-gamma RII-b" "Fc-gamma-RIIb" "FcRII-b"))
(define-protein "FCG3A_HUMAN" ("Low affinity immunoglobulin gamma Fc region receptor III-A" "CD16a antigen" "Fc-gamma RIII-alpha" "Fc-gamma RIII" "Fc-gamma RIIIa" "FcRIII" "FcRIIIa" "FcR-10" "IgG Fc receptor III-2"))
(define-protein "FCGRN_HUMAN" ("IgG receptor FcRn large subunit p51" "FcRn" "IgG Fc fragment receptor transporter alpha chain" "Neonatal Fc receptor"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "FCHO2_HUMAN" ("FCHO2")) 
<<<<<<< .mine
(define-protein "FCN3_HUMAN" ("zymosan" "Ficolin-3" "Collagen/fibrinogen domain-containing lectin 3 p35" "Collagen/fibrinogen domain-containing protein 3" "Hakata antigen"))
(define-protein "FCRL3_HUMAN" ("itams" "Fc receptor-like protein 3" "FcR-like protein 3" "FcRL3" "Fc receptor homolog 3" "FcRH3" "IFGP family protein 3" "hIFGP3" "Immune receptor translocation-associated protein 3" "SH2 domain-containing phosphatase anchor protein 2"))
=======
<<<<<<< .mine
(define-protein "FCN3_HUMAN" ("zymosan" "Ficolin-3" "Collagen/fibrinogen domain-containing lectin 3 p35" "Collagen/fibrinogen domain-containing protein 3" "Hakata antigen"))
(define-protein "FCRL3_HUMAN" ("itams" "Fc receptor-like protein 3" "FcR-like protein 3" "FcRL3" "Fc receptor homolog 3" "FcRH3" "IFGP family protein 3" "hIFGP3" "Immune receptor translocation-associated protein 3" "SH2 domain-containing phosphatase anchor protein 2"))
=======
(define-protein "FCN3_HUMAN" ("Ficolin-3" "Collagen/fibrinogen domain-containing lectin 3 p35" "Collagen/fibrinogen domain-containing protein 3" "Hakata antigen"))
(define-protein "FCRL3_HUMAN" ("Fc receptor-like protein 3" "FcR-like protein 3" "FcRL3" "Fc receptor homolog 3" "FcRH3" "IFGP family protein 3" "hIFGP3" "Immune receptor translocation-associated protein 3" "SH2 domain-containing phosphatase anchor protein 2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "FDFT_HUMAN" ("FDFT1" "SQS" "SS")) 
(define-protein "FERM1_HUMAN" ("Kindlin-1" "C20orf42" "FERMT1" "Kindlerin" "KIND1" "URP1")) 
<<<<<<< .mine
(define-protein "FGD4_HUMAN" ("frabin" "FYVE, RhoGEF and PH domain-containing protein 4" "Actin filament-binding protein frabin" "FGD1-related F-actin-binding protein" "Zinc finger FYVE domain-containing protein 6"))
=======
<<<<<<< .mine
(define-protein "FGD4_HUMAN" ("frabin" "FYVE, RhoGEF and PH domain-containing protein 4" "Actin filament-binding protein frabin" "FGD1-related F-actin-binding protein" "Zinc finger FYVE domain-containing protein 6"))
=======
(define-protein "FGD4_HUMAN" ("FYVE, RhoGEF and PH domain-containing protein 4" "Actin filament-binding protein frabin" "FGD1-related F-actin-binding protein" "Zinc finger FYVE domain-containing protein 6"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "FGF12_HUMAN" ("FGF12B" "FGF12" "FGF-12" "FHF-1" "FHF1")) 
<<<<<<< .mine
(define-protein "FGF19_HUMAN" ("fgfs" "Fibroblast growth factor 19" "FGF-19"))
(define-protein "FGFR4_HUMAN" ("Src/Shc" "Fibroblast growth factor receptor 4" "FGFR-4"))
(define-protein "FGR_HUMAN" ("neutrophils" "Tyrosine-protein kinase Fgr" "Gardner-Rasheed feline sarcoma viral (v-fgr) oncogene homolog" "Proto-oncogene c-Fgr" "p55-Fgr" "p58-Fgr" "p58c-Fgr"))
=======
<<<<<<< .mine
(define-protein "FGF19_HUMAN" ("fgfs" "Fibroblast growth factor 19" "FGF-19"))
(define-protein "FGFR4_HUMAN" ("Src/Shc" "Fibroblast growth factor receptor 4" "FGFR-4"))
(define-protein "FGR_HUMAN" ("neutrophils" "Tyrosine-protein kinase Fgr" "Gardner-Rasheed feline sarcoma viral (v-fgr) oncogene homolog" "Proto-oncogene c-Fgr" "p55-Fgr" "p58-Fgr" "p58c-Fgr"))
=======
(define-protein "FGF19_HUMAN" ("Fibroblast growth factor 19" "FGF-19"))
(define-protein "FGFR4_HUMAN" ("Fibroblast growth factor receptor 4" "FGFR-4"))
(define-protein "FGR_HUMAN" ("Tyrosine-protein kinase Fgr" "Gardner-Rasheed feline sarcoma viral (v-fgr) oncogene homolog" "Proto-oncogene c-Fgr" "p55-Fgr" "p58-Fgr" "p58c-Fgr"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "FHOD1_HUMAN" ("FHOS1" "FHOS" "FHOD1")) 
<<<<<<< .mine
(define-protein "FIBB_HUMAN" ("fgb" "Fibrinogen beta chain"))
(define-protein "FIBG_HUMAN" ("Coll-I" "Fibrinogen gamma chain"))
=======
<<<<<<< .mine
(define-protein "FIBB_HUMAN" ("fgb" "Fibrinogen beta chain"))
(define-protein "FIBG_HUMAN" ("Coll-I" "Fibrinogen gamma chain"))
=======
(define-protein "FIBB_HUMAN" ("Fibrinogen beta chain"))
(define-protein "FIBG_HUMAN" ("Fibrinogen gamma chain"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "FIG4_HUMAN" ("KIAA0274" "FIG4" "SAC3")) 
<<<<<<< .mine
(define-protein "FINC_HUMAN" ("fibronectins" "Fibronectin" "FN" "Cold-insoluble globulin" "CIG"))
=======
<<<<<<< .mine
(define-protein "FINC_HUMAN" ("fibronectins" "Fibronectin" "FN" "Cold-insoluble globulin" "CIG"))
=======
(define-protein "FINC_HUMAN" ("Fibronectin" "FN" "Cold-insoluble globulin" "CIG"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "FKB1B_HUMAN" ("FKBP1B" "FKBP12.6" "FKBP1L" "FKBP9" "OTK4")) 
<<<<<<< .mine
(define-protein "FKBP4_HUMAN" ("FKBP52" "Peptidyl-prolyl cis-trans isomerase FKBP4" "PPIase FKBP4" "51 kDa FK506-binding protein" "FKBP51" "52 kDa FK506-binding protein" "52 kDa FKBP" "FKBP-52" "59 kDa immunophilin" "p59" "FK506-binding protein 4" "FKBP-4" "FKBP59" "HSP-binding immunophilin" "HBI" "Immunophilin FKBP52" "Rotamase"))
(define-protein "FKBP5_HUMAN" ("Fkbp5" "Peptidyl-prolyl cis-trans isomerase FKBP5" "PPIase FKBP5" "51 kDa FK506-binding protein" "51 kDa FKBP" "FKBP-51" "54 kDa progesterone receptor-associated immunophilin" "Androgen-regulated protein 6" "FF1 antigen" "FK506-binding protein 5" "FKBP-5" "FKBP54" "p54" "HSP90-binding immunophilin" "Rotamase"))
(define-protein "FKBPL_HUMAN" ("Waf1/Cip1" "FK506-binding protein-like" "WAF-1/CIP1 stabilizing protein 39" "WISp39"))
=======
<<<<<<< .mine
(define-protein "FKBP4_HUMAN" ("FKBP52" "Peptidyl-prolyl cis-trans isomerase FKBP4" "PPIase FKBP4" "51 kDa FK506-binding protein" "FKBP51" "52 kDa FK506-binding protein" "52 kDa FKBP" "FKBP-52" "59 kDa immunophilin" "p59" "FK506-binding protein 4" "FKBP-4" "FKBP59" "HSP-binding immunophilin" "HBI" "Immunophilin FKBP52" "Rotamase"))
(define-protein "FKBP5_HUMAN" ("Fkbp5" "Peptidyl-prolyl cis-trans isomerase FKBP5" "PPIase FKBP5" "51 kDa FK506-binding protein" "51 kDa FKBP" "FKBP-51" "54 kDa progesterone receptor-associated immunophilin" "Androgen-regulated protein 6" "FF1 antigen" "FK506-binding protein 5" "FKBP-5" "FKBP54" "p54" "HSP90-binding immunophilin" "Rotamase"))
(define-protein "FKBPL_HUMAN" ("Waf1/Cip1" "FK506-binding protein-like" "WAF-1/CIP1 stabilizing protein 39" "WISp39"))
=======
(define-protein "FKBP4_HUMAN" ("Peptidyl-prolyl cis-trans isomerase FKBP4" "PPIase FKBP4" "51 kDa FK506-binding protein" "FKBP51" "52 kDa FK506-binding protein" "52 kDa FKBP" "FKBP-52" "59 kDa immunophilin" "p59" "FK506-binding protein 4" "FKBP-4" "FKBP59" "HSP-binding immunophilin" "HBI" "Immunophilin FKBP52" "Rotamase"))
(define-protein "FKBP5_HUMAN" ("Peptidyl-prolyl cis-trans isomerase FKBP5" "PPIase FKBP5" "51 kDa FK506-binding protein" "51 kDa FKBP" "FKBP-51" "54 kDa progesterone receptor-associated immunophilin" "Androgen-regulated protein 6" "FF1 antigen" "FK506-binding protein 5" "FKBP-5" "FKBP54" "p54" "HSP90-binding immunophilin" "Rotamase"))
(define-protein "FKBPL_HUMAN" ("FK506-binding protein-like" "WAF-1/CIP1 stabilizing protein 39" "WISp39"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "FLII_HUMAN" ("FLIL" "FLII")) 
(define-protein "FLNB_HUMAN" ("Fh1" "TABP" "FLN3" "Beta-filamin" "FLN-B" "FLNB" "FLN1L" "TAP" "Filamin-3" "ABP-278")) 
(define-protein "FLNC_HUMAN" ("FLN2" "FLN-C" "FLNC" "ABPL" "ABP-L" "FLNc" "Filamin-2" "Gamma-filamin")) 
(define-protein "FLOT1_HUMAN" ("FLOT1")) 
<<<<<<< .mine
(define-protein "FLOT2_HUMAN" ("esa" "Flotillin-2" "Epidermal surface antigen" "ESA" "Membrane component chromosome 17 surface marker 1"))
(define-protein "FMOD_HUMAN" ("fm" "Fibromodulin" "FM" "Collagen-binding 59 kDa protein" "Keratan sulfate proteoglycan fibromodulin" "KSPG fibromodulin"))
=======
<<<<<<< .mine
(define-protein "FLOT2_HUMAN" ("esa" "Flotillin-2" "Epidermal surface antigen" "ESA" "Membrane component chromosome 17 surface marker 1"))
(define-protein "FMOD_HUMAN" ("fm" "Fibromodulin" "FM" "Collagen-binding 59 kDa protein" "Keratan sulfate proteoglycan fibromodulin" "KSPG fibromodulin"))
=======
(define-protein "FLOT2_HUMAN" ("Flotillin-2" "Epidermal surface antigen" "ESA" "Membrane component chromosome 17 surface marker 1"))
(define-protein "FMOD_HUMAN" ("Fibromodulin" "FM" "Collagen-binding 59 kDa protein" "Keratan sulfate proteoglycan fibromodulin" "KSPG fibromodulin"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "FNTA_HUMAN" ("GGTase-I-alpha" "FTase-alpha" "FNTA")) 
(define-protein "FNTB_HUMAN" ("FNTB" "FTase-beta")) 
<<<<<<< .mine
(define-protein "FOSL1_HUMAN" ("Fra-1" "Fos-related antigen 1" "FRA-1"))
=======
<<<<<<< .mine
(define-protein "FOSL1_HUMAN" ("Fra-1" "Fos-related antigen 1" "FRA-1"))
=======
(define-protein "FOSL1_HUMAN" ("Fos-related antigen 1" "FRA-1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "FOS_HUMAN" ("FOS" "G0S7")) 
<<<<<<< .mine
(define-protein "FOXA1_HUMAN" ("Foxa1" "Hepatocyte nuclear factor 3-alpha" "HNF-3-alpha" "HNF-3A" "Forkhead box protein A1" "Transcription factor 3A" "TCF-3A"))
=======
<<<<<<< .mine
(define-protein "FOXA1_HUMAN" ("Foxa1" "Hepatocyte nuclear factor 3-alpha" "HNF-3-alpha" "HNF-3A" "Forkhead box protein A1" "Transcription factor 3A" "TCF-3A"))
=======
(define-protein "FOXA1_HUMAN" ("Hepatocyte nuclear factor 3-alpha" "HNF-3-alpha" "HNF-3A" "Forkhead box protein A1" "Transcription factor 3A" "TCF-3A"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "FOXF2_HUMAN" ("Forkhead box protein F2" "Forkhead-related activator 2" "FREAC-2" "Forkhead-related protein FKHL6" "Forkhead-related transcription factor 2"))
(define-protein "FOXM1_HUMAN" ("Forkhead box protein M1" "Forkhead-related protein FKHL16" "Hepatocyte nuclear factor 3 forkhead homolog 11" "HFH-11" "HNF-3/fork-head homolog 11" "M-phase phosphoprotein 2" "MPM-2 reactive phosphoprotein 2" "Transcription factor Trident" "Winged-helix factor from INS-1 cells"))
(define-protein "FOXO1_HUMAN" ("Forkhead box protein O1" "Forkhead box protein O1A" "Forkhead in rhabdomyosarcoma"))
<<<<<<< .mine
(define-protein "FOXO1_HUMAN" ("fkhr" "Forkhead box protein O1" "Forkhead box protein O1A" "Forkhead in rhabdomyosarcoma"))
(define-protein "FOXO3_HUMAN" ("FOXO3a" "Forkhead box protein O3" "AF6q21 protein" "Forkhead in rhabdomyosarcoma-like 1"))
(define-protein "FOXO4_HUMAN" ("afx" "Forkhead box protein O4" "Fork head domain transcription factor AFX1"))
(define-protein "FPPS_HUMAN" ("fdps" "Farnesyl pyrophosphate synthase" "FPP synthase" "FPS" "(2E,6E)-farnesyl diphosphate synthase" "Dimethylallyltranstransferase" "Farnesyl diphosphate synthase" "Geranyltranstransferase"))
(define-protein "FPR2_HUMAN" ("lxa" "N-formyl peptide receptor 2" "FMLP-related receptor I" "FMLP-R-I" "Formyl peptide receptor-like 1" "HM63" "Lipoxin A4 receptor" "LXA4 receptor" "RFP"))
(define-protein "FRG1_HUMAN" ("frg" "Protein FRG1" "FSHD region gene 1 protein"))
(define-protein "FRK_HUMAN" ("frk" "Tyrosine-protein kinase FRK" "FYN-related kinase" "Nuclear tyrosine protein kinase RAK" "Protein-tyrosine kinase 5"))
=======
<<<<<<< .mine
(define-protein "FOXO1_HUMAN" ("fkhr" "Forkhead box protein O1" "Forkhead box protein O1A" "Forkhead in rhabdomyosarcoma"))
(define-protein "FOXO3_HUMAN" ("FOXO3a" "Forkhead box protein O3" "AF6q21 protein" "Forkhead in rhabdomyosarcoma-like 1"))
(define-protein "FOXO4_HUMAN" ("afx" "Forkhead box protein O4" "Fork head domain transcription factor AFX1"))
(define-protein "FPPS_HUMAN" ("fdps" "Farnesyl pyrophosphate synthase" "FPP synthase" "FPS" "(2E,6E)-farnesyl diphosphate synthase" "Dimethylallyltranstransferase" "Farnesyl diphosphate synthase" "Geranyltranstransferase"))
(define-protein "FPR2_HUMAN" ("lxa" "N-formyl peptide receptor 2" "FMLP-related receptor I" "FMLP-R-I" "Formyl peptide receptor-like 1" "HM63" "Lipoxin A4 receptor" "LXA4 receptor" "RFP"))
(define-protein "FRG1_HUMAN" ("frg" "Protein FRG1" "FSHD region gene 1 protein"))
(define-protein "FRK_HUMAN" ("frk" "Tyrosine-protein kinase FRK" "FYN-related kinase" "Nuclear tyrosine protein kinase RAK" "Protein-tyrosine kinase 5"))
=======
(define-protein "FOXO3_HUMAN" ("Forkhead box protein O3" "AF6q21 protein" "Forkhead in rhabdomyosarcoma-like 1"))
(define-protein "FOXO4_HUMAN" ("Forkhead box protein O4" "Fork head domain transcription factor AFX1"))
(define-protein "FPPS_HUMAN" ("Farnesyl pyrophosphate synthase" "FPP synthase" "FPS" "(2E,6E)-farnesyl diphosphate synthase" "Dimethylallyltranstransferase" "Farnesyl diphosphate synthase" "Geranyltranstransferase"))
(define-protein "FPR2_HUMAN" ("N-formyl peptide receptor 2" "FMLP-related receptor I" "FMLP-R-I" "Formyl peptide receptor-like 1" "HM63" "Lipoxin A4 receptor" "LXA4 receptor" "RFP"))
(define-protein "FRG1_HUMAN" ("Protein FRG1" "FSHD region gene 1 protein"))
(define-protein "FRK_HUMAN" ("Tyrosine-protein kinase FRK" "FYN-related kinase" "Nuclear tyrosine protein kinase RAK" "Protein-tyrosine kinase 5"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "FRPD3_HUMAN" ("KIAA1817" "FRMPD3")) 
(define-protein "FSCN1_HUMAN" ("Fascin" "55 kDa actin-bundling protein" "Singed-like protein" "p55"))
<<<<<<< .mine
(define-protein "FSCN1_HUMAN" ("fimbrin" "Fascin" "55 kDa actin-bundling protein" "Singed-like protein" "p55"))
(define-protein "FSHB_HUMAN" ("gonadotropins" "Follitropin subunit beta" "Follicle-stimulating hormone beta subunit" "FSH-B" "FSH-beta" "Follitropin beta chain"))
(define-protein "FUBP2_HUMAN" ("ksrp" "Far upstream element-binding protein 2" "FUSE-binding protein 2" "KH type-splicing regulatory protein" "KSRP" "p75"))
(define-protein "FURIN_HUMAN" ("furin" "Furin" "Dibasic-processing enzyme" "Paired basic amino acid residue-cleaving enzyme" "PACE"))
(define-protein "FUT3_HUMAN" ("le" "Galactoside 3(4)-L-fucosyltransferase" "Blood group Lewis alpha-4-fucosyltransferase" "Lewis FT" "Fucosyltransferase 3" "Fucosyltransferase III" "FucT-III"))
(define-protein "FUT4_HUMAN" ("transfectants" "Alpha-(1,3)-fucosyltransferase 4" "ELAM-1 ligand fucosyltransferase" "Fucosyltransferase 4" "Fucosyltransferase IV" "Fuc-TIV" "FucT-IV" "Galactoside 3-L-fucosyltransferase"))
(define-protein "FYN_HUMAN" ("PAG/Cbp" "Tyrosine-protein kinase Fyn" "Proto-oncogene Syn" "Proto-oncogene c-Fyn" "Src-like kinase" "SLK" "p59-Fyn"))
(define-protein "FZD1_HUMAN" ("Fzd1" "Frizzled-1" "Fz-1" "hFz1" "FzE1"))
(define-protein "FZD4_HUMAN" ("vasculature" "Frizzled-4" "Fz-4" "hFz4" "FzE4"))
(define-protein "FZD5_HUMAN" ("Fzd5" "Frizzled-5" "Fz-5" "hFz5" "FzE5"))
(define-protein "G0S2_HUMAN" ("G0" "G0/G1 switch protein 2" "G0/G1 switch regulatory protein 2" "Putative lymphocyte G0/G1 switch gene"))
(define-protein "G2E3_HUMAN" ("G2/M" "G2/M phase-specific E3 ubiquitin-protein ligase"))
=======
<<<<<<< .mine
(define-protein "FSCN1_HUMAN" ("fimbrin" "Fascin" "55 kDa actin-bundling protein" "Singed-like protein" "p55"))
(define-protein "FSHB_HUMAN" ("gonadotropins" "Follitropin subunit beta" "Follicle-stimulating hormone beta subunit" "FSH-B" "FSH-beta" "Follitropin beta chain"))
(define-protein "FUBP2_HUMAN" ("ksrp" "Far upstream element-binding protein 2" "FUSE-binding protein 2" "KH type-splicing regulatory protein" "KSRP" "p75"))
(define-protein "FURIN_HUMAN" ("furin" "Furin" "Dibasic-processing enzyme" "Paired basic amino acid residue-cleaving enzyme" "PACE"))
(define-protein "FUT3_HUMAN" ("le" "Galactoside 3(4)-L-fucosyltransferase" "Blood group Lewis alpha-4-fucosyltransferase" "Lewis FT" "Fucosyltransferase 3" "Fucosyltransferase III" "FucT-III"))
(define-protein "FUT4_HUMAN" ("transfectants" "Alpha-(1,3)-fucosyltransferase 4" "ELAM-1 ligand fucosyltransferase" "Fucosyltransferase 4" "Fucosyltransferase IV" "Fuc-TIV" "FucT-IV" "Galactoside 3-L-fucosyltransferase"))
(define-protein "FYN_HUMAN" ("PAG/Cbp" "Tyrosine-protein kinase Fyn" "Proto-oncogene Syn" "Proto-oncogene c-Fyn" "Src-like kinase" "SLK" "p59-Fyn"))
(define-protein "FZD1_HUMAN" ("Fzd1" "Frizzled-1" "Fz-1" "hFz1" "FzE1"))
(define-protein "FZD4_HUMAN" ("vasculature" "Frizzled-4" "Fz-4" "hFz4" "FzE4"))
(define-protein "FZD5_HUMAN" ("Fzd5" "Frizzled-5" "Fz-5" "hFz5" "FzE5"))
(define-protein "G0S2_HUMAN" ("G0" "G0/G1 switch protein 2" "G0/G1 switch regulatory protein 2" "Putative lymphocyte G0/G1 switch gene"))
(define-protein "G2E3_HUMAN" ("G2/M" "G2/M phase-specific E3 ubiquitin-protein ligase"))
=======
(define-protein "FSHB_HUMAN" ("Follitropin subunit beta" "Follicle-stimulating hormone beta subunit" "FSH-B" "FSH-beta" "Follitropin beta chain"))
(define-protein "FUBP2_HUMAN" ("Far upstream element-binding protein 2" "FUSE-binding protein 2" "KH type-splicing regulatory protein" "KSRP" "p75"))
(define-protein "FURIN_HUMAN" ("Furin" "Dibasic-processing enzyme" "Paired basic amino acid residue-cleaving enzyme" "PACE"))
(define-protein "FUT3_HUMAN" ("Galactoside 3(4)-L-fucosyltransferase" "Blood group Lewis alpha-4-fucosyltransferase" "Lewis FT" "Fucosyltransferase 3" "Fucosyltransferase III" "FucT-III"))
(define-protein "FUT4_HUMAN" ("Alpha-(1,3)-fucosyltransferase 4" "ELAM-1 ligand fucosyltransferase" "Fucosyltransferase 4" "Fucosyltransferase IV" "Fuc-TIV" "FucT-IV" "Galactoside 3-L-fucosyltransferase"))
(define-protein "FYN_HUMAN" ("Tyrosine-protein kinase Fyn" "Proto-oncogene Syn" "Proto-oncogene c-Fyn" "Src-like kinase" "SLK" "p59-Fyn"))
(define-protein "FZD1_HUMAN" ("Frizzled-1" "Fz-1" "hFz1" "FzE1"))
(define-protein "FZD4_HUMAN" ("Frizzled-4" "Fz-4" "hFz4" "FzE4"))
(define-protein "FZD5_HUMAN" ("Frizzled-5" "Fz-5" "hFz5" "FzE5"))
(define-protein "G0S2_HUMAN" ("G0/G1 switch protein 2" "G0/G1 switch regulatory protein 2" "Putative lymphocyte G0/G1 switch gene"))
(define-protein "G2E3_HUMAN" ("G2/M phase-specific E3 ubiquitin-protein ligase"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "G3BP1_HUMAN" ("G3BP-1" "G3BP" "G3BP1")) 
<<<<<<< .mine
(define-protein "G3FA30_9HIV1" ("K56" "Pol protein"))
(define-protein "G3FA67_9HIV1" ("K33" "Pol protein"))
(define-protein "G3GCR0_9HIV1" ("S130" "Pol protein"))
(define-protein "G3GCV8_9HIV1" ("S178" "Pol protein"))
(define-protein "G3LTJ9_9PAPI" ("lscs" "Major capsid protein L1"))
=======
<<<<<<< .mine
(define-protein "G3FA30_9HIV1" ("K56" "Pol protein"))
(define-protein "G3FA67_9HIV1" ("K33" "Pol protein"))
(define-protein "G3GCR0_9HIV1" ("S130" "Pol protein"))
(define-protein "G3GCV8_9HIV1" ("S178" "Pol protein"))
(define-protein "G3LTJ9_9PAPI" ("lscs" "Major capsid protein L1"))
=======
(define-protein "G3FA30_9HIV1" ("Pol protein"))
(define-protein "G3FA67_9HIV1" ("Pol protein"))
(define-protein "G3GCR0_9HIV1" ("Pol protein"))
(define-protein "G3GCV8_9HIV1" ("Pol protein"))
(define-protein "G3LTJ9_9PAPI" ("Major capsid protein L1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "G3P_HUMAN" ("GAPDH" "GAPD")) 
(define-protein "G3XAG3_HUMAN" ("Cyclin-dependent kinase inhibitor 2A" "Cyclin-dependent kinase inhibitor 2A (Melanoma, p16, inhibits CDK4), isoform CRA_a"))
(define-protein "G45IP_HUMAN" ("PRG6" "MRP-L59" "MRPL59" "PLINP-1" "CRIF1" "PLINP1" "GADD45GIP1" "PLINP")) 
(define-protein "G6PD_HUMAN" ("G6PD")) 
<<<<<<< .mine
(define-protein "G6PE_HUMAN" ("gdh" "GDH/6PGL endoplasmic bifunctional protein"))
(define-protein "GA45A_HUMAN" ("Gadd45a" "Growth arrest and DNA damage-inducible protein GADD45 alpha" "DNA damage-inducible transcript 1 protein" "DDIT-1"))
(define-protein "GAB2_HUMAN" ("Gab-2" "GRB2-associated-binding protein 2" "GRB2-associated binder 2" "Growth factor receptor bound protein 2-associated protein 2" "pp100"))
(define-protein "GABR1_HUMAN" ("G-proteins" "Gamma-aminobutyric acid type B receptor subunit 1" "GABA-B receptor 1" "GABA-B-R1" "GABA-BR1" "GABABR1" "Gb1"))
=======
<<<<<<< .mine
(define-protein "G6PE_HUMAN" ("gdh" "GDH/6PGL endoplasmic bifunctional protein"))
(define-protein "GA45A_HUMAN" ("Gadd45a" "Growth arrest and DNA damage-inducible protein GADD45 alpha" "DNA damage-inducible transcript 1 protein" "DDIT-1"))
(define-protein "GAB2_HUMAN" ("Gab-2" "GRB2-associated-binding protein 2" "GRB2-associated binder 2" "Growth factor receptor bound protein 2-associated protein 2" "pp100"))
(define-protein "GABR1_HUMAN" ("G-proteins" "Gamma-aminobutyric acid type B receptor subunit 1" "GABA-B receptor 1" "GABA-B-R1" "GABA-BR1" "GABABR1" "Gb1"))
=======
(define-protein "G6PE_HUMAN" ("GDH/6PGL endoplasmic bifunctional protein"))
(define-protein "GA45A_HUMAN" ("Growth arrest and DNA damage-inducible protein GADD45 alpha" "DNA damage-inducible transcript 1 protein" "DDIT-1"))
(define-protein "GAB2_HUMAN" ("GRB2-associated-binding protein 2" "GRB2-associated binder 2" "Growth factor receptor bound protein 2-associated protein 2" "pp100"))
(define-protein "GABR1_HUMAN" ("Gamma-aminobutyric acid type B receptor subunit 1" "GABA-B receptor 1" "GABA-B-R1" "GABA-BR1" "GABABR1" "Gb1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "GALC_HUMAN" ("GALC" "GALCERase" "Galactosylceramidase")) 
<<<<<<< .mine
(define-protein "GALT1_HUMAN" ("polypeptide" "Polypeptide N-acetylgalactosaminyltransferase 1" "Polypeptide GalNAc transferase 1" "GalNAc-T1" "pp-GaNTase 1" "Protein-UDP acetylgalactosaminyltransferase 1" "UDP-GalNAc:polypeptide N-acetylgalactosaminyltransferase 1"))
(define-protein "GAN_HUMAN" ("GAN-1" "Gigaxonin" "Kelch-like protein 16"))
=======
<<<<<<< .mine
(define-protein "GALT1_HUMAN" ("polypeptide" "Polypeptide N-acetylgalactosaminyltransferase 1" "Polypeptide GalNAc transferase 1" "GalNAc-T1" "pp-GaNTase 1" "Protein-UDP acetylgalactosaminyltransferase 1" "UDP-GalNAc:polypeptide N-acetylgalactosaminyltransferase 1"))
(define-protein "GAN_HUMAN" ("GAN-1" "Gigaxonin" "Kelch-like protein 16"))
=======
(define-protein "GALT1_HUMAN" ("Polypeptide N-acetylgalactosaminyltransferase 1" "Polypeptide GalNAc transferase 1" "GalNAc-T1" "pp-GaNTase 1" "Protein-UDP acetylgalactosaminyltransferase 1" "UDP-GalNAc:polypeptide N-acetylgalactosaminyltransferase 1"))
(define-protein "GAN_HUMAN" ("Gigaxonin" "Kelch-like protein 16"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "GAPD1_HUMAN" ("GAPEX5" "GAPex-5" "KIAA1521" "RAP6" "GAPVD1")) 
(define-protein "GAPR1_HUMAN" ("GAPR-1" "C9orf19" "GAPR1" "GLIPR2")) 
<<<<<<< .mine
(define-protein "GAS2_HUMAN" ("Gas2" "Growth arrest-specific protein 2" "GAS-2"))
(define-protein "GAS6_HUMAN" ("Gas6" "Growth arrest-specific protein 6" "GAS-6" "AXL receptor tyrosine kinase ligand"))
(define-protein "GATA2_HUMAN" ("GATA-2" "Endothelial transcription factor GATA-2" "GATA-binding protein 2"))
=======
<<<<<<< .mine
(define-protein "GAS2_HUMAN" ("Gas2" "Growth arrest-specific protein 2" "GAS-2"))
(define-protein "GAS6_HUMAN" ("Gas6" "Growth arrest-specific protein 6" "GAS-6" "AXL receptor tyrosine kinase ligand"))
(define-protein "GATA2_HUMAN" ("GATA-2" "Endothelial transcription factor GATA-2" "GATA-binding protein 2"))
=======
(define-protein "GAS2_HUMAN" ("Growth arrest-specific protein 2" "GAS-2"))
(define-protein "GAS6_HUMAN" ("Growth arrest-specific protein 6" "GAS-6" "AXL receptor tyrosine kinase ligand"))
(define-protein "GATA2_HUMAN" ("Endothelial transcription factor GATA-2" "GATA-binding protein 2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "GBB3_HUMAN" ("GNB3")) 
(define-protein "GBF1_HUMAN" ("KIAA0248" "GBF1")) 
(define-protein "GBG10_HUMAN" ("GNGT10" "GNG10")) 
(define-protein "GBG12_HUMAN" ("GNG12")) 
(define-protein "GBG3_HUMAN" ("GNGT3" "GNG3")) 
(define-protein "GBG4_HUMAN" ("GNGT4" "GNG4")) 
(define-protein "GBG5_HUMAN" ("GNGT5" "GNG5")) 
(define-protein "GBG7_HUMAN" ("GNGT7" "GNG7")) 
(define-protein "GBG8_HUMAN" ("GNGT9" "GNG9" "GNG8" "Gamma-9")) 
<<<<<<< .mine
(define-protein "GBP2_HUMAN" ("neun" "Interferon-induced guanylate-binding protein 2" "GTP-binding protein 2" "GBP-2" "HuGBP-2" "Guanine nucleotide-binding protein 2"))
=======
<<<<<<< .mine
(define-protein "GBP2_HUMAN" ("neun" "Interferon-induced guanylate-binding protein 2" "GTP-binding protein 2" "GBP-2" "HuGBP-2" "Guanine nucleotide-binding protein 2"))
=======
(define-protein "GBP2_HUMAN" ("Interferon-induced guanylate-binding protein 2" "GTP-binding protein 2" "GBP-2" "HuGBP-2" "Guanine nucleotide-binding protein 2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "GCC1_HUMAN" ("GCC1")) 
<<<<<<< .mine
(define-protein "GCH1_HUMAN" ("GTP-" "GTP cyclohydrolase 1" "GTP cyclohydrolase I" "GTP-CH-I"))
=======
<<<<<<< .mine
(define-protein "GCH1_HUMAN" ("GTP-" "GTP cyclohydrolase 1" "GTP cyclohydrolase I" "GTP-CH-I"))
=======
(define-protein "GCH1_HUMAN" ("GTP cyclohydrolase 1" "GTP cyclohydrolase I" "GTP-CH-I"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "GCN1L_HUMAN" ("KIAA0219" "GCN1L1" "HsGCN1")) 
(define-protein "GCP2_HUMAN" ("GCP2" "hGrip103" "h103p" "TUBGCP2" "hSpc97" "GCP-2" "hGCP2")) 
<<<<<<< .mine
(define-protein "GCP3_HUMAN" ("γ-tubulin" "Gamma-tubulin complex component 3" "GCP-3" "hGCP3" "Gamma-ring complex protein 104 kDa" "h104p" "hGrip104" "Spindle pole body protein Spc98 homolog" "hSpc98"))
(define-protein "GCSH_HUMAN" ("gcsh" "Glycine cleavage system H protein, mitochondrial" "Lipoic acid-containing protein"))
(define-protein "GDF15_HUMAN" ("nsaid" "Growth/differentiation factor 15" "GDF-15" "Macrophage inhibitory cytokine 1" "MIC-1" "NSAID-activated gene 1 protein" "NAG-1" "NSAID-regulated gene 1 protein" "NRG-1" "Placental TGF-beta" "Placental bone morphogenetic protein" "Prostate differentiation factor"))
(define-protein "GDF5_HUMAN" ("lps" "Growth/differentiation factor 5" "GDF-5" "Bone morphogenetic protein 14" "BMP-14" "Cartilage-derived morphogenetic protein 1" "CDMP-1" "Lipopolysaccharide-associated protein 4" "LAP-4" "LPS-associated protein 4" "Radotermin"))
(define-protein "GDIA_HUMAN" ("gdis" "Rab GDP dissociation inhibitor alpha" "Rab GDI alpha" "Guanosine diphosphate dissociation inhibitor 1" "GDI-1" "Oligophrenin-2" "Protein XAP-4"))
=======
<<<<<<< .mine
(define-protein "GCP3_HUMAN" ("γ-tubulin" "Gamma-tubulin complex component 3" "GCP-3" "hGCP3" "Gamma-ring complex protein 104 kDa" "h104p" "hGrip104" "Spindle pole body protein Spc98 homolog" "hSpc98"))
(define-protein "GCSH_HUMAN" ("gcsh" "Glycine cleavage system H protein, mitochondrial" "Lipoic acid-containing protein"))
(define-protein "GDF15_HUMAN" ("nsaid" "Growth/differentiation factor 15" "GDF-15" "Macrophage inhibitory cytokine 1" "MIC-1" "NSAID-activated gene 1 protein" "NAG-1" "NSAID-regulated gene 1 protein" "NRG-1" "Placental TGF-beta" "Placental bone morphogenetic protein" "Prostate differentiation factor"))
(define-protein "GDF5_HUMAN" ("lps" "Growth/differentiation factor 5" "GDF-5" "Bone morphogenetic protein 14" "BMP-14" "Cartilage-derived morphogenetic protein 1" "CDMP-1" "Lipopolysaccharide-associated protein 4" "LAP-4" "LPS-associated protein 4" "Radotermin"))
(define-protein "GDIA_HUMAN" ("gdis" "Rab GDP dissociation inhibitor alpha" "Rab GDI alpha" "Guanosine diphosphate dissociation inhibitor 1" "GDI-1" "Oligophrenin-2" "Protein XAP-4"))
=======
(define-protein "GCP3_HUMAN" ("Gamma-tubulin complex component 3" "GCP-3" "hGCP3" "Gamma-ring complex protein 104 kDa" "h104p" "hGrip104" "Spindle pole body protein Spc98 homolog" "hSpc98"))
(define-protein "GCSH_HUMAN" ("Glycine cleavage system H protein, mitochondrial" "Lipoic acid-containing protein"))
(define-protein "GDF15_HUMAN" ("Growth/differentiation factor 15" "GDF-15" "Macrophage inhibitory cytokine 1" "MIC-1" "NSAID-activated gene 1 protein" "NAG-1" "NSAID-regulated gene 1 protein" "NRG-1" "Placental TGF-beta" "Placental bone morphogenetic protein" "Prostate differentiation factor"))
(define-protein "GDF5_HUMAN" ("Growth/differentiation factor 5" "GDF-5" "Bone morphogenetic protein 14" "BMP-14" "Cartilage-derived morphogenetic protein 1" "CDMP-1" "Lipopolysaccharide-associated protein 4" "LAP-4" "LPS-associated protein 4" "Radotermin"))
(define-protein "GDIA_HUMAN" ("Rab GDP dissociation inhibitor alpha" "Rab GDI alpha" "Guanosine diphosphate dissociation inhibitor 1" "GDI-1" "Oligophrenin-2" "Protein XAP-4"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "GDIB_HUMAN" ("GDI-2" "RABGDIB" "GDI2")) 
<<<<<<< .mine
(define-protein "GELS_HUMAN" ("gelsolin" "Gelsolin" "AGEL" "Actin-depolymerizing factor" "ADF" "Brevin"))
(define-protein "GEMI_HUMAN" ("gmnn" "Geminin"))
(define-protein "GEPH_HUMAN" ("gephyrin" "Gephyrin"))
(define-protein "GFAP_HUMAN" ("glial" "Glial fibrillary acidic protein" "GFAP"))
(define-protein "GFPT1_HUMAN" ("fructose" "Glutamine--fructose-6-phosphate aminotransferase [isomerizing] 1" "D-fructose-6-phosphate amidotransferase 1" "Glutamine:fructose-6-phosphate amidotransferase 1" "GFAT 1" "GFAT1" "Hexosephosphate aminotransferase 1"))
(define-protein "GFRA1_HUMAN" ("GFRα1" "GDNF family receptor alpha-1" "GDNF receptor alpha-1" "GDNFR-alpha-1" "GFR-alpha-1" "RET ligand 1" "TGF-beta-related neurotrophic factor receptor 1"))
(define-protein "GGA2_HUMAN" ("γ-adaptin" "ADP-ribosylation factor-binding protein GGA2" "Gamma-adaptin-related protein 2" "Golgi-localized, gamma ear-containing, ARF-binding protein 2" "VHS domain and ear domain of gamma-adaptin" "Vear"))
=======
<<<<<<< .mine
(define-protein "GELS_HUMAN" ("gelsolin" "Gelsolin" "AGEL" "Actin-depolymerizing factor" "ADF" "Brevin"))
(define-protein "GEMI_HUMAN" ("gmnn" "Geminin"))
(define-protein "GEPH_HUMAN" ("gephyrin" "Gephyrin"))
(define-protein "GFAP_HUMAN" ("glial" "Glial fibrillary acidic protein" "GFAP"))
(define-protein "GFPT1_HUMAN" ("fructose" "Glutamine--fructose-6-phosphate aminotransferase [isomerizing] 1" "D-fructose-6-phosphate amidotransferase 1" "Glutamine:fructose-6-phosphate amidotransferase 1" "GFAT 1" "GFAT1" "Hexosephosphate aminotransferase 1"))
(define-protein "GFRA1_HUMAN" ("GFRα1" "GDNF family receptor alpha-1" "GDNF receptor alpha-1" "GDNFR-alpha-1" "GFR-alpha-1" "RET ligand 1" "TGF-beta-related neurotrophic factor receptor 1"))
(define-protein "GGA2_HUMAN" ("γ-adaptin" "ADP-ribosylation factor-binding protein GGA2" "Gamma-adaptin-related protein 2" "Golgi-localized, gamma ear-containing, ARF-binding protein 2" "VHS domain and ear domain of gamma-adaptin" "Vear"))
=======
(define-protein "GELS_HUMAN" ("Gelsolin" "AGEL" "Actin-depolymerizing factor" "ADF" "Brevin"))
(define-protein "GEMI_HUMAN" ("Geminin"))
(define-protein "GEPH_HUMAN" ("Gephyrin"))
(define-protein "GFAP_HUMAN" ("Glial fibrillary acidic protein" "GFAP"))
(define-protein "GFPT1_HUMAN" ("Glutamine--fructose-6-phosphate aminotransferase [isomerizing] 1" "D-fructose-6-phosphate amidotransferase 1" "Glutamine:fructose-6-phosphate amidotransferase 1" "GFAT 1" "GFAT1" "Hexosephosphate aminotransferase 1"))
(define-protein "GFRA1_HUMAN" ("GDNF family receptor alpha-1" "GDNF receptor alpha-1" "GDNFR-alpha-1" "GFR-alpha-1" "RET ligand 1" "TGF-beta-related neurotrophic factor receptor 1"))
(define-protein "GGA2_HUMAN" ("ADP-ribosylation factor-binding protein GGA2" "Gamma-adaptin-related protein 2" "Golgi-localized, gamma ear-containing, ARF-binding protein 2" "VHS domain and ear domain of gamma-adaptin" "Vear"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "GHC1_HUMAN" ("Mitochondrial glutamate carrier 1" "GC-1" "Glutamate/H(+) symporter 1" "Solute carrier family 25 member 22"))
(define-protein "GIT1_HUMAN" ("ARF GTPase-activating protein GIT1" "ARF GAP GIT1" "Cool-associated and tyrosine-phosphorylated protein 1" "CAT-1" "CAT1" "G protein-coupled receptor kinase-interactor 1" "GRK-interacting protein 1"))
<<<<<<< .mine
(define-protein "GKAP1_HUMAN" ("gkap" "G kinase-anchoring protein 1" "cGMP-dependent protein kinase-anchoring protein of 42 kDa"))
=======
<<<<<<< .mine
(define-protein "GKAP1_HUMAN" ("gkap" "G kinase-anchoring protein 1" "cGMP-dependent protein kinase-anchoring protein of 42 kDa"))
=======
(define-protein "GKAP1_HUMAN" ("G kinase-anchoring protein 1" "cGMP-dependent protein kinase-anchoring protein of 42 kDa"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "GLCM_HUMAN" ("Beta-glucocerebrosidase" "GLUC" "Alglucerase" "Beta-GC" "GBA" "Imiglucerase" "GC")) 
<<<<<<< .mine
(define-protein "GLHA_HUMAN" ("α-" "Glycoprotein hormones alpha chain" "Anterior pituitary glycoprotein hormones common subunit alpha" "Choriogonadotropin alpha chain" "Chorionic gonadotrophin subunit alpha" "CG-alpha" "Follicle-stimulating hormone alpha chain" "FSH-alpha" "Follitropin alpha chain" "Luteinizing hormone alpha chain" "LSH-alpha" "Lutropin alpha chain" "Thyroid-stimulating hormone alpha chain" "TSH-alpha" "Thyrotropin alpha chain"))
(define-protein "GLI1_HUMAN" ("gli1" "Zinc finger protein GLI1" "Glioma-associated oncogene" "Oncogene GLI"))
=======
<<<<<<< .mine
(define-protein "GLHA_HUMAN" ("α-" "Glycoprotein hormones alpha chain" "Anterior pituitary glycoprotein hormones common subunit alpha" "Choriogonadotropin alpha chain" "Chorionic gonadotrophin subunit alpha" "CG-alpha" "Follicle-stimulating hormone alpha chain" "FSH-alpha" "Follitropin alpha chain" "Luteinizing hormone alpha chain" "LSH-alpha" "Lutropin alpha chain" "Thyroid-stimulating hormone alpha chain" "TSH-alpha" "Thyrotropin alpha chain"))
(define-protein "GLI1_HUMAN" ("gli1" "Zinc finger protein GLI1" "Glioma-associated oncogene" "Oncogene GLI"))
=======
(define-protein "GLHA_HUMAN" ("Glycoprotein hormones alpha chain" "Anterior pituitary glycoprotein hormones common subunit alpha" "Choriogonadotropin alpha chain" "Chorionic gonadotrophin subunit alpha" "CG-alpha" "Follicle-stimulating hormone alpha chain" "FSH-alpha" "Follitropin alpha chain" "Luteinizing hormone alpha chain" "LSH-alpha" "Lutropin alpha chain" "Thyroid-stimulating hormone alpha chain" "TSH-alpha" "Thyrotropin alpha chain"))
(define-protein "GLI1_HUMAN" ("Zinc finger protein GLI1" "Glioma-associated oncogene" "Oncogene GLI"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "GLI2_HUMAN" ("Zinc finger protein GLI2" "GLI family zinc finger protein 2" "Tax helper protein"))
<<<<<<< .mine
(define-protein "GLI3_HUMAN" ("Gli3" "Transcriptional activator GLI3" "GLI3 form of 190 kDa" "GLI3-190" "GLI3 full length protein" "GLI3FL"))
(define-protein "GLMN_HUMAN" ("media" "Glomulin" "FK506-binding protein-associated protein" "FAP" "FKBP-associated protein"))
=======
<<<<<<< .mine
(define-protein "GLI3_HUMAN" ("Gli3" "Transcriptional activator GLI3" "GLI3 form of 190 kDa" "GLI3-190" "GLI3 full length protein" "GLI3FL"))
(define-protein "GLMN_HUMAN" ("media" "Glomulin" "FK506-binding protein-associated protein" "FAP" "FKBP-associated protein"))
=======
(define-protein "GLI3_HUMAN" ("Transcriptional activator GLI3" "GLI3 form of 190 kDa" "GLI3-190" "GLI3 full length protein" "GLI3FL"))
(define-protein "GLMN_HUMAN" ("Glomulin" "FK506-binding protein-associated protein" "FAP" "FKBP-associated protein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "GLP3L_HUMAN" ("GPP34R" "GOLPH3L")) 
<<<<<<< .mine
(define-protein "GLT16_HUMAN" ("protein–1" "Polypeptide N-acetylgalactosaminyltransferase 16" "Polypeptide GalNAc transferase 16" "GalNAc-T16" "Polypeptide GalNAc transferase-like protein 1" "GalNAc-T-like protein 1" "pp-GaNTase-like protein 1" "Polypeptide N-acetylgalactosaminyltransferase-like protein 1" "Protein-UDP acetylgalactosaminyltransferase-like protein 1" "UDP-GalNAc:polypeptide N-acetylgalactosaminyltransferase-like protein 1"))
(define-protein "GLU2B_HUMAN" ("prkcsh" "Glucosidase 2 subunit beta" "80K-H protein" "Glucosidase II subunit beta" "Protein kinase C substrate 60.1 kDa protein heavy chain" "PKCSH"))
=======
<<<<<<< .mine
(define-protein "GLT16_HUMAN" ("protein–1" "Polypeptide N-acetylgalactosaminyltransferase 16" "Polypeptide GalNAc transferase 16" "GalNAc-T16" "Polypeptide GalNAc transferase-like protein 1" "GalNAc-T-like protein 1" "pp-GaNTase-like protein 1" "Polypeptide N-acetylgalactosaminyltransferase-like protein 1" "Protein-UDP acetylgalactosaminyltransferase-like protein 1" "UDP-GalNAc:polypeptide N-acetylgalactosaminyltransferase-like protein 1"))
(define-protein "GLU2B_HUMAN" ("prkcsh" "Glucosidase 2 subunit beta" "80K-H protein" "Glucosidase II subunit beta" "Protein kinase C substrate 60.1 kDa protein heavy chain" "PKCSH"))
=======
(define-protein "GLT16_HUMAN" ("Polypeptide N-acetylgalactosaminyltransferase 16" "Polypeptide GalNAc transferase 16" "GalNAc-T16" "Polypeptide GalNAc transferase-like protein 1" "GalNAc-T-like protein 1" "pp-GaNTase-like protein 1" "Polypeptide N-acetylgalactosaminyltransferase-like protein 1" "Protein-UDP acetylgalactosaminyltransferase-like protein 1" "UDP-GalNAc:polypeptide N-acetylgalactosaminyltransferase-like protein 1"))
(define-protein "GLU2B_HUMAN" ("Glucosidase 2 subunit beta" "80K-H protein" "Glucosidase II subunit beta" "Protein kinase C substrate 60.1 kDa protein heavy chain" "PKCSH"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "GLYR1_HUMAN" ("HIBDL" "NP60" "GLYR1")) 
<<<<<<< .mine
(define-protein "GNAS1_HUMAN" ("xlas" "Guanine nucleotide-binding protein G(s) subunit alpha isoforms XLas" "Adenylate cyclase-stimulating G alpha protein" "Extra large alphas protein" "XLalphas"))
(define-protein "GNL1_HUMAN" ("hsr" "Guanine nucleotide-binding protein-like 1" "GTP-binding protein HSR1"))
=======
<<<<<<< .mine
(define-protein "GNAS1_HUMAN" ("xlas" "Guanine nucleotide-binding protein G(s) subunit alpha isoforms XLas" "Adenylate cyclase-stimulating G alpha protein" "Extra large alphas protein" "XLalphas"))
(define-protein "GNL1_HUMAN" ("hsr" "Guanine nucleotide-binding protein-like 1" "GTP-binding protein HSR1"))
=======
(define-protein "GNAS1_HUMAN" ("Guanine nucleotide-binding protein G(s) subunit alpha isoforms XLas" "Adenylate cyclase-stimulating G alpha protein" "Extra large alphas protein" "XLalphas"))
(define-protein "GNL1_HUMAN" ("Guanine nucleotide-binding protein-like 1" "GTP-binding protein HSR1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "GNPAT_HUMAN" ("DHAP-AT" "DAPAT" "GNPAT" "DAP-AT" "Acyl-CoA:dihydroxyacetonephosphateacyltransferase" "DHAPAT")) 
<<<<<<< .mine
(define-protein "GNPTA_HUMAN" ("subunits" "N-acetylglucosamine-1-phosphotransferase subunits alpha/beta" "GlcNAc-1-phosphotransferase subunits alpha/beta" "Stealth protein GNPTAB" "UDP-N-acetylglucosamine-1-phosphotransferase subunits alpha/beta"))
=======
<<<<<<< .mine
(define-protein "GNPTA_HUMAN" ("subunits" "N-acetylglucosamine-1-phosphotransferase subunits alpha/beta" "GlcNAc-1-phosphotransferase subunits alpha/beta" "Stealth protein GNPTAB" "UDP-N-acetylglucosamine-1-phosphotransferase subunits alpha/beta"))
=======
(define-protein "GNPTA_HUMAN" ("N-acetylglucosamine-1-phosphotransferase subunits alpha/beta" "GlcNAc-1-phosphotransferase subunits alpha/beta" "Stealth protein GNPTAB" "UDP-N-acetylglucosamine-1-phosphotransferase subunits alpha/beta"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "GOGA7_HUMAN" ("GCP16" "GOLGA7")) 
(define-protein "GOLI4_HUMAN" ("GIMPc" "GPP130" "GOLIM4" "GIMPC" "GOLPH4")) 
<<<<<<< .mine
(define-protein "GOLM1_HUMAN" ("hepatocytes" "Golgi membrane protein 1" "Golgi membrane protein GP73" "Golgi phosphoprotein 2"))
=======
<<<<<<< .mine
(define-protein "GOLM1_HUMAN" ("hepatocytes" "Golgi membrane protein 1" "Golgi membrane protein GP73" "Golgi phosphoprotein 2"))
=======
(define-protein "GOLM1_HUMAN" ("Golgi membrane protein 1" "Golgi membrane protein GP73" "Golgi phosphoprotein 2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "GOLP3_HUMAN" ("GOLPH3" "GPP34" "MIDAS")) 
(define-protein "GOPC_HUMAN" ("PIST" "CAL" "FIG" "GOPC")) 
<<<<<<< .mine
(define-protein "GORS2_HUMAN" ("Grasp55" "Golgi reassembly-stacking protein 2" "GRS2" "Golgi phosphoprotein 6" "GOLPH6" "Golgi reassembly-stacking protein of 55 kDa" "GRASP55" "p59"))
=======
<<<<<<< .mine
(define-protein "GORS2_HUMAN" ("Grasp55" "Golgi reassembly-stacking protein 2" "GRS2" "Golgi phosphoprotein 6" "GOLPH6" "Golgi reassembly-stacking protein of 55 kDa" "GRASP55" "p59"))
=======
(define-protein "GORS2_HUMAN" ("Golgi reassembly-stacking protein 2" "GRS2" "Golgi phosphoprotein 6" "GOLPH6" "Golgi reassembly-stacking protein of 55 kDa" "GRASP55" "p59"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "GOSR1_HUMAN" ("GOS-28" "GOSR1" "GS28")) 
(define-protein "GOSR2_HUMAN" ("Membrin" "GOSR2" "GS27")) 
(define-protein "GOT1B_HUMAN" ("hGOT1a" "GOLT1B" "GOT1A" "GCT2")) 
(define-protein "GPA33_HUMAN" ("GPA33")) 
(define-protein "GPC3_HUMAN" ("Glypican-3" "GTR2-2" "Intestinal protein OCI-5" "MXR7"))
<<<<<<< .mine
(define-protein "GPER1_HUMAN" ("receptor–" "G-protein coupled estrogen receptor 1" "Chemoattractant receptor-like 2" "Flow-induced endothelial G-protein coupled receptor 1" "FEG-1" "G protein-coupled estrogen receptor 1" "G-protein coupled receptor 30" "GPCR-Br" "IL8-related receptor DRY12" "Lymphocyte-derived G-protein coupled receptor" "LYGPR" "Membrane estrogen receptor" "mER"))
=======
<<<<<<< .mine
(define-protein "GPER1_HUMAN" ("receptor–" "G-protein coupled estrogen receptor 1" "Chemoattractant receptor-like 2" "Flow-induced endothelial G-protein coupled receptor 1" "FEG-1" "G protein-coupled estrogen receptor 1" "G-protein coupled receptor 30" "GPCR-Br" "IL8-related receptor DRY12" "Lymphocyte-derived G-protein coupled receptor" "LYGPR" "Membrane estrogen receptor" "mER"))
=======
(define-protein "GPER1_HUMAN" ("G-protein coupled estrogen receptor 1" "Chemoattractant receptor-like 2" "Flow-induced endothelial G-protein coupled receptor 1" "FEG-1" "G protein-coupled estrogen receptor 1" "G-protein coupled receptor 30" "GPCR-Br" "IL8-related receptor DRY12" "Lymphocyte-derived G-protein coupled receptor" "LYGPR" "Membrane estrogen receptor" "mER"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "GPKOW_HUMAN" ("G patch domain and KOW motifs-containing protein" "G patch domain-containing protein 5" "Protein MOS2 homolog" "Protein T54"))
<<<<<<< .mine
(define-protein "GPKOW_HUMAN" ("MOS2" "G patch domain and KOW motifs-containing protein" "G patch domain-containing protein 5" "Protein MOS2 homolog" "Protein T54"))
(define-protein "GPR31_HUMAN" ("Ten14" "12-(S)-hydroxy-5,8,10,14-eicosatetraenoic acid receptor" "12-(S)-HETE receptor" "12-HETER" "G-protein coupled receptor 31"))
(define-protein "GPR37_HUMAN" ("LP1" "Prosaposin receptor GPR37" "Endothelin B receptor-like protein 1" "ETBR-LP-1" "G-protein coupled receptor 37" "Parkin-associated endothelin receptor-like receptor" "PAELR"))
(define-protein "GPR84_HUMAN" ("ffas" "G-protein coupled receptor 84" "Inflammation-related G-protein coupled receptor EX33"))
=======
<<<<<<< .mine
(define-protein "GPKOW_HUMAN" ("MOS2" "G patch domain and KOW motifs-containing protein" "G patch domain-containing protein 5" "Protein MOS2 homolog" "Protein T54"))
(define-protein "GPR31_HUMAN" ("Ten14" "12-(S)-hydroxy-5,8,10,14-eicosatetraenoic acid receptor" "12-(S)-HETE receptor" "12-HETER" "G-protein coupled receptor 31"))
(define-protein "GPR37_HUMAN" ("LP1" "Prosaposin receptor GPR37" "Endothelin B receptor-like protein 1" "ETBR-LP-1" "G-protein coupled receptor 37" "Parkin-associated endothelin receptor-like receptor" "PAELR"))
(define-protein "GPR84_HUMAN" ("ffas" "G-protein coupled receptor 84" "Inflammation-related G-protein coupled receptor EX33"))
=======
(define-protein "GPR31_HUMAN" ("12-(S)-hydroxy-5,8,10,14-eicosatetraenoic acid receptor" "12-(S)-HETE receptor" "12-HETER" "G-protein coupled receptor 31"))
(define-protein "GPR37_HUMAN" ("Prosaposin receptor GPR37" "Endothelin B receptor-like protein 1" "ETBR-LP-1" "G-protein coupled receptor 37" "Parkin-associated endothelin receptor-like receptor" "PAELR"))
(define-protein "GPR84_HUMAN" ("G-protein coupled receptor 84" "Inflammation-related G-protein coupled receptor EX33"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "GPS2_HUMAN" ("G protein pathway suppressor 2" "GPS-2"))
(define-protein "GPSM2_HUMAN" ("GPSM2" "LGN")) 
<<<<<<< .mine
(define-protein "GPX3_HUMAN" ("gpx" "Glutathione peroxidase 3" "GPx-3" "GSHPx-3" "Extracellular glutathione peroxidase" "Plasma glutathione peroxidase" "GPx-P" "GSHPx-P"))
=======
<<<<<<< .mine
(define-protein "GPX3_HUMAN" ("gpx" "Glutathione peroxidase 3" "GPx-3" "GSHPx-3" "Extracellular glutathione peroxidase" "Plasma glutathione peroxidase" "GPx-P" "GSHPx-P"))
=======
(define-protein "GPX3_HUMAN" ("Glutathione peroxidase 3" "GPx-3" "GSHPx-3" "Extracellular glutathione peroxidase" "Plasma glutathione peroxidase" "GPx-P" "GSHPx-P"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "GRAP1_HUMAN" ("GRIPAP1" "GRASP-1" "KIAA1167")) 
<<<<<<< .mine
(define-protein "GRAP2_HUMAN" ("mona" "GRB2-related adapter protein 2" "Adapter protein GRID" "GRB-2-like protein" "GRB2L" "GRBLG" "GRBX" "Grf40 adapter protein" "Grf-40" "Growth factor receptor-binding protein" "Hematopoietic cell-associated adapter protein GrpL" "P38" "Protein GADS" "SH3-SH2-SH3 adapter Mona"))
=======
<<<<<<< .mine
(define-protein "GRAP2_HUMAN" ("mona" "GRB2-related adapter protein 2" "Adapter protein GRID" "GRB-2-like protein" "GRB2L" "GRBLG" "GRBX" "Grf40 adapter protein" "Grf-40" "Growth factor receptor-binding protein" "Hematopoietic cell-associated adapter protein GrpL" "P38" "Protein GADS" "SH3-SH2-SH3 adapter Mona"))
=======
(define-protein "GRAP2_HUMAN" ("GRB2-related adapter protein 2" "Adapter protein GRID" "GRB-2-like protein" "GRB2L" "GRBLG" "GRBX" "Grf40 adapter protein" "Grf-40" "Growth factor receptor-binding protein" "Hematopoietic cell-associated adapter protein GrpL" "P38" "Protein GADS" "SH3-SH2-SH3 adapter Mona"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "GRB10_HUMAN" ("KIAA0207" "GRB10" "GRBIR")) 
<<<<<<< .mine
(define-protein "GRB2_HUMAN" ("Grb-2" "Growth factor receptor-bound protein 2" "Adapter protein GRB2" "Protein Ash" "SH2/SH3 adapter GRB2"))
(define-protein "GRIA1_HUMAN" ("GluR1" "Glutamate receptor 1" "GluR-1" "AMPA-selective glutamate receptor 1" "GluR-A" "GluR-K1" "Glutamate receptor ionotropic, AMPA 1" "GluA1"))
=======
<<<<<<< .mine
(define-protein "GRB2_HUMAN" ("Grb-2" "Growth factor receptor-bound protein 2" "Adapter protein GRB2" "Protein Ash" "SH2/SH3 adapter GRB2"))
(define-protein "GRIA1_HUMAN" ("GluR1" "Glutamate receptor 1" "GluR-1" "AMPA-selective glutamate receptor 1" "GluR-A" "GluR-K1" "Glutamate receptor ionotropic, AMPA 1" "GluA1"))
=======
(define-protein "GRB2_HUMAN" ("Growth factor receptor-bound protein 2" "Adapter protein GRB2" "Protein Ash" "SH2/SH3 adapter GRB2"))
(define-protein "GRIA1_HUMAN" ("Glutamate receptor 1" "GluR-1" "AMPA-selective glutamate receptor 1" "GluR-A" "GluR-K1" "Glutamate receptor ionotropic, AMPA 1" "GluA1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "GRK5_HUMAN" ("G protein-coupled receptor kinase 5" "G protein-coupled receptor kinase GRK5"))
<<<<<<< .mine
(define-protein "GRK6_HUMAN" ("grks" "G protein-coupled receptor kinase 6" "G protein-coupled receptor kinase GRK6"))
(define-protein "GROA_HUMAN" ("cytokines" "Growth-regulated alpha protein" "C-X-C motif chemokine 1" "GRO-alpha(1-73)" "Melanoma growth stimulatory activity" "MGSA" "Neutrophil-activating protein 3" "NAP-3"))
=======
<<<<<<< .mine
(define-protein "GRK6_HUMAN" ("grks" "G protein-coupled receptor kinase 6" "G protein-coupled receptor kinase GRK6"))
(define-protein "GROA_HUMAN" ("cytokines" "Growth-regulated alpha protein" "C-X-C motif chemokine 1" "GRO-alpha(1-73)" "Melanoma growth stimulatory activity" "MGSA" "Neutrophil-activating protein 3" "NAP-3"))
=======
(define-protein "GRK6_HUMAN" ("G protein-coupled receptor kinase 6" "G protein-coupled receptor kinase GRK6"))
(define-protein "GROA_HUMAN" ("Growth-regulated alpha protein" "C-X-C motif chemokine 1" "GRO-alpha(1-73)" "Melanoma growth stimulatory activity" "MGSA" "Neutrophil-activating protein 3" "NAP-3"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "GRP78_HUMAN" ("78 kDa glucose-regulated protein" "GRP-78" "Endoplasmic reticulum lumenal Ca(2+)-binding protein grp78" "Heat shock 70 kDa protein 5" "Immunoglobulin heavy chain-binding protein" "BiP"))
(define-protein "GRTP1_HUMAN" ("TBC1D6" "GRTP1")) 
<<<<<<< .mine
(define-protein "GSK3A_HUMAN" ("GSK3" "Glycogen synthase kinase-3 alpha" "GSK-3 alpha" "Serine/threonine-protein kinase GSK3A"))
=======
<<<<<<< .mine
(define-protein "GSK3A_HUMAN" ("GSK3" "Glycogen synthase kinase-3 alpha" "GSK-3 alpha" "Serine/threonine-protein kinase GSK3A"))
=======
(define-protein "GSK3A_HUMAN" ("Glycogen synthase kinase-3 alpha" "GSK-3 alpha" "Serine/threonine-protein kinase GSK3A"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "GSK3B_HUMAN" ("GSK3B")) 
<<<<<<< .mine
(define-protein "GSLG1_HUMAN" ("antiserum" "Golgi apparatus protein 1" "CFR-1" "Cysteine-rich fibroblast growth factor receptor" "E-selectin ligand 1" "ESL-1" "Golgi sialoglycoprotein MG-160"))
(define-protein "GSTA2_HUMAN" ("GST-" "Glutathione S-transferase A2" "GST HA subunit 2" "GST class-alpha member 2" "GST-gamma" "GSTA2-2" "GTH2"))
(define-protein "GSTO1_HUMAN" ("glutathione-" "Glutathione S-transferase omega-1" "GSTO-1" "Glutathione S-transferase omega 1-1" "GSTO 1-1" "Glutathione-dependent dehydroascorbate reductase" "Monomethylarsonic acid reductase" "MMA(V) reductase" "S-(Phenacyl)glutathione reductase" "SPG-R"))
=======
<<<<<<< .mine
(define-protein "GSLG1_HUMAN" ("antiserum" "Golgi apparatus protein 1" "CFR-1" "Cysteine-rich fibroblast growth factor receptor" "E-selectin ligand 1" "ESL-1" "Golgi sialoglycoprotein MG-160"))
(define-protein "GSTA2_HUMAN" ("GST-" "Glutathione S-transferase A2" "GST HA subunit 2" "GST class-alpha member 2" "GST-gamma" "GSTA2-2" "GTH2"))
(define-protein "GSTO1_HUMAN" ("glutathione-" "Glutathione S-transferase omega-1" "GSTO-1" "Glutathione S-transferase omega 1-1" "GSTO 1-1" "Glutathione-dependent dehydroascorbate reductase" "Monomethylarsonic acid reductase" "MMA(V) reductase" "S-(Phenacyl)glutathione reductase" "SPG-R"))
=======
(define-protein "GSLG1_HUMAN" ("Golgi apparatus protein 1" "CFR-1" "Cysteine-rich fibroblast growth factor receptor" "E-selectin ligand 1" "ESL-1" "Golgi sialoglycoprotein MG-160"))
(define-protein "GSTA2_HUMAN" ("Glutathione S-transferase A2" "GST HA subunit 2" "GST class-alpha member 2" "GST-gamma" "GSTA2-2" "GTH2"))
(define-protein "GSTO1_HUMAN" ("Glutathione S-transferase omega-1" "GSTO-1" "Glutathione S-transferase omega 1-1" "GSTO 1-1" "Glutathione-dependent dehydroascorbate reductase" "Monomethylarsonic acid reductase" "MMA(V) reductase" "S-(Phenacyl)glutathione reductase" "SPG-R"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "GTPB1_HUMAN" ("GP-1" "GP1" "GTPBP1")) 
(define-protein "GTR14_HUMAN" ("GLUT3" "SLC2A14" "GLUT14" "GLUT-14")) 
(define-protein "GTR3_HUMAN" ("GLUT3" "GLUT-3" "SLC2A3")) 
(define-protein "GTR4_HUMAN" ("Solute carrier family 2, facilitated glucose transporter member 4" "Glucose transporter type 4, insulin-responsive" "GLUT-4"))
(define-protein "Galphaq" NIL) 
(define-protein "Gbetagamma" NIL) 
(define-protein "Grb7" NIL) 
<<<<<<< .mine
(define-protein "H10_HUMAN" ("H1" "Histone H1.0" "Histone H1'" "Histone H1(0)"))
(define-protein "H2AX_HUMAN" ("γ-H2AX" "Histone H2AX" "H2a/x" "Histone H2A.X"))
(define-protein "H2BFS_HUMAN" ("fs" "Histone H2B type F-S" "Histone H2B.s" "H2B/s"))
(define-protein "H33_HUMAN" ("H3" "Histone H3.3"))
(define-protein "H4_HUMAN" ("H4" "Histone H4"))
(define-protein "H6QVQ5_HUMAN" ("CD3ζ" "CD3zeta chain"))
(define-protein "HABP2_HUMAN" ("hyaluronan" "Hyaluronan-binding protein 2" "Factor VII-activating protease" "Factor seven-activating protease" "FSAP" "Hepatocyte growth factor activator-like protein" "Plasma hyaluronan-binding protein"))
(define-protein "HACD3_HUMAN" ("butyrate" "Very-long-chain (3R)-3-hydroxyacyl-CoA dehydratase 3" "3-hydroxyacyl-CoA dehydratase 3" "HACD3" "Butyrate-induced protein 1" "B-ind1" "hB-ind1" "Protein-tyrosine phosphatase-like A domain-containing protein 1"))
(define-protein "HACE1_HUMAN" ("wt/wt" "E3 ubiquitin-protein ligase HACE1" "HECT domain and ankyrin repeat-containing E3 ubiquitin-protein ligase 1"))
(define-protein "HAKAI_HUMAN" ("hakai" "E3 ubiquitin-protein ligase Hakai" "Casitas B-lineage lymphoma-transforming sequence-like protein 1" "RING finger protein 188" "c-Cbl-like protein 1"))
(define-protein "HAP1_HUMAN" ("KIF5" "Huntingtin-associated protein 1" "HAP-1" "Neuroan 1"))
=======
<<<<<<< .mine
(define-protein "H10_HUMAN" ("H1" "Histone H1.0" "Histone H1'" "Histone H1(0)"))
(define-protein "H2AX_HUMAN" ("γ-H2AX" "Histone H2AX" "H2a/x" "Histone H2A.X"))
(define-protein "H2BFS_HUMAN" ("fs" "Histone H2B type F-S" "Histone H2B.s" "H2B/s"))
(define-protein "H33_HUMAN" ("H3" "Histone H3.3"))
(define-protein "H4_HUMAN" ("H4" "Histone H4"))
(define-protein "H6QVQ5_HUMAN" ("CD3ζ" "CD3zeta chain"))
(define-protein "HABP2_HUMAN" ("hyaluronan" "Hyaluronan-binding protein 2" "Factor VII-activating protease" "Factor seven-activating protease" "FSAP" "Hepatocyte growth factor activator-like protein" "Plasma hyaluronan-binding protein"))
(define-protein "HACD3_HUMAN" ("butyrate" "Very-long-chain (3R)-3-hydroxyacyl-CoA dehydratase 3" "3-hydroxyacyl-CoA dehydratase 3" "HACD3" "Butyrate-induced protein 1" "B-ind1" "hB-ind1" "Protein-tyrosine phosphatase-like A domain-containing protein 1"))
(define-protein "HACE1_HUMAN" ("wt/wt" "E3 ubiquitin-protein ligase HACE1" "HECT domain and ankyrin repeat-containing E3 ubiquitin-protein ligase 1"))
(define-protein "HAKAI_HUMAN" ("hakai" "E3 ubiquitin-protein ligase Hakai" "Casitas B-lineage lymphoma-transforming sequence-like protein 1" "RING finger protein 188" "c-Cbl-like protein 1"))
(define-protein "HAP1_HUMAN" ("KIF5" "Huntingtin-associated protein 1" "HAP-1" "Neuroan 1"))
=======
(define-protein "H10_HUMAN" ("Histone H1.0" "Histone H1'" "Histone H1(0)"))
(define-protein "H2AX_HUMAN" ("Histone H2AX" "H2a/x" "Histone H2A.X"))
(define-protein "H2BFS_HUMAN" ("Histone H2B type F-S" "Histone H2B.s" "H2B/s"))
(define-protein "H33_HUMAN" ("Histone H3.3"))
(define-protein "H4_HUMAN" ("Histone H4"))
(define-protein "H6QVQ5_HUMAN" ("CD3zeta chain"))
(define-protein "HABP2_HUMAN" ("Hyaluronan-binding protein 2" "Factor VII-activating protease" "Factor seven-activating protease" "FSAP" "Hepatocyte growth factor activator-like protein" "Plasma hyaluronan-binding protein"))
(define-protein "HACD3_HUMAN" ("Very-long-chain (3R)-3-hydroxyacyl-CoA dehydratase 3" "3-hydroxyacyl-CoA dehydratase 3" "HACD3" "Butyrate-induced protein 1" "B-ind1" "hB-ind1" "Protein-tyrosine phosphatase-like A domain-containing protein 1"))
(define-protein "HACE1_HUMAN" ("E3 ubiquitin-protein ligase HACE1" "HECT domain and ankyrin repeat-containing E3 ubiquitin-protein ligase 1"))
(define-protein "HAKAI_HUMAN" ("E3 ubiquitin-protein ligase Hakai" "Casitas B-lineage lymphoma-transforming sequence-like protein 1" "RING finger protein 188" "c-Cbl-like protein 1"))
(define-protein "HAP1_HUMAN" ("Huntingtin-associated protein 1" "HAP-1" "Neuroan 1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "HAUS1_HUMAN" ("HAUS1" "HEI-C" "CCDC5" "HEIC")) 
(define-protein "HAUS3_HUMAN" ("HAUS3" "C4orf15")) 
(define-protein "HAX1_HUMAN" ("HAX-1" "HS1BP1" "HAX1" "HSP1BP-1")) 
(define-protein "HAX1_HUMAN" ("HCLS1-associated protein X-1" "HS1-associating protein X-1" "HAX-1" "HS1-binding protein 1" "HSP1BP-1"))
<<<<<<< .mine
(define-protein "HBAZ_HUMAN" ("fetuses" "Hemoglobin subunit zeta" "HBAZ" "Hemoglobin zeta chain" "Zeta-globin"))
(define-protein "HBG1_HUMAN" ("EF3" "Hemoglobin subunit gamma-1" "Gamma-1-globin" "Hb F Agamma" "Hemoglobin gamma-1 chain" "Hemoglobin gamma-A chain"))
=======
<<<<<<< .mine
(define-protein "HBAZ_HUMAN" ("fetuses" "Hemoglobin subunit zeta" "HBAZ" "Hemoglobin zeta chain" "Zeta-globin"))
(define-protein "HBG1_HUMAN" ("EF3" "Hemoglobin subunit gamma-1" "Gamma-1-globin" "Hb F Agamma" "Hemoglobin gamma-1 chain" "Hemoglobin gamma-A chain"))
=======
(define-protein "HBAZ_HUMAN" ("Hemoglobin subunit zeta" "HBAZ" "Hemoglobin zeta chain" "Zeta-globin"))
(define-protein "HBG1_HUMAN" ("Hemoglobin subunit gamma-1" "Gamma-1-globin" "Hb F Agamma" "Hemoglobin gamma-1 chain" "Hemoglobin gamma-A chain"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "HCFC1_HUMAN" ("HFC1" "HCF-1" "HCF" "VCAF" "HCF1" "HCFC1" "CFF")) 
<<<<<<< .mine
(define-protein "HCST_HUMAN" ("DAP10-" "Hematopoietic cell signal transducer" "DNAX-activation protein 10" "Membrane protein DAP10" "Transmembrane adapter protein KAP10"))
=======
<<<<<<< .mine
(define-protein "HCST_HUMAN" ("DAP10-" "Hematopoietic cell signal transducer" "DNAX-activation protein 10" "Membrane protein DAP10" "Transmembrane adapter protein KAP10"))
=======
(define-protein "HCST_HUMAN" ("Hematopoietic cell signal transducer" "DNAX-activation protein 10" "Membrane protein DAP10" "Transmembrane adapter protein KAP10"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "HDAC1_HUMAN" ("Histone deacetylase 1" "HD1"))
(define-protein "HDAC2_HUMAN" ("Histone deacetylase 2" "HD2"))
(define-protein "HDAC4_HUMAN" ("Histone deacetylase 4" "HD4"))
<<<<<<< .mine
(define-protein "HDAC5_HUMAN" ("myotube" "Histone deacetylase 5" "HD5" "Antigen NY-CO-9"))
=======
<<<<<<< .mine
(define-protein "HDAC5_HUMAN" ("myotube" "Histone deacetylase 5" "HD5" "Antigen NY-CO-9"))
=======
(define-protein "HDAC5_HUMAN" ("Histone deacetylase 5" "HD5" "Antigen NY-CO-9"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "HDAC6_HUMAN" ("Histone deacetylase 6" "HD6"))
<<<<<<< .mine
(define-protein "HDAC8_HUMAN" ("α-SMA" "Histone deacetylase 8" "HD8"))
=======
<<<<<<< .mine
(define-protein "HDAC8_HUMAN" ("α-SMA" "Histone deacetylase 8" "HD8"))
=======
(define-protein "HDAC8_HUMAN" ("Histone deacetylase 8" "HD8"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "HDGR3_HUMAN" ("HDGFRP3" "HRP-3" "HDGF-2" "HDGF2")) 
(define-protein "HD_HUMAN" ("HTT" "IT15" "HD")) 
<<<<<<< .mine
(define-protein "HECD1_HUMAN" ("hect" "E3 ubiquitin-protein ligase HECTD1" "E3 ligase for inhibin receptor" "EULIR" "HECT domain-containing protein 1"))
=======
<<<<<<< .mine
(define-protein "HECD1_HUMAN" ("hect" "E3 ubiquitin-protein ligase HECTD1" "E3 ligase for inhibin receptor" "EULIR" "HECT domain-containing protein 1"))
=======
(define-protein "HECD1_HUMAN" ("E3 ubiquitin-protein ligase HECTD1" "E3 ligase for inhibin receptor" "EULIR" "HECT domain-containing protein 1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "HELLS_HUMAN" ("Lymphoid-specific helicase" "Proliferation-associated SNF2-like protein" "SWI/SNF2-related matrix-associated actin-dependent regulator of chromatin subfamily A member 6"))
<<<<<<< .mine
(define-protein "HEMGN_HUMAN" ("bmmcs" "Hemogen" "Erythroid differentiation-associated gene protein" "EDAG-1" "Hemopoietic gene protein" "Negative differentiation regulator protein"))
(define-protein "HEN2_HUMAN" ("NSCL2" "Helix-loop-helix protein 2" "HEN-2" "Class A basic helix-loop-helix protein 34" "bHLHa34" "Nescient helix loop helix 2" "NSCL-2"))
=======
<<<<<<< .mine
(define-protein "HEMGN_HUMAN" ("bmmcs" "Hemogen" "Erythroid differentiation-associated gene protein" "EDAG-1" "Hemopoietic gene protein" "Negative differentiation regulator protein"))
(define-protein "HEN2_HUMAN" ("NSCL2" "Helix-loop-helix protein 2" "HEN-2" "Class A basic helix-loop-helix protein 34" "bHLHa34" "Nescient helix loop helix 2" "NSCL-2"))
=======
(define-protein "HEMGN_HUMAN" ("Hemogen" "Erythroid differentiation-associated gene protein" "EDAG-1" "Hemopoietic gene protein" "Negative differentiation regulator protein"))
(define-protein "HEN2_HUMAN" ("Helix-loop-helix protein 2" "HEN-2" "Class A basic helix-loop-helix protein 34" "bHLHa34" "Nescient helix loop helix 2" "NSCL-2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "HEP2_HUMAN" ("Heparin cofactor 2" "Heparin cofactor II" "HC-II" "Protease inhibitor leuserpin-2" "HLS2" "Serpin D1"))
(define-protein "HES1_HUMAN" ("Transcription factor HES-1" "Class B basic helix-loop-helix protein 39" "bHLHb39" "Hairy and enhancer of split 1" "Hairy homolog" "Hairy-like protein" "hHL"))
(define-protein "HGS_HUMAN" ("HGS" "HRS" "Hrs")) 
<<<<<<< .mine
(define-protein "HIBCH_HUMAN" ("saline-" "3-hydroxyisobutyryl-CoA hydrolase, mitochondrial" "3-hydroxyisobutyryl-coenzyme A hydrolase" "HIB-CoA hydrolase" "HIBYL-CoA-H"))
(define-protein "HIF1A_HUMAN" ("HIF1α" "Hypoxia-inducible factor 1-alpha" "HIF-1-alpha" "HIF1-alpha" "ARNT-interacting protein" "Basic-helix-loop-helix-PAS protein MOP1" "Class E basic helix-loop-helix protein 78" "bHLHe78" "Member of PAS protein 1" "PAS domain-containing protein 8"))
=======
<<<<<<< .mine
(define-protein "HIBCH_HUMAN" ("saline-" "3-hydroxyisobutyryl-CoA hydrolase, mitochondrial" "3-hydroxyisobutyryl-coenzyme A hydrolase" "HIB-CoA hydrolase" "HIBYL-CoA-H"))
(define-protein "HIF1A_HUMAN" ("HIF1α" "Hypoxia-inducible factor 1-alpha" "HIF-1-alpha" "HIF1-alpha" "ARNT-interacting protein" "Basic-helix-loop-helix-PAS protein MOP1" "Class E basic helix-loop-helix protein 78" "bHLHe78" "Member of PAS protein 1" "PAS domain-containing protein 8"))
=======
(define-protein "HIBCH_HUMAN" ("3-hydroxyisobutyryl-CoA hydrolase, mitochondrial" "3-hydroxyisobutyryl-coenzyme A hydrolase" "HIB-CoA hydrolase" "HIBYL-CoA-H"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "HIF1A_HUMAN" ("Hypoxia-inducible factor 1-alpha" "HIF-1-alpha" "HIF1-alpha" "ARNT-interacting protein" "Basic-helix-loop-helix-PAS protein MOP1" "Class E basic helix-loop-helix protein 78" "bHLHe78" "Member of PAS protein 1" "PAS domain-containing protein 8"))
<<<<<<< .mine
(define-protein "HIF3A_HUMAN" ("normoxia" "Hypoxia-inducible factor 3-alpha" "HIF-3-alpha" "HIF3-alpha" "Basic-helix-loop-helix-PAS protein MOP7" "Class E basic helix-loop-helix protein 17" "bHLHe17" "HIF3-alpha-1" "Inhibitory PAS domain protein" "IPAS" "Member of PAS protein 7" "PAS domain-containing protein 7"))
=======
<<<<<<< .mine
(define-protein "HIF3A_HUMAN" ("normoxia" "Hypoxia-inducible factor 3-alpha" "HIF-3-alpha" "HIF3-alpha" "Basic-helix-loop-helix-PAS protein MOP7" "Class E basic helix-loop-helix protein 17" "bHLHe17" "HIF3-alpha-1" "Inhibitory PAS domain protein" "IPAS" "Member of PAS protein 7" "PAS domain-containing protein 7"))
=======
(define-protein "HIF3A_HUMAN" ("Hypoxia-inducible factor 3-alpha" "HIF-3-alpha" "HIF3-alpha" "Basic-helix-loop-helix-PAS protein MOP7" "Class E basic helix-loop-helix protein 17" "bHLHe17" "HIF3-alpha-1" "Inhibitory PAS domain protein" "IPAS" "Member of PAS protein 7" "PAS domain-containing protein 7"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "HIP1R_HUMAN" ("HIP-12" "HIP1R" "KIAA0655" "HIP12")) 
(define-protein "HIP1_HUMAN" ("HIP1" "HIP-I" "HIP-1")) 
(define-protein "HIPK2_HUMAN" ("Homeodomain-interacting protein kinase 2" "hHIPk2"))
<<<<<<< .mine
(define-protein "HIS3_HUMAN" ("demilune" "Histatin-3" "Basic histidine-rich protein" "Hst" "Histidine-rich protein 3" "PB"))
(define-protein "HJURP_HUMAN" ("nucleosomes" "Holliday junction recognition protein" "14-3-3-associated AKT substrate" "Fetal liver-expressing gene 1 protein" "Up-regulated in lung cancer 9"))
=======
<<<<<<< .mine
(define-protein "HIS3_HUMAN" ("demilune" "Histatin-3" "Basic histidine-rich protein" "Hst" "Histidine-rich protein 3" "PB"))
(define-protein "HJURP_HUMAN" ("nucleosomes" "Holliday junction recognition protein" "14-3-3-associated AKT substrate" "Fetal liver-expressing gene 1 protein" "Up-regulated in lung cancer 9"))
=======
(define-protein "HIS3_HUMAN" ("Histatin-3" "Basic histidine-rich protein" "Hst" "Histidine-rich protein 3" "PB"))
(define-protein "HJURP_HUMAN" ("Holliday junction recognition protein" "14-3-3-associated AKT substrate" "Fetal liver-expressing gene 1 protein" "Up-regulated in lung cancer 9"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "HLAH_HUMAN" ("HLA-12.4" "HLA-H" "HLA-AR" "HLAH")) 
<<<<<<< .mine
(define-protein "HLTF_HUMAN" ("sucrose" "Helicase-like transcription factor" "DNA-binding protein/plasminogen activator inhibitor 1 regulator" "HIP116" "RING finger protein 80" "SWI/SNF-related matrix-associated actin-dependent regulator of chromatin subfamily A member 3" "Sucrose nonfermenting protein 2-like 3"))
(define-protein "HMGA1_HUMAN" ("high-" "High mobility group protein HMG-I/HMG-Y" "HMG-I(Y)" "High mobility group AT-hook protein 1" "High mobility group protein A1" "High mobility group protein R"))
(define-protein "HMGB1_HUMAN" ("HMGB-1" "High mobility group protein B1" "High mobility group protein 1" "HMG-1"))
=======
<<<<<<< .mine
(define-protein "HLTF_HUMAN" ("sucrose" "Helicase-like transcription factor" "DNA-binding protein/plasminogen activator inhibitor 1 regulator" "HIP116" "RING finger protein 80" "SWI/SNF-related matrix-associated actin-dependent regulator of chromatin subfamily A member 3" "Sucrose nonfermenting protein 2-like 3"))
(define-protein "HMGA1_HUMAN" ("high-" "High mobility group protein HMG-I/HMG-Y" "HMG-I(Y)" "High mobility group AT-hook protein 1" "High mobility group protein A1" "High mobility group protein R"))
(define-protein "HMGB1_HUMAN" ("HMGB-1" "High mobility group protein B1" "High mobility group protein 1" "HMG-1"))
=======
(define-protein "HLTF_HUMAN" ("Helicase-like transcription factor" "DNA-binding protein/plasminogen activator inhibitor 1 regulator" "HIP116" "RING finger protein 80" "SWI/SNF-related matrix-associated actin-dependent regulator of chromatin subfamily A member 3" "Sucrose nonfermenting protein 2-like 3"))
(define-protein "HMGA1_HUMAN" ("High mobility group protein HMG-I/HMG-Y" "HMG-I(Y)" "High mobility group AT-hook protein 1" "High mobility group protein A1" "High mobility group protein R"))
(define-protein "HMGB1_HUMAN" ("High mobility group protein B1" "High mobility group protein 1" "HMG-1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "HMGB2_HUMAN" ("HMG2" "HMG-2" "HMGB2")) 
(define-protein "HMGN3_HUMAN" ("HMGN3" "TRIP7" "TRIP-7")) 
(define-protein "HMOX1_HUMAN" ("Heme oxygenase 1" "HO-1"))
<<<<<<< .mine
(define-protein "HN1L_HUMAN" ("L11" "Hematological and neurological expressed 1-like protein" "HN1-like protein"))
=======
<<<<<<< .mine
(define-protein "HN1L_HUMAN" ("L11" "Hematological and neurological expressed 1-like protein" "HN1-like protein"))
=======
(define-protein "HN1L_HUMAN" ("Hematological and neurological expressed 1-like protein" "HN1-like protein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "HNF4A_HUMAN" ("TCF-14" "TCF14" "HNF4" "HNF4A" "HNF-4-alpha" "NR2A1")) 
(define-protein "HNRPC_HUMAN" ("HNRPC" "HNRNPC")) 
<<<<<<< .mine
(define-protein "HNRPK_HUMAN" ("hnrnpk" "Heterogeneous nuclear ribonucleoprotein K" "hnRNP K" "Transformation up-regulated nuclear protein" "TUNP"))
=======
<<<<<<< .mine
(define-protein "HNRPK_HUMAN" ("hnrnpk" "Heterogeneous nuclear ribonucleoprotein K" "hnRNP K" "Transformation up-regulated nuclear protein" "TUNP"))
=======
(define-protein "HNRPK_HUMAN" ("Heterogeneous nuclear ribonucleoprotein K" "hnRNP K" "Transformation up-regulated nuclear protein" "TUNP"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "HOOK1_HUMAN" ("HOOK1" "hHK1" "h-hook1")) 
(define-protein "HOOK2_HUMAN" ("HOOK2" "hHK2" "h-hook2")) 
<<<<<<< .mine
(define-protein "HPBP1_HUMAN" ("Hsp70" "Hsp70-binding protein 1" "HspBP1" "Heat shock protein-binding protein 1" "Hsp70-binding protein 2" "HspBP2" "Hsp70-interacting protein 1" "Hsp70-interacting protein 2"))
(define-protein "HPRT_HUMAN" ("T/D" "Hypoxanthine-guanine phosphoribosyltransferase" "HGPRT" "HGPRTase"))
(define-protein "HPSE_HUMAN" ("faster" "Heparanase" "Endo-glucoronidase" "Heparanase-1" "Hpa1"))
=======
<<<<<<< .mine
(define-protein "HPBP1_HUMAN" ("Hsp70" "Hsp70-binding protein 1" "HspBP1" "Heat shock protein-binding protein 1" "Hsp70-binding protein 2" "HspBP2" "Hsp70-interacting protein 1" "Hsp70-interacting protein 2"))
(define-protein "HPRT_HUMAN" ("T/D" "Hypoxanthine-guanine phosphoribosyltransferase" "HGPRT" "HGPRTase"))
(define-protein "HPSE_HUMAN" ("faster" "Heparanase" "Endo-glucoronidase" "Heparanase-1" "Hpa1"))
=======
(define-protein "HPBP1_HUMAN" ("Hsp70-binding protein 1" "HspBP1" "Heat shock protein-binding protein 1" "Hsp70-binding protein 2" "HspBP2" "Hsp70-interacting protein 1" "Hsp70-interacting protein 2"))
(define-protein "HPRT_HUMAN" ("Hypoxanthine-guanine phosphoribosyltransferase" "HGPRT" "HGPRTase"))
(define-protein "HPSE_HUMAN" ("Heparanase" "Endo-glucoronidase" "Heparanase-1" "Hpa1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "HRK_HUMAN" ("Activator of apoptosis harakiri" "BH3-interacting domain-containing protein 3" "Neuronal death protein DP5"))
<<<<<<< .mine
(define-protein "HS105_HUMAN" ("Hsph1" "Heat shock protein 105 kDa" "Antigen NY-CO-25" "Heat shock 110 kDa protein"))
(define-protein "HS90B_HUMAN" ("HSP90-β" "Heat shock protein HSP 90-beta" "HSP 90" "Heat shock 84 kDa" "HSP 84" "HSP84"))
=======
<<<<<<< .mine
(define-protein "HS105_HUMAN" ("Hsph1" "Heat shock protein 105 kDa" "Antigen NY-CO-25" "Heat shock 110 kDa protein"))
(define-protein "HS90B_HUMAN" ("HSP90-β" "Heat shock protein HSP 90-beta" "HSP 90" "Heat shock 84 kDa" "HSP 84" "HSP84"))
=======
(define-protein "HS105_HUMAN" ("Heat shock protein 105 kDa" "Antigen NY-CO-25" "Heat shock 110 kDa protein"))
(define-protein "HS90B_HUMAN" ("Heat shock protein HSP 90-beta" "HSP 90" "Heat shock 84 kDa" "HSP 84" "HSP84"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "HSDL2_HUMAN" ("HSDL2" "C9orf99")) 
(define-protein "HSF1_HUMAN" ("HSF-1" "Heat shock factor protein 1" "HSF 1" "Heat shock transcription factor 1" "HSTF 1"))
(define-protein "HSF1_HUMAN" ("Heat shock factor protein 1" "HSF 1" "Heat shock transcription factor 1" "HSTF 1"))
<<<<<<< .mine
(define-protein "HSH2D_HUMAN" ("lymphocytes" "Hematopoietic SH2 domain-containing protein" "Hematopoietic SH2 protein" "Adaptor in lymphocytes of unknown function X"))
=======
<<<<<<< .mine
(define-protein "HSH2D_HUMAN" ("lymphocytes" "Hematopoietic SH2 domain-containing protein" "Hematopoietic SH2 protein" "Adaptor in lymphocytes of unknown function X"))
=======
(define-protein "HSH2D_HUMAN" ("Hematopoietic SH2 domain-containing protein" "Hematopoietic SH2 protein" "Adaptor in lymphocytes of unknown function X"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "HSP71_HUMAN" ("HSP70-1/HSP70-2" "HSPA1A" "HSPA1B" "HSP70.1/HSP70.2" "HSPA1" "HSX70")) 
(define-protein "HSPB1_HUMAN" ("Heat shock protein beta-1" "HspB1" "28 kDa heat shock protein" "Estrogen-regulated 24 kDa protein" "Heat shock 27 kDa protein" "HSP 27" "Stress-responsive protein 27" "SRP27"))
<<<<<<< .mine
(define-protein "HSPB1_HUMAN" ("Hsp27" "Heat shock protein beta-1" "HspB1" "28 kDa heat shock protein" "Estrogen-regulated 24 kDa protein" "Heat shock 27 kDa protein" "HSP 27" "Stress-responsive protein 27" "SRP27"))
(define-protein "HTRA2_HUMAN" ("tbid" "Serine protease HTRA2, mitochondrial" "High temperature requirement protein A2" "HtrA2" "Omi stress-regulated endoprotease" "Serine protease 25" "Serine proteinase OMI"))
(define-protein "HUS1_HUMAN" ("ber" "Checkpoint protein HUS1" "hHUS1"))
(define-protein "HUWE1_HUMAN" ("MULE" "E3 ubiquitin-protein ligase HUWE1" "ARF-binding protein 1" "ARF-BP1" "HECT, UBA and WWE domain-containing protein 1" "Homologous to E6AP carboxyl terminus homologous protein 9" "HectH9" "Large structure of UREB1" "LASU1" "Mcl-1 ubiquitin ligase E3" "Mule" "Upstream regulatory element-binding protein 1" "URE-B1" "URE-binding protein 1"))
=======
<<<<<<< .mine
(define-protein "HSPB1_HUMAN" ("Hsp27" "Heat shock protein beta-1" "HspB1" "28 kDa heat shock protein" "Estrogen-regulated 24 kDa protein" "Heat shock 27 kDa protein" "HSP 27" "Stress-responsive protein 27" "SRP27"))
(define-protein "HTRA2_HUMAN" ("tbid" "Serine protease HTRA2, mitochondrial" "High temperature requirement protein A2" "HtrA2" "Omi stress-regulated endoprotease" "Serine protease 25" "Serine proteinase OMI"))
(define-protein "HUS1_HUMAN" ("ber" "Checkpoint protein HUS1" "hHUS1"))
(define-protein "HUWE1_HUMAN" ("MULE" "E3 ubiquitin-protein ligase HUWE1" "ARF-binding protein 1" "ARF-BP1" "HECT, UBA and WWE domain-containing protein 1" "Homologous to E6AP carboxyl terminus homologous protein 9" "HectH9" "Large structure of UREB1" "LASU1" "Mcl-1 ubiquitin ligase E3" "Mule" "Upstream regulatory element-binding protein 1" "URE-B1" "URE-binding protein 1"))
=======
(define-protein "HTRA2_HUMAN" ("Serine protease HTRA2, mitochondrial" "High temperature requirement protein A2" "HtrA2" "Omi stress-regulated endoprotease" "Serine protease 25" "Serine proteinase OMI"))
(define-protein "HUS1_HUMAN" ("Checkpoint protein HUS1" "hHUS1"))
(define-protein "HUWE1_HUMAN" ("E3 ubiquitin-protein ligase HUWE1" "ARF-binding protein 1" "ARF-BP1" "HECT, UBA and WWE domain-containing protein 1" "Homologous to E6AP carboxyl terminus homologous protein 9" "HectH9" "Large structure of UREB1" "LASU1" "Mcl-1 ubiquitin ligase E3" "Mule" "Upstream regulatory element-binding protein 1" "URE-B1" "URE-binding protein 1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "HXA1_HUMAN" ("Homeobox protein Hox-A1" "Homeobox protein Hox-1F"))
(define-protein "HXA1_HUMAN" ("Hoxa1" "Homeobox protein Hox-A1" "Homeobox protein Hox-1F"))
(define-protein "HXA2_HUMAN" ("Homeobox protein Hox-A2" "Homeobox protein Hox-1K"))
(define-protein "HXA2_HUMAN" ("Hoxa2" "Homeobox protein Hox-A2" "Homeobox protein Hox-1K"))
(define-protein "HXA5_HUMAN" ("Homeobox protein Hox-A5" "Homeobox protein Hox-1C"))
<<<<<<< .mine
(define-protein "HXA9_HUMAN" ("Hoxa9" "Homeobox protein Hox-A9" "Homeobox protein Hox-1G"))
(define-protein "HXB4_HUMAN" ("Hoxb4" "Homeobox protein Hox-B4" "Homeobox protein Hox-2.6" "Homeobox protein Hox-2F"))
(define-protein "HXD10_HUMAN" ("hox" "Homeobox protein Hox-D10" "Homeobox protein Hox-4D" "Homeobox protein Hox-4E"))
(define-protein "HXD11_HUMAN" ("D11" "Homeobox protein Hox-D11" "Homeobox protein Hox-4F"))
(define-protein "HXK2_HUMAN" ("hexokinase-2" "Hexokinase-2" "Hexokinase type II" "HK II" "Muscle form hexokinase"))
(define-protein "HYEP_HUMAN" ("COS1" "Epoxide hydrolase 1" "Epoxide hydratase" "Microsomal epoxide hydrolase"))
(define-protein "IBTK_HUMAN" ("NB4" "Inhibitor of Bruton tyrosine kinase" "IBtk"))
=======
<<<<<<< .mine
(define-protein "HXA9_HUMAN" ("Hoxa9" "Homeobox protein Hox-A9" "Homeobox protein Hox-1G"))
(define-protein "HXB4_HUMAN" ("Hoxb4" "Homeobox protein Hox-B4" "Homeobox protein Hox-2.6" "Homeobox protein Hox-2F"))
(define-protein "HXD10_HUMAN" ("hox" "Homeobox protein Hox-D10" "Homeobox protein Hox-4D" "Homeobox protein Hox-4E"))
(define-protein "HXD11_HUMAN" ("D11" "Homeobox protein Hox-D11" "Homeobox protein Hox-4F"))
(define-protein "HXK2_HUMAN" ("hexokinase-2" "Hexokinase-2" "Hexokinase type II" "HK II" "Muscle form hexokinase"))
(define-protein "HYEP_HUMAN" ("COS1" "Epoxide hydrolase 1" "Epoxide hydratase" "Microsomal epoxide hydrolase"))
(define-protein "IBTK_HUMAN" ("NB4" "Inhibitor of Bruton tyrosine kinase" "IBtk"))
=======
(define-protein "HXA9_HUMAN" ("Homeobox protein Hox-A9" "Homeobox protein Hox-1G"))
(define-protein "HXB4_HUMAN" ("Homeobox protein Hox-B4" "Homeobox protein Hox-2.6" "Homeobox protein Hox-2F"))
(define-protein "HXD10_HUMAN" ("Homeobox protein Hox-D10" "Homeobox protein Hox-4D" "Homeobox protein Hox-4E"))
(define-protein "HXD11_HUMAN" ("Homeobox protein Hox-D11" "Homeobox protein Hox-4F"))
(define-protein "HXK2_HUMAN" ("Hexokinase-2" "Hexokinase type II" "HK II" "Muscle form hexokinase"))
(define-protein "HYEP_HUMAN" ("Epoxide hydrolase 1" "Epoxide hydratase" "Microsomal epoxide hydrolase"))
(define-protein "IBTK_HUMAN" ("Inhibitor of Bruton tyrosine kinase" "IBtk"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ICAM1_HUMAN" ("Intercellular adhesion molecule 1" "ICAM-1" "Icam-1" "Major group rhinovirus receptor"))
<<<<<<< .mine
(define-protein "ICAM3_HUMAN" ("αLβ2" "Intercellular adhesion molecule 3" "ICAM-3" "CDw50" "ICAM-R"))
=======
<<<<<<< .mine
(define-protein "ICAM3_HUMAN" ("αLβ2" "Intercellular adhesion molecule 3" "ICAM-3" "CDw50" "ICAM-R"))
=======
(define-protein "ICAM3_HUMAN" ("Intercellular adhesion molecule 3" "ICAM-3" "CDw50" "ICAM-R"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ICMT_HUMAN" ("PPMT" "pcCMT" "PCCMT" "ICMT")) 
<<<<<<< .mine
(define-protein "ICOSL_HUMAN" ("B-" "ICOS ligand" "B7 homolog 2" "B7-H2" "B7-like protein Gl50" "B7-related protein 1" "B7RP-1"))
(define-protein "IDE_HUMAN" ("aβ" "Insulin-degrading enzyme" "Abeta-degrading protease" "Insulin protease" "Insulinase" "Insulysin"))
(define-protein "IDHC_HUMAN" ("isocitrate" "Isocitrate dehydrogenase [NADP] cytoplasmic" "IDH" "Cytosolic NADP-isocitrate dehydrogenase" "IDP" "NADP(+)-specific ICDH" "Oxalosuccinate decarboxylase"))
(define-protein "IEX1_HUMAN" ("Ier3" "Radiation-inducible immediate-early gene IEX-1" "Differentiation-dependent gene 2 protein" "Protein DIF-2" "Immediate early protein GLY96" "Immediate early response 3 protein" "PACAP-responsive gene 1 protein" "Protein PRG1"))
=======
<<<<<<< .mine
(define-protein "ICOSL_HUMAN" ("B-" "ICOS ligand" "B7 homolog 2" "B7-H2" "B7-like protein Gl50" "B7-related protein 1" "B7RP-1"))
(define-protein "IDE_HUMAN" ("aβ" "Insulin-degrading enzyme" "Abeta-degrading protease" "Insulin protease" "Insulinase" "Insulysin"))
(define-protein "IDHC_HUMAN" ("isocitrate" "Isocitrate dehydrogenase [NADP] cytoplasmic" "IDH" "Cytosolic NADP-isocitrate dehydrogenase" "IDP" "NADP(+)-specific ICDH" "Oxalosuccinate decarboxylase"))
(define-protein "IEX1_HUMAN" ("Ier3" "Radiation-inducible immediate-early gene IEX-1" "Differentiation-dependent gene 2 protein" "Protein DIF-2" "Immediate early protein GLY96" "Immediate early response 3 protein" "PACAP-responsive gene 1 protein" "Protein PRG1"))
=======
(define-protein "ICOSL_HUMAN" ("ICOS ligand" "B7 homolog 2" "B7-H2" "B7-like protein Gl50" "B7-related protein 1" "B7RP-1"))
(define-protein "IDE_HUMAN" ("Insulin-degrading enzyme" "Abeta-degrading protease" "Insulin protease" "Insulinase" "Insulysin"))
(define-protein "IDHC_HUMAN" ("Isocitrate dehydrogenase [NADP] cytoplasmic" "IDH" "Cytosolic NADP-isocitrate dehydrogenase" "IDP" "NADP(+)-specific ICDH" "Oxalosuccinate decarboxylase"))
(define-protein "IEX1_HUMAN" ("Radiation-inducible immediate-early gene IEX-1" "Differentiation-dependent gene 2 protein" "Protein DIF-2" "Immediate early protein GLY96" "Immediate early response 3 protein" "PACAP-responsive gene 1 protein" "Protein PRG1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "IF1AY_HUMAN" ("eIF-4C" "EIF1AY")) 
<<<<<<< .mine
(define-protein "IF2A_HUMAN" ("eIF2α" "Eukaryotic translation initiation factor 2 subunit 1" "Eukaryotic translation initiation factor 2 subunit alpha" "eIF-2-alpha" "eIF-2A" "eIF-2alpha"))
=======
<<<<<<< .mine
(define-protein "IF2A_HUMAN" ("eIF2α" "Eukaryotic translation initiation factor 2 subunit 1" "Eukaryotic translation initiation factor 2 subunit alpha" "eIF-2-alpha" "eIF-2A" "eIF-2alpha"))
=======
(define-protein "IF2A_HUMAN" ("Eukaryotic translation initiation factor 2 subunit 1" "Eukaryotic translation initiation factor 2 subunit alpha" "eIF-2-alpha" "eIF-2A" "eIF-2alpha"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "IF2B2_HUMAN" ("VICKZ2" "IMP-2" "IGF2BP2" "IMP2")) 
<<<<<<< .mine
(define-protein "IFIH1_HUMAN" ("MDA5" "Interferon-induced helicase C domain-containing protein 1" "Clinically amyopathic dermatomyositis autoantigen 140 kDa" "CADM-140 autoantigen" "Helicase with 2 CARD domains" "Helicard" "Interferon-induced with helicase C domain protein 1" "Melanoma differentiation-associated protein 5" "MDA-5" "Murabutide down-regulated protein" "RIG-I-like receptor 2" "RLR-2" "RNA helicase-DEAD box protein 116"))
(define-protein "IFM2_HUMAN" ("vsv" "Interferon-induced transmembrane protein 2" "Dispanin subfamily A member 2c" "DSPA2c" "Interferon-inducible protein 1-8D"))
(define-protein "IFNA8_HUMAN" ("αb" "Interferon alpha-8" "IFN-alpha-8" "Interferon alpha-B" "LeIF B" "Interferon alpha-B2"))
=======
<<<<<<< .mine
(define-protein "IFIH1_HUMAN" ("MDA5" "Interferon-induced helicase C domain-containing protein 1" "Clinically amyopathic dermatomyositis autoantigen 140 kDa" "CADM-140 autoantigen" "Helicase with 2 CARD domains" "Helicard" "Interferon-induced with helicase C domain protein 1" "Melanoma differentiation-associated protein 5" "MDA-5" "Murabutide down-regulated protein" "RIG-I-like receptor 2" "RLR-2" "RNA helicase-DEAD box protein 116"))
(define-protein "IFM2_HUMAN" ("vsv" "Interferon-induced transmembrane protein 2" "Dispanin subfamily A member 2c" "DSPA2c" "Interferon-inducible protein 1-8D"))
(define-protein "IFNA8_HUMAN" ("αb" "Interferon alpha-8" "IFN-alpha-8" "Interferon alpha-B" "LeIF B" "Interferon alpha-B2"))
=======
(define-protein "IFIH1_HUMAN" ("Interferon-induced helicase C domain-containing protein 1" "Clinically amyopathic dermatomyositis autoantigen 140 kDa" "CADM-140 autoantigen" "Helicase with 2 CARD domains" "Helicard" "Interferon-induced with helicase C domain protein 1" "Melanoma differentiation-associated protein 5" "MDA-5" "Murabutide down-regulated protein" "RIG-I-like receptor 2" "RLR-2" "RNA helicase-DEAD box protein 116"))
(define-protein "IFM2_HUMAN" ("Interferon-induced transmembrane protein 2" "Dispanin subfamily A member 2c" "DSPA2c" "Interferon-inducible protein 1-8D"))
(define-protein "IFNA8_HUMAN" ("Interferon alpha-8" "IFN-alpha-8" "Interferon alpha-B" "LeIF B" "Interferon alpha-B2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "IFNG_HUMAN" ("IFN-gamma" "IFNG")) 
<<<<<<< .mine
(define-protein "IFNL3_HUMAN" ("ifnλ" "Interferon lambda-3" "IFN-lambda-3" "Cytokine Zcyto22" "Interleukin-28B" "IL-28B" "Interleukin-28C" "IL-28C"))
=======
<<<<<<< .mine
(define-protein "IFNL3_HUMAN" ("ifnλ" "Interferon lambda-3" "IFN-lambda-3" "Cytokine Zcyto22" "Interleukin-28B" "IL-28B" "Interleukin-28C" "IL-28C"))
=======
(define-protein "IFNL3_HUMAN" ("Interferon lambda-3" "IFN-lambda-3" "Cytokine Zcyto22" "Interleukin-28B" "IL-28B" "Interleukin-28C" "IL-28C"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "IFRD2_HUMAN" ("IFRD2")) 
<<<<<<< .mine
(define-protein "IFT57_HUMAN" ("hippi" "Intraflagellar transport protein 57 homolog" "Dermal papilla-derived protein 8" "Estrogen-related receptor beta-like protein 1" "HIP1-interacting protein" "MHS4R2"))
(define-protein "IG2AS_HUMAN" ("IGF-2" "Putative insulin-like growth factor 2 antisense gene protein" "IGF2 antisense RNA 1" "IGF2 antisense gene protein 1" "PEG8/IGF2AS protein" "Putative insulin-like growth factor 2 antisense gene protein 1" "IGF2-AS1"))
(define-protein "IGHD_HUMAN" ("igd" "Ig delta chain C region"))
(define-protein "IGHG2_HUMAN" ("immunoglobulins" "Ig gamma-2 chain C region"))
=======
<<<<<<< .mine
(define-protein "IFT57_HUMAN" ("hippi" "Intraflagellar transport protein 57 homolog" "Dermal papilla-derived protein 8" "Estrogen-related receptor beta-like protein 1" "HIP1-interacting protein" "MHS4R2"))
(define-protein "IG2AS_HUMAN" ("IGF-2" "Putative insulin-like growth factor 2 antisense gene protein" "IGF2 antisense RNA 1" "IGF2 antisense gene protein 1" "PEG8/IGF2AS protein" "Putative insulin-like growth factor 2 antisense gene protein 1" "IGF2-AS1"))
(define-protein "IGHD_HUMAN" ("igd" "Ig delta chain C region"))
(define-protein "IGHG2_HUMAN" ("immunoglobulins" "Ig gamma-2 chain C region"))
=======
(define-protein "IFT57_HUMAN" ("Intraflagellar transport protein 57 homolog" "Dermal papilla-derived protein 8" "Estrogen-related receptor beta-like protein 1" "HIP1-interacting protein" "MHS4R2"))
(define-protein "IG2AS_HUMAN" ("Putative insulin-like growth factor 2 antisense gene protein" "IGF2 antisense RNA 1" "IGF2 antisense gene protein 1" "PEG8/IGF2AS protein" "Putative insulin-like growth factor 2 antisense gene protein 1" "IGF2-AS1"))
(define-protein "IGHD_HUMAN" ("Ig delta chain C region"))
(define-protein "IGHG2_HUMAN" ("Ig gamma-2 chain C region"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "IGS21_HUMAN" ("IGSF21" "IgSF21")) 
<<<<<<< .mine
(define-protein "IGSF8_HUMAN" ("keratinocytes" "Immunoglobulin superfamily member 8" "IgSF8" "CD81 partner 3" "Glu-Trp-Ile EWI motif-containing protein 2" "EWI-2" "Keratinocytes-associated transmembrane protein 4" "KCT-4" "LIR-D1" "Prostaglandin regulatory-like protein" "PGRL"))
(define-protein "IHH_HUMAN" ("ihh" "Indian hedgehog protein" "IHH" "HHG-2"))
(define-protein "IKBB_HUMAN" ("iκbβ" "NF-kappa-B inhibitor beta" "NF-kappa-BIB" "I-kappa-B-beta" "IkB-B" "IkB-beta" "IkappaBbeta" "Thyroid receptor-interacting protein 9" "TR-interacting protein 9" "TRIP-9"))
(define-protein "IKBZ_HUMAN" ("nfkbiz" "NF-kappa-B inhibitor zeta" "I-kappa-B-zeta" "IkB-zeta" "IkappaBzeta" "IL-1 inducible nuclear ankyrin-repeat protein" "INAP" "Molecule possessing ankyrin repeats induced by lipopolysaccharide" "MAIL"))
(define-protein "IKKB_HUMAN" ("ikkβ" "Inhibitor of nuclear factor kappa-B kinase subunit beta" "I-kappa-B-kinase beta" "IKK-B" "IKK-beta" "IkBKB" "I-kappa-B kinase 2" "IKK2" "Nuclear factor NF-kappa-B inhibitor kinase beta" "NFKBIKB"))
(define-protein "IKKE_HUMAN" ("ikkε" "Inhibitor of nuclear factor kappa-B kinase subunit epsilon" "I-kappa-B kinase epsilon" "IKK-E" "IKK-epsilon" "IkBKE" "Inducible I kappa-B kinase" "IKK-i"))
(define-protein "IKZF1_HUMAN" ("IKZF1/IK" "DNA-binding protein Ikaros" "Ikaros family zinc finger protein 1" "Lymphoid transcription factor LyF-1"))
(define-protein "IL1A_HUMAN" ("IL-1A" "Interleukin-1 alpha" "IL-1 alpha" "Hematopoietin-1"))
=======
<<<<<<< .mine
(define-protein "IGSF8_HUMAN" ("keratinocytes" "Immunoglobulin superfamily member 8" "IgSF8" "CD81 partner 3" "Glu-Trp-Ile EWI motif-containing protein 2" "EWI-2" "Keratinocytes-associated transmembrane protein 4" "KCT-4" "LIR-D1" "Prostaglandin regulatory-like protein" "PGRL"))
(define-protein "IHH_HUMAN" ("ihh" "Indian hedgehog protein" "IHH" "HHG-2"))
(define-protein "IKBB_HUMAN" ("iκbβ" "NF-kappa-B inhibitor beta" "NF-kappa-BIB" "I-kappa-B-beta" "IkB-B" "IkB-beta" "IkappaBbeta" "Thyroid receptor-interacting protein 9" "TR-interacting protein 9" "TRIP-9"))
(define-protein "IKBZ_HUMAN" ("nfkbiz" "NF-kappa-B inhibitor zeta" "I-kappa-B-zeta" "IkB-zeta" "IkappaBzeta" "IL-1 inducible nuclear ankyrin-repeat protein" "INAP" "Molecule possessing ankyrin repeats induced by lipopolysaccharide" "MAIL"))
(define-protein "IKKB_HUMAN" ("ikkβ" "Inhibitor of nuclear factor kappa-B kinase subunit beta" "I-kappa-B-kinase beta" "IKK-B" "IKK-beta" "IkBKB" "I-kappa-B kinase 2" "IKK2" "Nuclear factor NF-kappa-B inhibitor kinase beta" "NFKBIKB"))
(define-protein "IKKE_HUMAN" ("ikkε" "Inhibitor of nuclear factor kappa-B kinase subunit epsilon" "I-kappa-B kinase epsilon" "IKK-E" "IKK-epsilon" "IkBKE" "Inducible I kappa-B kinase" "IKK-i"))
(define-protein "IKZF1_HUMAN" ("IKZF1/IK" "DNA-binding protein Ikaros" "Ikaros family zinc finger protein 1" "Lymphoid transcription factor LyF-1"))
(define-protein "IL1A_HUMAN" ("IL-1A" "Interleukin-1 alpha" "IL-1 alpha" "Hematopoietin-1"))
=======
(define-protein "IGSF8_HUMAN" ("Immunoglobulin superfamily member 8" "IgSF8" "CD81 partner 3" "Glu-Trp-Ile EWI motif-containing protein 2" "EWI-2" "Keratinocytes-associated transmembrane protein 4" "KCT-4" "LIR-D1" "Prostaglandin regulatory-like protein" "PGRL"))
(define-protein "IHH_HUMAN" ("Indian hedgehog protein" "IHH" "HHG-2"))
(define-protein "IKBB_HUMAN" ("NF-kappa-B inhibitor beta" "NF-kappa-BIB" "I-kappa-B-beta" "IkB-B" "IkB-beta" "IkappaBbeta" "Thyroid receptor-interacting protein 9" "TR-interacting protein 9" "TRIP-9"))
(define-protein "IKBZ_HUMAN" ("NF-kappa-B inhibitor zeta" "I-kappa-B-zeta" "IkB-zeta" "IkappaBzeta" "IL-1 inducible nuclear ankyrin-repeat protein" "INAP" "Molecule possessing ankyrin repeats induced by lipopolysaccharide" "MAIL"))
(define-protein "IKKB_HUMAN" ("Inhibitor of nuclear factor kappa-B kinase subunit beta" "I-kappa-B-kinase beta" "IKK-B" "IKK-beta" "IkBKB" "I-kappa-B kinase 2" "IKK2" "Nuclear factor NF-kappa-B inhibitor kinase beta" "NFKBIKB"))
(define-protein "IKKE_HUMAN" ("Inhibitor of nuclear factor kappa-B kinase subunit epsilon" "I-kappa-B kinase epsilon" "IKK-E" "IKK-epsilon" "IkBKE" "Inducible I kappa-B kinase" "IKK-i"))
(define-protein "IKZF1_HUMAN" ("DNA-binding protein Ikaros" "Ikaros family zinc finger protein 1" "Lymphoid transcription factor LyF-1"))
(define-protein "IL1A_HUMAN" ("Interleukin-1 alpha" "IL-1 alpha" "Hematopoietin-1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "IL1B_HUMAN" ("IL1B" "Catabolin" "IL1F2")) 
<<<<<<< .mine
(define-protein "IL1RA_HUMAN" ("IL1ra" "Interleukin-1 receptor antagonist protein" "IL-1RN" "IL-1ra" "IRAP" "ICIL-1RA" "IL1 inhibitor"))
(define-protein "IL22_HUMAN" ("IL-22R1" "Interleukin-22" "IL-22" "Cytokine Zcyto18" "IL-10-related T-cell-derived-inducible factor" "IL-TIF"))
=======
<<<<<<< .mine
(define-protein "IL1RA_HUMAN" ("IL1ra" "Interleukin-1 receptor antagonist protein" "IL-1RN" "IL-1ra" "IRAP" "ICIL-1RA" "IL1 inhibitor"))
(define-protein "IL22_HUMAN" ("IL-22R1" "Interleukin-22" "IL-22" "Cytokine Zcyto18" "IL-10-related T-cell-derived-inducible factor" "IL-TIF"))
=======
(define-protein "IL1RA_HUMAN" ("Interleukin-1 receptor antagonist protein" "IL-1RN" "IL-1ra" "IRAP" "ICIL-1RA" "IL1 inhibitor"))
(define-protein "IL22_HUMAN" ("Interleukin-22" "IL-22" "Cytokine Zcyto18" "IL-10-related T-cell-derived-inducible factor" "IL-TIF"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "IL23A_HUMAN" ("Interleukin-23 subunit alpha" "IL-23 subunit alpha" "IL-23-A" "Interleukin-23 subunit p19" "IL-23p19"))
(define-protein "IL23A_HUMAN" ("P19" "Interleukin-23 subunit alpha" "IL-23 subunit alpha" "IL-23-A" "Interleukin-23 subunit p19" "IL-23p19"))
(define-protein "IL37_HUMAN" ("Interleukin-37" "FIL1 zeta" "IL-1X" "Interleukin-1 family member 7" "IL-1F7" "Interleukin-1 homolog 4" "IL-1H" "IL-1H4" "Interleukin-1 zeta" "IL-1 zeta" "Interleukin-1-related protein" "IL-1RP1" "Interleukin-23" "IL-37"))
<<<<<<< .mine
(define-protein "IL6RB_HUMAN" ("interleukin-6" "Interleukin-6 receptor subunit beta" "IL-6 receptor subunit beta" "IL-6R subunit beta" "IL-6R-beta" "IL-6RB" "CDw130" "Interleukin-6 signal transducer" "Membrane glycoprotein 130" "gp130" "Oncostatin-M receptor subunit alpha"))
(define-protein "IL6_HUMAN" ("anti-β" "Interleukin-6" "IL-6" "B-cell stimulatory factor 2" "BSF-2" "CTL differentiation factor" "CDF" "Hybridoma growth factor" "Interferon beta-2" "IFN-beta-2"))
=======
<<<<<<< .mine
(define-protein "IL6RB_HUMAN" ("interleukin-6" "Interleukin-6 receptor subunit beta" "IL-6 receptor subunit beta" "IL-6R subunit beta" "IL-6R-beta" "IL-6RB" "CDw130" "Interleukin-6 signal transducer" "Membrane glycoprotein 130" "gp130" "Oncostatin-M receptor subunit alpha"))
(define-protein "IL6_HUMAN" ("anti-β" "Interleukin-6" "IL-6" "B-cell stimulatory factor 2" "BSF-2" "CTL differentiation factor" "CDF" "Hybridoma growth factor" "Interferon beta-2" "IFN-beta-2"))
=======
(define-protein "IL6RB_HUMAN" ("Interleukin-6 receptor subunit beta" "IL-6 receptor subunit beta" "IL-6R subunit beta" "IL-6R-beta" "IL-6RB" "CDw130" "Interleukin-6 signal transducer" "Membrane glycoprotein 130" "gp130" "Oncostatin-M receptor subunit alpha"))
(define-protein "IL6_HUMAN" ("Interleukin-6" "IL-6" "B-cell stimulatory factor 2" "BSF-2" "CTL differentiation factor" "CDF" "Hybridoma growth factor" "Interferon beta-2" "IFN-beta-2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ILF3_HUMAN" ("NF-AT-90" "TCP80" "DRBF" "ILF3" "NF90" "MPHOSPH4" "MPP4" "DRBP76" "NFAR")) 
(define-protein "ILKAP_HUMAN" ("ILKAP")) 
(define-protein "IMA1_HUMAN" ("KPNA2" "RCH1" "SRP1")) 
<<<<<<< .mine
(define-protein "IMA5_HUMAN" ("karyopherin" "Importin subunit alpha-5" "Karyopherin subunit alpha-1" "Nucleoprotein interactor 1" "NPI-1" "RAG cohort protein 2" "SRP1-beta"))
=======
<<<<<<< .mine
(define-protein "IMA5_HUMAN" ("karyopherin" "Importin subunit alpha-5" "Karyopherin subunit alpha-1" "Nucleoprotein interactor 1" "NPI-1" "RAG cohort protein 2" "SRP1-beta"))
=======
(define-protein "IMA5_HUMAN" ("Importin subunit alpha-5" "Karyopherin subunit alpha-1" "Nucleoprotein interactor 1" "NPI-1" "RAG cohort protein 2" "SRP1-beta"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "IMB1_HUMAN" ("NTF97" "KPNB1" "Importin-90" "PTAC97")) 
<<<<<<< .mine
(define-protein "IMPA1_HUMAN" ("inositol" "Inositol monophosphatase 1" "IMP 1" "IMPase 1" "D-galactose 1-phosphate phosphatase" "Inositol-1(or 4)-monophosphatase 1" "Lithium-sensitive myo-inositol monophosphatase A1"))
(define-protein "INAR2_HUMAN" ("ifnα" "Interferon alpha/beta receptor 2" "IFN-R-2" "IFN-alpha binding protein" "IFN-alpha/beta receptor 2" "Interferon alpha binding protein" "Type I interferon receptor 2"))
(define-protein "INCE_HUMAN" ("incenp" "Inner centromere protein"))
(define-protein "INGR1_HUMAN" ("IFN-γ" "Interferon gamma receptor 1" "IFN-gamma receptor 1" "IFN-gamma-R1" "CDw119"))
(define-protein "INGR2_HUMAN" ("interferon-γ" "Interferon gamma receptor 2" "IFN-gamma receptor 2" "IFN-gamma-R2" "Interferon gamma receptor accessory factor 1" "AF-1" "Interferon gamma transducer 1"))
=======
<<<<<<< .mine
(define-protein "IMPA1_HUMAN" ("inositol" "Inositol monophosphatase 1" "IMP 1" "IMPase 1" "D-galactose 1-phosphate phosphatase" "Inositol-1(or 4)-monophosphatase 1" "Lithium-sensitive myo-inositol monophosphatase A1"))
(define-protein "INAR2_HUMAN" ("ifnα" "Interferon alpha/beta receptor 2" "IFN-R-2" "IFN-alpha binding protein" "IFN-alpha/beta receptor 2" "Interferon alpha binding protein" "Type I interferon receptor 2"))
(define-protein "INCE_HUMAN" ("incenp" "Inner centromere protein"))
(define-protein "INGR1_HUMAN" ("IFN-γ" "Interferon gamma receptor 1" "IFN-gamma receptor 1" "IFN-gamma-R1" "CDw119"))
(define-protein "INGR2_HUMAN" ("interferon-γ" "Interferon gamma receptor 2" "IFN-gamma receptor 2" "IFN-gamma-R2" "Interferon gamma receptor accessory factor 1" "AF-1" "Interferon gamma transducer 1"))
=======
(define-protein "IMPA1_HUMAN" ("Inositol monophosphatase 1" "IMP 1" "IMPase 1" "D-galactose 1-phosphate phosphatase" "Inositol-1(or 4)-monophosphatase 1" "Lithium-sensitive myo-inositol monophosphatase A1"))
(define-protein "INAR2_HUMAN" ("Interferon alpha/beta receptor 2" "IFN-R-2" "IFN-alpha binding protein" "IFN-alpha/beta receptor 2" "Interferon alpha binding protein" "Type I interferon receptor 2"))
(define-protein "INCE_HUMAN" ("Inner centromere protein"))
(define-protein "INGR1_HUMAN" ("Interferon gamma receptor 1" "IFN-gamma receptor 1" "IFN-gamma-R1" "CDw119"))
(define-protein "INGR2_HUMAN" ("Interferon gamma receptor 2" "IFN-gamma receptor 2" "IFN-gamma-R2" "Interferon gamma receptor accessory factor 1" "AF-1" "Interferon gamma transducer 1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "IPO4_HUMAN" ("Importin-4" "Imp4" "Importin-4b" "Imp4b" "Ran-binding protein 4" "RanBP4"))
(define-protein "IPO4_HUMAN" ("importin-4" "Importin-4" "Imp4" "Importin-4b" "Imp4b" "Ran-binding protein 4" "RanBP4"))
(define-protein "IQGA2_HUMAN" ("IQGAP2")) 
(define-protein "IQGA3_HUMAN" ("IQGAP3")) 
(define-protein "IRAK1_HUMAN" ("IRAK1" "IRAK-1" "IRAK")) 
(define-protein "IRAK2_HUMAN" ("IRAK2" "IRAK-2")) 
(define-protein "IRF1_HUMAN" ("Interferon regulatory factor 1" "IRF-1"))
(define-protein "IRF9_HUMAN" ("IRF-9" "ISGF3G" "IRF9")) 
<<<<<<< .mine
(define-protein "IRS4_HUMAN" ("substrate-4" "Insulin receptor substrate 4" "IRS-4" "160 kDa phosphotyrosine protein" "py160" "Phosphoprotein of 160 kDa" "pp160"))
(define-protein "ISG20_HUMAN" ("snrnas" "Interferon-stimulated gene 20 kDa protein" "Estrogen-regulated transcript 45 protein" "Promyelocytic leukemia nuclear body-associated protein ISG20"))
=======
<<<<<<< .mine
(define-protein "IRS4_HUMAN" ("substrate-4" "Insulin receptor substrate 4" "IRS-4" "160 kDa phosphotyrosine protein" "py160" "Phosphoprotein of 160 kDa" "pp160"))
(define-protein "ISG20_HUMAN" ("snrnas" "Interferon-stimulated gene 20 kDa protein" "Estrogen-regulated transcript 45 protein" "Promyelocytic leukemia nuclear body-associated protein ISG20"))
=======
(define-protein "IRS4_HUMAN" ("Insulin receptor substrate 4" "IRS-4" "160 kDa phosphotyrosine protein" "py160" "Phosphoprotein of 160 kDa" "pp160"))
(define-protein "ISG20_HUMAN" ("Interferon-stimulated gene 20 kDa protein" "Estrogen-regulated transcript 45 protein" "Promyelocytic leukemia nuclear body-associated protein ISG20"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "IST1_HUMAN" ("hIST1" "IST1" "KIAA0174")) 
(define-protein "ITA2_HUMAN" ("CD49B" "ITGA2" "GPIa" "CD49b")) 
(define-protein "ITA3_HUMAN" ("GAPB3" "CD49c" "MSK18" "ITGA3" "FRP-2")) 
<<<<<<< .mine
(define-protein "ITA4_HUMAN" ("VLA4" "Integrin alpha-4" "CD49 antigen-like family member D" "Integrin alpha-IV" "VLA-4 subunit alpha"))
(define-protein "ITA5_HUMAN" ("α5β1" "Integrin alpha-5" "CD49 antigen-like family member E" "Fibronectin receptor subunit alpha" "Integrin alpha-F" "VLA-5"))
=======
<<<<<<< .mine
(define-protein "ITA4_HUMAN" ("VLA4" "Integrin alpha-4" "CD49 antigen-like family member D" "Integrin alpha-IV" "VLA-4 subunit alpha"))
(define-protein "ITA5_HUMAN" ("α5β1" "Integrin alpha-5" "CD49 antigen-like family member E" "Fibronectin receptor subunit alpha" "Integrin alpha-F" "VLA-5"))
=======
(define-protein "ITA4_HUMAN" ("Integrin alpha-4" "CD49 antigen-like family member D" "Integrin alpha-IV" "VLA-4 subunit alpha"))
(define-protein "ITA5_HUMAN" ("Integrin alpha-5" "CD49 antigen-like family member E" "Fibronectin receptor subunit alpha" "Integrin alpha-F" "VLA-5"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ITAL_HUMAN" ("Integrin alpha-L" "CD11 antigen-like family member A" "Leukocyte adhesion glycoprotein LFA-1 alpha chain" "LFA-1A" "Leukocyte function-associated molecule 1 alpha chain"))
<<<<<<< .mine
(define-protein "ITAM_HUMAN" ("Mac1" "Integrin alpha-M" "CD11 antigen-like family member B" "CR-3 alpha chain" "Cell surface glycoprotein MAC-1 subunit alpha" "Leukocyte adhesion receptor MO1" "Neutrophil adherence receptor"))
(define-protein "ITAV_HUMAN" ("αv" "Integrin alpha-V" "Vitronectin receptor subunit alpha"))
(define-protein "ITB3_HUMAN" ("αIIbβ3" "Integrin beta-3" "Platelet membrane glycoprotein IIIa" "GPIIIa"))
(define-protein "ITB4_HUMAN" ("β4-integrin" "Integrin beta-4" "GP150"))
=======
<<<<<<< .mine
(define-protein "ITAM_HUMAN" ("Mac1" "Integrin alpha-M" "CD11 antigen-like family member B" "CR-3 alpha chain" "Cell surface glycoprotein MAC-1 subunit alpha" "Leukocyte adhesion receptor MO1" "Neutrophil adherence receptor"))
(define-protein "ITAV_HUMAN" ("αv" "Integrin alpha-V" "Vitronectin receptor subunit alpha"))
(define-protein "ITB3_HUMAN" ("αIIbβ3" "Integrin beta-3" "Platelet membrane glycoprotein IIIa" "GPIIIa"))
(define-protein "ITB4_HUMAN" ("β4-integrin" "Integrin beta-4" "GP150"))
=======
(define-protein "ITAM_HUMAN" ("Integrin alpha-M" "CD11 antigen-like family member B" "CR-3 alpha chain" "Cell surface glycoprotein MAC-1 subunit alpha" "Leukocyte adhesion receptor MO1" "Neutrophil adherence receptor"))
(define-protein "ITAV_HUMAN" ("Integrin alpha-V" "Vitronectin receptor subunit alpha"))
(define-protein "ITB3_HUMAN" ("Integrin beta-3" "Platelet membrane glycoprotein IIIa" "GPIIIa"))
(define-protein "ITB4_HUMAN" ("Integrin beta-4" "GP150"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ITB5_HUMAN" ("ITGB5")) 
<<<<<<< .mine
(define-protein "ITB7_HUMAN" ("admidas" "Integrin beta-7" "Gut homing receptor beta subunit"))
(define-protein "ITBP1_HUMAN" ("β1-integrin" "Integrin beta-1-binding protein 1" "Integrin cytoplasmic domain-associated protein 1" "ICAP-1"))
(define-protein "ITCH_HUMAN" ("Itch/AIP4" "E3 ubiquitin-protein ligase Itchy homolog" "Itch" "Atrophin-1-interacting protein 4" "AIP4" "NFE2-associated polypeptide 1" "NAPP1"))
(define-protein "ITF2_HUMAN" ("Tcf4" "Transcription factor 4" "TCF-4" "Class B basic helix-loop-helix protein 19" "bHLHb19" "Immunoglobulin transcription factor 2" "ITF-2" "SL3-3 enhancer factor 2" "SEF-2"))
=======
<<<<<<< .mine
(define-protein "ITB7_HUMAN" ("admidas" "Integrin beta-7" "Gut homing receptor beta subunit"))
(define-protein "ITBP1_HUMAN" ("β1-integrin" "Integrin beta-1-binding protein 1" "Integrin cytoplasmic domain-associated protein 1" "ICAP-1"))
(define-protein "ITCH_HUMAN" ("Itch/AIP4" "E3 ubiquitin-protein ligase Itchy homolog" "Itch" "Atrophin-1-interacting protein 4" "AIP4" "NFE2-associated polypeptide 1" "NAPP1"))
(define-protein "ITF2_HUMAN" ("Tcf4" "Transcription factor 4" "TCF-4" "Class B basic helix-loop-helix protein 19" "bHLHb19" "Immunoglobulin transcription factor 2" "ITF-2" "SL3-3 enhancer factor 2" "SEF-2"))
=======
(define-protein "ITB7_HUMAN" ("Integrin beta-7" "Gut homing receptor beta subunit"))
(define-protein "ITBP1_HUMAN" ("Integrin beta-1-binding protein 1" "Integrin cytoplasmic domain-associated protein 1" "ICAP-1"))
(define-protein "ITCH_HUMAN" ("E3 ubiquitin-protein ligase Itchy homolog" "Itch" "Atrophin-1-interacting protein 4" "AIP4" "NFE2-associated polypeptide 1" "NAPP1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ITF2_HUMAN" ("Transcription factor 4" "TCF-4" "Class B basic helix-loop-helix protein 19" "bHLHb19" "Immunoglobulin transcription factor 2" "ITF-2" "SL3-3 enhancer factor 2" "SEF-2"))
<<<<<<< .mine
(define-protein "ITSN1_HUMAN" ("intersectin" "Intersectin-1" "SH3 domain-containing protein 1A" "SH3P17"))
=======
<<<<<<< .mine
(define-protein "ITSN1_HUMAN" ("intersectin" "Intersectin-1" "SH3 domain-containing protein 1A" "SH3P17"))
=======
(define-protein "ITSN1_HUMAN" ("Intersectin-1" "SH3 domain-containing protein 1A" "SH3P17"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "IWS1_HUMAN" ("IWS1" "IWS1L")) 
<<<<<<< .mine
(define-protein "J9RB96_9HIV1" ("LN18" "Protein Nef"))
=======
<<<<<<< .mine
(define-protein "J9RB96_9HIV1" ("LN18" "Protein Nef"))
=======
(define-protein "J9RB96_9HIV1" ("Protein Nef"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "JIP3_HUMAN" ("JIP-3" "JIP3" "MAPK8IP3" "KIAA1066")) 
<<<<<<< .mine
(define-protein "JIP4_HUMAN" ("jlp" "C-Jun-amino-terminal kinase-interacting protein 4" "JIP-4" "JNK-interacting protein 4" "Cancer/testis antigen 89" "CT89" "Human lung cancer oncogene 6 protein" "HLC-6" "JNK-associated leucine-zipper protein" "JLP" "Mitogen-activated protein kinase 8-interacting protein 4" "Proliferation-inducing protein 6" "Protein highly expressed in testis" "PHET" "Sperm surface protein" "Sperm-associated antigen 9" "Sperm-specific protein" "Sunday driver 1"))
=======
<<<<<<< .mine
(define-protein "JIP4_HUMAN" ("jlp" "C-Jun-amino-terminal kinase-interacting protein 4" "JIP-4" "JNK-interacting protein 4" "Cancer/testis antigen 89" "CT89" "Human lung cancer oncogene 6 protein" "HLC-6" "JNK-associated leucine-zipper protein" "JLP" "Mitogen-activated protein kinase 8-interacting protein 4" "Proliferation-inducing protein 6" "Protein highly expressed in testis" "PHET" "Sperm surface protein" "Sperm-associated antigen 9" "Sperm-specific protein" "Sunday driver 1"))
=======
(define-protein "JIP4_HUMAN" ("C-Jun-amino-terminal kinase-interacting protein 4" "JIP-4" "JNK-interacting protein 4" "Cancer/testis antigen 89" "CT89" "Human lung cancer oncogene 6 protein" "HLC-6" "JNK-associated leucine-zipper protein" "JLP" "Mitogen-activated protein kinase 8-interacting protein 4" "Proliferation-inducing protein 6" "Protein highly expressed in testis" "PHET" "Sperm surface protein" "Sperm-associated antigen 9" "Sperm-specific protein" "Sunday driver 1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "JMJD6_HUMAN" ("Bifunctional arginine demethylase and lysyl-hydroxylase JMJD6" "Histone arginine demethylase JMJD6" "JmjC domain-containing protein 6" "Jumonji domain-containing protein 6" "Lysyl-hydroxylase JMJD6" "Peptide-lysine 5-dioxygenase JMJD6" "Phosphatidylserine receptor" "Protein PTDSR"))
<<<<<<< .mine
(define-protein "JUN_HUMAN" ("c-jun" "Transcription factor AP-1" "Activator protein 1" "AP1" "Proto-oncogene c-Jun" "V-jun avian sarcoma virus 17 oncogene homolog" "p39"))
(define-protein "K15_HHV8P" ("NFAT/AP1" "Protein K15"))
(define-protein "K1C14_HUMAN" ("cK14" "Keratin, type I cytoskeletal 14" "Cytokeratin-14" "CK-14" "Keratin-14" "K14"))
=======
<<<<<<< .mine
(define-protein "JUN_HUMAN" ("c-jun" "Transcription factor AP-1" "Activator protein 1" "AP1" "Proto-oncogene c-Jun" "V-jun avian sarcoma virus 17 oncogene homolog" "p39"))
(define-protein "K15_HHV8P" ("NFAT/AP1" "Protein K15"))
(define-protein "K1C14_HUMAN" ("cK14" "Keratin, type I cytoskeletal 14" "Cytokeratin-14" "CK-14" "Keratin-14" "K14"))
=======
(define-protein "JUN_HUMAN" ("Transcription factor AP-1" "Activator protein 1" "AP1" "Proto-oncogene c-Jun" "V-jun avian sarcoma virus 17 oncogene homolog" "p39"))
(define-protein "K15_HHV8P" ("Protein K15"))
(define-protein "K1C14_HUMAN" ("Keratin, type I cytoskeletal 14" "Cytokeratin-14" "CK-14" "Keratin-14" "K14"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "K1C16_HUMAN" ("Keratin, type I cytoskeletal 16" "Cytokeratin-16" "CK-16" "Keratin-16" "K16"))
(define-protein "K1C18_HUMAN" ("Cytokeratin-18" "Keratin-18" "K18" "KRT18" "CK-18" "CYK18")) 
(define-protein "K1C19_HUMAN" ("Keratin, type I cytoskeletal 19" "Cytokeratin-19" "CK-19" "Keratin-19" "K19"))
<<<<<<< .mine
(define-protein "K1C19_HUMAN" ("cytokeratins" "Keratin, type I cytoskeletal 19" "Cytokeratin-19" "CK-19" "Keratin-19" "K19"))
(define-protein "K1SWR3_9ZZZZ" ("chaperones" "Disulfide bond chaperones of the HSP33 family"))
(define-protein "K1TBJ7_9ZZZZ" ("S46" "Peptidase S46"))
(define-protein "K1TY43_9ZZZZ" ("topo" "DNA gyrase/topo II, topoisomerase IV"))
(define-protein "K1V7I5_9ZZZZ" ("tfx" "DNA-directed RNA polymerase specialized sigma subunit"))
(define-protein "K6_HHV8P" ("K6" "Protein K6"))
(define-protein "KANK2_HUMAN" ("coactivators" "KN motif and ankyrin repeat domain-containing protein 2" "Ankyrin repeat domain-containing protein 25" "Matrix-remodeling-associated protein 3" "SRC-1-interacting protein" "SIP" "SRC-interacting protein" "SRC1-interacting protein"))
=======
<<<<<<< .mine
(define-protein "K1C19_HUMAN" ("cytokeratins" "Keratin, type I cytoskeletal 19" "Cytokeratin-19" "CK-19" "Keratin-19" "K19"))
(define-protein "K1SWR3_9ZZZZ" ("chaperones" "Disulfide bond chaperones of the HSP33 family"))
(define-protein "K1TBJ7_9ZZZZ" ("S46" "Peptidase S46"))
(define-protein "K1TY43_9ZZZZ" ("topo" "DNA gyrase/topo II, topoisomerase IV"))
(define-protein "K1V7I5_9ZZZZ" ("tfx" "DNA-directed RNA polymerase specialized sigma subunit"))
(define-protein "K6_HHV8P" ("K6" "Protein K6"))
(define-protein "KANK2_HUMAN" ("coactivators" "KN motif and ankyrin repeat domain-containing protein 2" "Ankyrin repeat domain-containing protein 25" "Matrix-remodeling-associated protein 3" "SRC-1-interacting protein" "SIP" "SRC-interacting protein" "SRC1-interacting protein"))
=======
(define-protein "K1SWR3_9ZZZZ" ("Disulfide bond chaperones of the HSP33 family"))
(define-protein "K1TBJ7_9ZZZZ" ("Peptidase S46"))
(define-protein "K1TY43_9ZZZZ" ("DNA gyrase/topo II, topoisomerase IV"))
(define-protein "K1V7I5_9ZZZZ" ("DNA-directed RNA polymerase specialized sigma subunit"))
(define-protein "K6_HHV8P" ("Protein K6"))
(define-protein "KANK2_HUMAN" ("KN motif and ankyrin repeat domain-containing protein 2" "Ankyrin repeat domain-containing protein 25" "Matrix-remodeling-associated protein 3" "SRC-1-interacting protein" "SIP" "SRC-interacting protein" "SRC1-interacting protein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "KANL2_HUMAN" ("NSL2" "C12orf41" "KANSL2")) 
<<<<<<< .mine
(define-protein "KAP0_HUMAN" ("iα" "cAMP-dependent protein kinase type I-alpha regulatory subunit" "Tissue-specific extinguisher 1" "TSE1"))
=======
<<<<<<< .mine
(define-protein "KAP0_HUMAN" ("iα" "cAMP-dependent protein kinase type I-alpha regulatory subunit" "Tissue-specific extinguisher 1" "TSE1"))
=======
(define-protein "KAP0_HUMAN" ("cAMP-dependent protein kinase type I-alpha regulatory subunit" "Tissue-specific extinguisher 1" "TSE1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "KAP2_HUMAN" ("PRKAR2" "PRKAR2A" "PKR2")) 
<<<<<<< .mine
(define-protein "KAPCA_HUMAN" ("pka" "cAMP-dependent protein kinase catalytic subunit alpha" "PKA C-alpha"))
(define-protein "KAT2B_HUMAN" ("pcaf" "Histone acetyltransferase KAT2B" "Histone acetyltransferase PCAF" "Histone acetylase PCAF" "Lysine acetyltransferase 2B" "P300/CBP-associated factor" "P/CAF"))
(define-protein "KAT5_HUMAN" ("TIP60" "Histone acetyltransferase KAT5" "60 kDa Tat-interactive protein" "Tip60" "Histone acetyltransferase HTATIP" "HIV-1 Tat interactive protein" "Lysine acetyltransferase 5" "cPLA(2)-interacting protein"))
(define-protein "KAT6B_HUMAN" ("Sas2" "Histone acetyltransferase KAT6B" "Histone acetyltransferase MOZ2" "MOZ, YBF2/SAS3, SAS2 and TIP60 protein 4" "MYST-4" "Monocytic leukemia zinc finger protein-related factor"))
=======
<<<<<<< .mine
(define-protein "KAPCA_HUMAN" ("pka" "cAMP-dependent protein kinase catalytic subunit alpha" "PKA C-alpha"))
(define-protein "KAT2B_HUMAN" ("pcaf" "Histone acetyltransferase KAT2B" "Histone acetyltransferase PCAF" "Histone acetylase PCAF" "Lysine acetyltransferase 2B" "P300/CBP-associated factor" "P/CAF"))
(define-protein "KAT5_HUMAN" ("TIP60" "Histone acetyltransferase KAT5" "60 kDa Tat-interactive protein" "Tip60" "Histone acetyltransferase HTATIP" "HIV-1 Tat interactive protein" "Lysine acetyltransferase 5" "cPLA(2)-interacting protein"))
(define-protein "KAT6B_HUMAN" ("Sas2" "Histone acetyltransferase KAT6B" "Histone acetyltransferase MOZ2" "MOZ, YBF2/SAS3, SAS2 and TIP60 protein 4" "MYST-4" "Monocytic leukemia zinc finger protein-related factor"))
=======
(define-protein "KAPCA_HUMAN" ("cAMP-dependent protein kinase catalytic subunit alpha" "PKA C-alpha"))
(define-protein "KAT2B_HUMAN" ("Histone acetyltransferase KAT2B" "Histone acetyltransferase PCAF" "Histone acetylase PCAF" "Lysine acetyltransferase 2B" "P300/CBP-associated factor" "P/CAF"))
(define-protein "KAT5_HUMAN" ("Histone acetyltransferase KAT5" "60 kDa Tat-interactive protein" "Tip60" "Histone acetyltransferase HTATIP" "HIV-1 Tat interactive protein" "Lysine acetyltransferase 5" "cPLA(2)-interacting protein"))
(define-protein "KAT6B_HUMAN" ("Histone acetyltransferase KAT6B" "Histone acetyltransferase MOZ2" "MOZ, YBF2/SAS3, SAS2 and TIP60 protein 4" "MYST-4" "Monocytic leukemia zinc finger protein-related factor"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "KBRS2_HUMAN" ("KBRAS2" "NKIRAS2" "KappaB-Ras2")) 
(define-protein "KC1A_HUMAN" ("CSNK1A1" "CK1" "CKI-alpha")) 
(define-protein "KC1D_HUMAN" ("CKId" "CSNK1D" "HCKID" "CKI-delta")) 
(define-protein "KCC4_HUMAN" ("Calcium/calmodulin-dependent protein kinase type IV" "CaMK IV" "CaM kinase-GR"))
(define-protein "KCJ11_HUMAN" ("ATP-sensitive inward rectifier potassium channel 11" "IKATP" "Inward rectifier K(+) channel Kir6.2" "Potassium channel, inwardly rectifying subfamily J member 11"))
<<<<<<< .mine
(define-protein "KCMA1_HUMAN" ("bk" "Calcium-activated potassium channel subunit alpha-1" "BK channel" "BKCA alpha" "Calcium-activated potassium channel, subfamily M subunit alpha-1" "K(VCA)alpha" "KCa1.1" "Maxi K channel" "MaxiK" "Slo-alpha" "Slo1" "Slowpoke homolog" "Slo homolog" "hSlo"))
(define-protein "KCMB2_HUMAN" ("β2" "Calcium-activated potassium channel subunit beta-2" "BK channel subunit beta-2" "BKbeta2" "Hbeta2" "Calcium-activated potassium channel, subfamily M subunit beta-2" "Charybdotoxin receptor subunit beta-2" "Hbeta3" "K(VCA)beta-2" "Maxi K channel subunit beta-2" "Slo-beta-2"))
=======
<<<<<<< .mine
(define-protein "KCMA1_HUMAN" ("bk" "Calcium-activated potassium channel subunit alpha-1" "BK channel" "BKCA alpha" "Calcium-activated potassium channel, subfamily M subunit alpha-1" "K(VCA)alpha" "KCa1.1" "Maxi K channel" "MaxiK" "Slo-alpha" "Slo1" "Slowpoke homolog" "Slo homolog" "hSlo"))
(define-protein "KCMB2_HUMAN" ("β2" "Calcium-activated potassium channel subunit beta-2" "BK channel subunit beta-2" "BKbeta2" "Hbeta2" "Calcium-activated potassium channel, subfamily M subunit beta-2" "Charybdotoxin receptor subunit beta-2" "Hbeta3" "K(VCA)beta-2" "Maxi K channel subunit beta-2" "Slo-beta-2"))
=======
(define-protein "KCMA1_HUMAN" ("Calcium-activated potassium channel subunit alpha-1" "BK channel" "BKCA alpha" "Calcium-activated potassium channel, subfamily M subunit alpha-1" "K(VCA)alpha" "KCa1.1" "Maxi K channel" "MaxiK" "Slo-alpha" "Slo1" "Slowpoke homolog" "Slo homolog" "hSlo"))
(define-protein "KCMB2_HUMAN" ("Calcium-activated potassium channel subunit beta-2" "BK channel subunit beta-2" "BKbeta2" "Hbeta2" "Calcium-activated potassium channel, subfamily M subunit beta-2" "Charybdotoxin receptor subunit beta-2" "Hbeta3" "K(VCA)beta-2" "Maxi K channel subunit beta-2" "Slo-beta-2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "KCMB3_HUMAN" ("Calcium-activated potassium channel subunit beta-3" "BK channel subunit beta-3" "BKbeta3" "Hbeta3" "Calcium-activated potassium channel, subfamily M subunit beta-3" "Charybdotoxin receptor subunit beta-3" "K(VCA)beta-3" "Maxi K channel subunit beta-3" "Slo-beta-3"))
<<<<<<< .mine
(define-protein "KCMB3_HUMAN" ("β3" "Calcium-activated potassium channel subunit beta-3" "BK channel subunit beta-3" "BKbeta3" "Hbeta3" "Calcium-activated potassium channel, subfamily M subunit beta-3" "Charybdotoxin receptor subunit beta-3" "K(VCA)beta-3" "Maxi K channel subunit beta-3" "Slo-beta-3"))
(define-protein "KCMB4_HUMAN" ("β4" "Calcium-activated potassium channel subunit beta-4" "BK channel subunit beta-4" "BKbeta4" "Hbeta4" "Calcium-activated potassium channel, subfamily M subunit beta-4" "Charybdotoxin receptor subunit beta-4" "K(VCA)beta-4" "Maxi K channel subunit beta-4" "Slo-beta-4"))
=======
<<<<<<< .mine
(define-protein "KCMB3_HUMAN" ("β3" "Calcium-activated potassium channel subunit beta-3" "BK channel subunit beta-3" "BKbeta3" "Hbeta3" "Calcium-activated potassium channel, subfamily M subunit beta-3" "Charybdotoxin receptor subunit beta-3" "K(VCA)beta-3" "Maxi K channel subunit beta-3" "Slo-beta-3"))
(define-protein "KCMB4_HUMAN" ("β4" "Calcium-activated potassium channel subunit beta-4" "BK channel subunit beta-4" "BKbeta4" "Hbeta4" "Calcium-activated potassium channel, subfamily M subunit beta-4" "Charybdotoxin receptor subunit beta-4" "K(VCA)beta-4" "Maxi K channel subunit beta-4" "Slo-beta-4"))
=======
(define-protein "KCMB4_HUMAN" ("Calcium-activated potassium channel subunit beta-4" "BK channel subunit beta-4" "BKbeta4" "Hbeta4" "Calcium-activated potassium channel, subfamily M subunit beta-4" "Charybdotoxin receptor subunit beta-4" "K(VCA)beta-4" "Maxi K channel subunit beta-4" "Slo-beta-4"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "KCNA3_HUMAN" ("Potassium voltage-gated channel subfamily A member 3" "HGK5" "HLK3" "HPCN3" "Voltage-gated K(+) channel HuKIII" "Voltage-gated potassium channel subunit Kv1.3"))
(define-protein "KCNA5_HUMAN" ("Potassium voltage-gated channel subfamily A member 5" "HPCN1" "Voltage-gated potassium channel HK2" "Voltage-gated potassium channel subunit Kv1.5"))
<<<<<<< .mine
(define-protein "KCNH1_HUMAN" ("myoblasts" "Potassium voltage-gated channel subfamily H member 1" "Ether-a-go-go potassium channel 1" "EAG channel 1" "h-eag" "hEAG1" "Voltage-gated potassium channel subunit Kv10.1"))
=======
<<<<<<< .mine
(define-protein "KCNH1_HUMAN" ("myoblasts" "Potassium voltage-gated channel subfamily H member 1" "Ether-a-go-go potassium channel 1" "EAG channel 1" "h-eag" "hEAG1" "Voltage-gated potassium channel subunit Kv10.1"))
=======
(define-protein "KCNH1_HUMAN" ("Potassium voltage-gated channel subfamily H member 1" "Ether-a-go-go potassium channel 1" "EAG channel 1" "h-eag" "hEAG1" "Voltage-gated potassium channel subunit Kv10.1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "KCNN4_HUMAN" ("Intermediate conductance calcium-activated potassium channel protein 4" "SK4" "SKCa 4" "SKCa4" "IKCa1" "IK1" "KCa3.1" "KCa4" "Putative Gardos channel"))
<<<<<<< .mine
(define-protein "KCNN4_HUMAN" ("ko" "Intermediate conductance calcium-activated potassium channel protein 4" "SK4" "SKCa 4" "SKCa4" "IKCa1" "IK1" "KCa3.1" "KCa4" "Putative Gardos channel"))
(define-protein "KCRM_HUMAN" ("creatine" "Creatine kinase M-type" "Creatine kinase M chain" "M-CK"))
=======
<<<<<<< .mine
(define-protein "KCNN4_HUMAN" ("ko" "Intermediate conductance calcium-activated potassium channel protein 4" "SK4" "SKCa 4" "SKCa4" "IKCa1" "IK1" "KCa3.1" "KCa4" "Putative Gardos channel"))
(define-protein "KCRM_HUMAN" ("creatine" "Creatine kinase M-type" "Creatine kinase M chain" "M-CK"))
=======
(define-protein "KCRM_HUMAN" ("Creatine kinase M-type" "Creatine kinase M chain" "M-CK"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "KDM4D_HUMAN" ("KDM4D" "JMJD2D" "JHDM3D")) 
<<<<<<< .mine
(define-protein "KDM5B_HUMAN" ("H3K4" "Lysine-specific demethylase 5B" "Cancer/testis antigen 31" "CT31" "Histone demethylase JARID1B" "Jumonji/ARID domain-containing protein 1B" "PLU-1" "Retinoblastoma-binding protein 2 homolog 1" "RBP2-H1"))
=======
<<<<<<< .mine
(define-protein "KDM5B_HUMAN" ("H3K4" "Lysine-specific demethylase 5B" "Cancer/testis antigen 31" "CT31" "Histone demethylase JARID1B" "Jumonji/ARID domain-containing protein 1B" "PLU-1" "Retinoblastoma-binding protein 2 homolog 1" "RBP2-H1"))
=======
(define-protein "KDM5B_HUMAN" ("Lysine-specific demethylase 5B" "Cancer/testis antigen 31" "CT31" "Histone demethylase JARID1B" "Jumonji/ARID domain-containing protein 1B" "PLU-1" "Retinoblastoma-binding protein 2 homolog 1" "RBP2-H1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "KEAP1_HUMAN" ("Kelch-like ECH-associated protein 1" "Cytosolic inhibitor of Nrf2" "INrf2" "Kelch-like protein 19"))
(define-protein "KEAP1_HUMAN" ("sulforaphane" "Kelch-like ECH-associated protein 1" "Cytosolic inhibitor of Nrf2" "INrf2" "Kelch-like protein 19"))
(define-protein "KHDR1_HUMAN" ("p68" "SAM68" "KHDRBS1" "Sam68")) 
(define-protein "KI20B_HUMAN" ("KRMP1" "MPHOSPH1" "MPP1" "KIF20B" "CT90")) 
(define-protein "KI67_HUMAN" ("Antigen KI-67"))
(define-protein "KI67_HUMAN" ("Ki67" "Antigen KI-67"))
(define-protein "KIF11_HUMAN" ("TRIP-5" "EG5" "KIF11" "TRIP5" "KNSL1")) 
<<<<<<< .mine
(define-protein "KIF14_HUMAN" ("dyneins" "Kinesin-like protein KIF14"))
=======
<<<<<<< .mine
(define-protein "KIF14_HUMAN" ("dyneins" "Kinesin-like protein KIF14"))
=======
(define-protein "KIF14_HUMAN" ("Kinesin-like protein KIF14"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "KIF1A_HUMAN" ("hUnc-104" "ATSV" "KIF1A" "C2orf20")) 
<<<<<<< .mine
(define-protein "KIF23_HUMAN" ("centralspindlin" "Kinesin-like protein KIF23" "Kinesin-like protein 5" "Mitotic kinesin-like protein 1"))
=======
<<<<<<< .mine
(define-protein "KIF23_HUMAN" ("centralspindlin" "Kinesin-like protein KIF23" "Kinesin-like protein 5" "Mitotic kinesin-like protein 1"))
=======
(define-protein "KIF23_HUMAN" ("Kinesin-like protein KIF23" "Kinesin-like protein 5" "Mitotic kinesin-like protein 1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "KIF2A_HUMAN" ("KNS2" "KIF2A" "hK2" "KIF2" "Kinesin-2")) 
(define-protein "KIF4A_HUMAN" ("KIF4" "KIF4A" "Chromokinesin-A")) 
(define-protein "KIFC1_HUMAN" ("KIFC1" "KNSL2" "HSET")) 
<<<<<<< .mine
(define-protein "KIN17_HUMAN" ("subdomains" "DNA/RNA-binding protein KIN17" "Binding to curved DNA" "KIN, antigenic determinant of recA protein homolog"))
=======
<<<<<<< .mine
(define-protein "KIN17_HUMAN" ("subdomains" "DNA/RNA-binding protein KIN17" "Binding to curved DNA" "KIN, antigenic determinant of recA protein homolog"))
=======
(define-protein "KIN17_HUMAN" ("DNA/RNA-binding protein KIN17" "Binding to curved DNA" "KIN, antigenic determinant of recA protein homolog"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "KINH_HUMAN" ("UKHC" "KIF5B" "KNS1" "KNS")) 
<<<<<<< .mine
(define-protein "KIT_HUMAN" ("c-Kit" "Mast/stem cell growth factor receptor Kit" "SCFR" "Piebald trait protein" "PBT" "Proto-oncogene c-Kit" "Tyrosine-protein kinase Kit" "p145 c-kit" "v-kit Hardy-Zuckerman 4 feline sarcoma viral oncogene homolog"))
(define-protein "KKCC2_HUMAN" ("calmodulin" "Calcium/calmodulin-dependent protein kinase kinase 2" "CaM-KK 2" "CaM-kinase kinase 2" "CaMKK 2" "Calcium/calmodulin-dependent protein kinase kinase beta" "CaM-KK beta" "CaM-kinase kinase beta" "CaMKK beta"))
=======
<<<<<<< .mine
(define-protein "KIT_HUMAN" ("c-Kit" "Mast/stem cell growth factor receptor Kit" "SCFR" "Piebald trait protein" "PBT" "Proto-oncogene c-Kit" "Tyrosine-protein kinase Kit" "p145 c-kit" "v-kit Hardy-Zuckerman 4 feline sarcoma viral oncogene homolog"))
(define-protein "KKCC2_HUMAN" ("calmodulin" "Calcium/calmodulin-dependent protein kinase kinase 2" "CaM-KK 2" "CaM-kinase kinase 2" "CaMKK 2" "Calcium/calmodulin-dependent protein kinase kinase beta" "CaM-KK beta" "CaM-kinase kinase beta" "CaMKK beta"))
=======
(define-protein "KIT_HUMAN" ("Mast/stem cell growth factor receptor Kit" "SCFR" "Piebald trait protein" "PBT" "Proto-oncogene c-Kit" "Tyrosine-protein kinase Kit" "p145 c-kit" "v-kit Hardy-Zuckerman 4 feline sarcoma viral oncogene homolog"))
(define-protein "KKCC2_HUMAN" ("Calcium/calmodulin-dependent protein kinase kinase 2" "CaM-KK 2" "CaM-kinase kinase 2" "CaMKK 2" "Calcium/calmodulin-dependent protein kinase kinase beta" "CaM-KK beta" "CaM-kinase kinase beta" "CaMKK beta"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "KLC1_HUMAN" ("KNS2" "KLC1" "KLC")) 
(define-protein "KLC2_HUMAN" ("KLC2")) 
(define-protein "KLC4_HUMAN" ("KNSL8" "KLC4")) 
(define-protein "KLF10_HUMAN" ("Krueppel-like factor 10" "EGR-alpha" "Transforming growth factor-beta-inducible early growth response protein 1" "TGFB-inducible early growth response protein 1" "TIEG-1"))
(define-protein "KLF3_HUMAN" ("TEF-2" "BKLF" "KLF3")) 
<<<<<<< .mine
(define-protein "KLH41_HUMAN" ("sarcosin" "Kelch-like protein 41" "Kel-like protein 23" "Kelch repeat and BTB domain-containing protein 10" "Kelch-related protein 1" "Sarcosin"))
(define-protein "KLRD1_HUMAN" ("CD94/NKG2A" "Natural killer cells antigen CD94" "KP43" "Killer cell lectin-like receptor subfamily D member 1" "NK cell receptor"))
(define-protein "KLRG1_HUMAN" ("mafa" "Killer cell lectin-like receptor subfamily G member 1" "C-type lectin domain family 15 member A" "ITIM-containing receptor MAFA-L" "MAFA-like receptor" "Mast cell function-associated antigen"))
(define-protein "KMT2A_HUMAN" ("myeloid" "Histone-lysine N-methyltransferase 2A" "Lysine N-methyltransferase 2A" "ALL-1" "CXXC-type zinc finger protein 7" "Myeloid/lymphoid or mixed-lineage leukemia" "Myeloid/lymphoid or mixed-lineage leukemia protein 1" "Trithorax-like protein" "Zinc finger protein HRX"))
=======
<<<<<<< .mine
(define-protein "KLH41_HUMAN" ("sarcosin" "Kelch-like protein 41" "Kel-like protein 23" "Kelch repeat and BTB domain-containing protein 10" "Kelch-related protein 1" "Sarcosin"))
(define-protein "KLRD1_HUMAN" ("CD94/NKG2A" "Natural killer cells antigen CD94" "KP43" "Killer cell lectin-like receptor subfamily D member 1" "NK cell receptor"))
(define-protein "KLRG1_HUMAN" ("mafa" "Killer cell lectin-like receptor subfamily G member 1" "C-type lectin domain family 15 member A" "ITIM-containing receptor MAFA-L" "MAFA-like receptor" "Mast cell function-associated antigen"))
(define-protein "KMT2A_HUMAN" ("myeloid" "Histone-lysine N-methyltransferase 2A" "Lysine N-methyltransferase 2A" "ALL-1" "CXXC-type zinc finger protein 7" "Myeloid/lymphoid or mixed-lineage leukemia" "Myeloid/lymphoid or mixed-lineage leukemia protein 1" "Trithorax-like protein" "Zinc finger protein HRX"))
=======
(define-protein "KLH41_HUMAN" ("Kelch-like protein 41" "Kel-like protein 23" "Kelch repeat and BTB domain-containing protein 10" "Kelch-related protein 1" "Sarcosin"))
(define-protein "KLRD1_HUMAN" ("Natural killer cells antigen CD94" "KP43" "Killer cell lectin-like receptor subfamily D member 1" "NK cell receptor"))
(define-protein "KLRG1_HUMAN" ("Killer cell lectin-like receptor subfamily G member 1" "C-type lectin domain family 15 member A" "ITIM-containing receptor MAFA-L" "MAFA-like receptor" "Mast cell function-associated antigen"))
(define-protein "KMT2A_HUMAN" ("Histone-lysine N-methyltransferase 2A" "Lysine N-methyltransferase 2A" "ALL-1" "CXXC-type zinc finger protein 7" "Myeloid/lymphoid or mixed-lineage leukemia" "Myeloid/lymphoid or mixed-lineage leukemia protein 1" "Trithorax-like protein" "Zinc finger protein HRX"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "KMT2B_HUMAN" ("Histone-lysine N-methyltransferase 2B" "Lysine N-methyltransferase 2B" "Myeloid/lymphoid or mixed-lineage leukemia protein 4" "Trithorax homolog 2" "WW domain-binding protein 7" "WBP-7"))
(define-protein "KNTC1_HUMAN" ("HsROD" "KIAA0166" "hRod" "Rod" "KNTC1")) 
<<<<<<< .mine
(define-protein "KPCA_HUMAN" ("pkcα" "Protein kinase C alpha type" "PKC-A" "PKC-alpha"))
(define-protein "KPCB_HUMAN" ("pkcβ" "Protein kinase C beta type" "PKC-B" "PKC-beta"))
(define-protein "KPCD_HUMAN" ("pkcδ" "Protein kinase C delta type" "Tyrosine-protein kinase PRKCD" "nPKC-delta"))
(define-protein "KPCE_HUMAN" ("pkcε" "Protein kinase C epsilon type" "nPKC-epsilon"))
(define-protein "KPCI_HUMAN" ("pkcι" "Protein kinase C iota type" "Atypical protein kinase C-lambda/iota" "PRKC-lambda/iota" "aPKC-lambda/iota" "nPKC-iota"))
(define-protein "KPCL_HUMAN" ("PKC-η" "Protein kinase C eta type" "PKC-L" "nPKC-eta"))
(define-protein "KPCZ_HUMAN" ("p42/44" "Protein kinase C zeta type" "nPKC-zeta"))
(define-protein "KPRB_HUMAN" ("ribp" "Phosphoribosyl pyrophosphate synthase-associated protein 2" "PRPP synthase-associated protein 2" "41 kDa phosphoribosypyrophosphate synthetase-associated protein" "PAP41"))
(define-protein "KRA14_HUMAN" ("I4" "Keratin-associated protein 1-4" "High sulfur keratin-associated protein 1.4" "Keratin-associated protein 1.4"))
(define-protein "KRA23_HUMAN" ("2/3" "Keratin-associated protein 2-3" "High sulfur keratin-associated protein 2.4" "Keratin-associated protein 2.3"))
(define-protein "KRA51_HUMAN" ("V1" "Keratin-associated protein 5-1" "Keratin, cuticle, ultrahigh sulphur 1-like" "Keratin-associated protein 5.1" "Ultrahigh sulfur keratin-associated protein 5.1"))
(define-protein "KRA55_HUMAN" ("V5" "Keratin-associated protein 5-5" "Keratin-associated protein 5-11" "Keratin-associated protein 5.11" "Keratin-associated protein 5.5" "Ultrahigh sulfur keratin-associated protein 5.5"))
=======
<<<<<<< .mine
(define-protein "KPCA_HUMAN" ("pkcα" "Protein kinase C alpha type" "PKC-A" "PKC-alpha"))
(define-protein "KPCB_HUMAN" ("pkcβ" "Protein kinase C beta type" "PKC-B" "PKC-beta"))
(define-protein "KPCD_HUMAN" ("pkcδ" "Protein kinase C delta type" "Tyrosine-protein kinase PRKCD" "nPKC-delta"))
(define-protein "KPCE_HUMAN" ("pkcε" "Protein kinase C epsilon type" "nPKC-epsilon"))
(define-protein "KPCI_HUMAN" ("pkcι" "Protein kinase C iota type" "Atypical protein kinase C-lambda/iota" "PRKC-lambda/iota" "aPKC-lambda/iota" "nPKC-iota"))
(define-protein "KPCL_HUMAN" ("PKC-η" "Protein kinase C eta type" "PKC-L" "nPKC-eta"))
(define-protein "KPCZ_HUMAN" ("p42/44" "Protein kinase C zeta type" "nPKC-zeta"))
(define-protein "KPRB_HUMAN" ("ribp" "Phosphoribosyl pyrophosphate synthase-associated protein 2" "PRPP synthase-associated protein 2" "41 kDa phosphoribosypyrophosphate synthetase-associated protein" "PAP41"))
(define-protein "KRA14_HUMAN" ("I4" "Keratin-associated protein 1-4" "High sulfur keratin-associated protein 1.4" "Keratin-associated protein 1.4"))
(define-protein "KRA23_HUMAN" ("2/3" "Keratin-associated protein 2-3" "High sulfur keratin-associated protein 2.4" "Keratin-associated protein 2.3"))
(define-protein "KRA51_HUMAN" ("V1" "Keratin-associated protein 5-1" "Keratin, cuticle, ultrahigh sulphur 1-like" "Keratin-associated protein 5.1" "Ultrahigh sulfur keratin-associated protein 5.1"))
(define-protein "KRA55_HUMAN" ("V5" "Keratin-associated protein 5-5" "Keratin-associated protein 5-11" "Keratin-associated protein 5.11" "Keratin-associated protein 5.5" "Ultrahigh sulfur keratin-associated protein 5.5"))
=======
(define-protein "KPCA_HUMAN" ("Protein kinase C alpha type" "PKC-A" "PKC-alpha"))
(define-protein "KPCB_HUMAN" ("Protein kinase C beta type" "PKC-B" "PKC-beta"))
(define-protein "KPCD_HUMAN" ("Protein kinase C delta type" "Tyrosine-protein kinase PRKCD" "nPKC-delta"))
(define-protein "KPCE_HUMAN" ("Protein kinase C epsilon type" "nPKC-epsilon"))
(define-protein "KPCI_HUMAN" ("Protein kinase C iota type" "Atypical protein kinase C-lambda/iota" "PRKC-lambda/iota" "aPKC-lambda/iota" "nPKC-iota"))
(define-protein "KPCL_HUMAN" ("Protein kinase C eta type" "PKC-L" "nPKC-eta"))
(define-protein "KPCZ_HUMAN" ("Protein kinase C zeta type" "nPKC-zeta"))
(define-protein "KPRB_HUMAN" ("Phosphoribosyl pyrophosphate synthase-associated protein 2" "PRPP synthase-associated protein 2" "41 kDa phosphoribosypyrophosphate synthetase-associated protein" "PAP41"))
(define-protein "KRA14_HUMAN" ("Keratin-associated protein 1-4" "High sulfur keratin-associated protein 1.4" "Keratin-associated protein 1.4"))
(define-protein "KRA23_HUMAN" ("Keratin-associated protein 2-3" "High sulfur keratin-associated protein 2.4" "Keratin-associated protein 2.3"))
(define-protein "KRA51_HUMAN" ("Keratin-associated protein 5-1" "Keratin, cuticle, ultrahigh sulphur 1-like" "Keratin-associated protein 5.1" "Ultrahigh sulfur keratin-associated protein 5.1"))
(define-protein "KRA55_HUMAN" ("Keratin-associated protein 5-5" "Keratin-associated protein 5-11" "Keratin-associated protein 5.11" "Keratin-associated protein 5.5" "Ultrahigh sulfur keratin-associated protein 5.5"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "KS6A1_HUMAN" ("MAPKAPK-1a" "S6K-alpha-1" "p90S6K" "RSK1" "MAPKAPK1A" "RSK-1" "RPS6KA1" "p90RSK1")) 
(define-protein "KS6A3_HUMAN" ("pp90RSK2" "MAPKAPK-1b" "RPS6KA3" "S6K-alpha-3" "ISPK1" "RSK2" "MAPKAPK1B" "ISPK-1" "RSK-2" "p90RSK3" "Rsk2")) 
(define-protein "KS6A4_HUMAN" ("RSKB" "MSK2" "RPS6KA4" "S6K-alpha-4")) 
(define-protein "KS6A5_HUMAN" ("RSKL" "MSK1" "S6K-alpha-5" "RPS6KA5")) 
(define-protein "KS6B2_HUMAN" ("Ribosomal protein S6 kinase beta-2" "S6K-beta-2" "S6K2" "70 kDa ribosomal protein S6 kinase 2" "P70S6K2" "p70-S6K 2" "S6 kinase-related kinase" "SRK" "Serine/threonine-protein kinase 14B" "p70 ribosomal S6 kinase beta" "S6K-beta" "p70 S6 kinase beta" "p70 S6K-beta" "p70 S6KB" "p70-beta"))
<<<<<<< .mine
(define-protein "KS6B2_HUMAN" ("S6k" "Ribosomal protein S6 kinase beta-2" "S6K-beta-2" "S6K2" "70 kDa ribosomal protein S6 kinase 2" "P70S6K2" "p70-S6K 2" "S6 kinase-related kinase" "SRK" "Serine/threonine-protein kinase 14B" "p70 ribosomal S6 kinase beta" "S6K-beta" "p70 S6 kinase beta" "p70 S6K-beta" "p70 S6KB" "p70-beta"))
(define-protein "LAMB1_HUMAN" ("laminin-1" "Laminin subunit beta-1" "Laminin B1 chain" "Laminin-1 subunit beta" "Laminin-10 subunit beta" "Laminin-12 subunit beta" "Laminin-2 subunit beta" "Laminin-6 subunit beta" "Laminin-8 subunit beta"))
=======
<<<<<<< .mine
(define-protein "KS6B2_HUMAN" ("S6k" "Ribosomal protein S6 kinase beta-2" "S6K-beta-2" "S6K2" "70 kDa ribosomal protein S6 kinase 2" "P70S6K2" "p70-S6K 2" "S6 kinase-related kinase" "SRK" "Serine/threonine-protein kinase 14B" "p70 ribosomal S6 kinase beta" "S6K-beta" "p70 S6 kinase beta" "p70 S6K-beta" "p70 S6KB" "p70-beta"))
(define-protein "LAMB1_HUMAN" ("laminin-1" "Laminin subunit beta-1" "Laminin B1 chain" "Laminin-1 subunit beta" "Laminin-10 subunit beta" "Laminin-12 subunit beta" "Laminin-2 subunit beta" "Laminin-6 subunit beta" "Laminin-8 subunit beta"))
=======
(define-protein "LAMB1_HUMAN" ("Laminin subunit beta-1" "Laminin B1 chain" "Laminin-1 subunit beta" "Laminin-10 subunit beta" "Laminin-12 subunit beta" "Laminin-2 subunit beta" "Laminin-6 subunit beta" "Laminin-8 subunit beta"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "LAMP1_HUMAN" ("LAMP1" "LAMP-1" "CD107a")) 
(define-protein "LAMP2_HUMAN" ("LAMP2" "LAMP-2" "CD107b")) 
(define-protein "LAP2_HUMAN" ("ERBIN" "Erbin" "LAP2" "ERBB2IP" "KIAA1225")) 
(define-protein "LBR_HUMAN" ("LMN2R" "LBR")) 
<<<<<<< .mine
(define-protein "LCK_HUMAN" ("Ly49D" "Tyrosine-protein kinase Lck" "Leukocyte C-terminal Src kinase" "LSK" "Lymphocyte cell-specific protein-tyrosine kinase" "Protein YT16" "Proto-oncogene Lck" "T cell-specific protein-tyrosine kinase" "p56-LCK"))
(define-protein "LCP2_HUMAN" ("SLP-76" "Lymphocyte cytosolic protein 2" "SH2 domain-containing leukocyte protein of 76 kDa" "SLP-76 tyrosine phosphoprotein" "SLP76"))
=======
<<<<<<< .mine
(define-protein "LCK_HUMAN" ("Ly49D" "Tyrosine-protein kinase Lck" "Leukocyte C-terminal Src kinase" "LSK" "Lymphocyte cell-specific protein-tyrosine kinase" "Protein YT16" "Proto-oncogene Lck" "T cell-specific protein-tyrosine kinase" "p56-LCK"))
(define-protein "LCP2_HUMAN" ("SLP-76" "Lymphocyte cytosolic protein 2" "SH2 domain-containing leukocyte protein of 76 kDa" "SLP-76 tyrosine phosphoprotein" "SLP76"))
=======
(define-protein "LCK_HUMAN" ("Tyrosine-protein kinase Lck" "Leukocyte C-terminal Src kinase" "LSK" "Lymphocyte cell-specific protein-tyrosine kinase" "Protein YT16" "Proto-oncogene Lck" "T cell-specific protein-tyrosine kinase" "p56-LCK"))
(define-protein "LCP2_HUMAN" ("Lymphocyte cytosolic protein 2" "SH2 domain-containing leukocyte protein of 76 kDa" "SLP-76 tyrosine phosphoprotein" "SLP76"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "LDHA_HUMAN" ("LDHA" "LDH-M" "LDH-A")) 
<<<<<<< .mine
(define-protein "LEF1_HUMAN" ("TLE/Groucho" "Lymphoid enhancer-binding factor 1" "LEF-1" "T cell-specific transcription factor 1-alpha" "TCF1-alpha"))
=======
<<<<<<< .mine
(define-protein "LEF1_HUMAN" ("TLE/Groucho" "Lymphoid enhancer-binding factor 1" "LEF-1" "T cell-specific transcription factor 1-alpha" "TCF1-alpha"))
=======
(define-protein "LEF1_HUMAN" ("Lymphoid enhancer-binding factor 1" "LEF-1" "T cell-specific transcription factor 1-alpha" "TCF1-alpha"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "LEG4_HUMAN" ("Gal-4" "LGALS4" "L36LBP")) 
<<<<<<< .mine
(define-protein "LEPR_HUMAN" ("binding/activation" "Leptin receptor" "LEP-R" "HuB219" "OB receptor" "OB-R"))
=======
<<<<<<< .mine
(define-protein "LEPR_HUMAN" ("binding/activation" "Leptin receptor" "LEP-R" "HuB219" "OB receptor" "OB-R"))
=======
(define-protein "LEPR_HUMAN" ("Leptin receptor" "LEP-R" "HuB219" "OB receptor" "OB-R"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "LGMN_HUMAN" ("PRSC1" "LGMN")) 
(define-protein "LGR5_HUMAN" ("GPR49" "GPR67" "LGR5")) 
<<<<<<< .mine
(define-protein "LHX6_HUMAN" ("Lhx6" "LIM/homeobox protein Lhx6" "LIM homeobox protein 6" "LIM/homeobox protein Lhx6.1"))
=======
<<<<<<< .mine
(define-protein "LHX6_HUMAN" ("Lhx6" "LIM/homeobox protein Lhx6" "LIM homeobox protein 6" "LIM/homeobox protein Lhx6.1"))
=======
(define-protein "LHX6_HUMAN" ("LIM/homeobox protein Lhx6" "LIM homeobox protein 6" "LIM/homeobox protein Lhx6.1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "LIN7C_HUMAN" ("Veli-3" "LIN7C" "Lin-7C" "MALS-3" "VELI3" "MALS3")) 
<<<<<<< .mine
(define-protein "LIPA1_HUMAN" ("ptprf" "Liprin-alpha-1" "LAR-interacting protein 1" "LIP-1" "Protein tyrosine phosphatase receptor type f polypeptide-interacting protein alpha-1" "PTPRF-interacting protein alpha-1"))
(define-protein "LIPL_HUMAN" ("lpl" "Lipoprotein lipase" "LPL"))
(define-protein "LIRB1_HUMAN" ("miR-7" "Leukocyte immunoglobulin-like receptor subfamily B member 1" "LIR-1" "Leukocyte immunoglobulin-like receptor 1" "CD85 antigen-like family member J" "Immunoglobulin-like transcript 2" "ILT-2" "Monocyte/macrophage immunoglobulin-like receptor 7" "MIR-7"))
(define-protein "LKHA4_HUMAN" ("lta" "Leukotriene A-4 hydrolase" "LTA-4 hydrolase" "Leukotriene A(4) hydrolase"))
(define-protein "LMNB1_HUMAN" ("lamins" "Lamin-B1"))
=======
<<<<<<< .mine
(define-protein "LIPA1_HUMAN" ("ptprf" "Liprin-alpha-1" "LAR-interacting protein 1" "LIP-1" "Protein tyrosine phosphatase receptor type f polypeptide-interacting protein alpha-1" "PTPRF-interacting protein alpha-1"))
(define-protein "LIPL_HUMAN" ("lpl" "Lipoprotein lipase" "LPL"))
(define-protein "LIRB1_HUMAN" ("miR-7" "Leukocyte immunoglobulin-like receptor subfamily B member 1" "LIR-1" "Leukocyte immunoglobulin-like receptor 1" "CD85 antigen-like family member J" "Immunoglobulin-like transcript 2" "ILT-2" "Monocyte/macrophage immunoglobulin-like receptor 7" "MIR-7"))
(define-protein "LKHA4_HUMAN" ("lta" "Leukotriene A-4 hydrolase" "LTA-4 hydrolase" "Leukotriene A(4) hydrolase"))
(define-protein "LMNB1_HUMAN" ("lamins" "Lamin-B1"))
=======
(define-protein "LIPA1_HUMAN" ("Liprin-alpha-1" "LAR-interacting protein 1" "LIP-1" "Protein tyrosine phosphatase receptor type f polypeptide-interacting protein alpha-1" "PTPRF-interacting protein alpha-1"))
(define-protein "LIPL_HUMAN" ("Lipoprotein lipase" "LPL"))
(define-protein "LIRB1_HUMAN" ("Leukocyte immunoglobulin-like receptor subfamily B member 1" "LIR-1" "Leukocyte immunoglobulin-like receptor 1" "CD85 antigen-like family member J" "Immunoglobulin-like transcript 2" "ILT-2" "Monocyte/macrophage immunoglobulin-like receptor 7" "MIR-7"))
(define-protein "LKHA4_HUMAN" ("Leukotriene A-4 hydrolase" "LTA-4 hydrolase" "Leukotriene A(4) hydrolase"))
(define-protein "LMNB1_HUMAN" ("Lamin-B1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "LMO7_HUMAN" ("LMO7" "LOMP" "FBX20" "LMO-7" "KIAA0858" "FBXO20")) 
<<<<<<< .mine
(define-protein "LMP1_EBVB9" ("LMP1" "Latent membrane protein 1" "LMP-1" "Protein p63"))
(define-protein "LN28A_HUMAN" ("miR-125a" "Protein lin-28 homolog A" "Lin-28A" "Zinc finger CCHC domain-containing protein 1"))
(define-protein "LN28B_HUMAN" ("miR-21" "Protein lin-28 homolog B" "Lin-28B"))
(define-protein "LOX12_HUMAN" ("lo" "Arachidonate 12-lipoxygenase, 12S-type" "12S-LOX" "12S-lipoxygenase" "Lipoxin synthase 12-LO" "Platelet-type lipoxygenase 12"))
(define-protein "LPPRC_HUMAN" ("lrpprc" "Leucine-rich PPR motif-containing protein, mitochondrial" "130 kDa leucine-rich protein" "LRP 130" "GP130"))
(define-protein "LPXN_HUMAN" ("osteoclasts" "Leupaxin"))
=======
<<<<<<< .mine
(define-protein "LMP1_EBVB9" ("LMP1" "Latent membrane protein 1" "LMP-1" "Protein p63"))
(define-protein "LN28A_HUMAN" ("miR-125a" "Protein lin-28 homolog A" "Lin-28A" "Zinc finger CCHC domain-containing protein 1"))
(define-protein "LN28B_HUMAN" ("miR-21" "Protein lin-28 homolog B" "Lin-28B"))
(define-protein "LOX12_HUMAN" ("lo" "Arachidonate 12-lipoxygenase, 12S-type" "12S-LOX" "12S-lipoxygenase" "Lipoxin synthase 12-LO" "Platelet-type lipoxygenase 12"))
(define-protein "LPPRC_HUMAN" ("lrpprc" "Leucine-rich PPR motif-containing protein, mitochondrial" "130 kDa leucine-rich protein" "LRP 130" "GP130"))
(define-protein "LPXN_HUMAN" ("osteoclasts" "Leupaxin"))
=======
(define-protein "LMP1_EBVB9" ("Latent membrane protein 1" "LMP-1" "Protein p63"))
(define-protein "LN28A_HUMAN" ("Protein lin-28 homolog A" "Lin-28A" "Zinc finger CCHC domain-containing protein 1"))
(define-protein "LN28B_HUMAN" ("Protein lin-28 homolog B" "Lin-28B"))
(define-protein "LOX12_HUMAN" ("Arachidonate 12-lipoxygenase, 12S-type" "12S-LOX" "12S-lipoxygenase" "Lipoxin synthase 12-LO" "Platelet-type lipoxygenase 12"))
(define-protein "LPPRC_HUMAN" ("Leucine-rich PPR motif-containing protein, mitochondrial" "130 kDa leucine-rich protein" "LRP 130" "GP130"))
(define-protein "LPXN_HUMAN" ("Leupaxin"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "LRBA_HUMAN" ("LRBA" "BGL" "CDC4L" "LBA")) 
(define-protein "LRCH4_HUMAN" ("LRCH4" "LRRN4" "LRRN1" "LRN")) 
(define-protein "LRP10_HUMAN" ("LRP-10" "LRP10")) 
(define-protein "LRP1_HUMAN" ("Prolow-density lipoprotein receptor-related protein 1" "LRP-1" "Alpha-2-macroglobulin receptor" "A2MR" "Apolipoprotein E receptor" "APOER"))
(define-protein "LRP6_HUMAN" ("Low-density lipoprotein receptor-related protein 6" "LRP-6"))
(define-protein "LRRK2_HUMAN" ("Leucine-rich repeat serine/threonine-protein kinase 2" "Dardarin"))
(define-protein "LSG1_HUMAN" ("hLsg1" "LSG1")) 
<<<<<<< .mine
(define-protein "LST8_HUMAN" ("Lst8" "Target of rapamycin complex subunit LST8" "TORC subunit LST8" "G protein beta subunit-like" "Gable" "Protein GbetaL" "Mammalian lethal with SEC13 protein 8" "mLST8"))
=======
<<<<<<< .mine
(define-protein "LST8_HUMAN" ("Lst8" "Target of rapamycin complex subunit LST8" "TORC subunit LST8" "G protein beta subunit-like" "Gable" "Protein GbetaL" "Mammalian lethal with SEC13 protein 8" "mLST8"))
=======
(define-protein "LST8_HUMAN" ("Target of rapamycin complex subunit LST8" "TORC subunit LST8" "G protein beta subunit-like" "Gable" "Protein GbetaL" "Mammalian lethal with SEC13 protein 8" "mLST8"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "LTOR3_HUMAN" ("MAPKSP1" "Mp1" "MAP2K1IP1" "LAMTOR3")) 
<<<<<<< .mine
(define-protein "LY6E_HUMAN" ("tsa" "Lymphocyte antigen 6E" "Ly-6E" "Retinoic acid-induced gene E protein" "RIG-E" "Stem cell antigen 2" "SCA-2" "Thymic shared antigen 1" "TSA-1"))
=======
<<<<<<< .mine
(define-protein "LY6E_HUMAN" ("tsa" "Lymphocyte antigen 6E" "Ly-6E" "Retinoic acid-induced gene E protein" "RIG-E" "Stem cell antigen 2" "SCA-2" "Thymic shared antigen 1" "TSA-1"))
=======
(define-protein "LY6E_HUMAN" ("Lymphocyte antigen 6E" "Ly-6E" "Retinoic acid-induced gene E protein" "RIG-E" "Stem cell antigen 2" "SCA-2" "Thymic shared antigen 1" "TSA-1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "LYAG_HUMAN" ("GAA")) 
<<<<<<< .mine
(define-protein "LYAM1_HUMAN" ("L-selectin" "CD62 antigen-like family member L" "Leukocyte adhesion molecule 1" "LAM-1" "Leukocyte surface antigen Leu-8" "Leukocyte-endothelial cell adhesion molecule 1" "LECAM1" "Lymph node homing receptor" "TQ1" "gp90-MEL"))
(define-protein "LYAM2_HUMAN" ("E-selectin" "CD62 antigen-like family member E" "Endothelial leukocyte adhesion molecule 1" "ELAM-1" "Leukocyte-endothelial cell adhesion molecule 2" "LECAM2"))
(define-protein "LYN_HUMAN" ("SU6656" "Tyrosine-protein kinase Lyn" "Lck/Yes-related novel protein tyrosine kinase" "V-yes-1 Yamaguchi sarcoma viral related oncogene homolog" "p53Lyn" "p56Lyn"))
(define-protein "LYPD3_HUMAN" ("matrigel" "Ly6/PLAUR domain-containing protein 3" "GPI-anchored metastasis-associated protein C4.4A homolog" "Matrigel-induced gene C4 protein" "MIG-C4"))
(define-protein "M0QXZ8_HUMAN" ("elegans" "Rho GTPase-activating protein SYDE1" "Synapse defective 1, Rho GTPase, homolog 1 (C. elegans), isoform CRA_a"))
=======
<<<<<<< .mine
(define-protein "LYAM1_HUMAN" ("L-selectin" "CD62 antigen-like family member L" "Leukocyte adhesion molecule 1" "LAM-1" "Leukocyte surface antigen Leu-8" "Leukocyte-endothelial cell adhesion molecule 1" "LECAM1" "Lymph node homing receptor" "TQ1" "gp90-MEL"))
(define-protein "LYAM2_HUMAN" ("E-selectin" "CD62 antigen-like family member E" "Endothelial leukocyte adhesion molecule 1" "ELAM-1" "Leukocyte-endothelial cell adhesion molecule 2" "LECAM2"))
(define-protein "LYN_HUMAN" ("SU6656" "Tyrosine-protein kinase Lyn" "Lck/Yes-related novel protein tyrosine kinase" "V-yes-1 Yamaguchi sarcoma viral related oncogene homolog" "p53Lyn" "p56Lyn"))
(define-protein "LYPD3_HUMAN" ("matrigel" "Ly6/PLAUR domain-containing protein 3" "GPI-anchored metastasis-associated protein C4.4A homolog" "Matrigel-induced gene C4 protein" "MIG-C4"))
(define-protein "M0QXZ8_HUMAN" ("elegans" "Rho GTPase-activating protein SYDE1" "Synapse defective 1, Rho GTPase, homolog 1 (C. elegans), isoform CRA_a"))
=======
(define-protein "LYAM1_HUMAN" ("L-selectin" "CD62 antigen-like family member L" "Leukocyte adhesion molecule 1" "LAM-1" "Leukocyte surface antigen Leu-8" "Leukocyte-endothelial cell adhesion molecule 1" "LECAM1" "Lymph node homing receptor" "TQ1" "gp90-MEL"))
(define-protein "LYAM2_HUMAN" ("E-selectin" "CD62 antigen-like family member E" "Endothelial leukocyte adhesion molecule 1" "ELAM-1" "Leukocyte-endothelial cell adhesion molecule 2" "LECAM2"))
(define-protein "LYN_HUMAN" ("Tyrosine-protein kinase Lyn" "Lck/Yes-related novel protein tyrosine kinase" "V-yes-1 Yamaguchi sarcoma viral related oncogene homolog" "p53Lyn" "p56Lyn"))
(define-protein "LYPD3_HUMAN" ("Ly6/PLAUR domain-containing protein 3" "GPI-anchored metastasis-associated protein C4.4A homolog" "Matrigel-induced gene C4 protein" "MIG-C4"))
(define-protein "M0QXZ8_HUMAN" ("Rho GTPase-activating protein SYDE1" "Synapse defective 1, Rho GTPase, homolog 1 (C. elegans), isoform CRA_a"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "M2OM_HUMAN" ("OGCP" "SLC20A4" "SLC25A11")) 
<<<<<<< .mine
(define-protein "M3K11_HUMAN" ("Src-homology" "Mitogen-activated protein kinase kinase kinase 11" "Mixed lineage kinase 3" "Src-homology 3 domain-containing proline-rich kinase"))
(define-protein "M3K8_HUMAN" ("Tpl-2" "Mitogen-activated protein kinase kinase kinase 8" "Cancer Osaka thyroid oncogene" "Proto-oncogene c-Cot" "Serine/threonine-protein kinase cot" "Tumor progression locus 2" "TPL-2"))
(define-protein "M4K1_HUMAN" ("HPK-1" "Mitogen-activated protein kinase kinase kinase kinase 1" "Hematopoietic progenitor kinase" "MAPK/ERK kinase kinase kinase 1" "MEK kinase kinase 1" "MEKKK 1"))
=======
<<<<<<< .mine
(define-protein "M3K11_HUMAN" ("Src-homology" "Mitogen-activated protein kinase kinase kinase 11" "Mixed lineage kinase 3" "Src-homology 3 domain-containing proline-rich kinase"))
(define-protein "M3K8_HUMAN" ("Tpl-2" "Mitogen-activated protein kinase kinase kinase 8" "Cancer Osaka thyroid oncogene" "Proto-oncogene c-Cot" "Serine/threonine-protein kinase cot" "Tumor progression locus 2" "TPL-2"))
(define-protein "M4K1_HUMAN" ("HPK-1" "Mitogen-activated protein kinase kinase kinase kinase 1" "Hematopoietic progenitor kinase" "MAPK/ERK kinase kinase kinase 1" "MEK kinase kinase 1" "MEKKK 1"))
=======
(define-protein "M3K11_HUMAN" ("Mitogen-activated protein kinase kinase kinase 11" "Mixed lineage kinase 3" "Src-homology 3 domain-containing proline-rich kinase"))
(define-protein "M3K8_HUMAN" ("Mitogen-activated protein kinase kinase kinase 8" "Cancer Osaka thyroid oncogene" "Proto-oncogene c-Cot" "Serine/threonine-protein kinase cot" "Tumor progression locus 2" "TPL-2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "M4K1_HUMAN" ("Mitogen-activated protein kinase kinase kinase kinase 1" "Hematopoietic progenitor kinase" "MAPK/ERK kinase kinase kinase 1" "MEK kinase kinase 1" "MEKKK 1"))
<<<<<<< .mine
(define-protein "MA2B1_HUMAN" ("wildtype" "Lysosomal alpha-mannosidase" "Laman" "Lysosomal acid alpha-mannosidase" "Mannosidase alpha class 2B member 1" "Mannosidase alpha-B"))
(define-protein "MAD4_HUMAN" ("Mad4" "Max dimerization protein 4" "Max dimerizer 4" "Class C basic helix-loop-helix protein 12" "bHLHc12" "Max-associated protein 4" "Max-interacting transcriptional repressor MAD4"))
(define-protein "MAF1_HUMAN" ("weaker" "Repressor of RNA polymerase III transcription MAF1 homolog"))
(define-protein "MAFA_HUMAN" ("β-cell" "Transcription factor MafA" "Pancreatic beta-cell-specific transcriptional activator" "Transcription factor RIPE3b1" "V-maf musculoaponeurotic fibrosarcoma oncogene homolog A"))
(define-protein "MAFB_HUMAN" ("mafb" "Transcription factor MafB" "Maf-B" "V-maf musculoaponeurotic fibrosarcoma oncogene homolog B"))
(define-protein "MAF_HUMAN" ("tbhq" "Transcription factor Maf" "Proto-oncogene c-Maf" "V-maf musculoaponeurotic fibrosarcoma oncogene homolog"))
(define-protein "MAGF1_HUMAN" ("F1" "Melanoma-associated antigen F1" "MAGE-F1 antigen"))
=======
<<<<<<< .mine
(define-protein "MA2B1_HUMAN" ("wildtype" "Lysosomal alpha-mannosidase" "Laman" "Lysosomal acid alpha-mannosidase" "Mannosidase alpha class 2B member 1" "Mannosidase alpha-B"))
(define-protein "MAD4_HUMAN" ("Mad4" "Max dimerization protein 4" "Max dimerizer 4" "Class C basic helix-loop-helix protein 12" "bHLHc12" "Max-associated protein 4" "Max-interacting transcriptional repressor MAD4"))
(define-protein "MAF1_HUMAN" ("weaker" "Repressor of RNA polymerase III transcription MAF1 homolog"))
(define-protein "MAFA_HUMAN" ("β-cell" "Transcription factor MafA" "Pancreatic beta-cell-specific transcriptional activator" "Transcription factor RIPE3b1" "V-maf musculoaponeurotic fibrosarcoma oncogene homolog A"))
(define-protein "MAFB_HUMAN" ("mafb" "Transcription factor MafB" "Maf-B" "V-maf musculoaponeurotic fibrosarcoma oncogene homolog B"))
(define-protein "MAF_HUMAN" ("tbhq" "Transcription factor Maf" "Proto-oncogene c-Maf" "V-maf musculoaponeurotic fibrosarcoma oncogene homolog"))
(define-protein "MAGF1_HUMAN" ("F1" "Melanoma-associated antigen F1" "MAGE-F1 antigen"))
=======
(define-protein "MA2B1_HUMAN" ("Lysosomal alpha-mannosidase" "Laman" "Lysosomal acid alpha-mannosidase" "Mannosidase alpha class 2B member 1" "Mannosidase alpha-B"))
(define-protein "MAD4_HUMAN" ("Max dimerization protein 4" "Max dimerizer 4" "Class C basic helix-loop-helix protein 12" "bHLHc12" "Max-associated protein 4" "Max-interacting transcriptional repressor MAD4"))
(define-protein "MAF1_HUMAN" ("Repressor of RNA polymerase III transcription MAF1 homolog"))
(define-protein "MAFA_HUMAN" ("Transcription factor MafA" "Pancreatic beta-cell-specific transcriptional activator" "Transcription factor RIPE3b1" "V-maf musculoaponeurotic fibrosarcoma oncogene homolog A"))
(define-protein "MAFB_HUMAN" ("Transcription factor MafB" "Maf-B" "V-maf musculoaponeurotic fibrosarcoma oncogene homolog B"))
(define-protein "MAF_HUMAN" ("Transcription factor Maf" "Proto-oncogene c-Maf" "V-maf musculoaponeurotic fibrosarcoma oncogene homolog"))
(define-protein "MAGF1_HUMAN" ("Melanoma-associated antigen F1" "MAGE-F1 antigen"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "MAGG1_HUMAN" ("MAGEG1" "NDNL2" "HCA4")) 
<<<<<<< .mine
(define-protein "MAGI1_HUMAN" ("S-SCAM" "Membrane-associated guanylate kinase, WW and PDZ domain-containing protein 1" "Atrophin-1-interacting protein 3" "AIP-3" "BAI1-associated protein 1" "BAP-1" "Membrane-associated guanylate kinase inverted 1" "MAGI-1" "Trinucleotide repeat-containing gene 19 protein" "WW domain-containing protein 3" "WWP3"))
=======
<<<<<<< .mine
(define-protein "MAGI1_HUMAN" ("S-SCAM" "Membrane-associated guanylate kinase, WW and PDZ domain-containing protein 1" "Atrophin-1-interacting protein 3" "AIP-3" "BAI1-associated protein 1" "BAP-1" "Membrane-associated guanylate kinase inverted 1" "MAGI-1" "Trinucleotide repeat-containing gene 19 protein" "WW domain-containing protein 3" "WWP3"))
=======
(define-protein "MAGI1_HUMAN" ("Membrane-associated guanylate kinase, WW and PDZ domain-containing protein 1" "Atrophin-1-interacting protein 3" "AIP-3" "BAI1-associated protein 1" "BAP-1" "Membrane-associated guanylate kinase inverted 1" "MAGI-1" "Trinucleotide repeat-containing gene 19 protein" "WW domain-containing protein 3" "WWP3"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "MAN1_HUMAN" ("LEMD3" "MAN1")) 
<<<<<<< .mine
(define-protein "MAOM_HUMAN" ("abts" "NAD-dependent malic enzyme, mitochondrial" "NAD-ME" "Malic enzyme 2"))
=======
<<<<<<< .mine
(define-protein "MAOM_HUMAN" ("abts" "NAD-dependent malic enzyme, mitochondrial" "NAD-ME" "Malic enzyme 2"))
=======
(define-protein "MAOM_HUMAN" ("NAD-dependent malic enzyme, mitochondrial" "NAD-ME" "Malic enzyme 2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "MAP1S_HUMAN" ("MAP-1S" "VCY2IP-1" "C19orf5" "MAP1S" "MAP8" "BPY2IP1" "VCY2IP1")) 
(define-protein "MAPK2_HUMAN" ("MAPKAPK-2" "MK-2" "MK2" "MAPKAP-K2" "MAPKAPK2")) 
(define-protein "MAPK3_HUMAN" ("MAPKAPK-3" "MK-3" "MAPKAPK3" "3pK" "MAPKAP-K3")) 
(define-protein "MAPK5_HUMAN" ("MK-5" "MAPKAP-K5" "MAPKAPK-5" "MAPKAPK5" "PRAK" "MK5")) 
(define-protein "MARE1_HUMAN" ("MAPRE1" "EB1")) 
(define-protein "MARK2_HUMAN" ("MARK2" "EMK1" "Par1b" "EMK-1" "Par-1b")) 
<<<<<<< .mine
(define-protein "MASP1_HUMAN" ("serine-" "Mannan-binding lectin serine protease 1" "Complement factor MASP-3" "Complement-activating component of Ra-reactive factor" "Mannose-binding lectin-associated serine protease 1" "MASP-1" "Mannose-binding protein-associated serine protease" "Ra-reactive factor serine protease p100" "RaRF" "Serine protease 5"))
(define-protein "MAX_HUMAN" ("Myc/Max" "Protein max" "Class D basic helix-loop-helix protein 4" "bHLHd4" "Myc-associated factor X"))
=======
<<<<<<< .mine
(define-protein "MASP1_HUMAN" ("serine-" "Mannan-binding lectin serine protease 1" "Complement factor MASP-3" "Complement-activating component of Ra-reactive factor" "Mannose-binding lectin-associated serine protease 1" "MASP-1" "Mannose-binding protein-associated serine protease" "Ra-reactive factor serine protease p100" "RaRF" "Serine protease 5"))
(define-protein "MAX_HUMAN" ("Myc/Max" "Protein max" "Class D basic helix-loop-helix protein 4" "bHLHd4" "Myc-associated factor X"))
=======
(define-protein "MASP1_HUMAN" ("Mannan-binding lectin serine protease 1" "Complement factor MASP-3" "Complement-activating component of Ra-reactive factor" "Mannose-binding lectin-associated serine protease 1" "MASP-1" "Mannose-binding protein-associated serine protease" "Ra-reactive factor serine protease p100" "RaRF" "Serine protease 5"))
(define-protein "MAX_HUMAN" ("Protein max" "Class D basic helix-loop-helix protein 4" "bHLHd4" "Myc-associated factor X"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "MB12A_HUMAN" ("CFBP" "MVB12A" "FAM125A")) 
<<<<<<< .mine
(define-protein "MBD2_HUMAN" ("p66α" "Methyl-CpG-binding domain protein 2" "Demethylase" "DMTase" "Methyl-CpG-binding protein MBD2"))
(define-protein "MCEL_VAR67" ("mrna" "mRNA-capping enzyme catalytic subunit" "Virus termination factor large subunit" "VTF large subunit" "mRNA-capping enzyme 97 kDa subunit" "mRNA-capping enzyme D1 subunit" "mRNA-capping enzyme large subunit"))
=======
<<<<<<< .mine
(define-protein "MBD2_HUMAN" ("p66α" "Methyl-CpG-binding domain protein 2" "Demethylase" "DMTase" "Methyl-CpG-binding protein MBD2"))
(define-protein "MCEL_VAR67" ("mrna" "mRNA-capping enzyme catalytic subunit" "Virus termination factor large subunit" "VTF large subunit" "mRNA-capping enzyme 97 kDa subunit" "mRNA-capping enzyme D1 subunit" "mRNA-capping enzyme large subunit"))
=======
(define-protein "MBD2_HUMAN" ("Methyl-CpG-binding domain protein 2" "Demethylase" "DMTase" "Methyl-CpG-binding protein MBD2"))
(define-protein "MCEL_VAR67" ("mRNA-capping enzyme catalytic subunit" "Virus termination factor large subunit" "VTF large subunit" "mRNA-capping enzyme 97 kDa subunit" "mRNA-capping enzyme D1 subunit" "mRNA-capping enzyme large subunit"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "MCL1_HUMAN" ("Induced myeloid leukemia cell differentiation protein Mcl-1" "Bcl-2-like protein 3" "Bcl2-L-3" "Bcl-2-related protein EAT/mcl1" "mcl1/EAT"))
(define-protein "MCL1_HUMAN" ("Mcl-1" "Induced myeloid leukemia cell differentiation protein Mcl-1" "Bcl-2-like protein 3" "Bcl2-L-3" "Bcl-2-related protein EAT/mcl1" "mcl1/EAT"))
(define-protein "MCM2_HUMAN" ("CCNL1" "KIAA0030" "CDCL1" "MCM2" "BM28")) 
<<<<<<< .mine
(define-protein "MCM3_HUMAN" ("holoenzyme" "DNA replication licensing factor MCM3" "DNA polymerase alpha holoenzyme-associated protein P1" "P1-MCM3" "RLF subunit beta" "p102"))
=======
<<<<<<< .mine
(define-protein "MCM3_HUMAN" ("holoenzyme" "DNA replication licensing factor MCM3" "DNA polymerase alpha holoenzyme-associated protein P1" "P1-MCM3" "RLF subunit beta" "p102"))
=======
(define-protein "MCM3_HUMAN" ("DNA replication licensing factor MCM3" "DNA polymerase alpha holoenzyme-associated protein P1" "P1-MCM3" "RLF subunit beta" "p102"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "MD2L1_HUMAN" ("MAD2" "HsMAD2" "MAD2L1")) 
(define-protein "MDM2_HUMAN" ("MDM2" "Hdm2")) 
<<<<<<< .mine
(define-protein "MDM4_HUMAN" ("mdmx" "Protein Mdm4" "Double minute 4 protein" "Mdm2-like p53-binding protein" "Protein Mdmx" "p53-binding protein Mdm4"))
(define-protein "MDR1_HUMAN" ("MDR-1" "Multidrug resistance protein 1" "ATP-binding cassette sub-family B member 1" "P-glycoprotein 1"))
=======
<<<<<<< .mine
(define-protein "MDM4_HUMAN" ("mdmx" "Protein Mdm4" "Double minute 4 protein" "Mdm2-like p53-binding protein" "Protein Mdmx" "p53-binding protein Mdm4"))
(define-protein "MDR1_HUMAN" ("MDR-1" "Multidrug resistance protein 1" "ATP-binding cassette sub-family B member 1" "P-glycoprotein 1"))
=======
(define-protein "MDM4_HUMAN" ("Protein Mdm4" "Double minute 4 protein" "Mdm2-like p53-binding protein" "Protein Mdmx" "p53-binding protein Mdm4"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "MDR1_HUMAN" ("Multidrug resistance protein 1" "ATP-binding cassette sub-family B member 1" "P-glycoprotein 1"))
<<<<<<< .mine
(define-protein "MED1_HUMAN" ("TRAP220" "Mediator of RNA polymerase II transcription subunit 1" "Activator-recruited cofactor 205 kDa component" "ARC205" "Mediator complex subunit 1" "Peroxisome proliferator-activated receptor-binding protein" "PBP" "PPAR-binding protein" "Thyroid hormone receptor-associated protein complex 220 kDa component" "Trap220" "Thyroid receptor-interacting protein 2" "TR-interacting protein 2" "TRIP-2" "Vitamin D receptor-interacting protein complex component DRIP205" "p53 regulatory protein RB18A"))
(define-protein "MEF2C_HUMAN" ("Mef2C" "Myocyte-specific enhancer factor 2C"))
(define-protein "MEI1_HUMAN" ("Mei1" "Meiosis inhibitor protein 1" "Meiosis defective protein 1"))
(define-protein "MEN1_HUMAN" ("menin" "Menin"))
(define-protein "MEOX2_HUMAN" ("gax" "Homeobox protein MOX-2" "Growth arrest-specific homeobox" "Mesenchyme homeobox 2"))
=======
<<<<<<< .mine
(define-protein "MED1_HUMAN" ("TRAP220" "Mediator of RNA polymerase II transcription subunit 1" "Activator-recruited cofactor 205 kDa component" "ARC205" "Mediator complex subunit 1" "Peroxisome proliferator-activated receptor-binding protein" "PBP" "PPAR-binding protein" "Thyroid hormone receptor-associated protein complex 220 kDa component" "Trap220" "Thyroid receptor-interacting protein 2" "TR-interacting protein 2" "TRIP-2" "Vitamin D receptor-interacting protein complex component DRIP205" "p53 regulatory protein RB18A"))
(define-protein "MEF2C_HUMAN" ("Mef2C" "Myocyte-specific enhancer factor 2C"))
(define-protein "MEI1_HUMAN" ("Mei1" "Meiosis inhibitor protein 1" "Meiosis defective protein 1"))
(define-protein "MEN1_HUMAN" ("menin" "Menin"))
(define-protein "MEOX2_HUMAN" ("gax" "Homeobox protein MOX-2" "Growth arrest-specific homeobox" "Mesenchyme homeobox 2"))
=======
(define-protein "MED1_HUMAN" ("Mediator of RNA polymerase II transcription subunit 1" "Activator-recruited cofactor 205 kDa component" "ARC205" "Mediator complex subunit 1" "Peroxisome proliferator-activated receptor-binding protein" "PBP" "PPAR-binding protein" "Thyroid hormone receptor-associated protein complex 220 kDa component" "Trap220" "Thyroid receptor-interacting protein 2" "TR-interacting protein 2" "TRIP-2" "Vitamin D receptor-interacting protein complex component DRIP205" "p53 regulatory protein RB18A"))
(define-protein "MEF2C_HUMAN" ("Myocyte-specific enhancer factor 2C"))
(define-protein "MEI1_HUMAN" ("Meiosis inhibitor protein 1" "Meiosis defective protein 1"))
(define-protein "MEN1_HUMAN" ("Menin"))
(define-protein "MEOX2_HUMAN" ("Homeobox protein MOX-2" "Growth arrest-specific homeobox" "Mesenchyme homeobox 2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "MERL_HUMAN" ("Neurofibromin-2" "NF2" "Schwannomerlin" "SCH" "Schwannomin")) 
<<<<<<< .mine
(define-protein "MET_HUMAN" ("cmet" "Hepatocyte growth factor receptor" "HGF receptor" "HGF/SF receptor" "Proto-oncogene c-Met" "Scatter factor receptor" "SF receptor" "Tyrosine-protein kinase Met"))
=======
<<<<<<< .mine
(define-protein "MET_HUMAN" ("cmet" "Hepatocyte growth factor receptor" "HGF receptor" "HGF/SF receptor" "Proto-oncogene c-Met" "Scatter factor receptor" "SF receptor" "Tyrosine-protein kinase Met"))
=======
(define-protein "MET_HUMAN" ("Hepatocyte growth factor receptor" "HGF receptor" "HGF/SF receptor" "Proto-oncogene c-Met" "Scatter factor receptor" "SF receptor" "Tyrosine-protein kinase Met"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "MFGM_HUMAN" ("Lactadherin" "Breast epithelial antigen BA46" "HMFG" "MFGM" "Milk fat globule-EGF factor 8" "MFG-E8" "SED1"))
<<<<<<< .mine
(define-protein "MFN1_HUMAN" ("Mfn1" "Mitofusin-1" "Fzo homolog" "Transmembrane GTPase MFN1"))
=======
<<<<<<< .mine
(define-protein "MFN1_HUMAN" ("Mfn1" "Mitofusin-1" "Fzo homolog" "Transmembrane GTPase MFN1"))
=======
(define-protein "MFN1_HUMAN" ("Mitofusin-1" "Fzo homolog" "Transmembrane GTPase MFN1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "MFSD5_HUMAN" ("Molybdate-anion transporter" "Major facilitator superfamily domain-containing protein 5" "Molybdate transporter 2 homolog" "hsMOT2"))
<<<<<<< .mine
(define-protein "MI1HG_HUMAN" ("miR-1" "Uncharacterized protein MIR1-1HG" "MIR1-1 host gene protein"))
=======
<<<<<<< .mine
(define-protein "MI1HG_HUMAN" ("miR-1" "Uncharacterized protein MIR1-1HG" "MIR1-1 host gene protein"))
=======
(define-protein "MI1HG_HUMAN" ("Uncharacterized protein MIR1-1HG" "MIR1-1 host gene protein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "MIF_HUMAN" ("MMIF" "GIF" "MIF" "GLIF")) 
<<<<<<< .mine
(define-protein "MIR2_HHV8P" ("MIR2" "E3 ubiquitin-protein ligase MIR2" "IE1A protein" "Modulator of immune recognition 2" "ORF K5"))
(define-protein "MIRH1_HUMAN" ("microrna" "Putative microRNA 17 host gene protein" "Putative microRNA host gene 1 protein"))
=======
<<<<<<< .mine
(define-protein "MIR2_HHV8P" ("MIR2" "E3 ubiquitin-protein ligase MIR2" "IE1A protein" "Modulator of immune recognition 2" "ORF K5"))
(define-protein "MIRH1_HUMAN" ("microrna" "Putative microRNA 17 host gene protein" "Putative microRNA host gene 1 protein"))
=======
(define-protein "MIR2_HHV8P" ("E3 ubiquitin-protein ligase MIR2" "IE1A protein" "Modulator of immune recognition 2" "ORF K5"))
(define-protein "MIRH1_HUMAN" ("Putative microRNA 17 host gene protein" "Putative microRNA host gene 1 protein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "MIRO1_HUMAN" ("ARHT1" "MIRO-1" "hMiro-1" "RHOT1")) 
(define-protein "MIRO2_HUMAN" ("ARHT2" "MIRO-2" "C16orf39" "RHOT2" "hMiro-2")) 
<<<<<<< .mine
(define-protein "MK03_HUMAN" ("Erk1/2" "Mitogen-activated protein kinase 3" "MAP kinase 3" "MAPK 3" "ERT2" "Extracellular signal-regulated kinase 1" "ERK-1" "Insulin-stimulated MAP2 kinase" "MAP kinase isoform p44" "p44-MAPK" "Microtubule-associated protein 2 kinase" "p44-ERK1"))
=======
<<<<<<< .mine
(define-protein "MK03_HUMAN" ("Erk1/2" "Mitogen-activated protein kinase 3" "MAP kinase 3" "MAPK 3" "ERT2" "Extracellular signal-regulated kinase 1" "ERK-1" "Insulin-stimulated MAP2 kinase" "MAP kinase isoform p44" "p44-MAPK" "Microtubule-associated protein 2 kinase" "p44-ERK1"))
=======
(define-protein "MK03_HUMAN" ("Mitogen-activated protein kinase 3" "MAP kinase 3" "MAPK 3" "ERT2" "Extracellular signal-regulated kinase 1" "ERK-1" "Insulin-stimulated MAP2 kinase" "MAP kinase isoform p44" "p44-MAPK" "Microtubule-associated protein 2 kinase" "p44-ERK1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "MK07_HUMAN" ("ERK5" "PRKM7" "ERK-5" "MAPK7" "BMK1" "BMK-1")) 
<<<<<<< .mine
(define-protein "MK11_HUMAN" ("p-38" "Mitogen-activated protein kinase 11" "MAP kinase 11" "MAPK 11" "Mitogen-activated protein kinase p38 beta" "MAP kinase p38 beta" "p38b" "Stress-activated protein kinase 2b" "SAPK2b" "p38-2"))
=======
<<<<<<< .mine
(define-protein "MK11_HUMAN" ("p-38" "Mitogen-activated protein kinase 11" "MAP kinase 11" "MAPK 11" "Mitogen-activated protein kinase p38 beta" "MAP kinase p38 beta" "p38b" "Stress-activated protein kinase 2b" "SAPK2b" "p38-2"))
=======
(define-protein "MK11_HUMAN" ("Mitogen-activated protein kinase 11" "MAP kinase 11" "MAPK 11" "Mitogen-activated protein kinase p38 beta" "MAP kinase p38 beta" "p38b" "Stress-activated protein kinase 2b" "SAPK2b" "p38-2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "MK13_HUMAN" ("MAPK13" "PRKM13" "SAPK4")) 
(define-protein "MK14_HUMAN" ("CSBP2" "SAPK2A" "MAPK14" "CSPB1" "CSBP1" "SAPK2a" "CSBP" "MXI2")) 
<<<<<<< .mine
(define-protein "MKKS_HUMAN" ("mkks" "McKusick-Kaufman/Bardet-Biedl syndromes putative chaperonin" "Bardet-Biedl syndrome 6 protein"))
=======
<<<<<<< .mine
(define-protein "MKKS_HUMAN" ("mkks" "McKusick-Kaufman/Bardet-Biedl syndromes putative chaperonin" "Bardet-Biedl syndrome 6 protein"))
=======
(define-protein "MKKS_HUMAN" ("McKusick-Kaufman/Bardet-Biedl syndromes putative chaperonin" "Bardet-Biedl syndrome 6 protein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ML12A_HUMAN" ("MYL12A" "HEL-S-24" "MLC-2B" "MRLC3" "RLC" "MLCB")) 
(define-protein "MLH1_HUMAN" ("DNA mismatch repair protein Mlh1" "MutL protein homolog 1"))
<<<<<<< .mine
(define-protein "MLP3A_HUMAN" ("LC3" "Microtubule-associated proteins 1A/1B light chain 3A" "Autophagy-related protein LC3 A" "Autophagy-related ubiquitin-like modifier LC3 A" "MAP1 light chain 3-like protein 1" "MAP1A/MAP1B light chain 3 A" "MAP1A/MAP1B LC3 A" "Microtubule-associated protein 1 light chain 3 alpha"))
(define-protein "MLTK_HUMAN" ("zak" "Mitogen-activated protein kinase kinase kinase MLT" "Human cervical cancer suppressor gene 4 protein" "HCCS-4" "Leucine zipper- and sterile alpha motif-containing kinase" "MLK-like mitogen-activated protein triple kinase" "Mixed lineage kinase-related kinase" "MLK-related kinase" "MRK" "Sterile alpha motif- and leucine zipper-containing kinase AZK"))
(define-protein "MMP13_HUMAN" ("Mmp13" "Collagenase 3" "Matrix metalloproteinase-13" "MMP-13"))
=======
<<<<<<< .mine
(define-protein "MLP3A_HUMAN" ("LC3" "Microtubule-associated proteins 1A/1B light chain 3A" "Autophagy-related protein LC3 A" "Autophagy-related ubiquitin-like modifier LC3 A" "MAP1 light chain 3-like protein 1" "MAP1A/MAP1B light chain 3 A" "MAP1A/MAP1B LC3 A" "Microtubule-associated protein 1 light chain 3 alpha"))
(define-protein "MLTK_HUMAN" ("zak" "Mitogen-activated protein kinase kinase kinase MLT" "Human cervical cancer suppressor gene 4 protein" "HCCS-4" "Leucine zipper- and sterile alpha motif-containing kinase" "MLK-like mitogen-activated protein triple kinase" "Mixed lineage kinase-related kinase" "MLK-related kinase" "MRK" "Sterile alpha motif- and leucine zipper-containing kinase AZK"))
(define-protein "MMP13_HUMAN" ("Mmp13" "Collagenase 3" "Matrix metalloproteinase-13" "MMP-13"))
=======
(define-protein "MLP3A_HUMAN" ("Microtubule-associated proteins 1A/1B light chain 3A" "Autophagy-related protein LC3 A" "Autophagy-related ubiquitin-like modifier LC3 A" "MAP1 light chain 3-like protein 1" "MAP1A/MAP1B light chain 3 A" "MAP1A/MAP1B LC3 A" "Microtubule-associated protein 1 light chain 3 alpha"))
(define-protein "MLTK_HUMAN" ("Mitogen-activated protein kinase kinase kinase MLT" "Human cervical cancer suppressor gene 4 protein" "HCCS-4" "Leucine zipper- and sterile alpha motif-containing kinase" "MLK-like mitogen-activated protein triple kinase" "Mixed lineage kinase-related kinase" "MLK-related kinase" "MRK" "Sterile alpha motif- and leucine zipper-containing kinase AZK"))
(define-protein "MMP13_HUMAN" ("Collagenase 3" "Matrix metalloproteinase-13" "MMP-13"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "MMP2_HUMAN" ("72 kDa type IV collagenase" "72 kDa gelatinase" "Gelatinase A" "Matrix metalloproteinase-2" "MMP-2" "TBE-1"))
<<<<<<< .mine
(define-protein "MMP2_HUMAN" ("Mmp2" "72 kDa type IV collagenase" "72 kDa gelatinase" "Gelatinase A" "Matrix metalloproteinase-2" "MMP-2" "TBE-1"))
(define-protein "MMP3_HUMAN" ("stromelysin-1" "Stromelysin-1" "SL-1" "Matrix metalloproteinase-3" "MMP-3" "Transin-1"))
=======
<<<<<<< .mine
(define-protein "MMP2_HUMAN" ("Mmp2" "72 kDa type IV collagenase" "72 kDa gelatinase" "Gelatinase A" "Matrix metalloproteinase-2" "MMP-2" "TBE-1"))
(define-protein "MMP3_HUMAN" ("stromelysin-1" "Stromelysin-1" "SL-1" "Matrix metalloproteinase-3" "MMP-3" "Transin-1"))
=======
(define-protein "MMP3_HUMAN" ("Stromelysin-1" "SL-1" "Matrix metalloproteinase-3" "MMP-3" "Transin-1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "MMP9_HUMAN" ("Matrix metalloproteinase-9" "MMP-9" "92 kDa gelatinase" "92 kDa type IV collagenase" "Gelatinase B" "GELB"))
(define-protein "MMTA2_HUMAN" ("C1orf35" "MMTAG2" "hMMTAG2")) 
(define-protein "MOB1B_HUMAN" ("MOB1B" "MOBKL1A" "Mob1B" "Mob1A" "MOB4A")) 
(define-protein "MOES_HUMAN" ("MSN")) 
(define-protein "MOGS_HUMAN" ("GCS1" "MOGS")) 
(define-protein "MON2_HUMAN" ("SF21" "KIAA1040" "MON2")) 
<<<<<<< .mine
(define-protein "MOS_HUMAN" ("mos" "Proto-oncogene serine/threonine-protein kinase mos" "Oocyte maturation factor mos" "Proto-oncogene c-Mos"))
(define-protein "MOT4_HUMAN" ("MCT-4" "Monocarboxylate transporter 4" "MCT 4" "Solute carrier family 16 member 3"))
(define-protein "MP2K2_HUMAN" ("mock-" "Dual specificity mitogen-activated protein kinase kinase 2" "MAP kinase kinase 2" "MAPKK 2" "ERK activator kinase 2" "MAPK/ERK kinase 2" "MEK 2"))
(define-protein "MP2K4_HUMAN" ("kinase-1" "Dual specificity mitogen-activated protein kinase kinase 4" "MAP kinase kinase 4" "MAPKK 4" "JNK-activating kinase 1" "MAPK/ERK kinase 4" "MEK 4" "SAPK/ERK kinase 1" "SEK1" "Stress-activated protein kinase kinase 1" "SAPK kinase 1" "SAPKK-1" "SAPKK1" "c-Jun N-terminal kinase kinase 1" "JNKK"))
(define-protein "MP2K6_HUMAN" ("vi" "Dual specificity mitogen-activated protein kinase kinase 6" "MAP kinase kinase 6" "MAPKK 6" "MAPK/ERK kinase 6" "MEK 6" "Stress-activated protein kinase kinase 3" "SAPK kinase 3" "SAPKK-3" "SAPKK3"))
(define-protein "MP2K7_HUMAN" ("vii" "Dual specificity mitogen-activated protein kinase kinase 7" "MAP kinase kinase 7" "MAPKK 7" "JNK-activating kinase 2" "MAPK/ERK kinase 7" "MEK 7" "Stress-activated protein kinase kinase 4" "SAPK kinase 4" "SAPKK-4" "SAPKK4" "c-Jun N-terminal kinase kinase 2" "JNK kinase 2" "JNKK 2"))
=======
<<<<<<< .mine
(define-protein "MOS_HUMAN" ("mos" "Proto-oncogene serine/threonine-protein kinase mos" "Oocyte maturation factor mos" "Proto-oncogene c-Mos"))
(define-protein "MOT4_HUMAN" ("MCT-4" "Monocarboxylate transporter 4" "MCT 4" "Solute carrier family 16 member 3"))
(define-protein "MP2K2_HUMAN" ("mock-" "Dual specificity mitogen-activated protein kinase kinase 2" "MAP kinase kinase 2" "MAPKK 2" "ERK activator kinase 2" "MAPK/ERK kinase 2" "MEK 2"))
(define-protein "MP2K4_HUMAN" ("kinase-1" "Dual specificity mitogen-activated protein kinase kinase 4" "MAP kinase kinase 4" "MAPKK 4" "JNK-activating kinase 1" "MAPK/ERK kinase 4" "MEK 4" "SAPK/ERK kinase 1" "SEK1" "Stress-activated protein kinase kinase 1" "SAPK kinase 1" "SAPKK-1" "SAPKK1" "c-Jun N-terminal kinase kinase 1" "JNKK"))
(define-protein "MP2K6_HUMAN" ("vi" "Dual specificity mitogen-activated protein kinase kinase 6" "MAP kinase kinase 6" "MAPKK 6" "MAPK/ERK kinase 6" "MEK 6" "Stress-activated protein kinase kinase 3" "SAPK kinase 3" "SAPKK-3" "SAPKK3"))
(define-protein "MP2K7_HUMAN" ("vii" "Dual specificity mitogen-activated protein kinase kinase 7" "MAP kinase kinase 7" "MAPKK 7" "JNK-activating kinase 2" "MAPK/ERK kinase 7" "MEK 7" "Stress-activated protein kinase kinase 4" "SAPK kinase 4" "SAPKK-4" "SAPKK4" "c-Jun N-terminal kinase kinase 2" "JNK kinase 2" "JNKK 2"))
=======
(define-protein "MOS_HUMAN" ("Proto-oncogene serine/threonine-protein kinase mos" "Oocyte maturation factor mos" "Proto-oncogene c-Mos"))
(define-protein "MOT4_HUMAN" ("Monocarboxylate transporter 4" "MCT 4" "Solute carrier family 16 member 3"))
(define-protein "MP2K2_HUMAN" ("Dual specificity mitogen-activated protein kinase kinase 2" "MAP kinase kinase 2" "MAPKK 2" "ERK activator kinase 2" "MAPK/ERK kinase 2" "MEK 2"))
(define-protein "MP2K4_HUMAN" ("Dual specificity mitogen-activated protein kinase kinase 4" "MAP kinase kinase 4" "MAPKK 4" "JNK-activating kinase 1" "MAPK/ERK kinase 4" "MEK 4" "SAPK/ERK kinase 1" "SEK1" "Stress-activated protein kinase kinase 1" "SAPK kinase 1" "SAPKK-1" "SAPKK1" "c-Jun N-terminal kinase kinase 1" "JNKK"))
(define-protein "MP2K6_HUMAN" ("Dual specificity mitogen-activated protein kinase kinase 6" "MAP kinase kinase 6" "MAPKK 6" "MAPK/ERK kinase 6" "MEK 6" "Stress-activated protein kinase kinase 3" "SAPK kinase 3" "SAPKK-3" "SAPKK3"))
(define-protein "MP2K7_HUMAN" ("Dual specificity mitogen-activated protein kinase kinase 7" "MAP kinase kinase 7" "MAPKK 7" "JNK-activating kinase 2" "MAPK/ERK kinase 7" "MEK 7" "Stress-activated protein kinase kinase 4" "SAPK kinase 4" "SAPKK-4" "SAPKK4" "c-Jun N-terminal kinase kinase 2" "JNK kinase 2" "JNKK 2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "MPCP_HUMAN" ("SLC25A3" "PHC" "PTP")) 
(define-protein "MPIP1_HUMAN" ("CDC25A")) 
(define-protein "MPIP2_HUMAN" ("CDC25HU2" "CDC25B")) 
(define-protein "MPIP3_HUMAN" ("M-phase inducer phosphatase 3" "Dual specificity phosphatase Cdc25C"))
<<<<<<< .mine
(define-protein "MRC1_HUMAN" ("MMR+" "Macrophage mannose receptor 1" "MMR" "C-type lectin domain family 13 member D" "C-type lectin domain family 13 member D-like" "Macrophage mannose receptor 1-like protein 1"))
=======
<<<<<<< .mine
(define-protein "MRC1_HUMAN" ("MMR+" "Macrophage mannose receptor 1" "MMR" "C-type lectin domain family 13 member D" "C-type lectin domain family 13 member D-like" "Macrophage mannose receptor 1-like protein 1"))
=======
(define-protein "MRC1_HUMAN" ("Macrophage mannose receptor 1" "MMR" "C-type lectin domain family 13 member D" "C-type lectin domain family 13 member D-like" "Macrophage mannose receptor 1-like protein 1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "MRCKB_HUMAN" ("CDC42BPB" "KIAA1124" "CDC42BP-beta")) 
(define-protein "MRCKG_HUMAN" ("DMPK2" "CDC42BPG" "MRCKG")) 
<<<<<<< .mine
(define-protein "MRE11_HUMAN" ("hMRE11" "Double-strand break repair protein MRE11A" "Meiotic recombination 11 homolog 1" "MRE11 homolog 1" "Meiotic recombination 11 homolog A" "MRE11 homolog A"))
(define-protein "MRGX2_HUMAN" ("β-defensins" "Mas-related G-protein coupled receptor member X2"))
=======
<<<<<<< .mine
(define-protein "MRE11_HUMAN" ("hMRE11" "Double-strand break repair protein MRE11A" "Meiotic recombination 11 homolog 1" "MRE11 homolog 1" "Meiotic recombination 11 homolog A" "MRE11 homolog A"))
(define-protein "MRGX2_HUMAN" ("β-defensins" "Mas-related G-protein coupled receptor member X2"))
=======
(define-protein "MRE11_HUMAN" ("Double-strand break repair protein MRE11A" "Meiotic recombination 11 homolog 1" "MRE11 homolog 1" "Meiotic recombination 11 homolog A" "MRE11 homolog A"))
(define-protein "MRGX2_HUMAN" ("Mas-related G-protein coupled receptor member X2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "MRI_HUMAN" ("MRI" "C7orf49")) 
<<<<<<< .mine
(define-protein "MRM3_HUMAN" ("rrna" "rRNA methyltransferase 3, mitochondrial" "16S rRNA (guanosine(1370)-2'-O)-methyltransferase" "16S rRNA [Gm1370] 2'-O-methyltransferase" "RNA methyltransferase-like protein 1"))
(define-protein "MRP2_HUMAN" ("multidrug" "Canalicular multispecific organic anion transporter 1" "ATP-binding cassette sub-family C member 2" "Canalicular multidrug resistance protein" "Multidrug resistance-associated protein 2"))
=======
<<<<<<< .mine
(define-protein "MRM3_HUMAN" ("rrna" "rRNA methyltransferase 3, mitochondrial" "16S rRNA (guanosine(1370)-2'-O)-methyltransferase" "16S rRNA [Gm1370] 2'-O-methyltransferase" "RNA methyltransferase-like protein 1"))
(define-protein "MRP2_HUMAN" ("multidrug" "Canalicular multispecific organic anion transporter 1" "ATP-binding cassette sub-family C member 2" "Canalicular multidrug resistance protein" "Multidrug resistance-associated protein 2"))
=======
(define-protein "MRM3_HUMAN" ("rRNA methyltransferase 3, mitochondrial" "16S rRNA (guanosine(1370)-2'-O)-methyltransferase" "16S rRNA [Gm1370] 2'-O-methyltransferase" "RNA methyltransferase-like protein 1"))
(define-protein "MRP2_HUMAN" ("Canalicular multispecific organic anion transporter 1" "ATP-binding cassette sub-family C member 2" "Canalicular multidrug resistance protein" "Multidrug resistance-associated protein 2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "MRP4_HUMAN" ("Multidrug resistance-associated protein 4" "ATP-binding cassette sub-family C member 4" "MRP/cMOAT-related ABC transporter" "Multi-specific organic anion transporter B" "MOAT-B"))
(define-protein "MRP_HUMAN" ("MARCKSL1" "Mac-MARCKS" "MRP" "MLP" "MacMARCKS")) 
(define-protein "MS3L1_HUMAN" ("MSL3L1" "MSL3")) 
(define-protein "MSH2_HUMAN" ("DNA mismatch repair protein Msh2" "hMSH2" "MutS protein homolog 2"))
(define-protein "MSH6_HUMAN" ("DNA mismatch repair protein Msh6" "hMSH6" "G/T mismatch-binding protein" "GTBP" "GTMBP" "MutS-alpha 160 kDa subunit" "p160"))
(define-protein "MSH6_HUMAN" ("mismatch" "DNA mismatch repair protein Msh6" "hMSH6" "G/T mismatch-binding protein" "GTBP" "GTMBP" "MutS-alpha 160 kDa subunit" "p160"))
(define-protein "MSPD2_HUMAN" ("MOSPD2")) 
<<<<<<< .mine
(define-protein "MSX1_HUMAN" ("Msx1" "Homeobox protein MSX-1" "Homeobox protein Hox-7" "Msh homeobox 1-like protein"))
(define-protein "MTA1_HUMAN" ("MTA-1" "Metastasis-associated protein MTA1"))
=======
<<<<<<< .mine
(define-protein "MSX1_HUMAN" ("Msx1" "Homeobox protein MSX-1" "Homeobox protein Hox-7" "Msh homeobox 1-like protein"))
(define-protein "MTA1_HUMAN" ("MTA-1" "Metastasis-associated protein MTA1"))
=======
(define-protein "MSX1_HUMAN" ("Homeobox protein MSX-1" "Homeobox protein Hox-7" "Msh homeobox 1-like protein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "MTA1_HUMAN" ("Metastasis-associated protein MTA1"))
(define-protein "MTAP2_HUMAN" ("MAP2" "MAP-2")) 
<<<<<<< .mine
(define-protein "MTFR1_HUMAN" ("polyproline" "Mitochondrial fission regulator 1" "Chondrocyte protein with a poly-proline region"))
(define-protein "MTMR2_HUMAN" ("phosphatidylinositol-3" "Myotubularin-related protein 2" "Phosphatidylinositol-3,5-bisphosphate 3-phosphatase" "Phosphatidylinositol-3-phosphate phosphatase"))
(define-protein "MTOR_HUMAN" ("mtorc" "Serine/threonine-protein kinase mTOR" "FK506-binding protein 12-rapamycin complex-associated protein 1" "FKBP12-rapamycin complex-associated protein" "Mammalian target of rapamycin" "mTOR" "Mechanistic target of rapamycin" "Rapamycin and FKBP12 target 1" "Rapamycin target protein 1"))
=======
<<<<<<< .mine
(define-protein "MTFR1_HUMAN" ("polyproline" "Mitochondrial fission regulator 1" "Chondrocyte protein with a poly-proline region"))
(define-protein "MTMR2_HUMAN" ("phosphatidylinositol-3" "Myotubularin-related protein 2" "Phosphatidylinositol-3,5-bisphosphate 3-phosphatase" "Phosphatidylinositol-3-phosphate phosphatase"))
(define-protein "MTOR_HUMAN" ("mtorc" "Serine/threonine-protein kinase mTOR" "FK506-binding protein 12-rapamycin complex-associated protein 1" "FKBP12-rapamycin complex-associated protein" "Mammalian target of rapamycin" "mTOR" "Mechanistic target of rapamycin" "Rapamycin and FKBP12 target 1" "Rapamycin target protein 1"))
=======
(define-protein "MTFR1_HUMAN" ("Mitochondrial fission regulator 1" "Chondrocyte protein with a poly-proline region"))
(define-protein "MTMR2_HUMAN" ("Myotubularin-related protein 2" "Phosphatidylinositol-3,5-bisphosphate 3-phosphatase" "Phosphatidylinositol-3-phosphate phosphatase"))
(define-protein "MTOR_HUMAN" ("Serine/threonine-protein kinase mTOR" "FK506-binding protein 12-rapamycin complex-associated protein 1" "FKBP12-rapamycin complex-associated protein" "Mammalian target of rapamycin" "mTOR" "Mechanistic target of rapamycin" "Rapamycin and FKBP12 target 1" "Rapamycin target protein 1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "MTSS1_HUMAN" ("Metastasis suppressor protein 1" "Metastasis suppressor YGL-1" "Missing in metastasis protein"))
(define-protein "MUC13_HUMAN" ("MUC-13" "RECC" "MUC13" "DRCC1")) 
(define-protein "MUC18_HUMAN" ("MCAM" "MUC18" "CD146")) 
(define-protein "MUC1_HUMAN" ("Mucin-1" "MUC-1" "Breast carcinoma-associated antigen DF3" "Cancer antigen 15-3" "CA 15-3" "Carcinoma-associated mucin" "Episialin" "H23AG" "Krebs von den Lungen-6" "KL-6" "PEMT" "Peanut-reactive urinary mucin" "PUM" "Polymorphic epithelial mucin" "PEM" "Tumor-associated epithelial membrane antigen" "EMA" "Tumor-associated mucin"))
(define-protein "MUC1_HUMAN" ("γ-catenin" "Mucin-1" "MUC-1" "Breast carcinoma-associated antigen DF3" "Cancer antigen 15-3" "CA 15-3" "Carcinoma-associated mucin" "Episialin" "H23AG" "Krebs von den Lungen-6" "KL-6" "PEMT" "Peanut-reactive urinary mucin" "PUM" "Polymorphic epithelial mucin" "PEM" "Tumor-associated epithelial membrane antigen" "EMA" "Tumor-associated mucin"))
(define-protein "MVP_HUMAN" ("MVP" "LRP")) 
(define-protein "MX1_HUMAN" ("IFI-78K" "MX1")) 
(define-protein "MY18A_HUMAN" ("MYSPDZ" "KIAA0216" "MYO18A" "MAJN")) 
<<<<<<< .mine
(define-protein "MYCN_HUMAN" ("mycn" "N-myc proto-oncogene protein" "Class E basic helix-loop-helix protein 37" "bHLHe37"))
=======
<<<<<<< .mine
(define-protein "MYCN_HUMAN" ("mycn" "N-myc proto-oncogene protein" "Class E basic helix-loop-helix protein 37" "bHLHe37"))
=======
(define-protein "MYCN_HUMAN" ("N-myc proto-oncogene protein" "Class E basic helix-loop-helix protein 37" "bHLHe37"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "MYC_HUMAN" ("Myc proto-oncogene protein" "Class E basic helix-loop-helix protein 39" "bHLHe39" "Proto-oncogene c-Myc" "Transcription factor p64"))
<<<<<<< .mine
(define-protein "MYC_HUMAN" ("cmyc" "Myc proto-oncogene protein" "Class E basic helix-loop-helix protein 39" "bHLHe39" "Proto-oncogene c-Myc" "Transcription factor p64"))
(define-protein "MYF5_HUMAN" ("myf5" "Myogenic factor 5" "Myf-5" "Class C basic helix-loop-helix protein 2" "bHLHc2"))
(define-protein "MYH11_HUMAN" ("subfragments" "Myosin-11" "Myosin heavy chain 11" "Myosin heavy chain, smooth muscle isoform" "SMMHC"))
=======
<<<<<<< .mine
(define-protein "MYC_HUMAN" ("cmyc" "Myc proto-oncogene protein" "Class E basic helix-loop-helix protein 39" "bHLHe39" "Proto-oncogene c-Myc" "Transcription factor p64"))
(define-protein "MYF5_HUMAN" ("myf5" "Myogenic factor 5" "Myf-5" "Class C basic helix-loop-helix protein 2" "bHLHc2"))
(define-protein "MYH11_HUMAN" ("subfragments" "Myosin-11" "Myosin heavy chain 11" "Myosin heavy chain, smooth muscle isoform" "SMMHC"))
=======
(define-protein "MYF5_HUMAN" ("Myogenic factor 5" "Myf-5" "Class C basic helix-loop-helix protein 2" "bHLHc2"))
(define-protein "MYH11_HUMAN" ("Myosin-11" "Myosin heavy chain 11" "Myosin heavy chain, smooth muscle isoform" "SMMHC"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "MYH14_HUMAN" ("MYH14" "KIAA2034")) 
<<<<<<< .mine
(define-protein "MYH7_HUMAN" ("myhc" "Myosin-7" "Myosin heavy chain 7" "Myosin heavy chain slow isoform" "MyHC-slow" "Myosin heavy chain, cardiac muscle beta isoform" "MyHC-beta"))
=======
<<<<<<< .mine
(define-protein "MYH7_HUMAN" ("myhc" "Myosin-7" "Myosin heavy chain 7" "Myosin heavy chain slow isoform" "MyHC-slow" "Myosin heavy chain, cardiac muscle beta isoform" "MyHC-beta"))
=======
(define-protein "MYH7_HUMAN" ("Myosin-7" "Myosin heavy chain 7" "Myosin heavy chain slow isoform" "MyHC-slow" "Myosin heavy chain, cardiac muscle beta isoform" "MyHC-beta"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "MYH9_HUMAN" ("NMMHC-A" "MYH9" "NMMHC-IIA")) 
(define-protein "MYL6B_HUMAN" ("MLC1sa" "MLC1SA" "MYL6B")) 
(define-protein "MYL6_HUMAN" ("MLC-3" "LC17" "MYL6")) 
(define-protein "MYO1A_HUMAN" ("MYO1A" "BBMI" "MIHC" "MYHL" "BBM-I")) 
(define-protein "MYO1E_HUMAN" ("MYO1E" "Myosin-Ic" "MYO1C")) 
<<<<<<< .mine
(define-protein "MYO1G_HUMAN" ("HA-" "Unconventional myosin-Ig"))
=======
<<<<<<< .mine
(define-protein "MYO1G_HUMAN" ("HA-" "Unconventional myosin-Ig"))
=======
(define-protein "MYO1G_HUMAN" ("Unconventional myosin-Ig"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "MYO6_HUMAN" ("MYO6" "KIAA0389")) 
(define-protein "MYO7B_HUMAN" ("MYO7B")) 
<<<<<<< .mine
(define-protein "MYOD1_HUMAN" ("myod" "Myoblast determination protein 1" "Class C basic helix-loop-helix protein 1" "bHLHc1" "Myogenic factor 3" "Myf-3"))
=======
<<<<<<< .mine
(define-protein "MYOD1_HUMAN" ("myod" "Myoblast determination protein 1" "Class C basic helix-loop-helix protein 1" "bHLHc1" "Myogenic factor 3" "Myf-3"))
=======
(define-protein "MYOD1_HUMAN" ("Myoblast determination protein 1" "Class C basic helix-loop-helix protein 1" "bHLHc1" "Myogenic factor 3" "Myf-3"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "MYOF_HUMAN" ("KIAA1207" "MYOF" "FER1L3")) 
(define-protein "MYOME_HUMAN" ("KIAA0454" "MMGL" "PDE4DIP" "KIAA0477" "CMYA2")) 
(define-protein "NAA15_HUMAN" ("NARG1" "NAA15" "TBDN100" "Tbdn100" "NATH" "GA19")) 
(define-protein "NAAA_HUMAN" ("NAAA" "ASAHL" "PLT")) 
(define-protein "NACA_HUMAN" ("NAC-alpha" "Alpha-NAC" "NACA")) 
(define-protein "NAL12_HUMAN" ("NACHT, LRR and PYD domains-containing protein 12" "Monarch-1" "PYRIN-containing APAF1-like protein 7" "Regulated by nitric oxide"))
<<<<<<< .mine
(define-protein "NAL12_HUMAN" ("PYPAF-7" "NACHT, LRR and PYD domains-containing protein 12" "Monarch-1" "PYRIN-containing APAF1-like protein 7" "Regulated by nitric oxide"))
(define-protein "NALP2_HUMAN" ("Nbs1" "NACHT, LRR and PYD domains-containing protein 2" "Nucleotide-binding site protein 1" "PYRIN domain and NACHT domain-containing protein 1" "PYRIN-containing APAF1-like protein 2"))
=======
<<<<<<< .mine
(define-protein "NAL12_HUMAN" ("PYPAF-7" "NACHT, LRR and PYD domains-containing protein 12" "Monarch-1" "PYRIN-containing APAF1-like protein 7" "Regulated by nitric oxide"))
(define-protein "NALP2_HUMAN" ("Nbs1" "NACHT, LRR and PYD domains-containing protein 2" "Nucleotide-binding site protein 1" "PYRIN domain and NACHT domain-containing protein 1" "PYRIN-containing APAF1-like protein 2"))
=======
(define-protein "NALP2_HUMAN" ("NACHT, LRR and PYD domains-containing protein 2" "Nucleotide-binding site protein 1" "PYRIN domain and NACHT domain-containing protein 1" "PYRIN-containing APAF1-like protein 2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "NANO2_HUMAN" ("Nanos homolog 2" "NOS-2"))
<<<<<<< .mine
(define-protein "NANOG_HUMAN" ("nanog" "Homeobox protein NANOG" "Homeobox transcription factor Nanog" "hNanog"))
(define-protein "NAT10_HUMAN" ("assembly/disassembly" "N-acetyltransferase 10"))
(define-protein "NAT9_HUMAN" ("ebs" "N-acetyltransferase 9" "Embryo brain-specific protein"))
(define-protein "NB5R3_HUMAN" ("Dia1" "NADH-cytochrome b5 reductase 3" "B5R" "Cytochrome b5 reductase" "Diaphorase-1"))
=======
<<<<<<< .mine
(define-protein "NANOG_HUMAN" ("nanog" "Homeobox protein NANOG" "Homeobox transcription factor Nanog" "hNanog"))
(define-protein "NAT10_HUMAN" ("assembly/disassembly" "N-acetyltransferase 10"))
(define-protein "NAT9_HUMAN" ("ebs" "N-acetyltransferase 9" "Embryo brain-specific protein"))
(define-protein "NB5R3_HUMAN" ("Dia1" "NADH-cytochrome b5 reductase 3" "B5R" "Cytochrome b5 reductase" "Diaphorase-1"))
=======
(define-protein "NANOG_HUMAN" ("Homeobox protein NANOG" "Homeobox transcription factor Nanog" "hNanog"))
(define-protein "NAT10_HUMAN" ("N-acetyltransferase 10"))
(define-protein "NAT9_HUMAN" ("N-acetyltransferase 9" "Embryo brain-specific protein"))
(define-protein "NB5R3_HUMAN" ("NADH-cytochrome b5 reductase 3" "B5R" "Cytochrome b5 reductase" "Diaphorase-1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "NC2A_HUMAN" ("NC2-alpha" "DRAP1")) 
<<<<<<< .mine
(define-protein "NCK2_HUMAN" ("LD4" "Cytoplasmic protein NCK2" "Growth factor receptor-bound protein 4" "NCK adaptor protein 2" "Nck-2" "SH2/SH3 adaptor protein NCK-beta"))
(define-protein "NCOA2_HUMAN" ("SRC-2" "Nuclear receptor coactivator 2" "NCoA-2" "Class E basic helix-loop-helix protein 75" "bHLHe75" "Transcriptional intermediary factor 2" "hTIF2"))
(define-protein "NCOA3_HUMAN" ("SRC3" "Nuclear receptor coactivator 3" "NCoA-3" "ACTR" "Amplified in breast cancer 1 protein" "AIB-1" "CBP-interacting protein" "pCIP" "Class E basic helix-loop-helix protein 42" "bHLHe42" "Receptor-associated coactivator 3" "RAC-3" "Steroid receptor coactivator protein 3" "SRC-3" "Thyroid hormone receptor activator molecule 1" "TRAM-1"))
(define-protein "NCOA4_HUMAN" ("androgen" "Nuclear receptor coactivator 4" "NCoA-4" "Androgen receptor coactivator 70 kDa protein" "70 kDa AR-activator" "70 kDa androgen receptor coactivator" "Androgen receptor-associated protein of 70 kDa" "Ret-activating protein ELE1"))
(define-protein "NCOA5_HUMAN" ("AF-2" "Nuclear receptor coactivator 5" "NCoA-5" "Coactivator independent of AF-2" "CIA"))
(define-protein "NCOA6_HUMAN" ("ppars" "Nuclear receptor coactivator 6" "Activating signal cointegrator 2" "ASC-2" "Amplified in breast cancer protein 3" "Cancer-amplified transcriptional coactivator ASC-2" "Nuclear receptor coactivator RAP250" "NRC RAP250" "Nuclear receptor-activating protein, 250 kDa" "Peroxisome proliferator-activated receptor-interacting protein" "PPAR-interacting protein" "PRIP" "Thyroid hormone receptor-binding protein"))
(define-protein "NCOA7_HUMAN" ("AhR/ARNT" "Nuclear receptor coactivator 7" "140 kDa estrogen receptor-associated protein" "Estrogen nuclear receptor coactivator 1"))
=======
<<<<<<< .mine
(define-protein "NCK2_HUMAN" ("LD4" "Cytoplasmic protein NCK2" "Growth factor receptor-bound protein 4" "NCK adaptor protein 2" "Nck-2" "SH2/SH3 adaptor protein NCK-beta"))
(define-protein "NCOA2_HUMAN" ("SRC-2" "Nuclear receptor coactivator 2" "NCoA-2" "Class E basic helix-loop-helix protein 75" "bHLHe75" "Transcriptional intermediary factor 2" "hTIF2"))
(define-protein "NCOA3_HUMAN" ("SRC3" "Nuclear receptor coactivator 3" "NCoA-3" "ACTR" "Amplified in breast cancer 1 protein" "AIB-1" "CBP-interacting protein" "pCIP" "Class E basic helix-loop-helix protein 42" "bHLHe42" "Receptor-associated coactivator 3" "RAC-3" "Steroid receptor coactivator protein 3" "SRC-3" "Thyroid hormone receptor activator molecule 1" "TRAM-1"))
(define-protein "NCOA4_HUMAN" ("androgen" "Nuclear receptor coactivator 4" "NCoA-4" "Androgen receptor coactivator 70 kDa protein" "70 kDa AR-activator" "70 kDa androgen receptor coactivator" "Androgen receptor-associated protein of 70 kDa" "Ret-activating protein ELE1"))
(define-protein "NCOA5_HUMAN" ("AF-2" "Nuclear receptor coactivator 5" "NCoA-5" "Coactivator independent of AF-2" "CIA"))
(define-protein "NCOA6_HUMAN" ("ppars" "Nuclear receptor coactivator 6" "Activating signal cointegrator 2" "ASC-2" "Amplified in breast cancer protein 3" "Cancer-amplified transcriptional coactivator ASC-2" "Nuclear receptor coactivator RAP250" "NRC RAP250" "Nuclear receptor-activating protein, 250 kDa" "Peroxisome proliferator-activated receptor-interacting protein" "PPAR-interacting protein" "PRIP" "Thyroid hormone receptor-binding protein"))
(define-protein "NCOA7_HUMAN" ("AhR/ARNT" "Nuclear receptor coactivator 7" "140 kDa estrogen receptor-associated protein" "Estrogen nuclear receptor coactivator 1"))
=======
(define-protein "NCK2_HUMAN" ("Cytoplasmic protein NCK2" "Growth factor receptor-bound protein 4" "NCK adaptor protein 2" "Nck-2" "SH2/SH3 adaptor protein NCK-beta"))
(define-protein "NCOA2_HUMAN" ("Nuclear receptor coactivator 2" "NCoA-2" "Class E basic helix-loop-helix protein 75" "bHLHe75" "Transcriptional intermediary factor 2" "hTIF2"))
(define-protein "NCOA3_HUMAN" ("Nuclear receptor coactivator 3" "NCoA-3" "ACTR" "Amplified in breast cancer 1 protein" "AIB-1" "CBP-interacting protein" "pCIP" "Class E basic helix-loop-helix protein 42" "bHLHe42" "Receptor-associated coactivator 3" "RAC-3" "Steroid receptor coactivator protein 3" "SRC-3" "Thyroid hormone receptor activator molecule 1" "TRAM-1"))
(define-protein "NCOA4_HUMAN" ("Nuclear receptor coactivator 4" "NCoA-4" "Androgen receptor coactivator 70 kDa protein" "70 kDa AR-activator" "70 kDa androgen receptor coactivator" "Androgen receptor-associated protein of 70 kDa" "Ret-activating protein ELE1"))
(define-protein "NCOA5_HUMAN" ("Nuclear receptor coactivator 5" "NCoA-5" "Coactivator independent of AF-2" "CIA"))
(define-protein "NCOA6_HUMAN" ("Nuclear receptor coactivator 6" "Activating signal cointegrator 2" "ASC-2" "Amplified in breast cancer protein 3" "Cancer-amplified transcriptional coactivator ASC-2" "Nuclear receptor coactivator RAP250" "NRC RAP250" "Nuclear receptor-activating protein, 250 kDa" "Peroxisome proliferator-activated receptor-interacting protein" "PPAR-interacting protein" "PRIP" "Thyroid hormone receptor-binding protein"))
(define-protein "NCOA7_HUMAN" ("Nuclear receptor coactivator 7" "140 kDa estrogen receptor-associated protein" "Estrogen nuclear receptor coactivator 1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "NCS1_HUMAN" ("Neuronal calcium sensor 1" "NCS-1" "Frequenin homolog" "Frequenin-like protein" "Frequenin-like ubiquitous protein"))
<<<<<<< .mine
(define-protein "NCTR3_HUMAN" ("p30" "Natural cytotoxicity triggering receptor 3" "Activating natural killer receptor p30" "Natural killer cell p30-related protein" "NK-p30" "NKp30"))
=======
<<<<<<< .mine
(define-protein "NCTR3_HUMAN" ("p30" "Natural cytotoxicity triggering receptor 3" "Activating natural killer receptor p30" "Natural killer cell p30-related protein" "NK-p30" "NKp30"))
=======
(define-protein "NCTR3_HUMAN" ("Natural cytotoxicity triggering receptor 3" "Activating natural killer receptor p30" "Natural killer cell p30-related protein" "NK-p30" "NKp30"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "NDE1_HUMAN" ("Nuclear distribution protein nudE homolog 1" "NudE"))
<<<<<<< .mine
(define-protein "NDKA_HUMAN" ("nm-23" "Nucleoside diphosphate kinase A" "NDK A" "NDP kinase A" "Granzyme A-activated DNase" "GAAD" "Metastasis inhibition factor nm23" "NM23-H1" "Tumor metastatic process-associated protein"))
(define-protein "NDST1_HUMAN" ("N-" "Bifunctional heparan sulfate N-deacetylase/N-sulfotransferase 1" "Glucosaminyl N-deacetylase/N-sulfotransferase 1" "NDST-1" "N-heparan sulfate sulfotransferase 1" "N-HSST 1" "[Heparan sulfate]-glucosamine N-sulfotransferase 1" "HSNST 1"))
=======
<<<<<<< .mine
(define-protein "NDKA_HUMAN" ("nm-23" "Nucleoside diphosphate kinase A" "NDK A" "NDP kinase A" "Granzyme A-activated DNase" "GAAD" "Metastasis inhibition factor nm23" "NM23-H1" "Tumor metastatic process-associated protein"))
(define-protein "NDST1_HUMAN" ("N-" "Bifunctional heparan sulfate N-deacetylase/N-sulfotransferase 1" "Glucosaminyl N-deacetylase/N-sulfotransferase 1" "NDST-1" "N-heparan sulfate sulfotransferase 1" "N-HSST 1" "[Heparan sulfate]-glucosamine N-sulfotransferase 1" "HSNST 1"))
=======
(define-protein "NDKA_HUMAN" ("Nucleoside diphosphate kinase A" "NDK A" "NDP kinase A" "Granzyme A-activated DNase" "GAAD" "Metastasis inhibition factor nm23" "NM23-H1" "Tumor metastatic process-associated protein"))
(define-protein "NDST1_HUMAN" ("Bifunctional heparan sulfate N-deacetylase/N-sulfotransferase 1" "Glucosaminyl N-deacetylase/N-sulfotransferase 1" "NDST-1" "N-heparan sulfate sulfotransferase 1" "N-HSST 1" "[Heparan sulfate]-glucosamine N-sulfotransferase 1" "HSNST 1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "NEB2_HUMAN" ("Neurabin-II" "Spinophilin" "PPP1R9B" "PPP1R6")) 
(define-protein "NEDD1_HUMAN" ("NEDD1" "NEDD-1")) 
(define-protein "NEDD8_HUMAN" ("Neddylin" "NEDD-8")) 
(define-protein "NEK6_HUMAN" ("NEK6")) 
(define-protein "NEK9_HUMAN" ("NEK9" "NEK8" "NERCC" "KIAA1995" "Nek8")) 
<<<<<<< .mine
(define-protein "NEMO_HUMAN" ("ikkγ" "NF-kappa-B essential modulator" "NEMO" "FIP-3" "IkB kinase-associated protein 1" "IKKAP1" "Inhibitor of nuclear factor kappa-B kinase subunit gamma" "I-kappa-B kinase subunit gamma" "IKK-gamma" "IKKG" "IkB kinase subunit gamma" "NF-kappa-B essential modifier"))
(define-protein "NEO1_HUMAN" ("neogenin" "Neogenin" "Immunoglobulin superfamily DCC subclass member 2"))
(define-protein "NEP_HUMAN" ("polypeptides" "Neprilysin" "Atriopeptidase" "Common acute lymphocytic leukemia antigen" "CALLA" "Enkephalinase" "Neutral endopeptidase 24.11" "NEP" "Neutral endopeptidase" "Skin fibroblast elastase" "SFE"))
(define-protein "NEST_HUMAN" ("nestin" "Nestin"))
=======
<<<<<<< .mine
(define-protein "NEMO_HUMAN" ("ikkγ" "NF-kappa-B essential modulator" "NEMO" "FIP-3" "IkB kinase-associated protein 1" "IKKAP1" "Inhibitor of nuclear factor kappa-B kinase subunit gamma" "I-kappa-B kinase subunit gamma" "IKK-gamma" "IKKG" "IkB kinase subunit gamma" "NF-kappa-B essential modifier"))
(define-protein "NEO1_HUMAN" ("neogenin" "Neogenin" "Immunoglobulin superfamily DCC subclass member 2"))
(define-protein "NEP_HUMAN" ("polypeptides" "Neprilysin" "Atriopeptidase" "Common acute lymphocytic leukemia antigen" "CALLA" "Enkephalinase" "Neutral endopeptidase 24.11" "NEP" "Neutral endopeptidase" "Skin fibroblast elastase" "SFE"))
(define-protein "NEST_HUMAN" ("nestin" "Nestin"))
=======
(define-protein "NEMO_HUMAN" ("NF-kappa-B essential modulator" "NEMO" "FIP-3" "IkB kinase-associated protein 1" "IKKAP1" "Inhibitor of nuclear factor kappa-B kinase subunit gamma" "I-kappa-B kinase subunit gamma" "IKK-gamma" "IKKG" "IkB kinase subunit gamma" "NF-kappa-B essential modifier"))
(define-protein "NEO1_HUMAN" ("Neogenin" "Immunoglobulin superfamily DCC subclass member 2"))
(define-protein "NEP_HUMAN" ("Neprilysin" "Atriopeptidase" "Common acute lymphocytic leukemia antigen" "CALLA" "Enkephalinase" "Neutral endopeptidase 24.11" "NEP" "Neutral endopeptidase" "Skin fibroblast elastase" "SFE"))
(define-protein "NEST_HUMAN" ("Nestin"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "NEUL1_HUMAN" ("NEURL1" "NEURL1A" "RNF67" "NEURL" "h-neu")) 
(define-protein "NEUL2_HUMAN" ("NEURL2" "C20orf163")) 
(define-protein "NEUL4_HUMAN" ("KIAA1787" "NEURL4")) 
<<<<<<< .mine
(define-protein "NEUM_HUMAN" ("neuromodulin" "Neuromodulin" "Axonal membrane protein GAP-43" "Growth-associated protein 43" "Neural phosphoprotein B-50" "pp46"))
=======
<<<<<<< .mine
(define-protein "NEUM_HUMAN" ("neuromodulin" "Neuromodulin" "Axonal membrane protein GAP-43" "Growth-associated protein 43" "Neural phosphoprotein B-50" "pp46"))
=======
(define-protein "NEUM_HUMAN" ("Neuromodulin" "Axonal membrane protein GAP-43" "Growth-associated protein 43" "Neural phosphoprotein B-50" "pp46"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "NEUR1_HUMAN" ("NANH" "NEU1")) 
<<<<<<< .mine
(define-protein "NF1_HUMAN" ("NF-" "Neurofibromin" "Neurofibromatosis-related protein NF-1"))
(define-protein "NF2L2_HUMAN" ("Nrf2" "Nuclear factor erythroid 2-related factor 2" "NF-E2-related factor 2" "NFE2-related factor 2" "HEBP1" "Nuclear factor, erythroid derived 2, like 2"))
=======
<<<<<<< .mine
(define-protein "NF1_HUMAN" ("NF-" "Neurofibromin" "Neurofibromatosis-related protein NF-1"))
(define-protein "NF2L2_HUMAN" ("Nrf2" "Nuclear factor erythroid 2-related factor 2" "NF-E2-related factor 2" "NFE2-related factor 2" "HEBP1" "Nuclear factor, erythroid derived 2, like 2"))
=======
(define-protein "NF1_HUMAN" ("Neurofibromin" "Neurofibromatosis-related protein NF-1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "NF2L2_HUMAN" ("Nuclear factor erythroid 2-related factor 2" "NF-E2-related factor 2" "NFE2-related factor 2" "HEBP1" "Nuclear factor, erythroid derived 2, like 2"))
<<<<<<< .mine
(define-protein "NFKB1_HUMAN" ("nfκb" "Nuclear factor NF-kappa-B p105 subunit" "DNA-binding factor KBF1" "EBP-1" "Nuclear factor of kappa light polypeptide gene enhancer in B-cells 1"))
(define-protein "NFM_HUMAN" ("nfm" "Neurofilament medium polypeptide" "NF-M" "160 kDa neurofilament protein" "Neurofilament 3" "Neurofilament triplet M protein"))
(define-protein "NFYC_HUMAN" ("NF-Y" "Nuclear transcription factor Y subunit gamma" "CAAT box DNA-binding protein subunit C" "Nuclear transcription factor Y subunit C" "NF-YC" "Transactivator HSM-1/2"))
(define-protein "NGLY1_HUMAN" ("fmk" "Peptide-N(4)-(N-acetyl-beta-glucosaminyl)asparagine amidase" "PNGase" "hPNGase" "N-glycanase 1" "Peptide:N-glycanase"))
=======
<<<<<<< .mine
(define-protein "NFKB1_HUMAN" ("nfκb" "Nuclear factor NF-kappa-B p105 subunit" "DNA-binding factor KBF1" "EBP-1" "Nuclear factor of kappa light polypeptide gene enhancer in B-cells 1"))
(define-protein "NFM_HUMAN" ("nfm" "Neurofilament medium polypeptide" "NF-M" "160 kDa neurofilament protein" "Neurofilament 3" "Neurofilament triplet M protein"))
(define-protein "NFYC_HUMAN" ("NF-Y" "Nuclear transcription factor Y subunit gamma" "CAAT box DNA-binding protein subunit C" "Nuclear transcription factor Y subunit C" "NF-YC" "Transactivator HSM-1/2"))
(define-protein "NGLY1_HUMAN" ("fmk" "Peptide-N(4)-(N-acetyl-beta-glucosaminyl)asparagine amidase" "PNGase" "hPNGase" "N-glycanase 1" "Peptide:N-glycanase"))
=======
(define-protein "NFKB1_HUMAN" ("Nuclear factor NF-kappa-B p105 subunit" "DNA-binding factor KBF1" "EBP-1" "Nuclear factor of kappa light polypeptide gene enhancer in B-cells 1"))
(define-protein "NFM_HUMAN" ("Neurofilament medium polypeptide" "NF-M" "160 kDa neurofilament protein" "Neurofilament 3" "Neurofilament triplet M protein"))
(define-protein "NFYC_HUMAN" ("Nuclear transcription factor Y subunit gamma" "CAAT box DNA-binding protein subunit C" "Nuclear transcription factor Y subunit C" "NF-YC" "Transactivator HSM-1/2"))
(define-protein "NGLY1_HUMAN" ("Peptide-N(4)-(N-acetyl-beta-glucosaminyl)asparagine amidase" "PNGase" "hPNGase" "N-glycanase 1" "Peptide:N-glycanase"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "NIBL1_HUMAN" ("FAM129B" "MINERVA" "Meg-3" "C9orf88")) 
(define-protein "NICA_HUMAN" ("NCSTN" "KIAA0253")) 
<<<<<<< .mine
(define-protein "NIP7_HUMAN" ("kd" "60S ribosome subunit biogenesis protein NIP7 homolog" "KD93"))
(define-protein "NIPA3_HUMAN" ("nipa" "Magnesium transporter NIPA3" "NIPA-like protein 1" "Non-imprinted in Prader-Willi/Angelman syndrome region protein 3"))
=======
<<<<<<< .mine
(define-protein "NIP7_HUMAN" ("kd" "60S ribosome subunit biogenesis protein NIP7 homolog" "KD93"))
(define-protein "NIPA3_HUMAN" ("nipa" "Magnesium transporter NIPA3" "NIPA-like protein 1" "Non-imprinted in Prader-Willi/Angelman syndrome region protein 3"))
=======
(define-protein "NIP7_HUMAN" ("60S ribosome subunit biogenesis protein NIP7 homolog" "KD93"))
(define-protein "NIPA3_HUMAN" ("Magnesium transporter NIPA3" "NIPA-like protein 1" "Non-imprinted in Prader-Willi/Angelman syndrome region protein 3"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "NIPS1_HUMAN" ("NipSnap1" "NIPSNAP1")) 
(define-protein "NIPS2_HUMAN" ("NipSnap2" "GBAS" "NIPSNAP2")) 
<<<<<<< .mine
(define-protein "NISCH_HUMAN" ("antisera" "Nischarin" "Imidazoline receptor 1" "I-1" "IR1" "Imidazoline receptor antisera-selected protein" "hIRAS" "Imidazoline-1 receptor" "I1R" "Imidazoline-1 receptor candidate protein" "I-1 receptor candidate protein" "I1R candidate protein"))
=======
<<<<<<< .mine
(define-protein "NISCH_HUMAN" ("antisera" "Nischarin" "Imidazoline receptor 1" "I-1" "IR1" "Imidazoline receptor antisera-selected protein" "hIRAS" "Imidazoline-1 receptor" "I1R" "Imidazoline-1 receptor candidate protein" "I-1 receptor candidate protein" "I1R candidate protein"))
=======
(define-protein "NISCH_HUMAN" ("Nischarin" "Imidazoline receptor 1" "I-1" "IR1" "Imidazoline receptor antisera-selected protein" "hIRAS" "Imidazoline-1 receptor" "I1R" "Imidazoline-1 receptor candidate protein" "I-1 receptor candidate protein" "I1R candidate protein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "NK1R_HUMAN" ("Substance-P receptor" "SPR" "NK-1 receptor" "NK-1R" "Tachykinin receptor 1"))
(define-protein "NLTP_HUMAN" ("SCP2" "SCP-chi" "SCP-2" "NSL-TP" "SCPX" "SCP-X")) 
<<<<<<< .mine
(define-protein "NOB1_HUMAN" ("phosphorylation-" "RNA-binding protein NOB1" "Phosphorylation regulatory protein HP-10" "Protein ART-4"))
=======
<<<<<<< .mine
(define-protein "NOB1_HUMAN" ("phosphorylation-" "RNA-binding protein NOB1" "Phosphorylation regulatory protein HP-10" "Protein ART-4"))
=======
(define-protein "NOB1_HUMAN" ("RNA-binding protein NOB1" "Phosphorylation regulatory protein HP-10" "Protein ART-4"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "NOC2L_HUMAN" ("NOC2L" "NIR")) 
<<<<<<< .mine
(define-protein "NOG2_HUMAN" ("Ngp-1" "Nucleolar GTP-binding protein 2" "Autoantigen NGP-1"))
=======
<<<<<<< .mine
(define-protein "NOG2_HUMAN" ("Ngp-1" "Nucleolar GTP-binding protein 2" "Autoantigen NGP-1"))
=======
(define-protein "NOG2_HUMAN" ("Nucleolar GTP-binding protein 2" "Autoantigen NGP-1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "NOL7_HUMAN" ("NOP27" "C6orf90" "NOL7")) 
(define-protein "NOP16_HUMAN" ("NOP16")) 
(define-protein "NOS2_HUMAN" ("Nitric oxide synthase, inducible" "Hepatocyte NOS" "HEP-NOS" "Inducible NO synthase" "Inducible NOS" "iNOS" "NOS type II" "Peptidyl-cysteine S-nitrosylase NOS2"))
<<<<<<< .mine
(define-protein "NOSTN_HUMAN" ("inducer" "Nostrin" "BM247 homolog" "Nitric oxide synthase traffic inducer" "Nitric oxide synthase trafficker" "eNOS-trafficking inducer"))
=======
<<<<<<< .mine
(define-protein "NOSTN_HUMAN" ("inducer" "Nostrin" "BM247 homolog" "Nitric oxide synthase traffic inducer" "Nitric oxide synthase trafficker" "eNOS-trafficking inducer"))
=======
(define-protein "NOSTN_HUMAN" ("Nostrin" "BM247 homolog" "Nitric oxide synthase traffic inducer" "Nitric oxide synthase trafficker" "eNOS-trafficking inducer"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "NOTC1_HUMAN" ("Neurogenic locus notch homolog protein 1" "Notch 1" "hN1" "Translocation-associated notch protein TAN-1"))
(define-protein "NOTC1_HUMAN" ("Notch-1" "Neurogenic locus notch homolog protein 1" "Notch 1" "hN1" "Translocation-associated notch protein TAN-1"))
(define-protein "NOTC2_HUMAN" ("Neurogenic locus notch homolog protein 2" "Notch 2" "hN2"))
<<<<<<< .mine
(define-protein "NOX3_HUMAN" ("Nox3" "NADPH oxidase 3" "Mitogenic oxidase 2" "MOX-2" "gp91phox homolog 3" "GP91-3"))
=======
<<<<<<< .mine
(define-protein "NOX3_HUMAN" ("Nox3" "NADPH oxidase 3" "Mitogenic oxidase 2" "MOX-2" "gp91phox homolog 3" "GP91-3"))
=======
(define-protein "NOX3_HUMAN" ("NADPH oxidase 3" "Mitogenic oxidase 2" "MOX-2" "gp91phox homolog 3" "GP91-3"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "NOXA1_HUMAN" ("NADPH oxidase activator 1" "NOX activator 1" "Antigen NY-CO-31" "NCF2-like protein" "P67phox-like factor" "p51-nox"))
(define-protein "NOXA1_HUMAN" ("NoxA1" "NADPH oxidase activator 1" "NOX activator 1" "Antigen NY-CO-31" "NCF2-like protein" "P67phox-like factor" "p51-nox"))
(define-protein "NO_VALUE" NIL) 
<<<<<<< .mine
(define-protein "NP1L4_HUMAN" ("nucleosome" "Nucleosome assembly protein 1-like 4" "Nucleosome assembly protein 2" "NAP-2"))
(define-protein "NPBW2_HUMAN" ("neuropeptides" "Neuropeptides B/W receptor type 2" "G-protein coupled receptor 8"))
(define-protein "NPC1_HUMAN" ("liposomes" "Niemann-Pick C1 protein"))
(define-protein "NPHN_HUMAN" ("nephrin" "Nephrin" "Renal glomerulus-specific cell adhesion receptor"))
=======
<<<<<<< .mine
(define-protein "NP1L4_HUMAN" ("nucleosome" "Nucleosome assembly protein 1-like 4" "Nucleosome assembly protein 2" "NAP-2"))
(define-protein "NPBW2_HUMAN" ("neuropeptides" "Neuropeptides B/W receptor type 2" "G-protein coupled receptor 8"))
(define-protein "NPC1_HUMAN" ("liposomes" "Niemann-Pick C1 protein"))
(define-protein "NPHN_HUMAN" ("nephrin" "Nephrin" "Renal glomerulus-specific cell adhesion receptor"))
=======
(define-protein "NP1L4_HUMAN" ("Nucleosome assembly protein 1-like 4" "Nucleosome assembly protein 2" "NAP-2"))
(define-protein "NPBW2_HUMAN" ("Neuropeptides B/W receptor type 2" "G-protein coupled receptor 8"))
(define-protein "NPC1_HUMAN" ("Niemann-Pick C1 protein"))
(define-protein "NPHN_HUMAN" ("Nephrin" "Renal glomerulus-specific cell adhesion receptor"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "NPHP1_HUMAN" ("Nephrocystin-1" "Juvenile nephronophthisis 1 protein"))
(define-protein "NPM_HUMAN" ("NPM1" "Numatrin" "NPM")) 
<<<<<<< .mine
(define-protein "NQO2_HUMAN" ("resveratrol" "Ribosyldihydronicotinamide dehydrogenase [quinone]" "NRH dehydrogenase [quinone] 2" "NRH:quinone oxidoreductase 2" "Quinone reductase 2" "QR2"))
(define-protein "NR1D1_HUMAN" ("preadipocytes" "Nuclear receptor subfamily 1 group D member 1" "Rev-erbA-alpha" "V-erbA-related protein 1" "EAR-1"))
(define-protein "NR1H2_HUMAN" ("lxrβ" "Oxysterols receptor LXR-beta" "Liver X receptor beta" "Nuclear receptor NER" "Nuclear receptor subfamily 1 group H member 2" "Ubiquitously-expressed nuclear receptor"))
=======
<<<<<<< .mine
(define-protein "NQO2_HUMAN" ("resveratrol" "Ribosyldihydronicotinamide dehydrogenase [quinone]" "NRH dehydrogenase [quinone] 2" "NRH:quinone oxidoreductase 2" "Quinone reductase 2" "QR2"))
(define-protein "NR1D1_HUMAN" ("preadipocytes" "Nuclear receptor subfamily 1 group D member 1" "Rev-erbA-alpha" "V-erbA-related protein 1" "EAR-1"))
(define-protein "NR1H2_HUMAN" ("lxrβ" "Oxysterols receptor LXR-beta" "Liver X receptor beta" "Nuclear receptor NER" "Nuclear receptor subfamily 1 group H member 2" "Ubiquitously-expressed nuclear receptor"))
=======
(define-protein "NQO2_HUMAN" ("Ribosyldihydronicotinamide dehydrogenase [quinone]" "NRH dehydrogenase [quinone] 2" "NRH:quinone oxidoreductase 2" "Quinone reductase 2" "QR2"))
(define-protein "NR1D1_HUMAN" ("Nuclear receptor subfamily 1 group D member 1" "Rev-erbA-alpha" "V-erbA-related protein 1" "EAR-1"))
(define-protein "NR1H2_HUMAN" ("Oxysterols receptor LXR-beta" "Liver X receptor beta" "Nuclear receptor NER" "Nuclear receptor subfamily 1 group H member 2" "Ubiquitously-expressed nuclear receptor"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "NR2C2_HUMAN" ("Nuclear receptor subfamily 2 group C member 2" "Orphan nuclear receptor TAK1" "Orphan nuclear receptor TR4" "Testicular receptor 4"))
(define-protein "NR4A1_HUMAN" ("NAK1" "Nur77" "NR4A1" "HMR" "ST-59" "GFRP1")) 
(define-protein "NRBP_HUMAN" ("NRBP" "NRBP1" "BCON3")) 
(define-protein "NRF1_HUMAN" ("Alpha-pal" "NRF-1" "NRF1")) 
<<<<<<< .mine
(define-protein "NRG2_HUMAN" ("neuregulin-2" "Pro-neuregulin-2, membrane-bound isoform" "Pro-NRG2"))
(define-protein "NRIP1_HUMAN" ("RIP140" "Nuclear receptor-interacting protein 1" "Nuclear factor RIP140" "Receptor-interacting protein 140"))
(define-protein "NRK2_HUMAN" ("nrk" "Nicotinamide riboside kinase 2" "NRK 2" "NmR-K 2" "Integrin beta-1-binding protein 3" "Muscle integrin-binding protein" "MIBP" "Nicotinic acid riboside kinase 2" "Ribosylnicotinamide kinase 2" "RNK 2" "Ribosylnicotinic acid kinase 2"))
(define-protein "NRP1_HUMAN" ("neuropilin" "Neuropilin-1" "Vascular endothelial cell growth factor 165 receptor"))
(define-protein "NRX3B_HUMAN" ("neurexin" "Neurexin-3-beta" "Neurexin III-beta"))
=======
<<<<<<< .mine
(define-protein "NRG2_HUMAN" ("neuregulin-2" "Pro-neuregulin-2, membrane-bound isoform" "Pro-NRG2"))
(define-protein "NRIP1_HUMAN" ("RIP140" "Nuclear receptor-interacting protein 1" "Nuclear factor RIP140" "Receptor-interacting protein 140"))
(define-protein "NRK2_HUMAN" ("nrk" "Nicotinamide riboside kinase 2" "NRK 2" "NmR-K 2" "Integrin beta-1-binding protein 3" "Muscle integrin-binding protein" "MIBP" "Nicotinic acid riboside kinase 2" "Ribosylnicotinamide kinase 2" "RNK 2" "Ribosylnicotinic acid kinase 2"))
(define-protein "NRP1_HUMAN" ("neuropilin" "Neuropilin-1" "Vascular endothelial cell growth factor 165 receptor"))
(define-protein "NRX3B_HUMAN" ("neurexin" "Neurexin-3-beta" "Neurexin III-beta"))
=======
(define-protein "NRG2_HUMAN" ("Pro-neuregulin-2, membrane-bound isoform" "Pro-NRG2"))
(define-protein "NRIP1_HUMAN" ("Nuclear receptor-interacting protein 1" "Nuclear factor RIP140" "Receptor-interacting protein 140"))
(define-protein "NRK2_HUMAN" ("Nicotinamide riboside kinase 2" "NRK 2" "NmR-K 2" "Integrin beta-1-binding protein 3" "Muscle integrin-binding protein" "MIBP" "Nicotinic acid riboside kinase 2" "Ribosylnicotinamide kinase 2" "RNK 2" "Ribosylnicotinic acid kinase 2"))
(define-protein "NRP1_HUMAN" ("Neuropilin-1" "Vascular endothelial cell growth factor 165 receptor"))
(define-protein "NRX3B_HUMAN" ("Neurexin-3-beta" "Neurexin III-beta"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "NSDHL_HUMAN" ("H105E3" "NSDHL")) 
(define-protein "NSF_HUMAN" ("NSF")) 
<<<<<<< .mine
(define-protein "NTAN1_HUMAN" ("nh" "Protein N-terminal asparagine amidohydrolase" "Protein NH2-terminal asparagine amidohydrolase" "PNAA" "Protein NH2-terminal asparagine deamidase" "PNAD" "Protein N-terminal Asn amidase" "Protein N-terminal asparagine amidase" "Protein NTN-amidase"))
=======
<<<<<<< .mine
(define-protein "NTAN1_HUMAN" ("nh" "Protein N-terminal asparagine amidohydrolase" "Protein NH2-terminal asparagine amidohydrolase" "PNAA" "Protein NH2-terminal asparagine deamidase" "PNAD" "Protein N-terminal Asn amidase" "Protein N-terminal asparagine amidase" "Protein NTN-amidase"))
=======
(define-protein "NTAN1_HUMAN" ("Protein N-terminal asparagine amidohydrolase" "Protein NH2-terminal asparagine amidohydrolase" "PNAA" "Protein NH2-terminal asparagine deamidase" "PNAD" "Protein N-terminal Asn amidase" "Protein N-terminal asparagine amidase" "Protein NTN-amidase"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "NTKL_HUMAN" ("TEIF" "CVAK90" "GKLP" "SCYL1" "TAPK" "TRAP" "NTKL")) 
(define-protein "NTPCR_HUMAN" ("C1orf57" "NTPase" "NTPCR")) 
<<<<<<< .mine
(define-protein "NTRK1_HUMAN" ("TRK-T1" "High affinity nerve growth factor receptor" "Neurotrophic tyrosine kinase receptor type 1" "TRK1-transforming tyrosine kinase protein" "Tropomyosin-related kinase A" "Tyrosine kinase receptor" "Tyrosine kinase receptor A" "Trk-A" "gp140trk" "p140-TrkA"))
(define-protein "NU1M_HUMAN" ("rotenone" "NADH-ubiquinone oxidoreductase chain 1" "NADH dehydrogenase subunit 1"))
=======
<<<<<<< .mine
(define-protein "NTRK1_HUMAN" ("TRK-T1" "High affinity nerve growth factor receptor" "Neurotrophic tyrosine kinase receptor type 1" "TRK1-transforming tyrosine kinase protein" "Tropomyosin-related kinase A" "Tyrosine kinase receptor" "Tyrosine kinase receptor A" "Trk-A" "gp140trk" "p140-TrkA"))
(define-protein "NU1M_HUMAN" ("rotenone" "NADH-ubiquinone oxidoreductase chain 1" "NADH dehydrogenase subunit 1"))
=======
(define-protein "NTRK1_HUMAN" ("High affinity nerve growth factor receptor" "Neurotrophic tyrosine kinase receptor type 1" "TRK1-transforming tyrosine kinase protein" "Tropomyosin-related kinase A" "Tyrosine kinase receptor" "Tyrosine kinase receptor A" "Trk-A" "gp140trk" "p140-TrkA"))
(define-protein "NU1M_HUMAN" ("NADH-ubiquinone oxidoreductase chain 1" "NADH dehydrogenase subunit 1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "NU6M_HUMAN" ("NADH-ubiquinone oxidoreductase chain 6" "NADH dehydrogenase subunit 6"))
<<<<<<< .mine
(define-protein "NUAK2_HUMAN" ("snark" "NUAK family SNF1-like kinase 2" "Omphalocele kinase 2" "SNF1/AMP kinase-related kinase" "SNARK"))
=======
<<<<<<< .mine
(define-protein "NUAK2_HUMAN" ("snark" "NUAK family SNF1-like kinase 2" "Omphalocele kinase 2" "SNF1/AMP kinase-related kinase" "SNARK"))
=======
(define-protein "NUAK2_HUMAN" ("NUAK family SNF1-like kinase 2" "Omphalocele kinase 2" "SNF1/AMP kinase-related kinase" "SNARK"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "NUDC_HUMAN" ("NUDC")) 
(define-protein "NUDT4_HUMAN" ("DIPP-2" "NUDT4" "DIPP2" "KIAA0487")) 
(define-protein "NUP50_HUMAN" ("NPAP60L" "NUP50")) 
(define-protein "O41637_9HIV1" ("Envelope glycoprotein"))
(define-protein "O95598_HUMAN" ("<Delta>Fas/APO-1/CD95 protein"))
(define-protein "OAS1_HUMAN" ("2'-5'-oligoadenylate synthase 1" "(2-5')oligo(A) synthase 1" "2-5A synthase 1" "E18/E16" "p46/p42 OAS"))
(define-protein "OAZ1_HUMAN" ("Ornithine decarboxylase antizyme 1" "ODC-Az"))
(define-protein "OBRG_HUMAN" ("Leptin receptor gene-related protein" "Endospanin-1" "Leptin receptor overlapping transcript protein" "OB-R gene-related protein" "OB-RGRP"))
(define-protein "OC90_HUMAN" ("Otoconin-90" "Oc90" "Phospholipase A2 homolog"))
(define-protein "OCLN_HUMAN" ("Occludin"))
(define-protein "ODO1_HUMAN" ("2-oxoglutarate dehydrogenase, mitochondrial" "2-oxoglutarate dehydrogenase complex component E1" "OGDC-E1" "Alpha-ketoglutarate dehydrogenase"))
(define-protein "O41637_9HIV1" ("V30" "Envelope glycoprotein"))
(define-protein "O95598_HUMAN" ("Fas/APO1" "<Delta>Fas/APO-1/CD95 protein"))
(define-protein "OAS1_HUMAN" ("p46-" "2'-5'-oligoadenylate synthase 1" "(2-5')oligo(A) synthase 1" "2-5A synthase 1" "E18/E16" "p46/p42 OAS"))
(define-protein "OAZ1_HUMAN" ("oaz" "Ornithine decarboxylase antizyme 1" "ODC-Az"))
(define-protein "OBRG_HUMAN" ("leptin" "Leptin receptor gene-related protein" "Endospanin-1" "Leptin receptor overlapping transcript protein" "OB-R gene-related protein" "OB-RGRP"))
(define-protein "OC90_HUMAN" ("oc" "Otoconin-90" "Oc90" "Phospholipase A2 homolog"))
(define-protein "OCLN_HUMAN" ("occludin" "Occludin"))
(define-protein "ODO1_HUMAN" ("α-ketoglutarate–" "2-oxoglutarate dehydrogenase, mitochondrial" "2-oxoglutarate dehydrogenase complex component E1" "OGDC-E1" "Alpha-ketoglutarate dehydrogenase"))
(define-protein "O41637_9HIV1" ("V30" "Envelope glycoprotein"))
(define-protein "O95598_HUMAN" ("Fas/APO1" "<Delta>Fas/APO-1/CD95 protein"))
(define-protein "OAS1_HUMAN" ("p46-" "2'-5'-oligoadenylate synthase 1" "(2-5')oligo(A) synthase 1" "2-5A synthase 1" "E18/E16" "p46/p42 OAS"))
(define-protein "OAZ1_HUMAN" ("oaz" "Ornithine decarboxylase antizyme 1" "ODC-Az"))
(define-protein "OBRG_HUMAN" ("leptin" "Leptin receptor gene-related protein" "Endospanin-1" "Leptin receptor overlapping transcript protein" "OB-R gene-related protein" "OB-RGRP"))
(define-protein "OC90_HUMAN" ("oc" "Otoconin-90" "Oc90" "Phospholipase A2 homolog"))
(define-protein "OCLN_HUMAN" ("occludin" "Occludin"))
(define-protein "ODO1_HUMAN" ("α-ketoglutarate–" "2-oxoglutarate dehydrogenase, mitochondrial" "2-oxoglutarate dehydrogenase complex component E1" "OGDC-E1" "Alpha-ketoglutarate dehydrogenase"))
(define-protein "OFD1_HUMAN" ("Oral-facial-digital syndrome 1 protein" "Protein 71-7A"))
(define-protein "OLR1_HUMAN" ("Oxidized low-density lipoprotein receptor 1" "Ox-LDL receptor 1" "C-type lectin domain family 8 member A" "Lectin-like oxidized LDL receptor 1" "LOX-1" "Lectin-like oxLDL receptor 1" "hLOX-1" "Lectin-type oxidized LDL receptor 1"))
(define-protein "OLR1_HUMAN" ("ox-LDL" "Oxidized low-density lipoprotein receptor 1" "Ox-LDL receptor 1" "C-type lectin domain family 8 member A" "Lectin-like oxidized LDL receptor 1" "LOX-1" "Lectin-like oxLDL receptor 1" "hLOX-1" "Lectin-type oxidized LDL receptor 1"))
(define-protein "OPA1_HUMAN" ("Dynamin-like 120 kDa protein, mitochondrial" "Optic atrophy protein 1"))
<<<<<<< .mine
(define-protein "OPA1_HUMAN" ("Opa1" "Dynamin-like 120 kDa protein, mitochondrial" "Optic atrophy protein 1"))
(define-protein "OPSG_HUMAN" ("opn" "Medium-wave-sensitive opsin 1" "Green cone photoreceptor pigment" "Green-sensitive opsin" "GOP"))
(define-protein "OPTN_HUMAN" ("optineurin" "Optineurin" "E3-14.7K-interacting protein" "FIP-2" "Huntingtin yeast partner L" "Huntingtin-interacting protein 7" "HIP-7" "Huntingtin-interacting protein L" "NEMO-related protein" "Optic neuropathy-inducing protein" "Transcription factor IIIA-interacting protein" "TFIIIA-IntP"))
(define-protein "OR1E1_HUMAN" ("\\or" "Olfactory receptor 1E1" "Olfactory receptor 13-66" "OR13-66" "Olfactory receptor 17-2/17-32" "OR17-2" "OR17-32" "Olfactory receptor 1E5" "Olfactory receptor 1E6" "Olfactory receptor 5-85" "OR5-85" "Olfactory receptor OR17-18" "Olfactory receptor-like protein HGMP07I"))
=======
<<<<<<< .mine
(define-protein "OPA1_HUMAN" ("Opa1" "Dynamin-like 120 kDa protein, mitochondrial" "Optic atrophy protein 1"))
(define-protein "OPSG_HUMAN" ("opn" "Medium-wave-sensitive opsin 1" "Green cone photoreceptor pigment" "Green-sensitive opsin" "GOP"))
(define-protein "OPTN_HUMAN" ("optineurin" "Optineurin" "E3-14.7K-interacting protein" "FIP-2" "Huntingtin yeast partner L" "Huntingtin-interacting protein 7" "HIP-7" "Huntingtin-interacting protein L" "NEMO-related protein" "Optic neuropathy-inducing protein" "Transcription factor IIIA-interacting protein" "TFIIIA-IntP"))
(define-protein "OR1E1_HUMAN" ("\\or" "Olfactory receptor 1E1" "Olfactory receptor 13-66" "OR13-66" "Olfactory receptor 17-2/17-32" "OR17-2" "OR17-32" "Olfactory receptor 1E5" "Olfactory receptor 1E6" "Olfactory receptor 5-85" "OR5-85" "Olfactory receptor OR17-18" "Olfactory receptor-like protein HGMP07I"))
=======
(define-protein "OPSG_HUMAN" ("Medium-wave-sensitive opsin 1" "Green cone photoreceptor pigment" "Green-sensitive opsin" "GOP"))
(define-protein "OPTN_HUMAN" ("Optineurin" "E3-14.7K-interacting protein" "FIP-2" "Huntingtin yeast partner L" "Huntingtin-interacting protein 7" "HIP-7" "Huntingtin-interacting protein L" "NEMO-related protein" "Optic neuropathy-inducing protein" "Transcription factor IIIA-interacting protein" "TFIIIA-IntP"))
(define-protein "OR1E1_HUMAN" ("Olfactory receptor 1E1" "Olfactory receptor 13-66" "OR13-66" "Olfactory receptor 17-2/17-32" "OR17-2" "OR17-32" "Olfactory receptor 1E5" "Olfactory receptor 1E6" "Olfactory receptor 5-85" "OR5-85" "Olfactory receptor OR17-18" "Olfactory receptor-like protein HGMP07I"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ORF3_HEVHY" ("Protein ORF3" "pORF3"))
(define-protein "OSB10_HUMAN" ("ORP10" "OSBP9" "ORP-10" "OSBPL10")) 
(define-protein "OSB11_HUMAN" ("OSBP12" "ORP11" "ORP-11" "OSBPL11")) 
(define-protein "OSBL3_HUMAN" ("ORP3" "ORP-3" "OSBPL3" "KIAA0704" "OSBP3")) 
(define-protein "OSBL8_HUMAN" ("ORP-8" "OSBP10" "KIAA1451" "OSBPL8" "ORP8")) 
(define-protein "OSBP1_HUMAN" ("OSBP1" "OSBP")) 
<<<<<<< .mine
(define-protein "OSTP_HUMAN" ("osteopontin" "Osteopontin" "Bone sialoprotein 1" "Nephropontin" "Secreted phosphoprotein 1" "SPP-1" "Urinary stone protein" "Uropontin"))
=======
<<<<<<< .mine
(define-protein "OSTP_HUMAN" ("osteopontin" "Osteopontin" "Bone sialoprotein 1" "Nephropontin" "Secreted phosphoprotein 1" "SPP-1" "Urinary stone protein" "Uropontin"))
=======
(define-protein "OSTP_HUMAN" ("Osteopontin" "Bone sialoprotein 1" "Nephropontin" "Secreted phosphoprotein 1" "SPP-1" "Urinary stone protein" "Uropontin"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "OTU6B_HUMAN" ("DUBA5" "DUBA-5" "OTUD6B")) 
(define-protein "OTUB1_HUMAN" ("Ubiquitin thioesterase OTUB1" "Deubiquitinating enzyme OTUB1" "OTU domain-containing ubiquitin aldehyde-binding protein 1" "Otubain-1" "hOTU1" "Ubiquitin-specific-processing protease OTUB1"))
(define-protein "OXSR1_HUMAN" ("KIAA1101" "OXSR1" "OSR1")) 
<<<<<<< .mine
(define-protein "OXYR_HUMAN" ("oxtr" "Oxytocin receptor" "OT-R"))
=======
<<<<<<< .mine
(define-protein "OXYR_HUMAN" ("oxtr" "Oxytocin receptor" "OT-R"))
=======
(define-protein "OXYR_HUMAN" ("Oxytocin receptor" "OT-R"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "P2R3B_HUMAN" ("PPP2R3B" "PPP2R3L")) 
<<<<<<< .mine
(define-protein "P2RY2_HUMAN" ("atpγs" "P2Y purinoceptor 2" "P2Y2" "ATP receptor" "P2U purinoceptor 1" "P2U1" "P2U receptor 1" "Purinergic receptor"))
=======
<<<<<<< .mine
(define-protein "P2RY2_HUMAN" ("atpγs" "P2Y purinoceptor 2" "P2Y2" "ATP receptor" "P2U purinoceptor 1" "P2U1" "P2U receptor 1" "Purinergic receptor"))
=======
(define-protein "P2RY2_HUMAN" ("P2Y purinoceptor 2" "P2Y2" "ATP receptor" "P2U purinoceptor 1" "P2U1" "P2U receptor 1" "Purinergic receptor"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "P4R3A_HUMAN" ("SMEK1" "KIAA2010" "PPP4R3A" "PP4R3A")) 
<<<<<<< .mine
(define-protein "P66B_HUMAN" ("p66" "Transcriptional repressor p66-beta" "GATA zinc finger domain-containing protein 2B" "p66/p68"))
=======
<<<<<<< .mine
(define-protein "P66B_HUMAN" ("p66" "Transcriptional repressor p66-beta" "GATA zinc finger domain-containing protein 2B" "p66/p68"))
=======
(define-protein "P66B_HUMAN" ("Transcriptional repressor p66-beta" "GATA zinc finger domain-containing protein 2B" "p66/p68"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "P73_HUMAN" ("P73" "TP73")) 
(define-protein "P73_HUMAN" ("Tumor protein p73" "p53-like transcription factor" "p53-related protein"))
(define-protein "P85B_HUMAN" ("PIK3R2")) 
(define-protein "PA24A_HUMAN" ("cPLA2" "CPLA2" "PLA2G4A" "Lysophospholipase" "PLA2G4")) 
(define-protein "PA24B_HUMAN" ("PLA2G4B" "cPLA2-beta")) 
(define-protein "PACN2_HUMAN" ("PACSIN2" "Syndapin-2" "Syndapin-II")) 
<<<<<<< .mine
(define-protein "PADI4_HUMAN" ("HL60" "Protein-arginine deiminase type-4" "HL-60 PAD" "Peptidylarginine deiminase IV" "Protein-arginine deiminase type IV"))
=======
<<<<<<< .mine
(define-protein "PADI4_HUMAN" ("HL60" "Protein-arginine deiminase type-4" "HL-60 PAD" "Peptidylarginine deiminase IV" "Protein-arginine deiminase type IV"))
=======
(define-protein "PADI4_HUMAN" ("Protein-arginine deiminase type-4" "HL-60 PAD" "Peptidylarginine deiminase IV" "Protein-arginine deiminase type IV"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PAI1_HUMAN" ("Plasminogen activator inhibitor 1" "PAI" "PAI-1" "Endothelial plasminogen activator inhibitor" "Serpin E1"))
(define-protein "PAK2_HUMAN" ("PAK-2" "Gamma-PAK" "PAK2")) 
(define-protein "PAK3_HUMAN" ("Oligophrenin-3" "PAK-3" "OPHN3" "Beta-PAK" "PAK3")) 
(define-protein "PAK4_HUMAN" ("PAK-4" "KIAA1142" "PAK4")) 
<<<<<<< .mine
(define-protein "PANX1_HUMAN" ("pannexin-1" "Pannexin-1"))
(define-protein "PAPOA_HUMAN" ("papola" "Poly(A) polymerase alpha" "PAP-alpha" "Polynucleotide adenylyltransferase alpha"))
(define-protein "PAPOG_HUMAN" ("neo" "Poly(A) polymerase gamma" "PAP-gamma" "Neo-poly(A) polymerase" "Neo-PAP" "Polynucleotide adenylyltransferase gamma" "SRP RNA 3'-adenylating enzyme"))
(define-protein "PAR16_HUMAN" ("mono-" "Mono [ADP-ribose] polymerase PARP16" "ADP-ribosyltransferase diphtheria toxin-like 15" "Poly [ADP-ribose] polymerase 16" "PARP-16"))
=======
<<<<<<< .mine
(define-protein "PANX1_HUMAN" ("pannexin-1" "Pannexin-1"))
(define-protein "PAPOA_HUMAN" ("papola" "Poly(A) polymerase alpha" "PAP-alpha" "Polynucleotide adenylyltransferase alpha"))
(define-protein "PAPOG_HUMAN" ("neo" "Poly(A) polymerase gamma" "PAP-gamma" "Neo-poly(A) polymerase" "Neo-PAP" "Polynucleotide adenylyltransferase gamma" "SRP RNA 3'-adenylating enzyme"))
(define-protein "PAR16_HUMAN" ("mono-" "Mono [ADP-ribose] polymerase PARP16" "ADP-ribosyltransferase diphtheria toxin-like 15" "Poly [ADP-ribose] polymerase 16" "PARP-16"))
=======
(define-protein "PANX1_HUMAN" ("Pannexin-1"))
(define-protein "PAPOA_HUMAN" ("Poly(A) polymerase alpha" "PAP-alpha" "Polynucleotide adenylyltransferase alpha"))
(define-protein "PAPOG_HUMAN" ("Poly(A) polymerase gamma" "PAP-gamma" "Neo-poly(A) polymerase" "Neo-PAP" "Polynucleotide adenylyltransferase gamma" "SRP RNA 3'-adenylating enzyme"))
(define-protein "PAR16_HUMAN" ("Mono [ADP-ribose] polymerase PARP16" "ADP-ribosyltransferase diphtheria toxin-like 15" "Poly [ADP-ribose] polymerase 16" "PARP-16"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PAR6A_HUMAN" ("Partitioning defective 6 homolog alpha" "PAR-6" "PAR-6 alpha" "PAR-6A" "PAR6C" "Tax interaction protein 40" "TIP-40"))
(define-protein "PAR6A_HUMAN" ("pkcζ" "Partitioning defective 6 homolog alpha" "PAR-6" "PAR-6 alpha" "PAR-6A" "PAR6C" "Tax interaction protein 40" "TIP-40"))
(define-protein "PARD3_HUMAN" ("Partitioning defective 3 homolog" "PAR-3" "PARD-3" "Atypical PKC isotype-specific-interacting protein" "ASIP" "CTCL tumor antigen se2-5" "PAR3-alpha"))
<<<<<<< .mine
(define-protein "PARK7_HUMAN" ("Dj-1" "Protein deglycase DJ-1" "DJ-1" "Oncogene DJ1" "Parkinson disease protein 7"))
=======
<<<<<<< .mine
(define-protein "PARK7_HUMAN" ("Dj-1" "Protein deglycase DJ-1" "DJ-1" "Oncogene DJ1" "Parkinson disease protein 7"))
=======
(define-protein "PARK7_HUMAN" ("Protein deglycase DJ-1" "DJ-1" "Oncogene DJ1" "Parkinson disease protein 7"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PARP1_HUMAN" ("Poly [ADP-ribose] polymerase 1" "PARP-1" "ADP-ribosyltransferase diphtheria toxin-like 1" "ARTD1" "NAD(+) ADP-ribosyltransferase 1" "ADPRT 1" "Poly[ADP-ribose] synthase 1"))
<<<<<<< .mine
(define-protein "PARPT_HUMAN" ("tcdd" "TCDD-inducible poly [ADP-ribose] polymerase" "ADP-ribosyltransferase diphtheria toxin-like 14" "ARTD14" "Poly [ADP-ribose] polymerase 7" "PARP-7"))
(define-protein "PARVA_HUMAN" ("actopaxin" "Alpha-parvin" "Actopaxin" "CH-ILKBP" "Calponin-like integrin-linked kinase-binding protein" "Matrix-remodeling-associated protein 2"))
=======
<<<<<<< .mine
(define-protein "PARPT_HUMAN" ("tcdd" "TCDD-inducible poly [ADP-ribose] polymerase" "ADP-ribosyltransferase diphtheria toxin-like 14" "ARTD14" "Poly [ADP-ribose] polymerase 7" "PARP-7"))
(define-protein "PARVA_HUMAN" ("actopaxin" "Alpha-parvin" "Actopaxin" "CH-ILKBP" "Calponin-like integrin-linked kinase-binding protein" "Matrix-remodeling-associated protein 2"))
=======
(define-protein "PARPT_HUMAN" ("TCDD-inducible poly [ADP-ribose] polymerase" "ADP-ribosyltransferase diphtheria toxin-like 14" "ARTD14" "Poly [ADP-ribose] polymerase 7" "PARP-7"))
(define-protein "PARVA_HUMAN" ("Alpha-parvin" "Actopaxin" "CH-ILKBP" "Calponin-like integrin-linked kinase-binding protein" "Matrix-remodeling-associated protein 2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PAX3_HUMAN" ("Paired box protein Pax-3" "HuP2"))
<<<<<<< .mine
(define-protein "PAX3_HUMAN" ("Pax3" "Paired box protein Pax-3" "HuP2"))
(define-protein "PAX5_HUMAN" ("bsap" "Paired box protein Pax-5" "B-cell-specific transcription factor" "BSAP"))
=======
<<<<<<< .mine
(define-protein "PAX3_HUMAN" ("Pax3" "Paired box protein Pax-3" "HuP2"))
(define-protein "PAX5_HUMAN" ("bsap" "Paired box protein Pax-5" "B-cell-specific transcription factor" "BSAP"))
=======
(define-protein "PAX5_HUMAN" ("Paired box protein Pax-5" "B-cell-specific transcription factor" "BSAP"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PAX6_HUMAN" ("Paired box protein Pax-6" "Aniridia type II protein" "Oculorhombin"))
(define-protein "PAX6_HUMAN" ("Pax6" "Paired box protein Pax-6" "Aniridia type II protein" "Oculorhombin"))
(define-protein "PAX7_HUMAN" ("Paired box protein Pax-7" "HuP1"))
<<<<<<< .mine
(define-protein "PAX7_HUMAN" ("Pax7" "Paired box protein Pax-7" "HuP1"))
(define-protein "PAXI_HUMAN" ("paxillin" "Paxillin"))
(define-protein "PBX1_HUMAN" ("Pbx1" "Pre-B-cell leukemia transcription factor 1" "Homeobox protein PBX1" "Homeobox protein PRL"))
(define-protein "PC11X_HUMAN" ("protocadherins" "Protocadherin-11 X-linked" "Protocadherin-11" "Protocadherin on the X chromosome" "PCDH-X" "Protocadherin-S"))
=======
<<<<<<< .mine
(define-protein "PAX7_HUMAN" ("Pax7" "Paired box protein Pax-7" "HuP1"))
(define-protein "PAXI_HUMAN" ("paxillin" "Paxillin"))
(define-protein "PBX1_HUMAN" ("Pbx1" "Pre-B-cell leukemia transcription factor 1" "Homeobox protein PBX1" "Homeobox protein PRL"))
(define-protein "PC11X_HUMAN" ("protocadherins" "Protocadherin-11 X-linked" "Protocadherin-11" "Protocadherin on the X chromosome" "PCDH-X" "Protocadherin-S"))
=======
(define-protein "PAXI_HUMAN" ("Paxillin"))
(define-protein "PBX1_HUMAN" ("Pre-B-cell leukemia transcription factor 1" "Homeobox protein PBX1" "Homeobox protein PRL"))
(define-protein "PC11X_HUMAN" ("Protocadherin-11 X-linked" "Protocadherin-11" "Protocadherin on the X chromosome" "PCDH-X" "Protocadherin-S"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PCAT2_HUMAN" ("LPCAT-2" "AGPAT11" "AYTL1" "LysoPAFAT" "LPAAT-alpha" "LPCAT2")) 
<<<<<<< .mine
(define-protein "PCDB5_HUMAN" ("β5" "Protocadherin beta-5" "PCDH-beta-5"))
(define-protein "PCGF1_HUMAN" ("NSPC1" "Polycomb group RING finger protein 1" "Nervous system Polycomb-1" "NSPc1" "RING finger protein 68"))
=======
<<<<<<< .mine
(define-protein "PCDB5_HUMAN" ("β5" "Protocadherin beta-5" "PCDH-beta-5"))
(define-protein "PCGF1_HUMAN" ("NSPC1" "Polycomb group RING finger protein 1" "Nervous system Polycomb-1" "NSPc1" "RING finger protein 68"))
=======
(define-protein "PCDB5_HUMAN" ("Protocadherin beta-5" "PCDH-beta-5"))
(define-protein "PCGF1_HUMAN" ("Polycomb group RING finger protein 1" "Nervous system Polycomb-1" "NSPc1" "RING finger protein 68"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PCGF2_HUMAN" ("Polycomb group RING finger protein 2" "DNA-binding protein Mel-18" "RING finger protein 110" "Zinc finger protein 144"))
<<<<<<< .mine
(define-protein "PCGF6_HUMAN" ("mblr" "Polycomb group RING finger protein 6" "Mel18 and Bmi1-like RING finger" "RING finger protein 134"))
(define-protein "PCH2_HUMAN" ("pch" "Pachytene checkpoint protein 2 homolog" "Human papillomavirus type 16 E1 protein-binding protein" "16E1-BP" "HPV16 E1 protein-binding protein" "Thyroid hormone receptor interactor 13" "Thyroid receptor-interacting protein 13" "TR-interacting protein 13" "TRIP-13"))
(define-protein "PCKGC_HUMAN" ("pepck" "Phosphoenolpyruvate carboxykinase, cytosolic [GTP]" "PEPCK-C"))
=======
<<<<<<< .mine
(define-protein "PCGF6_HUMAN" ("mblr" "Polycomb group RING finger protein 6" "Mel18 and Bmi1-like RING finger" "RING finger protein 134"))
(define-protein "PCH2_HUMAN" ("pch" "Pachytene checkpoint protein 2 homolog" "Human papillomavirus type 16 E1 protein-binding protein" "16E1-BP" "HPV16 E1 protein-binding protein" "Thyroid hormone receptor interactor 13" "Thyroid receptor-interacting protein 13" "TR-interacting protein 13" "TRIP-13"))
(define-protein "PCKGC_HUMAN" ("pepck" "Phosphoenolpyruvate carboxykinase, cytosolic [GTP]" "PEPCK-C"))
=======
(define-protein "PCGF6_HUMAN" ("Polycomb group RING finger protein 6" "Mel18 and Bmi1-like RING finger" "RING finger protein 134"))
(define-protein "PCH2_HUMAN" ("Pachytene checkpoint protein 2 homolog" "Human papillomavirus type 16 E1 protein-binding protein" "16E1-BP" "HPV16 E1 protein-binding protein" "Thyroid hormone receptor interactor 13" "Thyroid receptor-interacting protein 13" "TR-interacting protein 13" "TRIP-13"))
(define-protein "PCKGC_HUMAN" ("Phosphoenolpyruvate carboxykinase, cytosolic [GTP]" "PEPCK-C"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PCLO_HUMAN" ("KIAA0559" "Aczonin" "PCLO" "ACZ")) 
(define-protein "PCM1_HUMAN" ("Pericentriolar material 1 protein" "PCM-1" "hPCM-1"))
(define-protein "PCTL_HUMAN" ("StARD10" "PCTP-L" "SDCCAG28" "STARD10")) 
<<<<<<< .mine
(define-protein "PCX3_HUMAN" ("pcx" "Pecanex-like protein 3"))
=======
<<<<<<< .mine
(define-protein "PCX3_HUMAN" ("pcx" "Pecanex-like protein 3"))
=======
(define-protein "PCX3_HUMAN" ("Pecanex-like protein 3"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PCYOX_HUMAN" ("PCL1" "PCYOX1" "KIAA0908")) 
<<<<<<< .mine
(define-protein "PD2R2_HUMAN" ("Th2" "Prostaglandin D2 receptor 2" "Chemoattractant receptor-homologous molecule expressed on Th2 cells" "G-protein coupled receptor 44"))
=======
<<<<<<< .mine
(define-protein "PD2R2_HUMAN" ("Th2" "Prostaglandin D2 receptor 2" "Chemoattractant receptor-homologous molecule expressed on Th2 cells" "G-protein coupled receptor 44"))
=======
(define-protein "PD2R2_HUMAN" ("Prostaglandin D2 receptor 2" "Chemoattractant receptor-homologous molecule expressed on Th2 cells" "G-protein coupled receptor 44"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PDC10_HUMAN" ("CCM3" "TFAR15" "PDCD10")) 
<<<<<<< .mine
(define-protein "PDC6I_HUMAN" ("ypx" "Programmed cell death 6-interacting protein" "PDCD6-interacting protein" "ALG-2-interacting protein 1" "ALG-2-interacting protein X" "Hp95"))
=======
<<<<<<< .mine
(define-protein "PDC6I_HUMAN" ("ypx" "Programmed cell death 6-interacting protein" "PDCD6-interacting protein" "ALG-2-interacting protein 1" "ALG-2-interacting protein X" "Hp95"))
=======
(define-protein "PDC6I_HUMAN" ("Programmed cell death 6-interacting protein" "PDCD6-interacting protein" "ALG-2-interacting protein 1" "ALG-2-interacting protein X" "Hp95"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PDCD4_HUMAN" ("H731" "PDCD4")) 
(define-protein "PDCD6_HUMAN" ("ALG2" "PDCD6")) 
<<<<<<< .mine
(define-protein "PDE4D_HUMAN" ("phosphodiesterases" "cAMP-specific 3',5'-cyclic phosphodiesterase 4D" "DPDE3" "PDE43"))
=======
<<<<<<< .mine
(define-protein "PDE4D_HUMAN" ("phosphodiesterases" "cAMP-specific 3',5'-cyclic phosphodiesterase 4D" "DPDE3" "PDE43"))
=======
(define-protein "PDE4D_HUMAN" ("cAMP-specific 3',5'-cyclic phosphodiesterase 4D" "DPDE3" "PDE43"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PDE6D_HUMAN" ("PDE6D" "PDED")) 
<<<<<<< .mine
(define-protein "PDGFD_HUMAN" ("seen" "Platelet-derived growth factor D" "PDGF-D" "Iris-expressed growth factor" "Spinal cord-derived growth factor B" "SCDGF-B"))
(define-protein "PDIA3_HUMAN" ("ER-" "Protein disulfide-isomerase A3" "58 kDa glucose-regulated protein" "58 kDa microsomal protein" "p58" "Disulfide isomerase ER-60" "Endoplasmic reticulum resident protein 57" "ER protein 57" "ERp57" "Endoplasmic reticulum resident protein 60" "ER protein 60" "ERp60"))
(define-protein "PDIA6_HUMAN" ("P5" "Protein disulfide-isomerase A6" "Endoplasmic reticulum protein 5" "ER protein 5" "ERp5" "Protein disulfide isomerase P5" "Thioredoxin domain-containing protein 7"))
(define-protein "PDK4_HUMAN" ("Pdk4" "[Pyruvate dehydrogenase (acetyl-transferring)] kinase isozyme 4, mitochondrial" "Pyruvate dehydrogenase kinase isoform 4"))
(define-protein "PDPN_HUMAN" ("podoplanin" "Podoplanin" "Aggrus" "Glycoprotein 36" "Gp36" "PA2.26 antigen" "T1-alpha" "T1A"))
=======
<<<<<<< .mine
(define-protein "PDGFD_HUMAN" ("seen" "Platelet-derived growth factor D" "PDGF-D" "Iris-expressed growth factor" "Spinal cord-derived growth factor B" "SCDGF-B"))
(define-protein "PDIA3_HUMAN" ("ER-" "Protein disulfide-isomerase A3" "58 kDa glucose-regulated protein" "58 kDa microsomal protein" "p58" "Disulfide isomerase ER-60" "Endoplasmic reticulum resident protein 57" "ER protein 57" "ERp57" "Endoplasmic reticulum resident protein 60" "ER protein 60" "ERp60"))
(define-protein "PDIA6_HUMAN" ("P5" "Protein disulfide-isomerase A6" "Endoplasmic reticulum protein 5" "ER protein 5" "ERp5" "Protein disulfide isomerase P5" "Thioredoxin domain-containing protein 7"))
(define-protein "PDK4_HUMAN" ("Pdk4" "[Pyruvate dehydrogenase (acetyl-transferring)] kinase isozyme 4, mitochondrial" "Pyruvate dehydrogenase kinase isoform 4"))
(define-protein "PDPN_HUMAN" ("podoplanin" "Podoplanin" "Aggrus" "Glycoprotein 36" "Gp36" "PA2.26 antigen" "T1-alpha" "T1A"))
=======
(define-protein "PDGFD_HUMAN" ("Platelet-derived growth factor D" "PDGF-D" "Iris-expressed growth factor" "Spinal cord-derived growth factor B" "SCDGF-B"))
(define-protein "PDIA3_HUMAN" ("Protein disulfide-isomerase A3" "58 kDa glucose-regulated protein" "58 kDa microsomal protein" "p58" "Disulfide isomerase ER-60" "Endoplasmic reticulum resident protein 57" "ER protein 57" "ERp57" "Endoplasmic reticulum resident protein 60" "ER protein 60" "ERp60"))
(define-protein "PDIA6_HUMAN" ("Protein disulfide-isomerase A6" "Endoplasmic reticulum protein 5" "ER protein 5" "ERp5" "Protein disulfide isomerase P5" "Thioredoxin domain-containing protein 7"))
(define-protein "PDK4_HUMAN" ("[Pyruvate dehydrogenase (acetyl-transferring)] kinase isozyme 4, mitochondrial" "Pyruvate dehydrogenase kinase isoform 4"))
(define-protein "PDPN_HUMAN" ("Podoplanin" "Aggrus" "Glycoprotein 36" "Gp36" "PA2.26 antigen" "T1-alpha" "T1A"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PDS5A_HUMAN" ("PDS5A" "SCC-112" "PDS5" "KIAA0648")) 
(define-protein "PDS5B_HUMAN" ("PDS5B" "APRIN" "KIAA0979" "AS3")) 
(define-protein "PDZD8_HUMAN" ("PDZK8" "PDZD8")) 
<<<<<<< .mine
(define-protein "PE2R1_HUMAN" ("EP1" "Prostaglandin E2 receptor EP1 subtype" "PGE receptor EP1 subtype" "PGE2 receptor EP1 subtype" "Prostanoid EP1 receptor"))
(define-protein "PE2R3_HUMAN" ("pge" "Prostaglandin E2 receptor EP3 subtype" "PGE receptor EP3 subtype" "PGE2 receptor EP3 subtype" "PGE2-R" "Prostanoid EP3 receptor"))
(define-protein "PE2R4_HUMAN" ("EP4" "Prostaglandin E2 receptor EP4 subtype" "PGE receptor EP4 subtype" "PGE2 receptor EP4 subtype" "Prostanoid EP4 receptor"))
=======
<<<<<<< .mine
(define-protein "PE2R1_HUMAN" ("EP1" "Prostaglandin E2 receptor EP1 subtype" "PGE receptor EP1 subtype" "PGE2 receptor EP1 subtype" "Prostanoid EP1 receptor"))
(define-protein "PE2R3_HUMAN" ("pge" "Prostaglandin E2 receptor EP3 subtype" "PGE receptor EP3 subtype" "PGE2 receptor EP3 subtype" "PGE2-R" "Prostanoid EP3 receptor"))
(define-protein "PE2R4_HUMAN" ("EP4" "Prostaglandin E2 receptor EP4 subtype" "PGE receptor EP4 subtype" "PGE2 receptor EP4 subtype" "Prostanoid EP4 receptor"))
=======
(define-protein "PE2R1_HUMAN" ("Prostaglandin E2 receptor EP1 subtype" "PGE receptor EP1 subtype" "PGE2 receptor EP1 subtype" "Prostanoid EP1 receptor"))
(define-protein "PE2R3_HUMAN" ("Prostaglandin E2 receptor EP3 subtype" "PGE receptor EP3 subtype" "PGE2 receptor EP3 subtype" "PGE2-R" "Prostanoid EP3 receptor"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PE2R4_HUMAN" ("Prostaglandin E2 receptor EP4 subtype" "PGE receptor EP4 subtype" "PGE2 receptor EP4 subtype" "Prostanoid EP4 receptor"))
<<<<<<< .mine
(define-protein "PEA15_HUMAN" ("astrocytes" "Astrocytic phosphoprotein PEA-15" "15 kDa phosphoprotein enriched in astrocytes" "Phosphoprotein enriched in diabetes" "PED"))
(define-protein "PEBB_HUMAN" ("enhancers" "Core-binding factor subunit beta" "CBF-beta" "Polyomavirus enhancer-binding protein 2 beta subunit" "PEA2-beta" "PEBP2-beta" "SL3-3 enhancer factor 1 subunit beta" "SL3/AKV core-binding factor beta subunit"))
=======
<<<<<<< .mine
(define-protein "PEA15_HUMAN" ("astrocytes" "Astrocytic phosphoprotein PEA-15" "15 kDa phosphoprotein enriched in astrocytes" "Phosphoprotein enriched in diabetes" "PED"))
(define-protein "PEBB_HUMAN" ("enhancers" "Core-binding factor subunit beta" "CBF-beta" "Polyomavirus enhancer-binding protein 2 beta subunit" "PEA2-beta" "PEBP2-beta" "SL3-3 enhancer factor 1 subunit beta" "SL3/AKV core-binding factor beta subunit"))
=======
(define-protein "PEA15_HUMAN" ("Astrocytic phosphoprotein PEA-15" "15 kDa phosphoprotein enriched in astrocytes" "Phosphoprotein enriched in diabetes" "PED"))
(define-protein "PEBB_HUMAN" ("Core-binding factor subunit beta" "CBF-beta" "Polyomavirus enhancer-binding protein 2 beta subunit" "PEA2-beta" "PEBP2-beta" "SL3-3 enhancer factor 1 subunit beta" "SL3/AKV core-binding factor beta subunit"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PEBP1_HUMAN" ("PBP" "HCNPpp" "PEBP1" "PEBP" "HCNP" "RKIP" "PEBP-1")) 
(define-protein "PEBP4_HUMAN" ("CORK1" "hPEBP4" "PEBP4" "PEBP-4")) 
<<<<<<< .mine
(define-protein "PEO1_HUMAN" ("replisome" "Twinkle protein, mitochondrial" "Progressive external ophthalmoplegia 1 protein" "T7 gp4-like protein with intramitochondrial nucleoid localization" "T7-like mitochondrial DNA helicase"))
(define-protein "PEPL_HUMAN" ("ppl" "Periplakin" "190 kDa paraneoplastic pemphigus antigen" "195 kDa cornified envelope precursor protein"))
=======
<<<<<<< .mine
(define-protein "PEO1_HUMAN" ("replisome" "Twinkle protein, mitochondrial" "Progressive external ophthalmoplegia 1 protein" "T7 gp4-like protein with intramitochondrial nucleoid localization" "T7-like mitochondrial DNA helicase"))
(define-protein "PEPL_HUMAN" ("ppl" "Periplakin" "190 kDa paraneoplastic pemphigus antigen" "195 kDa cornified envelope precursor protein"))
=======
(define-protein "PEO1_HUMAN" ("Twinkle protein, mitochondrial" "Progressive external ophthalmoplegia 1 protein" "T7 gp4-like protein with intramitochondrial nucleoid localization" "T7-like mitochondrial DNA helicase"))
(define-protein "PEPL_HUMAN" ("Periplakin" "190 kDa paraneoplastic pemphigus antigen" "195 kDa cornified envelope precursor protein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PERM1_HUMAN" ("PGC-1 and ERR-induced regulator in muscle protein 1" "PPARGC1 and ESRR-induced regulator in muscle 1" "Peroxisome proliferator-activated receptor gamma coactivator 1 and estrogen-related receptor-induced regulator in muscle 1"))
<<<<<<< .mine
(define-protein "PERM_HUMAN" ("mpo" "Myeloperoxidase" "MPO"))
=======
<<<<<<< .mine
(define-protein "PERM_HUMAN" ("mpo" "Myeloperoxidase" "MPO"))
=======
(define-protein "PERM_HUMAN" ("Myeloperoxidase" "MPO"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PERQ2_HUMAN" ("GIGYF2" "KIAA0642" "PERQ2" "TNRC15")) 
<<<<<<< .mine
(define-protein "PEX1_HUMAN" ("peroxisome" "Peroxisome biogenesis factor 1" "Peroxin-1" "Peroxisome biogenesis disorder protein 1"))
=======
<<<<<<< .mine
(define-protein "PEX1_HUMAN" ("peroxisome" "Peroxisome biogenesis factor 1" "Peroxin-1" "Peroxisome biogenesis disorder protein 1"))
=======
(define-protein "PEX1_HUMAN" ("Peroxisome biogenesis factor 1" "Peroxin-1" "Peroxisome biogenesis disorder protein 1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PFKAL_HUMAN" ("ATP-PFK" "PFK-B" "PFK-L" "Phosphohexokinase" "PFKL")) 
(define-protein "PFKAP_HUMAN" ("PFKF" "PFK-C" "ATP-PFK" "Phosphohexokinase" "PFKP" "PFK-P")) 
(define-protein "PGAM1_HUMAN" ("PGAMA" "PGAM-B" "PGAM1")) 
(define-protein "PGAM5_HUMAN" ("PGAM5")) 
<<<<<<< .mine
(define-protein "PGBM_HUMAN" ("LG3" "Basement membrane-specific heparan sulfate proteoglycan core protein" "HSPG" "Perlecan" "PLC"))
(define-protein "PGES2_HUMAN" ("prostaglandin" "Prostaglandin E synthase 2" "Membrane-associated prostaglandin E synthase-2" "mPGE synthase-2" "Microsomal prostaglandin E synthase 2" "mPGES-2" "Prostaglandin-H(2) E-isomerase"))
(define-protein "PGFRA_HUMAN" ("pdgfrα" "Platelet-derived growth factor receptor alpha" "PDGF-R-alpha" "PDGFR-alpha" "Alpha platelet-derived growth factor receptor" "Alpha-type platelet-derived growth factor receptor" "CD140 antigen-like family member A" "CD140a antigen" "Platelet-derived growth factor alpha receptor" "Platelet-derived growth factor receptor 2" "PDGFR-2"))
(define-protein "PGFRB_HUMAN" ("pdgfrbeta" "Platelet-derived growth factor receptor beta" "PDGF-R-beta" "PDGFR-beta" "Beta platelet-derived growth factor receptor" "Beta-type platelet-derived growth factor receptor" "CD140 antigen-like family member B" "Platelet-derived growth factor receptor 1" "PDGFR-1"))
(define-protein "PGH1_HUMAN" ("Cox1" "Prostaglandin G/H synthase 1" "Cyclooxygenase-1" "COX-1" "Prostaglandin H2 synthase 1" "PGH synthase 1" "PGHS-1" "PHS 1" "Prostaglandin-endoperoxide synthase 1"))
(define-protein "PGK1_HUMAN" ("Mig-10" "Phosphoglycerate kinase 1" "Cell migration-inducing gene 10 protein" "Primer recognition protein 2" "PRP 2"))
=======
<<<<<<< .mine
(define-protein "PGBM_HUMAN" ("LG3" "Basement membrane-specific heparan sulfate proteoglycan core protein" "HSPG" "Perlecan" "PLC"))
(define-protein "PGES2_HUMAN" ("prostaglandin" "Prostaglandin E synthase 2" "Membrane-associated prostaglandin E synthase-2" "mPGE synthase-2" "Microsomal prostaglandin E synthase 2" "mPGES-2" "Prostaglandin-H(2) E-isomerase"))
(define-protein "PGFRA_HUMAN" ("pdgfrα" "Platelet-derived growth factor receptor alpha" "PDGF-R-alpha" "PDGFR-alpha" "Alpha platelet-derived growth factor receptor" "Alpha-type platelet-derived growth factor receptor" "CD140 antigen-like family member A" "CD140a antigen" "Platelet-derived growth factor alpha receptor" "Platelet-derived growth factor receptor 2" "PDGFR-2"))
(define-protein "PGFRB_HUMAN" ("pdgfrbeta" "Platelet-derived growth factor receptor beta" "PDGF-R-beta" "PDGFR-beta" "Beta platelet-derived growth factor receptor" "Beta-type platelet-derived growth factor receptor" "CD140 antigen-like family member B" "Platelet-derived growth factor receptor 1" "PDGFR-1"))
(define-protein "PGH1_HUMAN" ("Cox1" "Prostaglandin G/H synthase 1" "Cyclooxygenase-1" "COX-1" "Prostaglandin H2 synthase 1" "PGH synthase 1" "PGHS-1" "PHS 1" "Prostaglandin-endoperoxide synthase 1"))
(define-protein "PGK1_HUMAN" ("Mig-10" "Phosphoglycerate kinase 1" "Cell migration-inducing gene 10 protein" "Primer recognition protein 2" "PRP 2"))
=======
(define-protein "PGBM_HUMAN" ("Basement membrane-specific heparan sulfate proteoglycan core protein" "HSPG" "Perlecan" "PLC"))
(define-protein "PGES2_HUMAN" ("Prostaglandin E synthase 2" "Membrane-associated prostaglandin E synthase-2" "mPGE synthase-2" "Microsomal prostaglandin E synthase 2" "mPGES-2" "Prostaglandin-H(2) E-isomerase"))
(define-protein "PGFRA_HUMAN" ("Platelet-derived growth factor receptor alpha" "PDGF-R-alpha" "PDGFR-alpha" "Alpha platelet-derived growth factor receptor" "Alpha-type platelet-derived growth factor receptor" "CD140 antigen-like family member A" "CD140a antigen" "Platelet-derived growth factor alpha receptor" "Platelet-derived growth factor receptor 2" "PDGFR-2"))
(define-protein "PGFRB_HUMAN" ("Platelet-derived growth factor receptor beta" "PDGF-R-beta" "PDGFR-beta" "Beta platelet-derived growth factor receptor" "Beta-type platelet-derived growth factor receptor" "CD140 antigen-like family member B" "Platelet-derived growth factor receptor 1" "PDGFR-1"))
(define-protein "PGH1_HUMAN" ("Prostaglandin G/H synthase 1" "Cyclooxygenase-1" "COX-1" "Prostaglandin H2 synthase 1" "PGH synthase 1" "PGHS-1" "PHS 1" "Prostaglandin-endoperoxide synthase 1"))
(define-protein "PGK1_HUMAN" ("Phosphoglycerate kinase 1" "Cell migration-inducing gene 10 protein" "Primer recognition protein 2" "PRP 2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PGTB1_HUMAN" ("PGGT1B" "GGTase-I-beta")) 
(define-protein "PHAR4_HUMAN" ("PHACTR4")) 
(define-protein "PHB2_HUMAN" ("BAP" "D-prohibitin" "PHB2" "REA")) 
(define-protein "PHB_HUMAN" ("PHB")) 
<<<<<<< .mine
(define-protein "PHF1_HUMAN" ("PHF-1" "PHD finger protein 1" "Protein PHF1" "hPHF1" "Polycomb-like protein 1" "hPCl1"))
=======
<<<<<<< .mine
(define-protein "PHF1_HUMAN" ("PHF-1" "PHD finger protein 1" "Protein PHF1" "hPHF1" "Polycomb-like protein 1" "hPCl1"))
=======
(define-protein "PHF1_HUMAN" ("PHD finger protein 1" "Protein PHF1" "hPHF1" "Polycomb-like protein 1" "hPCl1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PHLA2_HUMAN" ("PHLDA2" "BWR1C" "p17-BWR1C" "HLDA2" "TSSC3" "IPL")) 
(define-protein "PHLA3_HUMAN" ("PHLDA3" "TIH1")) 
(define-protein "PHLB1_HUMAN" ("PHLDB1" "KIAA0638" "LL5A")) 
<<<<<<< .mine
(define-protein "PHLP_HUMAN" ("phlp" "Phosducin-like protein" "PHLP"))
(define-protein "PHOP2_HUMAN" ("phospho-" "Pyridoxal phosphate phosphatase PHOSPHO2"))
(define-protein "PHX2B_HUMAN" ("phox" "Paired mesoderm homeobox protein 2B" "Neuroblastoma Phox" "NBPhox" "PHOX2B homeodomain protein" "Paired-like homeobox 2B"))
=======
<<<<<<< .mine
(define-protein "PHLP_HUMAN" ("phlp" "Phosducin-like protein" "PHLP"))
(define-protein "PHOP2_HUMAN" ("phospho-" "Pyridoxal phosphate phosphatase PHOSPHO2"))
(define-protein "PHX2B_HUMAN" ("phox" "Paired mesoderm homeobox protein 2B" "Neuroblastoma Phox" "NBPhox" "PHOX2B homeodomain protein" "Paired-like homeobox 2B"))
=======
(define-protein "PHLP_HUMAN" ("Phosducin-like protein" "PHLP"))
(define-protein "PHOP2_HUMAN" ("Pyridoxal phosphate phosphatase PHOSPHO2"))
(define-protein "PHX2B_HUMAN" ("Paired mesoderm homeobox protein 2B" "Neuroblastoma Phox" "NBPhox" "PHOX2B homeodomain protein" "Paired-like homeobox 2B"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PI3R4_HUMAN" ("PIK3R4")) 
<<<<<<< .mine
(define-protein "PI42A_HUMAN" ("ptdins" "Phosphatidylinositol 5-phosphate 4-kinase type-2 alpha" "1-phosphatidylinositol 5-phosphate 4-kinase 2-alpha" "Diphosphoinositide kinase 2-alpha" "PIP5KIII" "Phosphatidylinositol 5-phosphate 4-kinase type II alpha" "PI(5)P 4-kinase type II alpha" "PIP4KII-alpha" "PtdIns(4)P-5-kinase B isoform" "PtdIns(4)P-5-kinase C isoform" "PtdIns(5)P-4-kinase isoform 2-alpha"))
(define-protein "PI51C_HUMAN" ("pipkiγ" "Phosphatidylinositol 4-phosphate 5-kinase type-1 gamma" "PIP5K1-gamma" "PtdIns(4)P-5-kinase 1 gamma" "Phosphatidylinositol 4-phosphate 5-kinase type I gamma" "PIP5KIgamma"))
=======
<<<<<<< .mine
(define-protein "PI42A_HUMAN" ("ptdins" "Phosphatidylinositol 5-phosphate 4-kinase type-2 alpha" "1-phosphatidylinositol 5-phosphate 4-kinase 2-alpha" "Diphosphoinositide kinase 2-alpha" "PIP5KIII" "Phosphatidylinositol 5-phosphate 4-kinase type II alpha" "PI(5)P 4-kinase type II alpha" "PIP4KII-alpha" "PtdIns(4)P-5-kinase B isoform" "PtdIns(4)P-5-kinase C isoform" "PtdIns(5)P-4-kinase isoform 2-alpha"))
(define-protein "PI51C_HUMAN" ("pipkiγ" "Phosphatidylinositol 4-phosphate 5-kinase type-1 gamma" "PIP5K1-gamma" "PtdIns(4)P-5-kinase 1 gamma" "Phosphatidylinositol 4-phosphate 5-kinase type I gamma" "PIP5KIgamma"))
=======
(define-protein "PI42A_HUMAN" ("Phosphatidylinositol 5-phosphate 4-kinase type-2 alpha" "1-phosphatidylinositol 5-phosphate 4-kinase 2-alpha" "Diphosphoinositide kinase 2-alpha" "PIP5KIII" "Phosphatidylinositol 5-phosphate 4-kinase type II alpha" "PI(5)P 4-kinase type II alpha" "PIP4KII-alpha" "PtdIns(4)P-5-kinase B isoform" "PtdIns(4)P-5-kinase C isoform" "PtdIns(5)P-4-kinase isoform 2-alpha"))
(define-protein "PI51C_HUMAN" ("Phosphatidylinositol 4-phosphate 5-kinase type-1 gamma" "PIP5K1-gamma" "PtdIns(4)P-5-kinase 1 gamma" "Phosphatidylinositol 4-phosphate 5-kinase type I gamma" "PIP5KIgamma"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PICK1_HUMAN" ("PRKCABP" "PICK1")) 
(define-protein "PIGS_HUMAN" ("PIGS")) 
<<<<<<< .mine
(define-protein "PIM1_HUMAN" ("LY-294002" "Serine/threonine-protein kinase pim-1"))
=======
<<<<<<< .mine
(define-protein "PIM1_HUMAN" ("LY-294002" "Serine/threonine-protein kinase pim-1"))
=======
(define-protein "PIM1_HUMAN" ("Serine/threonine-protein kinase pim-1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PIN1_HUMAN" ("PIN1")) 
(define-protein "PIN1_HUMAN" ("Peptidyl-prolyl cis-trans isomerase NIMA-interacting 1" "Peptidyl-prolyl cis-trans isomerase Pin1" "PPIase Pin1" "Rotamase Pin1"))
(define-protein "PIN4_HUMAN" ("hPar17" "Par14" "hPar14" "Parvulin-17" "Par17" "Parvulin-14" "hEPVH" "PIN4")) 
(define-protein "PINK1_HUMAN" ("Serine/threonine-protein kinase PINK1, mitochondrial" "BRPK" "PTEN-induced putative kinase protein 1"))
(define-protein "PIPNB_HUMAN" ("PI-TP-beta" "PITPNB")) 
(define-protein "PIP_HUMAN" ("gp17" "GCDFP-15" "SABP" "PIP" "GPIP4" "GCDFP15")) 
(define-protein "PITM1_HUMAN" ("Membrane-associated phosphatidylinositol transfer protein 1" "Drosophila retinal degeneration B homolog" "Phosphatidylinositol transfer protein, membrane-associated 1" "PITPnm 1" "Pyk2 N-terminal domain-interacting receptor 2" "NIR-2"))
(define-protein "PITM1_HUMAN" ("NIR-2" "PITPNM" "PITPNM1" "NIR2" "DRES9")) 
<<<<<<< .mine
(define-protein "PITX2_HUMAN" ("Pitx2" "Pituitary homeobox 2" "ALL1-responsive protein ARP1" "Homeobox protein PITX2" "Paired-like homeodomain transcription factor 2" "RIEG bicoid-related homeobox transcription factor" "Solurshin"))
(define-protein "PK3C3_HUMAN" ("type-3" "Phosphatidylinositol 3-kinase catalytic subunit type 3" "PI3-kinase type 3" "PI3K type 3" "PtdIns-3-kinase type 3" "Phosphatidylinositol 3-kinase p100 subunit" "Phosphoinositide-3-kinase class 3" "hVps34"))
(define-protein "PK3CA_HUMAN" ("nSH2" "Phosphatidylinositol 4,5-bisphosphate 3-kinase catalytic subunit alpha isoform" "PI3-kinase subunit alpha" "PI3K-alpha" "PI3Kalpha" "PtdIns-3-kinase subunit alpha" "Phosphatidylinositol 4,5-bisphosphate 3-kinase 110 kDa catalytic subunit alpha" "PtdIns-3-kinase subunit p110-alpha" "p110alpha" "Phosphoinositide-3-kinase catalytic alpha polypeptide" "Serine/threonine protein kinase PIK3CA"))
(define-protein "PK3CB_HUMAN" ("iSH2" "Phosphatidylinositol 4,5-bisphosphate 3-kinase catalytic subunit beta isoform" "PI3-kinase subunit beta" "PI3K-beta" "PI3Kbeta" "PtdIns-3-kinase subunit beta" "Phosphatidylinositol 4,5-bisphosphate 3-kinase 110 kDa catalytic subunit beta" "PtdIns-3-kinase subunit p110-beta" "p110beta"))
(define-protein "PK3CD_HUMAN" ("anti-IgM" "Phosphatidylinositol 4,5-bisphosphate 3-kinase catalytic subunit delta isoform" "PI3-kinase subunit delta" "PI3K-delta" "PI3Kdelta" "PtdIns-3-kinase subunit delta" "Phosphatidylinositol 4,5-bisphosphate 3-kinase 110 kDa catalytic subunit delta" "PtdIns-3-kinase subunit p110-delta" "p110delta"))
(define-protein "PK3CG_HUMAN" ("βγ" "Phosphatidylinositol 4,5-bisphosphate 3-kinase catalytic subunit gamma isoform" "PI3-kinase subunit gamma" "PI3K-gamma" "PI3Kgamma" "PtdIns-3-kinase subunit gamma" "Phosphatidylinositol 4,5-bisphosphate 3-kinase 110 kDa catalytic subunit gamma" "PtdIns-3-kinase subunit p110-gamma" "p110gamma" "Phosphoinositide-3-kinase catalytic gamma polypeptide" "Serine/threonine protein kinase PIK3CG" "p120-PI3K"))
=======
<<<<<<< .mine
(define-protein "PITX2_HUMAN" ("Pitx2" "Pituitary homeobox 2" "ALL1-responsive protein ARP1" "Homeobox protein PITX2" "Paired-like homeodomain transcription factor 2" "RIEG bicoid-related homeobox transcription factor" "Solurshin"))
(define-protein "PK3C3_HUMAN" ("type-3" "Phosphatidylinositol 3-kinase catalytic subunit type 3" "PI3-kinase type 3" "PI3K type 3" "PtdIns-3-kinase type 3" "Phosphatidylinositol 3-kinase p100 subunit" "Phosphoinositide-3-kinase class 3" "hVps34"))
(define-protein "PK3CA_HUMAN" ("nSH2" "Phosphatidylinositol 4,5-bisphosphate 3-kinase catalytic subunit alpha isoform" "PI3-kinase subunit alpha" "PI3K-alpha" "PI3Kalpha" "PtdIns-3-kinase subunit alpha" "Phosphatidylinositol 4,5-bisphosphate 3-kinase 110 kDa catalytic subunit alpha" "PtdIns-3-kinase subunit p110-alpha" "p110alpha" "Phosphoinositide-3-kinase catalytic alpha polypeptide" "Serine/threonine protein kinase PIK3CA"))
(define-protein "PK3CB_HUMAN" ("iSH2" "Phosphatidylinositol 4,5-bisphosphate 3-kinase catalytic subunit beta isoform" "PI3-kinase subunit beta" "PI3K-beta" "PI3Kbeta" "PtdIns-3-kinase subunit beta" "Phosphatidylinositol 4,5-bisphosphate 3-kinase 110 kDa catalytic subunit beta" "PtdIns-3-kinase subunit p110-beta" "p110beta"))
(define-protein "PK3CD_HUMAN" ("anti-IgM" "Phosphatidylinositol 4,5-bisphosphate 3-kinase catalytic subunit delta isoform" "PI3-kinase subunit delta" "PI3K-delta" "PI3Kdelta" "PtdIns-3-kinase subunit delta" "Phosphatidylinositol 4,5-bisphosphate 3-kinase 110 kDa catalytic subunit delta" "PtdIns-3-kinase subunit p110-delta" "p110delta"))
(define-protein "PK3CG_HUMAN" ("βγ" "Phosphatidylinositol 4,5-bisphosphate 3-kinase catalytic subunit gamma isoform" "PI3-kinase subunit gamma" "PI3K-gamma" "PI3Kgamma" "PtdIns-3-kinase subunit gamma" "Phosphatidylinositol 4,5-bisphosphate 3-kinase 110 kDa catalytic subunit gamma" "PtdIns-3-kinase subunit p110-gamma" "p110gamma" "Phosphoinositide-3-kinase catalytic gamma polypeptide" "Serine/threonine protein kinase PIK3CG" "p120-PI3K"))
=======
(define-protein "PITX2_HUMAN" ("Pituitary homeobox 2" "ALL1-responsive protein ARP1" "Homeobox protein PITX2" "Paired-like homeodomain transcription factor 2" "RIEG bicoid-related homeobox transcription factor" "Solurshin"))
(define-protein "PK3C3_HUMAN" ("Phosphatidylinositol 3-kinase catalytic subunit type 3" "PI3-kinase type 3" "PI3K type 3" "PtdIns-3-kinase type 3" "Phosphatidylinositol 3-kinase p100 subunit" "Phosphoinositide-3-kinase class 3" "hVps34"))
(define-protein "PK3CA_HUMAN" ("Phosphatidylinositol 4,5-bisphosphate 3-kinase catalytic subunit alpha isoform" "PI3-kinase subunit alpha" "PI3K-alpha" "PI3Kalpha" "PtdIns-3-kinase subunit alpha" "Phosphatidylinositol 4,5-bisphosphate 3-kinase 110 kDa catalytic subunit alpha" "PtdIns-3-kinase subunit p110-alpha" "p110alpha" "Phosphoinositide-3-kinase catalytic alpha polypeptide" "Serine/threonine protein kinase PIK3CA"))
(define-protein "PK3CB_HUMAN" ("Phosphatidylinositol 4,5-bisphosphate 3-kinase catalytic subunit beta isoform" "PI3-kinase subunit beta" "PI3K-beta" "PI3Kbeta" "PtdIns-3-kinase subunit beta" "Phosphatidylinositol 4,5-bisphosphate 3-kinase 110 kDa catalytic subunit beta" "PtdIns-3-kinase subunit p110-beta" "p110beta"))
(define-protein "PK3CD_HUMAN" ("Phosphatidylinositol 4,5-bisphosphate 3-kinase catalytic subunit delta isoform" "PI3-kinase subunit delta" "PI3K-delta" "PI3Kdelta" "PtdIns-3-kinase subunit delta" "Phosphatidylinositol 4,5-bisphosphate 3-kinase 110 kDa catalytic subunit delta" "PtdIns-3-kinase subunit p110-delta" "p110delta"))
(define-protein "PK3CG_HUMAN" ("Phosphatidylinositol 4,5-bisphosphate 3-kinase catalytic subunit gamma isoform" "PI3-kinase subunit gamma" "PI3K-gamma" "PI3Kgamma" "PtdIns-3-kinase subunit gamma" "Phosphatidylinositol 4,5-bisphosphate 3-kinase 110 kDa catalytic subunit gamma" "PtdIns-3-kinase subunit p110-gamma" "p110gamma" "Phosphoinositide-3-kinase catalytic gamma polypeptide" "Serine/threonine protein kinase PIK3CG" "p120-PI3K"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PKHA1_HUMAN" ("PLEKHA1" "TAPP1" "TAPP-1")) 
(define-protein "PKHA2_HUMAN" ("PLEKHA2" "TAPP2" "TAPP-2")) 
(define-protein "PKHA5_HUMAN" ("KIAA1686" "PEPP2" "PLEKHA5" "PEPP-2")) 
(define-protein "PKHA7_HUMAN" ("PLEKHA7")) 
<<<<<<< .mine
(define-protein "PKHD1_HUMAN" ("PKD3" "Fibrocystin" "Polycystic kidney and hepatic disease 1 protein" "Polyductin" "Tigmin"))
=======
<<<<<<< .mine
(define-protein "PKHD1_HUMAN" ("PKD3" "Fibrocystin" "Polycystic kidney and hepatic disease 1 protein" "Polyductin" "Tigmin"))
=======
(define-protein "PKHD1_HUMAN" ("Fibrocystin" "Polycystic kidney and hepatic disease 1 protein" "Polyductin" "Tigmin"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PKHF2_HUMAN" ("EAPF" "PLEKHF2" "ZFYVE18" "Phafin-2" "Phafin2")) 
(define-protein "PKHF2_HUMAN" ("Pleckstrin homology domain-containing family F member 2" "PH domain-containing family F member 2" "Endoplasmic reticulum-associated apoptosis-involved protein containing PH and FYVE domains" "EAPF" "PH and FYVE domain-containing protein 2" "Phafin-2" "Phafin2" "Zinc finger FYVE domain-containing protein 18"))
(define-protein "PKHG3_HUMAN" ("KIAA0599" "PLEKHG3")) 
(define-protein "PKHH1_HUMAN" ("KIAA1200" "PLEKHH1")) 
(define-protein "PKP2_HUMAN" ("Plakophilin-2"))
(define-protein "PKP3_HUMAN" ("Plakophilin-3"))
<<<<<<< .mine
(define-protein "PLAK_HUMAN" ("plakoglobin" "Junction plakoglobin" "Catenin gamma" "Desmoplakin III" "Desmoplakin-3"))
=======
<<<<<<< .mine
(define-protein "PLAK_HUMAN" ("plakoglobin" "Junction plakoglobin" "Catenin gamma" "Desmoplakin III" "Desmoplakin-3"))
=======
(define-protein "PLAK_HUMAN" ("Junction plakoglobin" "Catenin gamma" "Desmoplakin III" "Desmoplakin-3"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PLCB2_HUMAN" ("1-phosphatidylinositol 4,5-bisphosphate phosphodiesterase beta-2" "Phosphoinositide phospholipase C-beta-2" "Phospholipase C-beta-2" "PLC-beta-2"))
<<<<<<< .mine
(define-protein "PLCB3_HUMAN" ("PLCβ3" "1-phosphatidylinositol 4,5-bisphosphate phosphodiesterase beta-3" "Phosphoinositide phospholipase C-beta-3" "Phospholipase C-beta-3" "PLC-beta-3"))
(define-protein "PLCE1_HUMAN" ("PLCε1" "1-phosphatidylinositol 4,5-bisphosphate phosphodiesterase epsilon-1" "Pancreas-enriched phospholipase C" "Phosphoinositide phospholipase C-epsilon-1" "Phospholipase C-epsilon-1" "PLC-epsilon-1"))
(define-protein "PLCG1_HUMAN" ("cγ" "1-phosphatidylinositol 4,5-bisphosphate phosphodiesterase gamma-1" "PLC-148" "Phosphoinositide phospholipase C-gamma-1" "Phospholipase C-II" "PLC-II" "Phospholipase C-gamma-1" "PLC-gamma-1"))
(define-protein "PLCG2_HUMAN" ("PLCγ2" "1-phosphatidylinositol 4,5-bisphosphate phosphodiesterase gamma-2" "Phosphoinositide phospholipase C-gamma-2" "Phospholipase C-IV" "PLC-IV" "Phospholipase C-gamma-2" "PLC-gamma-2"))
(define-protein "PLD5_HUMAN" ("D5" "Inactive phospholipase D5" "Inactive PLD 5" "Inactive choline phosphatase 5" "Inactive phosphatidylcholine-hydrolyzing phospholipase D5" "PLDc"))
=======
<<<<<<< .mine
(define-protein "PLCB3_HUMAN" ("PLCβ3" "1-phosphatidylinositol 4,5-bisphosphate phosphodiesterase beta-3" "Phosphoinositide phospholipase C-beta-3" "Phospholipase C-beta-3" "PLC-beta-3"))
(define-protein "PLCE1_HUMAN" ("PLCε1" "1-phosphatidylinositol 4,5-bisphosphate phosphodiesterase epsilon-1" "Pancreas-enriched phospholipase C" "Phosphoinositide phospholipase C-epsilon-1" "Phospholipase C-epsilon-1" "PLC-epsilon-1"))
(define-protein "PLCG1_HUMAN" ("cγ" "1-phosphatidylinositol 4,5-bisphosphate phosphodiesterase gamma-1" "PLC-148" "Phosphoinositide phospholipase C-gamma-1" "Phospholipase C-II" "PLC-II" "Phospholipase C-gamma-1" "PLC-gamma-1"))
(define-protein "PLCG2_HUMAN" ("PLCγ2" "1-phosphatidylinositol 4,5-bisphosphate phosphodiesterase gamma-2" "Phosphoinositide phospholipase C-gamma-2" "Phospholipase C-IV" "PLC-IV" "Phospholipase C-gamma-2" "PLC-gamma-2"))
(define-protein "PLD5_HUMAN" ("D5" "Inactive phospholipase D5" "Inactive PLD 5" "Inactive choline phosphatase 5" "Inactive phosphatidylcholine-hydrolyzing phospholipase D5" "PLDc"))
=======
(define-protein "PLCB3_HUMAN" ("1-phosphatidylinositol 4,5-bisphosphate phosphodiesterase beta-3" "Phosphoinositide phospholipase C-beta-3" "Phospholipase C-beta-3" "PLC-beta-3"))
(define-protein "PLCE1_HUMAN" ("1-phosphatidylinositol 4,5-bisphosphate phosphodiesterase epsilon-1" "Pancreas-enriched phospholipase C" "Phosphoinositide phospholipase C-epsilon-1" "Phospholipase C-epsilon-1" "PLC-epsilon-1"))
(define-protein "PLCG1_HUMAN" ("1-phosphatidylinositol 4,5-bisphosphate phosphodiesterase gamma-1" "PLC-148" "Phosphoinositide phospholipase C-gamma-1" "Phospholipase C-II" "PLC-II" "Phospholipase C-gamma-1" "PLC-gamma-1"))
(define-protein "PLCG2_HUMAN" ("1-phosphatidylinositol 4,5-bisphosphate phosphodiesterase gamma-2" "Phosphoinositide phospholipase C-gamma-2" "Phospholipase C-IV" "PLC-IV" "Phospholipase C-gamma-2" "PLC-gamma-2"))
(define-protein "PLD5_HUMAN" ("Inactive phospholipase D5" "Inactive PLD 5" "Inactive choline phosphatase 5" "Inactive phosphatidylcholine-hydrolyzing phospholipase D5" "PLDc"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PLEC_HUMAN" ("Plectin-1" "PLTN" "PCN" "PLEC" "PLEC1" "HD1")) 
(define-protein "PLEK2_HUMAN" ("PLEK2")) 
<<<<<<< .mine
(define-protein "PLIN2_HUMAN" ("adrp" "Perilipin-2" "Adipophilin" "Adipose differentiation-related protein" "ADRP"))
=======
<<<<<<< .mine
(define-protein "PLIN2_HUMAN" ("adrp" "Perilipin-2" "Adipophilin" "Adipose differentiation-related protein" "ADRP"))
=======
(define-protein "PLIN2_HUMAN" ("Perilipin-2" "Adipophilin" "Adipose differentiation-related protein" "ADRP"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PLIN3_HUMAN" ("TIP47" "M6PRBP1" "PP17" "PLIN3")) 
<<<<<<< .mine
(define-protein "PLK1_HUMAN" ("plks" "Serine/threonine-protein kinase PLK1" "Polo-like kinase 1" "PLK-1" "Serine/threonine-protein kinase 13" "STPK13"))
(define-protein "PLK2_HUMAN" ("miR-126" "Serine/threonine-protein kinase PLK2" "Polo-like kinase 2" "PLK-2" "hPlk2" "Serine/threonine-protein kinase SNK" "hSNK" "Serum-inducible kinase"))
(define-protein "PLK4_HUMAN" ("HCT116" "Serine/threonine-protein kinase PLK4" "Polo-like kinase 4" "PLK-4" "Serine/threonine-protein kinase 18" "Serine/threonine-protein kinase Sak"))
=======
<<<<<<< .mine
(define-protein "PLK1_HUMAN" ("plks" "Serine/threonine-protein kinase PLK1" "Polo-like kinase 1" "PLK-1" "Serine/threonine-protein kinase 13" "STPK13"))
(define-protein "PLK2_HUMAN" ("miR-126" "Serine/threonine-protein kinase PLK2" "Polo-like kinase 2" "PLK-2" "hPlk2" "Serine/threonine-protein kinase SNK" "hSNK" "Serum-inducible kinase"))
(define-protein "PLK4_HUMAN" ("HCT116" "Serine/threonine-protein kinase PLK4" "Polo-like kinase 4" "PLK-4" "Serine/threonine-protein kinase 18" "Serine/threonine-protein kinase Sak"))
=======
(define-protein "PLK1_HUMAN" ("Serine/threonine-protein kinase PLK1" "Polo-like kinase 1" "PLK-1" "Serine/threonine-protein kinase 13" "STPK13"))
(define-protein "PLK2_HUMAN" ("Serine/threonine-protein kinase PLK2" "Polo-like kinase 2" "PLK-2" "hPlk2" "Serine/threonine-protein kinase SNK" "hSNK" "Serum-inducible kinase"))
(define-protein "PLK4_HUMAN" ("Serine/threonine-protein kinase PLK4" "Polo-like kinase 4" "PLK-4" "Serine/threonine-protein kinase 18" "Serine/threonine-protein kinase Sak"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PLLP_HUMAN" ("PMLP" "PLLP" "TM4SF11")) 
(define-protein "PLSI_HUMAN" ("I-plastin" "PLS1")) 
<<<<<<< .mine
(define-protein "PLXA3_HUMAN" ("plexin" "Plexin-A3" "Plexin-4" "Semaphorin receptor SEX"))
(define-protein "PLXB1_HUMAN" ("plexins" "Plexin-B1" "Semaphorin receptor SEP"))
(define-protein "PMEL_HUMAN" ("pmel" "Melanocyte protein PMEL" "ME20-M" "ME20M" "Melanocyte protein Pmel 17" "Melanocytes lineage-specific antigen GP100" "Melanoma-associated ME20 antigen" "P1" "P100" "Premelanosome protein" "Silver locus protein homolog"))
=======
<<<<<<< .mine
(define-protein "PLXA3_HUMAN" ("plexin" "Plexin-A3" "Plexin-4" "Semaphorin receptor SEX"))
(define-protein "PLXB1_HUMAN" ("plexins" "Plexin-B1" "Semaphorin receptor SEP"))
(define-protein "PMEL_HUMAN" ("pmel" "Melanocyte protein PMEL" "ME20-M" "ME20M" "Melanocyte protein Pmel 17" "Melanocytes lineage-specific antigen GP100" "Melanoma-associated ME20 antigen" "P1" "P100" "Premelanosome protein" "Silver locus protein homolog"))
=======
(define-protein "PLXA3_HUMAN" ("Plexin-A3" "Plexin-4" "Semaphorin receptor SEX"))
(define-protein "PLXB1_HUMAN" ("Plexin-B1" "Semaphorin receptor SEP"))
(define-protein "PMEL_HUMAN" ("Melanocyte protein PMEL" "ME20-M" "ME20M" "Melanocyte protein Pmel 17" "Melanocytes lineage-specific antigen GP100" "Melanoma-associated ME20 antigen" "P1" "P100" "Premelanosome protein" "Silver locus protein homolog"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PMF1_HUMAN" ("PMF1" "PMF-1")) 
(define-protein "PML_HUMAN" ("Promyelocytic leukemia protein" "RING finger protein")) 
<<<<<<< .mine
(define-protein "PMP22_HUMAN" ("Pmp22" "Peripheral myelin protein 22" "PMP-22" "Growth arrest-specific protein 3" "GAS-3"))
(define-protein "PMS2_HUMAN" ("mutlα" "Mismatch repair endonuclease PMS2" "DNA mismatch repair protein PMS2" "PMS1 protein homolog 2"))
(define-protein "PNPT1_HUMAN" ("miR-221" "Polyribonucleotide nucleotidyltransferase 1, mitochondrial" "3'-5' RNA exonuclease OLD35" "PNPase old-35" "Polynucleotide phosphorylase 1" "PNPase 1" "Polynucleotide phosphorylase-like protein"))
=======
<<<<<<< .mine
(define-protein "PMP22_HUMAN" ("Pmp22" "Peripheral myelin protein 22" "PMP-22" "Growth arrest-specific protein 3" "GAS-3"))
(define-protein "PMS2_HUMAN" ("mutlα" "Mismatch repair endonuclease PMS2" "DNA mismatch repair protein PMS2" "PMS1 protein homolog 2"))
(define-protein "PNPT1_HUMAN" ("miR-221" "Polyribonucleotide nucleotidyltransferase 1, mitochondrial" "3'-5' RNA exonuclease OLD35" "PNPase old-35" "Polynucleotide phosphorylase 1" "PNPase 1" "Polynucleotide phosphorylase-like protein"))
=======
(define-protein "PMP22_HUMAN" ("Peripheral myelin protein 22" "PMP-22" "Growth arrest-specific protein 3" "GAS-3"))
(define-protein "PMS2_HUMAN" ("Mismatch repair endonuclease PMS2" "DNA mismatch repair protein PMS2" "PMS1 protein homolog 2"))
(define-protein "PNPT1_HUMAN" ("Polyribonucleotide nucleotidyltransferase 1, mitochondrial" "3'-5' RNA exonuclease OLD35" "PNPase old-35" "Polynucleotide phosphorylase 1" "PNPase 1" "Polynucleotide phosphorylase-like protein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PO2F1_HUMAN" ("POU domain, class 2, transcription factor 1" "NF-A1" "Octamer-binding protein 1" "Oct-1" "Octamer-binding transcription factor 1" "OTF-1"))
<<<<<<< .mine
(define-protein "PO2F2_HUMAN" ("OCT-2" "POU domain, class 2, transcription factor 2" "Lymphoid-restricted immunoglobulin octamer-binding protein NF-A2" "Octamer-binding protein 2" "Oct-2" "Octamer-binding transcription factor 2" "OTF-2"))
=======
<<<<<<< .mine
(define-protein "PO2F2_HUMAN" ("OCT-2" "POU domain, class 2, transcription factor 2" "Lymphoid-restricted immunoglobulin octamer-binding protein NF-A2" "Octamer-binding protein 2" "Oct-2" "Octamer-binding transcription factor 2" "OTF-2"))
=======
(define-protein "PO2F2_HUMAN" ("POU domain, class 2, transcription factor 2" "Lymphoid-restricted immunoglobulin octamer-binding protein NF-A2" "Octamer-binding protein 2" "Oct-2" "Octamer-binding transcription factor 2" "OTF-2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PO5F1_HUMAN" ("POU domain, class 5, transcription factor 1" "Octamer-binding protein 3" "Oct-3" "Octamer-binding protein 4" "Oct-4" "Octamer-binding transcription factor 3" "OTF-3"))
<<<<<<< .mine
(define-protein "PO5F1_HUMAN" ("octamer" "POU domain, class 5, transcription factor 1" "Octamer-binding protein 3" "Oct-3" "Octamer-binding protein 4" "Oct-4" "Octamer-binding transcription factor 3" "OTF-3"))
(define-protein "PODO_HUMAN" ("podocin" "Podocin"))
(define-protein "PODXL_HUMAN" ("podocalyxin" "Podocalyxin" "GCTM-2 antigen" "Gp200" "Podocalyxin-like protein 1" "PC" "PCLP-1"))
(define-protein "POL_HTL1A" ("pro-" "Gag-Pro-Pol polyprotein" "Pr160Gag-Pro-Pol"))
(define-protein "PON1_HUMAN" ("K45" "Serum paraoxonase/arylesterase 1" "PON 1" "Aromatic esterase 1" "A-esterase 1" "K-45" "Serum aryldialkylphosphatase 1"))
(define-protein "PORCN_HUMAN" ("porcn" "Protein-serine O-palmitoleoyltransferase porcupine" "Protein MG61"))
=======
<<<<<<< .mine
(define-protein "PO5F1_HUMAN" ("octamer" "POU domain, class 5, transcription factor 1" "Octamer-binding protein 3" "Oct-3" "Octamer-binding protein 4" "Oct-4" "Octamer-binding transcription factor 3" "OTF-3"))
(define-protein "PODO_HUMAN" ("podocin" "Podocin"))
(define-protein "PODXL_HUMAN" ("podocalyxin" "Podocalyxin" "GCTM-2 antigen" "Gp200" "Podocalyxin-like protein 1" "PC" "PCLP-1"))
(define-protein "POL_HTL1A" ("pro-" "Gag-Pro-Pol polyprotein" "Pr160Gag-Pro-Pol"))
(define-protein "PON1_HUMAN" ("K45" "Serum paraoxonase/arylesterase 1" "PON 1" "Aromatic esterase 1" "A-esterase 1" "K-45" "Serum aryldialkylphosphatase 1"))
(define-protein "PORCN_HUMAN" ("porcn" "Protein-serine O-palmitoleoyltransferase porcupine" "Protein MG61"))
=======
(define-protein "PODO_HUMAN" ("Podocin"))
(define-protein "PODXL_HUMAN" ("Podocalyxin" "GCTM-2 antigen" "Gp200" "Podocalyxin-like protein 1" "PC" "PCLP-1"))
(define-protein "POL_HTL1A" ("Gag-Pro-Pol polyprotein" "Pr160Gag-Pro-Pol"))
(define-protein "PON1_HUMAN" ("Serum paraoxonase/arylesterase 1" "PON 1" "Aromatic esterase 1" "A-esterase 1" "K-45" "Serum aryldialkylphosphatase 1"))
(define-protein "PORCN_HUMAN" ("Protein-serine O-palmitoleoyltransferase porcupine" "Protein MG61"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "POTEE_HUMAN" ("A26C1A" "POTE2" "POTEE" "POTE-2")) 
(define-protein "PP1A_HUMAN" ("PP-1A" "PPP1CA" "PPP1A")) 
(define-protein "PP1B_HUMAN" ("PP-1B" "PPP1CB" "PPP1CD")) 
(define-protein "PP1R7_HUMAN" ("SDS22" "PPP1R7")) 
(define-protein "PP2A" NIL) 
(define-protein "PP2AA_HUMAN" ("RP-C" "PPP2CA" "PP2A-alpha")) 
(define-protein "PP2AB_HUMAN" ("PP2A-beta" "PPP2CB")) 
<<<<<<< .mine
(define-protein "PPA6_HUMAN" ("lpap" "Lysophosphatidic acid phosphatase type 6" "Acid phosphatase 6, lysophosphatidic" "Acid phosphatase-like protein 1" "PACPL1"))
=======
<<<<<<< .mine
(define-protein "PPA6_HUMAN" ("lpap" "Lysophosphatidic acid phosphatase type 6" "Acid phosphatase 6, lysophosphatidic" "Acid phosphatase-like protein 1" "PACPL1"))
=======
(define-protein "PPA6_HUMAN" ("Lysophosphatidic acid phosphatase type 6" "Acid phosphatase 6, lysophosphatidic" "Acid phosphatase-like protein 1" "PACPL1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PPAC_HUMAN" ("LMW-PTP" "LMW-PTPase" "ACP1")) 
<<<<<<< .mine
(define-protein "PPARA_HUMAN" ("pparα" "Peroxisome proliferator-activated receptor alpha" "PPAR-alpha" "Nuclear receptor subfamily 1 group C member 1"))
(define-protein "PPARD_HUMAN" ("pparδ" "Peroxisome proliferator-activated receptor delta" "PPAR-delta" "NUCI" "Nuclear hormone receptor 1" "NUC1" "Nuclear receptor subfamily 1 group C member 2" "Peroxisome proliferator-activated receptor beta" "PPAR-beta"))
=======
<<<<<<< .mine
(define-protein "PPARA_HUMAN" ("pparα" "Peroxisome proliferator-activated receptor alpha" "PPAR-alpha" "Nuclear receptor subfamily 1 group C member 1"))
(define-protein "PPARD_HUMAN" ("pparδ" "Peroxisome proliferator-activated receptor delta" "PPAR-delta" "NUCI" "Nuclear hormone receptor 1" "NUC1" "Nuclear receptor subfamily 1 group C member 2" "Peroxisome proliferator-activated receptor beta" "PPAR-beta"))
=======
(define-protein "PPARA_HUMAN" ("Peroxisome proliferator-activated receptor alpha" "PPAR-alpha" "Nuclear receptor subfamily 1 group C member 1"))
(define-protein "PPARD_HUMAN" ("Peroxisome proliferator-activated receptor delta" "PPAR-delta" "NUCI" "Nuclear hormone receptor 1" "NUC1" "Nuclear receptor subfamily 1 group C member 2" "Peroxisome proliferator-activated receptor beta" "PPAR-beta"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PPARG_HUMAN" ("PPAR-gamma" "PPARG" "NR1C3")) 
<<<<<<< .mine
(define-protein "PPB1_HUMAN" ("stec" "Alkaline phosphatase, placental type" "Alkaline phosphatase Regan isozyme" "Placental alkaline phosphatase 1" "PLAP-1"))
=======
<<<<<<< .mine
(define-protein "PPB1_HUMAN" ("stec" "Alkaline phosphatase, placental type" "Alkaline phosphatase Regan isozyme" "Placental alkaline phosphatase 1" "PLAP-1"))
=======
(define-protein "PPB1_HUMAN" ("Alkaline phosphatase, placental type" "Alkaline phosphatase Regan isozyme" "Placental alkaline phosphatase 1" "PLAP-1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PPCT_HUMAN" ("STARD2" "StARD2" "PC-TP" "PCTP")) 
(define-protein "PPGB_HUMAN" ("CTSA" "PPCA" "PPGB")) 
<<<<<<< .mine
(define-protein "PPIB_HUMAN" ("cyps" "Peptidyl-prolyl cis-trans isomerase B" "PPIase B" "CYP-S1" "Cyclophilin B" "Rotamase B" "S-cyclophilin" "SCYLP"))
=======
<<<<<<< .mine
(define-protein "PPIB_HUMAN" ("cyps" "Peptidyl-prolyl cis-trans isomerase B" "PPIase B" "CYP-S1" "Cyclophilin B" "Rotamase B" "S-cyclophilin" "SCYLP"))
=======
(define-protein "PPIB_HUMAN" ("Peptidyl-prolyl cis-trans isomerase B" "PPIase B" "CYP-S1" "Cyclophilin B" "Rotamase B" "S-cyclophilin" "SCYLP"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PPM1A_HUMAN" ("PPM1A" "PPPM1A" "PP2C-alpha")) 
(define-protein "PPM1B_HUMAN" ("PP2C-beta" "PP2CB" "PPM1B")) 
<<<<<<< .mine
(define-protein "PPM1K_HUMAN" ("PP2C" "Protein phosphatase 1K, mitochondrial" "PP2C domain-containing protein phosphatase 1K" "PP2C-like mitochondrial protein" "PP2C-type mitochondrial phosphoprotein phosphatase" "PTMP" "Protein phosphatase 2C isoform kappa" "PP2C-kappa"))
=======
<<<<<<< .mine
(define-protein "PPM1K_HUMAN" ("PP2C" "Protein phosphatase 1K, mitochondrial" "PP2C domain-containing protein phosphatase 1K" "PP2C-like mitochondrial protein" "PP2C-type mitochondrial phosphoprotein phosphatase" "PTMP" "Protein phosphatase 2C isoform kappa" "PP2C-kappa"))
=======
(define-protein "PPM1K_HUMAN" ("Protein phosphatase 1K, mitochondrial" "PP2C domain-containing protein phosphatase 1K" "PP2C-like mitochondrial protein" "PP2C-type mitochondrial phosphoprotein phosphatase" "PTMP" "Protein phosphatase 2C isoform kappa" "PP2C-kappa"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PPP5_HUMAN" ("PP-T" "PP5" "PPP5" "PPP5C" "PPT")) 
<<<<<<< .mine
(define-protein "PPR29_HUMAN" ("fibronectin" "Protein phosphatase 1 regulatory subunit 29" "Extracellular leucine-rich repeat and fibronectin type III domain-containing protein 2" "Leucine-rich repeat and fibronectin type-III domain-containing protein 6" "Leucine-rich repeat-containing protein 62"))
(define-protein "PPR3B_HUMAN" ("phosphatase-1" "Protein phosphatase 1 regulatory subunit 3B" "Hepatic glycogen-targeting protein phosphatase 1 regulatory subunit GL" "Protein phosphatase 1 regulatory subunit 4" "PP1 subunit R4" "Protein phosphatase 1 subunit GL" "PTG"))
=======
<<<<<<< .mine
(define-protein "PPR29_HUMAN" ("fibronectin" "Protein phosphatase 1 regulatory subunit 29" "Extracellular leucine-rich repeat and fibronectin type III domain-containing protein 2" "Leucine-rich repeat and fibronectin type-III domain-containing protein 6" "Leucine-rich repeat-containing protein 62"))
(define-protein "PPR3B_HUMAN" ("phosphatase-1" "Protein phosphatase 1 regulatory subunit 3B" "Hepatic glycogen-targeting protein phosphatase 1 regulatory subunit GL" "Protein phosphatase 1 regulatory subunit 4" "PP1 subunit R4" "Protein phosphatase 1 subunit GL" "PTG"))
=======
(define-protein "PPR29_HUMAN" ("Protein phosphatase 1 regulatory subunit 29" "Extracellular leucine-rich repeat and fibronectin type III domain-containing protein 2" "Leucine-rich repeat and fibronectin type-III domain-containing protein 6" "Leucine-rich repeat-containing protein 62"))
(define-protein "PPR3B_HUMAN" ("Protein phosphatase 1 regulatory subunit 3B" "Hepatic glycogen-targeting protein phosphatase 1 regulatory subunit GL" "Protein phosphatase 1 regulatory subunit 4" "PP1 subunit R4" "Protein phosphatase 1 subunit GL" "PTG"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PPT1_HUMAN" ("PPT1" "PPT-1" "PPT")) 
(define-protein "PRAF1_HUMAN" ("RABAC1" "PRA1" "PRAF1")) 
(define-protein "PRAF2_HUMAN" ("PRAF2")) 
<<<<<<< .mine
(define-protein "PRD16_HUMAN" ("Prdm16" "PR domain zinc finger protein 16" "PR domain-containing protein 16" "Transcription factor MEL1" "MDS1/EVI1-like gene 1"))
=======
<<<<<<< .mine
(define-protein "PRD16_HUMAN" ("Prdm16" "PR domain zinc finger protein 16" "PR domain-containing protein 16" "Transcription factor MEL1" "MDS1/EVI1-like gene 1"))
=======
(define-protein "PRD16_HUMAN" ("PR domain zinc finger protein 16" "PR domain-containing protein 16" "Transcription factor MEL1" "MDS1/EVI1-like gene 1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PRDX1_HUMAN" ("Peroxiredoxin-1" "Natural killer cell-enhancing factor A" "NKEF-A" "Proliferation-associated gene protein" "PAG" "Thioredoxin peroxidase 2" "Thioredoxin-dependent peroxide reductase 2"))
<<<<<<< .mine
(define-protein "PRDX1_HUMAN" ("Prdx1" "Peroxiredoxin-1" "Natural killer cell-enhancing factor A" "NKEF-A" "Proliferation-associated gene protein" "PAG" "Thioredoxin peroxidase 2" "Thioredoxin-dependent peroxide reductase 2"))
(define-protein "PRDX2_HUMAN" ("Prdx2" "Peroxiredoxin-2" "Natural killer cell-enhancing factor B" "NKEF-B" "PRP" "Thiol-specific antioxidant protein" "TSA" "Thioredoxin peroxidase 1" "Thioredoxin-dependent peroxide reductase 1"))
=======
<<<<<<< .mine
(define-protein "PRDX1_HUMAN" ("Prdx1" "Peroxiredoxin-1" "Natural killer cell-enhancing factor A" "NKEF-A" "Proliferation-associated gene protein" "PAG" "Thioredoxin peroxidase 2" "Thioredoxin-dependent peroxide reductase 2"))
(define-protein "PRDX2_HUMAN" ("Prdx2" "Peroxiredoxin-2" "Natural killer cell-enhancing factor B" "NKEF-B" "PRP" "Thiol-specific antioxidant protein" "TSA" "Thioredoxin peroxidase 1" "Thioredoxin-dependent peroxide reductase 1"))
=======
(define-protein "PRDX2_HUMAN" ("Peroxiredoxin-2" "Natural killer cell-enhancing factor B" "NKEF-B" "PRP" "Thiol-specific antioxidant protein" "TSA" "Thioredoxin peroxidase 1" "Thioredoxin-dependent peroxide reductase 1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PRDX3_HUMAN" ("Thioredoxin-dependent peroxide reductase, mitochondrial" "Antioxidant protein 1" "AOP-1" "HBC189" "Peroxiredoxin III" "Prx-III" "Peroxiredoxin-3" "Protein MER5 homolog"))
<<<<<<< .mine
(define-protein "PRDX5_HUMAN" ("alu" "Peroxiredoxin-5, mitochondrial" "Alu corepressor 1" "Antioxidant enzyme B166" "AOEB166" "Liver tissue 2D-page spot 71B" "PLP" "Peroxiredoxin V" "Prx-V" "Peroxisomal antioxidant enzyme" "TPx type VI" "Thioredoxin peroxidase PMP20" "Thioredoxin reductase"))
=======
<<<<<<< .mine
(define-protein "PRDX5_HUMAN" ("alu" "Peroxiredoxin-5, mitochondrial" "Alu corepressor 1" "Antioxidant enzyme B166" "AOEB166" "Liver tissue 2D-page spot 71B" "PLP" "Peroxiredoxin V" "Prx-V" "Peroxisomal antioxidant enzyme" "TPx type VI" "Thioredoxin peroxidase PMP20" "Thioredoxin reductase"))
=======
(define-protein "PRDX5_HUMAN" ("Peroxiredoxin-5, mitochondrial" "Alu corepressor 1" "Antioxidant enzyme B166" "AOEB166" "Liver tissue 2D-page spot 71B" "PLP" "Peroxiredoxin V" "Prx-V" "Peroxisomal antioxidant enzyme" "TPx type VI" "Thioredoxin peroxidase PMP20" "Thioredoxin reductase"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PRDX6_HUMAN" ("Peroxiredoxin-6" "1-Cys peroxiredoxin" "1-Cys PRX" "24 kDa protein" "Acidic calcium-independent phospholipase A2" "aiPLA2" "Antioxidant protein 2" "Liver 2D page spot 40" "Non-selenium glutathione peroxidase" "NSGPx" "Red blood cells page spot 12"))
<<<<<<< .mine
(define-protein "PRGC1_HUMAN" ("PGC1α" "Peroxisome proliferator-activated receptor gamma coactivator 1-alpha" "PGC-1-alpha" "PPAR-gamma coactivator 1-alpha" "PPARGC-1-alpha" "Ligand effect modulator 6"))
(define-protein "PRGC2_HUMAN" ("PGC-1" "Peroxisome proliferator-activated receptor gamma coactivator 1-beta" "PGC-1-beta" "PPAR-gamma coactivator 1-beta" "PPARGC-1-beta" "PGC-1-related estrogen receptor alpha coactivator"))
=======
<<<<<<< .mine
(define-protein "PRGC1_HUMAN" ("PGC1α" "Peroxisome proliferator-activated receptor gamma coactivator 1-alpha" "PGC-1-alpha" "PPAR-gamma coactivator 1-alpha" "PPARGC-1-alpha" "Ligand effect modulator 6"))
(define-protein "PRGC2_HUMAN" ("PGC-1" "Peroxisome proliferator-activated receptor gamma coactivator 1-beta" "PGC-1-beta" "PPAR-gamma coactivator 1-beta" "PPARGC-1-beta" "PGC-1-related estrogen receptor alpha coactivator"))
=======
(define-protein "PRGC1_HUMAN" ("Peroxisome proliferator-activated receptor gamma coactivator 1-alpha" "PGC-1-alpha" "PPAR-gamma coactivator 1-alpha" "PPARGC-1-alpha" "Ligand effect modulator 6"))
(define-protein "PRGC2_HUMAN" ("Peroxisome proliferator-activated receptor gamma coactivator 1-beta" "PGC-1-beta" "PPAR-gamma coactivator 1-beta" "PPARGC-1-beta" "PGC-1-related estrogen receptor alpha coactivator"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PRKDC_HUMAN" ("DNA-PK" "HYRC" "DNPK1" "p460" "PRKDC" "DNA-PKcs" "HYRC1")) 
<<<<<<< .mine
(define-protein "PRKN2_HUMAN" ("parkin" "E3 ubiquitin-protein ligase parkin" "Parkin" "Parkinson juvenile disease protein 2" "Parkinson disease protein 2"))
(define-protein "PROF1_HUMAN" ("profilin-1" "Profilin-1" "Epididymis tissue protein Li 184a" "Profilin I"))
=======
<<<<<<< .mine
(define-protein "PRKN2_HUMAN" ("parkin" "E3 ubiquitin-protein ligase parkin" "Parkin" "Parkinson juvenile disease protein 2" "Parkinson disease protein 2"))
(define-protein "PROF1_HUMAN" ("profilin-1" "Profilin-1" "Epididymis tissue protein Li 184a" "Profilin I"))
=======
(define-protein "PRKN2_HUMAN" ("E3 ubiquitin-protein ligase parkin" "Parkin" "Parkinson juvenile disease protein 2" "Parkinson disease protein 2"))
(define-protein "PROF1_HUMAN" ("Profilin-1" "Epididymis tissue protein Li 184a" "Profilin I"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PROM1_HUMAN" ("Prominin-1" "Antigen AC133" "Prominin-like protein 1"))
<<<<<<< .mine
(define-protein "PRP31_HUMAN" ("Prp31" "U4/U6 small nuclear ribonucleoprotein Prp31" "Pre-mRNA-processing factor 31" "Serologically defined breast cancer antigen NY-BR-99" "U4/U6 snRNP 61 kDa protein" "Protein 61K" "hPrp31"))
(define-protein "PRP8_HUMAN" ("PRP8" "Pre-mRNA-processing-splicing factor 8" "220 kDa U5 snRNP-specific protein" "PRP8 homolog" "Splicing factor Prp8" "p220"))
=======
<<<<<<< .mine
(define-protein "PRP31_HUMAN" ("Prp31" "U4/U6 small nuclear ribonucleoprotein Prp31" "Pre-mRNA-processing factor 31" "Serologically defined breast cancer antigen NY-BR-99" "U4/U6 snRNP 61 kDa protein" "Protein 61K" "hPrp31"))
(define-protein "PRP8_HUMAN" ("PRP8" "Pre-mRNA-processing-splicing factor 8" "220 kDa U5 snRNP-specific protein" "PRP8 homolog" "Splicing factor Prp8" "p220"))
=======
(define-protein "PRP31_HUMAN" ("U4/U6 small nuclear ribonucleoprotein Prp31" "Pre-mRNA-processing factor 31" "Serologically defined breast cancer antigen NY-BR-99" "U4/U6 snRNP 61 kDa protein" "Protein 61K" "hPrp31"))
(define-protein "PRP8_HUMAN" ("Pre-mRNA-processing-splicing factor 8" "220 kDa U5 snRNP-specific protein" "PRP8 homolog" "Splicing factor Prp8" "p220"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PRR15_HUMAN" ("PRR15")) 
<<<<<<< .mine
(define-protein "PSA1_HUMAN" ("usps" "Proteasome subunit alpha type-1" "30 kDa prosomal protein" "PROS-30" "Macropain subunit C2" "Multicatalytic endopeptidase complex subunit C2" "Proteasome component C2" "Proteasome nu chain"))
(define-protein "PSA3_HUMAN" ("proteasomes" "Proteasome subunit alpha type-3" "Macropain subunit C8" "Multicatalytic endopeptidase complex subunit C8" "Proteasome component C8"))
=======
<<<<<<< .mine
(define-protein "PSA1_HUMAN" ("usps" "Proteasome subunit alpha type-1" "30 kDa prosomal protein" "PROS-30" "Macropain subunit C2" "Multicatalytic endopeptidase complex subunit C2" "Proteasome component C2" "Proteasome nu chain"))
(define-protein "PSA3_HUMAN" ("proteasomes" "Proteasome subunit alpha type-3" "Macropain subunit C8" "Multicatalytic endopeptidase complex subunit C8" "Proteasome component C8"))
=======
(define-protein "PSA1_HUMAN" ("Proteasome subunit alpha type-1" "30 kDa prosomal protein" "PROS-30" "Macropain subunit C2" "Multicatalytic endopeptidase complex subunit C2" "Proteasome component C2" "Proteasome nu chain"))
(define-protein "PSA3_HUMAN" ("Proteasome subunit alpha type-3" "Macropain subunit C8" "Multicatalytic endopeptidase complex subunit C8" "Proteasome component C8"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PSB2_HUMAN" ("PSMB2")) 
<<<<<<< .mine
(define-protein "PSD11_HUMAN" ("RPN6" "26S proteasome non-ATPase regulatory subunit 11" "26S proteasome regulatory subunit RPN6" "26S proteasome regulatory subunit S9" "26S proteasome regulatory subunit p44.5"))
(define-protein "PSDE_HUMAN" ("Rpn11" "26S proteasome non-ATPase regulatory subunit 14" "26S proteasome regulatory subunit RPN11" "26S proteasome-associated PAD1 homolog 1"))
=======
<<<<<<< .mine
(define-protein "PSD11_HUMAN" ("RPN6" "26S proteasome non-ATPase regulatory subunit 11" "26S proteasome regulatory subunit RPN6" "26S proteasome regulatory subunit S9" "26S proteasome regulatory subunit p44.5"))
(define-protein "PSDE_HUMAN" ("Rpn11" "26S proteasome non-ATPase regulatory subunit 14" "26S proteasome regulatory subunit RPN11" "26S proteasome-associated PAD1 homolog 1"))
=======
(define-protein "PSD11_HUMAN" ("26S proteasome non-ATPase regulatory subunit 11" "26S proteasome regulatory subunit RPN6" "26S proteasome regulatory subunit S9" "26S proteasome regulatory subunit p44.5"))
(define-protein "PSDE_HUMAN" ("26S proteasome non-ATPase regulatory subunit 14" "26S proteasome regulatory subunit RPN11" "26S proteasome-associated PAD1 homolog 1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PSMD4_HUMAN" ("ASF" "MCB1" "AF" "PSMD4")) 
(define-protein "PSN1_HUMAN" ("AD3" "PS-1" "PS1-CTF12" "PSEN1" "PS1" "PSNL1")) 
<<<<<<< .mine
(define-protein "PSPB_HUMAN" ("surfactant" "Pulmonary surfactant-associated protein B" "SP-B" "18 kDa pulmonary-surfactant protein" "6 kDa protein" "Pulmonary surfactant-associated proteolipid SPL(Phe)"))
=======
<<<<<<< .mine
(define-protein "PSPB_HUMAN" ("surfactant" "Pulmonary surfactant-associated protein B" "SP-B" "18 kDa pulmonary-surfactant protein" "6 kDa protein" "Pulmonary surfactant-associated proteolipid SPL(Phe)"))
=======
(define-protein "PSPB_HUMAN" ("Pulmonary surfactant-associated protein B" "SP-B" "18 kDa pulmonary-surfactant protein" "6 kDa protein" "Pulmonary surfactant-associated proteolipid SPL(Phe)"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PTC1_HUMAN" ("Protein patched homolog 1" "PTC" "PTC1"))
<<<<<<< .mine
(define-protein "PTCRA_HUMAN" ("tcr" "Pre T-cell antigen receptor alpha" "pT-alpha" "pTa" "pT-alpha-TCR"))
(define-protein "PTEN_HUMAN" ("Akt/PKB" "Phosphatidylinositol 3,4,5-trisphosphate 3-phosphatase and dual-specificity protein phosphatase PTEN" "Mutated in multiple advanced cancers 1" "Phosphatase and tensin homolog"))
(define-protein "PTGES_HUMAN" ("pges" "Prostaglandin E synthase" "Microsomal glutathione S-transferase 1-like 1" "MGST1-L1" "Microsomal prostaglandin E synthase 1" "MPGES-1" "p53-induced gene 12 protein"))
(define-protein "PTN11_HUMAN" ("SHP2" "Tyrosine-protein phosphatase non-receptor type 11" "Protein-tyrosine phosphatase 1D" "PTP-1D" "Protein-tyrosine phosphatase 2C" "PTP-2C" "SH-PTP2" "SHP-2" "Shp2" "SH-PTP3"))
=======
<<<<<<< .mine
(define-protein "PTCRA_HUMAN" ("tcr" "Pre T-cell antigen receptor alpha" "pT-alpha" "pTa" "pT-alpha-TCR"))
(define-protein "PTEN_HUMAN" ("Akt/PKB" "Phosphatidylinositol 3,4,5-trisphosphate 3-phosphatase and dual-specificity protein phosphatase PTEN" "Mutated in multiple advanced cancers 1" "Phosphatase and tensin homolog"))
(define-protein "PTGES_HUMAN" ("pges" "Prostaglandin E synthase" "Microsomal glutathione S-transferase 1-like 1" "MGST1-L1" "Microsomal prostaglandin E synthase 1" "MPGES-1" "p53-induced gene 12 protein"))
(define-protein "PTN11_HUMAN" ("SHP2" "Tyrosine-protein phosphatase non-receptor type 11" "Protein-tyrosine phosphatase 1D" "PTP-1D" "Protein-tyrosine phosphatase 2C" "PTP-2C" "SH-PTP2" "SHP-2" "Shp2" "SH-PTP3"))
=======
(define-protein "PTCRA_HUMAN" ("Pre T-cell antigen receptor alpha" "pT-alpha" "pTa" "pT-alpha-TCR"))
(define-protein "PTEN_HUMAN" ("Phosphatidylinositol 3,4,5-trisphosphate 3-phosphatase and dual-specificity protein phosphatase PTEN" "Mutated in multiple advanced cancers 1" "Phosphatase and tensin homolog"))
(define-protein "PTGES_HUMAN" ("Prostaglandin E synthase" "Microsomal glutathione S-transferase 1-like 1" "MGST1-L1" "Microsomal prostaglandin E synthase 1" "MPGES-1" "p53-induced gene 12 protein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PTN11_HUMAN" ("Tyrosine-protein phosphatase non-receptor type 11" "Protein-tyrosine phosphatase 1D" "PTP-1D" "Protein-tyrosine phosphatase 2C" "PTP-2C" "SH-PTP2" "SHP-2" "Shp2" "SH-PTP3"))
<<<<<<< .mine
(define-protein "PTN5_HUMAN" ("striatum" "Tyrosine-protein phosphatase non-receptor type 5" "Neural-specific protein-tyrosine phosphatase" "Striatum-enriched protein-tyrosine phosphatase" "STEP"))
(define-protein "PTN6_HUMAN" ("SHP1" "Tyrosine-protein phosphatase non-receptor type 6" "Hematopoietic cell protein-tyrosine phosphatase" "Protein-tyrosine phosphatase 1C" "PTP-1C" "Protein-tyrosine phosphatase SHP-1" "SH-PTP1"))
=======
<<<<<<< .mine
(define-protein "PTN5_HUMAN" ("striatum" "Tyrosine-protein phosphatase non-receptor type 5" "Neural-specific protein-tyrosine phosphatase" "Striatum-enriched protein-tyrosine phosphatase" "STEP"))
(define-protein "PTN6_HUMAN" ("SHP1" "Tyrosine-protein phosphatase non-receptor type 6" "Hematopoietic cell protein-tyrosine phosphatase" "Protein-tyrosine phosphatase 1C" "PTP-1C" "Protein-tyrosine phosphatase SHP-1" "SH-PTP1"))
=======
(define-protein "PTN5_HUMAN" ("Tyrosine-protein phosphatase non-receptor type 5" "Neural-specific protein-tyrosine phosphatase" "Striatum-enriched protein-tyrosine phosphatase" "STEP"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PTN6_HUMAN" ("Tyrosine-protein phosphatase non-receptor type 6" "Hematopoietic cell protein-tyrosine phosphatase" "Protein-tyrosine phosphatase 1C" "PTP-1C" "Protein-tyrosine phosphatase SHP-1" "SH-PTP1"))
(define-protein "PTN9_HUMAN" ("PTPN9")) 
<<<<<<< .mine
(define-protein "PTPRA_HUMAN" ("phosphatase-α" "Receptor-type tyrosine-protein phosphatase alpha" "Protein-tyrosine phosphatase alpha" "R-PTP-alpha"))
(define-protein "PTPRG_HUMAN" ("phosphatases" "Receptor-type tyrosine-protein phosphatase gamma" "Protein-tyrosine phosphatase gamma" "R-PTP-gamma"))
(define-protein "PTPRO_HUMAN" ("ptpμ" "Receptor-type tyrosine-protein phosphatase O" "R-PTP-O" "Glomerular epithelial protein 1" "Protein tyrosine phosphatase U2" "PTP-U2" "PTPase U2"))
(define-protein "PTPS_HUMAN" ("pkg" "6-pyruvoyl tetrahydrobiopterin synthase" "PTP synthase" "PTPS"))
(define-protein "PTRF_HUMAN" ("ptrf" "Polymerase I and transcript release factor" "Cavin-1"))
(define-protein "PTTG1_HUMAN" ("securin" "Securin" "Esp1-associated protein" "Pituitary tumor-transforming gene 1 protein" "Tumor-transforming protein 1" "hPTTG"))
=======
<<<<<<< .mine
(define-protein "PTPRA_HUMAN" ("phosphatase-α" "Receptor-type tyrosine-protein phosphatase alpha" "Protein-tyrosine phosphatase alpha" "R-PTP-alpha"))
(define-protein "PTPRG_HUMAN" ("phosphatases" "Receptor-type tyrosine-protein phosphatase gamma" "Protein-tyrosine phosphatase gamma" "R-PTP-gamma"))
(define-protein "PTPRO_HUMAN" ("ptpμ" "Receptor-type tyrosine-protein phosphatase O" "R-PTP-O" "Glomerular epithelial protein 1" "Protein tyrosine phosphatase U2" "PTP-U2" "PTPase U2"))
(define-protein "PTPS_HUMAN" ("pkg" "6-pyruvoyl tetrahydrobiopterin synthase" "PTP synthase" "PTPS"))
(define-protein "PTRF_HUMAN" ("ptrf" "Polymerase I and transcript release factor" "Cavin-1"))
(define-protein "PTTG1_HUMAN" ("securin" "Securin" "Esp1-associated protein" "Pituitary tumor-transforming gene 1 protein" "Tumor-transforming protein 1" "hPTTG"))
=======
(define-protein "PTPRA_HUMAN" ("Receptor-type tyrosine-protein phosphatase alpha" "Protein-tyrosine phosphatase alpha" "R-PTP-alpha"))
(define-protein "PTPRG_HUMAN" ("Receptor-type tyrosine-protein phosphatase gamma" "Protein-tyrosine phosphatase gamma" "R-PTP-gamma"))
(define-protein "PTPRO_HUMAN" ("Receptor-type tyrosine-protein phosphatase O" "R-PTP-O" "Glomerular epithelial protein 1" "Protein tyrosine phosphatase U2" "PTP-U2" "PTPase U2"))
(define-protein "PTPS_HUMAN" ("6-pyruvoyl tetrahydrobiopterin synthase" "PTP synthase" "PTPS"))
(define-protein "PTRF_HUMAN" ("Polymerase I and transcript release factor" "Cavin-1"))
(define-protein "PTTG1_HUMAN" ("Securin" "Esp1-associated protein" "Pituitary tumor-transforming gene 1 protein" "Tumor-transforming protein 1" "hPTTG"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "PTTG_HUMAN" ("PTTG1IP" "PBF" "C21orf3" "C21orf1")) 
<<<<<<< .mine
(define-protein "PVRL1_HUMAN" ("nectin-" "Nectin-1" "Herpes virus entry mediator C" "Herpesvirus entry mediator C" "HveC" "Herpesvirus Ig-like receptor" "HIgR" "Poliovirus receptor-related protein 1"))
(define-protein "PVRL4_HUMAN" ("nectins" "Nectin-4" "Ig superfamily receptor LNIR" "Poliovirus receptor-related protein 4"))
(define-protein "PXMP4_HUMAN" ("Pxmp4" "Peroxisomal membrane protein 4" "24 kDa peroxisomal intrinsic membrane protein"))
(define-protein "PYAS1_HUMAN" ("pycard" "Putative uncharacterized protein PYCARD-AS1" "PYCARD antisense RNA 1" "PYCARD antisense gene protein 1" "PYCARD opposite strand protein"))
(define-protein "Q07CK6_9HIV1" ("m67" "Protease"))
(define-protein "Q0NCE0_VAR65" ("crma" "SPI-2/CrmA, IL-1 convertase"))
(define-protein "Q0VAP4_HUMAN" ("fanca" "FANCA protein" "Fanconi anemia group A protein"))
(define-protein "Q13696_HUMAN" ("crosslinker" "ACF7 protein"))
=======
<<<<<<< .mine
(define-protein "PVRL1_HUMAN" ("nectin-" "Nectin-1" "Herpes virus entry mediator C" "Herpesvirus entry mediator C" "HveC" "Herpesvirus Ig-like receptor" "HIgR" "Poliovirus receptor-related protein 1"))
(define-protein "PVRL4_HUMAN" ("nectins" "Nectin-4" "Ig superfamily receptor LNIR" "Poliovirus receptor-related protein 4"))
(define-protein "PXMP4_HUMAN" ("Pxmp4" "Peroxisomal membrane protein 4" "24 kDa peroxisomal intrinsic membrane protein"))
(define-protein "PYAS1_HUMAN" ("pycard" "Putative uncharacterized protein PYCARD-AS1" "PYCARD antisense RNA 1" "PYCARD antisense gene protein 1" "PYCARD opposite strand protein"))
(define-protein "Q07CK6_9HIV1" ("m67" "Protease"))
(define-protein "Q0NCE0_VAR65" ("crma" "SPI-2/CrmA, IL-1 convertase"))
(define-protein "Q0VAP4_HUMAN" ("fanca" "FANCA protein" "Fanconi anemia group A protein"))
(define-protein "Q13696_HUMAN" ("crosslinker" "ACF7 protein"))
=======
(define-protein "PVRL1_HUMAN" ("Nectin-1" "Herpes virus entry mediator C" "Herpesvirus entry mediator C" "HveC" "Herpesvirus Ig-like receptor" "HIgR" "Poliovirus receptor-related protein 1"))
(define-protein "PVRL4_HUMAN" ("Nectin-4" "Ig superfamily receptor LNIR" "Poliovirus receptor-related protein 4"))
(define-protein "PXMP4_HUMAN" ("Peroxisomal membrane protein 4" "24 kDa peroxisomal intrinsic membrane protein"))
(define-protein "PYAS1_HUMAN" ("Putative uncharacterized protein PYCARD-AS1" "PYCARD antisense RNA 1" "PYCARD antisense gene protein 1" "PYCARD opposite strand protein"))
(define-protein "Q07CK6_9HIV1" ("Protease"))
(define-protein "Q0NCE0_VAR65" ("SPI-2/CrmA, IL-1 convertase"))
(define-protein "Q0VAP4_HUMAN" ("FANCA protein" "Fanconi anemia group A protein"))
(define-protein "Q13696_HUMAN" ("ACF7 protein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "Q14CC5_HUMAN" ("TPH2 protein"))
<<<<<<< .mine
(define-protein "Q16397_HUMAN" ("EWS1" "EWS/WT1 fusion protein"))
(define-protein "Q4JM46_HUMAN" ("xenopus" "AGR2" "Anterior gradient 2 homolog (Xenopus laevis)" "Anterior gradient 2 homolog (Xenopus laevis), isoform CRA_a" "Epididymis secretory protein Li 116"))
(define-protein "Q4LE53_HUMAN" ("protein+" "Receptor protein-tyrosine kinase"))
(define-protein "Q4QQH3_HUMAN" ("Slc8a1" "SLC8A1 protein"))
=======
<<<<<<< .mine
(define-protein "Q16397_HUMAN" ("EWS1" "EWS/WT1 fusion protein"))
(define-protein "Q4JM46_HUMAN" ("xenopus" "AGR2" "Anterior gradient 2 homolog (Xenopus laevis)" "Anterior gradient 2 homolog (Xenopus laevis), isoform CRA_a" "Epididymis secretory protein Li 116"))
(define-protein "Q4LE53_HUMAN" ("protein+" "Receptor protein-tyrosine kinase"))
(define-protein "Q4QQH3_HUMAN" ("Slc8a1" "SLC8A1 protein"))
=======
(define-protein "Q16397_HUMAN" ("EWS/WT1 fusion protein"))
(define-protein "Q4JM46_HUMAN" ("AGR2" "Anterior gradient 2 homolog (Xenopus laevis)" "Anterior gradient 2 homolog (Xenopus laevis), isoform CRA_a" "Epididymis secretory protein Li 116"))
(define-protein "Q4LE53_HUMAN" ("Receptor protein-tyrosine kinase"))
(define-protein "Q4QQH3_HUMAN" ("SLC8A1 protein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "Q4W5F5_HUMAN" ("Putative uncharacterized protein PTPN13"))
<<<<<<< .mine
(define-protein "Q53F09_HUMAN" ("karyopherin-α" "Karyopherin alpha 3 variant"))
(define-protein "Q569H8_HUMAN" ("esrra" "ESRRA protein" "Estrogen-related nuclear receptor alpha" "Estrogen-related receptor alpha" "HCG2016877, isoform CRA_b"))
(define-protein "Q59HB0_HUMAN" ("p66shc" "SHC (Src homology 2 domain containing) transforming protein 1 isoform p66Shc variant"))
(define-protein "Q5EHA4_9HIV1" ("Ig6" "Envelope glycoprotein"))
(define-protein "Q5FBZ9_HUMAN" ("nirs" "PMS1 nirs variant 1" "PMS1 protein homolog 1"))
(define-protein "Q5G4B7_9HIV1" ("266A" "Pol protein"))
(define-protein "Q5QD01_HUMAN" ("SPR210" "SP-A receptor subunit SP-R210 alphaS"))
(define-protein "Q693B9_9INFA" ("PB2" "Polymerase basic protein 2"))
(define-protein "Q69565_HHV6U" ("U87"))
=======
<<<<<<< .mine
(define-protein "Q53F09_HUMAN" ("karyopherin-α" "Karyopherin alpha 3 variant"))
(define-protein "Q569H8_HUMAN" ("esrra" "ESRRA protein" "Estrogen-related nuclear receptor alpha" "Estrogen-related receptor alpha" "HCG2016877, isoform CRA_b"))
(define-protein "Q59HB0_HUMAN" ("p66shc" "SHC (Src homology 2 domain containing) transforming protein 1 isoform p66Shc variant"))
(define-protein "Q5EHA4_9HIV1" ("Ig6" "Envelope glycoprotein"))
(define-protein "Q5FBZ9_HUMAN" ("nirs" "PMS1 nirs variant 1" "PMS1 protein homolog 1"))
(define-protein "Q5G4B7_9HIV1" ("266A" "Pol protein"))
(define-protein "Q5QD01_HUMAN" ("SPR210" "SP-A receptor subunit SP-R210 alphaS"))
(define-protein "Q693B9_9INFA" ("PB2" "Polymerase basic protein 2"))
(define-protein "Q69565_HHV6U" ("U87"))
=======
(define-protein "Q53F09_HUMAN" ("Karyopherin alpha 3 variant"))
(define-protein "Q569H8_HUMAN" ("ESRRA protein" "Estrogen-related nuclear receptor alpha" "Estrogen-related receptor alpha" "HCG2016877, isoform CRA_b"))
(define-protein "Q59HB0_HUMAN" ("SHC (Src homology 2 domain containing) transforming protein 1 isoform p66Shc variant"))
(define-protein "Q5EHA4_9HIV1" ("Envelope glycoprotein"))
(define-protein "Q5FBZ9_HUMAN" ("PMS1 nirs variant 1" "PMS1 protein homolog 1"))
(define-protein "Q5G4B7_9HIV1" ("Pol protein"))
(define-protein "Q5QD01_HUMAN" ("SP-A receptor subunit SP-R210 alphaS"))
(define-protein "Q693B9_9INFA" ("Polymerase basic protein 2"))
(define-protein "Q69565_HHV6U" ("U87"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "Q6DEN2_HUMAN" ("DPYSL3 protein"))
(define-protein "Q6FH11_HUMAN" ("HMOX1 protein" "Heme oxygenase (Decycling) 1"))
<<<<<<< .mine
(define-protein "Q6FI27_HUMAN" ("Gsk3β" "GSK3B protein" "GSK3beta isoform" "Glycogen synthase kinase 3 beta, isoform CRA_b" "cDNA FLJ75266, highly similar to Homo sapiens glycogen synthase kinase 3 beta, mRNA"))
(define-protein "Q6P3U7_HUMAN" ("rxra" "RXRA protein"))
(define-protein "Q708E1_HUMAN" ("c-Myb" "C-myb v-myb myeloblastosis viral oncogene homologue (avian), exon 1 and joined CDS" "Transcriptional activator Myb" "V-myb myeloblastosis viral oncogene homolog (Avian), isoform CRA_d" "V-myb myeloblastosis viral oncogene homologue (Avian)"))
(define-protein "Q79354_9HIV1" ("K29" "Gag protein"))
(define-protein "Q79360_9HIV1" ("K88" "Gag protein"))
(define-protein "Q7TJL8_HHV1" ("R-55" "UL40"))
(define-protein "Q7Z6C1_HUMAN" ("Ep300" "EP300 protein"))
(define-protein "Q86SW4_HUMAN" ("jurkat" "Dihydrolipoyllysine-residue succinyltransferase component of 2-oxoglutarate dehydrogenase complex, mitochondrial" "Full-length cDNA 5-PRIME end of clone CS0DJ009YL13 of T cells (Jurkat cell line) of Homo sapiens (human)"))
=======
<<<<<<< .mine
(define-protein "Q6FI27_HUMAN" ("Gsk3β" "GSK3B protein" "GSK3beta isoform" "Glycogen synthase kinase 3 beta, isoform CRA_b" "cDNA FLJ75266, highly similar to Homo sapiens glycogen synthase kinase 3 beta, mRNA"))
(define-protein "Q6P3U7_HUMAN" ("rxra" "RXRA protein"))
(define-protein "Q708E1_HUMAN" ("c-Myb" "C-myb v-myb myeloblastosis viral oncogene homologue (avian), exon 1 and joined CDS" "Transcriptional activator Myb" "V-myb myeloblastosis viral oncogene homolog (Avian), isoform CRA_d" "V-myb myeloblastosis viral oncogene homologue (Avian)"))
(define-protein "Q79354_9HIV1" ("K29" "Gag protein"))
(define-protein "Q79360_9HIV1" ("K88" "Gag protein"))
(define-protein "Q7TJL8_HHV1" ("R-55" "UL40"))
(define-protein "Q7Z6C1_HUMAN" ("Ep300" "EP300 protein"))
(define-protein "Q86SW4_HUMAN" ("jurkat" "Dihydrolipoyllysine-residue succinyltransferase component of 2-oxoglutarate dehydrogenase complex, mitochondrial" "Full-length cDNA 5-PRIME end of clone CS0DJ009YL13 of T cells (Jurkat cell line) of Homo sapiens (human)"))
=======
(define-protein "Q6FI27_HUMAN" ("GSK3B protein" "GSK3beta isoform" "Glycogen synthase kinase 3 beta, isoform CRA_b" "cDNA FLJ75266, highly similar to Homo sapiens glycogen synthase kinase 3 beta, mRNA"))
(define-protein "Q6P3U7_HUMAN" ("RXRA protein"))
(define-protein "Q708E1_HUMAN" ("C-myb v-myb myeloblastosis viral oncogene homologue (avian), exon 1 and joined CDS" "Transcriptional activator Myb" "V-myb myeloblastosis viral oncogene homolog (Avian), isoform CRA_d" "V-myb myeloblastosis viral oncogene homologue (Avian)"))
(define-protein "Q79354_9HIV1" ("Gag protein"))
(define-protein "Q79360_9HIV1" ("Gag protein"))
(define-protein "Q7TJL8_HHV1" ("UL40"))
(define-protein "Q7Z6C1_HUMAN" ("EP300 protein"))
(define-protein "Q86SW4_HUMAN" ("Dihydrolipoyllysine-residue succinyltransferase component of 2-oxoglutarate dehydrogenase complex, mitochondrial" "Full-length cDNA 5-PRIME end of clone CS0DJ009YL13 of T cells (Jurkat cell line) of Homo sapiens (human)"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "Q86UY0_HUMAN" ("Protein BLOC1S5-TXNDC5" "TXNDC5 protein"))
<<<<<<< .mine
(define-protein "Q86V67_HUMAN" ("PDE4" "Phosphodiesterase isozyme 4"))
(define-protein "Q8AMB3_9DELA" ("TP65" "Tax protein"))
(define-protein "Q8IZD7_HUMAN" ("anti-Histone" "Anti-thyroglobulin heavy chain variable region"))
(define-protein "Q8NFL3_HUMAN" ("amphiphysin-1" "Amphiphysin I variant NT2"))
=======
<<<<<<< .mine
(define-protein "Q86V67_HUMAN" ("PDE4" "Phosphodiesterase isozyme 4"))
(define-protein "Q8AMB3_9DELA" ("TP65" "Tax protein"))
(define-protein "Q8IZD7_HUMAN" ("anti-Histone" "Anti-thyroglobulin heavy chain variable region"))
(define-protein "Q8NFL3_HUMAN" ("amphiphysin-1" "Amphiphysin I variant NT2"))
=======
(define-protein "Q86V67_HUMAN" ("Phosphodiesterase isozyme 4"))
(define-protein "Q8AMB3_9DELA" ("Tax protein"))
(define-protein "Q8IZD7_HUMAN" ("Anti-thyroglobulin heavy chain variable region"))
(define-protein "Q8NFL3_HUMAN" ("Amphiphysin I variant NT2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "Q96D37_HUMAN" ("Proto-oncogene vav" "VAV1 protein"))
<<<<<<< .mine
(define-protein "Q96T14_HUMAN" ("caenorhabditis" "cDNA FLJ14509 fis, clone NT2RM1000499, weakly similar to Caenorhabditis elegans centaurin gamma 1A"))
(define-protein "Q99C47_9HIV1" ("AGC2" "Envelope glycoprotein"))
(define-protein "Q9BY25_HUMAN" ("IL1β" "HCG2007431" "IL-1beta-regulated neutrophil survival protein"))
=======
<<<<<<< .mine
(define-protein "Q96T14_HUMAN" ("caenorhabditis" "cDNA FLJ14509 fis, clone NT2RM1000499, weakly similar to Caenorhabditis elegans centaurin gamma 1A"))
(define-protein "Q99C47_9HIV1" ("AGC2" "Envelope glycoprotein"))
(define-protein "Q9BY25_HUMAN" ("IL1β" "HCG2007431" "IL-1beta-regulated neutrophil survival protein"))
=======
(define-protein "Q96T14_HUMAN" ("cDNA FLJ14509 fis, clone NT2RM1000499, weakly similar to Caenorhabditis elegans centaurin gamma 1A"))
(define-protein "Q99C47_9HIV1" ("Envelope glycoprotein"))
(define-protein "Q9BY25_HUMAN" ("HCG2007431" "IL-1beta-regulated neutrophil survival protein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "Q9ENS0_HHV1" ("Thymidine kinase"))
<<<<<<< .mine
(define-protein "Q9UM81_HUMAN" ("ptpσ" "Protein-tyrosine-phosphatase"))
(define-protein "Q9UNC0_HUMAN" ("K65" "P58 killer cell inhibitory receptor KIR-K65"))
(define-protein "Q9WJJ2_9HIV1" ("JM-B" "Pol protein"))
(define-protein "R1AB_CVH22" ("proteinases" "Replicase polyprotein 1ab" "pp1ab" "ORF1ab polyprotein"))
=======
<<<<<<< .mine
(define-protein "Q9UM81_HUMAN" ("ptpσ" "Protein-tyrosine-phosphatase"))
(define-protein "Q9UNC0_HUMAN" ("K65" "P58 killer cell inhibitory receptor KIR-K65"))
(define-protein "Q9WJJ2_9HIV1" ("JM-B" "Pol protein"))
(define-protein "R1AB_CVH22" ("proteinases" "Replicase polyprotein 1ab" "pp1ab" "ORF1ab polyprotein"))
=======
(define-protein "Q9UM81_HUMAN" ("Protein-tyrosine-phosphatase"))
(define-protein "Q9UNC0_HUMAN" ("P58 killer cell inhibitory receptor KIR-K65"))
(define-protein "Q9WJJ2_9HIV1" ("Pol protein"))
(define-protein "R1AB_CVH22" ("Replicase polyprotein 1ab" "pp1ab" "ORF1ab polyprotein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "R51A1_HUMAN" ("RAD51AP1" "PIR51")) 
(define-protein "RA51B_HUMAN" ("DNA repair protein RAD51 homolog 2" "R51H2" "RAD51 homolog B" "Rad51B" "RAD51-like protein 1"))
(define-protein "RA51B_HUMAN" ("paralogs" "DNA repair protein RAD51 homolog 2" "R51H2" "RAD51 homolog B" "Rad51B" "RAD51-like protein 1"))
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
<<<<<<< .mine
(define-protein "RAB3A_HUMAN" ("Rab3A" "Ras-related protein Rab-3A"))
=======
<<<<<<< .mine
(define-protein "RAB3A_HUMAN" ("Rab3A" "Ras-related protein Rab-3A"))
=======
(define-protein "RAB3A_HUMAN" ("Ras-related protein Rab-3A"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "RAB43_HUMAN" ("RAB41" "RAB43")) 
(define-protein "RAB5B_HUMAN" ("RAB5B")) 
(define-protein "RAB5C_HUMAN" ("L1880" "RABL" "RAB5L" "RAB5C")) 
(define-protein "RAB6A_HUMAN" ("RAB6" "RAB6A" "Rab-6")) 
(define-protein "RAB7A_HUMAN" ("RAB7A" "RAB7")) 
(define-protein "RAB8A_HUMAN" ("RAB8" "MEL" "RAB8A")) 
(define-protein "RAB9A_HUMAN" ("RAB9A" "RAB9")) 
(define-protein "RABE1_HUMAN" ("RABPT5" "RABPT5A" "RABEP1" "Rabaptin-5alpha" "Rabaptin-5" "Rabaptin-4" "RAB5EP")) 
(define-protein "RABL3_HUMAN" ("RABL3")) 
(define-protein "RABL6_HUMAN" ("RBEL1" "RABL6" "PARF" "C9orf86")) 
(define-protein "RAC1_HUMAN" ("Rac-1" "Ras-related C3 botulinum toxin substrate 1" "Cell migration-inducing gene 5 protein" "Ras-like protein TC25" "p21-Rac1"))
(define-protein "RAC1_HUMAN" ("Ras-related C3 botulinum toxin substrate 1" "Cell migration-inducing gene 5 protein" "Ras-like protein TC25" "p21-Rac1"))
(define-protein "RAD51_HUMAN" ("DNA repair protein RAD51 homolog 1" "HsRAD51" "hRAD51" "RAD51 homolog A"))
<<<<<<< .mine
(define-protein "RAD51_HUMAN" ("Rad51" "DNA repair protein RAD51 homolog 1" "HsRAD51" "hRAD51" "RAD51 homolog A"))
(define-protein "RAD52_HUMAN" ("Rad52" "DNA repair protein RAD52 homolog"))
=======
<<<<<<< .mine
(define-protein "RAD51_HUMAN" ("Rad51" "DNA repair protein RAD51 homolog 1" "HsRAD51" "hRAD51" "RAD51 homolog A"))
(define-protein "RAD52_HUMAN" ("Rad52" "DNA repair protein RAD52 homolog"))
=======
(define-protein "RAD52_HUMAN" ("DNA repair protein RAD52 homolog"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "RADI_HUMAN" ("RDX")) 
<<<<<<< .mine
(define-protein "RAG1_HUMAN" ("nbd" "V(D)J recombination-activating protein 1" "RAG-1" "RING finger protein 74"))
=======
<<<<<<< .mine
(define-protein "RAG1_HUMAN" ("nbd" "V(D)J recombination-activating protein 1" "RAG-1" "RING finger protein 74"))
=======
(define-protein "RAG1_HUMAN" ("V(D)J recombination-activating protein 1" "RAG-1" "RING finger protein 74"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "RAGP1_HUMAN" ("SD" "RanGAP1" "RANGAP1" "KIAA1835")) 
(define-protein "RAI3_HUMAN" ("RAI3" "RAIG-1" "GPRC5A" "GPCR5A" "RAIG1")) 
(define-protein "RAIN_HUMAN" ("Rain" "RASIP1")) 
<<<<<<< .mine
(define-protein "RALA_HUMAN" ("Exo84" "Ras-related protein Ral-A"))
=======
<<<<<<< .mine
(define-protein "RALA_HUMAN" ("Exo84" "Ras-related protein Ral-A"))
=======
(define-protein "RALA_HUMAN" ("Ras-related protein Ral-A"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "RANG_HUMAN" ("RanBP1" "RANBP1")) 
(define-protein "RAN_HUMAN" ("ARA24" "RAN")) 
<<<<<<< .mine
(define-protein "RAP2A_HUMAN" ("gtpγs" "Ras-related protein Rap-2a" "RbBP-30"))
=======
<<<<<<< .mine
(define-protein "RAP2A_HUMAN" ("gtpγs" "Ras-related protein Rap-2a" "RbBP-30"))
=======
(define-protein "RAP2A_HUMAN" ("Ras-related protein Rap-2a" "RbBP-30"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "RAP2B_HUMAN" ("RAP2B")) 
<<<<<<< .mine
(define-protein "RAPH1_HUMAN" ("lamellipodin" "Ras-associated and pleckstrin homology domains-containing protein 1" "RAPH1" "Amyotrophic lateral sclerosis 2 chromosomal region candidate gene 18 protein" "Amyotrophic lateral sclerosis 2 chromosomal region candidate gene 9 protein" "Lamellipodin" "Proline-rich EVH1 ligand 2" "PREL-2" "Protein RMO1"))
(define-protein "RARB_HUMAN" ("rar" "Retinoic acid receptor beta" "RAR-beta" "HBV-activated protein" "Nuclear receptor subfamily 1 group B member 2" "RAR-epsilon"))
(define-protein "RASD1_HUMAN" ("dexamethasone" "Dexamethasone-induced Ras-related protein 1" "Activator of G-protein signaling 1"))
=======
<<<<<<< .mine
(define-protein "RAPH1_HUMAN" ("lamellipodin" "Ras-associated and pleckstrin homology domains-containing protein 1" "RAPH1" "Amyotrophic lateral sclerosis 2 chromosomal region candidate gene 18 protein" "Amyotrophic lateral sclerosis 2 chromosomal region candidate gene 9 protein" "Lamellipodin" "Proline-rich EVH1 ligand 2" "PREL-2" "Protein RMO1"))
(define-protein "RARB_HUMAN" ("rar" "Retinoic acid receptor beta" "RAR-beta" "HBV-activated protein" "Nuclear receptor subfamily 1 group B member 2" "RAR-epsilon"))
(define-protein "RASD1_HUMAN" ("dexamethasone" "Dexamethasone-induced Ras-related protein 1" "Activator of G-protein signaling 1"))
=======
(define-protein "RAPH1_HUMAN" ("Ras-associated and pleckstrin homology domains-containing protein 1" "RAPH1" "Amyotrophic lateral sclerosis 2 chromosomal region candidate gene 18 protein" "Amyotrophic lateral sclerosis 2 chromosomal region candidate gene 9 protein" "Lamellipodin" "Proline-rich EVH1 ligand 2" "PREL-2" "Protein RMO1"))
(define-protein "RARB_HUMAN" ("Retinoic acid receptor beta" "RAR-beta" "HBV-activated protein" "Nuclear receptor subfamily 1 group B member 2" "RAR-epsilon"))
(define-protein "RASD1_HUMAN" ("Dexamethasone-induced Ras-related protein 1" "Activator of G-protein signaling 1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "RASF1_HUMAN" ("RASSF1" "RDA32")) 
(define-protein "RASF2_HUMAN" ("RASSF2" "KIAA0168")) 
(define-protein "RASF5_HUMAN" ("NORE1" "RASSF5" "RAPL")) 
<<<<<<< .mine
(define-protein "RASH_HUMAN" ("H-ras" "GTPase HRas" "H-Ras-1" "Ha-Ras" "Transforming protein p21" "c-H-ras" "p21ras"))
(define-protein "RASK_HUMAN" ("Ras-" "GTPase KRas" "K-Ras 2" "Ki-Ras" "c-K-ras" "c-Ki-ras"))
=======
<<<<<<< .mine
(define-protein "RASH_HUMAN" ("H-ras" "GTPase HRas" "H-Ras-1" "Ha-Ras" "Transforming protein p21" "c-H-ras" "p21ras"))
(define-protein "RASK_HUMAN" ("Ras-" "GTPase KRas" "K-Ras 2" "Ki-Ras" "c-K-ras" "c-Ki-ras"))
=======
(define-protein "RASH_HUMAN" ("GTPase HRas" "H-Ras-1" "Ha-Ras" "Transforming protein p21" "c-H-ras" "p21ras"))
(define-protein "RASK_HUMAN" ("GTPase KRas" "K-Ras 2" "Ki-Ras" "c-K-ras" "c-Ki-ras"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "RB11A_HUMAN" ("RAB11" "RAB11A" "YL8" "Rab-11")) 
<<<<<<< .mine
(define-protein "RB33A_HUMAN" ("rabs" "Ras-related protein Rab-33A" "Small GTP-binding protein S10"))
=======
<<<<<<< .mine
(define-protein "RB33A_HUMAN" ("rabs" "Ras-related protein Rab-33A" "Small GTP-binding protein S10"))
=======
(define-protein "RB33A_HUMAN" ("Ras-related protein Rab-33A" "Small GTP-binding protein S10"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "RB33B_HUMAN" ("RAB33B")) 
(define-protein "RB3GP_HUMAN" ("KIAA0066" "RAB3GAP" "Rab3-GAP" "RAB3GAP1")) 
(define-protein "RBBP4_HUMAN" ("Histone-binding protein RBBP4" "Chromatin assembly factor 1 subunit C" "CAF-1 subunit C" "Chromatin assembly factor I p48 subunit" "CAF-I 48 kDa subunit" "CAF-I p48" "Nucleosome-remodeling factor subunit RBAP48" "Retinoblastoma-binding protein 4" "RBBP-4" "Retinoblastoma-binding protein p48"))
<<<<<<< .mine
(define-protein "RBBP4_HUMAN" ("RbAp48" "Histone-binding protein RBBP4" "Chromatin assembly factor 1 subunit C" "CAF-1 subunit C" "Chromatin assembly factor I p48 subunit" "CAF-I 48 kDa subunit" "CAF-I p48" "Nucleosome-remodeling factor subunit RBAP48" "Retinoblastoma-binding protein 4" "RBBP-4" "Retinoblastoma-binding protein p48"))
(define-protein "RBBP5_HUMAN" ("RbBP5" "Retinoblastoma-binding protein 5" "RBBP-5" "Retinoblastoma-binding protein RBQ-3"))
=======
<<<<<<< .mine
(define-protein "RBBP4_HUMAN" ("RbAp48" "Histone-binding protein RBBP4" "Chromatin assembly factor 1 subunit C" "CAF-1 subunit C" "Chromatin assembly factor I p48 subunit" "CAF-I 48 kDa subunit" "CAF-I p48" "Nucleosome-remodeling factor subunit RBAP48" "Retinoblastoma-binding protein 4" "RBBP-4" "Retinoblastoma-binding protein p48"))
(define-protein "RBBP5_HUMAN" ("RbBP5" "Retinoblastoma-binding protein 5" "RBBP-5" "Retinoblastoma-binding protein RBQ-3"))
=======
(define-protein "RBBP5_HUMAN" ("Retinoblastoma-binding protein 5" "RBBP-5" "Retinoblastoma-binding protein RBQ-3"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "RBBP7_HUMAN" ("Histone-binding protein RBBP7" "Histone acetyltransferase type B subunit 2" "Nucleosome-remodeling factor subunit RBAP46" "Retinoblastoma-binding protein 7" "RBBP-7" "Retinoblastoma-binding protein p46"))
<<<<<<< .mine
(define-protein "RBBP7_HUMAN" ("RbAp46" "Histone-binding protein RBBP7" "Histone acetyltransferase type B subunit 2" "Nucleosome-remodeling factor subunit RBAP46" "Retinoblastoma-binding protein 7" "RBBP-7" "Retinoblastoma-binding protein p46"))
(define-protein "RBCC1_HUMAN" ("RB1-inducible coiled-coil protein 1" "FAK family kinase-interacting protein of 200 kDa" "FIP200"))
=======
<<<<<<< .mine
(define-protein "RBBP7_HUMAN" ("RbAp46" "Histone-binding protein RBBP7" "Histone acetyltransferase type B subunit 2" "Nucleosome-remodeling factor subunit RBAP46" "Retinoblastoma-binding protein 7" "RBBP-7" "Retinoblastoma-binding protein p46"))
(define-protein "RBCC1_HUMAN" ("RB1-inducible coiled-coil protein 1" "FAK family kinase-interacting protein of 200 kDa" "FIP200"))
=======
(define-protein "RBCC1_HUMAN" ("RB1-inducible coiled-coil protein 1" "FAK family kinase-interacting protein of 200 kDa" "FIP200"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "RBGPR_HUMAN" ("Rab3-GAP150" "KIAA0839" "RGAP-iso" "RAB3GAP2")) 
(define-protein "RBL2A_HUMAN" ("RABL2A")) 
<<<<<<< .mine
(define-protein "RBM8A_HUMAN" ("mrnas" "RNA-binding protein 8A" "Binder of OVCA1-1" "BOV-1" "RNA-binding motif protein 8A" "RNA-binding protein Y14" "Ribonucleoprotein RBM8A"))
(define-protein "RBNS5_HUMAN" ("rabenosyn" "Rabenosyn-5" "110 kDa protein" "FYVE finger-containing Rab5 effector protein rabenosyn-5" "RAB effector RBSN" "Zinc finger FYVE domain-containing protein 20"))
=======
<<<<<<< .mine
(define-protein "RBM8A_HUMAN" ("mrnas" "RNA-binding protein 8A" "Binder of OVCA1-1" "BOV-1" "RNA-binding motif protein 8A" "RNA-binding protein Y14" "Ribonucleoprotein RBM8A"))
(define-protein "RBNS5_HUMAN" ("rabenosyn" "Rabenosyn-5" "110 kDa protein" "FYVE finger-containing Rab5 effector protein rabenosyn-5" "RAB effector RBSN" "Zinc finger FYVE domain-containing protein 20"))
=======
(define-protein "RBM8A_HUMAN" ("RNA-binding protein 8A" "Binder of OVCA1-1" "BOV-1" "RNA-binding motif protein 8A" "RNA-binding protein Y14" "Ribonucleoprotein RBM8A"))
(define-protein "RBNS5_HUMAN" ("Rabenosyn-5" "110 kDa protein" "FYVE finger-containing Rab5 effector protein rabenosyn-5" "RAB effector RBSN" "Zinc finger FYVE domain-containing protein 20"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "RBP17_HUMAN" ("RANBP17")) 
<<<<<<< .mine
(define-protein "RBP1_HUMAN" ("doxorubicin" "RalA-binding protein 1" "RalBP1" "76 kDa Ral-interacting protein" "Dinitrophenyl S-glutathione ATPase" "DNP-SG ATPase" "Ral-interacting protein 1"))
(define-protein "RBTN2_HUMAN" ("rhombotin-2" "Rhombotin-2" "Cysteine-rich protein TTG-2" "LIM domain only protein 2" "LMO-2" "T-cell translocation protein 2"))
=======
<<<<<<< .mine
(define-protein "RBP1_HUMAN" ("doxorubicin" "RalA-binding protein 1" "RalBP1" "76 kDa Ral-interacting protein" "Dinitrophenyl S-glutathione ATPase" "DNP-SG ATPase" "Ral-interacting protein 1"))
(define-protein "RBTN2_HUMAN" ("rhombotin-2" "Rhombotin-2" "Cysteine-rich protein TTG-2" "LIM domain only protein 2" "LMO-2" "T-cell translocation protein 2"))
=======
(define-protein "RBP1_HUMAN" ("RalA-binding protein 1" "RalBP1" "76 kDa Ral-interacting protein" "Dinitrophenyl S-glutathione ATPase" "DNP-SG ATPase" "Ral-interacting protein 1"))
(define-protein "RBTN2_HUMAN" ("Rhombotin-2" "Cysteine-rich protein TTG-2" "LIM domain only protein 2" "LMO-2" "T-cell translocation protein 2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "RB_HUMAN" ("Retinoblastoma-associated protein" "p105-Rb" "pRb" "Rb" "pp110"))
(define-protein "RB_HUMAN" ("pp110" "Rb" "pRb" "p105-Rb" "RB1")) 
(define-protein "RCAS1_HUMAN" ("RCAS1" "EBAG9")) 
<<<<<<< .mine
(define-protein "RCC2_HUMAN" ("td" "Protein RCC2" "RCC1-like protein TD-60" "Telophase disk protein of 60 kDa"))
=======
<<<<<<< .mine
(define-protein "RCC2_HUMAN" ("td" "Protein RCC2" "RCC1-like protein TD-60" "Telophase disk protein of 60 kDa"))
=======
(define-protein "RCC2_HUMAN" ("Protein RCC2" "RCC1-like protein TD-60" "Telophase disk protein of 60 kDa"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "RCD1_HUMAN" ("CNOT9" "RCD1" "RQCD1" "Rcd-1")) 
<<<<<<< .mine
(define-protein "RECK_HUMAN" ("reck" "Reversion-inducing cysteine-rich protein with Kazal motifs" "hRECK" "Suppressor of tumorigenicity 15 protein"))
(define-protein "RELB_HUMAN" ("relb" "Transcription factor RelB" "I-Rel"))
(define-protein "REL_HUMAN" ("c-rel" "Proto-oncogene c-Rel"))
=======
<<<<<<< .mine
(define-protein "RECK_HUMAN" ("reck" "Reversion-inducing cysteine-rich protein with Kazal motifs" "hRECK" "Suppressor of tumorigenicity 15 protein"))
(define-protein "RELB_HUMAN" ("relb" "Transcription factor RelB" "I-Rel"))
(define-protein "REL_HUMAN" ("c-rel" "Proto-oncogene c-Rel"))
=======
(define-protein "RECK_HUMAN" ("Reversion-inducing cysteine-rich protein with Kazal motifs" "hRECK" "Suppressor of tumorigenicity 15 protein"))
(define-protein "RELB_HUMAN" ("Transcription factor RelB" "I-Rel"))
(define-protein "REL_HUMAN" ("Proto-oncogene c-Rel"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "REPS1_HUMAN" ("REPS1")) 
(define-protein "REQU_HUMAN" ("Zinc finger protein ubi-d4" "Apoptosis response zinc finger protein" "BRG1-associated factor 45D" "BAF45D" "D4, zinc and double PHD fingers family 2" "Protein requiem"))
<<<<<<< .mine
(define-protein "RES18_HUMAN" ("endocrine" "Regulated endocrine-specific protein 18"))
(define-protein "REST_HUMAN" ("nrsf" "RE1-silencing transcription factor" "Neural-restrictive silencer factor" "X2 box repressor"))
(define-protein "RET3_HUMAN" ("retinoid" "Retinol-binding protein 3" "Interphotoreceptor retinoid-binding protein" "IRBP" "Interstitial retinol-binding protein"))
(define-protein "RETN_HUMAN" ("resistin" "Resistin" "Adipose tissue-specific secretory factor" "ADSF" "C/EBP-epsilon-regulated myeloid-specific secreted cysteine-rich protein" "Cysteine-rich secreted protein A12-alpha-like 2" "Cysteine-rich secreted protein FIZZ3"))
(define-protein "RET_HUMAN" ("Ret9" "Proto-oncogene tyrosine-protein kinase receptor Ret" "Cadherin family member 12" "Proto-oncogene c-Ret"))
(define-protein "RFFL_HUMAN" ("caspases" "E3 ubiquitin-protein ligase rififylin" "Caspase regulator CARP2" "Caspases-8 and -10-associated RING finger protein 2" "CARP-2" "FYVE-RING finger protein Sakura" "Fring" "RING finger and FYVE-like domain-containing protein 1" "RING finger protein 189" "RING finger protein 34-like"))
=======
<<<<<<< .mine
(define-protein "RES18_HUMAN" ("endocrine" "Regulated endocrine-specific protein 18"))
(define-protein "REST_HUMAN" ("nrsf" "RE1-silencing transcription factor" "Neural-restrictive silencer factor" "X2 box repressor"))
(define-protein "RET3_HUMAN" ("retinoid" "Retinol-binding protein 3" "Interphotoreceptor retinoid-binding protein" "IRBP" "Interstitial retinol-binding protein"))
(define-protein "RETN_HUMAN" ("resistin" "Resistin" "Adipose tissue-specific secretory factor" "ADSF" "C/EBP-epsilon-regulated myeloid-specific secreted cysteine-rich protein" "Cysteine-rich secreted protein A12-alpha-like 2" "Cysteine-rich secreted protein FIZZ3"))
(define-protein "RET_HUMAN" ("Ret9" "Proto-oncogene tyrosine-protein kinase receptor Ret" "Cadherin family member 12" "Proto-oncogene c-Ret"))
(define-protein "RFFL_HUMAN" ("caspases" "E3 ubiquitin-protein ligase rififylin" "Caspase regulator CARP2" "Caspases-8 and -10-associated RING finger protein 2" "CARP-2" "FYVE-RING finger protein Sakura" "Fring" "RING finger and FYVE-like domain-containing protein 1" "RING finger protein 189" "RING finger protein 34-like"))
=======
(define-protein "RES18_HUMAN" ("Regulated endocrine-specific protein 18"))
(define-protein "REST_HUMAN" ("RE1-silencing transcription factor" "Neural-restrictive silencer factor" "X2 box repressor"))
(define-protein "RET3_HUMAN" ("Retinol-binding protein 3" "Interphotoreceptor retinoid-binding protein" "IRBP" "Interstitial retinol-binding protein"))
(define-protein "RETN_HUMAN" ("Resistin" "Adipose tissue-specific secretory factor" "ADSF" "C/EBP-epsilon-regulated myeloid-specific secreted cysteine-rich protein" "Cysteine-rich secreted protein A12-alpha-like 2" "Cysteine-rich secreted protein FIZZ3"))
(define-protein "RET_HUMAN" ("Proto-oncogene tyrosine-protein kinase receptor Ret" "Cadherin family member 12" "Proto-oncogene c-Ret"))
(define-protein "RFFL_HUMAN" ("E3 ubiquitin-protein ligase rififylin" "Caspase regulator CARP2" "Caspases-8 and -10-associated RING finger protein 2" "CARP-2" "FYVE-RING finger protein Sakura" "Fring" "RING finger and FYVE-like domain-containing protein 1" "RING finger protein 189" "RING finger protein 34-like"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "RFWD2_HUMAN" ("E3 ubiquitin-protein ligase RFWD2" "Constitutive photomorphogenesis protein 1 homolog" "hCOP1" "RING finger and WD repeat domain protein 2" "RING finger protein 200"))
(define-protein "RGAP1_HUMAN" ("RACGAP1" "MGCRACGAP" "CYK4" "MgcRacGAP" "HsCYK-4" "KIAA1478")) 
(define-protein "RGDSR_HUMAN" ("RGL4" "hRGR" "RGR")) 
(define-protein "RGRF1_HUMAN" ("Ras-specific guanine nucleotide-releasing factor 1" "Ras-GRF1" "Guanine nucleotide-releasing protein" "GNRP" "Ras-specific nucleotide exchange factor CDC25"))
(define-protein "RGS12_HUMAN" ("RGS12")) 
(define-protein "RGS14_HUMAN" ("RGS14")) 
(define-protein "RHEB_HUMAN" ("RHEB" "RHEB2")) 
(define-protein "RHG01_HUMAN" ("p50-RhoGAP" "CDC42GAP" "RHOGAP1" "ARHGAP1")) 
(define-protein "RHG08_HUMAN" ("ARHGAP8")) 
<<<<<<< .mine
(define-protein "RHG09_HUMAN" ("ArhGAP9" "Rho GTPase-activating protein 9" "Rho-type GTPase-activating protein 9"))
=======
<<<<<<< .mine
(define-protein "RHG09_HUMAN" ("ArhGAP9" "Rho GTPase-activating protein 9" "Rho-type GTPase-activating protein 9"))
=======
(define-protein "RHG09_HUMAN" ("Rho GTPase-activating protein 9" "Rho-type GTPase-activating protein 9"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "RHG17_HUMAN" ("RICH-1" "ARHGAP17" "RICH1")) 
(define-protein "RHG18_HUMAN" ("ARHGAP18" "MacGAP")) 
(define-protein "RHG32_HUMAN" ("Rho GTPase-activating protein 32" "Brain-specific Rho GTPase-activating protein" "GAB-associated Cdc42/Rac GTPase-activating protein" "GC-GAP" "GTPase regulator interacting with TrkA" "Rho-type GTPase-activating protein 32" "Rho/Cdc42/Rac GTPase-activating protein RICS" "RhoGAP involved in the beta-catenin-N-cadherin and NMDA receptor signaling" "p200RhoGAP" "p250GAP"))
(define-protein "RHNO1_HUMAN" ("RAD9, HUS1, RAD1-interacting nuclear orphan protein 1" "RAD9, RAD1, HUS1-interacting nuclear orphan protein"))
<<<<<<< .mine
(define-protein "RHNO1_HUMAN" ("Rad9-Rad1-Hus1" "RAD9, HUS1, RAD1-interacting nuclear orphan protein 1" "RAD9, RAD1, HUS1-interacting nuclear orphan protein"))
(define-protein "RHOA_HUMAN" ("RhoA-" "Transforming protein RhoA" "Rho cDNA clone 12" "h12"))
=======
<<<<<<< .mine
(define-protein "RHNO1_HUMAN" ("Rad9-Rad1-Hus1" "RAD9, HUS1, RAD1-interacting nuclear orphan protein 1" "RAD9, RAD1, HUS1-interacting nuclear orphan protein"))
(define-protein "RHOA_HUMAN" ("RhoA-" "Transforming protein RhoA" "Rho cDNA clone 12" "h12"))
=======
(define-protein "RHOA_HUMAN" ("Transforming protein RhoA" "Rho cDNA clone 12" "h12"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "RHOD_HUMAN" ("RHOD" "ARHD" "RhoHP1")) 
(define-protein "RHOF_HUMAN" ("RIF" "RHOF" "ARHF")) 
(define-protein "RIC8A_HUMAN" ("RIC8A")) 
<<<<<<< .mine
(define-protein "RICTR_HUMAN" ("RICTOR-mTOR" "Rapamycin-insensitive companion of mTOR" "AVO3 homolog" "hAVO3"))
=======
<<<<<<< .mine
(define-protein "RICTR_HUMAN" ("RICTOR-mTOR" "Rapamycin-insensitive companion of mTOR" "AVO3 homolog" "hAVO3"))
=======
(define-protein "RICTR_HUMAN" ("Rapamycin-insensitive companion of mTOR" "AVO3 homolog" "hAVO3"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "RIF1_HUMAN" ("RIF1")) 
(define-protein "RIMS1_HUMAN" ("RAB3IP2" "RIM1" "KIAA0340" "RIMS1")) 
(define-protein "RING2_HUMAN" ("E3 ubiquitin-protein ligase RING2" "Huntingtin-interacting protein 2-interacting protein 3" "HIP2-interacting protein 3" "Protein DinG" "RING finger protein 1B" "RING1b" "RING finger protein 2" "RING finger protein BAP-1"))
(define-protein "RINT1_HUMAN" ("RINT1" "HsRINT-1" "RINT-1")) 
<<<<<<< .mine
(define-protein "RIR1_HUMAN" ("cladribine" "Ribonucleoside-diphosphate reductase large subunit" "Ribonucleoside-diphosphate reductase subunit M1" "Ribonucleotide reductase large subunit"))
=======
<<<<<<< .mine
(define-protein "RIR1_HUMAN" ("cladribine" "Ribonucleoside-diphosphate reductase large subunit" "Ribonucleoside-diphosphate reductase subunit M1" "Ribonucleotide reductase large subunit"))
>>>>>>> .r4471
(define-protein "RKIP" NIL) 
<<<<<<< .mine
(define-protein "RL1D1_HUMAN" ("L12" "Ribosomal L1 domain-containing protein 1" "CATX-11" "Cellular senescence-inhibited gene protein" "Protein PBK1"))
=======
=======
(define-protein "RIR1_HUMAN" ("Ribonucleoside-diphosphate reductase large subunit" "Ribonucleoside-diphosphate reductase subunit M1" "Ribonucleotide reductase large subunit"))
(define-protein "RL1D1_HUMAN" ("Ribosomal L1 domain-containing protein 1" "CATX-11" "Cellular senescence-inhibited gene protein" "Protein PBK1"))
>>>>>>> .r4470
(define-protein "RL1D1_HUMAN" ("L12" "Ribosomal L1 domain-containing protein 1" "CATX-11" "Cellular senescence-inhibited gene protein" "Protein PBK1"))
>>>>>>> .r4471
(define-protein "RL22_HUMAN" ("EAP" "RPL22")) 
(define-protein "RL23A_HUMAN" ("RPL23A")) 
(define-protein "RL29_HUMAN" ("RPL29")) 
(define-protein "RL30_HUMAN" ("RPL30")) 
(define-protein "RL39L_HUMAN" ("RPL39L" "RPL39L1")) 
<<<<<<< .mine
(define-protein "RM32_HUMAN" ("L32" "39S ribosomal protein L32, mitochondrial" "L32mt" "MRP-L32"))
(define-protein "RMI1_HUMAN" ("blm" "RecQ-mediated genome instability protein 1" "BLM-associated protein of 75 kDa" "BLAP75" "FAAP75"))
=======
<<<<<<< .mine
(define-protein "RM32_HUMAN" ("L32" "39S ribosomal protein L32, mitochondrial" "L32mt" "MRP-L32"))
(define-protein "RMI1_HUMAN" ("blm" "RecQ-mediated genome instability protein 1" "BLM-associated protein of 75 kDa" "BLAP75" "FAAP75"))
=======
(define-protein "RM32_HUMAN" ("39S ribosomal protein L32, mitochondrial" "L32mt" "MRP-L32"))
(define-protein "RMI1_HUMAN" ("RecQ-mediated genome instability protein 1" "BLM-associated protein of 75 kDa" "BLAP75" "FAAP75"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "RMND1_HUMAN" ("C6orf96" "RMND1")) 
(define-protein "RN115_HUMAN" ("RNF115" "ZNF364")) 
(define-protein "RNAP" ("RNAPII")) 
<<<<<<< .mine
(define-protein "RNC_HUMAN" ("mirnas" "Ribonuclease 3" "Protein Drosha" "Ribonuclease III" "RNase III" "p241"))
=======
<<<<<<< .mine
(define-protein "RNC_HUMAN" ("mirnas" "Ribonuclease 3" "Protein Drosha" "Ribonuclease III" "RNase III" "p241"))
=======
(define-protein "RNC_HUMAN" ("Ribonuclease 3" "Protein Drosha" "Ribonuclease III" "RNase III" "p241"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "RNH2B_HUMAN" ("DLEU8" "AGS2" "RNASEH2B")) 
<<<<<<< .mine
(define-protein "RO52_HUMAN" ("Ro52" "E3 ubiquitin-protein ligase TRIM21" "52 kDa Ro protein" "52 kDa ribonucleoprotein autoantigen Ro/SS-A" "RING finger protein 81" "Ro(SS-A)" "Sjoegren syndrome type A antigen" "SS-A" "Tripartite motif-containing protein 21"))
(define-protein "ROA2_HUMAN" ("2/B1" "Heterogeneous nuclear ribonucleoproteins A2/B1" "hnRNP A2/B1"))
(define-protein "ROBO2_HUMAN" ("Robo2" "Roundabout homolog 2"))
(define-protein "ROS1_HUMAN" ("ros" "Proto-oncogene tyrosine-protein kinase ROS" "Proto-oncogene c-Ros" "Proto-oncogene c-Ros-1" "Receptor tyrosine kinase c-ros oncogene 1" "c-Ros receptor tyrosine kinase"))
(define-protein "RPAB3_HUMAN" ("polymerases" "DNA-directed RNA polymerases I, II, and III subunit RPABC3" "RNA polymerases I, II, and III subunit ABC3" "DNA-directed RNA polymerase II subunit H" "DNA-directed RNA polymerases I, II, and III 17.1 kDa polypeptide" "RPB17" "RPB8 homolog" "hRPB8"))
(define-protein "RPE65_HUMAN" ("palmitate" "Retinoid isomerohydrolase" "All-trans-retinyl-palmitate hydrolase" "Retinal pigment epithelium-specific 65 kDa protein" "Retinol isomerase"))
=======
<<<<<<< .mine
(define-protein "RO52_HUMAN" ("Ro52" "E3 ubiquitin-protein ligase TRIM21" "52 kDa Ro protein" "52 kDa ribonucleoprotein autoantigen Ro/SS-A" "RING finger protein 81" "Ro(SS-A)" "Sjoegren syndrome type A antigen" "SS-A" "Tripartite motif-containing protein 21"))
(define-protein "ROA2_HUMAN" ("2/B1" "Heterogeneous nuclear ribonucleoproteins A2/B1" "hnRNP A2/B1"))
(define-protein "ROBO2_HUMAN" ("Robo2" "Roundabout homolog 2"))
(define-protein "ROS1_HUMAN" ("ros" "Proto-oncogene tyrosine-protein kinase ROS" "Proto-oncogene c-Ros" "Proto-oncogene c-Ros-1" "Receptor tyrosine kinase c-ros oncogene 1" "c-Ros receptor tyrosine kinase"))
(define-protein "RPAB3_HUMAN" ("polymerases" "DNA-directed RNA polymerases I, II, and III subunit RPABC3" "RNA polymerases I, II, and III subunit ABC3" "DNA-directed RNA polymerase II subunit H" "DNA-directed RNA polymerases I, II, and III 17.1 kDa polypeptide" "RPB17" "RPB8 homolog" "hRPB8"))
(define-protein "RPE65_HUMAN" ("palmitate" "Retinoid isomerohydrolase" "All-trans-retinyl-palmitate hydrolase" "Retinal pigment epithelium-specific 65 kDa protein" "Retinol isomerase"))
=======
(define-protein "RO52_HUMAN" ("E3 ubiquitin-protein ligase TRIM21" "52 kDa Ro protein" "52 kDa ribonucleoprotein autoantigen Ro/SS-A" "RING finger protein 81" "Ro(SS-A)" "Sjoegren syndrome type A antigen" "SS-A" "Tripartite motif-containing protein 21"))
(define-protein "ROA2_HUMAN" ("Heterogeneous nuclear ribonucleoproteins A2/B1" "hnRNP A2/B1"))
(define-protein "ROBO2_HUMAN" ("Roundabout homolog 2"))
(define-protein "ROS1_HUMAN" ("Proto-oncogene tyrosine-protein kinase ROS" "Proto-oncogene c-Ros" "Proto-oncogene c-Ros-1" "Receptor tyrosine kinase c-ros oncogene 1" "c-Ros receptor tyrosine kinase"))
(define-protein "RPAB3_HUMAN" ("DNA-directed RNA polymerases I, II, and III subunit RPABC3" "RNA polymerases I, II, and III subunit ABC3" "DNA-directed RNA polymerase II subunit H" "DNA-directed RNA polymerases I, II, and III 17.1 kDa polypeptide" "RPB17" "RPB8 homolog" "hRPB8"))
(define-protein "RPE65_HUMAN" ("Retinoid isomerohydrolase" "All-trans-retinyl-palmitate hydrolase" "Retinal pigment epithelium-specific 65 kDa protein" "Retinol isomerase"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "RPGF2_HUMAN" ("KIAA0313" "PDZ-GEF1" "PDZGEF1" "RA-GEF-1" "RAPGEF2" "CNrasGEF" "NRAPGEP")) 
(define-protein "RPGF4_HUMAN" ("CGEF2" "RAPGEF4" "cAMP-GEFII" "EPAC2")) 
(define-protein "RPN1_HUMAN" ("RPN-I" "Ribophorin-1" "RPN1")) 
(define-protein "RPN2_HUMAN" ("RPN-II" "RIBIIR" "Ribophorin-2" "RPN2")) 
(define-protein "RPP21_HUMAN" ("Ribonuclease P protein subunit p21" "RNaseP protein p21" "Ribonuclease P/MRP 21 kDa subunit" "Ribonucleoprotein V"))
(define-protein "RPTOR_HUMAN" ("Regulatory-associated protein of mTOR" "Raptor" "p150 target of rapamycin (TOR)-scaffold protein"))
(define-protein "RS20_HUMAN" ("RPS20")) 
(define-protein "RS28_HUMAN" ("RPS28")) 
<<<<<<< .mine
(define-protein "RSAD2_HUMAN" ("pdcs" "Radical S-adenosyl methionine domain-containing protein 2" "Cytomegalovirus-induced gene 5 protein" "Viperin" "Virus inhibitory protein, endoplasmic reticulum-associated, interferon-inducible"))
=======
<<<<<<< .mine
(define-protein "RSAD2_HUMAN" ("pdcs" "Radical S-adenosyl methionine domain-containing protein 2" "Cytomegalovirus-induced gene 5 protein" "Viperin" "Virus inhibitory protein, endoplasmic reticulum-associated, interferon-inducible"))
=======
(define-protein "RSAD2_HUMAN" ("Radical S-adenosyl methionine domain-containing protein 2" "Cytomegalovirus-induced gene 5 protein" "Viperin" "Virus inhibitory protein, endoplasmic reticulum-associated, interferon-inducible"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "RSF1_HUMAN" ("RSF1" "Rsf-1" "HBXAP" "XAP8")) 
(define-protein "RSLBA_HUMAN" ("RASL11A")) 
(define-protein "RSRP1_HUMAN" ("RSRP1" "C1orf63")) 
(define-protein "RSU1_HUMAN" ("Rsu-1" "RSP1" "RSP-1" "RSU1")) 
<<<<<<< .mine
(define-protein "RT07_HUMAN" ("S7" "28S ribosomal protein S7, mitochondrial" "MRP-S7" "S7mt" "bMRP-27a" "bMRP27a"))
(define-protein "RT33_HUMAN" ("S33" "28S ribosomal protein S33, mitochondrial" "MRP-S33" "S33mt"))
=======
<<<<<<< .mine
(define-protein "RT07_HUMAN" ("S7" "28S ribosomal protein S7, mitochondrial" "MRP-S7" "S7mt" "bMRP-27a" "bMRP27a"))
(define-protein "RT33_HUMAN" ("S33" "28S ribosomal protein S33, mitochondrial" "MRP-S33" "S33mt"))
=======
(define-protein "RT07_HUMAN" ("28S ribosomal protein S7, mitochondrial" "MRP-S7" "S7mt" "bMRP-27a" "bMRP27a"))
(define-protein "RT33_HUMAN" ("28S ribosomal protein S33, mitochondrial" "MRP-S33" "S33mt"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "RTN3_HUMAN" ("RTN3" "HAP" "NSPL2" "ASYIP" "NSPLII")) 
(define-protein "RUFY1_HUMAN" ("RABIP4" "RUFY1" "ZFYVE12")) 
(define-protein "RUIT1_HUMAN" ("Putative uncharacterized protein encoded by RUNX1-IT1" "RUNX1 intronic transcript 1"))
<<<<<<< .mine
(define-protein "RUIT1_HUMAN" ("Runx1" "Putative uncharacterized protein encoded by RUNX1-IT1" "RUNX1 intronic transcript 1"))
(define-protein "RUN3B_HUMAN" ("Rap2" "RUN domain-containing protein 3B" "Rap2-binding protein 9" "Rap2-interacting protein 9" "RPIP-9"))
(define-protein "RUNX1_HUMAN" ("α-B" "Runt-related transcription factor 1" "Acute myeloid leukemia 1 protein" "Core-binding factor subunit alpha-2" "CBF-alpha-2" "Oncogene AML-1" "Polyomavirus enhancer-binding protein 2 alpha B subunit" "PEA2-alpha B" "PEBP2-alpha B" "SL3-3 enhancer factor 1 alpha B subunit" "SL3/AKV core-binding factor alpha B subunit"))
=======
<<<<<<< .mine
(define-protein "RUIT1_HUMAN" ("Runx1" "Putative uncharacterized protein encoded by RUNX1-IT1" "RUNX1 intronic transcript 1"))
(define-protein "RUN3B_HUMAN" ("Rap2" "RUN domain-containing protein 3B" "Rap2-binding protein 9" "Rap2-interacting protein 9" "RPIP-9"))
(define-protein "RUNX1_HUMAN" ("α-B" "Runt-related transcription factor 1" "Acute myeloid leukemia 1 protein" "Core-binding factor subunit alpha-2" "CBF-alpha-2" "Oncogene AML-1" "Polyomavirus enhancer-binding protein 2 alpha B subunit" "PEA2-alpha B" "PEBP2-alpha B" "SL3-3 enhancer factor 1 alpha B subunit" "SL3/AKV core-binding factor alpha B subunit"))
=======
(define-protein "RUN3B_HUMAN" ("RUN domain-containing protein 3B" "Rap2-binding protein 9" "Rap2-interacting protein 9" "RPIP-9"))
(define-protein "RUNX1_HUMAN" ("Runt-related transcription factor 1" "Acute myeloid leukemia 1 protein" "Core-binding factor subunit alpha-2" "CBF-alpha-2" "Oncogene AML-1" "Polyomavirus enhancer-binding protein 2 alpha B subunit" "PEA2-alpha B" "PEBP2-alpha B" "SL3-3 enhancer factor 1 alpha B subunit" "SL3/AKV core-binding factor alpha B subunit"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "RUNX2_HUMAN" ("Runt-related transcription factor 2" "Acute myeloid leukemia 3 protein" "Core-binding factor subunit alpha-1" "CBF-alpha-1" "Oncogene AML-3" "Osteoblast-specific transcription factor 2" "OSF-2" "Polyomavirus enhancer-binding protein 2 alpha A subunit" "PEA2-alpha A" "PEBP2-alpha A" "SL3-3 enhancer factor 1 alpha A subunit" "SL3/AKV core-binding factor alpha A subunit"))
<<<<<<< .mine
(define-protein "RUNX2_HUMAN" ("runx2" "Runt-related transcription factor 2" "Acute myeloid leukemia 3 protein" "Core-binding factor subunit alpha-1" "CBF-alpha-1" "Oncogene AML-3" "Osteoblast-specific transcription factor 2" "OSF-2" "Polyomavirus enhancer-binding protein 2 alpha A subunit" "PEA2-alpha A" "PEBP2-alpha A" "SL3-3 enhancer factor 1 alpha A subunit" "SL3/AKV core-binding factor alpha A subunit"))
(define-protein "RUVB2_HUMAN" ("reptin" "RuvB-like 2" "48 kDa TATA box-binding protein-interacting protein" "48 kDa TBP-interacting protein" "51 kDa erythrocyte cytosolic protein" "ECP-51" "INO80 complex subunit J" "Repressing pontin 52" "Reptin 52" "TIP49b" "TIP60-associated protein 54-beta" "TAP54-beta"))
=======
<<<<<<< .mine
(define-protein "RUNX2_HUMAN" ("runx2" "Runt-related transcription factor 2" "Acute myeloid leukemia 3 protein" "Core-binding factor subunit alpha-1" "CBF-alpha-1" "Oncogene AML-3" "Osteoblast-specific transcription factor 2" "OSF-2" "Polyomavirus enhancer-binding protein 2 alpha A subunit" "PEA2-alpha A" "PEBP2-alpha A" "SL3-3 enhancer factor 1 alpha A subunit" "SL3/AKV core-binding factor alpha A subunit"))
(define-protein "RUVB2_HUMAN" ("reptin" "RuvB-like 2" "48 kDa TATA box-binding protein-interacting protein" "48 kDa TBP-interacting protein" "51 kDa erythrocyte cytosolic protein" "ECP-51" "INO80 complex subunit J" "Repressing pontin 52" "Reptin 52" "TIP49b" "TIP60-associated protein 54-beta" "TAP54-beta"))
=======
(define-protein "RUVB2_HUMAN" ("RuvB-like 2" "48 kDa TATA box-binding protein-interacting protein" "48 kDa TBP-interacting protein" "51 kDa erythrocyte cytosolic protein" "ECP-51" "INO80 complex subunit J" "Repressing pontin 52" "Reptin 52" "TIP49b" "TIP60-associated protein 54-beta" "TAP54-beta"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "RUXE_HUMAN" ("SmE" "Sm-E" "SNRPE" "snRNP-E")) 
<<<<<<< .mine
(define-protein "RWDD3_HUMAN" ("rsume" "RWD domain-containing protein 3" "RWD domain-containing sumoylation enhancer" "RSUME"))
=======
<<<<<<< .mine
(define-protein "RWDD3_HUMAN" ("rsume" "RWD domain-containing protein 3" "RWD domain-containing sumoylation enhancer" "RSUME"))
=======
(define-protein "RWDD3_HUMAN" ("RWD domain-containing protein 3" "RWD domain-containing sumoylation enhancer" "RSUME"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "RXFP1_HUMAN" ("Relaxin receptor 1" "Leucine-rich repeat-containing G-protein coupled receptor 7" "Relaxin family peptide receptor 1"))
<<<<<<< .mine
(define-protein "RXRA_HUMAN" ("rxr" "Retinoic acid receptor RXR-alpha" "Nuclear receptor subfamily 2 group B member 1" "Retinoid X receptor alpha"))
=======
<<<<<<< .mine
(define-protein "RXRA_HUMAN" ("rxr" "Retinoic acid receptor RXR-alpha" "Nuclear receptor subfamily 2 group B member 1" "Retinoid X receptor alpha"))
=======
(define-protein "RXRA_HUMAN" ("Retinoic acid receptor RXR-alpha" "Nuclear receptor subfamily 2 group B member 1" "Retinoid X receptor alpha"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "Rassf5" NIL) 
<<<<<<< .mine
(define-protein "S10A1_HUMAN" ("S100" "Protein S100-A1" "S-100 protein alpha chain" "S-100 protein subunit alpha" "S100 calcium-binding protein A1"))
(define-protein "S10A7_HUMAN" ("A7" "Protein S100-A7" "Psoriasin" "S100 calcium-binding protein A7"))
(define-protein "S10A8_HUMAN" ("S100A8/A9" "Protein S100-A8" "Calgranulin-A" "Calprotectin L1L subunit" "Cystic fibrosis antigen" "CFAG" "Leukocyte L1 complex light chain" "Migration inhibitory factor-related protein 8" "MRP-8" "p8" "S100 calcium-binding protein A8" "Urinary stone protein band A"))
(define-protein "S10AB_HUMAN" ("A11" "Protein S100-A11" "Calgizzarin" "Metastatic lymph node gene 70 protein" "MLN 70" "Protein S100-C" "S100 calcium-binding protein A11"))
(define-protein "S10AC_HUMAN" ("P6" "Protein S100-A12" "CGRP" "Calcium-binding protein in amniotic fluid 1" "CAAF1" "Calgranulin-C" "CAGC" "Extracellular newly identified RAGE-binding protein" "EN-RAGE" "Migration inhibitory factor-related protein 6" "MRP-6" "p6" "Neutrophil S100 protein" "S100 calcium-binding protein A12"))
(define-protein "S12A3_HUMAN" ("nacl" "Solute carrier family 12 member 3" "Na-Cl cotransporter" "NCC" "Na-Cl symporter" "Thiazide-sensitive sodium-chloride cotransporter"))
(define-protein "S22A2_HUMAN" ("creatinine" "Solute carrier family 22 member 2" "Organic cation transporter 2" "hOCT2"))
(define-protein "S22A6_HUMAN" ("losartan" "Solute carrier family 22 member 6" "Organic anion transporter 1" "hOAT1" "PAH transporter" "hPAHT" "Renal organic anion transporter 1" "hROAT1"))
=======
<<<<<<< .mine
(define-protein "S10A1_HUMAN" ("S100" "Protein S100-A1" "S-100 protein alpha chain" "S-100 protein subunit alpha" "S100 calcium-binding protein A1"))
(define-protein "S10A7_HUMAN" ("A7" "Protein S100-A7" "Psoriasin" "S100 calcium-binding protein A7"))
(define-protein "S10A8_HUMAN" ("S100A8/A9" "Protein S100-A8" "Calgranulin-A" "Calprotectin L1L subunit" "Cystic fibrosis antigen" "CFAG" "Leukocyte L1 complex light chain" "Migration inhibitory factor-related protein 8" "MRP-8" "p8" "S100 calcium-binding protein A8" "Urinary stone protein band A"))
(define-protein "S10AB_HUMAN" ("A11" "Protein S100-A11" "Calgizzarin" "Metastatic lymph node gene 70 protein" "MLN 70" "Protein S100-C" "S100 calcium-binding protein A11"))
(define-protein "S10AC_HUMAN" ("P6" "Protein S100-A12" "CGRP" "Calcium-binding protein in amniotic fluid 1" "CAAF1" "Calgranulin-C" "CAGC" "Extracellular newly identified RAGE-binding protein" "EN-RAGE" "Migration inhibitory factor-related protein 6" "MRP-6" "p6" "Neutrophil S100 protein" "S100 calcium-binding protein A12"))
(define-protein "S12A3_HUMAN" ("nacl" "Solute carrier family 12 member 3" "Na-Cl cotransporter" "NCC" "Na-Cl symporter" "Thiazide-sensitive sodium-chloride cotransporter"))
(define-protein "S22A2_HUMAN" ("creatinine" "Solute carrier family 22 member 2" "Organic cation transporter 2" "hOCT2"))
(define-protein "S22A6_HUMAN" ("losartan" "Solute carrier family 22 member 6" "Organic anion transporter 1" "hOAT1" "PAH transporter" "hPAHT" "Renal organic anion transporter 1" "hROAT1"))
=======
(define-protein "S10A1_HUMAN" ("Protein S100-A1" "S-100 protein alpha chain" "S-100 protein subunit alpha" "S100 calcium-binding protein A1"))
(define-protein "S10A7_HUMAN" ("Protein S100-A7" "Psoriasin" "S100 calcium-binding protein A7"))
(define-protein "S10A8_HUMAN" ("Protein S100-A8" "Calgranulin-A" "Calprotectin L1L subunit" "Cystic fibrosis antigen" "CFAG" "Leukocyte L1 complex light chain" "Migration inhibitory factor-related protein 8" "MRP-8" "p8" "S100 calcium-binding protein A8" "Urinary stone protein band A"))
(define-protein "S10AB_HUMAN" ("Protein S100-A11" "Calgizzarin" "Metastatic lymph node gene 70 protein" "MLN 70" "Protein S100-C" "S100 calcium-binding protein A11"))
(define-protein "S10AC_HUMAN" ("Protein S100-A12" "CGRP" "Calcium-binding protein in amniotic fluid 1" "CAAF1" "Calgranulin-C" "CAGC" "Extracellular newly identified RAGE-binding protein" "EN-RAGE" "Migration inhibitory factor-related protein 6" "MRP-6" "p6" "Neutrophil S100 protein" "S100 calcium-binding protein A12"))
(define-protein "S12A3_HUMAN" ("Solute carrier family 12 member 3" "Na-Cl cotransporter" "NCC" "Na-Cl symporter" "Thiazide-sensitive sodium-chloride cotransporter"))
(define-protein "S22A2_HUMAN" ("Solute carrier family 22 member 2" "Organic cation transporter 2" "hOCT2"))
(define-protein "S22A6_HUMAN" ("Solute carrier family 22 member 6" "Organic anion transporter 1" "hOAT1" "PAH transporter" "hPAHT" "Renal organic anion transporter 1" "hROAT1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "S2533_HUMAN" ("BMSC-MCP" "SLC25A33" "HuBMSC-MCP")) 
(define-protein "S35G1_HUMAN" ("Solute carrier family 35 member G1" "Partner of STIM1" "Transmembrane protein 20"))
<<<<<<< .mine
(define-protein "S35G1_HUMAN" ("Stim1" "Solute carrier family 35 member G1" "Partner of STIM1" "Transmembrane protein 20"))
(define-protein "S38A1_HUMAN" ("amino-" "Sodium-coupled neutral amino acid transporter 1" "Amino acid transporter A1" "N-system amino acid transporter 2" "Solute carrier family 38 member 1" "System A amino acid transporter 1" "System N amino acid transporter 1"))
=======
<<<<<<< .mine
(define-protein "S35G1_HUMAN" ("Stim1" "Solute carrier family 35 member G1" "Partner of STIM1" "Transmembrane protein 20"))
(define-protein "S38A1_HUMAN" ("amino-" "Sodium-coupled neutral amino acid transporter 1" "Amino acid transporter A1" "N-system amino acid transporter 2" "Solute carrier family 38 member 1" "System A amino acid transporter 1" "System N amino acid transporter 1"))
=======
(define-protein "S38A1_HUMAN" ("Sodium-coupled neutral amino acid transporter 1" "Amino acid transporter A1" "N-system amino acid transporter 2" "Solute carrier family 38 member 1" "System A amino acid transporter 1" "System N amino acid transporter 1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "S61A1_HUMAN" ("SEC61A1" "SEC61A")) 
<<<<<<< .mine
(define-protein "SAA1_HUMAN" ("serum-" "Serum amyloid A-1 protein" "SAA"))
(define-protein "SALL2_HUMAN" ("Sall2" "Sal-like protein 2" "Zinc finger protein 795" "Zinc finger protein SALL2" "Zinc finger protein Spalt-2" "Sal-2" "hSal2"))
=======
<<<<<<< .mine
(define-protein "SAA1_HUMAN" ("serum-" "Serum amyloid A-1 protein" "SAA"))
(define-protein "SALL2_HUMAN" ("Sall2" "Sal-like protein 2" "Zinc finger protein 795" "Zinc finger protein SALL2" "Zinc finger protein Spalt-2" "Sal-2" "hSal2"))
=======
(define-protein "SAA1_HUMAN" ("Serum amyloid A-1 protein" "SAA"))
(define-protein "SALL2_HUMAN" ("Sal-like protein 2" "Zinc finger protein 795" "Zinc finger protein SALL2" "Zinc finger protein Spalt-2" "Sal-2" "hSal2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "SAP30_HUMAN" ("Histone deacetylase complex subunit SAP30" "30 kDa Sin3-associated polypeptide" "Sin3 corepressor complex subunit SAP30" "Sin3-associated polypeptide p30"))
(define-protein "SAP30_HUMAN" ("Sin3" "Histone deacetylase complex subunit SAP30" "30 kDa Sin3-associated polypeptide" "Sin3 corepressor complex subunit SAP30" "Sin3-associated polypeptide p30"))
(define-protein "SAP3_HUMAN" ("SAP-3" "GM2-AP" "GM2A")) 
(define-protein "SAP_HUMAN" ("SAP-2" "SAP-1" "Saposin-B" "PSAP" "Saposin-D" "Saposin-C" "Co-beta-glucosidase" "Saposin-A" "Dispersin" "Saposin-B-Val" "GLBA" "SAP1" "CSAct")) 
(define-protein "SAR1A_HUMAN" ("SARA" "SAR1A" "SAR1" "SARA1")) 
(define-protein "SARNP_HUMAN" ("SARNP" "HCC1")) 
(define-protein "SART3_HUMAN" ("TIP110" "SART3" "KIAA0156" "SART-3" "Tip110")) 
<<<<<<< .mine
(define-protein "SAS10_HUMAN" ("utp" "Something about silencing protein 10" "Charged amino acid-rich leucine zipper 1" "CRL1" "Disrupter of silencing SAS10" "UTP3 homolog"))
(define-protein "SAT1_HUMAN" ("spermine" "Diamine acetyltransferase 1" "Polyamine N-acetyltransferase 1" "Putrescine acetyltransferase" "Spermidine/spermine N(1)-acetyltransferase 1" "SSAT" "SSAT-1"))
=======
<<<<<<< .mine
(define-protein "SAS10_HUMAN" ("utp" "Something about silencing protein 10" "Charged amino acid-rich leucine zipper 1" "CRL1" "Disrupter of silencing SAS10" "UTP3 homolog"))
(define-protein "SAT1_HUMAN" ("spermine" "Diamine acetyltransferase 1" "Polyamine N-acetyltransferase 1" "Putrescine acetyltransferase" "Spermidine/spermine N(1)-acetyltransferase 1" "SSAT" "SSAT-1"))
=======
(define-protein "SAS10_HUMAN" ("Something about silencing protein 10" "Charged amino acid-rich leucine zipper 1" "CRL1" "Disrupter of silencing SAS10" "UTP3 homolog"))
(define-protein "SAT1_HUMAN" ("Diamine acetyltransferase 1" "Polyamine N-acetyltransferase 1" "Putrescine acetyltransferase" "Spermidine/spermine N(1)-acetyltransferase 1" "SSAT" "SSAT-1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "SBP1_HUMAN" ("SBP56" "SBP" "SELENBP1" "SP56")) 
(define-protein "SC22B_HUMAN" ("ERS-24" "SEC22L1" "SEC22B" "ERS24")) 
<<<<<<< .mine
(define-protein "SC23A_HUMAN" ("homologues" "Protein transport protein Sec23A" "SEC23-related protein A"))
(define-protein "SC5A8_HUMAN" ("iodide" "Sodium-coupled monocarboxylate transporter 1" "Apical iodide transporter" "Electrogenic sodium monocarboxylate cotransporter" "Sodium iodide-related cotransporter" "Solute carrier family 5 member 8"))
=======
<<<<<<< .mine
(define-protein "SC23A_HUMAN" ("homologues" "Protein transport protein Sec23A" "SEC23-related protein A"))
(define-protein "SC5A8_HUMAN" ("iodide" "Sodium-coupled monocarboxylate transporter 1" "Apical iodide transporter" "Electrogenic sodium monocarboxylate cotransporter" "Sodium iodide-related cotransporter" "Solute carrier family 5 member 8"))
=======
(define-protein "SC23A_HUMAN" ("Protein transport protein Sec23A" "SEC23-related protein A"))
(define-protein "SC5A8_HUMAN" ("Sodium-coupled monocarboxylate transporter 1" "Apical iodide transporter" "Electrogenic sodium monocarboxylate cotransporter" "Sodium iodide-related cotransporter" "Solute carrier family 5 member 8"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "SC61B_HUMAN" ("SEC61B")) 
(define-protein "SC61G_HUMAN" ("SEC61G")) 
<<<<<<< .mine
(define-protein "SC6A2_HUMAN" ("noradrenaline" "Sodium-dependent noradrenaline transporter" "Norepinephrine transporter" "NET" "Solute carrier family 6 member 2"))
=======
<<<<<<< .mine
(define-protein "SC6A2_HUMAN" ("noradrenaline" "Sodium-dependent noradrenaline transporter" "Norepinephrine transporter" "NET" "Solute carrier family 6 member 2"))
=======
(define-protein "SC6A2_HUMAN" ("Sodium-dependent noradrenaline transporter" "Norepinephrine transporter" "NET" "Solute carrier family 6 member 2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "SCAM1_HUMAN" ("SCAMP" "SCAMP1")) 
(define-protein "SCAM2_HUMAN" ("SCAMP2")) 
(define-protein "SCAM3_HUMAN" ("C1orf3" "SCAMP3" "PROPIN1")) 
(define-protein "SCAM4_HUMAN" ("SCAMP4")) 
(define-protein "SCFD1_HUMAN" ("STXBP1L2" "C14orf163" "KIAA0917" "SCFD1" "Sly1p")) 
(define-protein "SCFD2_HUMAN" ("STXBP1L1" "SCFD2")) 
(define-protein "SCPDL_HUMAN" ("SCCPDH")) 
(define-protein "SCRB1_HUMAN" ("Scavenger receptor class B member 1" "SRB1" "CD36 and LIMPII analogous 1" "CLA-1" "CD36 antigen-like 1" "Collagen type I receptor, thrombospondin receptor-like 1" "SR-BI"))
(define-protein "SCRB2_HUMAN" ("LIMPII" "LIMP2" "LGP85" "CD36L2" "CD36" "SCARB2")) 
<<<<<<< .mine
(define-protein "SCUB1_HUMAN" ("Matrix-bound" "Signal peptide, CUB and EGF-like domain-containing protein 1"))
(define-protein "SDC1_HUMAN" ("syndecan-1" "Syndecan-1" "SYND1"))
=======
<<<<<<< .mine
(define-protein "SCUB1_HUMAN" ("Matrix-bound" "Signal peptide, CUB and EGF-like domain-containing protein 1"))
(define-protein "SDC1_HUMAN" ("syndecan-1" "Syndecan-1" "SYND1"))
=======
(define-protein "SCUB1_HUMAN" ("Signal peptide, CUB and EGF-like domain-containing protein 1"))
(define-protein "SDC1_HUMAN" ("Syndecan-1" "SYND1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "SDC2_HUMAN" ("Syndecan-2" "SYND2" "Fibroglycan" "Heparan sulfate proteoglycan core protein" "HSPG"))
<<<<<<< .mine
(define-protein "SDC2_HUMAN" ("syndecan-2" "Syndecan-2" "SYND2" "Fibroglycan" "Heparan sulfate proteoglycan core protein" "HSPG"))
(define-protein "SDC4_HUMAN" ("syndecan-4" "Syndecan-4" "SYND4" "Amphiglycan" "Ryudocan core protein"))
=======
<<<<<<< .mine
(define-protein "SDC2_HUMAN" ("syndecan-2" "Syndecan-2" "SYND2" "Fibroglycan" "Heparan sulfate proteoglycan core protein" "HSPG"))
(define-protein "SDC4_HUMAN" ("syndecan-4" "Syndecan-4" "SYND4" "Amphiglycan" "Ryudocan core protein"))
=======
(define-protein "SDC4_HUMAN" ("Syndecan-4" "SYND4" "Amphiglycan" "Ryudocan core protein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "SDCB1_HUMAN" ("SYCL" "SDCBP" "MDA9" "TACIP18" "MDA-9")) 
<<<<<<< .mine
(define-protein "SE1L1_HUMAN" ("FN2" "Protein sel-1 homolog 1" "Suppressor of lin-12-like protein 1" "Sel-1L"))
=======
<<<<<<< .mine
(define-protein "SE1L1_HUMAN" ("FN2" "Protein sel-1 homolog 1" "Suppressor of lin-12-like protein 1" "Sel-1L"))
=======
(define-protein "SE1L1_HUMAN" ("Protein sel-1 homolog 1" "Suppressor of lin-12-like protein 1" "Sel-1L"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "SEC20_HUMAN" ("NIP1" "TRG-8" "BNIP1" "SEC20L")) 
<<<<<<< .mine
(define-protein "SELPL_HUMAN" ("selectins" "P-selectin glycoprotein ligand 1" "PSGL-1" "Selectin P ligand"))
(define-protein "SEM7A_HUMAN" ("α1β1" "Semaphorin-7A" "CDw108" "JMH blood group antigen" "John-Milton-Hargen human blood group Ag" "Semaphorin-K1" "Sema K1" "Semaphorin-L" "Sema L"))
(define-protein "SEMG1_HUMAN" ("inhibins" "Semenogelin-1" "Cancer/testis antigen 103" "Semenogelin I" "SGI"))
=======
<<<<<<< .mine
(define-protein "SELPL_HUMAN" ("selectins" "P-selectin glycoprotein ligand 1" "PSGL-1" "Selectin P ligand"))
(define-protein "SEM7A_HUMAN" ("α1β1" "Semaphorin-7A" "CDw108" "JMH blood group antigen" "John-Milton-Hargen human blood group Ag" "Semaphorin-K1" "Sema K1" "Semaphorin-L" "Sema L"))
(define-protein "SEMG1_HUMAN" ("inhibins" "Semenogelin-1" "Cancer/testis antigen 103" "Semenogelin I" "SGI"))
=======
(define-protein "SELPL_HUMAN" ("P-selectin glycoprotein ligand 1" "PSGL-1" "Selectin P ligand"))
(define-protein "SEM7A_HUMAN" ("Semaphorin-7A" "CDw108" "JMH blood group antigen" "John-Milton-Hargen human blood group Ag" "Semaphorin-K1" "Sema K1" "Semaphorin-L" "Sema L"))
(define-protein "SEMG1_HUMAN" ("Semenogelin-1" "Cancer/testis antigen 103" "Semenogelin I" "SGI"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "SEP10_HUMAN" ("SEPT10")) 
(define-protein "SEP11_HUMAN" ("SEPT11")) 
(define-protein "SEP14_HUMAN" ("SEPT14")) 
<<<<<<< .mine
(define-protein "SEPP1_HUMAN" ("wang" "Selenoprotein P" "SeP"))
=======
<<<<<<< .mine
(define-protein "SEPP1_HUMAN" ("wang" "Selenoprotein P" "SeP"))
=======
(define-protein "SEPP1_HUMAN" ("Selenoprotein P" "SeP"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "SEPT2_HUMAN" ("NEDD5" "NEDD-5" "KIAA0158" "DIFF6" "SEPT2")) 
(define-protein "SEPT7_HUMAN" ("SEPT7" "CDC10")) 
(define-protein "SEPT8_HUMAN" ("SEPT8" "KIAA0202")) 
(define-protein "SEPT9_HUMAN" ("KIAA0991" "SEPT9" "MSF")) 
(define-protein "SERA_HUMAN" ("PGDH3" "3-PGDH" "PHGDH")) 
<<<<<<< .mine
(define-protein "SERPH_HUMAN" ("raa" "Serpin H1" "47 kDa heat shock protein" "Arsenic-transactivated protein 3" "AsTP3" "Cell proliferation-inducing gene 14 protein" "Collagen-binding protein" "Colligin" "Rheumatoid arthritis-related antigen RA-A47"))
(define-protein "SETBP_HUMAN" ("higher" "SET-binding protein" "SEB"))
(define-protein "SETD2_HUMAN" ("Hif1" "Histone-lysine N-methyltransferase SETD2" "HIF-1" "Huntingtin yeast partner B" "Huntingtin-interacting protein 1" "HIP-1" "Huntingtin-interacting protein B" "Lysine N-methyltransferase 3A" "SET domain-containing protein 2" "hSET2" "p231HBP"))
=======
<<<<<<< .mine
(define-protein "SERPH_HUMAN" ("raa" "Serpin H1" "47 kDa heat shock protein" "Arsenic-transactivated protein 3" "AsTP3" "Cell proliferation-inducing gene 14 protein" "Collagen-binding protein" "Colligin" "Rheumatoid arthritis-related antigen RA-A47"))
(define-protein "SETBP_HUMAN" ("higher" "SET-binding protein" "SEB"))
(define-protein "SETD2_HUMAN" ("Hif1" "Histone-lysine N-methyltransferase SETD2" "HIF-1" "Huntingtin yeast partner B" "Huntingtin-interacting protein 1" "HIP-1" "Huntingtin-interacting protein B" "Lysine N-methyltransferase 3A" "SET domain-containing protein 2" "hSET2" "p231HBP"))
=======
(define-protein "SERPH_HUMAN" ("Serpin H1" "47 kDa heat shock protein" "Arsenic-transactivated protein 3" "AsTP3" "Cell proliferation-inducing gene 14 protein" "Collagen-binding protein" "Colligin" "Rheumatoid arthritis-related antigen RA-A47"))
(define-protein "SETBP_HUMAN" ("SET-binding protein" "SEB"))
(define-protein "SETD2_HUMAN" ("Histone-lysine N-methyltransferase SETD2" "HIF-1" "Huntingtin yeast partner B" "Huntingtin-interacting protein 1" "HIP-1" "Huntingtin-interacting protein B" "Lysine N-methyltransferase 3A" "SET domain-containing protein 2" "hSET2" "p231HBP"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "SETD6_HUMAN" ("N-lysine methyltransferase SETD6" "SET domain-containing protein 6"))
<<<<<<< .mine
(define-protein "SETD7_HUMAN" ("Set7" "Histone-lysine N-methyltransferase SETD7" "Histone H3-K4 methyltransferase SETD7" "H3-K4-HMTase SETD7" "Lysine N-methyltransferase 7" "SET domain-containing protein 7" "SET7/9"))
(define-protein "SETD8_HUMAN" ("H4K20me1" "N-lysine methyltransferase SETD8" "H4-K20-HMTase SETD8" "Histone-lysine N-methyltransferase SETD8" "Lysine N-methyltransferase 5A" "PR/SET domain-containing protein 07" "PR-Set7" "PR/SET07" "SET domain-containing protein 8"))
=======
<<<<<<< .mine
(define-protein "SETD7_HUMAN" ("Set7" "Histone-lysine N-methyltransferase SETD7" "Histone H3-K4 methyltransferase SETD7" "H3-K4-HMTase SETD7" "Lysine N-methyltransferase 7" "SET domain-containing protein 7" "SET7/9"))
(define-protein "SETD8_HUMAN" ("H4K20me1" "N-lysine methyltransferase SETD8" "H4-K20-HMTase SETD8" "Histone-lysine N-methyltransferase SETD8" "Lysine N-methyltransferase 5A" "PR/SET domain-containing protein 07" "PR-Set7" "PR/SET07" "SET domain-containing protein 8"))
=======
(define-protein "SETD7_HUMAN" ("Histone-lysine N-methyltransferase SETD7" "Histone H3-K4 methyltransferase SETD7" "H3-K4-HMTase SETD7" "Lysine N-methyltransferase 7" "SET domain-containing protein 7" "SET7/9"))
(define-protein "SETD8_HUMAN" ("N-lysine methyltransferase SETD8" "H4-K20-HMTase SETD8" "Histone-lysine N-methyltransferase SETD8" "Lysine N-methyltransferase 5A" "PR/SET domain-containing protein 07" "PR-Set7" "PR/SET07" "SET domain-containing protein 8"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "SF3B6_HUMAN" ("Splicing factor 3B subunit 6" "Pre-mRNA branch site protein p14" "SF3b 14 kDa subunit" "SF3B14a" "Spliceosome-associated protein, 14-kDa" "Splicing factor 3b, subunit 6, 14kDa"))
(define-protein "SFRP3_HUMAN" ("Secreted frizzled-related protein 3" "sFRP-3" "Frezzled" "Fritz" "Frizzled-related protein 1" "FrzB-1"))
(define-protein "SFRP3_HUMAN" ("wnts" "Secreted frizzled-related protein 3" "sFRP-3" "Frezzled" "Fritz" "Frizzled-related protein 1" "FrzB-1"))
(define-protein "SFT2B_HUMAN" ("SFT2D2")) 
(define-protein "SFT2C_HUMAN" ("SFT2D3")) 
(define-protein "SFXN1_HUMAN" ("TCC" "SFXN1")) 
<<<<<<< .mine
(define-protein "SGCE_HUMAN" ("undergoes" "Epsilon-sarcoglycan" "Epsilon-SG"))
=======
<<<<<<< .mine
(define-protein "SGCE_HUMAN" ("undergoes" "Epsilon-sarcoglycan" "Epsilon-SG"))
=======
(define-protein "SGCE_HUMAN" ("Epsilon-sarcoglycan" "Epsilon-SG"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "SGK3_HUMAN" ("CISK" "SGKL" "SGK3")) 
(define-protein "SGMR1_HUMAN" ("SR-BP" "OPRS1" "hSigmaR1" "Sigma1-receptor" "SIG-1R" "SIGMAR1" "SRBP" "Sigma1R")) 
<<<<<<< .mine
(define-protein "SGOL2_HUMAN" ("shugoshin" "Shugoshin-like 2" "Shugoshin-2" "Sgo2" "Tripin"))
=======
<<<<<<< .mine
(define-protein "SGOL2_HUMAN" ("shugoshin" "Shugoshin-like 2" "Shugoshin-2" "Sgo2" "Tripin"))
=======
(define-protein "SGOL2_HUMAN" ("Shugoshin-like 2" "Shugoshin-2" "Sgo2" "Tripin"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "SGPL1_HUMAN" ("SGPL1" "KIAA1252" "hSPL" "S1PL")) 
(define-protein "SH21B_HUMAN" ("SH2 domain-containing protein 1B" "EWS/FLI1-activated transcript 2" "EAT-2"))
(define-protein "SH23A_HUMAN" ("SH2D3A" "NSP1")) 
<<<<<<< .mine
(define-protein "SH2D3_HUMAN" ("SHEP-1" "SH2 domain-containing protein 3C" "Novel SH2-containing protein 3" "SH2 domain-containing Eph receptor-binding protein 1" "SHEP1"))
=======
<<<<<<< .mine
(define-protein "SH2D3_HUMAN" ("SHEP-1" "SH2 domain-containing protein 3C" "Novel SH2-containing protein 3" "SH2 domain-containing Eph receptor-binding protein 1" "SHEP1"))
=======
(define-protein "SH2D3_HUMAN" ("SH2 domain-containing protein 3C" "Novel SH2-containing protein 3" "SH2 domain-containing Eph receptor-binding protein 1" "SHEP1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "SH3G2_HUMAN" ("CNSA2" "Endophilin-1" "EEN-B1" "SH3D2A" "SH3GL2")) 
(define-protein "SH3K1_HUMAN" ("CIN85" "SH3KBP1" "HSB-1" "CD2BP3")) 
(define-protein "SHB_HUMAN" ("SHB")) 
(define-protein "SHD_HUMAN" ("SHD")) 
(define-protein "SHLB1_HUMAN" ("KIAA0491" "Bif-1" "SH3GLB1")) 
(define-protein "SHLB2_HUMAN" ("KIAA1848" "SH3GLB2")) 
(define-protein "SHOC2_HUMAN" ("SHOC2" "KIAA0862")) 
<<<<<<< .mine
(define-protein "SHOX2_HUMAN" ("2-OG" "Short stature homeobox protein 2" "Homeobox protein Og12X" "Paired-related homeobox protein SHOT"))
(define-protein "SIGL7_HUMAN" ("GT1b" "Sialic acid-binding Ig-like lectin 7" "Siglec-7" "Adhesion inhibitory receptor molecule 1" "AIRM-1" "CDw328" "D-siglec" "QA79 membrane protein" "p75"))
(define-protein "SIN1_HUMAN" ("sin1" "Target of rapamycin complex 2 subunit MAPKAP1" "TORC2 subunit MAPKAP1" "Mitogen-activated protein kinase 2-associated protein 1" "Stress-activated map kinase-interacting protein 1" "SAPK-interacting protein 1" "mSIN1"))
(define-protein "SIN3A_HUMAN" ("Sin3A" "Paired amphipathic helix protein Sin3a" "Histone deacetylase complex subunit Sin3a" "Transcriptional corepressor Sin3a"))
=======
<<<<<<< .mine
(define-protein "SHOX2_HUMAN" ("2-OG" "Short stature homeobox protein 2" "Homeobox protein Og12X" "Paired-related homeobox protein SHOT"))
(define-protein "SIGL7_HUMAN" ("GT1b" "Sialic acid-binding Ig-like lectin 7" "Siglec-7" "Adhesion inhibitory receptor molecule 1" "AIRM-1" "CDw328" "D-siglec" "QA79 membrane protein" "p75"))
(define-protein "SIN1_HUMAN" ("sin1" "Target of rapamycin complex 2 subunit MAPKAP1" "TORC2 subunit MAPKAP1" "Mitogen-activated protein kinase 2-associated protein 1" "Stress-activated map kinase-interacting protein 1" "SAPK-interacting protein 1" "mSIN1"))
(define-protein "SIN3A_HUMAN" ("Sin3A" "Paired amphipathic helix protein Sin3a" "Histone deacetylase complex subunit Sin3a" "Transcriptional corepressor Sin3a"))
=======
(define-protein "SHOX2_HUMAN" ("Short stature homeobox protein 2" "Homeobox protein Og12X" "Paired-related homeobox protein SHOT"))
(define-protein "SIGL7_HUMAN" ("Sialic acid-binding Ig-like lectin 7" "Siglec-7" "Adhesion inhibitory receptor molecule 1" "AIRM-1" "CDw328" "D-siglec" "QA79 membrane protein" "p75"))
(define-protein "SIN1_HUMAN" ("Target of rapamycin complex 2 subunit MAPKAP1" "TORC2 subunit MAPKAP1" "Mitogen-activated protein kinase 2-associated protein 1" "Stress-activated map kinase-interacting protein 1" "SAPK-interacting protein 1" "mSIN1"))
(define-protein "SIN3A_HUMAN" ("Paired amphipathic helix protein Sin3a" "Histone deacetylase complex subunit Sin3a" "Transcriptional corepressor Sin3a"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "SIR1_HUMAN" ("NAD-dependent protein deacetylase sirtuin-1" "hSIRT1" "Regulatory protein SIR2 homolog 1" "SIR2-like protein 1" "hSIR2"))
(define-protein "SIR1_HUMAN" ("SIRT1" "SIR2L1")) 
<<<<<<< .mine
(define-protein "SIR3_HUMAN" ("sir-2" "NAD-dependent protein deacetylase sirtuin-3, mitochondrial" "hSIRT3" "Regulatory protein SIR2 homolog 3" "SIR2-like protein 3"))
(define-protein "SIVA_HUMAN" ("Abl2/Arg" "Apoptosis regulatory protein Siva" "CD27-binding protein" "CD27BP"))
(define-protein "SKA1_HUMAN" ("ska" "Spindle and kinetochore-associated protein 1"))
=======
<<<<<<< .mine
(define-protein "SIR3_HUMAN" ("sir-2" "NAD-dependent protein deacetylase sirtuin-3, mitochondrial" "hSIRT3" "Regulatory protein SIR2 homolog 3" "SIR2-like protein 3"))
(define-protein "SIVA_HUMAN" ("Abl2/Arg" "Apoptosis regulatory protein Siva" "CD27-binding protein" "CD27BP"))
(define-protein "SKA1_HUMAN" ("ska" "Spindle and kinetochore-associated protein 1"))
=======
(define-protein "SIR3_HUMAN" ("NAD-dependent protein deacetylase sirtuin-3, mitochondrial" "hSIRT3" "Regulatory protein SIR2 homolog 3" "SIR2-like protein 3"))
(define-protein "SIVA_HUMAN" ("Apoptosis regulatory protein Siva" "CD27-binding protein" "CD27BP"))
(define-protein "SKA1_HUMAN" ("Spindle and kinetochore-associated protein 1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "SKP1_HUMAN" ("SIII" "OCP-II" "OCP-2" "TCEB1L" "p19A" "EMC19" "SKP1" "OCP2" "p19skp1" "SKP1A")) 
(define-protein "SL9A1_HUMAN" ("Sodium/hydrogen exchanger 1" "APNH" "Na(+)/H(+) antiporter, amiloride-sensitive" "Na(+)/H(+) exchanger 1" "NHE-1" "Solute carrier family 9 member 1"))
<<<<<<< .mine
(define-protein "SLAF7_HUMAN" ("subset" "SLAM family member 7" "CD2 subset 1" "CD2-like receptor-activating cytotoxic cells" "CRACC" "Membrane protein FOAP-12" "Novel Ly9" "Protein 19A"))
=======
<<<<<<< .mine
(define-protein "SLAF7_HUMAN" ("subset" "SLAM family member 7" "CD2 subset 1" "CD2-like receptor-activating cytotoxic cells" "CRACC" "Membrane protein FOAP-12" "Novel Ly9" "Protein 19A"))
=======
(define-protein "SLAF7_HUMAN" ("SLAM family member 7" "CD2 subset 1" "CD2-like receptor-activating cytotoxic cells" "CRACC" "Membrane protein FOAP-12" "Novel Ly9" "Protein 19A"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "SLAI2_HUMAN" ("SLAIN2" "KIAA1458")) 
<<<<<<< .mine
(define-protein "SLAP1_HUMAN" ("Src-like" "Src-like-adapter" "Src-like-adapter protein 1" "SLAP-1" "hSLAP"))
(define-protein "SMAD1_HUMAN" ("bsp" "Mothers against decapentaplegic homolog 1" "MAD homolog 1" "Mothers against DPP homolog 1" "JV4-1" "Mad-related protein 1" "SMAD family member 1" "SMAD 1" "Smad1" "hSMAD1" "Transforming growth factor-beta-signaling protein 1" "BSP-1"))
=======
<<<<<<< .mine
(define-protein "SLAP1_HUMAN" ("Src-like" "Src-like-adapter" "Src-like-adapter protein 1" "SLAP-1" "hSLAP"))
(define-protein "SMAD1_HUMAN" ("bsp" "Mothers against decapentaplegic homolog 1" "MAD homolog 1" "Mothers against DPP homolog 1" "JV4-1" "Mad-related protein 1" "SMAD family member 1" "SMAD 1" "Smad1" "hSMAD1" "Transforming growth factor-beta-signaling protein 1" "BSP-1"))
=======
(define-protein "SLAP1_HUMAN" ("Src-like-adapter" "Src-like-adapter protein 1" "SLAP-1" "hSLAP"))
(define-protein "SMAD1_HUMAN" ("Mothers against decapentaplegic homolog 1" "MAD homolog 1" "Mothers against DPP homolog 1" "JV4-1" "Mad-related protein 1" "SMAD family member 1" "SMAD 1" "Smad1" "hSMAD1" "Transforming growth factor-beta-signaling protein 1" "BSP-1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "SMAD2_HUMAN" ("Smad2" "MADH2" "hSMAD2" "JV18-1" "SMAD2" "hMAD-2" "MADR2")) 
(define-protein "SMAD4_HUMAN" ("Smad4" "DPC4" "MADH4" "hSMAD4" "SMAD4")) 
<<<<<<< .mine
(define-protein "SMAD7_HUMAN" ("homologue" "Mothers against decapentaplegic homolog 7" "MAD homolog 7" "Mothers against DPP homolog 7" "Mothers against decapentaplegic homolog 8" "MAD homolog 8" "Mothers against DPP homolog 8" "SMAD family member 7" "SMAD 7" "Smad7" "hSMAD7"))
=======
<<<<<<< .mine
(define-protein "SMAD7_HUMAN" ("homologue" "Mothers against decapentaplegic homolog 7" "MAD homolog 7" "Mothers against DPP homolog 7" "Mothers against decapentaplegic homolog 8" "MAD homolog 8" "Mothers against DPP homolog 8" "SMAD family member 7" "SMAD 7" "Smad7" "hSMAD7"))
=======
(define-protein "SMAD7_HUMAN" ("Mothers against decapentaplegic homolog 7" "MAD homolog 7" "Mothers against DPP homolog 7" "Mothers against decapentaplegic homolog 8" "MAD homolog 8" "Mothers against DPP homolog 8" "SMAD family member 7" "SMAD 7" "Smad7" "hSMAD7"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "SMC1A_HUMAN" ("SMC1A" "SMC1" "Sb1.8" "SMC1L1" "SB1.8" "SMC-1-alpha" "SMC-1A" "DXS423E" "KIAA0178")) 
(define-protein "SMC2_HUMAN" ("SMC-2" "hCAP-E" "SMC2" "SMC2L1" "CAPE")) 
(define-protein "SMC3_HUMAN" ("BMH" "Bamacan" "CSPG6" "SMC3L1" "SMC3" "SMC-3" "hCAP" "BAM")) 
(define-protein "SMC4_HUMAN" ("SMC4L1" "SMC-4" "SMC4" "CAPC" "hCAP-C")) 
<<<<<<< .mine
(define-protein "SMUF1_HUMAN" ("Smurf1" "E3 ubiquitin-protein ligase SMURF1" "hSMURF1" "SMAD ubiquitination regulatory factor 1" "SMAD-specific E3 ubiquitin-protein ligase 1"))
=======
<<<<<<< .mine
(define-protein "SMUF1_HUMAN" ("Smurf1" "E3 ubiquitin-protein ligase SMURF1" "hSMURF1" "SMAD ubiquitination regulatory factor 1" "SMAD-specific E3 ubiquitin-protein ligase 1"))
=======
(define-protein "SMUF1_HUMAN" ("E3 ubiquitin-protein ligase SMURF1" "hSMURF1" "SMAD ubiquitination regulatory factor 1" "SMAD-specific E3 ubiquitin-protein ligase 1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "SMUF2_HUMAN" ("hSMURF2" "SMURF2" "Smurf2" )) 
(define-protein "SMYD3_HUMAN" ("Histone-lysine N-methyltransferase SMYD3" "SET and MYND domain-containing protein 3" "Zinc finger MYND domain-containing protein 1"))
(define-protein "SNAA_HUMAN" ("NAPA" "SNAP-alpha" "SNAPA")) 
(define-protein "SNAG_HUMAN" ("SNAPG" "SNAP-gamma" "NAPG")) 
(define-protein "SNAI1_HUMAN" ("Zinc finger protein SNAI1" "Protein snail homolog 1" "Protein sna"))
(define-protein "SNAPN_HUMAN" ("SNAPAP" "BLOC1S7" "SNAP25BP" "SNAPIN")) 
(define-protein "SNCAP_HUMAN" ("Synphilin-1" "Sph1" "Alpha-synuclein-interacting protein"))
(define-protein "SNCAP_HUMAN" ("synphilin-1" "Synphilin-1" "Sph1" "Alpha-synuclein-interacting protein"))
(define-protein "SNF8_HUMAN" ("SNF8" "EAP30" "hVps22")) 
(define-protein "SNG2_HUMAN" ("SYNGR2" "Cellugyrin")) 
(define-protein "SNIP1_HUMAN" ("Smad nuclear-interacting protein 1" "FHA domain-containing protein SNIP1"))
(define-protein "SNP23_HUMAN" ("SNAP23" "SNAP-23")) 
(define-protein "SNP25_HUMAN" ("Synaptosomal-associated protein 25" "SNAP-25" "Super protein" "SUP" "Synaptosomal-associated 25 kDa protein"))
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
<<<<<<< .mine
(define-protein "SO1B1_HUMAN" ("solute" "Solute carrier organic anion transporter family member 1B1" "Liver-specific organic anion transporter 1" "LST-1" "OATP-C" "Sodium-independent organic anion-transporting polypeptide 2" "OATP-2" "Solute carrier family 21 member 6"))
=======
<<<<<<< .mine
(define-protein "SO1B1_HUMAN" ("solute" "Solute carrier organic anion transporter family member 1B1" "Liver-specific organic anion transporter 1" "LST-1" "OATP-C" "Sodium-independent organic anion-transporting polypeptide 2" "OATP-2" "Solute carrier family 21 member 6"))
=======
(define-protein "SO1B1_HUMAN" ("Solute carrier organic anion transporter family member 1B1" "Liver-specific organic anion transporter 1" "LST-1" "OATP-C" "Sodium-independent organic anion-transporting polypeptide 2" "OATP-2" "Solute carrier family 21 member 6"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "SO1B3_HUMAN" ("SLCO1B3" "OATP-8" "SLC21A8" "LST2" "OATP1B3" "OATP8" "LST-2")) 
(define-protein "SODC_HUMAN" ("Superoxide dismutase [Cu-Zn]" "Superoxide dismutase 1" "hSod1"))
<<<<<<< .mine
(define-protein "SODC_HUMAN" ("cuznsod" "Superoxide dismutase [Cu-Zn]" "Superoxide dismutase 1" "hSod1"))
(define-protein "SODE_HUMAN" ("cu" "Extracellular superoxide dismutase [Cu-Zn]" "EC-SOD"))
=======
<<<<<<< .mine
(define-protein "SODC_HUMAN" ("cuznsod" "Superoxide dismutase [Cu-Zn]" "Superoxide dismutase 1" "hSod1"))
(define-protein "SODE_HUMAN" ("cu" "Extracellular superoxide dismutase [Cu-Zn]" "EC-SOD"))
=======
(define-protein "SODE_HUMAN" ("Extracellular superoxide dismutase [Cu-Zn]" "EC-SOD"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "SORCN_HUMAN" ("V19" "SRI" "CP-22" "CP22")) 
<<<<<<< .mine
(define-protein "SORL_HUMAN" ("ldlr" "Sortilin-related receptor" "Low-density lipoprotein receptor relative with 11 ligand-binding repeats" "LDLR relative with 11 ligand-binding repeats" "LR11" "SorLA-1" "Sorting protein-related receptor containing LDLR class A repeats" "SorLA"))
(define-protein "SOX2_HUMAN" ("Sox2" "Transcription factor SOX-2"))
=======
<<<<<<< .mine
(define-protein "SORL_HUMAN" ("ldlr" "Sortilin-related receptor" "Low-density lipoprotein receptor relative with 11 ligand-binding repeats" "LDLR relative with 11 ligand-binding repeats" "LR11" "SorLA-1" "Sorting protein-related receptor containing LDLR class A repeats" "SorLA"))
(define-protein "SOX2_HUMAN" ("Sox2" "Transcription factor SOX-2"))
=======
(define-protein "SORL_HUMAN" ("Sortilin-related receptor" "Low-density lipoprotein receptor relative with 11 ligand-binding repeats" "LDLR relative with 11 ligand-binding repeats" "LR11" "SorLA-1" "Sorting protein-related receptor containing LDLR class A repeats" "SorLA"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "SOX2_HUMAN" ("Transcription factor SOX-2"))
(define-protein "SOX9_HUMAN" ("Transcription factor SOX-9"))
(define-protein "SP16H_HUMAN" ("FACTp140" "FACTP140" "FACT140" "hSPT16" "SUPT16H")) 
(define-protein "SP1_HUMAN" ("Transcription factor Sp1" "SP1"))
<<<<<<< .mine
(define-protein "SP2_HUMAN" ("Sp2" "Transcription factor Sp2"))
(define-protein "SP3_HUMAN" ("Sp3" "Transcription factor Sp3" "SPR-2"))
=======
<<<<<<< .mine
(define-protein "SP2_HUMAN" ("Sp2" "Transcription factor Sp2"))
(define-protein "SP3_HUMAN" ("Sp3" "Transcription factor Sp3" "SPR-2"))
=======
(define-protein "SP2_HUMAN" ("Transcription factor Sp2"))
(define-protein "SP3_HUMAN" ("Transcription factor Sp3" "SPR-2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "SPAS2_HUMAN" ("SCR59" "p59scr" "SPATS2" "SPATA10")) 
<<<<<<< .mine
(define-protein "SPB8_HUMAN" ("pI8" "Serpin B8" "Cytoplasmic antiproteinase 2" "CAP-2" "CAP2" "Peptidase inhibitor 8" "PI-8"))
=======
<<<<<<< .mine
(define-protein "SPB8_HUMAN" ("pI8" "Serpin B8" "Cytoplasmic antiproteinase 2" "CAP-2" "CAP2" "Peptidase inhibitor 8" "PI-8"))
=======
(define-protein "SPB8_HUMAN" ("Serpin B8" "Cytoplasmic antiproteinase 2" "CAP-2" "CAP2" "Peptidase inhibitor 8" "PI-8"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "SPC24_HUMAN" ("SPBC24" "hSpc24" "SPC24")) 
(define-protein "SPC25_HUMAN" ("SPBC25" "hSpc25" "SPC25")) 
(define-protein "SPD2A_HUMAN" ("SH3 and PX domain-containing protein 2A" "Adapter protein TKS5" "Five SH3 domain-containing protein" "SH3 multiple domains protein 1" "Tyrosine kinase substrate with five SH3 domains"))
(define-protein "SPD2A_HUMAN" ("tks" "SH3 and PX domain-containing protein 2A" "Adapter protein TKS5" "Five SH3 domain-containing protein" "SH3 multiple domains protein 1" "Tyrosine kinase substrate with five SH3 domains"))
(define-protein "SPD2B_HUMAN" ("SH3 and PX domain-containing protein 2B" "Adapter protein HOFI" "Factor for adipocyte differentiation 49" "Tyrosine kinase substrate with four SH3 domains"))
(define-protein "SPD2B_HUMAN" ("Tks4" "SH3 and PX domain-containing protein 2B" "Adapter protein HOFI" "Factor for adipocyte differentiation 49" "Tyrosine kinase substrate with four SH3 domains"))
(define-protein "SPE39_HUMAN" ("VIPAR" "hSPE-39" "C14orf133" "SPE39" "VIPAS39")) 
(define-protein "SPF45_HUMAN" ("Splicing factor 45" "45 kDa-splicing factor" "RNA-binding motif protein 17"))
(define-protein "SPI1_HUMAN" ("SPI-1" "Transcription factor PU.1" "31 kDa-transforming protein"))
(define-protein "SPI1_HUMAN" ("Transcription factor PU.1" "31 kDa-transforming protein"))
<<<<<<< .mine
(define-protein "SPN1_HUMAN" ("snurportin-1" "Snurportin-1" "RNA U transporter 1"))
(define-protein "SPON2_HUMAN" ("mindin" "Spondin-2" "Differentially expressed in cancerous and non-cancerous lung cells 1" "DIL-1" "Mindin"))
(define-protein "SPRC_HUMAN" ("sparc" "SPARC" "Basement-membrane protein 40" "BM-40" "Osteonectin" "ON" "Secreted protein acidic and rich in cysteine"))
=======
<<<<<<< .mine
(define-protein "SPN1_HUMAN" ("snurportin-1" "Snurportin-1" "RNA U transporter 1"))
(define-protein "SPON2_HUMAN" ("mindin" "Spondin-2" "Differentially expressed in cancerous and non-cancerous lung cells 1" "DIL-1" "Mindin"))
(define-protein "SPRC_HUMAN" ("sparc" "SPARC" "Basement-membrane protein 40" "BM-40" "Osteonectin" "ON" "Secreted protein acidic and rich in cysteine"))
=======
(define-protein "SPN1_HUMAN" ("Snurportin-1" "RNA U transporter 1"))
(define-protein "SPON2_HUMAN" ("Spondin-2" "Differentially expressed in cancerous and non-cancerous lung cells 1" "DIL-1" "Mindin"))
(define-protein "SPRC_HUMAN" ("SPARC" "Basement-membrane protein 40" "BM-40" "Osteonectin" "ON" "Secreted protein acidic and rich in cysteine"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "SPRR4_HUMAN" ("SPRR4")) 
(define-protein "SPXN1_HUMAN" ("Sperm protein associated with the nucleus on the X chromosome N1" "Nuclear-associated protein SPAN-Xn1" "SPANX-N1" "SPANX family member N1"))
(define-protein "SPXN4_HUMAN" ("SPANX-N4" "SPANXN4")) 
(define-protein "SPY2_HUMAN" ("Spry-2" "SPRY2")) 
<<<<<<< .mine
(define-protein "SPYA_HUMAN" ("agt" "Serine--pyruvate aminotransferase" "SPT" "Alanine--glyoxylate aminotransferase" "AGT"))
=======
<<<<<<< .mine
(define-protein "SPYA_HUMAN" ("agt" "Serine--pyruvate aminotransferase" "SPT" "Alanine--glyoxylate aminotransferase" "AGT"))
=======
(define-protein "SPYA_HUMAN" ("Serine--pyruvate aminotransferase" "SPT" "Alanine--glyoxylate aminotransferase" "AGT"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "SQRD_HUMAN" ("SQRDL" "SQOR")) 
<<<<<<< .mine
(define-protein "SQSTM_HUMAN" ("p62/ZIP" "Sequestosome-1" "EBI3-associated protein of 60 kDa" "EBIAP" "p60" "Phosphotyrosine-independent ligand for the Lck SH2 domain of 62 kDa" "Ubiquitin-binding protein p62"))
(define-protein "SRBP1_HUMAN" ("SREBP-1c" "Sterol regulatory element-binding protein 1" "SREBP-1" "Class D basic helix-loop-helix protein 1" "bHLHd1" "Sterol regulatory element-binding transcription factor 1"))
(define-protein "SRBP2_HUMAN" ("SRBP-2" "Sterol regulatory element-binding protein 2" "SREBP-2" "Class D basic helix-loop-helix protein 2" "bHLHd2" "Sterol regulatory element-binding transcription factor 2"))
(define-protein "SRBS2_HUMAN" ("Abl/Arg" "Sorbin and SH3 domain-containing protein 2" "Arg/Abl-interacting protein 2" "ArgBP2" "Sorbin"))
=======
<<<<<<< .mine
(define-protein "SQSTM_HUMAN" ("p62/ZIP" "Sequestosome-1" "EBI3-associated protein of 60 kDa" "EBIAP" "p60" "Phosphotyrosine-independent ligand for the Lck SH2 domain of 62 kDa" "Ubiquitin-binding protein p62"))
(define-protein "SRBP1_HUMAN" ("SREBP-1c" "Sterol regulatory element-binding protein 1" "SREBP-1" "Class D basic helix-loop-helix protein 1" "bHLHd1" "Sterol regulatory element-binding transcription factor 1"))
(define-protein "SRBP2_HUMAN" ("SRBP-2" "Sterol regulatory element-binding protein 2" "SREBP-2" "Class D basic helix-loop-helix protein 2" "bHLHd2" "Sterol regulatory element-binding transcription factor 2"))
(define-protein "SRBS2_HUMAN" ("Abl/Arg" "Sorbin and SH3 domain-containing protein 2" "Arg/Abl-interacting protein 2" "ArgBP2" "Sorbin"))
=======
(define-protein "SQSTM_HUMAN" ("Sequestosome-1" "EBI3-associated protein of 60 kDa" "EBIAP" "p60" "Phosphotyrosine-independent ligand for the Lck SH2 domain of 62 kDa" "Ubiquitin-binding protein p62"))
(define-protein "SRBP1_HUMAN" ("Sterol regulatory element-binding protein 1" "SREBP-1" "Class D basic helix-loop-helix protein 1" "bHLHd1" "Sterol regulatory element-binding transcription factor 1"))
(define-protein "SRBP2_HUMAN" ("Sterol regulatory element-binding protein 2" "SREBP-2" "Class D basic helix-loop-helix protein 2" "bHLHd2" "Sterol regulatory element-binding transcription factor 2"))
(define-protein "SRBS2_HUMAN" ("Sorbin and SH3 domain-containing protein 2" "Arg/Abl-interacting protein 2" "ArgBP2" "Sorbin"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "SRC8_HUMAN" ("CTTN" "EMS1" "Amplaxin")) 
<<<<<<< .mine
(define-protein "SRC_HUMAN" ("src-" "Proto-oncogene tyrosine-protein kinase Src" "Proto-oncogene c-Src" "pp60c-src" "p60-Src"))
=======
<<<<<<< .mine
(define-protein "SRC_HUMAN" ("src-" "Proto-oncogene tyrosine-protein kinase Src" "Proto-oncogene c-Src" "pp60c-src" "p60-Src"))
=======
(define-protein "SRC_HUMAN" ("Proto-oncogene tyrosine-protein kinase Src" "Proto-oncogene c-Src" "pp60c-src" "p60-Src"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "SRP09_HUMAN" ("SRP9")) 
(define-protein "SRP14_HUMAN" ("SRP14")) 
(define-protein "SRP19_HUMAN" ("SRP19")) 
(define-protein "SRP54_HUMAN" ("SRP54")) 
(define-protein "SRP72_HUMAN" ("SRP72")) 
(define-protein "SRPK1_HUMAN" ("SRPK1")) 
<<<<<<< .mine
(define-protein "SRRT_HUMAN" ("serrate" "Serrate RNA effector molecule homolog" "Arsenite-resistance protein 2"))
(define-protein "SRSF1_HUMAN" ("ASF1" "Serine/arginine-rich splicing factor 1" "Alternative-splicing factor 1" "ASF-1" "Splicing factor, arginine/serine-rich 1" "pre-mRNA-splicing factor SF2, P33 subunit"))
=======
<<<<<<< .mine
(define-protein "SRRT_HUMAN" ("serrate" "Serrate RNA effector molecule homolog" "Arsenite-resistance protein 2"))
(define-protein "SRSF1_HUMAN" ("ASF1" "Serine/arginine-rich splicing factor 1" "Alternative-splicing factor 1" "ASF-1" "Splicing factor, arginine/serine-rich 1" "pre-mRNA-splicing factor SF2, P33 subunit"))
=======
(define-protein "SRRT_HUMAN" ("Serrate RNA effector molecule homolog" "Arsenite-resistance protein 2"))
(define-protein "SRSF1_HUMAN" ("Serine/arginine-rich splicing factor 1" "Alternative-splicing factor 1" "ASF-1" "Splicing factor, arginine/serine-rich 1" "pre-mRNA-splicing factor SF2, P33 subunit"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "SRSF5_HUMAN" ("SFRS5" "SRSF5" "HRS" "SRP40")) 
(define-protein "SRSF9_HUMAN" ("SRSF9" "SFRS9" "SRP30C")) 
(define-protein "SRTD1_HUMAN" ("SERTAD1" "TRIP-Br1" "SEI1" "SEI-1")) 
<<<<<<< .mine
(define-protein "SSH1_HUMAN" ("slingshot" "Protein phosphatase Slingshot homolog 1" "SSH-like protein 1" "SSH-1L" "hSSH-1L"))
=======
<<<<<<< .mine
(define-protein "SSH1_HUMAN" ("slingshot" "Protein phosphatase Slingshot homolog 1" "SSH-like protein 1" "SSH-1L" "hSSH-1L"))
=======
(define-protein "SSH1_HUMAN" ("Protein phosphatase Slingshot homolog 1" "SSH-like protein 1" "SSH-1L" "hSSH-1L"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "SSRP1_HUMAN" ("FACTp80" "FACT80" "SSRP1" "hSSRP1" "T160")) 
<<<<<<< .mine
(define-protein "ST17A_HUMAN" ("thiazolidinediones" "Serine/threonine-protein kinase 17A" "DAP kinase-related apoptosis-inducing protein kinase 1"))
(define-protein "ST1A1_HUMAN" ("1A1" "Sulfotransferase 1A1" "ST1A1" "Aryl sulfotransferase 1" "HAST1/HAST2" "Phenol sulfotransferase 1" "Phenol-sulfating phenol sulfotransferase 1" "P-PST 1" "ST1A3" "Thermostable phenol sulfotransferase" "Ts-PST"))
(define-protein "ST1A2_HUMAN" ("1A2" "Sulfotransferase 1A2" "ST1A2" "Aryl sulfotransferase 2" "Phenol sulfotransferase 2" "Phenol-sulfating phenol sulfotransferase 2" "P-PST 2"))
(define-protein "ST2A1_HUMAN" ("catabolism" "Bile salt sulfotransferase" "Dehydroepiandrosterone sulfotransferase" "DHEA-ST" "Hydroxysteroid Sulfotransferase" "HST" "ST2" "ST2A3" "Sulfotransferase 2A1" "ST2A1"))
(define-protein "ST2B1_HUMAN" ("2B1" "Sulfotransferase family cytosolic 2B member 1" "ST2B1" "Sulfotransferase 2B1" "Alcohol sulfotransferase" "Hydroxysteroid sulfotransferase 2"))
(define-protein "ST5_HUMAN" ("hela" "Suppression of tumorigenicity 5 protein" "DENN domain-containing protein 2B" "HeLa tumor suppression 1"))
=======
<<<<<<< .mine
(define-protein "ST17A_HUMAN" ("thiazolidinediones" "Serine/threonine-protein kinase 17A" "DAP kinase-related apoptosis-inducing protein kinase 1"))
(define-protein "ST1A1_HUMAN" ("1A1" "Sulfotransferase 1A1" "ST1A1" "Aryl sulfotransferase 1" "HAST1/HAST2" "Phenol sulfotransferase 1" "Phenol-sulfating phenol sulfotransferase 1" "P-PST 1" "ST1A3" "Thermostable phenol sulfotransferase" "Ts-PST"))
(define-protein "ST1A2_HUMAN" ("1A2" "Sulfotransferase 1A2" "ST1A2" "Aryl sulfotransferase 2" "Phenol sulfotransferase 2" "Phenol-sulfating phenol sulfotransferase 2" "P-PST 2"))
(define-protein "ST2A1_HUMAN" ("catabolism" "Bile salt sulfotransferase" "Dehydroepiandrosterone sulfotransferase" "DHEA-ST" "Hydroxysteroid Sulfotransferase" "HST" "ST2" "ST2A3" "Sulfotransferase 2A1" "ST2A1"))
(define-protein "ST2B1_HUMAN" ("2B1" "Sulfotransferase family cytosolic 2B member 1" "ST2B1" "Sulfotransferase 2B1" "Alcohol sulfotransferase" "Hydroxysteroid sulfotransferase 2"))
(define-protein "ST5_HUMAN" ("hela" "Suppression of tumorigenicity 5 protein" "DENN domain-containing protein 2B" "HeLa tumor suppression 1"))
=======
(define-protein "ST17A_HUMAN" ("Serine/threonine-protein kinase 17A" "DAP kinase-related apoptosis-inducing protein kinase 1"))
(define-protein "ST1A1_HUMAN" ("Sulfotransferase 1A1" "ST1A1" "Aryl sulfotransferase 1" "HAST1/HAST2" "Phenol sulfotransferase 1" "Phenol-sulfating phenol sulfotransferase 1" "P-PST 1" "ST1A3" "Thermostable phenol sulfotransferase" "Ts-PST"))
(define-protein "ST1A2_HUMAN" ("Sulfotransferase 1A2" "ST1A2" "Aryl sulfotransferase 2" "Phenol sulfotransferase 2" "Phenol-sulfating phenol sulfotransferase 2" "P-PST 2"))
(define-protein "ST2A1_HUMAN" ("Bile salt sulfotransferase" "Dehydroepiandrosterone sulfotransferase" "DHEA-ST" "Hydroxysteroid Sulfotransferase" "HST" "ST2" "ST2A3" "Sulfotransferase 2A1" "ST2A1"))
(define-protein "ST2B1_HUMAN" ("Sulfotransferase family cytosolic 2B member 1" "ST2B1" "Sulfotransferase 2B1" "Alcohol sulfotransferase" "Hydroxysteroid sulfotransferase 2"))
(define-protein "ST5_HUMAN" ("Suppression of tumorigenicity 5 protein" "DENN domain-containing protein 2B" "HeLa tumor suppression 1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "STAG1_HUMAN" ("STAG1" "SA1")) 
<<<<<<< .mine
(define-protein "STAG2_HUMAN" ("Scc3" "Cohesin subunit SA-2" "SCC3 homolog 2" "Stromal antigen 2"))
=======
<<<<<<< .mine
(define-protein "STAG2_HUMAN" ("Scc3" "Cohesin subunit SA-2" "SCC3 homolog 2" "Stromal antigen 2"))
=======
(define-protein "STAG2_HUMAN" ("Cohesin subunit SA-2" "SCC3 homolog 2" "Stromal antigen 2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "STALP_HUMAN" ("AMSHLP" "KIAA1373" "STAMBPL1" "AMSH-LP")) 
(define-protein "STAM1_HUMAN" ("STAM1" "STAM-1" "STAM")) 
(define-protein "STAR5_HUMAN" ("STARD5" "StARD5")) 
(define-protein "STAR7_HUMAN" ("StARD7" "GTT1" "STARD7")) 
(define-protein "STAT3_HUMAN" ("Cbp/PAG" "Signal transducer and activator of transcription 3" "Acute-phase response factor"))
(define-protein "STAT3_HUMAN" ("Signal transducer and activator of transcription 3" "Acute-phase response factor"))
<<<<<<< .mine
(define-protein "STAT6_HUMAN" ("STAT-6" "Signal transducer and activator of transcription 6" "IL-4 Stat"))
(define-protein "STIP1_HUMAN" ("TPR2A" "Stress-induced-phosphoprotein 1" "STI1" "Hsc70/Hsp90-organizing protein" "Hop" "Renal carcinoma antigen NY-REN-11" "Transformation-sensitive protein IEF SSP 3521"))
=======
<<<<<<< .mine
(define-protein "STAT6_HUMAN" ("STAT-6" "Signal transducer and activator of transcription 6" "IL-4 Stat"))
(define-protein "STIP1_HUMAN" ("TPR2A" "Stress-induced-phosphoprotein 1" "STI1" "Hsc70/Hsp90-organizing protein" "Hop" "Renal carcinoma antigen NY-REN-11" "Transformation-sensitive protein IEF SSP 3521"))
=======
(define-protein "STAT6_HUMAN" ("Signal transducer and activator of transcription 6" "IL-4 Stat"))
(define-protein "STIP1_HUMAN" ("Stress-induced-phosphoprotein 1" "STI1" "Hsc70/Hsp90-organizing protein" "Hop" "Renal carcinoma antigen NY-REN-11" "Transformation-sensitive protein IEF SSP 3521"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "STK11_HUMAN" ("Serine/threonine-protein kinase STK11" "Liver kinase B1" "LKB1" "hLKB1" "Renal carcinoma antigen NY-REN-19"))
<<<<<<< .mine
(define-protein "STK25_HUMAN" ("oxidant" "Serine/threonine-protein kinase 25" "Ste20-like kinase" "Sterile 20/oxidant stress-response kinase 1" "SOK-1" "Ste20/oxidant stress response kinase 1"))
=======
<<<<<<< .mine
(define-protein "STK25_HUMAN" ("oxidant" "Serine/threonine-protein kinase 25" "Ste20-like kinase" "Sterile 20/oxidant stress-response kinase 1" "SOK-1" "Ste20/oxidant stress response kinase 1"))
=======
(define-protein "STK25_HUMAN" ("Serine/threonine-protein kinase 25" "Ste20-like kinase" "Sterile 20/oxidant stress-response kinase 1" "SOK-1" "Ste20/oxidant stress response kinase 1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "STK26_HUMAN" ("STK26" "MST4" "MASK" "MST-4")) 
(define-protein "STK38_HUMAN" ("NDR1" "STK38")) 
(define-protein "STK39_HUMAN" ("DCHT" "SPAK" "STK39")) 
(define-protein "STK3_HUMAN" ("Serine/threonine-protein kinase 3" "Mammalian STE20-like protein kinase 2" "MST-2" "STE20-like kinase MST2" "Serine/threonine-protein kinase Krs-1"))
(define-protein "STK4_HUMAN" ("Serine/threonine-protein kinase 4" "Mammalian STE20-like protein kinase 1" "MST-1" "STE20-like kinase MST1" "Serine/threonine-protein kinase Krs-2"))
<<<<<<< .mine
(define-protein "STML1_HUMAN" ("stomatin" "Stomatin-like protein 1" "SLP-1" "EPB72-like protein 1" "Protein unc-24 homolog" "Stomatin-related protein" "STORP"))
=======
<<<<<<< .mine
(define-protein "STML1_HUMAN" ("stomatin" "Stomatin-like protein 1" "SLP-1" "EPB72-like protein 1" "Protein unc-24 homolog" "Stomatin-related protein" "STORP"))
=======
(define-protein "STML1_HUMAN" ("Stomatin-like protein 1" "SLP-1" "EPB72-like protein 1" "Protein unc-24 homolog" "Stomatin-related protein" "STORP"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "STML2_HUMAN" ("SLP-2" "STOML2" "Paratarg-7" "SLP2")) 
<<<<<<< .mine
(define-protein "STMN1_HUMAN" ("oncoprotein" "Stathmin" "Leukemia-associated phosphoprotein p18" "Metablastin" "Oncoprotein 18" "Op18" "Phosphoprotein p19" "pp19" "Prosolin" "Protein Pr22" "pp17"))
(define-protein "STRAA_HUMAN" ("strad" "STE20-related kinase adapter protein alpha" "STRAD alpha" "STE20-related adapter protein" "Serologically defined breast cancer antigen NY-BR-96"))
=======
<<<<<<< .mine
(define-protein "STMN1_HUMAN" ("oncoprotein" "Stathmin" "Leukemia-associated phosphoprotein p18" "Metablastin" "Oncoprotein 18" "Op18" "Phosphoprotein p19" "pp19" "Prosolin" "Protein Pr22" "pp17"))
(define-protein "STRAA_HUMAN" ("strad" "STE20-related kinase adapter protein alpha" "STRAD alpha" "STE20-related adapter protein" "Serologically defined breast cancer antigen NY-BR-96"))
=======
(define-protein "STMN1_HUMAN" ("Stathmin" "Leukemia-associated phosphoprotein p18" "Metablastin" "Oncoprotein 18" "Op18" "Phosphoprotein p19" "pp19" "Prosolin" "Protein Pr22" "pp17"))
(define-protein "STRAA_HUMAN" ("STE20-related kinase adapter protein alpha" "STRAD alpha" "STE20-related adapter protein" "Serologically defined breast cancer antigen NY-BR-96"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "STRUM_HUMAN" ("KIAA0196" "Strumpellin")) 
(define-protein "STX12_HUMAN" ("STX12")) 
(define-protein "STX16_HUMAN" ("STX16" "Syn16")) 
(define-protein "STX17_HUMAN" ("STX17")) 
(define-protein "STX18_HUMAN" ("STX18")) 
<<<<<<< .mine
(define-protein "STX1B_HUMAN" ("syntaxin" "Syntaxin-1B" "Syntaxin-1B1" "Syntaxin-1B2"))
=======
<<<<<<< .mine
(define-protein "STX1B_HUMAN" ("syntaxin" "Syntaxin-1B" "Syntaxin-1B1" "Syntaxin-1B2"))
=======
(define-protein "STX1B_HUMAN" ("Syntaxin-1B" "Syntaxin-1B1" "Syntaxin-1B2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "STX3_HUMAN" ("STX3A" "STX3")) 
(define-protein "STX4_HUMAN" ("STX4A" "STX4")) 
(define-protein "STX5_HUMAN" ("STX5" "STX5A")) 
(define-protein "STX7_HUMAN" ("STX7")) 
(define-protein "STXB2_HUMAN" ("UNC18B" "Unc18-2" "Unc-18B" "STXBP2")) 
(define-protein "STXB3_HUMAN" ("PSP" "Unc18-3" "Unc-18C" "STXBP3")) 
(define-protein "SUMO1_HUMAN" ("Small ubiquitin-related modifier 1" "SUMO-1" "GAP-modifying protein 1" "GMP1" "SMT3 homolog 3" "Sentrin" "Ubiquitin-homology domain protein PIC1" "Ubiquitin-like protein SMT3C" "Smt3C" "Ubiquitin-like protein UBL1"))
(define-protein "SUMO2_HUMAN" ("Small ubiquitin-related modifier 2" "SUMO-2" "HSMT3" "SMT3 homolog 2" "SUMO-3" "Sentrin-2" "Ubiquitin-like protein SMT3B" "Smt3B"))
<<<<<<< .mine
(define-protein "SUV92_HUMAN" ("H3-K9" "Histone-lysine N-methyltransferase SUV39H2" "Histone H3-K9 methyltransferase 2" "H3-K9-HMTase 2" "Lysine N-methyltransferase 1B" "Suppressor of variegation 3-9 homolog 2" "Su(var)3-9 homolog 2"))
(define-protein "SUZ12_HUMAN" ("Suz12" "Polycomb protein SUZ12" "Chromatin precipitated E2F target 9 protein" "ChET 9 protein" "Joined to JAZF1 protein" "Suppressor of zeste 12 protein homolog"))
=======
<<<<<<< .mine
(define-protein "SUV92_HUMAN" ("H3-K9" "Histone-lysine N-methyltransferase SUV39H2" "Histone H3-K9 methyltransferase 2" "H3-K9-HMTase 2" "Lysine N-methyltransferase 1B" "Suppressor of variegation 3-9 homolog 2" "Su(var)3-9 homolog 2"))
(define-protein "SUZ12_HUMAN" ("Suz12" "Polycomb protein SUZ12" "Chromatin precipitated E2F target 9 protein" "ChET 9 protein" "Joined to JAZF1 protein" "Suppressor of zeste 12 protein homolog"))
=======
(define-protein "SUV92_HUMAN" ("Histone-lysine N-methyltransferase SUV39H2" "Histone H3-K9 methyltransferase 2" "H3-K9-HMTase 2" "Lysine N-methyltransferase 1B" "Suppressor of variegation 3-9 homolog 2" "Su(var)3-9 homolog 2"))
(define-protein "SUZ12_HUMAN" ("Polycomb protein SUZ12" "Chromatin precipitated E2F target 9 protein" "ChET 9 protein" "Joined to JAZF1 protein" "Suppressor of zeste 12 protein homolog"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "SWP70_HUMAN" ("SWAP70" "KIAA0640" "SWAP-70" "Swap-70")) 
<<<<<<< .mine
(define-protein "SYBU_HUMAN" ("syntaxin-1" "Syntabulin" "Golgi-localized syntaphilin-related protein" "Syntaxin-1-binding protein"))
(define-protein "SYEP_HUMAN" ("aminoacyl-tRNA" "Bifunctional glutamate/proline--tRNA ligase" "Bifunctional aminoacyl-tRNA synthetase" "Cell proliferation-inducing gene 32 protein" "Glutamatyl-prolyl-tRNA synthetase"))
(define-protein "SYHM_HUMAN" ("HO-3" "Probable histidine--tRNA ligase, mitochondrial" "Histidine--tRNA ligase-like" "Histidyl-tRNA synthetase" "HisRS"))
=======
<<<<<<< .mine
(define-protein "SYBU_HUMAN" ("syntaxin-1" "Syntabulin" "Golgi-localized syntaphilin-related protein" "Syntaxin-1-binding protein"))
(define-protein "SYEP_HUMAN" ("aminoacyl-tRNA" "Bifunctional glutamate/proline--tRNA ligase" "Bifunctional aminoacyl-tRNA synthetase" "Cell proliferation-inducing gene 32 protein" "Glutamatyl-prolyl-tRNA synthetase"))
(define-protein "SYHM_HUMAN" ("HO-3" "Probable histidine--tRNA ligase, mitochondrial" "Histidine--tRNA ligase-like" "Histidyl-tRNA synthetase" "HisRS"))
=======
(define-protein "SYBU_HUMAN" ("Syntabulin" "Golgi-localized syntaphilin-related protein" "Syntaxin-1-binding protein"))
(define-protein "SYEP_HUMAN" ("Bifunctional glutamate/proline--tRNA ligase" "Bifunctional aminoacyl-tRNA synthetase" "Cell proliferation-inducing gene 32 protein" "Glutamatyl-prolyl-tRNA synthetase"))
(define-protein "SYHM_HUMAN" ("Probable histidine--tRNA ligase, mitochondrial" "Histidine--tRNA ligase-like" "Histidyl-tRNA synthetase" "HisRS"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "SYJ2B_HUMAN" ("SYNJ2BP" "OMP25")) 
(define-protein "SYNE2_HUMAN" ("Syne-2" "SYNE2" "NUA" "KIAA1011")) 
<<<<<<< .mine
(define-protein "SYNRG_HUMAN" ("γ-synergin" "Synergin gamma" "AP1 subunit gamma-binding protein 1" "Gamma-synergin"))
(define-protein "SYPH_HUMAN" ("synaptophysin" "Synaptophysin" "Major synaptic vesicle protein p38"))
(define-protein "SYT16_HUMAN" ("synaptotagmin" "Synaptotagmin-16" "Chr14Syt" "Synaptotagmin 14-like protein" "Synaptotagmin XIV-related protein"))
(define-protein "SYT1_HUMAN" ("synaptotagmin-1" "Synaptotagmin-1" "Synaptotagmin I" "SytI" "p65"))
(define-protein "SYUA_HUMAN" ("α-synuclein" "Alpha-synuclein" "Non-A beta component of AD amyloid" "Non-A4 component of amyloid precursor" "NACP"))
(define-protein "T22D3_HUMAN" ("gilz" "TSC22 domain family protein 3" "DSIP-immunoreactive peptide" "Protein DIP" "hDIP" "Delta sleep-inducing peptide immunoreactor" "Glucocorticoid-induced leucine zipper protein" "GILZ" "TSC-22-like protein" "TSC-22-related protein" "TSC-22R"))
(define-protein "TAB3_HUMAN" ("TAB2/3" "TGF-beta-activated kinase 1 and MAP3K7-binding protein 3" "Mitogen-activated protein kinase kinase kinase 7-interacting protein 3" "NF-kappa-B-activating protein 1" "TAK1-binding protein 3" "TAB-3" "TGF-beta-activated kinase 1-binding protein 3"))
(define-protein "TAF1A_HUMAN" ("SL1" "TATA box-binding protein-associated factor RNA polymerase I subunit A" "RNA polymerase I-specific TBP-associated factor 48 kDa" "TAFI48" "TATA box-binding protein-associated factor 1A" "TBP-associated factor 1A" "Transcription factor SL1" "Transcription initiation factor SL1/TIF-IB subunit A"))
=======
<<<<<<< .mine
(define-protein "SYNRG_HUMAN" ("γ-synergin" "Synergin gamma" "AP1 subunit gamma-binding protein 1" "Gamma-synergin"))
(define-protein "SYPH_HUMAN" ("synaptophysin" "Synaptophysin" "Major synaptic vesicle protein p38"))
(define-protein "SYT16_HUMAN" ("synaptotagmin" "Synaptotagmin-16" "Chr14Syt" "Synaptotagmin 14-like protein" "Synaptotagmin XIV-related protein"))
(define-protein "SYT1_HUMAN" ("synaptotagmin-1" "Synaptotagmin-1" "Synaptotagmin I" "SytI" "p65"))
(define-protein "SYUA_HUMAN" ("α-synuclein" "Alpha-synuclein" "Non-A beta component of AD amyloid" "Non-A4 component of amyloid precursor" "NACP"))
(define-protein "T22D3_HUMAN" ("gilz" "TSC22 domain family protein 3" "DSIP-immunoreactive peptide" "Protein DIP" "hDIP" "Delta sleep-inducing peptide immunoreactor" "Glucocorticoid-induced leucine zipper protein" "GILZ" "TSC-22-like protein" "TSC-22-related protein" "TSC-22R"))
(define-protein "TAB3_HUMAN" ("TAB2/3" "TGF-beta-activated kinase 1 and MAP3K7-binding protein 3" "Mitogen-activated protein kinase kinase kinase 7-interacting protein 3" "NF-kappa-B-activating protein 1" "TAK1-binding protein 3" "TAB-3" "TGF-beta-activated kinase 1-binding protein 3"))
(define-protein "TAF1A_HUMAN" ("SL1" "TATA box-binding protein-associated factor RNA polymerase I subunit A" "RNA polymerase I-specific TBP-associated factor 48 kDa" "TAFI48" "TATA box-binding protein-associated factor 1A" "TBP-associated factor 1A" "Transcription factor SL1" "Transcription initiation factor SL1/TIF-IB subunit A"))
=======
(define-protein "SYNRG_HUMAN" ("Synergin gamma" "AP1 subunit gamma-binding protein 1" "Gamma-synergin"))
(define-protein "SYPH_HUMAN" ("Synaptophysin" "Major synaptic vesicle protein p38"))
(define-protein "SYT16_HUMAN" ("Synaptotagmin-16" "Chr14Syt" "Synaptotagmin 14-like protein" "Synaptotagmin XIV-related protein"))
(define-protein "SYT1_HUMAN" ("Synaptotagmin-1" "Synaptotagmin I" "SytI" "p65"))
(define-protein "SYUA_HUMAN" ("Alpha-synuclein" "Non-A beta component of AD amyloid" "Non-A4 component of amyloid precursor" "NACP"))
(define-protein "T22D3_HUMAN" ("TSC22 domain family protein 3" "DSIP-immunoreactive peptide" "Protein DIP" "hDIP" "Delta sleep-inducing peptide immunoreactor" "Glucocorticoid-induced leucine zipper protein" "GILZ" "TSC-22-like protein" "TSC-22-related protein" "TSC-22R"))
(define-protein "TAB3_HUMAN" ("TGF-beta-activated kinase 1 and MAP3K7-binding protein 3" "Mitogen-activated protein kinase kinase kinase 7-interacting protein 3" "NF-kappa-B-activating protein 1" "TAK1-binding protein 3" "TAB-3" "TGF-beta-activated kinase 1-binding protein 3"))
(define-protein "TAF1A_HUMAN" ("TATA box-binding protein-associated factor RNA polymerase I subunit A" "RNA polymerase I-specific TBP-associated factor 48 kDa" "TAFI48" "TATA box-binding protein-associated factor 1A" "TBP-associated factor 1A" "Transcription factor SL1" "Transcription initiation factor SL1/TIF-IB subunit A"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "TAGL2_HUMAN" ("TAGLN2" "KIAA0120")) 
<<<<<<< .mine
(define-protein "TAM41_HUMAN" ("TAM-" "Phosphatidate cytidylyltransferase, mitochondrial" "CDP-diacylglycerol synthase" "CDP-DAG synthase" "Mitochondrial translocator assembly and maintenance protein 41 homolog" "TAM41"))
=======
<<<<<<< .mine
(define-protein "TAM41_HUMAN" ("TAM-" "Phosphatidate cytidylyltransferase, mitochondrial" "CDP-diacylglycerol synthase" "CDP-DAG synthase" "Mitochondrial translocator assembly and maintenance protein 41 homolog" "TAM41"))
=======
(define-protein "TAM41_HUMAN" ("Phosphatidate cytidylyltransferase, mitochondrial" "CDP-diacylglycerol synthase" "CDP-DAG synthase" "Mitochondrial translocator assembly and maintenance protein 41 homolog" "TAM41"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "TAOK1_HUMAN" ("hKFC-B" "MAP3K16" "hTAOK1" "PSK2" "MARKK" "TAOK1" "PSK-2" "KIAA1361")) 
(define-protein "TAOK3_HUMAN" ("TAOK3" "DPK" "JIK" "MAP3K18" "hKFC-A" "KDS")) 
(define-protein "TAP1_HUMAN" ("Y3" "ABCB2" "APT1" "PSF1" "TAP1" "RING4" "PSF-1")) 
(define-protein "TAP2_HUMAN" ("Y1" "ABCB3" "APT2" "RING11" "PSF2" "TAP2" "PSF-2")) 
<<<<<<< .mine
(define-protein "TARM1_HUMAN" ("oscar" "T-cell-interacting, activating receptor on myeloid cells protein 1" "OSCAR-like transcript-2 protein" "OLT-2"))
(define-protein "TAU_HUMAN" ("p-Tau" "Microtubule-associated protein tau" "Neurofibrillary tangle protein" "Paired helical filament-tau" "PHF-tau"))
=======
<<<<<<< .mine
(define-protein "TARM1_HUMAN" ("oscar" "T-cell-interacting, activating receptor on myeloid cells protein 1" "OSCAR-like transcript-2 protein" "OLT-2"))
(define-protein "TAU_HUMAN" ("p-Tau" "Microtubule-associated protein tau" "Neurofibrillary tangle protein" "Paired helical filament-tau" "PHF-tau"))
=======
(define-protein "TARM1_HUMAN" ("T-cell-interacting, activating receptor on myeloid cells protein 1" "OSCAR-like transcript-2 protein" "OLT-2"))
(define-protein "TAU_HUMAN" ("Microtubule-associated protein tau" "Neurofibrillary tangle protein" "Paired helical filament-tau" "PHF-tau"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "TB10B_HUMAN" ("TBC1D10B" "Rab27A-GAP-beta")) 
(define-protein "TB22B_HUMAN" ("C6orf197" "TBC1D22B")) 
<<<<<<< .mine
(define-protein "TBA4A_HUMAN" ("α-tubulin" "Tubulin alpha-4A chain" "Alpha-tubulin 1" "Testis-specific alpha-tubulin" "Tubulin H2-alpha" "Tubulin alpha-1 chain"))
=======
<<<<<<< .mine
(define-protein "TBA4A_HUMAN" ("α-tubulin" "Tubulin alpha-4A chain" "Alpha-tubulin 1" "Testis-specific alpha-tubulin" "Tubulin H2-alpha" "Tubulin alpha-1 chain"))
=======
(define-protein "TBA4A_HUMAN" ("Tubulin alpha-4A chain" "Alpha-tubulin 1" "Testis-specific alpha-tubulin" "Tubulin H2-alpha" "Tubulin alpha-1 chain"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "TBC15_HUMAN" ("TBC1D15" "Rab7-GAP")) 
(define-protein "TBC17_HUMAN" ("TBC1D17")) 
<<<<<<< .mine
(define-protein "TBC3A_HUMAN" ("Tbc1d" "TBC1 domain family member 3" "Prostate cancer gene 17 protein" "Protein TRE17-alpha" "Rab GTPase-activating protein PRC17"))
=======
<<<<<<< .mine
(define-protein "TBC3A_HUMAN" ("Tbc1d" "TBC1 domain family member 3" "Prostate cancer gene 17 protein" "Protein TRE17-alpha" "Rab GTPase-activating protein PRC17"))
=======
(define-protein "TBC3A_HUMAN" ("TBC1 domain family member 3" "Prostate cancer gene 17 protein" "Protein TRE17-alpha" "Rab GTPase-activating protein PRC17"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "TBC9B_HUMAN" ("TBC1D9B" "KIAA0676")) 
<<<<<<< .mine
(define-protein "TBCB_HUMAN" ("cofactors" "Tubulin-folding cofactor B" "Cytoskeleton-associated protein 1" "Cytoskeleton-associated protein CKAPI" "Tubulin-specific chaperone B"))
=======
<<<<<<< .mine
(define-protein "TBCB_HUMAN" ("cofactors" "Tubulin-folding cofactor B" "Cytoskeleton-associated protein 1" "Cytoskeleton-associated protein CKAPI" "Tubulin-specific chaperone B"))
=======
(define-protein "TBCB_HUMAN" ("Tubulin-folding cofactor B" "Cytoskeleton-associated protein 1" "Cytoskeleton-associated protein CKAPI" "Tubulin-specific chaperone B"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "TBCD1_HUMAN" ("TBC1D1" "KIAA1108")) 
(define-protein "TBCD4_HUMAN" ("TBC1D4" "AS160" "KIAA0603")) 
<<<<<<< .mine
(define-protein "TBCD_HUMAN" ("β-tubulin" "Tubulin-specific chaperone D" "Beta-tubulin cofactor D" "tfcD" "SSD-1" "Tubulin-folding cofactor D"))
(define-protein "TBP_HUMAN" ("tfiid" "TATA-box-binding protein" "TATA sequence-binding protein" "TATA-binding factor" "TATA-box factor" "Transcription initiation factor TFIID TBP subunit"))
(define-protein "TBX19_HUMAN" ("tpit" "T-box transcription factor TBX19" "T-box protein 19" "T-box factor, pituitary"))
(define-protein "TBX21_HUMAN" ("T-bet" "T-box transcription factor TBX21" "T-box protein 21" "T-cell-specific T-box transcription factor T-bet" "Transcription factor TBLYM"))
(define-protein "TCAM1_HUMAN" ("tir" "TIR domain-containing adapter molecule 1" "TICAM-1" "Proline-rich, vinculin and TIR domain-containing protein B" "Putative NF-kappa-B-activating protein 502H" "Toll-interleukin-1 receptor domain-containing adapter protein inducing interferon beta" "MyD88-3" "TIR domain-containing adapter protein inducing IFN-beta"))
(define-protein "TCAM2_HUMAN" ("trif" "TIR domain-containing adapter molecule 2" "TICAM-2" "Putative NF-kappa-B-activating protein 502" "TRIF-related adapter molecule" "Toll-like receptor adaptor protein 3" "Toll/interleukin-1 receptor domain-containing protein" "MyD88-4"))
(define-protein "TCEA1_HUMAN" ("tfs" "Transcription elongation factor A protein 1" "Transcription elongation factor S-II protein 1" "Transcription elongation factor TFIIS.o"))
(define-protein "TCF20_HUMAN" ("spbp" "Transcription factor 20" "TCF-20" "Nuclear factor SPBP" "Protein AR1" "Stromelysin-1 PDGF-responsive element-binding protein" "SPRE-binding protein"))
(define-protein "TCPD_HUMAN" ("Cct4" "T-complex protein 1 subunit delta" "TCP-1-delta" "CCT-delta" "Stimulator of TAR RNA-binding"))
(define-protein "TCPG_HUMAN" ("tric" "T-complex protein 1 subunit gamma" "TCP-1-gamma" "CCT-gamma" "hTRiC5"))
=======
<<<<<<< .mine
(define-protein "TBCD_HUMAN" ("β-tubulin" "Tubulin-specific chaperone D" "Beta-tubulin cofactor D" "tfcD" "SSD-1" "Tubulin-folding cofactor D"))
(define-protein "TBP_HUMAN" ("tfiid" "TATA-box-binding protein" "TATA sequence-binding protein" "TATA-binding factor" "TATA-box factor" "Transcription initiation factor TFIID TBP subunit"))
(define-protein "TBX19_HUMAN" ("tpit" "T-box transcription factor TBX19" "T-box protein 19" "T-box factor, pituitary"))
(define-protein "TBX21_HUMAN" ("T-bet" "T-box transcription factor TBX21" "T-box protein 21" "T-cell-specific T-box transcription factor T-bet" "Transcription factor TBLYM"))
(define-protein "TCAM1_HUMAN" ("tir" "TIR domain-containing adapter molecule 1" "TICAM-1" "Proline-rich, vinculin and TIR domain-containing protein B" "Putative NF-kappa-B-activating protein 502H" "Toll-interleukin-1 receptor domain-containing adapter protein inducing interferon beta" "MyD88-3" "TIR domain-containing adapter protein inducing IFN-beta"))
(define-protein "TCAM2_HUMAN" ("trif" "TIR domain-containing adapter molecule 2" "TICAM-2" "Putative NF-kappa-B-activating protein 502" "TRIF-related adapter molecule" "Toll-like receptor adaptor protein 3" "Toll/interleukin-1 receptor domain-containing protein" "MyD88-4"))
(define-protein "TCEA1_HUMAN" ("tfs" "Transcription elongation factor A protein 1" "Transcription elongation factor S-II protein 1" "Transcription elongation factor TFIIS.o"))
(define-protein "TCF20_HUMAN" ("spbp" "Transcription factor 20" "TCF-20" "Nuclear factor SPBP" "Protein AR1" "Stromelysin-1 PDGF-responsive element-binding protein" "SPRE-binding protein"))
(define-protein "TCPD_HUMAN" ("Cct4" "T-complex protein 1 subunit delta" "TCP-1-delta" "CCT-delta" "Stimulator of TAR RNA-binding"))
(define-protein "TCPG_HUMAN" ("tric" "T-complex protein 1 subunit gamma" "TCP-1-gamma" "CCT-gamma" "hTRiC5"))
=======
(define-protein "TBCD_HUMAN" ("Tubulin-specific chaperone D" "Beta-tubulin cofactor D" "tfcD" "SSD-1" "Tubulin-folding cofactor D"))
(define-protein "TBP_HUMAN" ("TATA-box-binding protein" "TATA sequence-binding protein" "TATA-binding factor" "TATA-box factor" "Transcription initiation factor TFIID TBP subunit"))
(define-protein "TBX19_HUMAN" ("T-box transcription factor TBX19" "T-box protein 19" "T-box factor, pituitary"))
(define-protein "TBX21_HUMAN" ("T-box transcription factor TBX21" "T-box protein 21" "T-cell-specific T-box transcription factor T-bet" "Transcription factor TBLYM"))
(define-protein "TCAM1_HUMAN" ("TIR domain-containing adapter molecule 1" "TICAM-1" "Proline-rich, vinculin and TIR domain-containing protein B" "Putative NF-kappa-B-activating protein 502H" "Toll-interleukin-1 receptor domain-containing adapter protein inducing interferon beta" "MyD88-3" "TIR domain-containing adapter protein inducing IFN-beta"))
(define-protein "TCAM2_HUMAN" ("TIR domain-containing adapter molecule 2" "TICAM-2" "Putative NF-kappa-B-activating protein 502" "TRIF-related adapter molecule" "Toll-like receptor adaptor protein 3" "Toll/interleukin-1 receptor domain-containing protein" "MyD88-4"))
(define-protein "TCEA1_HUMAN" ("Transcription elongation factor A protein 1" "Transcription elongation factor S-II protein 1" "Transcription elongation factor TFIIS.o"))
(define-protein "TCF20_HUMAN" ("Transcription factor 20" "TCF-20" "Nuclear factor SPBP" "Protein AR1" "Stromelysin-1 PDGF-responsive element-binding protein" "SPRE-binding protein"))
(define-protein "TCPD_HUMAN" ("T-complex protein 1 subunit delta" "TCP-1-delta" "CCT-delta" "Stimulator of TAR RNA-binding"))
(define-protein "TCPG_HUMAN" ("T-complex protein 1 subunit gamma" "TCP-1-gamma" "CCT-gamma" "hTRiC5"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "TCPH_HUMAN" ("CCT-eta" "CCT7" "CCTH" "TCP-1-eta" "NIP7-1")) 
<<<<<<< .mine
(define-protein "TCPQ_HUMAN" ("Cct8" "T-complex protein 1 subunit theta" "TCP-1-theta" "CCT-theta" "Renal carcinoma antigen NY-REN-15"))
(define-protein "TDG_HUMAN" ("tdg" "G/T mismatch-specific thymine DNA glycosylase" "Thymine-DNA glycosylase" "hTDG"))
=======
<<<<<<< .mine
(define-protein "TCPQ_HUMAN" ("Cct8" "T-complex protein 1 subunit theta" "TCP-1-theta" "CCT-theta" "Renal carcinoma antigen NY-REN-15"))
(define-protein "TDG_HUMAN" ("tdg" "G/T mismatch-specific thymine DNA glycosylase" "Thymine-DNA glycosylase" "hTDG"))
=======
(define-protein "TCPQ_HUMAN" ("T-complex protein 1 subunit theta" "TCP-1-theta" "CCT-theta" "Renal carcinoma antigen NY-REN-15"))
(define-protein "TDG_HUMAN" ("G/T mismatch-specific thymine DNA glycosylase" "Thymine-DNA glycosylase" "hTDG"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "TEC_HUMAN" ("TEC" "PSCTK4")) 
(define-protein "TELO2_HUMAN" ("TELO2" "hCLK2" "KIAA0683")) 
<<<<<<< .mine
(define-protein "TERT_HUMAN" ("herbimycin" "Telomerase reverse transcriptase" "HEST2" "Telomerase catalytic subunit" "Telomerase-associated protein 2" "TP2"))
=======
<<<<<<< .mine
(define-protein "TERT_HUMAN" ("herbimycin" "Telomerase reverse transcriptase" "HEST2" "Telomerase catalytic subunit" "Telomerase-associated protein 2" "TP2"))
=======
(define-protein "TERT_HUMAN" ("Telomerase reverse transcriptase" "HEST2" "Telomerase catalytic subunit" "Telomerase-associated protein 2" "TP2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "TET1_HUMAN" ("Methylcytosine dioxygenase TET1" "CXXC-type zinc finger protein 6" "Leukemia-associated protein with a CXXC domain" "Ten-eleven translocation 1 gene protein"))
<<<<<<< .mine
(define-protein "TF2LX_HUMAN" ("TGF-β–induced" "Homeobox protein TGIF2LX" "TGF-beta-induced transcription factor 2-like protein" "TGFB-induced factor 2-like protein, X-linked" "TGIF-like on the X"))
=======
<<<<<<< .mine
(define-protein "TF2LX_HUMAN" ("TGF-β–induced" "Homeobox protein TGIF2LX" "TGF-beta-induced transcription factor 2-like protein" "TGFB-induced factor 2-like protein, X-linked" "TGIF-like on the X"))
=======
(define-protein "TF2LX_HUMAN" ("Homeobox protein TGIF2LX" "TGF-beta-induced transcription factor 2-like protein" "TGFB-induced factor 2-like protein, X-linked" "TGIF-like on the X"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "TF65_HUMAN" ("Transcription factor p65" "Nuclear factor NF-kappa-B p65 subunit" "Nuclear factor of kappa light polypeptide gene enhancer in B-cells 3"))
<<<<<<< .mine
(define-protein "TF65_HUMAN" ("enhanceosome" "Transcription factor p65" "Nuclear factor NF-kappa-B p65 subunit" "Nuclear factor of kappa light polypeptide gene enhancer in B-cells 3"))
(define-protein "TFDP1_HUMAN" ("DP-1" "Transcription factor Dp-1" "DRTF1-polypeptide 1" "DRTF1" "E2F dimerization partner 1"))
=======
<<<<<<< .mine
(define-protein "TF65_HUMAN" ("enhanceosome" "Transcription factor p65" "Nuclear factor NF-kappa-B p65 subunit" "Nuclear factor of kappa light polypeptide gene enhancer in B-cells 3"))
(define-protein "TFDP1_HUMAN" ("DP-1" "Transcription factor Dp-1" "DRTF1-polypeptide 1" "DRTF1" "E2F dimerization partner 1"))
=======
(define-protein "TFDP1_HUMAN" ("Transcription factor Dp-1" "DRTF1-polypeptide 1" "DRTF1" "E2F dimerization partner 1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "TFDP2_HUMAN" ("Transcription factor Dp-2" "E2F dimerization partner 2"))
<<<<<<< .mine
(define-protein "TFE2_HUMAN" ("Tcf-3" "Transcription factor E2-alpha" "Class B basic helix-loop-helix protein 21" "bHLHb21" "Immunoglobulin enhancer-binding factor E12/E47" "Immunoglobulin transcription factor 1" "Kappa-E2-binding factor" "Transcription factor 3" "TCF-3" "Transcription factor ITF-1"))
(define-protein "TFE3_HUMAN" ("MiT-TFE" "Transcription factor E3" "Class E basic helix-loop-helix protein 33" "bHLHe33"))
=======
<<<<<<< .mine
(define-protein "TFE2_HUMAN" ("Tcf-3" "Transcription factor E2-alpha" "Class B basic helix-loop-helix protein 21" "bHLHb21" "Immunoglobulin enhancer-binding factor E12/E47" "Immunoglobulin transcription factor 1" "Kappa-E2-binding factor" "Transcription factor 3" "TCF-3" "Transcription factor ITF-1"))
(define-protein "TFE3_HUMAN" ("MiT-TFE" "Transcription factor E3" "Class E basic helix-loop-helix protein 33" "bHLHe33"))
=======
(define-protein "TFE2_HUMAN" ("Transcription factor E2-alpha" "Class B basic helix-loop-helix protein 21" "bHLHb21" "Immunoglobulin enhancer-binding factor E12/E47" "Immunoglobulin transcription factor 1" "Kappa-E2-binding factor" "Transcription factor 3" "TCF-3" "Transcription factor ITF-1"))
(define-protein "TFE3_HUMAN" ("Transcription factor E3" "Class E basic helix-loop-helix protein 33" "bHLHe33"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "TFF1_HUMAN" ("Trefoil factor 1" "Breast cancer estrogen-inducible protein" "PNR-2" "Polypeptide P1.A" "hP1.A" "Protein pS2"))
(define-protein "TFF1_HUMAN" ("pS2" "Trefoil factor 1" "Breast cancer estrogen-inducible protein" "PNR-2" "Polypeptide P1.A" "hP1.A" "Protein pS2"))
(define-protein "TFG_HUMAN" ("Protein TFG" "TRK-fused gene protein"))
(define-protein "TFG_HUMAN" ("TRK-T3" "Protein TFG" "TRK-fused gene protein"))
(define-protein "TFIP8_HUMAN" ("MDC-3.13" "NDED" "SCC-S2" "TNFAIP8")) 
(define-protein "TGFA1_HUMAN" ("TRAP-1" "TRAP1" "TGFBRAP1")) 
<<<<<<< .mine
(define-protein "TGFA_HUMAN" ("tgfα" "Protransforming growth factor alpha"))
(define-protein "TGFB1_HUMAN" ("TGF-β1" "Transforming growth factor beta-1" "TGF-beta-1"))
=======
<<<<<<< .mine
(define-protein "TGFA_HUMAN" ("tgfα" "Protransforming growth factor alpha"))
(define-protein "TGFB1_HUMAN" ("TGF-β1" "Transforming growth factor beta-1" "TGF-beta-1"))
=======
(define-protein "TGFA_HUMAN" ("Protransforming growth factor alpha"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "TGFB1_HUMAN" ("Transforming growth factor beta-1" "TGF-beta-1"))
<<<<<<< .mine
(define-protein "TGFB2_HUMAN" ("TGFβ2" "Transforming growth factor beta-2" "TGF-beta-2" "BSC-1 cell growth inhibitor" "Cetermin" "Glioblastoma-derived T-cell suppressor factor" "G-TSF" "Polyergin"))
(define-protein "TGFR1_HUMAN" ("tβri" "TGF-beta receptor type-1" "TGFR-1" "Activin A receptor type II-like protein kinase of 53kD" "Activin receptor-like kinase 5" "ALK-5" "ALK5" "Serine/threonine-protein kinase receptor R4" "SKR4" "TGF-beta type I receptor" "Transforming growth factor-beta receptor type I" "TGF-beta receptor type I" "TbetaR-I"))
(define-protein "TGFR2_HUMAN" ("tβrii" "TGF-beta receptor type-2" "TGFR-2" "TGF-beta type II receptor" "Transforming growth factor-beta receptor type II" "TGF-beta receptor type II" "TbetaR-II"))
=======
<<<<<<< .mine
(define-protein "TGFB2_HUMAN" ("TGFβ2" "Transforming growth factor beta-2" "TGF-beta-2" "BSC-1 cell growth inhibitor" "Cetermin" "Glioblastoma-derived T-cell suppressor factor" "G-TSF" "Polyergin"))
(define-protein "TGFR1_HUMAN" ("tβri" "TGF-beta receptor type-1" "TGFR-1" "Activin A receptor type II-like protein kinase of 53kD" "Activin receptor-like kinase 5" "ALK-5" "ALK5" "Serine/threonine-protein kinase receptor R4" "SKR4" "TGF-beta type I receptor" "Transforming growth factor-beta receptor type I" "TGF-beta receptor type I" "TbetaR-I"))
(define-protein "TGFR2_HUMAN" ("tβrii" "TGF-beta receptor type-2" "TGFR-2" "TGF-beta type II receptor" "Transforming growth factor-beta receptor type II" "TGF-beta receptor type II" "TbetaR-II"))
=======
(define-protein "TGFB2_HUMAN" ("Transforming growth factor beta-2" "TGF-beta-2" "BSC-1 cell growth inhibitor" "Cetermin" "Glioblastoma-derived T-cell suppressor factor" "G-TSF" "Polyergin"))
(define-protein "TGFR1_HUMAN" ("TGF-beta receptor type-1" "TGFR-1" "Activin A receptor type II-like protein kinase of 53kD" "Activin receptor-like kinase 5" "ALK-5" "ALK5" "Serine/threonine-protein kinase receptor R4" "SKR4" "TGF-beta type I receptor" "Transforming growth factor-beta receptor type I" "TGF-beta receptor type I" "TbetaR-I"))
(define-protein "TGFR2_HUMAN" ("TGF-beta receptor type-2" "TGFR-2" "TGF-beta type II receptor" "Transforming growth factor-beta receptor type II" "TGF-beta receptor type II" "TbetaR-II"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "TGM2_HUMAN" ("Protein-glutamine gamma-glutamyltransferase 2" "Tissue transglutaminase" "Transglutaminase C" "TG(C)" "TGC" "TGase C" "Transglutaminase H" "TGase H" "Transglutaminase-2" "TGase-2"))
<<<<<<< .mine
(define-protein "TGON2_HUMAN" ("tgn" "Trans-Golgi network integral membrane protein 2" "TGN38 homolog" "TGN46" "TGN48" "Trans-Golgi network protein TGN51"))
(define-protein "THG1_HUMAN" ("foci" "Probable tRNA(His) guanylyltransferase" "Interphase cytoplasmic foci protein 45" "tRNA-histidine guanylyltransferase"))
(define-protein "THIC_HUMAN" ("acetyl-CoA" "Acetyl-CoA acetyltransferase, cytosolic" "Acetyl-CoA transferase-like protein" "Cytosolic acetoacetyl-CoA thiolase"))
(define-protein "THRB_HUMAN" ("prothrombin" "Prothrombin" "Coagulation factor II"))
(define-protein "TIAM1_HUMAN" ("Ras-binding" "T-lymphoma invasion and metastasis-inducing protein 1" "TIAM-1"))
(define-protein "TIAR_HUMAN" ("tiar" "Nucleolysin TIAR" "TIA-1-related protein"))
=======
<<<<<<< .mine
(define-protein "TGON2_HUMAN" ("tgn" "Trans-Golgi network integral membrane protein 2" "TGN38 homolog" "TGN46" "TGN48" "Trans-Golgi network protein TGN51"))
(define-protein "THG1_HUMAN" ("foci" "Probable tRNA(His) guanylyltransferase" "Interphase cytoplasmic foci protein 45" "tRNA-histidine guanylyltransferase"))
(define-protein "THIC_HUMAN" ("acetyl-CoA" "Acetyl-CoA acetyltransferase, cytosolic" "Acetyl-CoA transferase-like protein" "Cytosolic acetoacetyl-CoA thiolase"))
(define-protein "THRB_HUMAN" ("prothrombin" "Prothrombin" "Coagulation factor II"))
(define-protein "TIAM1_HUMAN" ("Ras-binding" "T-lymphoma invasion and metastasis-inducing protein 1" "TIAM-1"))
(define-protein "TIAR_HUMAN" ("tiar" "Nucleolysin TIAR" "TIA-1-related protein"))
=======
(define-protein "TGON2_HUMAN" ("Trans-Golgi network integral membrane protein 2" "TGN38 homolog" "TGN46" "TGN48" "Trans-Golgi network protein TGN51"))
(define-protein "THG1_HUMAN" ("Probable tRNA(His) guanylyltransferase" "Interphase cytoplasmic foci protein 45" "tRNA-histidine guanylyltransferase"))
(define-protein "THIC_HUMAN" ("Acetyl-CoA acetyltransferase, cytosolic" "Acetyl-CoA transferase-like protein" "Cytosolic acetoacetyl-CoA thiolase"))
(define-protein "THRB_HUMAN" ("Prothrombin" "Coagulation factor II"))
(define-protein "TIAM1_HUMAN" ("T-lymphoma invasion and metastasis-inducing protein 1" "TIAM-1"))
(define-protein "TIAR_HUMAN" ("Nucleolysin TIAR" "TIA-1-related protein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "TIF1A_HUMAN" ("RNF82" "TIF1-alpha" "TRIM24" "TIF1" "TIF1A")) 
(define-protein "TIF1B_HUMAN" ("KRIP-1" "RNF96" "TRIM28" "KAP1" "KAP-1" "TIF1B" "TIF1-beta")) 
<<<<<<< .mine
(define-protein "TIMP2_HUMAN" ("metalloproteinases" "Metalloproteinase inhibitor 2" "CSC-21K" "Tissue inhibitor of metalloproteinases 2" "TIMP-2"))
(define-protein "TISD_HUMAN" ("glucocorticoids" "Zinc finger protein 36, C3H1 type-like 2" "ZFP36-like 2" "Butyrate response factor 2" "EGF-response factor 2" "ERF-2" "Protein TIS11D"))
(define-protein "TLE1_HUMAN" ("groucho" "Transducin-like enhancer protein 1" "E(Sp1) homolog" "Enhancer of split groucho-like protein 1" "ESG1"))
(define-protein "TLK1_HUMAN" ("tlk" "Serine/threonine-protein kinase tousled-like 1" "PKU-beta" "Tousled-like kinase 1"))
(define-protein "TLN1_HUMAN" ("talin-1" "Talin-1"))
=======
<<<<<<< .mine
(define-protein "TIMP2_HUMAN" ("metalloproteinases" "Metalloproteinase inhibitor 2" "CSC-21K" "Tissue inhibitor of metalloproteinases 2" "TIMP-2"))
(define-protein "TISD_HUMAN" ("glucocorticoids" "Zinc finger protein 36, C3H1 type-like 2" "ZFP36-like 2" "Butyrate response factor 2" "EGF-response factor 2" "ERF-2" "Protein TIS11D"))
(define-protein "TLE1_HUMAN" ("groucho" "Transducin-like enhancer protein 1" "E(Sp1) homolog" "Enhancer of split groucho-like protein 1" "ESG1"))
(define-protein "TLK1_HUMAN" ("tlk" "Serine/threonine-protein kinase tousled-like 1" "PKU-beta" "Tousled-like kinase 1"))
(define-protein "TLN1_HUMAN" ("talin-1" "Talin-1"))
=======
(define-protein "TIMP2_HUMAN" ("Metalloproteinase inhibitor 2" "CSC-21K" "Tissue inhibitor of metalloproteinases 2" "TIMP-2"))
(define-protein "TISD_HUMAN" ("Zinc finger protein 36, C3H1 type-like 2" "ZFP36-like 2" "Butyrate response factor 2" "EGF-response factor 2" "ERF-2" "Protein TIS11D"))
(define-protein "TLE1_HUMAN" ("Transducin-like enhancer protein 1" "E(Sp1) homolog" "Enhancer of split groucho-like protein 1" "ESG1"))
(define-protein "TLK1_HUMAN" ("Serine/threonine-protein kinase tousled-like 1" "PKU-beta" "Tousled-like kinase 1"))
(define-protein "TLN1_HUMAN" ("Talin-1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "TLN2_HUMAN" ("TLN2" "KIAA0320")) 
(define-protein "TLR2_HUMAN" ("TIL4" "CD282" "TLR2")) 
(define-protein "TLR9_HUMAN" ("CD289" "TLR9")) 
(define-protein "TM109_HUMAN" ("Mitsugumin-23" "TMEM109" "Mg23")) 
<<<<<<< .mine
(define-protein "TM129_HUMAN" ("shrna" "E3 ubiquitin-protein ligase TM129"))
=======
<<<<<<< .mine
(define-protein "TM129_HUMAN" ("shrna" "E3 ubiquitin-protein ligase TM129"))
=======
(define-protein "TM129_HUMAN" ("E3 ubiquitin-protein ligase TM129"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "TM252_HUMAN" ("TMEM252" "C9orf71")) 
(define-protein "TM9S1_HUMAN" ("TM9SF1" "hMP70")) 
(define-protein "TMA7_HUMAN" ("CCDC72" "TMA7")) 
(define-protein "TMED1_HUMAN" ("p24gamma1" "IL1RL1L" "IL1RL1LG" "Tp24" "TMED1")) 
<<<<<<< .mine
(define-protein "TMED2_HUMAN" ("copi" "Transmembrane emp24 domain-containing protein 2" "Membrane protein p24A" "p24" "p24 family protein beta-1" "p24beta1"))
=======
<<<<<<< .mine
(define-protein "TMED2_HUMAN" ("copi" "Transmembrane emp24 domain-containing protein 2" "Membrane protein p24A" "p24" "p24 family protein beta-1" "p24beta1"))
=======
(define-protein "TMED2_HUMAN" ("Transmembrane emp24 domain-containing protein 2" "Membrane protein p24A" "p24" "p24 family protein beta-1" "p24beta1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "TMED9_HUMAN" ("Transmembrane emp24 domain-containing protein 9" "GMP25" "Glycoprotein 25L2" "p24 family protein alpha-2" "p24alpha2" "p25"))
(define-protein "TMM33_HUMAN" ("DB83" "TMEM33")) 
(define-protein "TMOD2_HUMAN" ("NTMOD" "N-Tmod" "TMOD2")) 
(define-protein "TMOD3_HUMAN" ("U-Tmod" "TMOD3")) 
<<<<<<< .mine
(define-protein "TN13B_HUMAN" ("baff" "Tumor necrosis factor ligand superfamily member 13B" "B lymphocyte stimulator" "BLyS" "B-cell-activating factor" "BAFF" "Dendritic cell-derived TNF-like molecule" "TNF- and APOL-related leukocyte expressed ligand 1" "TALL-1"))
(define-protein "TNAP3_HUMAN" ("A20" "Tumor necrosis factor alpha-induced protein 3" "TNF alpha-induced protein 3" "OTU domain-containing protein 7C" "Putative DNA-binding protein A20" "Zinc finger protein A20"))
(define-protein "TNF10_HUMAN" ("APO2" "Tumor necrosis factor ligand superfamily member 10" "Apo-2 ligand" "Apo-2L" "TNF-related apoptosis-inducing ligand" "Protein TRAIL"))
=======
<<<<<<< .mine
(define-protein "TN13B_HUMAN" ("baff" "Tumor necrosis factor ligand superfamily member 13B" "B lymphocyte stimulator" "BLyS" "B-cell-activating factor" "BAFF" "Dendritic cell-derived TNF-like molecule" "TNF- and APOL-related leukocyte expressed ligand 1" "TALL-1"))
(define-protein "TNAP3_HUMAN" ("A20" "Tumor necrosis factor alpha-induced protein 3" "TNF alpha-induced protein 3" "OTU domain-containing protein 7C" "Putative DNA-binding protein A20" "Zinc finger protein A20"))
(define-protein "TNF10_HUMAN" ("APO2" "Tumor necrosis factor ligand superfamily member 10" "Apo-2 ligand" "Apo-2L" "TNF-related apoptosis-inducing ligand" "Protein TRAIL"))
=======
(define-protein "TN13B_HUMAN" ("Tumor necrosis factor ligand superfamily member 13B" "B lymphocyte stimulator" "BLyS" "B-cell-activating factor" "BAFF" "Dendritic cell-derived TNF-like molecule" "TNF- and APOL-related leukocyte expressed ligand 1" "TALL-1"))
(define-protein "TNAP3_HUMAN" ("Tumor necrosis factor alpha-induced protein 3" "TNF alpha-induced protein 3" "OTU domain-containing protein 7C" "Putative DNA-binding protein A20" "Zinc finger protein A20"))
(define-protein "TNF10_HUMAN" ("Tumor necrosis factor ligand superfamily member 10" "Apo-2 ligand" "Apo-2L" "TNF-related apoptosis-inducing ligand" "Protein TRAIL"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "TNFA_HUMAN" ("ICD2" "ICD1" "TNFA" "Cachectin" "NTF" "TNFSF2" "TNF-a" "TNF" "TNF-alpha")) 
(define-protein "TNFA_HUMAN" ("Tumor necrosis factor" "Cachectin" "TNF-alpha" "Tumor necrosis factor ligand superfamily member 2" "TNF-a"))
<<<<<<< .mine
(define-protein "TNFL6_HUMAN" ("apl" "Tumor necrosis factor ligand superfamily member 6" "Apoptosis antigen ligand" "APTL" "CD95 ligand" "CD95-L" "Fas antigen ligand" "Fas ligand" "FasL"))
(define-protein "TNIP1_HUMAN" ("ABIN1" "TNFAIP3-interacting protein 1" "A20-binding inhibitor of NF-kappa-B activation 1" "ABIN-1" "HIV-1 Nef-interacting protein" "Nef-associated factor 1" "Naf1" "Nip40-1" "Virion-associated nuclear shuttling protein" "VAN" "hVAN"))
(define-protein "TNIP2_HUMAN" ("factor-κB" "TNFAIP3-interacting protein 2" "A20-binding inhibitor of NF-kappa-B activation 2" "ABIN-2" "Fetal liver LKB1-interacting protein"))
=======
<<<<<<< .mine
(define-protein "TNFL6_HUMAN" ("apl" "Tumor necrosis factor ligand superfamily member 6" "Apoptosis antigen ligand" "APTL" "CD95 ligand" "CD95-L" "Fas antigen ligand" "Fas ligand" "FasL"))
(define-protein "TNIP1_HUMAN" ("ABIN1" "TNFAIP3-interacting protein 1" "A20-binding inhibitor of NF-kappa-B activation 1" "ABIN-1" "HIV-1 Nef-interacting protein" "Nef-associated factor 1" "Naf1" "Nip40-1" "Virion-associated nuclear shuttling protein" "VAN" "hVAN"))
(define-protein "TNIP2_HUMAN" ("factor-κB" "TNFAIP3-interacting protein 2" "A20-binding inhibitor of NF-kappa-B activation 2" "ABIN-2" "Fetal liver LKB1-interacting protein"))
=======
(define-protein "TNFL6_HUMAN" ("Tumor necrosis factor ligand superfamily member 6" "Apoptosis antigen ligand" "APTL" "CD95 ligand" "CD95-L" "Fas antigen ligand" "Fas ligand" "FasL"))
(define-protein "TNIP1_HUMAN" ("TNFAIP3-interacting protein 1" "A20-binding inhibitor of NF-kappa-B activation 1" "ABIN-1" "HIV-1 Nef-interacting protein" "Nef-associated factor 1" "Naf1" "Nip40-1" "Virion-associated nuclear shuttling protein" "VAN" "hVAN"))
(define-protein "TNIP2_HUMAN" ("TNFAIP3-interacting protein 2" "A20-binding inhibitor of NF-kappa-B activation 2" "ABIN-2" "Fetal liver LKB1-interacting protein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "TNK1_HUMAN" ("TNK1")) 
<<<<<<< .mine
(define-protein "TNR1B_HUMAN" ("tnfr" "Tumor necrosis factor receptor superfamily member 1B" "Tumor necrosis factor receptor 2" "TNF-R2" "Tumor necrosis factor receptor type II" "TNF-RII" "TNFR-II" "p75" "p80 TNF-alpha receptor"))
(define-protein "TOLIP_HUMAN" ("IL-1RI" "Toll-interacting protein"))
=======
<<<<<<< .mine
(define-protein "TNR1B_HUMAN" ("tnfr" "Tumor necrosis factor receptor superfamily member 1B" "Tumor necrosis factor receptor 2" "TNF-R2" "Tumor necrosis factor receptor type II" "TNF-RII" "TNFR-II" "p75" "p80 TNF-alpha receptor"))
(define-protein "TOLIP_HUMAN" ("IL-1RI" "Toll-interacting protein"))
=======
(define-protein "TNR1B_HUMAN" ("Tumor necrosis factor receptor superfamily member 1B" "Tumor necrosis factor receptor 2" "TNF-R2" "Tumor necrosis factor receptor type II" "TNF-RII" "TNFR-II" "p75" "p80 TNF-alpha receptor"))
(define-protein "TOLIP_HUMAN" ("Toll-interacting protein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "TOM1_HUMAN" ("TOM1")) 
(define-protein "TOM34_HUMAN" ("URCC3" "hTom34" "TOMM34")) 
(define-protein "TOM70_HUMAN" ("KIAA0719" "TOMM70A" "TOM70")) 
(define-protein "TPD52_HUMAN" ("TPD52")) 
(define-protein "TPD54_HUMAN" ("TPD52L2" "hD54")) 
(define-protein "TPM2_HUMAN" ("TM1" "Tropomyosin beta chain" "Beta-tropomyosin" "Tropomyosin-2"))
(define-protein "TPM2_HUMAN" ("Tropomyosin beta chain" "Beta-tropomyosin" "Tropomyosin-2"))
(define-protein "TPM3_HUMAN" ("hTM5" "TPM3" "Tropomyosin-5" "Tropomyosin-3" "Gamma-tropomyosin")) 
<<<<<<< .mine
(define-protein "TPOR_HUMAN" ("metaplasia" "Thrombopoietin receptor" "TPO-R" "Myeloproliferative leukemia protein" "Proto-oncogene c-Mpl"))
=======
<<<<<<< .mine
(define-protein "TPOR_HUMAN" ("metaplasia" "Thrombopoietin receptor" "TPO-R" "Myeloproliferative leukemia protein" "Proto-oncogene c-Mpl"))
=======
(define-protein "TPOR_HUMAN" ("Thrombopoietin receptor" "TPO-R" "Myeloproliferative leukemia protein" "Proto-oncogene c-Mpl"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "TPPC3_HUMAN" ("BET3" "TRAPPC3")) 
(define-protein "TPPC4_HUMAN" ("Synbindin" "SBDN" "TRAPPC4")) 
(define-protein "TPPC5_HUMAN" ("TRAPPC5")) 
(define-protein "TPR_HUMAN" ("Megator" "TPR")) 
<<<<<<< .mine
(define-protein "TPSNR_HUMAN" ("tapasin" "Tapasin-related protein" "TAPASIN-R" "TAP-binding protein-like" "TAP-binding protein-related protein" "TAPBP-R" "Tapasin-like"))
=======
<<<<<<< .mine
(define-protein "TPSNR_HUMAN" ("tapasin" "Tapasin-related protein" "TAPASIN-R" "TAP-binding protein-like" "TAP-binding protein-related protein" "TAPBP-R" "Tapasin-like"))
=======
(define-protein "TPSNR_HUMAN" ("Tapasin-related protein" "TAPASIN-R" "TAP-binding protein-like" "TAP-binding protein-related protein" "TAPBP-R" "Tapasin-like"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "TPX2_HUMAN" ("p100" "DIL-2" "DIL2" "TPX2" "C20orf2" "C20orf1" "HCA519")) 
<<<<<<< .mine
(define-protein "TR10A_HUMAN" ("Tumor necrosis factor receptor superfamily member 10A" "Death receptor 4" "TNF-related apoptosis-inducing ligand receptor 1" "TRAIL receptor 1" "TRAIL-R1"))
(define-protein "TR10B_HUMAN" ("SW480" "Tumor necrosis factor receptor superfamily member 10B" "Death receptor 5" "TNF-related apoptosis-inducing ligand receptor 2" "TRAIL receptor 2" "TRAIL-R2"))
(define-protein "TRADD_HUMAN" ("tradd" "Tumor necrosis factor receptor type 1-associated DEATH domain protein" "TNFR1-associated DEATH domain protein" "TNFRSF1A-associated via death domain"))
=======
<<<<<<< .mine
(define-protein "TR10A_HUMAN" ("Tumor necrosis factor receptor superfamily member 10A" "Death receptor 4" "TNF-related apoptosis-inducing ligand receptor 1" "TRAIL receptor 1" "TRAIL-R1"))
(define-protein "TR10B_HUMAN" ("SW480" "Tumor necrosis factor receptor superfamily member 10B" "Death receptor 5" "TNF-related apoptosis-inducing ligand receptor 2" "TRAIL receptor 2" "TRAIL-R2"))
(define-protein "TRADD_HUMAN" ("tradd" "Tumor necrosis factor receptor type 1-associated DEATH domain protein" "TNFR1-associated DEATH domain protein" "TNFRSF1A-associated via death domain"))
=======
(define-protein "TR10A_HUMAN" ("Tumor necrosis factor receptor superfamily member 10A" "Death receptor 4" "TNF-related apoptosis-inducing ligand receptor 1" "TRAIL receptor 1" "TRAIL-R1"))
(define-protein "TR10B_HUMAN" ("Tumor necrosis factor receptor superfamily member 10B" "Death receptor 5" "TNF-related apoptosis-inducing ligand receptor 2" "TRAIL receptor 2" "TRAIL-R2"))
(define-protein "TRADD_HUMAN" ("Tumor necrosis factor receptor type 1-associated DEATH domain protein" "TNFR1-associated DEATH domain protein" "TNFRSF1A-associated via death domain"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "TRAF1_HUMAN" ("TNF receptor-associated factor 1" "Epstein-Barr virus-induced protein 6"))
(define-protein "TRAF3_HUMAN" ("TNF receptor-associated factor 3" "CAP-1" "CD40 receptor-associated factor 1" "CRAF1" "CD40-binding protein" "CD40BP" "LMP1-associated protein 1" "LAP1"))
(define-protein "TRAF3_HUMAN" ("Triad3A" "TNF receptor-associated factor 3" "CAP-1" "CD40 receptor-associated factor 1" "CRAF1" "CD40-binding protein" "CD40BP" "LMP1-associated protein 1" "LAP1"))
(define-protein "TRAF6_HUMAN" ("TNF receptor-associated factor 6" "E3 ubiquitin-protein ligase TRAF6" "Interleukin-1 signal transducer" "RING finger protein 85"))
(define-protein "TRAF6_HUMAN" ("TRAF6" "RNF85")) 
<<<<<<< .mine
(define-protein "TRBM_HUMAN" ("thbd" "Thrombomodulin" "TM" "Fetomodulin"))
(define-protein "TREM1_HUMAN" ("monocytes" "Triggering receptor expressed on myeloid cells 1" "TREM-1" "Triggering receptor expressed on monocytes 1"))
(define-protein "TRFL_HUMAN" ("ltf" "Lactotransferrin" "Lactoferrin" "Growth-inhibiting protein 12" "Talalactoferrin"))
=======
<<<<<<< .mine
(define-protein "TRBM_HUMAN" ("thbd" "Thrombomodulin" "TM" "Fetomodulin"))
(define-protein "TREM1_HUMAN" ("monocytes" "Triggering receptor expressed on myeloid cells 1" "TREM-1" "Triggering receptor expressed on monocytes 1"))
(define-protein "TRFL_HUMAN" ("ltf" "Lactotransferrin" "Lactoferrin" "Growth-inhibiting protein 12" "Talalactoferrin"))
=======
(define-protein "TRBM_HUMAN" ("Thrombomodulin" "TM" "Fetomodulin"))
(define-protein "TREM1_HUMAN" ("Triggering receptor expressed on myeloid cells 1" "TREM-1" "Triggering receptor expressed on monocytes 1"))
(define-protein "TRFL_HUMAN" ("Lactotransferrin" "Lactoferrin" "Growth-inhibiting protein 12" "Talalactoferrin"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "TRI44_HUMAN" ("TRIM44" "DIPB")) 
(define-protein "TRI63_HUMAN" ("E3 ubiquitin-protein ligase TRIM63" "Iris RING finger protein" "Muscle-specific RING finger protein 1" "MuRF-1" "MuRF1" "RING finger protein 28" "Striated muscle RING zinc finger protein" "Tripartite motif-containing protein 63"))
(define-protein "TRMB_HUMAN" ("tRNA (guanine-N(7)-)-methyltransferase" "Methyltransferase-like protein 1" "tRNA (guanine(46)-N(7))-methyltransferase" "tRNA(m7G46)-methyltransferase"))
(define-protein "TRPM7_HUMAN" ("Transient receptor potential cation channel subfamily M member 7" "Channel-kinase 1" "Long transient receptor potential channel 7" "LTrpC-7" "LTrpC7"))
<<<<<<< .mine
(define-protein "TRPM8_HUMAN" ("P8" "Transient receptor potential cation channel subfamily M member 8" "Long transient receptor potential channel 6" "LTrpC-6" "LTrpC6" "Transient receptor potential p8" "Trp-p8"))
=======
<<<<<<< .mine
(define-protein "TRPM8_HUMAN" ("P8" "Transient receptor potential cation channel subfamily M member 8" "Long transient receptor potential channel 6" "LTrpC-6" "LTrpC6" "Transient receptor potential p8" "Trp-p8"))
=======
(define-protein "TRPM8_HUMAN" ("Transient receptor potential cation channel subfamily M member 8" "Long transient receptor potential channel 6" "LTrpC-6" "LTrpC6" "Transient receptor potential p8" "Trp-p8"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "TRPV1_HUMAN" ("Transient receptor potential cation channel subfamily V member 1" "TrpV1" "Capsaicin receptor" "Osm-9-like TRP channel 1" "OTRPC1" "Vanilloid receptor 1"))
(define-protein "TRRAP_HUMAN" ("TRRAP" "PAF400" "STAF40" "PAF350/400")) 
(define-protein "TRXR1_HUMAN" ("Thioredoxin reductase 1, cytoplasmic" "TR" "Gene associated with retinoic and interferon-induced mortality 12 protein" "GRIM-12" "Gene associated with retinoic and IFN-induced mortality 12 protein" "KM-102-derived reductase-like factor" "Thioredoxin reductase TR1"))
(define-protein "TRXR1_HUMAN" ("TrxR1" "Thioredoxin reductase 1, cytoplasmic" "TR" "Gene associated with retinoic and interferon-induced mortality 12 protein" "GRIM-12" "Gene associated with retinoic and IFN-induced mortality 12 protein" "KM-102-derived reductase-like factor" "Thioredoxin reductase TR1"))
(define-protein "TS101_HUMAN" ("TSG101")) 
(define-protein "TSC1_HUMAN" ("KIAA0243" "TSC" "TSC1")) 
<<<<<<< .mine
(define-protein "TSC2_HUMAN" ("tuberin" "Tuberin" "Tuberous sclerosis 2 protein"))
=======
<<<<<<< .mine
(define-protein "TSC2_HUMAN" ("tuberin" "Tuberin" "Tuberous sclerosis 2 protein"))
=======
(define-protein "TSC2_HUMAN" ("Tuberin" "Tuberous sclerosis 2 protein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "TSN8_HUMAN" ("TM4SF3" "Tspan-8" "TSPAN8")) 
<<<<<<< .mine
(define-protein "TSTD1_HUMAN" ("MDA-MB468" "Thiosulfate sulfurtransferase/rhodanese-like domain-containing protein 1"))
(define-protein "TT39A_HUMAN" ("MCF7" "Tetratricopeptide repeat protein 39A" "TPR repeat protein 39A" "Differentially expressed in MCF7 with estradiol protein 6" "DEME-6"))
=======
<<<<<<< .mine
(define-protein "TSTD1_HUMAN" ("MDA-MB468" "Thiosulfate sulfurtransferase/rhodanese-like domain-containing protein 1"))
(define-protein "TT39A_HUMAN" ("MCF7" "Tetratricopeptide repeat protein 39A" "TPR repeat protein 39A" "Differentially expressed in MCF7 with estradiol protein 6" "DEME-6"))
=======
(define-protein "TSTD1_HUMAN" ("Thiosulfate sulfurtransferase/rhodanese-like domain-containing protein 1"))
(define-protein "TT39A_HUMAN" ("Tetratricopeptide repeat protein 39A" "TPR repeat protein 39A" "Differentially expressed in MCF7 with estradiol protein 6" "DEME-6"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "TT39B_HUMAN" ("TTC39B" "C9orf52")) 
(define-protein "TTC19_HUMAN" ("TTC19")) 
(define-protein "TTC1_HUMAN" ("TPR1" "TTC1")) 
(define-protein "TTI1_HUMAN" ("SMG10" "TTI1" "KIAA0406")) 
<<<<<<< .mine
(define-protein "TTK_HUMAN" ("SP600125" "Dual specificity protein kinase TTK" "Phosphotyrosine picked threonine-protein kinase" "PYT"))
=======
<<<<<<< .mine
(define-protein "TTK_HUMAN" ("SP600125" "Dual specificity protein kinase TTK" "Phosphotyrosine picked threonine-protein kinase" "PYT"))
=======
(define-protein "TTK_HUMAN" ("Dual specificity protein kinase TTK" "Phosphotyrosine picked threonine-protein kinase" "PYT"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "TTLL7_HUMAN" ("TTLL7")) 
<<<<<<< .mine
(define-protein "TWST1_HUMAN" ("twist-1" "Twist-related protein 1" "Class A basic helix-loop-helix protein 38" "bHLHa38" "H-twist"))
=======
<<<<<<< .mine
(define-protein "TWST1_HUMAN" ("twist-1" "Twist-related protein 1" "Class A basic helix-loop-helix protein 38" "bHLHa38" "H-twist"))
=======
(define-protein "TWST1_HUMAN" ("Twist-related protein 1" "Class A basic helix-loop-helix protein 38" "bHLHa38" "H-twist"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "TXLNA_HUMAN" ("TXLNA" "TXLN")) 
(define-protein "TXLNG_HUMAN" ("TXLNG" "FIAT" "LSR5" "CXorf15" "ELRG")) 
<<<<<<< .mine
(define-protein "TXNIP_HUMAN" ("txnip" "Thioredoxin-interacting protein" "Thioredoxin-binding protein 2" "Vitamin D3 up-regulated protein 1"))
=======
<<<<<<< .mine
(define-protein "TXNIP_HUMAN" ("txnip" "Thioredoxin-interacting protein" "Thioredoxin-binding protein 2" "Vitamin D3 up-regulated protein 1"))
=======
(define-protein "TXNIP_HUMAN" ("Thioredoxin-interacting protein" "Thioredoxin-binding protein 2" "Vitamin D3 up-regulated protein 1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "TXTP_HUMAN" ("SLC20A3" "CTP" "SLC25A1")) 
<<<<<<< .mine
(define-protein "TYDP2_HUMAN" ("ttrap" "Tyrosyl-DNA phosphodiesterase 2" "Tyr-DNA phosphodiesterase 2" "hTDP2" "5'-tyrosyl-DNA phosphodiesterase" "5'-Tyr-DNA phosphodiesterase" "ETS1-associated protein 2" "ETS1-associated protein II" "EAPII" "TRAF and TNF receptor-associated protein" "Tyrosyl-RNA phosphodiesterase" "VPg unlinkase"))
(define-protein "TYK2_HUMAN" ("Tyk2" "Non-receptor tyrosine-protein kinase TYK2"))
=======
<<<<<<< .mine
(define-protein "TYDP2_HUMAN" ("ttrap" "Tyrosyl-DNA phosphodiesterase 2" "Tyr-DNA phosphodiesterase 2" "hTDP2" "5'-tyrosyl-DNA phosphodiesterase" "5'-Tyr-DNA phosphodiesterase" "ETS1-associated protein 2" "ETS1-associated protein II" "EAPII" "TRAF and TNF receptor-associated protein" "Tyrosyl-RNA phosphodiesterase" "VPg unlinkase"))
(define-protein "TYK2_HUMAN" ("Tyk2" "Non-receptor tyrosine-protein kinase TYK2"))
=======
(define-protein "TYDP2_HUMAN" ("Tyrosyl-DNA phosphodiesterase 2" "Tyr-DNA phosphodiesterase 2" "hTDP2" "5'-tyrosyl-DNA phosphodiesterase" "5'-Tyr-DNA phosphodiesterase" "ETS1-associated protein 2" "ETS1-associated protein II" "EAPII" "TRAF and TNF receptor-associated protein" "Tyrosyl-RNA phosphodiesterase" "VPg unlinkase"))
(define-protein "TYK2_HUMAN" ("Non-receptor tyrosine-protein kinase TYK2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "TYRP2_HUMAN" ("L-dopachrome tautomerase" "DCT" "DT" "L-dopachrome Delta-isomerase" "Tyrosinase-related protein 2" "TRP-2" "TRP2"))
(define-protein "TYY1_HUMAN" ("Du145" "Transcriptional repressor protein YY1" "Delta transcription factor" "INO80 complex subunit S" "NF-E1" "Yin and yang 1" "YY-1"))
(define-protein "TYY1_HUMAN" ("Transcriptional repressor protein YY1" "Delta transcription factor" "INO80 complex subunit S" "NF-E1" "Yin and yang 1" "YY-1"))
(define-protein "UB2D1_HUMAN" ("Ubc5" "Ubiquitin-conjugating enzyme E2 D1" "Stimulator of Fe transport" "SFT" "UBC4/5 homolog" "UbcH5" "Ubiquitin carrier protein D1" "Ubiquitin-conjugating enzyme E2(17)KB 1" "Ubiquitin-conjugating enzyme E2-17 kDa 1" "Ubiquitin-protein ligase D1"))
(define-protein "UB2D1_HUMAN" ("Ubiquitin-conjugating enzyme E2 D1" "Stimulator of Fe transport" "SFT" "UBC4/5 homolog" "UbcH5" "Ubiquitin carrier protein D1" "Ubiquitin-conjugating enzyme E2(17)KB 1" "Ubiquitin-conjugating enzyme E2-17 kDa 1" "Ubiquitin-protein ligase D1"))
<<<<<<< .mine
(define-protein "UB2D2_HUMAN" ("ubiquitin-" "Ubiquitin-conjugating enzyme E2 D2" "Ubiquitin carrier protein D2" "Ubiquitin-conjugating enzyme E2(17)KB 2" "Ubiquitin-conjugating enzyme E2-17 kDa 2" "Ubiquitin-protein ligase D2" "p53-regulated ubiquitin-conjugating enzyme 1"))
(define-protein "UB2D3_HUMAN" ("D3" "Ubiquitin-conjugating enzyme E2 D3" "Ubiquitin carrier protein D3" "Ubiquitin-conjugating enzyme E2(17)KB 3" "Ubiquitin-conjugating enzyme E2-17 kDa 3" "Ubiquitin-protein ligase D3"))
(define-protein "UB2J1_HUMAN" ("J-1" "Ubiquitin-conjugating enzyme E2 J1" "Non-canonical ubiquitin-conjugating enzyme 1" "NCUBE-1" "Yeast ubiquitin-conjugating enzyme UBC6 homolog E" "HsUBC6e"))
=======
<<<<<<< .mine
(define-protein "UB2D2_HUMAN" ("ubiquitin-" "Ubiquitin-conjugating enzyme E2 D2" "Ubiquitin carrier protein D2" "Ubiquitin-conjugating enzyme E2(17)KB 2" "Ubiquitin-conjugating enzyme E2-17 kDa 2" "Ubiquitin-protein ligase D2" "p53-regulated ubiquitin-conjugating enzyme 1"))
(define-protein "UB2D3_HUMAN" ("D3" "Ubiquitin-conjugating enzyme E2 D3" "Ubiquitin carrier protein D3" "Ubiquitin-conjugating enzyme E2(17)KB 3" "Ubiquitin-conjugating enzyme E2-17 kDa 3" "Ubiquitin-protein ligase D3"))
(define-protein "UB2J1_HUMAN" ("J-1" "Ubiquitin-conjugating enzyme E2 J1" "Non-canonical ubiquitin-conjugating enzyme 1" "NCUBE-1" "Yeast ubiquitin-conjugating enzyme UBC6 homolog E" "HsUBC6e"))
=======
(define-protein "UB2D2_HUMAN" ("Ubiquitin-conjugating enzyme E2 D2" "Ubiquitin carrier protein D2" "Ubiquitin-conjugating enzyme E2(17)KB 2" "Ubiquitin-conjugating enzyme E2-17 kDa 2" "Ubiquitin-protein ligase D2" "p53-regulated ubiquitin-conjugating enzyme 1"))
(define-protein "UB2D3_HUMAN" ("Ubiquitin-conjugating enzyme E2 D3" "Ubiquitin carrier protein D3" "Ubiquitin-conjugating enzyme E2(17)KB 3" "Ubiquitin-conjugating enzyme E2-17 kDa 3" "Ubiquitin-protein ligase D3"))
(define-protein "UB2J1_HUMAN" ("Ubiquitin-conjugating enzyme E2 J1" "Non-canonical ubiquitin-conjugating enzyme 1" "NCUBE-1" "Yeast ubiquitin-conjugating enzyme UBC6 homolog E" "HsUBC6e"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "UB2R1_HUMAN" ("Ubiquitin-conjugating enzyme E2 R1" "Ubiquitin-conjugating enzyme E2-32 kDa complementing" "Ubiquitin-conjugating enzyme E2-CDC34" "Ubiquitin-protein ligase R1"))
<<<<<<< .mine
(define-protein "UB2R2_HUMAN" ("R2" "Ubiquitin-conjugating enzyme E2 R2" "Ubiquitin carrier protein R2" "Ubiquitin-conjugating enzyme E2-CDC34B" "Ubiquitin-protein ligase R2"))
(define-protein "UB2V1_HUMAN" ("Uev1A" "Ubiquitin-conjugating enzyme E2 variant 1" "UEV-1" "CROC-1" "TRAF6-regulated IKK activator 1 beta Uev1A"))
(define-protein "UBA1_HUMAN" ("uba" "Ubiquitin-like modifier-activating enzyme 1" "Protein A1S9" "Ubiquitin-activating enzyme E1"))
(define-protein "UBC9_HUMAN" ("Ubc9" "SUMO-conjugating enzyme UBC9" "SUMO-protein ligase" "Ubiquitin carrier protein 9" "Ubiquitin carrier protein I" "Ubiquitin-conjugating enzyme E2 I" "Ubiquitin-protein ligase I" "p18"))
=======
<<<<<<< .mine
(define-protein "UB2R2_HUMAN" ("R2" "Ubiquitin-conjugating enzyme E2 R2" "Ubiquitin carrier protein R2" "Ubiquitin-conjugating enzyme E2-CDC34B" "Ubiquitin-protein ligase R2"))
(define-protein "UB2V1_HUMAN" ("Uev1A" "Ubiquitin-conjugating enzyme E2 variant 1" "UEV-1" "CROC-1" "TRAF6-regulated IKK activator 1 beta Uev1A"))
(define-protein "UBA1_HUMAN" ("uba" "Ubiquitin-like modifier-activating enzyme 1" "Protein A1S9" "Ubiquitin-activating enzyme E1"))
(define-protein "UBC9_HUMAN" ("Ubc9" "SUMO-conjugating enzyme UBC9" "SUMO-protein ligase" "Ubiquitin carrier protein 9" "Ubiquitin carrier protein I" "Ubiquitin-conjugating enzyme E2 I" "Ubiquitin-protein ligase I" "p18"))
=======
(define-protein "UB2R2_HUMAN" ("Ubiquitin-conjugating enzyme E2 R2" "Ubiquitin carrier protein R2" "Ubiquitin-conjugating enzyme E2-CDC34B" "Ubiquitin-protein ligase R2"))
(define-protein "UB2V1_HUMAN" ("Ubiquitin-conjugating enzyme E2 variant 1" "UEV-1" "CROC-1" "TRAF6-regulated IKK activator 1 beta Uev1A"))
(define-protein "UBA1_HUMAN" ("Ubiquitin-like modifier-activating enzyme 1" "Protein A1S9" "Ubiquitin-activating enzyme E1"))
(define-protein "UBC9_HUMAN" ("SUMO-conjugating enzyme UBC9" "SUMO-protein ligase" "Ubiquitin carrier protein 9" "Ubiquitin carrier protein I" "Ubiquitin-conjugating enzyme E2 I" "Ubiquitin-protein ligase I" "p18"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "UBC_HUMAN" ("Ubiquitin" "UBC")) 
(define-protein "UBD_HUMAN" ("FAT10" "Diubiquitin" "UBD")) 
(define-protein "UBE2N_HUMAN" ("UbcH13" "Ubc13" "UBE2N" "BLU")) 
(define-protein "UBE2S_HUMAN" ("E2-EPF" "E2EPF" "UBE2S")) 
<<<<<<< .mine
(define-protein "UBP13_HUMAN" ("isot" "Ubiquitin carboxyl-terminal hydrolase 13" "Deubiquitinating enzyme 13" "Isopeptidase T-3" "ISOT-3" "Ubiquitin thioesterase 13" "Ubiquitin-specific-processing protease 13"))
(define-protein "UBP15_HUMAN" ("R-Smads" "Ubiquitin carboxyl-terminal hydrolase 15" "Deubiquitinating enzyme 15" "Ubiquitin thioesterase 15" "Ubiquitin-specific-processing protease 15" "Unph-2" "Unph4"))
=======
<<<<<<< .mine
(define-protein "UBP13_HUMAN" ("isot" "Ubiquitin carboxyl-terminal hydrolase 13" "Deubiquitinating enzyme 13" "Isopeptidase T-3" "ISOT-3" "Ubiquitin thioesterase 13" "Ubiquitin-specific-processing protease 13"))
(define-protein "UBP15_HUMAN" ("R-Smads" "Ubiquitin carboxyl-terminal hydrolase 15" "Deubiquitinating enzyme 15" "Ubiquitin thioesterase 15" "Ubiquitin-specific-processing protease 15" "Unph-2" "Unph4"))
=======
(define-protein "UBP13_HUMAN" ("Ubiquitin carboxyl-terminal hydrolase 13" "Deubiquitinating enzyme 13" "Isopeptidase T-3" "ISOT-3" "Ubiquitin thioesterase 13" "Ubiquitin-specific-processing protease 13"))
(define-protein "UBP15_HUMAN" ("Ubiquitin carboxyl-terminal hydrolase 15" "Deubiquitinating enzyme 15" "Ubiquitin thioesterase 15" "Ubiquitin-specific-processing protease 15" "Unph-2" "Unph4"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "UBP28_HUMAN" ("Ubiquitin carboxyl-terminal hydrolase 28" "Deubiquitinating enzyme 28" "Ubiquitin thioesterase 28" "Ubiquitin-specific-processing protease 28"))
(define-protein "UBP2L_HUMAN" ("Ubiquitin-associated protein 2-like" "Protein NICE-4"))
(define-protein "UBP8_HUMAN" ("hUBPy" "KIAA0055" "UBPY" "USP8")) 
(define-protein "UBQL2_HUMAN" ("Chap1" "hPLIC-2" "UBQLN2" "PLIC-2" "PLIC2" "N4BP4")) 
(define-protein "UCHL3_HUMAN" ("UCHL3" "UCH-L3")) 
<<<<<<< .mine
(define-protein "UCK2_HUMAN" ("uridine" "Uridine-cytidine kinase 2" "UCK 2" "Cytidine monophosphokinase 2" "Testis-specific protein TSA903" "Uridine monophosphokinase 2"))
=======
<<<<<<< .mine
(define-protein "UCK2_HUMAN" ("uridine" "Uridine-cytidine kinase 2" "UCK 2" "Cytidine monophosphokinase 2" "Testis-specific protein TSA903" "Uridine monophosphokinase 2"))
=======
(define-protein "UCK2_HUMAN" ("Uridine-cytidine kinase 2" "UCK 2" "Cytidine monophosphokinase 2" "Testis-specific protein TSA903" "Uridine monophosphokinase 2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "UCP2_HUMAN" ("Mitochondrial uncoupling protein 2" "UCP 2" "Solute carrier family 25 member 8" "UCPH"))
(define-protein "UD110_HUMAN" ("UGT1-10" "UGT1A10" "UGT1" "GNT1" "UGT1J" "UGT-1J" "UGT1.10" "UGT1*10")) 
(define-protein "UD11_HUMAN" ("UGT-1A" "GNT1" "UGT1.1" "UGT1" "UGT1*1" "UGT1A" "UGT1A1" "UGT1-01" "hUG-BR1")) 
(define-protein "UD13_HUMAN" ("UGT-1C" "GNT1" "UGT1.3" "UGT1" "UGT1C" "UGT1A3" "UGT1-03" "UGT1*3")) 
(define-protein "UD16_HUMAN" ("UGT-1F" "UGT1.6" "GNT1" "UGT1" "UGT1F" "UGT1A6" "UGT1-06" "UGT1*6")) 
(define-protein "UD17_HUMAN" ("UGT-1G" "UGT1.7" "GNT1" "UGT1" "UGT1G" "UGT1A7" "UGT1-07" "UGT1*7")) 
(define-protein "UD18_HUMAN" ("UGT-1H" "UGT1.8" "GNT1" "UGT1" "UGT1H" "UGT1A8" "UGT1-08" "UGT1*8")) 
(define-protein "UD19_HUMAN" ("lugP4" "UGT1.9" "GNT1" "UGT1" "UGT1I" "UGT1A9" "UGT1-09" "UGT-1I" "UGT1*9")) 
<<<<<<< .mine
(define-protein "UD2B7_HUMAN" ("2B7" "UDP-glucuronosyltransferase 2B7" "UDPGT 2B7" "3,4-catechol estrogen-specific UDPGT" "UDP-glucuronosyltransferase 2B9" "UDPGT 2B9" "UDPGTh-2"))
=======
<<<<<<< .mine
(define-protein "UD2B7_HUMAN" ("2B7" "UDP-glucuronosyltransferase 2B7" "UDPGT 2B7" "3,4-catechol estrogen-specific UDPGT" "UDP-glucuronosyltransferase 2B9" "UDPGT 2B9" "UDPGTh-2"))
=======
(define-protein "UD2B7_HUMAN" ("UDP-glucuronosyltransferase 2B7" "UDPGT 2B7" "3,4-catechol estrogen-specific UDPGT" "UDP-glucuronosyltransferase 2B9" "UDPGT 2B9" "UDPGTh-2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "UDB11_HUMAN" ("UGT2B11")) 
<<<<<<< .mine
(define-protein "UEVLD_HUMAN" ("ev" "Ubiquitin-conjugating enzyme E2 variant 3" "UEV-3" "EV and lactate/malate dehydrogenase domain-containing protein"))
=======
<<<<<<< .mine
(define-protein "UEVLD_HUMAN" ("ev" "Ubiquitin-conjugating enzyme E2 variant 3" "UEV-3" "EV and lactate/malate dehydrogenase domain-containing protein"))
=======
(define-protein "UEVLD_HUMAN" ("Ubiquitin-conjugating enzyme E2 variant 3" "UEV-3" "EV and lactate/malate dehydrogenase domain-containing protein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "UFC1_HUMAN" ("Ubiquitin-fold modifier-conjugating enzyme 1" "Ufm1-conjugating enzyme 1"))
<<<<<<< .mine
(define-protein "UFO_HUMAN" ("axl" "Tyrosine-protein kinase receptor UFO" "AXL oncogene"))
=======
<<<<<<< .mine
(define-protein "UFO_HUMAN" ("axl" "Tyrosine-protein kinase receptor UFO" "AXL oncogene"))
=======
(define-protein "UFO_HUMAN" ("Tyrosine-protein kinase receptor UFO" "AXL oncogene"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "UHRF1_HUMAN" ("hNp95" "hUHRF1" "NP95" "UHRF1" "HuNp95" "ICBP90" "RNF106")) 
(define-protein "ULK3_HUMAN" ("ULK3")) 
<<<<<<< .mine
(define-protein "UN13B_HUMAN" ("Unc-13" "Protein unc-13 homolog B" "Munc13-2" "munc13"))
=======
<<<<<<< .mine
(define-protein "UN13B_HUMAN" ("Unc-13" "Protein unc-13 homolog B" "Munc13-2" "munc13"))
=======
(define-protein "UN13B_HUMAN" ("Protein unc-13 homolog B" "Munc13-2" "munc13"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "UN93B_HUMAN" ("UNC93B1" "hUNC93B1" "UNC93B" "UNC93" "Unc-93B1")) 
<<<<<<< .mine
(define-protein "UNC50_HUMAN" ("Gea1p" "Protein unc-50 homolog" "Periodontal ligament-specific protein 22" "PDLs22" "Protein GMH1 homolog" "hGMH1" "Uncoordinated-like protein"))
(define-protein "UPP1_HUMAN" ("urdpase1" "Uridine phosphorylase 1" "UPase 1" "UrdPase 1"))
=======
<<<<<<< .mine
(define-protein "UNC50_HUMAN" ("Gea1p" "Protein unc-50 homolog" "Periodontal ligament-specific protein 22" "PDLs22" "Protein GMH1 homolog" "hGMH1" "Uncoordinated-like protein"))
(define-protein "UPP1_HUMAN" ("urdpase1" "Uridine phosphorylase 1" "UPase 1" "UrdPase 1"))
=======
(define-protein "UNC50_HUMAN" ("Protein unc-50 homolog" "Periodontal ligament-specific protein 22" "PDLs22" "Protein GMH1 homolog" "hGMH1" "Uncoordinated-like protein"))
(define-protein "UPP1_HUMAN" ("Uridine phosphorylase 1" "UPase 1" "UrdPase 1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "URGCP_HUMAN" ("URG4" "URGCP" "KIAA1507")) 
(define-protein "USE1_HUMAN" ("p31" "USE1L" "USE1")) 
(define-protein "USH1C_HUMAN" ("USH1C" "AIE75")) 
(define-protein "USO1_HUMAN" ("TAP" "USO1" "VDP")) 
(define-protein "USP9X_HUMAN" ("DFFRX" "FAM" "USP9" "USP9X" "hFAM")) 
<<<<<<< .mine
(define-protein "UTER_HUMAN" ("ccsp" "Uteroglobin" "Clara cell phospholipid-binding protein" "CCPBP" "Clara cells 10 kDa secretory protein" "CC10" "Secretoglobin family 1A member 1" "Urinary protein 1" "UP-1" "UP1" "Urine protein 1"))
=======
<<<<<<< .mine
(define-protein "UTER_HUMAN" ("ccsp" "Uteroglobin" "Clara cell phospholipid-binding protein" "CCPBP" "Clara cells 10 kDa secretory protein" "CC10" "Secretoglobin family 1A member 1" "Urinary protein 1" "UP-1" "UP1" "Urine protein 1"))
=======
(define-protein "UTER_HUMAN" ("Uteroglobin" "Clara cell phospholipid-binding protein" "CCPBP" "Clara cells 10 kDa secretory protein" "CC10" "Secretoglobin family 1A member 1" "Urinary protein 1" "UP-1" "UP1" "Urine protein 1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "UTRO_HUMAN" ("Utrophin" "Dystrophin-related protein 1" "DRP-1"))
<<<<<<< .mine
(define-protein "UVRAG_HUMAN" ("uvrag" "UV radiation resistance-associated gene protein" "p63"))
(define-protein "V9HW48_HUMAN" ("S115" "SH3 domain-binding glutamic acid-rich-like protein"))
(define-protein "V9VHH0_HRSV" ("mcherry" "MCherry"))
=======
<<<<<<< .mine
(define-protein "UVRAG_HUMAN" ("uvrag" "UV radiation resistance-associated gene protein" "p63"))
(define-protein "V9HW48_HUMAN" ("S115" "SH3 domain-binding glutamic acid-rich-like protein"))
(define-protein "V9VHH0_HRSV" ("mcherry" "MCherry"))
=======
(define-protein "UVRAG_HUMAN" ("UV radiation resistance-associated gene protein" "p63"))
(define-protein "V9HW48_HUMAN" ("SH3 domain-binding glutamic acid-rich-like protein"))
(define-protein "V9VHH0_HRSV" ("MCherry"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "VA0D1_HUMAN" ("ATP6D" "p39" "ATP6V0D1" "VPATPD")) 
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
(define-protein "VAV2_HUMAN" ("Guanine nucleotide exchange factor VAV2" "VAV-2"))
<<<<<<< .mine
(define-protein "VCAM1_HUMAN" ("Vcam1" "Vascular cell adhesion protein 1" "V-CAM 1" "VCAM-1" "INCAM-100"))
=======
<<<<<<< .mine
(define-protein "VCAM1_HUMAN" ("Vcam1" "Vascular cell adhesion protein 1" "V-CAM 1" "VCAM-1" "INCAM-100"))
=======
(define-protein "VCAM1_HUMAN" ("Vascular cell adhesion protein 1" "V-CAM 1" "VCAM-1" "INCAM-100"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "VCY1_HUMAN" ("BPY1" "VCY" "VCY1B" "VCY1A" "BPY1B")) 
<<<<<<< .mine
(define-protein "VDAC1_HUMAN" ("31HL" "Voltage-dependent anion-selective channel protein 1" "VDAC-1" "hVDAC1" "Outer mitochondrial membrane protein porin 1" "Plasmalemmal porin" "Porin 31HL" "Porin 31HM"))
=======
<<<<<<< .mine
(define-protein "VDAC1_HUMAN" ("31HL" "Voltage-dependent anion-selective channel protein 1" "VDAC-1" "hVDAC1" "Outer mitochondrial membrane protein porin 1" "Plasmalemmal porin" "Porin 31HL" "Porin 31HM"))
=======
(define-protein "VDAC1_HUMAN" ("Voltage-dependent anion-selective channel protein 1" "VDAC-1" "hVDAC1" "Outer mitochondrial membrane protein porin 1" "Plasmalemmal porin" "Porin 31HL" "Porin 31HM"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "VE2_HPV16" ("Regulatory protein E2"))
(define-protein "VE6_HPV18" ("Protein E6"))
<<<<<<< .mine
(define-protein "VEGFA_HUMAN" ("VEGF121" "Vascular endothelial growth factor A" "VEGF-A" "Vascular permeability factor" "VPF"))
(define-protein "VEGFB_HUMAN" ("vegfb" "Vascular endothelial growth factor B" "VEGF-B" "VEGF-related factor" "VRF"))
(define-protein "VEGFC_HUMAN" ("VEGFC-" "Vascular endothelial growth factor C" "VEGF-C" "Flt4 ligand" "Flt4-L" "Vascular endothelial growth factor-related protein" "VRP"))
(define-protein "VGFR1_HUMAN" ("VEGFR1" "Vascular endothelial growth factor receptor 1" "VEGFR-1" "Fms-like tyrosine kinase 1" "FLT-1" "Tyrosine-protein kinase FRT" "Tyrosine-protein kinase receptor FLT" "FLT" "Vascular permeability factor receptor"))
=======
<<<<<<< .mine
(define-protein "VEGFA_HUMAN" ("VEGF121" "Vascular endothelial growth factor A" "VEGF-A" "Vascular permeability factor" "VPF"))
(define-protein "VEGFB_HUMAN" ("vegfb" "Vascular endothelial growth factor B" "VEGF-B" "VEGF-related factor" "VRF"))
(define-protein "VEGFC_HUMAN" ("VEGFC-" "Vascular endothelial growth factor C" "VEGF-C" "Flt4 ligand" "Flt4-L" "Vascular endothelial growth factor-related protein" "VRP"))
(define-protein "VGFR1_HUMAN" ("VEGFR1" "Vascular endothelial growth factor receptor 1" "VEGFR-1" "Fms-like tyrosine kinase 1" "FLT-1" "Tyrosine-protein kinase FRT" "Tyrosine-protein kinase receptor FLT" "FLT" "Vascular permeability factor receptor"))
=======
(define-protein "VEGFA_HUMAN" ("Vascular endothelial growth factor A" "VEGF-A" "Vascular permeability factor" "VPF"))
(define-protein "VEGFB_HUMAN" ("Vascular endothelial growth factor B" "VEGF-B" "VEGF-related factor" "VRF"))
(define-protein "VEGFC_HUMAN" ("Vascular endothelial growth factor C" "VEGF-C" "Flt4 ligand" "Flt4-L" "Vascular endothelial growth factor-related protein" "VRP"))
(define-protein "VGFR1_HUMAN" ("Vascular endothelial growth factor receptor 1" "VEGFR-1" "Fms-like tyrosine kinase 1" "FLT-1" "Tyrosine-protein kinase FRT" "Tyrosine-protein kinase receptor FLT" "FLT" "Vascular permeability factor receptor"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "VGFR2_HUMAN" ("Vascular endothelial growth factor receptor 2" "VEGFR-2" "Fetal liver kinase 1" "FLK-1" "Kinase insert domain receptor" "KDR" "Protein-tyrosine kinase receptor flk-1"))
<<<<<<< .mine
(define-protein "VHL_HUMAN" ("Hippel–Lindau" "Von Hippel-Lindau disease tumor suppressor" "Protein G7" "pVHL"))
(define-protein "VILI_HUMAN" ("lamellipodia" "Villin-1"))
(define-protein "VINC_HUMAN" ("vinculin" "Vinculin" "Metavinculin" "MV"))
(define-protein "VINEX_HUMAN" ("vinexin-α" "Vinexin" "SH3-containing adapter molecule 1" "SCAM-1" "Sorbin and SH3 domain-containing protein 3"))
=======
<<<<<<< .mine
(define-protein "VHL_HUMAN" ("Hippel–Lindau" "Von Hippel-Lindau disease tumor suppressor" "Protein G7" "pVHL"))
(define-protein "VILI_HUMAN" ("lamellipodia" "Villin-1"))
(define-protein "VINC_HUMAN" ("vinculin" "Vinculin" "Metavinculin" "MV"))
(define-protein "VINEX_HUMAN" ("vinexin-α" "Vinexin" "SH3-containing adapter molecule 1" "SCAM-1" "Sorbin and SH3 domain-containing protein 3"))
=======
(define-protein "VHL_HUMAN" ("Von Hippel-Lindau disease tumor suppressor" "Protein G7" "pVHL"))
(define-protein "VILI_HUMAN" ("Villin-1"))
(define-protein "VINC_HUMAN" ("Vinculin" "Metavinculin" "MV"))
(define-protein "VINEX_HUMAN" ("Vinexin" "SH3-containing adapter molecule 1" "SCAM-1" "Sorbin and SH3 domain-containing protein 3"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "VISL1_HUMAN" ("VILIP" "VSNL1" "VLP-1" "HLP3" "VISL1")) 
<<<<<<< .mine
(define-protein "VKOR1_HUMAN" ("dithiothreitol" "Vitamin K epoxide reductase complex subunit 1" "Vitamin K1 2,3-epoxide reductase subunit 1"))
=======
<<<<<<< .mine
(define-protein "VKOR1_HUMAN" ("dithiothreitol" "Vitamin K epoxide reductase complex subunit 1" "Vitamin K1 2,3-epoxide reductase subunit 1"))
=======
(define-protein "VKOR1_HUMAN" ("Vitamin K epoxide reductase complex subunit 1" "Vitamin K1 2,3-epoxide reductase subunit 1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "VL1_HPV16" ("Major capsid protein L1"))
<<<<<<< .mine
(define-protein "VP16_HHV11" ("VP16-" "Tegument protein VP16" "Alpha trans-inducing protein" "Alpha-TIF" "ICP25" "Vmw65"))
=======
<<<<<<< .mine
(define-protein "VP16_HHV11" ("VP16-" "Tegument protein VP16" "Alpha trans-inducing protein" "Alpha-TIF" "ICP25" "Vmw65"))
=======
(define-protein "VP16_HHV11" ("Tegument protein VP16" "Alpha trans-inducing protein" "Alpha-TIF" "ICP25" "Vmw65"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "VP26A_HUMAN" ("VPS26A" "VPS26" "hVPS26")) 
(define-protein "VP33A_HUMAN" ("VPS33A" "hVPS33A")) 
(define-protein "VP33B_HUMAN" ("VPS33B" "hVPS33B")) 
(define-protein "VP37B_HUMAN" ("hVps37B" "VPS37B")) 
<<<<<<< .mine
(define-protein "VPRBP_HUMAN" ("vprbp" "Protein VPRBP" "DDB1- and CUL4-associated factor 1" "HIV-1 Vpr-binding protein" "VprBP" "Serine/threonine-protein kinase VPRBP" "Vpr-interacting protein"))
=======
<<<<<<< .mine
(define-protein "VPRBP_HUMAN" ("vprbp" "Protein VPRBP" "DDB1- and CUL4-associated factor 1" "HIV-1 Vpr-binding protein" "VprBP" "Serine/threonine-protein kinase VPRBP" "Vpr-interacting protein"))
=======
(define-protein "VPRBP_HUMAN" ("Protein VPRBP" "DDB1- and CUL4-associated factor 1" "HIV-1 Vpr-binding protein" "VprBP" "Serine/threonine-protein kinase VPRBP" "Vpr-interacting protein"))
>>>>>>> .r4470
>>>>>>> .r4471
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
<<<<<<< .mine
(define-protein "VSTM1_HUMAN" ("leukocytes" "V-set and transmembrane domain-containing protein 1" "Signal inhibitory receptor on leukocytes-1" "SIRL-1"))
=======
<<<<<<< .mine
(define-protein "VSTM1_HUMAN" ("leukocytes" "V-set and transmembrane domain-containing protein 1" "Signal inhibitory receptor on leukocytes-1" "SIRL-1"))
=======
(define-protein "VSTM1_HUMAN" ("V-set and transmembrane domain-containing protein 1" "Signal inhibitory receptor on leukocytes-1" "SIRL-1"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "VTA1_HUMAN" ("VTA1" "LIP5" "DRG-1" "SBP1" "C6orf55")) 
(define-protein "VTI1A_HUMAN" ("Vti1-rp2" "VTI1A")) 
<<<<<<< .mine
(define-protein "VTNC_HUMAN" ("vitronectin" "Vitronectin" "VN" "S-protein" "Serum-spreading factor" "V75"))
(define-protein "VWF_HUMAN" ("von" "von Willebrand factor" "vWF"))
(define-protein "W0G7P8_9HIV1" ("S318" "Envelope glycoprotein"))
(define-protein "W1WMX0_9ZZZZ" ("mannitol" "PTS family fructose/mannitol (Fru) porter component IIABC"))
(define-protein "W1XQY5_9ZZZZ" ("C20" "Precorrin-2 C20-methyltransferase"))
(define-protein "W1XTR8_9ZZZZ" ("intimin" "Invasin/intimin protein"))
(define-protein "W1Y3M4_9ZZZZ" ("cations" "Ferric cations import ATP-binding protein FbpC"))
(define-protein "W1Y846_9ZZZZ" ("metr" "HTH-type transcriptional regulator MetR"))
(define-protein "W1YB05_9ZZZZ" ("flga" "Lateral flagellar P-ring addition protein FlgA-like protein"))
(define-protein "W1YCB0_9ZZZZ" ("acetyltransferases" "Acetyltransferases The isoleucine patch superfamily"))
(define-protein "W2T694_NECAM" ("MH1" "MH1 domain protein"))
(define-protein "W2TEH5_NECAM" ("trr" "Histone-lysine N-methyltransferase"))
(define-protein "W2TL63_NECAM" ("SWI3" "Replication Fork Protection Component Swi3"))
(define-protein "W2TQH2_NECAM" ("APH-1" "Aph-1 protein"))
(define-protein "W2TX68_NECAM" ("Gtr1" "Gtr1/RagA G protein conserved region"))
(define-protein "W5S2D8_9PAPI" ("CH2" "Replication protein E1"))
(define-protein "WAP53_HUMAN" ("cajal" "Telomerase Cajal body protein 1" "WD repeat-containing protein 79" "WD repeat-containing protein WRAP53" "WD40 repeat-containing protein antisense to TP53 gene"))
=======
<<<<<<< .mine
(define-protein "VTNC_HUMAN" ("vitronectin" "Vitronectin" "VN" "S-protein" "Serum-spreading factor" "V75"))
(define-protein "VWF_HUMAN" ("von" "von Willebrand factor" "vWF"))
(define-protein "W0G7P8_9HIV1" ("S318" "Envelope glycoprotein"))
(define-protein "W1WMX0_9ZZZZ" ("mannitol" "PTS family fructose/mannitol (Fru) porter component IIABC"))
(define-protein "W1XQY5_9ZZZZ" ("C20" "Precorrin-2 C20-methyltransferase"))
(define-protein "W1XTR8_9ZZZZ" ("intimin" "Invasin/intimin protein"))
(define-protein "W1Y3M4_9ZZZZ" ("cations" "Ferric cations import ATP-binding protein FbpC"))
(define-protein "W1Y846_9ZZZZ" ("metr" "HTH-type transcriptional regulator MetR"))
(define-protein "W1YB05_9ZZZZ" ("flga" "Lateral flagellar P-ring addition protein FlgA-like protein"))
(define-protein "W1YCB0_9ZZZZ" ("acetyltransferases" "Acetyltransferases The isoleucine patch superfamily"))
(define-protein "W2T694_NECAM" ("MH1" "MH1 domain protein"))
(define-protein "W2TEH5_NECAM" ("trr" "Histone-lysine N-methyltransferase"))
(define-protein "W2TL63_NECAM" ("SWI3" "Replication Fork Protection Component Swi3"))
(define-protein "W2TQH2_NECAM" ("APH-1" "Aph-1 protein"))
(define-protein "W2TX68_NECAM" ("Gtr1" "Gtr1/RagA G protein conserved region"))
(define-protein "W5S2D8_9PAPI" ("CH2" "Replication protein E1"))
(define-protein "WAP53_HUMAN" ("cajal" "Telomerase Cajal body protein 1" "WD repeat-containing protein 79" "WD repeat-containing protein WRAP53" "WD40 repeat-containing protein antisense to TP53 gene"))
=======
(define-protein "VTNC_HUMAN" ("Vitronectin" "VN" "S-protein" "Serum-spreading factor" "V75"))
(define-protein "VWF_HUMAN" ("von Willebrand factor" "vWF"))
(define-protein "W0G7P8_9HIV1" ("Envelope glycoprotein"))
(define-protein "W1WMX0_9ZZZZ" ("PTS family fructose/mannitol (Fru) porter component IIABC"))
(define-protein "W1XQY5_9ZZZZ" ("Precorrin-2 C20-methyltransferase"))
(define-protein "W1XTR8_9ZZZZ" ("Invasin/intimin protein"))
(define-protein "W1Y3M4_9ZZZZ" ("Ferric cations import ATP-binding protein FbpC"))
(define-protein "W1Y846_9ZZZZ" ("HTH-type transcriptional regulator MetR"))
(define-protein "W1YB05_9ZZZZ" ("Lateral flagellar P-ring addition protein FlgA-like protein"))
(define-protein "W1YCB0_9ZZZZ" ("Acetyltransferases The isoleucine patch superfamily"))
(define-protein "W2T694_NECAM" ("MH1 domain protein"))
(define-protein "W2TEH5_NECAM" ("Histone-lysine N-methyltransferase"))
(define-protein "W2TL63_NECAM" ("Replication Fork Protection Component Swi3"))
(define-protein "W2TQH2_NECAM" ("Aph-1 protein"))
(define-protein "W2TX68_NECAM" ("Gtr1/RagA G protein conserved region"))
(define-protein "W5S2D8_9PAPI" ("Replication protein E1"))
(define-protein "WAP53_HUMAN" ("Telomerase Cajal body protein 1" "WD repeat-containing protein 79" "WD repeat-containing protein WRAP53" "WD40 repeat-containing protein antisense to TP53 gene"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "WASH2_HUMAN" ("WASH2P" "FAM39B")) 
(define-protein "WASH7_HUMAN" ("SWIP" "KIAA1033")) 
<<<<<<< .mine
(define-protein "WASL_HUMAN" ("icsa" "Neural Wiskott-Aldrich syndrome protein" "N-WASP"))
=======
<<<<<<< .mine
(define-protein "WASL_HUMAN" ("icsa" "Neural Wiskott-Aldrich syndrome protein" "N-WASP"))
=======
(define-protein "WASL_HUMAN" ("Neural Wiskott-Aldrich syndrome protein" "N-WASP"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "WDFY1_HUMAN" ("FENS-1" "ZFYVE17" "WDF1" "KIAA1435" "WDFY1")) 
(define-protein "WDFY3_HUMAN" ("KIAA0993" "Alfy" "WDFY3")) 
(define-protein "WDR26_HUMAN" ("MIP-2" "WD repeat-containing protein 26" "CUL4- and DDB1-associated WDR protein 2" "Myocardial ischemic preconditioning up-regulated protein 2"))
(define-protein "WDR26_HUMAN" ("WD repeat-containing protein 26" "CUL4- and DDB1-associated WDR protein 2" "Myocardial ischemic preconditioning up-regulated protein 2"))
(define-protein "WDR5_HUMAN" ("WDR5" "BIG3")) 
<<<<<<< .mine
(define-protein "WHAMM_HUMAN" ("microtubules" "WASP homolog-associated protein with actin, membranes and microtubules" "WAS protein homology region 2 domain-containing protein 1" "WH2 domain-containing protein 1"))
(define-protein "WIPI1_HUMAN" ("puncta" "WD repeat domain phosphoinositide-interacting protein 1" "WIPI-1" "Atg18 protein homolog" "WD40 repeat protein interacting with phosphoinositides of 49 kDa" "WIPI 49 kDa"))
=======
<<<<<<< .mine
(define-protein "WHAMM_HUMAN" ("microtubules" "WASP homolog-associated protein with actin, membranes and microtubules" "WAS protein homology region 2 domain-containing protein 1" "WH2 domain-containing protein 1"))
(define-protein "WIPI1_HUMAN" ("puncta" "WD repeat domain phosphoinositide-interacting protein 1" "WIPI-1" "Atg18 protein homolog" "WD40 repeat protein interacting with phosphoinositides of 49 kDa" "WIPI 49 kDa"))
=======
(define-protein "WHAMM_HUMAN" ("WASP homolog-associated protein with actin, membranes and microtubules" "WAS protein homology region 2 domain-containing protein 1" "WH2 domain-containing protein 1"))
(define-protein "WIPI1_HUMAN" ("WD repeat domain phosphoinositide-interacting protein 1" "WIPI-1" "Atg18 protein homolog" "WD40 repeat protein interacting with phosphoinositides of 49 kDa" "WIPI 49 kDa"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "WLS_HUMAN" ("GPR177" "C1orf139" "WLS" "EVI")) 
<<<<<<< .mine
(define-protein "WN10A_HUMAN" ("Wnt10a" "Protein Wnt-10a"))
=======
<<<<<<< .mine
(define-protein "WN10A_HUMAN" ("Wnt10a" "Protein Wnt-10a"))
=======
(define-protein "WN10A_HUMAN" ("Protein Wnt-10a"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "WNK1_HUMAN" ("Serine/threonine-protein kinase WNK1" "Erythrocyte 65 kDa protein" "p65" "Kinase deficient protein" "Protein kinase lysine-deficient 1" "Protein kinase with no lysine 1" "hWNK1"))
<<<<<<< .mine
(define-protein "WNT11_HUMAN" ("Wnt11" "Protein Wnt-11"))
=======
<<<<<<< .mine
(define-protein "WNT11_HUMAN" ("Wnt11" "Protein Wnt-11"))
=======
(define-protein "WNT11_HUMAN" ("Protein Wnt-11"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "WNT1_HUMAN" ("Proto-oncogene Wnt-1" "Proto-oncogene Int-1 homolog"))
<<<<<<< .mine
(define-protein "WNT1_HUMAN" ("Wnt1" "Proto-oncogene Wnt-1" "Proto-oncogene Int-1 homolog"))
(define-protein "WNT3A_HUMAN" ("Wnt3a" "Protein Wnt-3a"))
(define-protein "WNT4_HUMAN" ("Wnt4" "Protein Wnt-4"))
(define-protein "WNT6_HUMAN" ("Wnt6" "Protein Wnt-6"))
(define-protein "WNT7A_HUMAN" ("aarrs" "Protein Wnt-7a"))
(define-protein "WNT9B_HUMAN" ("Wnt-" "Protein Wnt-9b" "Protein Wnt-14b" "Protein Wnt-15"))
(define-protein "WT1_HUMAN" ("_WT" "Wilms tumor protein" "WT33"))
=======
<<<<<<< .mine
(define-protein "WNT1_HUMAN" ("Wnt1" "Proto-oncogene Wnt-1" "Proto-oncogene Int-1 homolog"))
(define-protein "WNT3A_HUMAN" ("Wnt3a" "Protein Wnt-3a"))
(define-protein "WNT4_HUMAN" ("Wnt4" "Protein Wnt-4"))
(define-protein "WNT6_HUMAN" ("Wnt6" "Protein Wnt-6"))
(define-protein "WNT7A_HUMAN" ("aarrs" "Protein Wnt-7a"))
(define-protein "WNT9B_HUMAN" ("Wnt-" "Protein Wnt-9b" "Protein Wnt-14b" "Protein Wnt-15"))
(define-protein "WT1_HUMAN" ("_WT" "Wilms tumor protein" "WT33"))
=======
(define-protein "WNT3A_HUMAN" ("Protein Wnt-3a"))
(define-protein "WNT4_HUMAN" ("Protein Wnt-4"))
(define-protein "WNT6_HUMAN" ("Protein Wnt-6"))
(define-protein "WNT7A_HUMAN" ("Protein Wnt-7a"))
(define-protein "WNT9B_HUMAN" ("Protein Wnt-9b" "Protein Wnt-14b" "Protein Wnt-15"))
(define-protein "WT1_HUMAN" ("Wilms tumor protein" "WT33"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "WWC2_HUMAN" ("Protein WWC2" "BH-3-only member B" "WW domain-containing protein 2"))
<<<<<<< .mine
(define-protein "XIAP_HUMAN" ("xiap" "E3 ubiquitin-protein ligase XIAP" "Baculoviral IAP repeat-containing protein 4" "IAP-like protein" "ILP" "hILP" "Inhibitor of apoptosis protein 3" "IAP-3" "hIAP-3" "hIAP3" "X-linked inhibitor of apoptosis protein" "X-linked IAP"))
(define-protein "XPA_HUMAN" ("xpa" "DNA repair protein complementing XP-A cells" "Xeroderma pigmentosum group A-complementing protein"))
(define-protein "XPC_HUMAN" ("xpc" "DNA repair protein complementing XP-C cells" "Xeroderma pigmentosum group C-complementing protein" "p125"))
(define-protein "XPF_HUMAN" ("xpf" "DNA repair endonuclease XPF" "DNA excision repair protein ERCC-4" "DNA repair protein complementing XP-F cells" "Xeroderma pigmentosum group F-complementing protein"))
=======
<<<<<<< .mine
(define-protein "XIAP_HUMAN" ("xiap" "E3 ubiquitin-protein ligase XIAP" "Baculoviral IAP repeat-containing protein 4" "IAP-like protein" "ILP" "hILP" "Inhibitor of apoptosis protein 3" "IAP-3" "hIAP-3" "hIAP3" "X-linked inhibitor of apoptosis protein" "X-linked IAP"))
(define-protein "XPA_HUMAN" ("xpa" "DNA repair protein complementing XP-A cells" "Xeroderma pigmentosum group A-complementing protein"))
(define-protein "XPC_HUMAN" ("xpc" "DNA repair protein complementing XP-C cells" "Xeroderma pigmentosum group C-complementing protein" "p125"))
(define-protein "XPF_HUMAN" ("xpf" "DNA repair endonuclease XPF" "DNA excision repair protein ERCC-4" "DNA repair protein complementing XP-F cells" "Xeroderma pigmentosum group F-complementing protein"))
=======
(define-protein "XIAP_HUMAN" ("E3 ubiquitin-protein ligase XIAP" "Baculoviral IAP repeat-containing protein 4" "IAP-like protein" "ILP" "hILP" "Inhibitor of apoptosis protein 3" "IAP-3" "hIAP-3" "hIAP3" "X-linked inhibitor of apoptosis protein" "X-linked IAP"))
(define-protein "XPA_HUMAN" ("DNA repair protein complementing XP-A cells" "Xeroderma pigmentosum group A-complementing protein"))
(define-protein "XPC_HUMAN" ("DNA repair protein complementing XP-C cells" "Xeroderma pigmentosum group C-complementing protein" "p125"))
(define-protein "XPF_HUMAN" ("DNA repair endonuclease XPF" "DNA excision repair protein ERCC-4" "DNA repair protein complementing XP-F cells" "Xeroderma pigmentosum group F-complementing protein"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "XPO1_HUMAN" ("CRM1" "XPO1" "Exp1")) 
(define-protein "XPO4_HUMAN" ("XPO4" "Exp4" "KIAA1721")) 
<<<<<<< .mine
(define-protein "XPO5_HUMAN" ("rangtp" "Exportin-5" "Exp5" "Ran-binding protein 21"))
(define-protein "XPO6_HUMAN" ("exportin-6" "Exportin-6" "Exp6" "Ran-binding protein 20"))
=======
<<<<<<< .mine
(define-protein "XPO5_HUMAN" ("rangtp" "Exportin-5" "Exp5" "Ran-binding protein 21"))
(define-protein "XPO6_HUMAN" ("exportin-6" "Exportin-6" "Exp6" "Ran-binding protein 20"))
=======
(define-protein "XPO5_HUMAN" ("Exportin-5" "Exp5" "Ran-binding protein 21"))
(define-protein "XPO6_HUMAN" ("Exportin-6" "Exp6" "Ran-binding protein 20"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "XPO7_HUMAN" ("KIAA0745" "RANBP16" "XPO7" "Exp7")) 
<<<<<<< .mine
(define-protein "XPP2_HUMAN" ("Membrane-bound" "Xaa-Pro aminopeptidase 2" "Aminoacylproline aminopeptidase" "Membrane-bound aminopeptidase P" "Membrane-bound APP" "Membrane-bound AmP" "mAmP" "X-Pro aminopeptidase 2"))
=======
<<<<<<< .mine
(define-protein "XPP2_HUMAN" ("Membrane-bound" "Xaa-Pro aminopeptidase 2" "Aminoacylproline aminopeptidase" "Membrane-bound aminopeptidase P" "Membrane-bound APP" "Membrane-bound AmP" "mAmP" "X-Pro aminopeptidase 2"))
=======
(define-protein "XPP2_HUMAN" ("Xaa-Pro aminopeptidase 2" "Aminoacylproline aminopeptidase" "Membrane-bound aminopeptidase P" "Membrane-bound APP" "Membrane-bound AmP" "mAmP" "X-Pro aminopeptidase 2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "XRCC1_HUMAN" ("XRCC1")) 
(define-protein "YBOX1_HUMAN" ("Nuclease-sensitive element-binding protein 1" "CCAAT-binding transcription factor I subunit A" "CBF-A" "DNA-binding protein B" "DBPB" "Enhancer factor I subunit A" "EFI-A" "Y-box transcription factor" "Y-box-binding protein 1" "YB-1"))
<<<<<<< .mine
(define-protein "YES_HUMAN" ("rtks" "Tyrosine-protein kinase Yes" "Proto-oncogene c-Yes" "p61-Yes"))
(define-protein "YH006_HUMAN" ("fp" "Putative chemokine-related protein FP248" "Protein N73"))
=======
<<<<<<< .mine
(define-protein "YES_HUMAN" ("rtks" "Tyrosine-protein kinase Yes" "Proto-oncogene c-Yes" "p61-Yes"))
(define-protein "YH006_HUMAN" ("fp" "Putative chemokine-related protein FP248" "Protein N73"))
=======
(define-protein "YES_HUMAN" ("Tyrosine-protein kinase Yes" "Proto-oncogene c-Yes" "p61-Yes"))
(define-protein "YH006_HUMAN" ("Putative chemokine-related protein FP248" "Protein N73"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "YIF1A_HUMAN" ("YIF1" "54TMp" "YIF1A" "HYIF1P" "54TM")) 
(define-protein "YKT6_HUMAN" ("YKT6")) 
<<<<<<< .mine
(define-protein "YLAT2_HUMAN" ("huvecs" "Y+L amino acid transporter 2" "Cationic amino acid transporter, y+ system" "Solute carrier family 7 member 6" "y(+)L-type amino acid transporter 2" "Y+LAT2" "y+LAT-2"))
(define-protein "YRDC_HUMAN" ("ischemia" "YrdC domain-containing protein, mitochondrial" "Dopamine receptor-interacting protein 3" "Ischemia/reperfusion-inducible protein homolog" "hIRIP"))
(define-protein "ZAP70_HUMAN" ("ZAP-70" "Tyrosine-protein kinase ZAP-70" "70 kDa zeta-chain associated protein" "Syk-related tyrosine kinase"))
=======
<<<<<<< .mine
(define-protein "YLAT2_HUMAN" ("huvecs" "Y+L amino acid transporter 2" "Cationic amino acid transporter, y+ system" "Solute carrier family 7 member 6" "y(+)L-type amino acid transporter 2" "Y+LAT2" "y+LAT-2"))
(define-protein "YRDC_HUMAN" ("ischemia" "YrdC domain-containing protein, mitochondrial" "Dopamine receptor-interacting protein 3" "Ischemia/reperfusion-inducible protein homolog" "hIRIP"))
(define-protein "ZAP70_HUMAN" ("ZAP-70" "Tyrosine-protein kinase ZAP-70" "70 kDa zeta-chain associated protein" "Syk-related tyrosine kinase"))
=======
(define-protein "YLAT2_HUMAN" ("Y+L amino acid transporter 2" "Cationic amino acid transporter, y+ system" "Solute carrier family 7 member 6" "y(+)L-type amino acid transporter 2" "Y+LAT2" "y+LAT-2"))
(define-protein "YRDC_HUMAN" ("YrdC domain-containing protein, mitochondrial" "Dopamine receptor-interacting protein 3" "Ischemia/reperfusion-inducible protein homolog" "hIRIP"))
(define-protein "ZAP70_HUMAN" ("Tyrosine-protein kinase ZAP-70" "70 kDa zeta-chain associated protein" "Syk-related tyrosine kinase"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ZBT12_HUMAN" ("NG35" "ZBTB12" "C6orf46" "G10")) 
<<<<<<< .mine
(define-protein "ZBT7A_HUMAN" ("erythroid" "Zinc finger and BTB domain-containing protein 7A" "Factor binding IST protein 1" "FBI-1" "Factor that binds to inducer of short transcripts protein 1" "HIV-1 1st-binding protein 1" "Leukemia/lymphoma-related factor" "POZ and Krueppel erythroid myeloid ontogenic factor" "POK erythroid myeloid ontogenic factor" "Pokemon" "TTF-I-interacting peptide 21" "TIP21" "Zinc finger protein 857A"))
=======
<<<<<<< .mine
(define-protein "ZBT7A_HUMAN" ("erythroid" "Zinc finger and BTB domain-containing protein 7A" "Factor binding IST protein 1" "FBI-1" "Factor that binds to inducer of short transcripts protein 1" "HIV-1 1st-binding protein 1" "Leukemia/lymphoma-related factor" "POZ and Krueppel erythroid myeloid ontogenic factor" "POK erythroid myeloid ontogenic factor" "Pokemon" "TTF-I-interacting peptide 21" "TIP21" "Zinc finger protein 857A"))
=======
(define-protein "ZBT7A_HUMAN" ("Zinc finger and BTB domain-containing protein 7A" "Factor binding IST protein 1" "FBI-1" "Factor that binds to inducer of short transcripts protein 1" "HIV-1 1st-binding protein 1" "Leukemia/lymphoma-related factor" "POZ and Krueppel erythroid myeloid ontogenic factor" "POK erythroid myeloid ontogenic factor" "Pokemon" "TTF-I-interacting peptide 21" "TIP21" "Zinc finger protein 857A"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ZC3HF_HUMAN" ("DFRP1" "ZC3H15" "LEREPO4")) 
(define-protein "ZDH17_HUMAN" ("HIP3" "DHHC-17" "HIP14" "KIAA0946" "ZDHHC17" "HIP-14" "HYPH" "HIP-3")) 
(define-protein "ZEB2_HUMAN" ("Zinc finger E-box-binding homeobox 2" "Smad-interacting protein 1" "SMADIP1" "Zinc finger homeobox protein 1b"))
(define-protein "ZFPL1_HUMAN" ("ZFPL1")) 
(define-protein "ZFYV1_HUMAN" ("KIAA1589" "SR3" "DFCP1" "TAFF1" "ZFYVE1" "ZNFN2A1")) 
<<<<<<< .mine
(define-protein "ZHX2_HUMAN" ("afp" "Zinc fingers and homeoboxes protein 2" "Alpha-fetoprotein regulator 1" "AFP regulator 1" "Regulator of AFP" "Zinc finger and homeodomain protein 2"))
=======
<<<<<<< .mine
(define-protein "ZHX2_HUMAN" ("afp" "Zinc fingers and homeoboxes protein 2" "Alpha-fetoprotein regulator 1" "AFP regulator 1" "Regulator of AFP" "Zinc finger and homeodomain protein 2"))
=======
(define-protein "ZHX2_HUMAN" ("Zinc fingers and homeoboxes protein 2" "Alpha-fetoprotein regulator 1" "AFP regulator 1" "Regulator of AFP" "Zinc finger and homeodomain protein 2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ZMYM4_HUMAN" ("Zinc finger MYM-type protein 4" "Zinc finger protein 262"))
<<<<<<< .mine
(define-protein "ZN148_HUMAN" ("zbp" "Zinc finger protein 148" "Transcription factor ZBP-89" "Zinc finger DNA-binding protein 89"))
=======
<<<<<<< .mine
(define-protein "ZN148_HUMAN" ("zbp" "Zinc finger protein 148" "Transcription factor ZBP-89" "Zinc finger DNA-binding protein 89"))
=======
(define-protein "ZN148_HUMAN" ("Zinc finger protein 148" "Transcription factor ZBP-89" "Zinc finger DNA-binding protein 89"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ZN239_HUMAN" ("HOK2" "MOK2" "ZNF239")) 
(define-protein "ZN363_HUMAN" ("Pirh2" "RING finger and CHY zinc finger domain-containing protein 1" "Androgen receptor N-terminal-interacting protein" "CH-rich-interacting match with PLAG1" "E3 ubiquitin-protein ligase Pirh2" "RING finger protein 199" "Zinc finger protein 363" "p53-induced RING-H2 protein" "hPirh2"))
(define-protein "ZN363_HUMAN" ("RING finger and CHY zinc finger domain-containing protein 1" "Androgen receptor N-terminal-interacting protein" "CH-rich-interacting match with PLAG1" "E3 ubiquitin-protein ligase Pirh2" "RING finger protein 199" "Zinc finger protein 363" "p53-induced RING-H2 protein" "hPirh2"))
<<<<<<< .mine
(define-protein "ZN451_HUMAN" ("receptors" "Zinc finger protein 451" "Coactivator for steroid receptors"))
=======
<<<<<<< .mine
(define-protein "ZN451_HUMAN" ("receptors" "Zinc finger protein 451" "Coactivator for steroid receptors"))
=======
(define-protein "ZN451_HUMAN" ("Zinc finger protein 451" "Coactivator for steroid receptors"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ZNT9_HUMAN" ("C4orf1" "HuEL" "HUEL" "SLC30A9" "ZnT-9")) 
(define-protein "ZO1_HUMAN" ("TJP1" "ZO1")) 
(define-protein "ZO1_HUMAN" ("Tight junction protein ZO-1" "Tight junction protein 1" "Zona occludens protein 1" "Zonula occludens protein 1"))
(define-protein "ZO2_HUMAN" ("X104" "TJP2" "ZO2")) 
<<<<<<< .mine
(define-protein "ZSC26_HUMAN" ("sre" "Zinc finger and SCAN domain-containing protein 26" "Protein SRE-ZBP" "Zinc finger protein 187"))
=======
<<<<<<< .mine
(define-protein "ZSC26_HUMAN" ("sre" "Zinc finger and SCAN domain-containing protein 26" "Protein SRE-ZBP" "Zinc finger protein 187"))
=======
(define-protein "ZSC26_HUMAN" ("Zinc finger and SCAN domain-containing protein 26" "Protein SRE-ZBP" "Zinc finger protein 187"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "ZW10_HUMAN" ("ZW10")) 
(define-protein "ZWILC_HUMAN" ("ZWILCH" "hZwilch")) 
(define-protein "ZWINT_HUMAN" ("ZWINT" "Zwint-1")) 
<<<<<<< .mine
(define-protein "ZYX_HUMAN" ("zyxin" "Zyxin" "Zyxin-2"))
=======
<<<<<<< .mine
(define-protein "ZYX_HUMAN" ("zyxin" "Zyxin" "Zyxin-2"))
=======
(define-protein "ZYX_HUMAN" ("Zyxin" "Zyxin-2"))
>>>>>>> .r4470
>>>>>>> .r4471
(define-protein "b4dip2_human" ("ERBB2IP")) 
(define-protein "b4dyu4_human" NIL) 
(define-protein "b4e074_human" NIL) 
(define-protein "byr2_schpo" ("SPBC2F12.01" "ste8" "SPBC1D7.05" "byr2")) 
(define-protein "fnta_rat" ("Fnta" "FTase-alpha")) 
(define-protein "fntb_rat" ("Fntb")) 
(define-protein "mSnx27" NIL) 
(define-protein "mSnx31" NIL) 
(define-protein "p27958-pro_0000037575" NIL) 
(define-protein "praf1_mouse" ("Pra1" "Pra" "Prenylin" "Rabac1" "Praf1")) 
(define-protein "q1zyl5_human" NIL) 
(define-protein "q46342_closo" NIL) 
(define-protein "q5ebh1-2" ("Rapl" "Nore1" "Rassf5")) 
(define-protein "rasf5_mouse" ("Rapl" "Nore1" "Rassf5")) 
(define-protein "rpgf4_mouse" ("Epac2" "Cgef2" "Rapgef4"))
;;(define-protein "DAPP1_HUMAN" ("Dual adapter for phosphotyrosine and 3-phosphotyrosine and 3-phosphoinositide" "hDAPP1" "B lymphocyte adapter protein Bam32" "B-cell adapter molecule of 32 kDa"))
 
;;(define-protein "DAPP1_HUMAN" ("Dual adapter for phosphotyrosine and 3-phosphotyrosine and 3-phosphoinositide" "hDAPP1" "B lymphocyte adapter protein Bam32" "B-cell adapter molecule of 32 kDa"))
;;(define-protein "DAPP1_HUMAN" ("Dual adapter for phosphotyrosine and 3-phosphotyrosine and 3-phosphoinositide" "hDAPP1" "B lymphocyte adapter protein Bam32" "B-cell adapter molecule of 32 kDa"))


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

