;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 2016-2017 David D. McDonald  -- all rights reserved
;;;
;;;     File:  "interlocutor"
;;;   Module:  "model/core/mid-level/"
;;;  version:  June 2017

;; Moved out of model/sl/blocks-world/resources.lisp 7/21/16

(in-package :sparser)


(define-category interlocutor
  :specializes physical-agent ;; thinking of us a robot
  ;;:mixins (has-name) ;; don't worry about location or movement yet
  :index (:permanent :key name)
  :documentation "Provides a category to instantiate as the
    basis of 'me', 'you', and 'us'. They need to be grounded
    in the TRIPS state-of-the-conversation model, its goals
    model, our situation model, and our planning model (re. who
    is supposed to do what. 
       The 'name' is just to  have something to display
    that's unlikely to appear in a text. Only the generation 
    direction has been set up.")

(defvar *me*
  (define-individual 'interlocutor :name "machine"))

(defvar *you*
  (define-individual 'interlocutor :name "person"))

(defvar *us*
  (define-individual 'interlocutor :name "persan-and-machine"))


(defun pre-interpret-first-and-second-pronouns (rule category-suffix)
  "Called from define-pronoun just before it returns"
  (case category-suffix
    (first/singular (setf (cfr-referent rule) *me*))
    (second         (setf (cfr-referent rule) *you*))
    (first/plural   (setf (cfr-referent rule) *us*))))


(in-package :mumble)

(defmethod realize ((i (eql sp::*me*)))
  (mumble-value 'first-person-singular 'pronoun))
(defmethod realize ((i (eql sp::*you*)))
  (mumble-value 'second-person-singular 'pronoun))
(defmethod realize ((i (eql sp::*us*)))
  (mumble-value 'first-person-plural 'm::pronoun))
