;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 2014-2016 David D. McDonald  -- all rights reserved
;;;
;;;     File:  "semantic-extraction"
;;;   Module:  "drivers/chart/psp/"
;;;  version:  July 2016


;;; This file contains all the functions/methods for extracting the elements of the semantics of a
;;;  parse, for display to the user, and for transmission to Spire...


;;;-----------------------
;;; identifying relations
;;;-----------------------

;; (setq *readout-relations* nil)
;; (identify-relations *sentence*)

(defvar *relations* nil
  "Holds the relations for the last sentence when *readout-relations* is up")
(defvar *entities* nil
  "Holds the entities for the last sentence when *readout-relations* is up")

(defparameter *print-sem-tree* nil
  "Set to T to change the structures extracted for collections, to allow psemtree to produce better output,
without damaging other code.")

(defparameter *show-words-and-polywords* nil)
(defparameter *for-spire* nil
  "If true, then we put category and id information into the tree explicitly, rather than putting the individual into the tree.")


(defun identify-relations (sentence)
  ;; sweep over every treetop in the sentence and look at
  ;; their referents. For all sensible cases recursively
  ;; examine the object and tally the entities and relations.
  ;; N.b. this sweep is based on collect-model, which is
  ;; defined in interface/grammar/sweep.lisp
  (setq *relations* nil
        *entities* nil)
  (let* ((start-pos (starts-at-pos sentence))
         (end-pos (ends-at-pos sentence))
         (rightmost-pos start-pos)
         (tt-count 0)
	 treetops
         raw-entities  raw-relations  tt-contents
         treetop  referent  pos-after )

    ;; modeled on sweep-sentence-treetops
    (loop
       (multiple-value-setq (treetop pos-after) ;; multiple?
	 (next-treetop/rightward rightmost-pos))
      
       (incf tt-count)
       (push treetop treetops)

       (when (edge-p treetop)
	 (setq referent (edge-referent treetop))

	 (when referent
	   (initalize-model-collection)
	   (setq tt-contents (collect-model referent))

	   (loop for item in tt-contents
	      do (cond
		   ((or (subject-variable item)
			(individual-p item))
		    (push item raw-relations))
		   (t
		    (pushnew item raw-entities))))))

       (when (eq pos-after end-pos)
	 (return))
       (when (position-precedes end-pos pos-after)
	 ;; we overshot somehow
	 (return))
       (setq rightmost-pos pos-after))

    ;; (push-debug `(,raw-entities ,raw-relations))
    ;; (setq raw-entities (car *) raw-relations (cadr *))
    ;; (strip-model-descriptions raw-relations)
    ;; (break "debug strip model")

    (let ((relations (strip-model-descriptions raw-relations))
          (entities (strip-model-descriptions raw-entities)))
      (values relations
              entities
              tt-count
	      (reverse treetops)))))

;;;---------------------------
;;; Helper code for the cards
;;;---------------------------

(defun all-individuals-in-tts (sentence)
  ;; This used to both walk the treetops to identify
  ;; all of the individuals that they reference
  ;; and also recurd their surface strings.
  ;; Now it just does the walk and the strings
  ;; are recorded by the call to note-surface-string in complete/hugin.
  (let ((individuals nil)
        (start-pos (starts-at-pos sentence))
        (end-pos (ends-at-pos sentence)))
    (loop for tt in (all-tts start-pos end-pos)
      do (loop for i in (individuals-under tt)
           when (itypep i 'biological)
           do (pushnew i individuals)))
    (reverse individuals)))


;; Set this variable to collect information about realizations of biochemical-entities in text...
(defparameter *bce-ht* nil
  	;;(make-hash-table :size 10000)
  	)

(defparameter *save-surface-text-as-variable* t)
(defparameter *save-surface-text-classes* '(protein protein-family))


(defparameter *bio-entity-heads* nil)  ;;
(defparameter *bio-chemical-heads* nil)  ;;	

(defun collect-bio-entity-heads ()
  (setq *bio-entity-heads* (make-hash-table :size 200000 :test #'equal)))

(defun collect-bio-chemical-heads ()
  (setq *bio-chemical-heads* (make-hash-table :size 200000 :test #'equal)))

(defun note-surface-string (edge)
  ;; Called on every edge from complete-edge/hugin
  ;; Record the surface string from the span dictated 
  ;; by the edge. 
  (declare (special *surface-strings*))
  (let ((referent (edge-referent edge)))
    (when t ;; (and referent (individual-p referent))
      (let* ((start-pos (pos-edge-starts-at edge))
             (end-pos (pos-edge-ends-at edge))
             (start-index (pos-character-index start-pos))
             (end-index (pos-character-index end-pos)))
        #| Too noisy. Digit sequences typically have
        a null end-index for reasons as yet unexplored
        (unless start-index
        (format t "~&>>> Null start-index: ~a~%~%" edge))
        (unless end-index
        (format t "~&>>> Null end-index: ~a~%~%" edge)) |#

        (if (and start-index end-index)
            ;; need both indices to extract the string
            (let ((string
                   (extract-string-from-char-buffers start-index end-index)))
              (setf (gethash edge *surface-strings*) string)
              (setq string (string-trim " 
" string))
              (setf (gethash referent *surface-strings*) string)
              (when (and  (eq (edge-right-daughter edge) :SINGLE-TERM)
                          (individual-p referent))

                (when (and *bce-ht* (itypep referent 'bio-chemical-entity))
                  (pushnew string (gethash referent *bce-ht*) :test #'equal))
                (when (and *save-surface-text-as-variable*
                           (member (cat-name (itype-of referent))
                                   *save-surface-text-classes*)
                           (null (value-of 'raw-text referent)))
                                   
                  ;; do this after the code above, so that the *bce-ht*
                  ;;  is keyed on the individual without the text
                  (setq referent (bind-dli-variable 'raw-text
                                                    (head-string edge) ;;string
                                                    referent))
                  (setf (edge-referent edge) referent)))
              (when (and *bio-entity-heads*
                         (eq (itype-of referent) (category-named 'bio-entity)))
                (setf (gethash (head-string edge) *bio-entity-heads*) t))
              (when (and *bio-chemical-heads*
                         (itypep referent 'bio-chemical-entity))
                (setf (gethash (head-string edge) *bio-chemical-heads*) t)))
            (setf (gethash referent *surface-strings*) ""))))))







(defparameter *surface-strings* (make-hash-table :size 10000)
  "Used by note-surface-string as the place to cache the text
   string that corresponds to an edge. Key is the referent
   of the edge.")


(defun retrieve-surface-string (i)
  (gethash i *surface-strings*))

(defun get-surface-string-for-individual (i)
  ;; Most all entities should have gotten their surface string
  ;; recorded when their edge passed through complete. 
  ;; This provides a minimal value for the others.
  (let ((name (and (individual-p i) (value-of 'name i))))
    (if name
      (pname name)
      (format nil "~s" i))))

(defun get-string-from-edge-word (item)
  "Given either an edge or word, retrieves the surface string -- if neither, just returns the item"
  (cond ((edge-p item)
         (string-right-trim " " (retrieve-surface-string item)))
        ((word-p item)
         (string-right-trim " " (pname item)))
        (t
         item)))


;;--------- dregs of another scheme for getting 
;; surface strings  --- Review and flush.

#+ignore
(defun get-surface-string-from-locally-recorded-edge (edges)
  (let ((edge (car edges))) 
    ;; ignoring possibility of mulitple mentions at least for now
    (let* ((start-pos (pos-edge-starts-at edge))
           (end-pos (pos-edge-ends-at edge))
           (start-index (pos-character-index start-pos))
           (end-index (pos-character-index end-pos)))
      (unless (and start-index end-index)
        (error "Some position index is null"))
      (extract-string-from-char-buffers 
       start-index end-index))))

#+ignore
(defun get-surface-string-from-discourse-entry (i)
  ;; N.b. depends on the dicourse entries being current
  ;; and tacitly assumes that there's only one mention
  ;; of an individual in the region being looked at
  ;; or that their spelling (surface string) in those two
  ;; mentions is identical.
  (let ((entry (individuals-discourse-entry i)))
    (when entry
      (let* ((most-recent (second entry))
             (start (car most-recent))
             (end (cdr most-recent)))
        (when (and (position-p start) (position-p end))
          (let ((start-index (pos-character-index start))
                (end-index (pos-character-index end)))
            (push-debug `(,start-index ,end-index ,i)) 
            (extract-string-from-char-buffers 
             start-index end-index)))))))

