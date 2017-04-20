;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER COMMON-LISP) -*-
;;; Copyright (c) 2014-2015 SIFT LLC. All Rights Reserved
;;;
;;;    File: "protein-families"
;;;  Module: "grammar/model/sl/biology/
;;; version: June 2015

;; initiated 06/16/15 migrating from other files 

(in-package :sparser)



;;bad (def-family "GST" :members ("GSTP1_HUMAN")) ;; actually, very many more

;; Protein families

(def-family "SAPK" :synonyms ("SAP kinase activity" "stress activated protein kinase" "stress=activated protein kinase" ) :identifier "GO:0016909" ) 
(def-family "histone H2B" :identifier "FA:01763")
(def-family "CDK" :synonyms ("cyclin dependent kinase" "cyclin-dependent kinase" "Cdks" "CDKs") :identifier "NCIT:C17767")	
(def-family "14-3-3")
(def-family "AMPK":synonyms ("AMP activated protein kinase"))
(def-family "ASPP" :members ("ASPP1" "ASPP2") :synonyms ("apoptosis-stimulating protein of p53"))
(def-family "CD3")
(def-family "CREB" :synonyms ("cAMP response element-binding protein"))
(def-family "CaMK" :synonyms ("CaM kinase" "CAMK" "CaM-kinase"))
(def-family "Cam-PDE 1" :members ("PDE1A_HUMAN" "PDE1B_HUMAN""PDE1C_HUMAN"))
(def-family "DUSP") ;; there are a bunch of these, but we will ignore them for the moment
(def-family "EPHB receptor":members ("EPHB1_HUMAN" "EPHB2_HUMAN" "EPHB3_HUMAN" "EPHB4_HUMAN" "EPHB5_HUMAN" "EPHB6_HUMAN"))
(def-family "GAP")
(def-family "GPCR")
(def-family "HLA class I molecule")
(def-family "HSP90") ;; heat-shock proteins
(def-family "IgG")
(def-family "IQGAP" :members ("IQGAP1" "IQGAP2" "IQGAP3"))
(def-family "Jnk" :members ("JNK1" "JNK3A"))
(def-family "MAP2K" :members ("MAP2K1" "MAP2K2" "MAP2K3" "MAP2K4" "MAP2K5" "MAP2K6" "MAP2K7") :synonyms ("mitogen activated protein kinase" "MAP kinase kinase") )
(def-family "MAPK" :members ("UP:Q5A1D3" #| "ERK1" |# "UP:Q54QB1" #| "ERK2" |# ) :long "mitogen activated protein kinase" :synonyms ("ERK" "extracellular signal-regulated kinase" "ERK1/2" "erk" "mapk" "MAP kinase" "mitogen-activated protein kinase"))
(def-family "MEK" :members ("MEK1" "MEK2") :synonyms ("MEK1/2" "MAPKK" "mitogen activated ERK kinase" "mitogen activated protein kinase kinase" "mitogen-activated protein kinase kinase"))
(def-family "NF-AT" :members ("NFAT5_HUMAN")) 
(def-family "PI3-kinase" :synonyms ("PI3K" "phosphatidylinositol-4,5-bisphosphate 3-kinase" "phosphatidylinositide 3-kinase"  "phosphatidylinositol 3-kinase" "phosphatidylinositol-3-kinase" "PI 3-kinase" "PI(3)K" "PI-3K"))
(def-family "PKC" :members ("PKC-alpha" "PKC-delta" "nPKC-epsilon"))
(def-family "PTK")
(def-family "RAS GAP")
(def-family "Raf" :members ("ARaf" "BRaf" "CRaf" "Raf1") :identifier  "FA:03114" :synonyms ("RAF")) ;;/// maybe use the Mitre choice? 
(def-family "Ras" :members ("KRas" "HRas" "NRas") :identifier "GO:0003930" :synonyms ("RAS")) ;; this is NOT the long name for "RAS" :long "GTPase") ;;//// need capitalization hacks
;; alternate Ras identifier "FA:03663" -- from TRIPS-proteins -- have now commented this definition out of non-upa-upm-proteins
(def-family "SMAD" );; there are a bunch of these, but we will ignore them for the moment
(def-family "TRIM")
(def-family "Wnt")
(def-family "arrestin") ;; lots of family members -- put them in some day
(def-family "cadherin" :members ("CADH1_HUMAN"))
(def-family "catenin")
(def-family "cyclooxygenase" :members ("PGH2_HUMAN"))
(def-family "endophilin")
(def-family "exportin")
(def-family "growth-factor" :members ("EGF_HUMAN") :long "growth factor")
(def-family "importin")
(def-family "integrin")
(def-family "karyopherin α" :synonyms ("karyopherin αs" "karyopherin alpha")) ;; don't have a list of proteins
(def-family "karyopherin β" :synonyms ("karyopherin βs" "karyopherin beta")) ;; don't have a list of proteins
(def-family "p38 SAPK" :members ("UP:Q16539" "UP:Q15759"))
(def-family "poly(ADP–ribose)" :members ("PARP1_HUMAN" "PARP2_HUMAN" "PARP3_HUMAN"))
(def-family "tyrphostin") ;; Tyrosine-kinase inhibitor -- actually a drug?
(def-family "1-phosphatidylinositol 4,5-bisphosphate phosphodiesterase delta-1" :members ("UP:P10895" "UP:P51178")) 
(def-family "1.1.1.239" :members ("UP:P37059" "UP:P42330")) 
(def-family "1.1.1.62" :members ("UP:P14061" "UP:P37059" "UP:P56937" "UP:Q53GQ0")) 
(def-family "1.14.14.1" :members ("UP:P04798" "UP:P05177" "UP:Q16678")) 
(def-family "1.15.1.1" :members ("UP:P00441" "UP:P04179")) 
(def-family "12 kDa FK506-binding protein" :members ("UP:P48375" "UP:P62942")) 
(def-family "2.4.1.222" :members ("UP:O00587" "UP:Q8NES3") :synonyms ("O-fucosylpeptide 3-beta-N-acetylglucosaminyltransferase" "O-fucosylpeptide 3-bη-N-acetylglucosaminyltransferase")) 
(def-family "2.7.1.153" :members ("UP:O00329" "UP:P42336" "UP:P42338" "UP:P48736")) 
(def-family "2.7.1.154" :members ("UP:O00443" "UP:O00750")) 
(def-family "2.7.1.40" :members ("UP:P14618" "UP:P30613")) 
(def-family "2.7.1.68" :members ("UP:O14986" "UP:O60331" "UP:Q99755")) 
(def-family "2.7.1.91" :members ("UP:Q9NRA0" "UP:Q9NYA1")) 
(def-family "2.7.10.1" :members ("UP:P00533" "UP:P04626" "UP:P04629" "UP:P06213" "UP:P07949" "UP:P08069" "UP:P08581" "UP:P09619" "UP:P10721" "UP:P11362" "UP:P16234" "UP:P21709" "UP:P21802" "UP:P21860" "UP:P22455" "UP:P22607" "UP:P29317" "UP:P29320" "UP:P29322" "UP:P29323" "UP:P35916" "UP:P35968" "UP:P54753" "UP:P54756" "UP:P54760" "UP:P54762" "UP:P54764" "UP:Q01974" "UP:Q02763" "UP:Q15303" "UP:Q15375" "UP:Q16288" "UP:Q16620" "UP:Q5JZY3" "UP:Q9UF33")) 
(def-family "2.7.10.2" :members ("UP:O60674" "UP:P00519" "UP:P06239" "UP:P06241" "UP:P07947" "UP:P07948" "UP:P08631" "UP:P09769" "UP:P12931" "UP:P23458" "UP:P42684" "UP:P43403" "UP:P43405" "UP:P51451" "UP:P52333" "UP:Q05397" "UP:Q06187" "UP:Q08881" "UP:Q14289")) 
(def-family "2.7.11.1" :members ("UP:O00141" "UP:O14578" "UP:O14757" "UP:O15530" "UP:O60229" "UP:O75116" "UP:O75460" "UP:O75962" "UP:P04049" "UP:P10398" "UP:P11274" "UP:P11309" "UP:P15056" "UP:P23443" "UP:P31749" "UP:P31751" "UP:P42336" "UP:P42345" "UP:P48736" "UP:Q13153" "UP:Q13177" "UP:Q13418" "UP:Q13464" "UP:Q13535" "UP:Q5VST9" "UP:Q8WZ42" "UP:Q9Y243")) 
(def-family "2.7.11.13" :members ("UP:O94806" "UP:P05129" "UP:P05771" "UP:P17252" "UP:P24723" "UP:P41743" "UP:Q02156" "UP:Q04759" "UP:Q05513" "UP:Q15139" "UP:Q16512" "UP:Q16513" "UP:Q9BZL6")) 
(def-family "2.7.11.17" :members ("UP:Q13554" "UP:Q13555" "UP:Q13557" "UP:Q16566" "UP:Q9UQM7")) 
(def-family "2.7.11.24" :members ("UP:P27361" "UP:P28482" "UP:P45983" "UP:P45984" "UP:P53779")) 
(def-family "2.7.11.25" :members ("UP:O95382" "UP:Q13233" "UP:Q99683" "UP:Q99759" "UP:Q9Y2U5" "UP:Q9Y6R4")) 
(def-family "2.7.11.30" :members ("UP:O00238" "UP:P27037" "UP:P36894" "UP:P36896" "UP:P36897" "UP:P37023" "UP:P37173" "UP:Q04771" "UP:Q13705" "UP:Q13873" "UP:Q16671" "UP:Q8NER5")) 
(def-family "2.7.12.2" :members ("UP:O14733" "UP:P36507" "UP:P45985" "UP:P46734" "UP:P52564" "UP:Q02750")) 
(def-family "2.7.4.3" :members ("UP:P00568" "UP:P54819" "UP:Q9Y6K8")) 
(def-family "2.7.4.6" :members ("UP:P00568" "UP:P15531" "UP:P22392" "UP:P30085" "UP:Q9Y6K8")) 
(def-family "20 alpha-hydroxysteroid dehydrogenase" :members ("UP:P14061" "UP:P37059") :synonyms ("20 α-hydroxysteroid dehydrogenase" "20-α-HSD" "E2DH" "EDH17B2")) 
(def-family "20-alpha-HSD" :members ("UP:P14061" "UP:P37059" "UP:Q04828")) 
(def-family "3.1.11.2" :members ("UP:O60671" "UP:Q99638")) 
(def-family "3.1.3.48" :members ("UP:P18031" "UP:P18433" "UP:P29350" "UP:P30307" "UP:P60484" "UP:Q06124" "UP:Q12913")) 
(def-family "3.1.3.86" :members ("UP:O15357" "UP:Q92835")) 
(def-family "3.1.4.11" :members ("UP:P16885" "UP:P19174" "UP:Q00722" "UP:Q01970" "UP:Q15147" "UP:Q9NQ66" "UP:Q9P212")) 
(def-family "3.1.4.4" :members ("UP:O14939" "UP:Q13393")) 
(def-family "5'-3' exoribonuclease 1" :members ("UP:P40383" "UP:Q8IZH2")) 
(def-family "51 kDa FK506-binding protein" :members ("UP:Q02790" "UP:Q13451")) 
(def-family "60S acidic ribosomal protein P0" :members ("UP:P05388" "UP:Q8SRJ7")) 
(def-family "ADF" :members ("UP:P06396" "UP:P10599")) 
(def-family "ADH1" :members ("UP:P07327" "UP:P23991")) 
(def-family "AF-1" :members ("UP:O28836" "UP:P38484")) 
(def-family "AF-2" :members ("UP:O28753" "UP:Q9HCD5")) 
(def-family "AGR2" :members ("UP:O95994" "UP:Q4JM46")) 
(def-family "AIM-1" :members ("UP:Q96GD4" "UP:Q9Y4K1")) 
(def-family "AIP1" :members ("UP:O75083" "UP:Q5VWQ8")) 
(def-family "AIP4" :members ("UP:Q66PJ3" "UP:Q96J02")) 
(def-family "ANT 2" :members ("UP:P05141" "UP:P12236")) 
(def-family "AP-1" :members ("UP:P05412" "UP:P61966")) 
(def-family "AP4" :members ("UP:P06594" "UP:Q9UPM8")) 
(def-family "AR" :members ("UP:P10275" "UP:P15121" "UP:P15514")) 
(def-family "ARIA" :members ("UP:Q02297" "UP:Q19T08")) 
(def-family "ASF" :members ("UP:P54793" "UP:P55036")) 
(def-family "ASIP" :members ("UP:P42127" "UP:Q8TEW0")) 
(def-family "ATP-PFK" :members ("UP:P17858" "UP:Q01813") :synonyms ("phosphohexokinase")) 
(def-family "ATP6C" :members ("UP:P21283" "UP:P27449")) 
(def-family "ATP6D" :members ("UP:P21283" "UP:P61421")) 
(def-family "Adenylate cyclase-inhibiting G alpha protein" :members ("UP:P04899" "UP:P63096") :synonyms ("Adenylate cyclase-inhibiting G α protein")) 
(def-family "Aminopeptidase N" :members ("UP:P15144" "UP:P79098")) 
(def-family "Amyloid beta A4 protein" :members ("UP:P05067" "UP:P12023")) 
(def-family "B-MYB" :members ("UP:P10244" "UP:Q03237")) 
(def-family "BAG family molecular chaperone regulator 2" :members ("UP:O95816" "UP:Q3ZBG5")) 
(def-family "BBP" :members ("UP:P09464" "UP:Q15637")) 
(def-family "BRF1" :members ("UP:Q07352" "UP:Q92994")) 
(def-family "CAM2" :members ("UP:P62158" "UP:Q13554")) 
(def-family "CAMK" :members ("UP:Q13555" "UP:Q16566")) 
(def-family "CAP2" :members ("UP:P40123" "UP:P50452")) 
(def-family "CAR" :members ("UP:P36575" "UP:P78310")) 
(def-family "CAS" :members ("UP:O60716" "UP:P56945")) 
(def-family "CCR4-associated factor 1" :members ("UP:A5YKK6" "UP:Q9UIV1")) 
(def-family "CD36" :members ("UP:P16671" "UP:Q14108")) 
(def-family "CDH3" :members ("UP:P22223" "UP:P55291")) 
(def-family "CGRP" :members ("UP:P10286" "UP:P80511")) 
(def-family "CK" :members ("UP:P30085" "UP:P35790")) 
(def-family "CMK" :members ("UP:P30085" "UP:Q07325")) 
(def-family "CPO" :members ("UP:P36551" "UP:Q8IVL8")) 
(def-family "CPS1" :members ("UP:P08686" "UP:P31327")) 
(def-family "CSN2" :members ("UP:P05814" "UP:P61201")) 
(def-family "CSN3" :members ("UP:P07498" "UP:Q9UNS2")) 
(def-family "CTCBF" :members ("UP:P12956" "UP:P13010") :synonyms ("TLAA" "thyroid-lupus autoantigen")) 
(def-family "Casein kinase I isoform epsilon" :members ("UP:P49674" "UP:Q5ZLL1")) 
(def-family "Cbp/PAG" :members ("UP:P40763" "UP:Q9NWQ8")) 
(def-family "Constitutive NOS" :members ("UP:P29474" "UP:P29475")) 
(def-family "Cyclin dependent kinase inhibitor 2A" :members ("UP:G3XAG3" "UP:Q8N726")) 
(def-family "Cyclin-dependent kinase inhibitor 2A" :members ("UP:G3XAG3" "UP:P42771" "UP:Q8N726")) 
(def-family "DAO" :members ("UP:P14920" "UP:P19801")) 
(def-family "DAP5" :members ("UP:P78344" "UP:Q15398")) 
(def-family "DBP" :members ("UP:P51659" "UP:Q10586")) 
(def-family "DEP1" :members ("UP:Q12913" "UP:Q6P493")) 
(def-family "DLK" :members ("UP:P80370" "UP:Q12852")) 
(def-family "DNA-3-methyladenine glycosylase" :members ("UP:P29372" "UP:P44321")) 
(def-family "DOC-2" :members ("UP:P98082" "UP:Q14183")) 
(def-family "DRG-1" :members ("UP:Q9NP79" "UP:Q9Y295")) 
(def-family "DRP-1" :members ("UP:P46939" "UP:Q9UIK4")) 
(def-family "DT" :members ("UP:P40126" "UP:Q03001")) 
(def-family "DUP" :members ("UP:P20585" "UP:Q9H211")) 
(def-family "E2F-1" :members ("UP:Q01094" "UP:Q90977") :synonyms ("Transcription factor E2F1")) 
(def-family "EBP" :members ("UP:Q15125" "UP:Q5HYK7")) 
(def-family "ERK-1" :members ("UP:P27361" "UP:Q5A1D3") :synonyms ("ERK1" "extracellular signal-regulated kinase 1")) 
(def-family "ERK2" :members ("UP:P28482" "UP:Q54QB1") :synonyms ("extracellular signal-regulated kinase 2")) 
(def-family "ERp60" :members ("UP:P27797" "UP:P30101")) 
(def-family "ET-1" :members ("UP:P05305" "UP:P22387") :synonyms ("endothelin-1")) 
(def-family "Endogenous retrovirus group K member 18 Env polyprotein" :members ("UP:C6FX96" "UP:O42043")) 
(def-family "Ephrin-B1" :members ("UP:O73612" "UP:P98172")) 
(def-family "Eukaryotic translation initiation factor 4E-binding protein 1" :members ("UP:Q0P5A7" "UP:Q13541")) 
(def-family "Exportin-T" :members ("UP:O43592" "UP:Q753A0")) 
(def-family "FAP" :members ("UP:Q12884" "UP:Q92990")) 
(def-family "FBP2" :members ("UP:O00757" "UP:Q92945")) 
(def-family "FcERI" :members ("UP:P12319" "UP:Q01362")) 
(def-family "G-CSF" :members ("UP:P09919" "UP:Q99062")) 
(def-family "GAR1" :members ("UP:Q14028" "UP:Q9NY12")) 
(def-family "GLR" :members ("UP:P23416" "UP:P47871")) 
(def-family "GLUT3" :members ("UP:P11169" "UP:Q8TDB8")) 
(def-family "GNT1" :members ("UP:O60656" "UP:P19224" "UP:P22309" "UP:P35503" "UP:Q9HAW7" "UP:Q9HAW8" "UP:Q9HAW9") :synonyms ("UGT1")) 
(def-family "GRF2" :members ("UP:O14827" "UP:Q13905")) 
(def-family "GRIP1" :members ("UP:Q15596" "UP:Q9Y3R0")) 
(def-family "GRP" :members ("UP:P07492" "UP:Q9Y4Z0")) 
(def-family "GSK3" :members ("UP:P49840" "UP:Q9U2Q9")) 
(def-family "HBGF-8" :members ("UP:P21246" "UP:P55075") :synonyms ("heparin-binding growth factor 8")) 
(def-family "HD1" :members ("UP:Q13547" "UP:Q15149")) 
(def-family "HIP-1" :members ("UP:O00291" "UP:Q9BYW2")) 
(def-family "HLA class I histocompatibility antigen, A-10 alpha chain" :members ("UP:P18462" "UP:P30453" "UP:P30457") :synonyms ("HLA class I histocompatibility antigen, A-10 α chain")) 
(def-family "HLA class I histocompatibility antigen, A-28 alpha chain" :members ("UP:P01891" "UP:P10316") :synonyms ("HLA class I histocompatibility antigen, A-28 α chain")) 
(def-family "HLA class I histocompatibility antigen, A-9 alpha chain" :members ("UP:P05534" "UP:P30447") :synonyms ("HLA class I histocompatibility antigen, A-9 α chain")) 
(def-family "HLA class I histocompatibility antigen, B-21 alpha chain" :members ("UP:P30487" "UP:P30488") :synonyms ("HLA class I histocompatibility antigen, B-21 α chain")) 
(def-family "HLA class II histocompatibility antigen, DRB1-8 beta chain" :members ("UP:P04229" "UP:Q30134") :synonyms ("q30134")) 
(def-family "HLA-A" :members ("UP:P01891" "UP:P01892" "UP:P04439" "UP:P05534" "UP:P10314" "UP:P10316" "UP:P13746" "UP:P16188" "UP:P16189" "UP:P16190" "UP:P18462" "UP:P30443" "UP:P30447" "UP:P30450" "UP:P30453" "UP:P30455" "UP:P30456" "UP:P30457" "UP:P30459" "UP:P30512" "UP:Q09160") :synonyms ("HLAA")) 
(def-family "HLA-B" :members ("UP:P01889" "UP:P03989" "UP:P10319" "UP:P18463" "UP:P18464" "UP:P18465" "UP:P30460" "UP:P30461" "UP:P30462" "UP:P30464" "UP:P30466" "UP:P30475" "UP:P30479" "UP:P30480" "UP:P30481" "UP:P30483" "UP:P30484" "UP:P30485" "UP:P30487" "UP:P30488" "UP:P30490" "UP:P30491" "UP:P30492" "UP:P30493" "UP:P30495" "UP:P30498" "UP:P30685" "UP:Q04826" "UP:Q29718" "UP:Q29836" "UP:Q29940" "UP:Q31610" "UP:Q31612" "UP:Q95365") :synonyms ("HLAB")) 
(def-family "HLA-C" :members ("UP:P04222" "UP:P10321" "UP:P30499" "UP:P30501" "UP:P30504" "UP:P30505" "UP:P30508" "UP:P30510" "UP:Q07000" "UP:Q29865" "UP:Q29960" "UP:Q29963" "UP:Q95604" "UP:Q9TNN7") :synonyms ("HLAC")) 
(def-family "HRAS1" :members ("UP:P01111" "UP:P01112")) 
(def-family "HRG" :members ("UP:P04196" "UP:Q02297")) 
(def-family "HRS" :members ("UP:O14964" "UP:Q13243")) 
(def-family "HSFs" :members ("UP:P19875" "UP:P22813")) 
(def-family "HSPG" :members ("UP:P34741" "UP:P98160")) 
(def-family "HST" :members ("UP:P08620" "UP:Q06520")) 
(def-family "HTRA3" :members ("UP:O15484" "UP:P83110")) 
(def-family "HV205_HUMAN" :members ("UP:P01817" "UP:P01818")) 
(def-family "HV311_HUMAN" :members ("UP:P01762" "UP:P01772")) 
(def-family "HV313_HUMAN" :members ("UP:P01766" "UP:P01774")) 
(def-family "Hematopoietic prostaglandin D synthase" :members ("UP:O60760" "UP:O73888")) 
(def-family "HisRS" :members ("UP:P12081" "UP:P49590")) 
(def-family "IAP" :members ("UP:P09923" "UP:Q08722" "UP:Q9H0U3")) 
(def-family "IFN-γ" :members ("UP:P01579" "UP:P15260")) 
(def-family "IL13R" :members ("UP:P78552" "UP:Q14627")) 
(def-family "INPP4B" :members ("UP:O15327" "UP:Q9BS68")) 
(def-family "IRS-1" :members ("UP:P35568" "UP:Q28224") :synonyms ("IRS1" "insulin receptor substrate-1" "insulin receptor substrate 1")) 
(def-family "Inhibitor of nuclear factor kappa-B kinase subunit beta" :members ("UP:O14920" "UP:Q95KV0")) 
(def-family "KCIP-1" :members ("UP:P31946" "UP:P61981" "UP:P63104") :synonyms ("Protein kinase C inhibitor protein 1")) 
(def-family "KLK3" :members ("UP:P03952" "UP:P07288")) 
(def-family "KNS2" :members ("UP:O00139" "UP:Q07866")) 
(def-family "KSR2" :members ("UP:Q6VAB6" "UP:Q8WXI2")) 
(def-family "KV117_HUMAN" :members ("UP:P01599" "UP:P01609")) 
(def-family "KV311_HUMAN" :members ("UP:P04433" "UP:P06311")) 
(def-family "LAMB2" :members ("UP:P11047" "UP:P55268")) 
(def-family "LAP" :members ("UP:P01137" "UP:P10600" "UP:P17676" "UP:P61812")) 
(def-family "LHR" :members ("UP:P16070" "UP:P22888")) 
(def-family "LIM and SH3 domain protein 1" :members ("UP:O77506" "UP:Q14847")) 
(def-family "LIM domain kinase 2" :members ("UP:P53671" "UP:Q32L23")) 
(def-family "LRRN1" :members ("UP:O75427" "UP:Q6UXK5")) 
(def-family "LV208_HUMAN" :members ("UP:P01709" "UP:P01711")) 
(def-family "LV211_HUMAN" :members ("UP:P01706" "UP:P04209")) 
(def-family "MAG" :members ("UP:P18074" "UP:P20916")) 
(def-family "MBP-1" :members ("UP:P06733" "UP:P22032")) 
(def-family "MGAT3" :members ("UP:Q09327" "UP:Q86VF5")) 
(def-family "MGF" :members ("UP:P05019" "UP:P21583")) 
(def-family "MK2" :members ("UP:P49136" "UP:P49137")) 
(def-family "MPP1" :members ("UP:Q00013" "UP:Q96Q89")) 
(def-family "MT1" :members ("UP:P02802" "UP:P04731")) 
(def-family "MUC-1" :members ("UP:P15941" "UP:Q8WML4") :synonyms ("mucin-1")) 
(def-family "MUC3" :members ("UP:Q02505" "UP:Q685J3")) 
(def-family "Major capsid protein L1" :members ("UP:A0A089N7W1" "UP:G3LTJ9" "UP:P03101")) 
(def-family "MuRF" :members ("UP:Q969Q1" "UP:Q9BYV2")) 
(def-family "NAF1" :members ("UP:Q15025" "UP:Q96HR8")) 
(def-family "NARF" :members ("UP:Q8WVD3" "UP:Q9UHQ1")) 
(def-family "NAT1" :members ("UP:P18440" "UP:P78344")) 
(def-family "NAT6" :members ("UP:Q12794" "UP:Q93015")) 
(def-family "NEK8" :members ("UP:Q86SG6" "UP:Q8TD19")) 
(def-family "NET" :members ("UP:P23975" "UP:P54762")) 
(def-family "NHE-1" :members ("UP:P19634" "UP:Q552S0") :synonyms ("sodium/hydrogen exchanger 1")) 
(def-family "NRXN1" :members ("UP:P58400" "UP:Q9ULB1") :synonyms ("p58400" "neurexin 1")) 
(def-family "NRXN2" :members ("UP:P58401" "UP:Q9P2S2") :synonyms ("p58401" "neurexin 2")) 
(def-family "Neural Wiskott-Aldrich syndrome protein" :members ("UP:O00401" "UP:Q95107")) 
(def-family "ODC1" :members ("UP:P11926" "UP:Q9BQT8")) 
(def-family "ORC1" :members ("UP:Q13415" "UP:Q9Y619")) 
(def-family "PAK-1" :members ("UP:Q13153" "UP:Q16512") :synonyms ("PAK1")) 
(def-family "PAR-3" :members ("UP:O00254" "UP:Q8TEW0")) 
(def-family "PB2" :members ("UP:P03428" "UP:Q693B9")) 
(def-family "PBP" :members ("UP:P02775" "UP:P30086" "UP:Q15648")) 
(def-family "PDI" :members ("UP:P07237" "UP:Q9ULC6")) 
(def-family "PEMT" :members ("UP:P15941" "UP:Q9UBM1")) 
(def-family "PI3K-alpha" :members ("UP:P32871" "UP:P42336") :synonyms ("phosphatidylinositol 4,5-bisphosphate 3-kinase catalytic subunit alpha isoform")) 
(def-family "PIP" :members ("UP:O95861" "UP:P12273")) 
(def-family "PKC-α" :members ("UP:P04409" "UP:P17252") :synonyms ("Protein kinase C alpha type")) 
(def-family "PKD2" :members ("UP:Q13563" "UP:Q9BZL6")) 
(def-family "PKL" :members ("UP:P30613" "UP:Q14161")) 
(def-family "PLAP-1" :members ("UP:P05187" "UP:Q9BXN1")) 
(def-family "POB1" :members ("UP:O94972" "UP:Q8NFH8")) 
(def-family "PP4" :members ("UP:P08758" "UP:P60510")) 
(def-family "PPAT" :members ("UP:Q06203" "UP:Q13057")) 
(def-family "PPIase" :members ("UP:Q9H2H8" "UP:Q9Y3C6")) 
(def-family "PPT" :members ("UP:P20366" "UP:P50897" "UP:P53041")) 
(def-family "PR" :members ("UP:P06401" "UP:P10265" "UP:P63120" "UP:P63121" "UP:P63122" "UP:P63123" "UP:P63124" "UP:P63125" "UP:P63127" "UP:P63129" "UP:P63131" "UP:Q9Y6I0")) 
(def-family "PRP" :members ("UP:P04003" "UP:P32119")) 
(def-family "PSP" :members ("UP:O00186" "UP:P05451")) 
(def-family "PTC" :members ("UP:P07949" "UP:Q13635")) 
(def-family "PTP" :members ("UP:P05451" "UP:Q00325")) 
(def-family "Plexin-A4" :members ("UP:Q6BEA0" "UP:Q9HCM2")) 
(def-family "Poly [ADP-ribose] polymerase 3" :members ("UP:Q9FK91" "UP:Q9Y6F1")) 
(def-family "Prostaglandin E synthase" :members ("UP:O14684" "UP:Q9JM51") :synonyms ("mPGES-1")) 
(def-family "Protein Nef" :members ("UP:B0ZG58" "UP:J9RB96")) 
(def-family "Protein disulfide-isomerase A3" :members ("UP:P11598" "UP:P30101")) 
(def-family "Protein kinase C gamma type" :members ("UP:P05129" "UP:P10829")) 
(def-family "Protein kinase C-like 1" :members ("UP:P34722" "UP:Q16512")) 
(def-family "Protein lin-28 homolog B" :members ("UP:Q45KJ4" "UP:Q6ZN17")) 
(def-family "Proto-oncogene c-Fgr" :members ("UP:P09769" "UP:P11362")) 
(def-family "Q9HDB5" :members ("UP:Q9HDB5" "UP:Q9Y4C0")) 
(def-family "Q9TQE0" :members ("UP:P04229" "UP:Q9TQE0")) 
(def-family "RAC-3" :members ("UP:P60763" "UP:Q9Y6Q9")) 
(def-family "RBP1" :members ("UP:P09455" "UP:P29374")) 
(def-family "RBP4" :members ("UP:O15514" "UP:P02753")) 
(def-family "RGS9" :members ("UP:O75916" "UP:Q6ZS82")) 
(def-family "RIS1" :members ("UP:P47985" "UP:Q8WZ71")) 
(def-family "ROCK-II" :members ("UP:O75116" "UP:Q28021")) 
(def-family "ROR1" :members ("UP:P35398" "UP:Q01973")) 
(def-family "RPF1" :members ("UP:P46934" "UP:Q9H9Y2")) 
(def-family "RPL10" :members ("UP:P27635" "UP:P61313")) 
(def-family "RasGAP" :members ("UP:P09851" "UP:P20936")) 
(def-family "S6K1" :members ("UP:P23443" "UP:Q6TJY3")) 
(def-family "SAP-1" :members ("UP:P07602" "UP:P28324")) 
(def-family "SBP" :members ("UP:P04278" "UP:Q13228")) 
(def-family "SCAN1" :members ("UP:Q8WVQ1" "UP:Q9NUW8")) 
(def-family "SERS" :members ("UP:P49591" "UP:Q9NP81")) 
(def-family "SIP" :members ("UP:Q63ZY3" "UP:Q9HB71")) 
(def-family "SKD1" :members ("UP:O75351" "UP:Q9UN37")) 
(def-family "SOCS4" :members ("UP:O14544" "UP:Q8WXH5") :synonyms ("suppressor of cytokine signaling 4")) 
(def-family "SPP1" :members ("UP:P10451" "UP:Q9P0U4")) 
(def-family "SRK" :members ("UP:P43403" "UP:Q9UBS0")) 
(def-family "ST7" :members ("UP:Q9NRC1" "UP:Q9Y561")) 
(def-family "STATs" :members ("UP:P08457" "UP:P35610")) 
(def-family "STK-1" :members ("UP:P36888" "UP:Q96GD4")) 
(def-family "SUMO-2" :members ("UP:P61956" "UP:Q5ZJM9") :synonyms ("small ubiquitin-related modifier 2")) 
(def-family "Segment polarity protein dishevelled homolog DVL-2" :members ("UP:O14641" "UP:P51142")) 
(def-family "Selenoprotein P" :members ("UP:P49907" "UP:P49908")) 
(def-family "Serine/threonine-protein kinase PLK1" :members ("UP:P53350" "UP:P70032")) 
(def-family "StAR" :members ("UP:P25092" "UP:P49675")) 
(def-family "TAP" :members ("UP:O60763" "UP:O75369")) 
(def-family "TEP1" :members ("UP:P60484" "UP:Q99973")) 
(def-family "TGF-B superfamily receptor type I" :members ("UP:P37023" "UP:Q04771") :synonyms ("TSR-I")) 
(def-family "TIM" :members ("UP:Q12774" "UP:Q96D42" "UP:Q9UNS1")) 
(def-family "TKT" :members ("UP:P29401" "UP:Q16832")) 
(def-family "TNC" :members ("UP:P24821" "UP:P63316")) 
(def-family "TNFAIP3-interacting protein 1" :members ("UP:Q15025" "UP:Q9WUU8")) 
(def-family "TORC-3" :members ("UP:Q6UUV7" "UP:Q6UUV9") :synonyms ("Transducer of CREB protein 3")) 
(def-family "TR" :members ("UP:P02786" "UP:P25116" "UP:Q16881")) 
(def-family "TRAM-1" :members ("UP:Q15629" "UP:Q9Y6Q9")) 
(def-family "TYRO4" :members ("UP:P29320" "UP:P54756")) 
(def-family "Transcription factor AP-2-alpha" :members ("UP:A1A4R9" "UP:P05549")) 
(def-family "Transcription factor AP-2-beta" :members ("UP:Q76HI7" "UP:Q92481")) 
(def-family "Transforming protein RhoA" :members ("UP:P24406" "UP:P61586")) 
(def-family "Tyrosine-protein kinase FRK" :members ("UP:P42685" "UP:Q922K9")) 
(def-family "VCAM-1" :members ("UP:P19320" "UP:Q28260") :synonyms ("vascular cell adhesion protein 1")) 
(def-family "VEGFR-3" :members ("UP:P35916" "UP:P79701") :synonyms ("VEGFR3")) 
(def-family "WBP1" :members ("UP:P39656" "UP:Q96G27")) 
(def-family "Zinc finger protein GLI1" :members ("UP:P08151" "UP:P55878")) 
(def-family "a2" :members ("UP:Q07032" "UP:Q9Y487")) 
(def-family "a3" :members ("UP:P05813" "UP:Q13488")) 
(def-family "actin" :members ("UP:P63267" "UP:P68133")) 
(def-family "actin, aortic smooth muscle" :members ("UP:P08023" "UP:P62736")) 
(def-family "adenosine deaminase" :members ("UP:P00813" "UP:P78563")) 
(def-family "adenylate monophosphate kinase" :members ("UP:P00568" "UP:P54819")) 
(def-family "adiponectin" :members ("UP:Q15848" "UP:Q3Y5Z3")) 
(def-family "albumin" :members ("UP:P02768" "UP:Q10586")) 
(def-family "aldehyde reductase" :members ("UP:P14550" "UP:P15121")) 
(def-family "alpha 1" :members ("UP:P68133" "UP:Q03692")) 
(def-family "alpha-2-antiplasmin" :members ("UP:P08697" "UP:P28800")) 
(def-family "alpha-internexin" :members ("UP:Q08DH7" "UP:Q16352")) 
(def-family "arf-1" :members ("UP:P84077" "UP:Q9ULH1")) 
(def-family "arpc1b" :members ("UP:A4D275" "UP:O15143")) 
(def-family "arrestin-2" :members ("UP:P17870" "UP:P32121")) 
(def-family "ataxin-3" :members ("UP:P54252" "UP:Q9W689")) 
(def-family "aw-19" :members ("UP:P16190" "UP:P30459" "UP:P30512")) 
(def-family "beta-arrestin-1" :members ("UP:P17870" "UP:P49407")) 
(def-family "beta-arrestin-2" :members ("UP:P32120" "UP:P32121")) 
(def-family "beta-defensin 1" :members ("UP:O19038" "UP:P60022")) 
(def-family "beta-defensin 2" :members ("UP:O15263" "UP:P82020")) 
(def-family "beta-gal" :members ("UP:P06864" "UP:P70753")) 
(def-family "breast cancer type 1 susceptibility protein" :members ("UP:B7ZA85" "UP:P38398")) 
(def-family "bw-22" :members ("UP:P30492" "UP:P30495")) 
(def-family "c3b" :members ("UP:P01024" "UP:P17927")) 
(def-family "cAMP dependent protein kinase catalytic subunit alpha" :members ("UP:P17612" "UP:Q15136") :synonyms ("cAMP-dependent protein kinase catalytic subunit alpha")) 
(def-family "cadherin-11" :members ("UP:O93319" "UP:P55287")) 
(def-family "cadherin-associated protein" :members ("UP:P26232" "UP:P35221")) 
(def-family "calnexin" :members ("UP:P24643" "UP:P27824")) 
(def-family "calponin-3" :members ("UP:Q15417" "UP:Q32L92")) 
(def-family "carbohydrate sulfotransferase 11" :members ("UP:Q7T3S3" "UP:Q9NPF2")) 
(def-family "caspase-2" :members ("UP:P42575" "UP:Q98943")) 
(def-family "caspase-6" :members ("UP:P55212" "UP:Q3T0P5")) 
(def-family "caveolin-3" :members ("UP:P56539" "UP:Q2KI43")) 
(def-family "cholecystokinin" :members ("UP:O93464" "UP:P06307")) 
(def-family "claudin-16" :members ("UP:Q9XT98" "UP:Q9Y5I7")) 
(def-family "claudin-18" :members ("UP:P56856" "UP:Q0VCN0")) 
(def-family "claudin-2" :members ("UP:P57739" "UP:Q765P1")) 
(def-family "claudin-4" :members ("UP:O14493" "UP:Q6BBL6")) 
(def-family "claudin-7" :members ("UP:O95471" "UP:Q3B7N4")) 
(def-family "cofilin" :members ("UP:P78929" "UP:Q759P0" "UP:Q9Y281" "UP:P23528") ) 
(def-family "actin depolymerizing factor" :members ("UP:P78929" "UP:Q759P0" "UP:Q9Y281" "UP:P23528" "UP:Q39250" "UP:Q39250" "UP:Q41764" "UP:Q570Y6" "UP:Q67ZM4" "UP:Q9LQ81" "UP:Q9ZNT3" "UP:Q9ZSK3" "UP:Q9ZSK4") :synonyms ("ADF"))
(def-family "collagenase" :members ("UP:P08897" "UP:P45452")) 
(def-family "collectin-12" :members ("UP:Q2LK54" "UP:Q5KU26")) 
(def-family "cpt1b" :members ("UP:A5PLL0" "UP:Q92523")) 
(def-family "cytohesin-1" :members ("UP:Q15438" "UP:Q76MZ1")) 
(def-family "desmoglein-3" :members ("UP:P32926" "UP:Q7YRU7")) 
(def-family "dihydrodiol dehydrogenase 3" :members ("UP:P14550" "UP:P42330")) 
(def-family "diphthamide biosynthesis protein 1" :members ("UP:Q3T7C9" "UP:Q9BZG8")) 
(def-family "docking protein 2" :members ("UP:O60496" "UP:O70469")) 
(def-family "eIF-2A" :members ("UP:P05198" "UP:Q9BY44")) 
(def-family "efs" :members ("UP:P40136" "UP:Q9NQ75")) 
(def-family "envelope glycoprotein" :members ("UP:D2XWF1" "UP:E2F1Z4" "UP:O41637" "UP:Q5EHA4" "UP:Q99C47" "UP:W0G7P8")) 
(def-family "extracellular signal regulated kinase" :members ("UP:P29323" "UP:Q16539" "UP:Q9NZJ5")) 
(def-family "f-actin cross-linking protein" :members ("UP:P12814" "UP:P35609")) 
(def-family "f3" :members ("UP:P13726" "UP:Q12860")) 
(def-family "fibrillin-1" :members ("UP:P35555" "UP:P98133")) 
(def-family "fibronectin" :members ("UP:P02751" "UP:Q5R3F8")) 
(def-family "fibulin-5" :members ("UP:Q5EA62" "UP:Q9UBX5")) 
(def-family "fritz" :members ("UP:O95876" "UP:Q92765")) 
(def-family "frizzled-2" :members ("UP:Q08464" "UP:Q14332")) 
(def-family "gag protein" :members ("UP:Q79354" "UP:Q79360")) 
(def-family "galectin-9" :members ("UP:O00182" "UP:Q3MHZ8")) 
(def-family "genome polyprotein" :members ("UP:D2IE15" "UP:D2IE16" "UP:Q99IB8")) 
(def-family "glyceraldehyde-3-phosphate dehydrogenase" :members ("UP:O14556" "UP:P04406")) 
(def-family "hCAP" :members ("UP:P49913" "UP:Q9UQE7")) 
(def-family "hK2" :members ("UP:O00139" "UP:P52789")) 
(def-family "hbeta3" :members ("UP:Q9NPA1" "UP:Q9Y691")) 
(def-family "hemolysin" :members ("UP:Q00951" "UP:Q06304")) 
(def-family "hepatocyte nuclear factor 1-alpha" :members ("UP:P20823" "UP:Q90867")) 
(def-family "hrs" :members ("UP:O14964" "UP:O43593")) 
(def-family "indanol dehydrogenase" :members ("UP:P42330" "UP:Q04828") :synonyms ("trans-1,2-dihydrobenzene-1,2-diol dehydrogenase")) 
(def-family "indoleamine 2,3-dioxygenase" :members ("UP:P14902" "UP:P47125")) 
(def-family "inositol 1,4,5-trisphosphate receptor" :members ("UP:Q14643" "UP:Q8WSR4")) 
(def-family "intercellular adhesion molecule 2" :members ("UP:P13598" "UP:Q5NKV1")) 
(def-family "interferon alpha" :members ("UP:P01563" "UP:P35849")) 
(def-family "interferon regulatory factor 3" :members ("UP:Q14653" "UP:Q4JF28")) 
(def-family "interferon regulatory factor 5" :members ("UP:Q13568" "UP:Q58DJ0")) 
(def-family "interleukin-33" :members ("UP:O95760" "UP:O97863")) 
(def-family "interleukin-6" :members ("UP:P05231" "UP:P40189")) 
(def-family "jagged1" :members ("UP:P78504" "UP:Q90Y57")) 
(def-family "l-dopachrome tautomerase" :members ("UP:P14174" "UP:P40126")) 
(def-family "lactase" :members ("UP:P09848" "UP:P16278")) 
(def-family "latency-associated peptide" :members ("UP:P01137" "UP:P10600" "UP:P61812")) 
(def-family "leptin" :members ("UP:O15243" "UP:P41159")) 
(def-family "mast cell growth factor" :members ("UP:P08700" "UP:P21583")) 
(def-family "maternal embryonic leucine zipper kinase" :members ("UP:Q14680" "UP:Q61846")) 
(def-family "mitogen-activated protein kinase 14" :members ("UP:P47812" "UP:Q16539")) 
(def-family "mitogen-activated protein kinase 2" :members ("UP:O42781" "UP:P28482")) 
(def-family "mixed lineage kinase" :members ("UP:O43283" "UP:Q12852")) 
(def-family "nephrocystin-1" :members ("UP:O15259" "UP:Q9TU19")) 
(def-family "netrin-1" :members ("UP:O95631" "UP:Q90922")) 
(def-family "neurogenic differentiation factor 1" :members ("UP:Q13562" "UP:Q60430")) 
(def-family "non-structural protein 3" :members ("UP:Q3ZK63" "UP:Q9YWQ0")) 
(def-family "noxa" :members ("UP:Q0GKC8" "UP:Q13794")) 
(def-family "o00505" :members ("UP:O00505" "UP:O00629") :synonyms ("o00629")) 
(def-family "o43295" :members ("UP:O43295" "UP:O75044") :synonyms ("SLIT-ROBO Rho GTPase activating protein 3")) 
(def-family "oncomodulin" :members ("UP:O35508" "UP:P0CE72")) 
(def-family "osteopontin" :members ("UP:P10451" "UP:P31097")) 
(def-family "p01258" :members ("UP:P01258" "UP:P06881")) 
(def-family "p01699" :members ("UP:P01699" "UP:Q5NV81")) 
(def-family "p01703" :members ("UP:P01703" "UP:Q5NV69")) 
(def-family "p01705" :members ("UP:P01705" "UP:Q5NV89")) 
(def-family "p01706" :members ("UP:P01706" "UP:Q5NV84")) 
(def-family "p01717" :members ("UP:P01717" "UP:Q5NV90")) 
(def-family "p01718" :members ("UP:P01718" "UP:Q5NV91")) 
(def-family "p04156" :members ("UP:F7VJQ1" "UP:P04156")) 
(def-family "p04211" :members ("UP:P04211" "UP:Q5NV80")) 
(def-family "p100" :members ("UP:P40967" "UP:Q9ULW0")) 
(def-family "p102" :members ("UP:P25205" "UP:P35606")) 
(def-family "p11" :members ("UP:P55957" "UP:Q5RKV6")) 
(def-family "p18" :members ("UP:P23528" "UP:P63279")) 
(def-family "p19" :members ("UP:P55273" "UP:Q9NPF7")) 
(def-family "p20039" :members ("UP:P04229" "UP:P20039")) 
(def-family "p21Cip1" :members ("UP:P38936" "UP:P49918")) 
(def-family "p22 phagocyte B-cytochrome" :members ("UP:P04839" "UP:P13498")) 
(def-family "p24" :members ("UP:P21926" "UP:Q15363")) 
(def-family "p27" :members ("UP:P40305" "UP:Q13177")) 
(def-family "p29" :members ("UP:O95926" "UP:P24158")) 
(def-family "p3" :members ("UP:P09131" "UP:Q01780")) 
(def-family "p31" :members ("UP:P36543" "UP:Q9NZ43")) 
(def-family "p36" :members ("UP:P07355" "UP:Q9H0P0")) 
(def-family "p38" :members ("UP:O75791" "UP:P46108")) 
(def-family "p38 mitogen activated protein kinase" :members ("UP:P27638" "UP:Q16539")) 
(def-family "p39" :members ("UP:P05412" "UP:P61421")) 
(def-family "p4" :members ("UP:Q01780" "UP:Q9HC77")) 
(def-family "p47" :members ("UP:P08567" "UP:Q12802")) 
(def-family "p5" :members ("UP:Q06265" "UP:Q15084")) 
(def-family "p54" :members ("UP:P14921" "UP:Q13451")) 
(def-family "p55" :members ("UP:P01589" "UP:Q16658")) 
(def-family "p56" :members ("UP:P62191" "UP:Q7Z6B0")) 
(def-family "p58" :members ("UP:P14618" "UP:P30101" "UP:Q13177")) 
(def-family "p59" :members ("UP:Q02790" "UP:Q9H8Y8")) 
(def-family "p63" :members ("UP:Q9H3D4" "UP:Q9P2Y5")) 
(def-family "p65" :members ("UP:P21579" "UP:Q9H4A3")) 
(def-family "p68" :members ("UP:P08133" "UP:Q07666")) 
(def-family "p75" :members ("UP:P14317" "UP:P14784" "UP:P20333" "UP:Q92945" "UP:Q9Y286")) 
(def-family "p8" :members ("UP:P05109" "UP:Q7Z2W7")) 
(def-family "p90" :members ("UP:P02786" "UP:P27824")) 
(def-family "period circadian protein homolog 2" :members ("UP:O15055" "UP:O54943")) 
(def-family "peroxisome proliferator-activated receptor gamma" :members ("UP:P37231" "UP:Q86YN6")) 
(def-family "peroxisome proliferator-activated receptor gamma coactivator 1-alpha" :members ("UP:Q865B7" "UP:Q9UBK2")) 
(def-family "phosphatase 1" :members ("UP:Q8TDY2" "UP:Q9UQK1")) 
(def-family "platelet-derived growth factor receptor beta" :members ("UP:P09619" "UP:Q6QNF3")) 
(def-family "pol protein" :members ("UP:A4ZJ37" "UP:B7TEU4" "UP:B7TEZ7" "UP:G3FA30" "UP:G3FA67" "UP:G3GCR0" "UP:G3GCV8" "UP:Q5G4B7" "UP:Q9WJJ2")) 
(def-family "polycystin-2" :members ("UP:Q13563" "UP:Q4GZT3")) 
(def-family "pop3" :members ("UP:Q9BVC4" "UP:Q9HBV1")) 
(def-family "protease" :members ("UP:C3VI15" "UP:P10265" "UP:P63120" "UP:P63121" "UP:P63122" "UP:P63123" "UP:P63124" "UP:P63125" "UP:P63127" "UP:P63129" "UP:P63131" "UP:Q07CK6" "UP:Q9Y6I0")) 
(def-family "protein diaphanous homolog 1" :members ("UP:O08808" "UP:O60610") :synonyms ("mDia1")) 
(def-family "proteinase" :members ("UP:P10265" "UP:P55085" "UP:P63120" "UP:P63121" "UP:P63122" "UP:P63123" "UP:P63124" "UP:P63125" "UP:P63127" "UP:P63129" "UP:P63131" "UP:Q9Y6I0")) 
(def-family "prx" :members ("UP:P30048" "UP:Q9BXM0")) 
(def-family "rad1" :members ("UP:O60671" "UP:Q9BSD3")) 
(def-family "rap1" :members ("UP:P0C768" "UP:Q9NYB0")) 
(def-family "rap2" :members ("UP:P10114" "UP:Q96NL0")) 
(def-family "receptor-type tyrosine-protein phosphatase kappa" :members ("UP:Q15262" "UP:Q6P493")) 
(def-family "replication-associated protein" :members ("UP:P0C768" "UP:P18919")) 
(def-family "retinoblastoma-associated protein" :members ("UP:P06400" "UP:P13405")) 
(def-family "retinol dehydrogenase" :members ("UP:O14756" "UP:P40394")) 
(def-family "rho-associated protein kinase 2" :members ("UP:Q28021" "UP:Q62868")) 
(def-family "rhodopsin kinase" :members ("UP:P28327" "UP:Q15835")) 
(def-family "rotamase" :members ("UP:P62942" "UP:Q02790" "UP:Q13451")) 
(def-family "secreted frizzled-related protein 2" :members ("UP:Q863H1" "UP:Q96HF1")) 
(def-family "sentrin-specific protease 2" :members ("UP:Q91ZX6" "UP:Q9HC62")) 
(def-family "serine/threonine-protein kinase 13" :members ("UP:P53350" "UP:Q9UQB9")) 
(def-family "serum albumin" :members ("UP:P02768" "UP:P02769")) 
(def-family "skeletal muscle" :members ("UP:P35523" "UP:P68133")) 
(def-family "sterol regulatory element-binding protein 1" :members ("UP:P36956" "UP:Q60416")) 
(def-family "stomatin" :members ("UP:P27105" "UP:Q9UBI4")) 
(def-family "stress-70 protein, mitochondrial" :members ("UP:P38646" "UP:P48721")) 
(def-family "suppressor of cytokine signaling 5" :members ("UP:O75159" "UP:Q29RN6")) 
(def-family "tapasin" :members ("UP:O15533" "UP:Q9BX59")) 
(def-family "thioredoxin reductase" :members ("UP:P30044" "UP:P80892")) 
(def-family "thyroid hormone receptor beta" :members ("UP:P10828" "UP:Q9PVE4")) 
(def-family "transcription factor 12" :members ("UP:Q60420" "UP:Q99081")) 
(def-family "transformer-2 protein homolog beta" :members ("UP:P62995" "UP:Q3ZBT6")) 
(def-family "transforming growth factor alpha" :members ("UP:P01135" "UP:P98138")) 
(def-family "tristetraprolin" :members ("UP:P26651" "UP:P53781")) 
(def-family "tuftelin" :members ("UP:Q9NNX1" "UP:Q9UBB9")) 
(def-family "vascular endothelial growth factor receptor 2" :members ("UP:P35968" "UP:P52583")) 
(def-family "β2" :members ("UP:Q60430" "UP:Q9Y691")) 
(def-family "β5" :members ("UP:G3MZC5" "UP:Q9Y5E4")) 
(def-family "Akt" :identifier "NCIT:C41625" :members ("UP:P31749" "UP:P31751" "UP:Q9Y243") :synonyms ("AKT" "protein kinase B")) 
