;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 2013 David D. McDonald  -- all rights reserved
;;;
;;;     File:  "interval"
;;;   Module:  "model;core:time:"
;;;  version:  July 2013

;; initiated 7/18/13

(in-package :sparser)

;;;------------
;;; the object
;;;------------

;;We will use Allen's formulation of a time interval as a model for the sparser one
;;Each interval has two endpoints (t-, t+)
;;Minimally we should know either t- or t+ (neither have to be overt)
;;then there is an event which takes place relative to the anchor/interval
(define-category  interval
  :specializes time
  :instantiates self
  :binds ((anchor . anchor) ;;doesn't have to be an anchor, just a slot for some timex
          (event . e)) ;;how to relate intervals with multiple events?  is this really correct?
  :realization (:common-noun "interval"))

#|(def-cfr interval (time amount-of-time) ;;this is not an actual interval, only the anchor part of it
  :form np
  :referent(:instantiate-individual interval
            :with (time left-edge amount-of-time right-edge)))|#      
                          


;;;------
;;; form
;;;------

;;Are there any pre-defined intervals?