;;;------------------------------------
;;; collectors for semtree and friends
;;;------------------------------------

(defun tts-semantics ()
  (loop for edge in (all-tts) #+ignore (cdr (all-tts)) 
    when (and (edge-p edge) 
              (not (word-p (edge-referent edge))))
    collect (semtree (edge-referent edge))))

(defun tts-edge-semantics ()
  (loop for edge in (all-tts)
    when (and (edge-p edge) 
              (not (word-p (edge-referent edge))))
    collect (list edge
                  (semtree (edge-referent edge)))))

(defun all-entities (&optional (trees (tts-semantics)))
  (loop for st in trees
     append (entities-in st)))

(defun entities-in (tree)
  (let ( entities )
    (when (consp tree)
      (if (and (not (consp (car tree)))
               (entity-p (car tree)))
        (push (car tree) entities))
      (loop for binding in (cdr tree)
         do (setq entities 
              (append (entities-in (second binding))
                      entities))))
    entities))

(defun all-relations (&optional (trees (tts-semantics)))
  (extend-relations
   (loop for rel in (all-rels trees)   
     when (cdr rel)
     collect rel)))

(defun all-rels (&optional (trees (tts-semantics)))
  (loop for st in trees
    append
    (loop for rel in (relations-in st)
      when (cdr rel)
      collect rel)))

