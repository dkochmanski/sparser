;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER LISP) -*-
;;; copyright (c) 1992-1999,2014-2016 David D. McDonald  -- all rights reserved
;;; 
;;;     File:  "object"
;;;   Module:  "model;core:numbers:"
;;;  Version:  December 2016

;; 1.2 (7/19/92 v2.3) made over as "real" category. 8/4/94 finished princ routine
;;     (10/3) improved the printer.  11/15/95 added a sort routine.
;; 1.3 (6/12/99) Added referential category for multiplier. 6/25 Added a realization
;;      for number. (9/20) moved over set-illion-distribution since it makes more
;;      sense here along with its category.
;;     (1/10/15) consolidated find-or-make routines here

(in-package :sparser)

;;;---------
;;; objects
;;;---------

(define-category  number
  :instantiates  self
  :specializes   abstract
  :binds ((value :primitive number))
  :index (:key value)
  :documentation "An representation of any sort of
 number. The 'numberical value' of a number individual
 is represented as a bare lisp number bound to the
 value variable of the number. Lets us use a common
 currency for numbers just like the other sorts of
 things that populate models.")
(mark-as-form-category 'number)

(define-mixin-category takes-numerical-value
  :specializes abstract
  :binds ((value :primitive number))
  :documentation "Provides a value variable for things
 that are not themselves numbers but can be viewed a
 them for some purposes or for digit strings that are
 ambbiguous -- notably years.")


(define-category multiplier
  :instantiates self
  :specializes number
  :index (:key name)
  :realization (:common-noun name))


(define-category illions-distribution :specializes index
  :binds ((number number)      ;; #<number 1,110,087.0>
          (illion multiplier)  ;; #<multiplier "million">
          (value number)))     ;; #<number 110>


;;; -----------------------------
;;; making illions-distributions
;;; -----------------------------

;; Nothing in English parses directly to an illions-distribution.
;; We establish them by hand in the various special-purpose
;; routines for numbers. See Set-illion-distribution-from-edge
;; and Apply-multiplier.

(defun set-illion-distribution (number value illion)
  (define-individual 'illions-distribution
    :number number
    :illion illion
    :value value))

    


;;;-------
;;; rules
;;;-------

(define-realization number   ;; "10 million"
  (:tree-family number-of-quantity
   ;; This etf is special purpose to this particular type
   ;; and pattern (/// maybe not a good idea). It calls
   ;; Apply-multiplier to find/make the number object.
   :mapping ((np . :self)
             (modifier . number)
             (np-head . multiplier))))

(assign-bracket number .[np)





;;;----------------
;;; print routines
;;;----------------

;; hook for specialized print routine
(setf (cat-ops-print (cat-operations category::number))
      'print-individual/number)

(defun print-individual/number (n stream)
  (write-string "#<number " stream)
  (let ((word (get-tag :digit-sequence n)))
    (cond
     (word (princ-word word stream))
     ((itypep n 'collection)
      (format stream "{collection: ~(~s ~)} ~s" 
              (value-of 'items n)
              (indiv-uid n)))
     (t (let ((value (value-of 'value n)))  ;; the integer
          (princ value stream))))
    (write-string ">" stream)))



(defun princ-number (n &optional (stream *standard-output*))
  (format stream "~A" (number-value n)))


(defun string/number (n)
  (let ((word (get-tag :digit-sequence n)))
    (if word
        (word-pname word)
        (let ((value (value-of 'value n)))
          (when value ;; can be nil -- don't want to produce "NIL"
            (format nil "~A" value))))))


;;;--------------
;;; sort routine
;;;--------------

#+ccl(define-sort-function 'number 'sort-number-individuals-by-value)

(defun sort-number-individuals-by-value (n1 n2)
  (let ((lisp-number1 (value-of 'value n1))
        (lisp-number2 (value-of 'value n2)))
    (< lisp-number1 lisp-number2)))


;;;-----------
;;; functions
;;;-----------

(defun number-value (indiv-number)
  (value-of 'value indiv-number))

(defgeneric integer-for-number (number)
  (:documentation "Given a number individual, 
    return the integer value it represents")
  (:method ((e edge))
    (integer-for-number (edge-referent e)))
  (:method ((i individual))
    (cond
      ((or (number-ones i) ;; #<ones-number 2>
           (number-teens i) ;;
           (number-tens i))
       (number-value i))
      ((itypep i 'multiplier)
       (let ((n (value-of 'value i)))
         (number-value n)))
      (t (error "Unexpected type of number object: ~a" i)))))


;;;-------------------------------
;;; routines for the plist fields
;;;-------------------------------

(defun number-ones (number)
  (get-tag :ones number))

(defun set-number-ones (number word)
  (setf (get-tag :ones number) word))

(defun number-teens (number)
  (get-tag :teens number))

(defun set-number-teens (number word)
  (setf (get-tag :teens number) word))

(defun number-tens (number)
  (get-tag :tens number))

(defun set-number-tens (number word)
  (setf (get-tag :tens number) word))

(defun number-multiplicand (number)
  (get-tag :multiplicand number))

(defun set-number-multiplicand (number word)
  (setf (get-tag :multiplicand number) word))


;;;--------------
;;; find-or-make
;;;--------------
;; Intended for instances where a function has something
;; in its hand and wants the corresponding number individual

(defun find-number (lisp-number)
  (find-individual 'number :value lisp-number))

;; (get-tag :numerical-value digit-word))

(defgeneric find-or-make-number (value)
  (:documentation "Return the number individual that
    has this numerical value.")

  (:method ((word word))
    (find-or-make-number (word-pname word)))
  (:method ((pname string))
    (let ((lisp-number (read-from-string pname)))
      (assert (numberp lisp-number) ()
              "The string ~s is not a number" pname)
      (find-or-make-number lisp-number)))

  (:method ((lisp-number number))
    (define-or-find-individual 'number 'value lisp-number))

  (:method ((i individual))
    "Used by reify-point-mutation in the odd cases where
     the residue number happens to be the same as one
     of the years we've defined, e.g. the S1986Y or 
     the S1986F mutation"
    (cond
      ((itypep i 'number) i)
      ((itypep i 'takes-numerical-value)
       (define-or-find-individual 'number
           :value (value-of 'value i)))
      ((value-of 'value i)
       ;;/// tally these so can give them the mix-in
       (define-or-find-individual 'number
           :value (value-of 'value i)))
      (t
       (error "Can not make a number individual from ~a~
             ~%which is a ~a" i (type-of i))))))




#|  original stuff

(defstruct (number/obj
            ;; n.b. this can't be a "number" because that's a
            ;; built-in Lisp type
            (:conc-name #:number-)
            (:print-function  print-number-structure))
  rules
  value
  digit-sequence
  plist )


;;;---------------
;;; print routine
;;;---------------

(defun print-number-structure (obj stream depth)
  (declare (ignore depth))
  (write-string "#<number " stream)
  (format stream "~A" (number-value obj))
  (write-string ">" stream))


;;;------------
;;; ancilaries
;;;------------

(setf (cat-index (category-named 'number))
      (make-index/hash-on-slot))

(defun find/number (lisp-number)
  (gethash lisp-number
           (cat-index (category-named/c-symbol 'category::number))))

(defun number-named (lisp-number)
  (unless (numberp lisp-number)
    (error "The argument to Number-named should be a lisp number"))
  (find/number lisp-number))

(defun index/number (lisp-number number)
  (setf (gethash lisp-number
                 (cat-index (category-named/c-symbol 'category::number)))
        number))

(defun delete/number (lisp-number)
  (let ((number (find/number lisp-number)))
    (dolist (rule (number-rules number))
      (delete/cfr rule))
    (remhash lisp-number
             (cat-index (category-named/c-symbol 'category::number)))
    number ))
|#

