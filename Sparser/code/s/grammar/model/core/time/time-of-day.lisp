;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; Copyright (c) 2008 BBNT Solutions LLC. All Rights Reserved
;;; copyright (c) 2013,2016 David D. McDonald  -- all rights reserved
;;;
;;;     File:  "time-of-day"
;;;   Module:  "model;core:time:"
;;;  version:  July 2016

;; initiated 8/27/08 (CG). 9/23/13 Adding and revising a lot.
;; 4/1/16 Added specialization

(in-package :sparser)

;;;------------------
;;; phase of the day
;;;------------------

(define-category phase-of-day
  :instantiates  self
  :specializes  time-interval
  :binds ((name :primitive word))
  :index (:permanent :key name)
  :realization (:common-noun name))

(defun define-phase-of-day (string)
  ;; hook to add arguments later
  (define-or-find-individual 'phase-of-day :name string))


;;;-------------
;;; time of day
;;;-------------

(define-category time-of-day
  :instantiates  self
  :specializes  time-interval
  :binds ((name :primitive word))
  :index (:permanent :key name)
  :realization (:common-noun name))

(defun define-time-of-day (string)
  ;; hook to add arguments later
  (define-or-find-individual 'time-of-day :name string))


;;;-----------
;;; meal time
;;;-----------

(define-category meal-time ;; sort of similar "having a late dinner"
  :instantiates  self   ;; but lots more content
  :specializes  time-of-day
  :binds ((name :primitive word))
  :index (:permanent :key name)
  :realization (:common-noun name))

(defun define-meal-time (string)
  (define-or-find-individual 'meal-time :name string))



;;;------------
;;; Numeric times
;;;------------

(define-category numeric-time
  :instantiates  self
  :specializes  time-of-day
  :binds ((name :primitive word))
  :index (:permanent :key name)
  :documentation "Intended for 'a.m.' and such, but needs
    work. See dossiers/time-of-day.lisp"
  :realization (:common-noun name))

(defmacro def-numeric-time (string) 
  (let ((word (define-word string))) ;; reuses any already defined word
    (define-individual 'numeric-time
       :name word)))

;;;------------
;;; Time zones
;;;------------

(define-category timezone
  :instantiates  self
  :specializes time
  :mixins (bounded-region  sequential cyclic)
  :binds ((name :primitive word))
  :index (:permanent :key name)
  :realization (:common-noun name))

(defmacro def-timezone (string) 
  ;; offset from GMT is another good argument, also the fully-spelled out
  ;; name, presumably as a polyword ("Eastern Daylight Time").
  ;; Otherwise this is just syntactic sugar
  (let ((word (define-word string))) ;; reuses any already defined word
    (define-individual 'timezone
       :name word)))


;;--- offsets from a timezone
#| These may as well be straight rules since they're idiosyncratic.
But if we see other cases of this sort off "offset" then it would be
better to workup some sort of ETF for the pattern.

N.b. This offset and its direction should also be encoded in the instances
we create, and they ought to be interned (two cases of the same text
string should go to the same object rather than create new ones.
The simplest way to do that is to create a category that specializes
timezone.  |#

;;/// There can be offsets from any timezone 
;; (Nepal is central India + 20 minutes), so these can be generalized.

#| This old scheme of Charlie G's calls into rollout-naries-from-the-left
   and then hits a gratuitous duplication on the second rule because it
   shares a prefix with the first
;;;-----------------------
;;; offsets from Coordinated Universal Time
;;;-----------------------

(def-cfr timezone ("UTC" plus-sign number))
(def-cfr timezone ("UTC" plus-sign number colon number))
(def-cfr timezone ("UTC" hyphen number))
(def-cfr timezone ("UTC" hyphen number colon number))
(def-cfr timezone ("UTC"))

;;;-----------------------
;;; offsets from Greenwich Mean Time
;;;-----------------------

(def-cfr timezone ("GMT" plus-sign number))
(def-cfr timezone ("GMT" plus-sign number colon number))
(def-cfr timezone ("GMT" hyphen number))
(def-cfr timezone ("GMT" hyphen number colon number))
(def-cfr timezone ("GMT"))
|#

