;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 2013 David D. McDonald  -- all rights reserved
;;;
;;;     File:  "binding-centric"
;;;   Module:  "/interface/mumble/"
;;;  version:  April 2013

;; Broken out from interface 4/7/13

(in-package :sparser)

(defmethod mumble::realize ((c referential-category))
  "The only reason to realize a category is to retrieve
its name to provide a head word."
  (let ((s-word (extract-word-from-category-definition c)))
    (get-mumble-word-for-sparser-word s-word)))

(defmethod mumble::realize ((w word))
  (mumble::find-or-make-word (pname-for w)))

(defmethod mumble::realize ((w polyword))
  (mumble::find-or-make-word (pname-for w)))

(defmethod mumble::realize ((b binding))
  (mumble::make-dtn :referent (realization-for-triple (binding-body b)
                                                      (binding-variable b)
                                                      (binding-value b))))

(defgeneric realization-for-triple (body variable value)
  (:method ((body individual) (v lambda-variable) (value t))
    (push-debug `(,body ,v ,value))
    (let* ((body-shadow (get-nominal-instance (get-sclass (itype-of body))))
           (var-shadow (var-shadow v))
           (*shadows-to-individuals*
            `((,body-shadow . ,body)
              (,var-shadow . ,v))))
      (declare (special *shadows-to-individuals*))
      (funcall #'realization-for-triple body-shadow var-shadow value))))

#|  Kills load until waypoint module is integrated in regular load 
(def-k-method realization-for-triple ((wp waypoint) 
                                      (v (variable nname)) (value t))
  (push-debug `(,wp ,v ,value)) ;;(break "name triple")
  ;; (setq wp (car *) v (cadr *) value (caddr *))
  ;; "the name of waypoint is LVN"
  ;; LVN
  ;; Taps into the realization class for named attributes (hight, color, ...)
  ;; But start simply
  (mumble::predicated-attribute-value :value value :of wp))
|#
    

