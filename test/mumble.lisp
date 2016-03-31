;;; -*- Mode: Lisp; Syntax: COMMON-LISP; Package: MUMBLE -*-
;;; Copyright (c) 2016 SIFT LLC. All Rights Reserved.

(in-package :mumble)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (use-package :rt))

(defvar *me*
  (mumble-value 'first-person-singular 'pronoun))

(defun mumble-said (content)
  (string-left-trim '(#\Space)
                    (with-output-to-string (*mumble-text-output*)
                      (say content))))

(deftest (say nil)
  (mumble-said nil)
  "")

(deftest (say cat)
  (mumble-said (find-word "cat"))
  "cat")

(deftest (say cats)
  (mumble-said (plural (make-dtn :resource (noun (find-word "cat")))))
  "cats")

(deftest (say mice)
  (mumble-said (plural (make-dtn :resource (noun "mouse"))))
  "mice")

(deftest (say snap bone)
  (let ((s *me*)
        (v (present-tense (make-dtn :resource (verb "snap"))))
        (o (always-definite (make-dtn :resource (noun "bone")))))
    (make-complement-node 's s v)
    (make-complement-node 'o o v)
    (mumble-said v))
  "I snap the bone")

(deftest (say snapped bone)
  (let ((s *me*)
        (v (past-tense (make-dtn :resource (verb "snap"))))
        (o (initially-indefinite (make-dtn :resource (noun "bone")))))
    (make-complement-node 's s v)
    (make-complement-node 'o o v)
    (mumble-said v))
  "I snapped a bone")

(deftest (say not drink milk)
    (let ((s *me*)
	  (v (negate (present-tense (make-dtn :resource (verb "drink")))))
	  (o (make-dtn :resource (noun "milk"))))
      (make-complement-node 's s v)
      (make-complement-node 'o o v)
      (mumble-said v))
  "I don't drink milk")

(deftest (say not drank milk)
    (let ((s *me*)
	  (v (negate (past-tense (make-dtn :resource (verb "drink")))))
	  (o (make-dtn :resource (noun "milk"))))
      (make-complement-node 's s v)
      (make-complement-node 'o o v)
      (mumble-said v))
  "I didn't drink milk")
	     
(deftest (say bought milk)
    (let ((s *me*)
	  (v (past-tense (make-dtn :resource (verb (find-word "buy")))))
	  (o (make-dtn :resource (noun "milk"))))
      (make-complement-node 's s v)
      (make-complement-node 'o o v)
      (mumble-said v))
  "I bought milk")
