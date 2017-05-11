;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER COMMON-LISP) -*-
;;; Copyright (c) 2017 SIFT LLC. All Rights Reserved
;;;
;;;    File: "non-cellular-locations"
;;;  Module: "grammar/model/sl/biology/
;;; version: May 2017

;; Broken out from terms 5/8/17
;; contains organs, tissues, tumors, secretions, and organisms/species

(in-package :sparser)

(define-category non-cellular-location  :specializes bio-location
  :instantiates self
  :index (:permanent :key name))

;;;-------------
;;; organs
;;;-------------

(define-category bio-organ :specializes non-cellular-location
  :mixins (has-UID)
  :binds ((organism organism))
  :instantiates self
  :index (:permanent :key name)
  :realization
    (:noun "organ"
     :in organism
     :of organism))

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

;;;-------------
;;; tissue
;;;-------------

(define-category tissue :specializes non-cellular-location
  :mixins (has-UID)
  :binds ((organism organism))
  :instantiates self
  :index (:permanent :key name)
  :realization
    (:noun "tissue"
     :in organism
     :of organism))

;;;-------------
;;; tumor
;;;-------------

(define-category tumor :specializes non-cellular-location
  :mixins (has-UID)
  :binds ((organism organism))
  :instantiates self
  :index (:permanent :key name)
  :realization
    (:noun ("tumor" "tumour")
     :in organism
     :of organism)) ;; should add organ or organ-adjective tumor

;;;-------------
;;; secretions
;;;-------------

;; for fluids, secretions, feces, and other organism substances --
;; currently only used when pulling in terms defined by reach
(define-category secretion :specializes non-cellular-location
  :mixins (has-UID)
  :binds ((organism organism))
  :instantiates self
  :index (:permanent :key name)
  :realization
    (:noun "secretion"
     :in organism
     :of organism))

;;;-------------
;;; organisms
;;;-------------

(define-category mammal :specializes organism
  :mixins (has-UID)
  :instantiates self
  :index (:permanent :key name)
  :realization
    (:noun "mammal"
     :adj "mammalian"))

(noun ("mouse" :plural "mice") :super organism) ;; changed from species to organism
(noun "Xenopus" :super species)
(noun "zebrafish" :super species)
(noun "human" :super species) 