(defun extend-relations (relations)
  (let ((alist1
        (loop for r in relations 
          when (is-bio-entity? r)
          collect (cons (second (second r)) (second (third r)))))
       (alist2
        (loop for r in relations 
          when (is-bio-entity? r)
          collect (cons (second (third r)) (second (second r))))))
    
    (remove-duplicates
     (append relations
             (sublis alist1
                     (loop for r in relations unless (is-bio-entity? r) collect r ))
             (sublis alist2
                     (loop for r in relations unless (is-bio-entity? r) collect r )))
     :test #'equalp)))

(defun is-bio-entity? (r)
  (and (individual-p (car r))
       (itypep (car r) 'is-bio-entity)
       (cddr r)))

(defun relations-in (tree)
  (let (relations)
    (when (and (consp tree)
               (not (eq 'collection (car tree))))
      (when (not (consp (car tree)))
        (if
         (not (entity-p (car tree)))
         (lsp-break "(car tree) is not an tntity in ~s"
                    (sentence-string *sentence-in-core*))
         (push (extract-relation tree) relations))))
    (loop for binding in (cdr tree)
       do
         (setq relations
               (append 
                (relations-in (second binding))
                relations)))
    relations))

(defun extract-relation (rel)
  `(,(car rel)
    .,(loop for binding in (cdr rel) 
        collect 
        `(,(car binding) 
          ,(if (consp (second binding)) 
             (if (consp (car (second binding)))
               (second (car (second binding)))
               (car (second binding)))
             (second binding))))))


;; THIS NEEDS TO BE REFINED
(defun entity-p (e)
  (and
   (individual-p e)
   (not (find-subject-vars e))
   (not (itypep e 'bio-process))
   (not (itypep e 'predicate))
   (not (itypep e 'is-bio-entity))))

(defun itypes-under (x type)
  (loop for i in (individuals-under x)
    when (itypep i type)
    collect i))

(defun processes-under (x)
  (itypes-under x 'bio-process))

(defun individuals-under (x)
  (declare (special *semtree-seen-individuals*))
  (let ((indivs nil))
    (semtree x)
    (maphash #'(lambda (l h)
                 (declare (ignore h))
                 (push l indivs))
             *semtree-seen-individuals*)
    indivs))


(defun spire-tree (item &optional (with-ids nil))
  (let ((*sentence-results-stream*
         (unless with-ids *sentence-results-stream*)))
    (declare (special *sentence-results-stream*))
    (let ((*for-spire* t))
      (declare (special *for-spire*))
      (semtree item))))

;;----- semtree methods

(defmethod semtree ((x null))
  nil)

(defmethod semtree ((w word))
  nil)

(defmethod semtree ((n number))
  (if (> n 1000)
      (semtree (i# n))
      (semtree (e# n))))

(defmethod semtree ((e edge))
  (semtree (edge-referent e)))


(defparameter *semtree-seen-individuals* (make-hash-table)
  "Cleared and used by semtree to avoid walking through the
  same individual twice and getting into a loop.")

(defmethod semtree ((i individual))
  (clrhash *semtree-seen-individuals*)
  (collect-model-description i))

(defmethod semtree ((i referential-category))
  (clrhash *semtree-seen-individuals*)
  (collect-model-description i))


;;----- collect-model-description mentods

(defmethod collect-model-description ((cat category))
  (declare (special *for-spire* *sentence-results-stream*))
  (if (or *for-spire* *sentence-results-stream*)
      `(category ,(cat-name cat))
      cat))

(defmethod collect-model-description ((str string))
  str)


(defmethod collect-model-description ((w word))
  (declare (special *for-spire* *sentence-results-stream*))
  (cond (*sentence-results-stream* (pname w))
        (*for-spire* `(wd ,(pname w)))
        (t (pname w))))

(defmethod collect-model-description ((w polyword)) ;
  (declare (special *for-spire*  *sentence-results-stream*))
  (cond (*sentence-results-stream* (pname w))
        (*for-spire* `(wd ,(pname w)))
        (t (pname w))))

(defmethod collect-model-description ((cal cons))
  `(collection :members 
                   (,@(loop for l in cal 
                         collect (collect-model-description l)))))


(defun indiv-or-type (i)
  (declare (special *for-spire* *sentence-results-stream*))
  (cond
    (*sentence-results-stream*
     `(,(cat-name (itype-of i))))
    (*for-spire* 
      `((,(cat-name (itype-of i))
          ,(indiv-uid i))))
    (t `(,i))))

(defmethod collect-model-description ((i individual))
  (declare (special script category::number category::ordinal *for-spire* *sentence-results-stream*))
  (cond
    ((gethash i *semtree-seen-individuals*)
     (if (or *for-spire* *sentence-results-stream*)
       (indiv-or-type i)
       (if (and (individual-p i)
                (null (cdr (indiv-old-binds i))))
         `(,i) ;; suppress "!recursion!" for very simple items
         `(("!recursion!" ,i)))))
    
    ((and (itypep i category::number)
          (not (itypep i category::ordinal))
          (not *print-sem-tree*)
          (not (or *for-spire* *sentence-results-stream*)))
     (if (collection-p  i)
      (value-of 'items i)
      (value-of 'value i)))
   	
    ((and (eq script :biology)
          (itypep i 'protein-family) ;; get rid of bio-family -- misnamed...
          (not (collection-p i)))
     (let ((bindings (indiv-binds i))
           (desc (indiv-or-type i)))
       (declare (special bindings desc))
       (append
        desc
        (loop for b in bindings 
           unless (and (not (or *for-spire* *sentence-results-stream*))
                       (member (var-name (binding-variable b))
                               '(members count ras2-model)))
           collect
             (list (var-name (binding-variable b))
                   (collect-model-description (binding-value b)))))))
    
    ((collection-p i)
     (setf (gethash i *semtree-seen-individuals*) t)
     (collect-model-description-for-collection i))
    
    (t  
     (let ((desc (indiv-or-type i)))
       (setf (gethash i *semtree-seen-individuals*) t)
       ;; Had been restricting the recursion to types with
       ;; a subject variable: (subject-variable type), 
       ;; but that's missing interesting noun phrase referents.
       (loop for b in  (indiv-binds i)
          as var  = (binding-variable b)
          as var-name = (var-name var)
          as restriction = (var-value-restriction var)
          as value = (binding-value b)
          do
            (unless (or (cond (*sentence-results-stream*
                               (or (memq var-name '(trailing-parenthetical category
                                                    ras2-model))
                                   (and
                                    (itypep i 'determiner)
                                    (memq var-name '(word)))))
                              ((not *for-spire*)
                               (memq var-name '(trailing-parenthetical category
                                                ras2-model))))
                        (typep value 'mixin-category)) ;; has-determiner
              (if (or (numberp value)
                      (symbolp value)
                      (stringp value))
                (push (list var-name value) desc)
                (typecase value
                  (individual 
                   (if (and (not (or *for-spire* *sentence-results-stream*))
                            (itypep value 'prepositional-phrase))
                     (push (list var-name
                                 (collect-model-description
                                  (value-of 'pobj value)))
                           desc)
                     (push (list var-name
                                 (collect-model-description value))
                           desc)))
                  ((or word polyword category)
                   (push `(,var-name ,(collect-model-description value)) desc))
                  (cons
                   (unless (equal restriction '(:primitive list))
                     (error "The value of the variable ~a is a cons but its ~
                             restriction, ~a, doesn't permit it.~%value = ~a"
                            var-name restriction value))
                   (push `(,var-name
                           (,(loop for item in value
                                do (collect-model-description item)) ))
                         desc))
                  (rule-set) ;; the word "anti" presently does this
                  ;; because the fix to bio-pair isn't in yet (ddm 6/9/15)
                  (otherwise
                   (push-debug `(,value ,b ,i))
                   ;;(break "Unexpected type of value of a binding: ~a" value)
                   (format t "~&~%Collect model: ~
                            Unexpected type of value of a binding: ~a~%" value))))))
       (reverse desc)))))


(defun collect-model-description-for-collection (i)
  (let ((desc (indiv-or-type i)))
    (loop for b in  (indiv-binds i)
       as var  = (binding-variable b)
       as var-name = (var-name var)
       as value = (binding-value b)
       as vv-pair = `(,var-name
                      ,(if (and (or *for-spire* *sentence-results-stream*)
                                (category-p value))
                         `(category ,(cat-name value))
                         value))
       do
         (unless (or (memq var-name '(trailing-parenthetical category ras2-model))
                     (typep value 'mixin-category)) ;; has-determiner
           (case var-name
             ((type number)
              ;;(when (or *for-spire* *sentence-results-stream*)
                (push vv-pair desc)) ;;)
             (items
              (let ((member-descs (mapcar #'collect-model-description value)))
                (push (if (or *for-spire* *sentence-results-stream*)
                        `(:members ,.member-descs)
                        `(,var-name (collection (:members (,@ member-descs)))))
                      desc)))
             (t
              (if (or (numberp value) (symbolp value) (stringp value))
                  (push vv-pair desc)
                  (typecase value
                    (individual 
                     (push (list var-name
                                 (collect-model-description
                                  (if (and (not (or *for-spire* *sentence-results-stream*))
                                           (itypep value 'prepositional-phrase))
                                    (value-of 'pobj value)
                                    value)))
                           desc))
                    ((or word polyword)
                     (when *show-words-and-polywords* (push vv-pair desc)))
                    (category
                     (push `(,var-name ,(collect-model-description value)) desc))
                    (cons (lsp-break "how did we get a CONS ~s as a value for variable ~s~%"
                                     value var-name))
                    (rule-set) ;; the word "anti" presently does this
                    ;; because the fix to bio-pair isn't in yet (ddm 6/9/15)
                    (otherwise
                     (push-debug `(,value ,b ,i))
                     ;;(break "Unexpected type of value of a binding: ~a" value)
                     (format t "~&~%Collect model: ~
                            Unexpected type of value of a binding: ~a~%~%" value))))))))
    (reverse desc)))

;;;--------------------
;;; save the sentences
;;;--------------------

(defparameter *print-sentences* nil)

(defun possibly-print-sentence ()
  (declare (special *sentence-in-core* *print-sentences*))
  (when (numberp *print-sentences*)
    (format t "~&~&*** (p ~s) ;; ~s" 
            (sentence-string *sentence-in-core*) 
            (incf *print-sentences*))))



;;;; semantic tree traversal


(defmethod traverse-sem ((s sentence) fn)
  (traverse-sem (previous s) fn)
  (funcall fn s)
  (loop for tt in (all-tts (starts-at-pos s) (ends-at-pos s))
        when
          (edge-p tt)
        do
          (traverse-sem (edge-referent tt) fn)))

(defmethod traverse-sem ((i individual) fn)
  (declare (special i))
  (funcall fn i)
  (cond ((simple-number? i)
         (funcall fn (value-of 'value i)))
        ((is-basic-collection? i)
         (loop for item in (value-of 'items i)
                 do (traverse-sem item fn)))
        (t
         (loop for b in (indiv-old-binds i)
               do (traverse-sem b fn)))))

(defgeneric traverse-sem (sem fn))
(defmethod traverse-sem ((w string) fn)
  (funcall fn w))

(defmethod traverse-sem ((w word) fn)
  (funcall fn w))
(defmethod traverse-sem ((w polyword) fn)
  (funcall fn w))
(defmethod traverse-sem ((w symbol) fn)
  (funcall fn w))

(defmethod traverse-sem ((w number) fn)
  (funcall fn w))

(defmethod traverse-sem ((val cons) fn)
  (funcall fn val))

(defmethod traverse-sem ((c referential-category) fn)
  (funcall fn c))

(defmethod traverse-sem ((binding binding) fn)
  (traverse-sem (binding-value binding) fn))

;; a useful example -- traversal functions to be used with traverse-sem
(defmethod find-biochemical-entities ((s sentence))
  (traverse-sem s #'find-bce)
  (all-bces))

(defparameter *found-bces* nil)
(defmethod find-bce ((s sentence))
  (setq *found-bces* nil))

(defmethod find-bce ((c referential-category))
  (if (itypep c 'bio-chemical-entity)
      (record-bce c)))

(defmethod find-bce ((i individual))
  (when (itypep i 'bio-chemical-entity)
    (record-bce i)
    (visit-indiv-generalizations i (itype-of i) #'record-bce)))

(defun record-bce (i)
  (push i *found-bces*))

(defun all-bces ()
  *found-bces*)

(defun visit-indiv-generalizations (i cat fn)
  (loop for (key parent) in (indiv-uplinks i)
        when
          (eq (itype-of parent) cat)
        do
          (funcall fn parent)
          (visit-indiv-generalizations parent cat fn)))
    
;; another useful example

(defmethod find-reach-processes ((s sentence))
  (traverse-sem s #'find-bps)
  (all-bps))

(defmethod find-bps (x)
  "do nothing")

(defparameter *found-bps* nil)

(defun reach-process-p (cat-or-indiv)
  (itypep cat-or-indiv
          '(:or bio-control post-translational-modification binding
            interact ;; not sure this constitues a cardable entity, but I think REACH thinks so
            )))

(defmethod find-bps ((s sentence))
  (setq *found-bps* nil))

(defmethod find-bps ((c referential-category))
  (if (reach-process-p c)
      (record-bp c)))

(defmethod find-bps ((i individual))
  (when (reach-process-p i)
    (record-bp i)))

(defun record-bp (i)
  (push i *found-bps*))

(defun all-bps ()
  *found-bps*)
    
                
(defmethod find-bp (x)
  "do nothing")





;;;; get the head edge for an edge, based on the fact that the head edge has the same category as the edge-referent, and is a lexical edge
(defun find-head-edge (edge)
  (let ((category (itype-of (edge-referent edge)))
        (start-pos (pos-edge-starts-at edge))
        (end-pos (pos-edge-ends-at edge)))
    (find-lexical-edge-with-cat category start-pos end-pos)))

(defun find-lexical-edge-with-cat (category start-pos end-pos)
  (if (or (eq (cat-name category) 'collection)
          (>= (pos-token-index start-pos) (pos-token-index end-pos)))
      nil
      (let ((lex-edge (lexical-edge-at start-pos)))
        (when lex-edge
          (if (eq (itype-of (edge-referent lex-edge)) category)
              lex-edge
              (find-lexical-edge-with-cat category (pos-edge-ends-at lex-edge) end-pos))))))      


           
        

(defmethod head-string ((edge edge))
  (when edge 
    (let ((found-head (find-head-edge edge)))
      (when found-head
        (string-right-trim " 
" (extract-string-spanned-by-edge found-head))))))


(defmethod head-string ((i individual))
  (head-string (mention-source (best-recent-mention i))))

(defmethod head-string (x)
  nil)

(defun all-current-sentences (s)
  (when s
    (cons s
     (all-current-sentences (previous s)))))

(defmethod top-edges-for-proteins ()
  (let ((slist
         (reverse (all-current-sentences (previous (sentence))))))
    (loop for s in slist
          append
            (top-edges-for-interps-in-s
             (find-biochemical-entities s)
             s))))

