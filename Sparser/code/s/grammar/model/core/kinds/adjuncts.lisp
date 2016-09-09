;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 2016 David D. McDonald  -- all rights reserved
;;;
;;;     File:  "temporally-localized"
;;;   Module:  "model;core:kinds:"
;;;  version:  September 2016

;; pulled out of terms-to-move 9/2/16


(in-package :sparser)

(define-category event-relation
    :specializes relation
    :binds ((relation)
            (event)
            (subordinated-event)))

(define-category with-certainty
    :specializes event-relation
    :binds ((certainty certainty)))

(define-category temporally-localized
    :specializes with-certainty
    :instantiates :self
    :index (:list)
    :binds ((following process)
            (preceding process)
            (during process)
            (after (:or time-unit
                        time ;; for "any time"
                        amount-of-time))
            (before (:or time-unit time amount-of-time))
            (timeperiod (:or time-unit time amount-of-time))))


