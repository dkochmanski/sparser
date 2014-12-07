(in-package :sparser)
(defparameter *rasADJS* 
  '(
    (CLINICAL 7994 578) 
    (HUMAN 5375 4258) 
    (SUCH 5340) 
    (SIGNIFICANT 4917 2683) 
    (THYROID 4422) 
    (METASTATIC 3975) 
    (COLORECTAL 3871 83) 
    (PRIMARY 3759 957) 
    (MUTANT 3622) 
    (NORMAL 3597 1121) 
    (MOLECULAR 3392 453) 
    (SPECIFIC 3212 1955) 
    (ADDITIONAL 3211 791) 
    (SEVERAL 3011) 
    (MORE 2982) 
    (GENETIC 2852 705) 
    (POSITIVE 2569 1829) 
    (THERAPEUTIC 2396 93) 
    (DUE 2374 373) 
    (SINGLE 2231 1564) 
    (NEGATIVE 2196 1664) 
    (OVERALL 2171 822) 
    (PRESENT 2165 1745) 
    (FIRST 2113) 
    (MULTIPLE 2104 518) 
    (SAME 2096) 
    (CELLULAR 2030 102) 
    (ENDOSCOPIC 2028) 
    (TOTAL 1940 1533) 
    (MEDIAN 1917 89) 
    (MANY 1913) 
    (POTENTIAL 1911 1293) 
    (FURTHER 1782) 
    (ADVANCED 1767 308) 
    (INDEPENDENT 1737 953) 
    (MALIGNANT 1737 46) 
    (ONCOGENIC 1721) 
    (GASTRIC 1694 57) 
    (ACTIVE 1658 762) 
    (IMMUNE 1639 155) 
    (PATIENT 1593 284) 
    (MEAN 1579 564) 
    (TARGETED 1579 40) 
    (RECENT 1572 1202) 
    (LEAST 1566) 
    (MOST 1540) 
    (PROGNOSTIC 1521) 
    (FUNCTIONAL 1452 464) 
    (DOWNSTREAM 1444 43) 
    (PREDICTIVE 1442 42) 
    (GENOMIC 1359 38) 
    (PANCREATIC 1348) 
    (STANDARD 1323 1047) 
    (SENSITIVE 1275 365) 
    (RESISTANT 1255 128) 
    (DIAGNOSTIC 1241 81) 
    (SOMATIC 1240 91) 
    (PTEN 1217) 
    (NUCLEAR 1178 405) 
    (CONSISTENT 1175 624) 
    (RELATIVE 1161 658) 
    (SERRATED 1155) 
    (VIVO 1146) 
    (COMPLETE 1142 841) 
    (CHRONIC 1140 362) 
    (BIOLOGICAL 1136 684) 
    (EXTRACELLULAR 1114) 
    (INFLAMMATORY 1070 80) 
    (SECOND 1067) 
    (WILD 1067 346) 
    (EPITHELIAL 1054) 
    (STATISTICAL 1049 314) 
    (FEW 1043) 
    (MUTATIONAL 1041) 
    (LESS 1023) 
    (SECONDARY 997 492) 
    (DISTINCT 986 605) 
    (PAPILLARY 966) 
    (INTESTINAL 955 52) 
    (NOVEL 917 185) 
    (INVASIVE 892 61) 
    (FREQUENT 865 232) 
    (WESTERN 845 652) 
    (HEALTHY 845 395) 
    (HISTOLOGICAL 842) 
    (SURGICAL 827 121) 
    (STABLE 819 675) 
    (MUCOSAL 812) 
    (SELECTIVE 804 202) 
    (BENIGN 803 57) 
    (CORRESPONDING 794 305) 
    (SUBSEQUENT 794 412) 
    (FOLLICULAR 792) 
    (EPIGENETIC 781) 
    (PRECLINICAL 780) 
    (ACUTE 776 316) 
    (CONVENTIONAL 772 359) 
    (ADVERSE 770 214) 
    (RARE 763 255) 
    (AGGRESSIVE 755 235) 
    (ESOPHAGEAL 746) 
    (RAS 735) 
    (GASTROINTESTINAL 729 51) 
    (SEVERE 719 473) 
    (PHOSPHORYLATED 709) 
    (COLONIC 706) 
    (SPORADIC 702 46) 
    (COMBINED 689 154) 
    (CUTANEOUS 687) 
    (SOLID 684 292) 
    (ENDOTHELIAL 662) 
    (PARTIAL 661 243) 
    (QUANTITATIVE 660 360) 
    (TRANSCRIPTIONAL 660) 
    (REGULATORY 653 206) 
    (UPPER 653 458) 
    (PROSPECTIVE 647 88) 
    (NCT 635) 
    (OVARIAN 635) 
    (RECURRENT 630 98) 
    (ADJUVANT 625) 
    (UNTREATED 613) 
    (BINDING 612 217) 
    (RETROSPECTIVE 610) 
    (CONSTITUTIVE 600 39) 
    (APOPTOTIC 591) 
    (PROXIMAL 588 48) 
    (ENHANCED 586 106) 
    (INHIBITORY 586) 
    (VASCULAR 579 60) 
    (ABERRANT 575) 
    (ORAL 570 149) 
    (UNKNOWN 570 452) 
    (INTRACELLULAR 554 91) 
    (LAST 552) 
    (ELEVATED 551 40) 
    (PROMISING 548 79) 
    (INDICATED 546) 
    (POTENT 543 57) 
    (CHROMOSOMAL 541) 
    (CYTOTOXIC 541) 
    (RECTAL 541 45) 
    (REAL-TIME 539 89) 
    (SYSTEMIC 539 86) 
    (DIFFERENTIAL 524 158) 
    (EPIDERMAL 520) 
    (DISTANT 510 120) 
    (PATHOLOGICAL 510 46) 
    (MITOCHONDRIAL 499 92) 
    (MULTIVARIATE 492) 
    (MURINE 484) 
    (SQUAMOUS 476) 
    (CONSECUTIVE 471) 
    (CYTOPLASMIC 471 46) 
    (BASAL 470 55) 
    (ENDOGENOUS 469 58) 
    (METABOLIC 467 146) 
    (DAILY 462 374) 
    (REPRESENTATIVE 462 210) 
    (ONGOING 458 162) 
    (RENAL 457 68) 
    (DUAL 449 188) 
    (TRANSGENIC 448) 
    (PROGRESSION-FREE 436) 
    (SUBMUCOSAL 434) 
    (PRIOR 432 144) 
    (DISTAL 427 68) 
    (EXCLUSIVE 426 187) 
    (CATALYTIC 424 64) 
    (OBSERVED 416 169) 
    (NEOPLASTIC 415) 
    (THIRD 414) 
    (STROMAL 413) 
    (ANAPLASTIC 412) 
    (SUPPLEMENTARY 410 62) 
    (SYNERGISTIC 408) 
    (EXACT 407 320) 
    (UNCLEAR 405 175) 
    (COMPARABLE 402 170) 
    (PERIPHERAL 401 153) 
    (ULCERATIVE 399) 
    (CHEMOTHERAPEUTIC 394) 
    (MODERATE 394 181) 
    (BILIARY 392) 
    (VIRAL 392 90) 
    (STENT 388) 
    (OPTIMAL 386 272) 
    (PARENTAL 380 181) 
    (MITOTIC 371) 
    (MEDIAN 370 89) 
    (DETECTABLE 369 39) 
    (REFRACTORY 368) 
    (PROGRESSIVE 359 203) 
    (PEDIATRIC 357) 
    (SELECTED 357 220) 
    (ABNORMAL 355 144) 
    (HETEROGENEOUS 354 40) 
    (ABDOMINAL 352 142) 
    (ACID 351) 
    (GI 349) 
    (ALTERED 347 65) 
    (MESENCHYMAL 345) 
    (UPSTREAM 345) 
    (BIOCHEMICAL 342 52) 
    (HEPATIC 342 47) 
    (MELANOCYTIC 342) 
    (HETEROZYGOUS 340) 
    (INACTIVE 336 41) 
    (UVEAL 331) 
    (FLUORESCENT 328) 
    (HOMOZYGOUS 328) 
    (IBD 326) 
    (CONCOMITANT 324) 
    (NEXT 323) 
    (INTRINSIC 319 230) 
    (PRELIMINARY 319 169) 
    (ADJACENT 318 76) 
    (ROUTINE 315) 
    (CLINICOPATHOLOGICAL 314) 
    (HYPERPLASTIC 314) 
    (PD 313) 
    (PROLIFERATIVE 313) 
    (FOCAL 310 79) 
    (PUTATIVE 309) 
    (SENESCENT 307) 
    (UPREGULATED 306) 
    (PROLONGED 301 85) 
    (PERSONALIZED 299) 
    (ROBUST 299 102) 
    (REVERSE 295 81) 
    (MITOGEN-ACTIVATED 292) 
    (KNOCKDOWN 290) 
    (BASELINE 287) 
    (FAMILIAL 286 55) 
    (ML 283) 
    (IMMUNOHISTOCHEMICAL 282) 
    (MAMMALIAN 282 42) 
    (MANY 280) 
    (ANIMAL 279) 
    (WILD-TYPE 279) 
    (VARIANT 274) 
    (ABSENT 272 164) 
    (ANTI-APOPTOTIC 269) 
    (TRANSIENT 269 82) 
    (MILD 260 138) 
    (PHARMACOLOGICAL 260) 
    (ADULT 258 51) 
    (NON 258) 
    (DIFFUSE 255) 
    (MINOR 252 201) 
    (SUSTAINED 251 85) 
    (EXOSOMAL 250) 
    (PHYSIOLOGICAL 249 167) 
    (ENDOMETRIAL 246) 
    (HIGH-GRADE 246) 
    (MUCINOUS 244) 
    (CLONAL 242) 
    (MARKED 240 122) 
    (SEQUENTIAL 240 92) 
    (NUDE 236) 
    (MYELOID 234) 
    (RECOMBINANT 233) 
    (RESPECTIVE 233 187) 
    (ADENOMATOUS 232) 
    (HISTOLOGIC 232) 
    (POSTOPERATIVE 232) 
    (PHENOTYPIC 231) 
    (CONFOCAL 230) 
    (PRO-APOPTOTIC 229) 
    (LIVE 227 99) 
    (DUODENAL 226) 
    (INFORMED 225 118) 
    (SUPERFICIAL 225 73) 
    (ISOLATED 224 156) 
    (PREVALENT 224 123) 
    (OXIDATIVE 223 66) 
    (TRIPLE 221 78) 
    (EMBRYONIC 219 106) 
    (BOVINE 217 59) 
    (AUTOIMMUNE 213) 
    (MORPHOLOGICAL 213 106) 
    (HISTOPATHOLOGICAL 212) 
    (LOGISTIC 212) 
    (FAVORABLE 211) 
    (FETAL 208) 
    (MIXED 207 167) 
    (UNDIFFERENTIATED 207) 
    (RESECTED 206) 
    (FROZEN 205 86) 
    (OS 204) 
    (Α 203) 
    (SOLUBLE 199 128) 
    (PERSISTENT 198 100) 
    (JNK 197) 
    (UNIVARIATE 197) 
    (CULTURED 196) 
    (DURABLE 194) 
    (HEREDITARY 194) 
    (INNATE 194 120) 
    (SESSILE 193) 
    (POOLED 192) 
    (TOXIC 192 79) 
    (Β 191) 
    (SIMULTANEOUS 189 101) 
    (AFFECTED 187 82) 
    (SEROUS 187) 
    (KNOCK-DOWN 186) 
    (CERVICAL 185) 
    (NUCLEIC 183 45) 
    (FECAL 182) 
    (HEPATOCELLULAR 182) 
    (SYNTHETIC 182 107) 
    (SUBCUTANEOUS 181) 
    (INTERCELLULAR 180) 
    (MICROSCOPIC 180 55) 
    (PREOPERATIVE 180) 
    (ANAL 179) 
    (CYTOLOGICAL 179) 
    (IMPAIRED 179) 
    (MODEST 179 56) 
    (DENDRITIC 178) 
    (OESOPHAGEAL 178) 
    (CANONICAL 177) 
    (ENDOCRINE 177) 
    (FATTY 177 76) 
    (UNRESECTABLE 177) 
    (HIGH-RISK 175) 
    (PREDOMINANT 175 99) 
    (ALLELIC 172) 
    (CONCURRENT 172 48) 
    (ELIGIBLE 172 43) 
    (TRANSFECTED 172) 
    (TUMORIGENIC 172) 
    (INTACT 171 108) 
    (CUMULATIVE 170 52) 
    (DYSPLASTIC 169) 
    (ECTOPIC 169 51) 
    (INCOMPLETE 168 106) 
    (HER 167) 
    (ATYPICAL 165 42) 
    (CURATIVE 165) 
    (VISCERAL 164) 
    (FORMALIN-FIXED 163) 
    (AUTOMATED 162 58) 
    (TRANSLATIONAL 162) 
    (DEFICIENT 161 45) 
    (LATTER 160) 
    (PROTECTIVE 159 93) 
    (SERIAL 159 120) 
    (COSMIC 158) 
    (UNSELECTED 157) 
    (MEDULLARY 156) 
    (SPONTANEOUS 156 100) 
    (DOSE-DEPENDENT 155) 
    (NK 154) 
    (NODAL 153) 
    (STANDARDIZED 153) 
    (INDUCIBLE 152) 
    (LETHAL 151 50) 
    (OWN 151) 
    (PULMONARY 151 98) 
    (DOWNREGULATED 149) 
    (MAXIMAL 149) 
    (PARADOXICAL 149 68) 
    (MECHANISTIC 148) 
    (REACTIVE 148 89) 
    (PATHOLOGIC 147) 
    (RESPONSIVE 146 68) 
    (SUPERNATANT 146) 
    (ALLOSTERIC 145) 
    (NON-INVASIVE 145) 
    (COMBINATORIAL 144) 
    (HIERARCHICAL 144 112) 
    (SYMPTOMATIC 144 47) 
    (EGFR-TARGETED 143) 
    (ANGIOGENIC 143) 
    (UP-REGULATED 143) 
    (ANTI-CANCER 142) 
    (BIOLOGIC 142) 
    (INTRAEPITHELIAL 142) 
    (REVERSIBLE 142 41) 
    (ANTI 141 77) 
    (IMMUNOSUPPRESSIVE 141) 
    (ER 140) 
    (GENOME-WIDE 140) 
    (ANTIAPOPTOTIC 139) 
    (EOSINOPHILIC 139) 
    (INTRAVENOUS 139) 
    (LENTIVIRAL 139) 
    (LUMINAL 139) 
    (PHARMACODYNAMIC 139) 
    (TERTIARY 139 56) 
    (COMPOUND 138) 
    (WELL-DIFFERENTIATED 137) 
    (EVALUABLE 136) 
    (MTOR 134) 
    (CELL 133) 
    (ANTI-INFLAMMATORY 133) 
    (IRRITABLE 133) 
    (PIVOTAL 133 54) 
    (PRO-INFLAMMATORY 133) 
    (SYNCHRONOUS 133 52) 
    (LARGE-SCALE 132 77) 
    (ASYMPTOMATIC 131) 
    (EXPERIENCED 131 101) 
    (HYDROPHOBIC 131 52) 
    (ACRAL 130) 
    (DISEASE-FREE 130) 
    (PARAFFIN-EMBEDDED 130) 
    (DELAYED 128 39) 
    (GOLD 128) 
    (HEMATOPOIETIC 128) 
    (MATURE 128 96) 
    (VILLOUS 128) 
    (SD 127) 
    (LAPAROSCOPIC 127) 
    (DOWN-REGULATED 125) 
    (EFFICACIOUS 125) 
    (PERIANAL 125) 
    (SUPPRESSIVE 125) 
    (ANTI-ANGIOGENIC 124) 
    (DIGESTIVE 124 42) 
    (PILOCYTIC 124) 
    (UM 123) 
    (ACQUIRED 123) 
    (LYMPHOCYTIC 122) 
    (SINGLE-AGENT 122) 
    (CELL-DERIVED 120) 
    (POLYCLONAL 120) 
    (REPRODUCIBLE 120) 
    (PRE-CLINICAL 119) 
    (EX 118) 
    (RECIPIENT 118) 
    (PROTEASOME 117) 
    (UNCHANGED 117 66) 
    (PS 116) 
    (CONFORMATIONAL 116) 
    (PREMALIGNANT 116) 
    (WT 116) 
    (DISCORDANT 115) 
    (EXOGENOUS 115 59) 
    (NEOADJUVANT 115) 
    (SUSPECTED 115) 
    (TUMOR-SPECIFIC 115) 
    (ENZYMATIC 114) 
    (NEURONAL 114) 
    (PLATELET-DERIVED 114) 
    (FULL-LENGTH 113) 
    (OVERNIGHT 113) 
    (PROAPOPTOTIC 113) 
    (UNDERWAY 113) 
    (PTEN 112) 
    (PROTEOMIC 112) 
    (SEQUENCED 112) 
    (STRIKING 112 84) 
    (UNMETHYLATED 112) 
    (CYSTIC 111 61) 
    (H. 111) 
    (OVERLAPPING 111 49) 
    (UNCOMMON 111 63) 
    (INDETERMINATE 110) 
    (MULTIPLEX 110) 
    (NON-NEOPLASTIC 110) 
    (C-TERMINAL 109) 
    (CYCLIN-DEPENDENT 109) 
    (ORTHOTOPIC 109) 
    (POST-TREATMENT 109) 
    (NIS 108) 
    (ANTI-PROLIFERATIVE 108) 
    (HOMOLOGOUS 108 56) 
    (N-TERMINAL 107) 
    (CIRRHOTIC 107) 
    (NON-SPECIFIC 107) 
    (PERITONEAL 107) 
    (PROPHYLACTIC 107) 
    (UNCONTROLLED 107) 
    (UNSUPERVISED 107) 
    (WELL-KNOWN 107 63) 
    (SUBCELLULAR 106) 
    (IMMUNOHISTOCHEMICAL 105) 
    (CANCER-RELATED 105) 
    (NODULAR 105) 
    (UNPUBLISHED 105) 
    (DEFINITIVE 104 77) 
    (LYMPHATIC 104) 
    (CONDITIONAL 103 51) 
    (HEMATOLOGICAL 103) 
    (MAMMARY 103) 
    (GLUTAMIC 102) 
    (ESD 101) 
    (ETS 101) 
    (COMPENSATORY 101) 
    (FORMER 101) 
    (CYTOSTATIC 100) 
    (FORWARD 100 67) 
    (PATHOGENIC 100) 
    (POST-TRANSLATIONAL 100) 
    (RIGHT-SIDED 100) 
    (TUBULAR 100) 
    (ML 99) 
    (MUCH 99) 
    (PARP 98) 
    (COELIAC 98) 
    (CYTOSOLIC 98) 
    (ADDITIVE 96) 
    (CANCER-SPECIFIC 96) 
    (DEFECTIVE 96 56) 
    (SIGMOID 96) 
    (TWO-SIDED 96) 
    (ALLELE-SPECIFIC 95) 
    (OCCULT 95) 
    (TWO-TAILED 95) 
    (ADOPTIVE 94) 
    (ANATOMICAL 94 43) 
    (FOURTH 94) 
    (IMMUNOLOGICAL 94) 
    (LYMPHOID 94) 
    (MACROSCOPIC 94) 
    (MICROSATELLITE 94) 
    (REPORTED 94 59) 
    (CANCEROUS 93) 
    (CHIMERIC 93) 
    (HYPOXIC 93) 
    (ILEAL 93) 
    (SIGNAL-REGULATED 93) 
    (UNAFFECTED 93 74) 
    (UNDETECTABLE 93) 
    (CTEN 92) 
    (FLUID 92) 
    (FDA-APPROVED 91) 
    (GENOMIC 91 38) 
    (APICAL 91) 
    (CONCORDANT 91) 
    (PIGMENTED 91) 
    (GERMLINE 89) 
    (INFORMATIVE 89 62) 
    (MIR- 89) 
    (RIBOSOMAL 89) 
    (ALTERNATE 88) 
    (ARCHIVAL 88) 
    (DELETERIOUS 88) 
    (MITOGENIC 88) 
    (RADIOLOGICAL 88) 
    (UV-INDUCED 87) 
    (FAECAL 87) 
    (NECROTIC 87) 
    (AZD 86) 
    (ADRENAL 86) 
    (CLINICOPATHOLOGIC 86) 
    (HOMOGENEOUS 86 57) 
    (SUBJECT 86) 
    (BRAF-MUTANT 85) 
    (ACINAR 85) 
    (INFILTRATIVE 85) 
    (INFREQUENT 85) 
    (SPLENIC 85) 
    (ANTIPROLIFERATIVE 84) 
    (INTRIGUING 84) 
    (PROGRAMMED 84) 
    (DIPLOID 83) 
    (DUCTAL 83) 
    (NOTEWORTHY 83) 
    (PALLIATIVE 83 41) 
    (POPULATION-BASED 83) 
    (BRAF-MUTATED 82) 
    (MS 82) 
    (DISEASE-SPECIFIC 82) 
    (LOCALIZED 82) 
    (NON-SYNONYMOUS 82) 
    (PRONOUNCED 82 44) 
    (CAUCASIAN 81) 
    (CAUSATIVE 81) 
    (CELIAC 81) 
    (DYSREGULATED 81) 
    (EPIDEMIOLOGICAL 81) 
    (GASTROESOPHAGEAL 81) 
    (MONONUCLEAR 81) 
    (RETROVIRAL 81) 
    (SURROGATE 81) 
    (METACHRONOUS 80) 
    (TRUNCATED 80) 
    (UNPAIRED 80) 
    (EUS 79) 
    (UNIVARIATE 79) 
    (ANTIANGIOGENIC 79) 
    (DOUBLE-BLIND 79) 
    (AKT 78) 
    (HALF 78) 
    (STEPWISE 78) 
    (TELOMERIC 78) 
    (GIANT 77 43) 
    (ONCOGENE-INDUCED 77) 
    (VESICULAR 77) 
    (AUTOLOGOUS 76) 
    (MEASURABLE 76 47) 
    (PEPTIC 76) 
    (PERCUTANEOUS 76) 
    (TRIPLICATE 76) 
    (TUMOR-DERIVED 76) 
    (URINARY 76 49) 
    (CYTOGENETIC 75) 
    (HIGH-LEVEL 75) 
    (INSENSITIVE 75) 
    (NON-METASTATIC 75) 
    (OVERT 75 55) 
    (PHARMACEUTICAL 75 46) 
    (POLYPOID 75) 
    (TANDEM 75) 
    (ATP-COMPETITIVE 74) 
    (CORE 74) 
    (MIGRATORY 74) 
    (PATIENT-DERIVED 74) 
    (PHARMACOLOGIC 74) 
    (TH 73) 
    (ANATOMIC 73) 
    (ATROPHIC 73) 
    (OBESE 73 55) 
    (OVEREXPRESSED 73) 
    (PHARMACOKINETIC 73) 
    (PRE-TREATED 73) 
    (XENOGRAFTED 73) 
    (ANCHORAGE-INDEPENDENT 72) 
    (ATHYMIC 72) 
    (CATEGORICAL 72) 
    (MYOGENIC 72) 
    (AUTOPHAGY 71) 
    (BORDERLINE 71) 
    (CANCER-ASSOCIATED 71) 
    (HYPERMETHYLATED 71) 
    (INTRACRANIAL 71) 
    (POLYPLOID 71) 
    (PRO-SURVIVAL 71) 
    (SUSPICIOUS 71 46) 
    (CYTOMETRIC 70) 
    (INVESTIGATIONAL 70) 
    (SERUM-FREE 70) 
    (TUMOR-ASSOCIATED 70) 
    (CYTOSKELETAL 69) 
    (EXTRATHYROIDAL 69) 
    (MORPHOLOGIC 69) 
    (NON-MALIGNANT 69) 
    (OBSERVATIONAL 69 43) 
    (PROTEASOMAL 69) 
    (VEMURAFENIB-RESISTANT 69) 
    (AMENABLE 68) 
    (BIOTINYLATED 68) 
    (DERMAL 68) 
    (NEUTROPHIL 67) 
    (NON-AGGRESSIVE 67) 
    (QUIESCENT 67) 
    (TUMORAL 67) 
    (ADJUSTED 66 38) 
    (ARTERIAL 66 38) 
    (RADIAL 66 52) 
    (THREE-DIMENSIONAL 66 40) 
    (Μ 66) 
    (EXPANDED 65) 
    (HYBRID 65 51) 
    (IRREVERSIBLE 65 42) 
    (TOPICAL 65) 
    (VENOUS 65) 
    (ANASTOMOTIC 64) 
    (ANTIBIOTIC 64) 
    (CARCINOGENIC 64) 
    (DUPLICATE 64) 
    (SOLVENT 64) 
    (ADIPOSE 63) 
    (ANTAGONISTIC 63) 
    (COGNATE 63) 
    (DIM 63) 
    (ENOUGH 63) 
    (INSULIN-LIKE 63) 
    (MUTATION-SPECIFIC 63) 
    (TRANSDUCED 63) 
    (TREATMENT-RELATED 63) 
    (WELL-ESTABLISHED 63) 
    (ANTITUMOR 62) 
    (AUTOSOMAL 62) 
    (DYSFUNCTIONAL 62) 
    (INDOLENT 62) 
    (PREVENTIVE 62) 
    (SECRETORY 62) 
    (CONGENITAL 61) 
    (DIMINISHED 61) 
    (DIMINUTIVE 61) 
    (ELUSIVE 61) 
    (IRINOTECAN 61) 
    (PRECANCEROUS 61) 
    (REGULATED 61 40) 
    (DTIC 60) 
    (ADHERENT 60) 
    (NON-CODING 60) 
    (OBSCURE 60) 
    (ONE-WAY 60) 
    (PAEDIATRIC 60) 
    (ANORECTAL 59) 
    (CECAL 59) 
    (IMMUNOGENIC 59) 
    (IRRADIATED 59) 
    (ONCOCYTIC 59) 
    (PHOSPHORYLATE 59) 
    (TRANSMEMBRANE 59) 
    (UNFAVORABLE 59) 
    (EROSIVE 58) 
    (OCULAR 58) 
    (SPECIALIZED 58 43) 
    (WORTH 58) 
    (LOW-RISK 57) 
    (NONSPECIFIC 57) 
    (POST-OPERATIVE 57) 
    (SUN-EXPOSED 57) 
    (SUPPLEMENTAL 57) 
    (C-REACTIVE 56) 
    (COMPELLING 56) 
    (HELICAL 56) 
    (HORMONAL 56) 
    (IMMUNOMODULATORY 56) 
    (PLASTIC 56) 
    (PREFERENTIAL 56 45) 
    (X-AXIS 56) 
    (ANTIGEN-SPECIFIC 55) 
    (ANTIVIRAL 55) 
    (CELL-BASED 55) 
    (CELL-FREE 55) 
    (COLONOSCOPIC 55) 
    (FLUVASTATIN 55) 
    (GRADIENT 55) 
    (MEMBRANOUS 55) 
    (MULTIFOCAL 55) 
    (NON-TREATED 55) 
    (PLEOMORPHIC 55) 
    (PROTEOLYTIC 55) 
    (PURPLE 55 38) 
    (RETROGRADE 55) 
    (SALINE 55) 
    (SCRAMBLED 55) 
    (VEHICLE-TREATED 55) 
    (WELL-DEFINED 55) 
    (ERK 54) 
    (CO-STIMULATORY 54) 
    (CONTRARY 54) 
    (INHERITED 54) 
    (INTRAPERITONEAL 54) 
    (PORCINE 54) 
    (RESECTABLE 54) 
    (SPINAL 54) 
    (TUMOR-SUPPRESSOR 54) 
    (NT 53) 
    (DRUG-INDUCED 53) 
    (ELECTROSTATIC 53) 
    (ENTERIC 53) 
    (INTRATUMORAL 53) 
    (PARACRINE 53) 
    (TAIL 53) 
    (TIME-DEPENDENT 53) 
    (Y-AXIS 53) 
    (FISH 52) 
    (AUTOCRINE 52) 
    (DRUGGABLE 52) 
    (ENDOPLASMIC 52) 
    (GRAY 52) 
    (PLACENTAL 52) 
    (PROINFLAMMATORY 52) 
    (RANK 52) 
    (EUS-GUIDED 51) 
    (IL 51) 
    (CLINICO-PATHOLOGICAL 51) 
    (COMPOSITE 51 40) 
    (ELECTIVE 51) 
    (HEMATOLOGIC 51) 
    (IN-FRAME 51) 
    (MYELOGENOUS 51) 
    (NEONATAL 51) 
    (NON-CANCEROUS 51) 
    (PRE-MALIGNANT 51) 
    (GTP-BOUND 50) 
    (PCR-BASED 50) 
    (ANTHROPOMETRIC 50) 
    (DISAPPOINTING 50) 
    (GLYCOLYTIC 50) 
    (ICE-COLD 50) 
    (ITERATIVE 50 38) 
    (LEFT-SIDED 50) 
    (NEUROENDOCRINE 50) 
    (S 50) 
    (TISSUE-SPECIFIC 50) 
    (UROTHELIAL 50) 
    (BETA 49) 
    (HISTOPATHOLOGIC 49) 
    (IMMORTAL 49 40) 
    (IMMUNOTHERAPEUTIC 49) 
    (NORMOXIC 49) 
    (PRO-ANGIOGENIC 49) 
    (REPLICATE 49) 
    (FBXW 48) 
    (NON 48) 
    (AGE-RELATED 48) 
    (DERIVATIVE 48) 
    (EXPLORATORY 48 39) 
    (FIFTH 48) 
    (INTERMITTENT 48 38) 
    (INTERSTITIAL 48) 
    (PATHOGENETIC 48) 
    (DRUG-RELATED 47) 
    (ISCHEMIC 47) 
    (LYMPHOBLASTIC 47) 
    (NON-CANONICAL 47) 
    (PELVIC 47) 
    (RELAPSE-FREE 47) 
    (TRANSVERSE 47) 
    (UNBIASED 47 39) 
    (AGAROSE 46) 
    (CHEMOPREVENTIVE 46) 
    (COST-EFFECTIVE 46) 
    (DOTTED 46) 
    (NAIVE 46) 
    (RESTING 46) 
    (UTERINE 46) 
    (VARICEAL 46) 
    (CLINICOPATHOLOGICAL 45) 
    (MD 45) 
    (ANTI-EGFR 45) 
    (CETUXIMAB-BASED 45) 
    (LEUKEMIC 45) 
    (LYSOSOMAL 45) 
    (NITRIC 45) 
    (PERITUMORAL 45) 
    (POSTPRANDIAL 45) 
    (Β-CATENIN 45) 
    (AMPULLARY 44) 
    (CIRCUMFERENTIAL 44) 
    (CROSS-VALIDATION 44) 
    (FOLATE 44) 
    (IMMATURE 44) 
    (LENTIGINOUS 44) 
    (MUTATION-POSITIVE 44) 
    (ONCOLYTIC 44) 
    (PEAK 44) 
    (POST-TRANSCRIPTIONAL 44) 
    (PRETREATED 44) 
    (REPLICATIVE 44) 
    (SUPRATENTORIAL 44) 
    (ULTRAVIOLET 44) 
    (EXPRESS 43) 
    (FIVE-YEAR 43) 
    (JEJUNAL 43) 
    (MEDIASTINAL 43) 
    (MICRODISSECTED 43) 
    (PENILE 43) 
    (PHYSIOLOGIC 43) 
    (ASTROCYTIC 42) 
    (HERITABLE 42) 
    (MANAGEABLE 42) 
    (MESENTERIC 42) 
    (NON-TUMORIGENIC 42) 
    (STOCHASTIC 42) 
    (UNSTIMULATED 42) 
    (WEIGHTED 42) 
    (WELL-CHARACTERIZED 42) 
    (AGILENT 41) 
    (IRANIAN 41) 
    (CONCEIVABLE 41) 
    (ENDOSOMAL 41) 
    (EUTHANIZED 41) 
    (ISOGENIC 41) 
    (PAIRWISE 41) 
    (PROSURVIVAL 41) 
    (RADIOGRAPHIC 41) 
    (SENESCENCE-ASSOCIATED 41) 
    (SUBCLONAL 41) 
    (SUBEPITHELIAL 41) 
    (ABOVE-MENTIONED 40) 
    (ALLERGIC 40) 
    (AMINO-ACID 40) 
    (ANTI-CD 40) 
    (DEADLY 40) 
    (ENTERAL 40) 
    (INTRAHEPATIC 40) 
    (LEAD 40) 
    (MULTIPLEXED 40) 
    (OLIGODENDROGLIAL 40) 
    (OUTLYING 40) 
    (THYROID-SPECIFIC 40) 
    (TOLERABLE 40) 
    (ACTIONABLE 39) 
    (CANINE 39) 
    (CEREBELLAR 39) 
    (CONFLUENT 39) 
    (CORRELATIVE 39) 
    (MULTIVESICULAR 39) 
    (REGENERATIVE 39) 
    (UNACTIVATED 39) 
    (Χ 39) 
    (CBD 38) 
    (MITOGEN-ACTIVATED 38) 
    (PROGRESSION-FREE 38) 
    (AFFERENT 38) 
    (CYTOKINE 38) 
    (ENDOMETRIOID 38) 
    (EPITHELIOID 38) 
    (GLANDULAR 38) 
    (IMMUNE-RELATED 38) 
    (INSERTIONAL 38) 
    (JUNCTIONAL 38) 
    (LOW-LEVEL 38) 
    (MULTIVARIABLE 38) 
    (MUTAGENIC 38) 
    (NON-SERRATED 38) 
    (PROBIOTIC 38) 
    (PROCOAGULANT 38) 
    (RADIATION-INDUCED 38) 
    (RECESSIVE 38) 
    (NER 37) 
    (UPREGULATED 37) 
    (ATTENUATED 37) 
    (DENSITOMETRIC 37) 
    (ENLARGED 37) 
    (EPITHELIAL-MESENCHYMAL 37) 
    (FALSE-POSITIVE 37) 
    (GENOTYPIC 37) 
    (GYNAECOLOGICAL 37) 
    (METHYLATION-SPECIFIC 37) 
    (PATHOPHYSIOLOGICAL 37) 
    (S.D. 37) 
    (STIMULATORY 37) 
    (STRESS-INDUCED 37) 
    (SUBOPTIMAL 37) 
    (SUN-DAMAGED 37) 
    (TRANSPLANTED 37) 
    (WEAKLY 37) 
    (GENOME-WIDE 36) 
    (BASE 36) 
    (DOWN 36) 
    (EXTRACEREBRAL 36) 
    (GRANULAR 36) 
    (HEMIZYGOUS 36) 
    (HIGH-THROUGHPUT 36) 
    (NON-SMALL-CELL 36) 
    (NONINVASIVE 36) 
    (SIRNA-MEDIATED 36) 
    (VIDEO 36) 
    (CELL-SPECIFIC 35) 
    (CIRCADIAN 35) 
    (CLONOGENIC 35) 
    (COVALENT 35) 
    (DOX 35) 
    (EXTRAHEPATIC 35) 
    (IRINOTECAN-BASED 35) 
    (MULTINODULAR 35) 
    (SEROLOGICAL 35) 
    (SINGLE-STRANDED 35) 
    (UNIDENTIFIED 35) 
    (UNSTAINED 35) 
    (Κ 35) 
    (ANEUPLOID 34) 
    (DISCREPANT 34) 
    (DOMINANT-NEGATIVE 34) 
    (GENOTOXIC 34) 
    (GENOTYPING 34) 
    (HAIRY 34) 
    (INCURABLE 34) 
    (NUTRIENT 34) 
    (P.I. 34) 
    (PIECEMEAL 34) 
    (POLYMORPHIC 34) 
    (PROTEIN-COUPLED 34) 
    (ERK-DEPENDENT 33) 
    (ALLOGENEIC 33) 
    (BEING 33) 
    (CARCINOID 33) 
    (COINCIDENT 33) 
    (DILUTED 33) 
    (ENDOCYTIC 33) 
    (ENGINEERED 33) 
    (EXOCRINE 33) 
    (HYPERSENSITIVE 33) 
    (IMMUNODEFICIENT 33) 
    (LYMPHOPROLIFERATIVE 33) 
    (MELANOMA-ASSOCIATED 33) 
    (MONOCYTE-DERIVED 33) 
    (NON-ALCOHOLIC 33) 
    (NON-TRANSFORMED 33) 
    (PARIETAL 33) 
    (SALIVARY 33) 
    (SUPERVISED 33) 
    (SYNGENEIC 33) 
    (TRABECULAR 33) 
    (VE 33) 
    (AR 32) 
    (CIMP-HIGH 32) 
    (METABRIC 32) 
    (TGF-Β 32) 
    (CETUXIMAB-TREATED 32) 
    (CONTIGUOUS 32) 
    (DEDIFFERENTIATED 32) 
    (DRUG-RESISTANT 32) 
    (INSOLUBLE 32) 
    (INTRALUMINAL 32) 
    (MEDICINAL 32) 
    (MEMBRANE-BOUND 32) 
    (MICROVESICULAR 32) 
    (NEIGHBORING 32) 
    (OPTIC 32) 
    (OXALIPLATIN-BASED 32) 
    (PHOSPHATE-BUFFERED 32) 
    (POSTTRANSLATIONAL 32) 
    (PULL-DOWN 32) 
    (QUADRUPLE 32) 
    (RESUSPENDED 32) 
    (TIME-CONSUMING 32) 
    (UNDETERMINED 32) 
    (UNINVOLVED 32) 
    (ADVISORY 31) 
    (BINOMIAL 31) 
    (COMPANION 31) 
    (EPIDEMIOLOGIC 31) 
    (IMMUNE-MEDIATED 31) 
    (IMMUNOCHEMICAL 31) 
    (IMMUNOLOGIC 31) 
    (LIFE-THREATENING 31) 
    (PLEIOTROPIC 31) 
    (POSTNATAL 31) 
    (REFRACTIVE 31) 
    (RS 31) 
    (TETRAPLOID 31) 
    (ETS 30) 
    (MSI-HIGH 30) 
    (PTC-DERIVED 30) 
    (PUBMED 30) 
    (AUTOPHAGIC 30) 
    (BIOACTIVE 30) 
    (BIOINFORMATIC 30) 
    (CELL-LIKE 30) 
    (DISMAL 30) 
    (DOUBLE-STRANDED 30) 
    (EPIGENOMIC 30) 
    (FLUOROPYRIMIDINE-BASED 30) 
    (INTEGRATIVE 30) 
    (INTRAMUCOSAL 30) 
    (INTRONIC 30) 
    (KINASE-IMPAIRED 30) 
    (MELANOCYTE-SPECIFIC 30) 
    (MULTIFACTORIAL 30) 
    (PROANGIOGENIC 30) 
    (SITE-DIRECTED 30) 
    (SYNOVIAL 30) 
    (FOX 29) 
    (GST 29) 
    (MMR-D 29) 
    (NORDIC 29) 
    (AMBULATORY 29) 
    (APPROVED 29) 
    (CHEMOREFRACTORY 29) 
    (CYTOLOGIC 29) 
    (DIVERTICULAR 29) 
    (FIBROTIC 29) 
    (IN-HOUSE 29) 
    (INDISTINGUISHABLE 29) 
    (INFUSIONAL 29) 
    (KNOCKOUT 29) 
    (LYMPHOVASCULAR 29) 
    (MOCK 29) 
    (NON-SIGNIFICANT 29) 
    (SEGMENTAL 29) 
    (SEMINAL 29) 
    (SPARSE 29) 
    (STEM-LIKE 29) 
    (TUMOR-SUPPRESSIVE 29) 
    (VULVAR 29) 
    (Λ 29) 
    (AKT 28) 
    (CIC 28) 
    (FAECAL 28) 
    (BIALLELIC 28) 
    (FALSE-NEGATIVE 28) 
    (HAEMATOPOIETIC 28) 
    (IMMUNOSORBENT 28) 
    (NON-TARGETING 28) 
    (ORGANOTYPIC 28) 
    (PRESUMED 28) 
    (RETINAL 28) 
    (VICE 28) 
    (EP-ICD 27) 
    (OMANI 27) 
    (ANTI-TNFΑ 27) 
    (ANTINEOPLASTIC 27) 
    (ASSESSABLE 27) 
    (BIPARTITE 27) 
    (BIPHASIC 27) 
    (CASPASE 27) 
    (CELL-MEDIATED 27) 
    (CURABLE 27) 
    (CYSTEINE-RICH 27) 
    (ELECTROPHORETIC 27) 
    (ENZYME-LINKED 27) 
    (EPIGASTRIC 27) 
    (GASTRO-INTESTINAL 27) 
    (LARVAL 27) 
    (MODULATORY 27) 
    (MYELOPROLIFERATIVE 27) 
    (NON-MUTATED 27) 
    (OR 27) 
    (OVER-EXPRESSED 27) 
    (PARENTERAL 27) 
    (SIXTH 27) 
    (SYNAPTIC 27) 
    (TARGET-SPECIFIC 27) 
    (TARGETABLE 27) 
    (UNEXPLAINED 27) 
    (UNRESPONSIVE 27) 
    (APOPTOTIC 26) 
    (E-POSITIVE 26) 
    (ID 26) 
    (PCR-AMPLIFIED 26) 
    (PDGFRΑ 26) 
    (TKI-RESISTANT 26) 
    (BULKY 26) 
    (CANCER-DERIVED 26) 
    (CETUXIMAB 26) 
    (DERMATOLOGICAL 26) 
    (DISPARATE 26) 
    (INTRADUCTAL 26) 
    (INTRAEPIDERMAL 26) 
    (INTRAGASTRIC 26) 
    (LOCOREGIONAL 26) 
    (LOGIC 26) 
    (MORPHOGENETIC 26) 
    (POSITIONAL 26) 
    (PRE-OPERATIVE 26) 
    (PRENEOPLASTIC 26) 
    (RETINOIC 26) 
    (STEREOTACTIC 26) 
    (THROMBOTIC 26) 
    (UNTRANSLATED 26) 
    (XENOGRAFT 26) 
    (BD 25) 
    (FRET-BASED 25) 
    (SWISS 25) 
    (AGONISTIC 25) 
    (ARCHIVED 25) 
    (BIDIRECTIONAL 25) 
    (BIOPSIED 25) 
    (COATED 25) 
    (COLITIS-ASSOCIATED 25) 
    (CONJUNCTIVAL 25) 
    (DRUG-TREATED 25) 
    (EQUIVOCAL 25) 
    (FIBROUS 25) 
    (FOLINIC 25) 
    (HETERODIMERIC 25) 
    (HETEROGENOUS 25) 
    (HETEROTRIMERIC 25) 
    (HOMEOSTATIC 25) 
    (HYDROPHILIC 25) 
    (HYPERMUTATED 25) 
    (INHIBITOR-RESISTANT 25) 
    (LIGAND-INDEPENDENT 25) 
    (MULTI-STEP 25) 
    (MULTI-TARGETED 25) 
    (NONSYNONYMOUS 25) 
    (PRONEURAL 25) 
    (SEVENTH 25) 
    (TAILORED 25) 
    (TUBULOVILLOUS 25) 
    (VIROLOGICAL 25) 
    (TRAIL-INDUCED 24) 
    (BASAL-LIKE 24) 
    (GASTRO-ESOPHAGEAL 24) 
    (HIATAL 24) 
    (IATROGENIC 24) 
    (IMMUNOMAGNETIC 24) 
    (LONG-LASTING 24) 
    (OBSTRUCTIVE 24) 
    (OSTEOGENIC 24) 
    (PY 24) 
    (SARCOMATOID 24) 
    (THREE-YEAR 24) 
    (TUBEROUS 24) 
    (TWIN 24) 
    ))
