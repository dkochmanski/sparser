;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 2017 David D. McDonald  -- all rights reserved
;;; 
;;;     File:  "client-operations"
;;;   Module:  "drivers;chart:psp:"
;;;  Version:  December 2017

;; Broken out of no-brackets-protocol 12/11/17 to make both files easier
;; for people to read as stories. Client-operations is diverse code needed
;; to massage or generate output that is tailored to special applications
;; such as uptake by Intra or formatting for Calisto.

(in-package :sparser)



(defparameter *indra-post-process* nil)
(defparameter *indra-embedded-post-mods* nil)
(defparameter *callisto-compare* nil)


(defun do-client-translations (sentence)
  (declare (special *sentence-results-stream* *semantic-output-format*
                    *indra-post-process* *callisto-compare*
                    *localization-interesting-heads-in-sentence*
                    *colorized-sentence* *localization-split-sentences*
                    *save-bio-processes* ))
  (declaim (optimize (debug 3)))
  
  (when (and (or (eq *sentence-results-stream* t)
                 (streamp *sentence-results-stream*))
             (not (eq *semantic-output-format* :HMS-JSON)))
    ;;output sentence semantics, if desired, in format specified
    ;; by *semantic-outut-format* -- code is in save-doc-semantics
    (when *save-bio-processes* (save-bio-processes sentence))
    (write-semantics sentence *sentence-results-stream*))
  
  (when *indra-post-process*
    (let ((mentions ;; sort, so that embedding edges for positive-bio-control come out first
           (sort
            (remove-collection-item-mentions
             (mentions-in-sentence-edges sentence))
            #'>
            :key #'(lambda (m) (edge-position-in-resource-array (mention-source m))))))
      (indra-post-process mentions sentence *sentence-results-stream*)))
  
  (when *callisto-compare* (extract-callisto-data sentence))
    
  (when *localization-interesting-heads-in-sentence*
    (let ((colorized-sentence (split-sentence-string-on-loc-heads)))
      (setf (gethash sentence *colorized-sentence*) colorized-sentence)
      (push colorized-sentence *localization-split-sentences*))))


;;;----------------------------------
;;; processing for comparison to callisto annotations
;;;----------------------------------
(defparameter *sp-clsto-entity-mentions* nil)
(defparameter *sp-clsto-relations* nil)
(defparameter *sp-clsto-used-entity-edges* nil)
(defparameter *sp-clsto-used-relation-edges* nil)
(defun extract-callisto-data (sentence)
  (let* ((mentions
          ;; sort, so that embedding edges for positive-bio-control come out first
          (sort
           (remove-collection-item-mentions
            (mentions-in-sentence-edges sentence))
           #'>
           :key #'(lambda (m) (edge-position-in-resource-array (mention-source m)))))
         (mentions-copy mentions))
    (declare (special mentions-copy))
    (loop for mention in mentions
          do (let* ((ref (base-description mention))
                    (edge (mention-source mention))
                    (head-edge (find-head-edge edge))
                    (dependencies (dependencies mention)))
               ;(declare (special edge))
               (cond ((itypep ref '(:or bio-chemical-entity molecular-location
                                    bio-movement ;; translocation
                                    cellular-process ;; autophagy, apoptosis
                                    pathway
                                    ))
                      (unless (edge-subsumed-by-edge-in-list edge *sp-clsto-used-entity-edges*)
                        (if (and (is-basic-collection? ref)
                                 (not (eq (edge-rule edge) 'make-protein-collection))
                                 (loop for item in (get-mention-items dependencies)
                                       always (typep item 'discourse-mention)))
                            (extract-callisto-conjunction-data ref edge head-edge dependencies)
                            (push `( ;;,mention
                                    (:category ,(cat-name (itype-of ref)))
                                    (:uid ,(value-of 'uid ref))
                                    (:head ,(get-edge-char-offsets-and-surface-string head-edge))
                                    (:full ,(get-edge-char-offsets-and-surface-string edge)))
                                  *sp-clsto-entity-mentions*))
                        (when (and (itypep ref '(:or bio-chemical-entity molecular-location))
                                   (not (itypep ref '(:or bio-complex dimer residue-on-protein
                                                      molecular-location))))
                          (push edge *sp-clsto-used-entity-edges*))))
                     ((itypep ref '(:or bio-control post-translational-modification))
                      ;;(lsp-break "at type bio-control/post-trans-mod")
                      (unless (or (edge-subsumed-by-edge-in-list edge *sp-clsto-used-relation-edges*)
                                  (and (null dependencies)
                                       ;; we got a lot events for listings of p-values
                                       (equal "p" (trim-whitespace (extract-string-spanned-by-edge edge))))
                        (push
                         `( ;;,mention
                           (:event (:full ,(get-edge-char-offsets-and-surface-string edge)))
                           (:relation (:head ,(get-edge-char-offsets-and-surface-string head-edge)))
                           ,.(loop for item in dependencies
                                   when (and (typep (second item) 'discourse-mention)
                                             (not (member (pname (car item)) '(modifier raw-text))))
                                   collect `(,(pname (car item))
                                              (:head ,(get-edge-char-offsets-and-surface-string
                                                       (find-head-edge (mention-source (second item)))))
                                              (:full ,(get-edge-char-offsets-and-surface-string
                                                       (mention-source (second item)))))
                                   end
                                   when (eq (second item) '*lambda-var*)
                                   collect (let ((lambda-edge (get-lambda-ref-edge-from-pred-edge edge)))
                                                   `(,(pname (car item))
                                              (:head ,(get-edge-char-offsets-and-surface-string
                                                       (find-head-edge lambda-edge)))
                                              (:full ,(get-edge-char-offsets-and-surface-string
                                                       lambda-edge))))))
                         *sp-clsto-relations*)
                        (push edge *sp-clsto-used-relation-edges*)))))))))

(defun get-mention-items (dependencies)
  (loop for bb in dependencies
        when (eq 'items (pname (car bb)))
        do (return (second bb))))

(defun extract-callisto-conjunction-data (ref edge head-edge dependencies)
  (loop for sub-mention in (get-mention-items dependencies)
        do
          (let* ((ref (base-description sub-mention))
                 (edge (mention-source sub-mention))
                 (head-edge (find-head-edge edge))
                 (dependencies (dependencies sub-mention)))
            (push `( ;;,mention
                    (:category ,(cat-name (itype-of ref)))
                    (:uid ,(value-of 'uid ref))
                    (:head ,(get-edge-char-offsets-and-surface-string head-edge))
                    (:full ,(get-edge-char-offsets-and-surface-string edge)))
                  *sp-clsto-entity-mentions*))))
          

(defun get-edge-char-offsets-and-surface-string (edge)
  (let* ((surface-string (trim-whitespace (extract-string-spanned-by-edge edge)))
        (char-start (- (pos-character-index (pos-edge-starts-at edge)) 1))
         ;;(char-end (- (pos-character-index (pos-edge-ends-at edge)) 1))
         ;; the ends at doesn't appreciate trimmed whitespace
         (char-end (+ char-start (length surface-string)))) 
    (list char-start char-end surface-string)))
                                             
(defun edge-subsumed-by-edge-in-list (edge edge-list)
  (member edge edge-list :test #'(lambda(edge x) (edge-subsumes-edge? x edge))))
                          
;;;----------------------------------
;;; diverse processing for HMS/Indra
;;;----------------------------------

(defparameter *end-of-sentence-display-operation* nil)
(defparameter *save-bio-processes* nil)

(defparameter *colorized-sentence* (make-hash-table :size 1000 :test #'equal))


(defun indra-post-process (mentions sentence output-stream)
  (setq *indra-embedded-post-mods* nil)
  (loop for mention in mentions
        do (indra-post-process-mention mention sentence output-stream)))

(defun indra-post-process-mention (mention sentence output-stream
                                   &optional
                                     (ippm-ref (base-description mention))
                                     (nec-vars? nil))
  (declare (special ippm-ref))
  (unless (member ippm-ref *indra-embedded-post-mods*)
    (let*  ((necessary-vars (necessary-vars? ippm-ref))
            (desc (if (and (c-itypep ippm-ref 'positive-bio-control)
                           (value-of 'agent ippm-ref)
                           (individual-p (value-of 'affected-process ippm-ref))
                           (itypep (value-of 'affected-process ippm-ref) 'post-translational-modification))
                      ;;e.g. "Rho induces tyrosine phosphorylation of gamma-catenin"
                      (bind-dli-variable 'agent
                                         (value-of 'agent ippm-ref)
                                         (value-of 'affected-process ippm-ref))
                      ippm-ref)))
      ;; Revise the code to 1) allow for conjoined verbs (use c-itypep)
      ;;  and follwing on that 2) allow a single mention/edge to have more
      ;;  than one type of INDRA statement (MEK phosphorylates and activates ERK"
      (when (not (eq desc ippm-ref))
        (push (value-of 'affected-process ippm-ref) *indra-embedded-post-mods*))
      (maybe-push-sem mention ippm-ref sentence necessary-vars output-stream desc nec-vars?))))

(defun necessary-vars? (Ref)
  (cond ((or (c-itypep ref 'bio-activate)
              (c-itypep ref 'bio-inactivate)
              (c-itypep ref 'inhibit)
              (c-itypep ref 'gene-transcript-express)
              (c-itypep ref 'gene-transcript-over-express)
              (c-itypep ref 'gene-transcript-under-express)
              (c-itypep ref 'gene-transcript-co-express)
              (c-itypep ref 'gene-transcript-co-over-express)
              (c-itypep ref 'transcribe))
         '(object affected-process modifier)) ;; modifier is for "p-ERK expression"

        ((and (c-itypep ref 'bio-scalar)
              (not (c-itypep ref 'sensitivity)))
         '(measured-item))
        ((c-itypep ref 'inhibit)
         '(affected-process))
        ((c-itypep ref 'site)
         '(process))
        ((and (c-itypep ref 'negative-bio-control)
              (individual-p (value-of 'affected-process ref))
              (itypep (value-of 'affected-process ref) 'post-translational-modification))
         '(agent))

        ((c-itypep ref 'bio-control)
         '(affected-process object modifier))

        
        ((or (c-itypep ref 'translocation)
             (c-itypep ref 'import)
             (c-itypep ref 'export)
             (c-itypep ref 'recruit))
         '(object moving-object moving-object-or-agent-or-object agent))
        ((c-itypep ref 'auto-phosphorylate)
         '(agent substrate))

        ((c-itypep ref 'binding)
         '(binder bindee direct-bindee))

        ((or (c-itypep ref 'post-translational-modification)
             (c-itypep ref 'methylation)
             (c-itypep ref 'site)
             ;;(c-itypep ref 'residue-on-protein)
             (and (is-basic-collection? ref)
                  (or (c-itypep (value-of 'type ref)
                                'post-translational-modification))))
         '(substrate agent-or-substrate site substrate-or-site))))

(defun maybe-push-sem (mention ref sentence necessary-vars output-stream &optional desc nec-vars?)
  (declare (special mention ref sentence necessary-vars output-stream desc))
  (if (and (is-basic-collection? ref)
           (c-itypep ref 'caused-bio-process))
      (let ((external-bindings
             (loop for b in (indiv-binds ref)
                   unless (member (var-name (binding-variable b))
                                  '(raw-text items type number))
                   collect b)))
        ;(declare (special external-bindings))
        ;;(lsp-break "maybe-push-sem")
        (loop for cref in (value-of 'items ref)
              do
                (indra-post-process-mention mention sentence output-stream
                                            (if external-bindings
                                                (do-external-bindings cref external-bindings)
                                                cref)
                                            (has-necessary-vars necessary-vars cref))))
      (when (or nec-vars? (has-necessary-vars necessary-vars ref))
        (push-sem->indra-post-process
         mention
         sentence
         ;; is there any variable bound to the lambda expression
         ;;   (thus a trace to containing item)
         (loop for b in (indiv-binds ref) thereis (eq (binding-value b) '*lambda-var*))
         output-stream
         desc))))

(defun do-external-bindings (i bindings)
  (loop for b in bindings
        do
          (setq i (or (bind-dli-variable (binding-variable b)
                                         (binding-value b)
                                         i)
                      i)))
  i)

(defun has-necessary-vars (necessary-vars ref)
  (loop for v in necessary-vars when  (value-of v ref)
        collect (list v (value-of v ref))))

(defun c-itypep (c super)
  (or
   (itypep c super)
   (and (is-basic-collection? c)
        (loop for item in (value-of 'items c) thereis (itypep item super)))))
              
(defparameter *show-indra-lambda-substitutions* nil)

(defun get-pmid ()
  (when *current-article* (symbol-name (name *current-article*))))

(defun push-sem->indra-post-process (mention sentence lambda-expansion output-stream &optional desc)
  (declare (special *indra-text* *predication-links-ht* *indra-post-process* lambda-expansion desc))
  (unless desc (setq desc (base-description mention)))
  ;;(lsp-break "push-sem->indra-post-process")
  (let* ((lambda-expansion
          (when lambda-expansion (gethash desc *predication-links-ht*)))
         (desc-sexp (sem-sexp desc))
         (subst-desc-sexp
          (when lambda-expansion
            (subst (sem-sexp (gethash desc *predication-links-ht*))
                   '*lambda-var*
                   (sem-sexp desc))))
         (f `(,(retrieve-surface-string (mention-source mention))
               ,(cond (subst-desc-sexp
                       (when *show-indra-lambda-substitutions*
                         (pprint `(,desc-sexp ===> ,subst-desc-sexp))
                         (terpri))
                       subst-desc-sexp)
                      (t desc-sexp))
               (TEXT ,(if (and (boundp '*indra-text*)
                               (stringp (eval '*indra-text*)))
                          (eval '*indra-text*)
                          (sentence-string sentence))))))
    (push f *indra-post-process*)))

(defun contains-atom (atom list-struct)
  (if (not (consp list-struct))
      (eq atom list-struct)
      (loop for item in list-struct
            thereis (contains-atom atom item))))

(defun contains-list (l list-struct)
  (when (consp list-struct)
    (or (equal l list-struct)
        (loop for item in list-struct
              thereis (contains-list l item)))))

(defun contains-string (string list-struct)
  (if (not (consp list-struct))
      (equal string list-struct)
      (loop for item in list-struct
              thereis (contains-string string item))))
