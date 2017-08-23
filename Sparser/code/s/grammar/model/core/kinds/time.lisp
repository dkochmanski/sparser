;;; -*- Mode: Lisp; Syntax: Common-lisp; -*-
;;; Copyright (c) 2016-2017 David D. McDonald  All Rights Reserved
;;;
;;;      File:  "time"
;;;    Module:  grammar/model/core/kinds/
;;;   version:  August 2017

;; Initiated 2/1/16 to collect the basic parts of the time model
;; so they can be referenced by later modules without worry about
;; the order in which they're loaded.

(in-package :sparser)

;; This just provides a root in the hierarchy for the diverse kinds of
;; time-stuff and their categories of realization.  It isn't intended
;; to ever be instantiated directly, just inherited from

(let ((*inhibit-constructing-comparatives* t))
  (declare (special *inhibit-constructing-comparatives*))

(define-category  time
  :instantiates nil
  :specializes region
  :realization (:noun "time"
                :adj "temporal")
  :documentation "For modeling the stuff, not the verb
 for recording an elapsed period of time or the 'timer'
 that one could use to do that.")

#| This ad-hoc binding of the flag that controls what the
make-rules-for-head (... adjective ...) method does is gross.
But we should have some more examples of what we want before
working up a compact way of saying this. |#

) ;; close let
