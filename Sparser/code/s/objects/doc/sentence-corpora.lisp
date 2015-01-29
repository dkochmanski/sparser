;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 2015  David D. McDonald  -- all rights reserved
;;;
;;;     File:  "sentence-corpora"
;;;   Module:  "objects/doc/"
;;;  version:  January 2015

;; initiated 1/25/15
;; 1/28/2015 added methods to for building a regression test for sentence semantics
;;  (one stepp beyond just the number of treetops)

(in-package :sparser)

#| For R3 we have organized our different training and testing
texts into files that consist of calls to 'p', one for each
sentence in the passage. We can call these "sentence-corpora"
and setup a regression test that records the number of treetops
in the analysis of a particular sentence and compares it to
previous records of treetop-counts. 
|#


;;--- useful macro -- but what file should it really be in?

(defmacro with-total-quiet (&body body)
  `(let ((*readout-relations* nil)
         (*readout-segments* nil)
         (*readout-segments-inline-with-text* nil) ;; quiet
         (*display-word-stream* nil)
         (*trace-lexicon-unpacking* nil)
         (*trace-morphology* nil)
         (*workshop-window* t)) ;; block tts in p
     (declare (special *readout-relations* *readout-segments*
                       *readout-segments-inline-with-text*
                       *display-word-stream*
                       *trace-lexicon-unpacking* *trace-morphology*
                       *workshop-window*))
     ,@body))

;;;---------
;;; classes
;;;---------

(defclass sentence-corpus (named-object)
  ((snapshots :initform nil :accessor snapshots
    :documentation "Filled by a list of treetop snapshots, most recent first")
   (variable :initform nil :accessor corpus-bound-variable
    :documentation "The variable that's bound to the list of calls to p"))
  (:documentation ""))

(setup-find-or-make 'sentence-corpus)


(defclass treetop-snapshot ()
  ((corpus :initarg :corpus :accessor snapshot-corpus
    :documentation "Backpointer")
   (timestamp :accessor snapshot-timestamp
    :documentation "Readable for for organizing file")
   (pairs :accessor snapshot-pairs
    :documentation "Dotted pair of sentence number and treetop count")))

(defmethod print-object ((ts treetop-snapshot) stream)
  (print-unreadable-object (ts stream :type t)
    (format stream "~a ~a" 
            (name (snapshot-corpus ts))
            (snapshot-timestamp ts))))


;;;---------
;;; methods
;;;---------


;;--- define corpora

(defmacro define-sentence-corpus (name variable &key location doc)
  `(define-sentence-corpus/expr 
       ',name ',variable :location ',location :doc ,doc))

(defun define-sentence-corpus/expr (name variable &key location doc)
  (declare (ignore location doc))
  (let ((sc (find-or-make-sentence-corpus name)))
    (setf (corpus-bound-variable sc) variable)
    sc))
  

;;--- run their sentences

(defmethod run-treetop-snapshot ((name symbol))
  (let ((corpus (get-sentence-corpus name)))
    (unless corpus
      (error "No sentence corpus has been defined with the name ~a" name))
    (run-treetop-snapshot corpus)))

(defmethod run-treetop-snapshot ((corpus sentence-corpus))
  (let ((variable (corpus-bound-variable corpus)))
    (unless variable
      (error "Corpus not set up with a variable"))
    (let ((*readout-relations* nil)
          (*readout-segments* nil)
          (*readout-segments-inline-with-text* nil) ;; quiet
          (*display-word-stream* nil)
          (*trace-lexicon-unpacking* nil)
          (*trace-morphology* nil)
          (*workshop-window* t) ;; block tts in p
          (index 0) pairs )
      (declare (special *readout-relations* *readout-segments*
                        *readout-segments-inline-with-text*
                        *display-word-stream*
                        *trace-lexicon-unpacking* *trace-morphology*
                        *workshop-window*)) 
      (dolist (exp (eval variable)) ;; (p "...")
        (incf index)
        (eval exp)
        (let ((sentence (previous (sentence))))
          ;;(push-debug `(,sentence ,corpus)) (break "check sentence")
          (let ((count (length (treetops-between
                                (starts-at-pos sentence)
                                (ends-at-pos sentence)))))
            (push `(,index . ,count) pairs))))
      (nreverse pairs))))
      
quiet
;;--- package runs into snapshots

(defmethod make-treetop-snapshot ((name symbol))
  (let ((corpus (get-sentence-corpus name)))
    (unless corpus
      (error "No sentence corpus has been defined with the name ~a" name))
    (make-treetop-snapshot corpus)))
      
(defmethod make-treetop-snapshot ((corpus sentence-corpus))
  (let ((pairs (run-treetop-snapshot corpus)))
    (let ((snapshot (make-instance 'treetop-snapshot :corpus corpus)))
      (setf (snapshot-timestamp snapshot)
            (date-&-time-as-formatted-string))
      (setf (snapshot-pairs snapshot) pairs)
      snapshot)))


;;--- write the snapshot to a file 

(defparameter *file-for-treetop-snapshots*
  (concatenate 'string
               "~/sparser/Sparser/code/s/"
               "grammar/tests/citations/code/"
               "treetop-records.lisp")
  "This file is in the loader for citations so it will always be
   included in a load of Sparser")

(defmethod save-treetop-snapshot ((name symbol) 
                                  &optional (file *file-for-treetop-snapshots*))
  (let ((corpus (get-sentence-corpus name)))
    (unless corpus
      (error "No sentence corpus has been defined with the name ~a" name))
    (save-treetop-snapshot corpus)))

(defmethod save-treetop-snapshot ((corpus sentence-corpus)
                                  &optional (file *file-for-treetop-snapshots*))
  (let ((snapshot (make-treetop-snapshot corpus)))
    (with-open-file (stream file
                     :direction :output
                     :if-exists :append
                     :if-does-not-exist :error)
        (write-treetop-snapshot snapshot stream))))

(defun write-treetop-snapshot (snapshot stream)
  (let ((corpus (snapshot-corpus snapshot)))
    (format stream "~&(define-treetop-snapshot ~a ~s"
            (name corpus)
            (snapshot-timestamp snapshot))
    ;; five pairs per line until we have them all
    (let* ((pairs (snapshot-pairs snapshot))
           (remaining-pairs pairs)
           (count-remaining (length pairs))
           five-pairs )
      (flet ((write-pair (pair)
               (format stream " (~a . ~a)"
                       (car pair) (cdr pair)))
             (next-five-pairs ()
               (loop repeat 5
                 collect (pop remaining-pairs))))
        (loop
          (when (> 5 count-remaining)
            (return))
          (terpri stream)
          (setq five-pairs (next-five-pairs))
          (loop for i from 0 to 4 do
            (decf count-remaining)
            (write-pair (nth i five-pairs))))
        (when remaining-pairs ;; no extra line if event
          (terpri stream))
        ;;(push-debug `(,remaining-pairs))
        (loop repeat (length remaining-pairs)
          do  (write-pair (pop remaining-pairs)))
        (format stream ")~%~%")))))
        

;;--- reading them from the file

(defmacro define-treetop-snapshot (corpus-name timestamp &rest pairs)
  `(define-treetop-snapshot/expr ',corpus-name ,timestamp ',pairs))

(defun define-treetop-snapshot/expr (corpus-name timestamp pairs)
  (let* ((corpus (get-sentence-corpus corpus-name))
         (snapshot (make-instance 'treetop-snapshot :corpus corpus)))
    (setf (snapshot-timestamp snapshot) timestamp)
    (setf (snapshot-pairs snapshot) pairs)
    (push snapshot (snapshots corpus))
    snapshot))


;;--- functions for extended regression test

(defun sem-result (sent)
  (with-total-quiet
     (pp sent)
    `(,sent
      ',(loop for edge in (tts-semantics)
          collect (simple-sem edge)))))
  

(defun simple-sem (semtree)
  (cond
   ((consp semtree)
    (cond
     ((individual-p (car semtree))
      (cons
       (let ((s (make-string-output-stream)))
         (string-for-individual (car semtree) s)
         (intern(get-output-stream-string s)))
       (loop for binding in (cdr semtree)
         when (second binding)
         collect
         (list (car binding)
               (simple-sem (second binding))))))))
   (t semtree)))



(defun string-for-individual (i s)
  ;; a 'special-routine' that is used with individuals that
  ;; have a name field, which we assume is bound to a word. 
  ;; This routine is put on the ops-printer field of the category
  ;; at the time the category is defined.
  (declare (special *print-short*))
  (let* ((name (name-of-individual i))
         (word-binding
          (unless name
            (find 'word (indiv-binds i)
                  :key #'(lambda (b)
                           (var-name (binding-variable b))))))
         (word
          (cond (name name)
                (word-binding (binding-value word-binding)))))
    (if
     word 
     (format s "<~A ~A>" 
             (cat-name (car (indiv-type i)))
             (let
                 ((ss (make-string-output-stream)))
               (typecase word
                 (word 
                  (princ-word word ss))
                 (polyword
                  (princ-polyword word ss))
                 (individual
                  (princ-name word ss)))
               (get-output-stream-string ss)))
     (format s "<~A>" (cat-name (car (indiv-type i)))))))

