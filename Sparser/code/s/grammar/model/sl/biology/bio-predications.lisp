;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER COMMON-LISP) -*-
;;; Copyright (c) 2017 SIFT LLC. All Rights Reserved
;;;
;;;    File: "bio-predications"
;;;  Module: "grammar/model/sl/biology/
;;; version: May 2017

;; Broken out from terms 5/8/17

(in-package :sparser)

(define-category dose-dependent :specializes :bio-predication
  :realization
  (:adj "dose-dependent"))
(def-synonym dose-dependent (:adj "dose dependent"))

(adj "-like" :super bio-predication) ;; as in "UBA (ubiquitin-associated)-like domains" where we don't combine the "-like"
(adj "in excess" :super bio-predication)
(adj "abundant" :super bio-predication)
(adj "nonreducing" :super bio-predication)
(adj "nontargeting" :super bio-predication)
(adj "nondenaturing" :super bio-predication)
(adj "noncoding" :super bio-predication)
(adj "nonmigrating" :super bio-predication)
(adj "deoxy" :super bio-predication)
(adj "unperturbed" :super bio-predication)
;;(adj "bound" :super bio-predication) it is the past tense of bind
(adj "unbound" :super bio-predication)
(adj "dual-specificity" :super bio-predication)
(adj "acidic" :super bio-predication)
(adj "adaptor" :super bio-predication) ;; "adaptor protein"
(adj "allosteric" :super bio-predication) ;; "allosteric activation", "allosteric activator""allosteric charge"
(adj "banded" :super bio-predication)
(adj "apparent" :super bio-predication) ;; perhaps need :rhetorical predication"
(adj "asymmetric" :super bio-predication)
(adj "conventional" :super bio-predication) ;;"conventinal MAPK cascade"
(adj "double-stranded" :super bio-predication)
(adj "single-stranded" :super bio-predication)
(adj "standard" :super bio-predication)
(adj "familial" :super bio-predication)
(adj "nonsignaling" :super bio-predication)
(def-synonym nonsignaling (:adj "nonsignalling"))
(adj "intermolecular" :super bio-predication)
(adj "intramolecular" :super bio-predication)
(adj "lethal" :super bio-predication)
(adj "linear" :super bio-predication)
(adj "hydrophobic" :super bio-predication)
(adj "inhibitory" :super bio-predication)
(adj "obligatory" :super bio-predication)
(adj "adhesion" :super bio-predication) ;; TO-DO need to think about how to define "adhere" to structure

(adj "scaffolding" :super bio-predication) ;; "scaffolding protein"
(adj "resting" :super bio-predication)
(adj "phospho-specific" :super bio-predication) ;; standin for "phospho-specific antibody"
(adj  "dimensional" :super bio-predication)

(adj "additive" :super bio-predication)

(adj "anticancer" :super bio-predication)
(adj "background" :super bio-predication)
(adj "bandee" :super bio-predication)
(adj "biophysical" :super bio-predication)

(adj "candidate" :super bio-predication )
(adj "chemical" :super bio-predication) ;; keyword: (al ADJ) 
;; This should be made more general
(adj "class I" :super bio-predication)
(adj "class II" :super bio-predication)
(adj "clinical" :super bio-predication)
(adj "pre-clinical" :super bio-predication)
(adj "cognate" :super bio-predication)
(adj "combinatorial" :super bio-predication) ;; keyword: (al ADJ) 
(adj "constitutive" :super bio-predication)
(define-adverb "constitutively")
(adj "de novo" :super bio-predication)
(adj "diffuse" :super bio-predication) ;; TO-DO better superc
(adj "ectopic" :super bio-predication) ;; keyword: (ic ADJ) 
(define-adverb "ectopically") ;; keyword: ENDS-IN-LY 
(define-category efficacy :specializes bio-predication
  :realization
  (:noun "efficacy"
         :of subject))

(adj "endogenous" :super bio-predication) ;; keyword: (ous ADJ) 
(adj "enzymatic" :super bio-predication)
;;;(adj "fail-proof" :super bio-predication)

;; we dropped out "follow" as a verb in biology, in favor of using "following" as a
;;  "preposition" and as an adjective
;;(adj "following" :super bio-predication)
(define-category following-adj :specializes bio-predication
                 :realization (:adj "following"))

(adj "nucleotide-free" :super bio-predication)
(adj "general" :super bio-predication)
(adj "genetic" :super bio-predication) 
(adj "housekeeping" :super bio-predication)
(adj "inducible" :super bio-predication) ;; keyword: (ible ADJ) 
(adj "integrative" :super bio-predication) ;; keyword: (ive ADJ) 
(adj "intriguing" :super bio-predication) ;; keyword: ENDS-IN-ING
(adj "kinase-dead" :super bio-predication)
(adj "kinetic" :super bio-predication)
(adj "least-selective" :super bio-predication) ;; just to get through
(adj "living" :super bio-predication)
(adj "molecular" :super bio-predication) ;; It's related to molecule, but how exactly? Seems wrong to jump to "is made of molecules"
(adj "mutagenic" :super bio-predication)
(adj "mutual" :super bio-predication) ;; keyword: (al ADJ) 
(adj "native" :super bio-predication)
(adj "oncogenic" :super bio-predication)
(adj "parallel" :super bio-predication)
(adj "pharmacological" :super bio-predication) ;; keyword: (al ADJ) 
(adj "physiological" :super bio-predication)
(adj "polyclonal" :super bio-predication)
(adj "present" :super bio-predication  ;; keyword: (ent ADJ)
     :binds ((in-molecule molecule))
     :realization
     (:adj "present"
           :in in-molecule))
(adj "prevalent" :super bio-predication)
(adj "putative" :super bio-predication)
(adj "rate-limiting" :super bio-predication)
(adj "real-time" :super bio-predication)
(def-synonym real-time (:adj "real time"))
(adj "recombinant" :super bio-predication)
(adj "responsible" :super bio-predication ;; adj/noun "resposibility"
  :binds ((subject bioloical)(theme bio-entity))
  :realization 
  (:adj "responsible"
        :s subject 
        :for theme))

(noun "restricted substrate" :super bio-predication)
(adj "rich" :super bio-predication) ;; proline rich region
(adj "short-lived" :super bio-predication)
(adj "speckled" :super bio-predication)
(define-category stable :specializes bio-predication
     :realization
     (:adj "stable"))

(delete-adj-cfr (resolve/make "sufficient"))
(adj "sufficient" :super bio-predication
     :binds ((theme biological)
             (sufficient-for biological))
     :realization
     (:adj "sufficient"
           :s theme
           :to-comp sufficient-for))

(adj "supplementary" :super bio-predication) ;; keyword: (ary ADJ)
(adj "synthetic" :super bio-predication)
(adj "unknown" :super bio-predication)
(adj "unmodified" :super bio-predication)
(adj "wild-type" :super bio-predication)
(def-synonym wild-type (:adj "wild type"))
(def-synonym wild-type (:adj "WT"))