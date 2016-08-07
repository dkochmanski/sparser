;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 2014-2016 David D. McDonald -- all rights reserved
;;;
;;;     File:  "syntax-functions"
;;;   Module:  grammar/rules/syntax/
;;;  Version:  August 2016

;; Initiated 10/27/14 as a place to collect the functions associated
;; with syntactic rules when they have no better home.
;; RJB 12/20/2014 tentative fix to allow interpret-pp-adjunct-to-np
;;   to handle bio-context.
;; 1/2/2015 put hooks in adjoin-pp-to-vg and interpret-pp-adjunct-to-np
;;   to allow for subcategorization frames
;; 1/5/2015 refactor code that David wrote for adjoin-pp-to-vg and
;;   interpret-pp-adjunct-to-np to allow them to be used as predicates as well as actions
;; 1/14/2015 support for negation and (eventually) other tense/aspect features
;;   methods for assimilating object using sub-categorization frame,
;;   and for handling verb_ing premodifiers
;; (2/12/15) Fixed return value for adj-noun-compound.
;; 2/23/2015 allow pronouns to be subjects using the submit mechanism, and
;; this file contains the mechanisms for creating an edge over the pronoun edge to include the semantic constraint from the verb
;; 3/4/2015 make subcategorization frame respect passives (maps surface subject to object)
;;  don't allow a copular-pp on an instance of BE+NP
;; 3/10/2015 for clarity, rename copy-individual to maybe-copy-individual
;; methods to save sucat instances
;; many small SBCL fixes
;; MAJOR SBCL FIX -- added new method get-prep-pobj to allow us to get the prep and pobj from
;;  the referent of a PP, without having to bind variables
;;  and create lots of vaariable bindngs to manage and search through.
;; 4/14/15 refactored subcategorized-variable to make the test readable and
;;   accommodate override categories
;; 4/15/15 Reworked treatment of the prepositional-phrase scafolding.
;;   Now can have :premod rules for noun-noun modifiers and adj-noun modifiers
;; 4/16/2015 fix make-copular-pp to reject "clausal to-pps" like "to enhance craf activation"
;;     make apply-copular-pp (almost) work -- something is wrong with the referent of the
;;     result -- DAVID -- let's look at it
;; 4/24/2015 correct trivial typo variable-to-bin --> variable-to-bind
;;  that would have blown up in collection of subcat information
;; 4/25/13 Made interpret-pp-adjunct-to-np bind the pobj rather than the pp
;; 4/27/2015 add new mechanism for sub-cat like interpretation where the PP obj becomes the head,
;;  using the syntactic-function interpret-pp-as-head-of-np
;;  this is actually for phrases like "a phosphoserine at residue 827"
;; 5/3/2015 new adjunct like modifier for bio-rocess -- "upon" or "following" <bio-process>
;; 5/8/2015 handle "in vitro" and "in vivo" as VP post-modifiers
;; 5/25/2015 start on handling pp-relative-clauses. 5/26/15 Modified return of
;; interpret-pp-adjunct-to-np to fail the rule rather than try to bind it's arg
;; to the variable 'nil'.
;; 5/30/2015 make sure all subcat type rules return NIL when they are called with an
;; argument that does not meet subcategorization requirements --
;; sometimes the rules can be called inside parenthesis processing, etc., and that
;; process does not do the appropariate "pre-checks"
;; Better handling of special cases for tense/aspect and adverb
;; 6/1/2015 add new method individual-for-ref that does all the work of
;;  getting an appropriate individual for the referent of an edge (creating
;;  an individual in the case where the referent is a category, and copying
;;  the individual when needed if the referent was an individual) Uniformly
;;  used this method in all places that previously used
;;  maybe-copy-individualand/or make-individual-for-dm&p
;; 6/2/2015 Key check in assimilate-subject-to-vp-ed that blocks using
;;  vp+ed (or vg+ed) as a main verb when there is a missing object -- such
;;  ases are much more likely to be reduced relatives this helps handle the
;;  Chen/Sorger sentences like "BRAF bound to Ras transphosphorylates itself
;;  at Thr598 and Ser601."  in the sense that the reduced relative is not
;;  bsorbed as a main verb, though we still need to handle the rule for the
;;  reduced relative.
;; 6/4/15 More modification to assimilate-subject-to-vp-ed for reduced relative
;; 6/8/2015 more informative messages for cases where subcategorization is 
;;   handed a NP with NIL referent
;; 6/22/15 Added prep-comp to allow richer set of prepositions to adjoint
;;   to VPs and expose the preposition to the subcategorization of the head.
;; 6/28/2015 Don't collect information on VP+ED sentences -- 
;; mechanism causes stack overflow because of the pushne with equalp...
;; Handle locations as premodifiers "nuclear kinase"  9/29/15 abstracted the
;; check for a pronoun we should ignore.
;; 1/2/16 Moved individual-for-ref to individuals/make.lisp


(in-package :sparser)
(defvar CATEGORY::PREPOSITIONAL-PHRASE)
(defvar CATEGORY::PRONOUN/INANIMATE)
(defvar CATEGORY::THERE-EXISTS)
(defvar CATEGORY::COPULAR-PP)
(defvar CATEGORY::COPULAR-PREDICATE)

;; moved here, out of KRAQL -- should be put in a more apprpriate place (DAVID?)
(defun collection-p (item)
  (declare (special category::collection))
  (itypep item category::collection))

; (left-edge-for-referent)
; (right-edge-for-referent)
; (parent-edge-for-referent)

;;;------------
;;; parameters
;;;------------

(defparameter *force-modifiers* nil
  "Set to T when you want to accept all PP modifiers
  to NPs and VPs")

(defparameter *subcat-test* nil
  "Set to T when we are executing the referent function
   as a predicate, not as part of interpretation of an NP or VP")


;;;----------------------
;;; unattached variables
;;;----------------------

(define-lambda-variable 
    ;; Used to explicitly mark the type of an individual
    ;; created to anchor segments created by DM&P rather
    ;; than core conceptualizations and incorporated sublanguages
  'predication ;; name
    nil ;; value restriction, which would be 'category' but don't want to go there
  category::top)

(define-lambda-variable 
  'predicate ;; name
    nil ;; value restriction, which would be 'category' but don't want to go there
  category::top)

(define-lambda-variable 
    ;; Used to explicitly mark the type of an individual
    ;; created to anchor segments created by DM&P rather
    ;; than core conceptualizations and incorporated sublanguages
  'ordinal ;; name
    nil ;; value restriction, which would be 'category' but don't want to go there
  category::top)

(define-lambda-variable 
    ;; Used to explicitly mark the type of an individual
    ;; created to anchor segments created by DM&P rather
    ;; than core conceptualizations and incorporated sublanguages
  'appositive-description ;; name
    nil ;; value restriction, which would be 'category' but don't want to go there
  category::top)

(define-lambda-variable 
  'comp ;; name
    nil ;; value restriction, which would be 'category' but don't want to go there
  category::top)

(define-lambda-variable 
  'subordinate-conjunction ;; name
    nil ;; value restriction, which would be 'category' but don't want to go there
  category::top)

(define-lambda-variable 
  'purpose ;; name
    nil ;; value restriction, which would be 'category' but don't want to go there
  category::top)

(define-lambda-variable 
  'quantifier ;; name
    nil ;; value restriction, which would be 'category' but don't want to go there
  category::top)

(define-lambda-variable 
  'det-quantifier ;; as in "all these"
    nil ;; value restriction, which would be 'category' but don't want to go there
  category::determiner)

(define-lambda-variable 
  'has-determiner ;; name
    nil ;; value restriction, which would be 'category' but don't want to go there
  category::top)

(define-lambda-variable 
  'has-possessive ;; name
    nil ;; value restriction, which would be 'category' but don't want to go there
  category::top)

(define-lambda-variable 
  'approximator ;; name
    nil ;; value restriction, which would be 'category' but don't want to go there
  category::number)

(define-lambda-variable 
  'cause-of ;; name
    nil ;; value restriction, which would be 'category' but don't want to go there
  category::top)

(define-lambda-variable 
  'amount-of-time ;; name
    nil ;; value restriction, which would be 'category' but don't want to go there
  category::top)

(define-lambda-variable 
  'copular-verb ;; name
    nil ;; value restriction, which would be 'category' but don't want to go there
  category::top)



;;;----------------------------
;;; place to stash determiners
;;;----------------------------

;;; --- part of mechanism to hang on to "modifiers" that should not be
;;;     incorporated in description-lattice individuals
;;; These include determiners and parentheticals
;;; see operations in create-discourse-mention and extend-discourse-mention

(defparameter *non-dli-mod-ht* (make-hash-table)
  "Holds determiners for NPs until they are put in
   the discourse mention")
(defun non-dli-mod-for (i)
  (gethash i *non-dli-mod-ht*))
(defun (setf non-dli-mod-for) (det i)
  (setf (gethash i *non-dli-mod-ht*) det))


;;;-------------------
;;; noun premodifiers
;;;-------------------

(defun noun-noun-compound (qualifier head)
  (declare (special category::determiner))
  ;; goes with (common-noun common-noun) syntactic rule
  (cond
    (*subcat-test*
     (not (and (individual-p head)
               (itypep head category::determiner))))
    ((itypep head category::determiner)
     ;; had strange case with "some cases this" -- head was "this"
     nil)
    ((word-p head)
     nil) ;; this happened with word = HYPHEN, "from FCS-treated cells"
    ((and qualifier head
	  (not (or (category-p head)
		   (individual-p head))))
     ;; Have cases like "pp170" where the head has a PW as referent.
     ;; Don't know what to  do
     (break "Can't deal with head whose interpretation is not ~
             an individual or category in noun-noun-compound, head is ~s~&" head))
    ((and qualifier head)
     (setq head (individual-for-ref head))
     (cond
       ((and (itypep head 'knockout-pattern)
             (itypep qualifier 'protein))
        (setq qualifier (bind-variable 'cell-line ;; ???
                                       head qualifier))
        qualifier)
       ;;/// There are a lot of knockout patterns. Enumerating them
       ;; like this is going to get old. Feels like motivation for
       ;; from-rule generated methods, all using a standard schema to
       ;; indicate what variable to use, head & form, etc
       ((and (itypep qualifier 'knockout-pattern)
             (itypep head 'mouse))
        (setq head (bind-variable 'cell-line qualifier head))
        head)
       ((and (itypep qualifier (itype-of head))
             (not (indiv-binds head))
             ;; head already is modified -- don't replace with proper noun
             ;; e.g. "braf mutant a 375 melanoma cell"
             (if (collection-p qualifier)
                 (and ;; conjunction of named items
                  (individual-p (car (value-of 'items qualifier)))
                  (value-of 'name (car (value-of 'items qualifier))))
                 ;; named item
                 (value-of 'name qualifier)))
        ;; intended as test for proper noun or other specific NP
        (revise-parent-edge :form category::proper-noun)
	qualifier)
       ((call-compose qualifier head))
       ((interpret-premod-to-np qualifier head))
       ;; subcat test is here. If there's a :premod subcategorization
       ;; that's compapatible this gets it.
       (t
	;; what's the right relationship? Systemics would say
	;; they are qualifiers, so perhaps subtype?
	(setq head (bind-variable 'modifier qualifier head)) ;; safe
	head)))))

(defun interpret-premod-to-np (premod head)
  (let ((variable-to-bind
          (subcategorized-variable head :m premod)))
    (cond
     (*subcat-test* variable-to-bind)
     (variable-to-bind
      (when *collect-subcat-info*
        (push (subcat-instance head :m variable-to-bind premod)
              *subcat-info*))
      (setq head (individual-for-ref head))
      (setq head (bind-variable variable-to-bind premod head))
      head))))


(defun adj-noun-compound (adjective head &optional adj-edge)
  (declare (special category::determiner))
  (when (category-p head) (setq head (individual-for-ref head)))
  (cond
    (*subcat-test*
     (and ;; had strange case with "some cases this" -- head was "this"
          ;; so rule out these cases
          (not (and (individual-p head) (itypep head category::determiner)))
          (not (itypep head  category::determiner))

          ;; Positive reasons to assume we can compose
          (or (subcategorized-variable head :m adjective)
              (subcategorized-variable adjective :subject head)
              (itypep adjective 'attribute-value))))

    ((call-compose adjective head)) ;; This case is to benefit marker-categories
    ((itypep adjective 'attribute-value)
     (handle-attribute-of-head adjective head))
    ((interpret-premod-to-np adjective head)) ;; normal subcategorization
    (t ;; Dec#2 has "low nM" which requires coercing 'low'
     ;; into a number. Right now just falls through
     (let ((predicate 
	     (if (and (not (is-basic-collection? adjective))
                      (find-variable-for-category :subject (itype-of adjective)))
		 (create-predication-by-binding
                  :subject **lambda-var** adjective
                  (list 'adj-noun-compound (or adj-edge (left-edge-for-referent))))
		 (individual-for-ref adjective))))
       (setq head (bind-dli-variable 'predication predicate head))
       head))))

(defun adj-postmodifies-noun (n adj &optional (adj-edge nil)) ;; adj-edge is set when we are postmodifying
  ;; to be more picky about which adjectives can post-modify a noun
  (when
      (or adj-edge (itypep adj 'post-adj))
    (adj-noun-compound adj n adj-edge)))

(defparameter *dets-seen* nil)

(defun create-partitive-np (quantifier of-pp)
  (declare (special quantifier of-pp))
  (let ((pp-edge (right-edge-for-referent)))
    (when (and (not (eq (edge-form pp-edge) category::preposition))
               (has-definite-determiner? (edge-right-daughter pp-edge)))
      (cond
	(*subcat-test* t)
	(t
	 (unless *sentence-in-core*
	   (error "Threading bug. No value for *sentence-in-core*"))
	 (let ((pobj-ref (edge-referent (edge-right-daughter pp-edge))))
	   (revise-parent-edge :category (itype-of pobj-ref))
	   (add-pending-partitive quantifier  (parent-edge-for-referent) *sentence-in-core*)
	   pobj-ref
	   ))))))


(defun determiner-noun (determiner head)
  "NO LONGER Drop indefinite determiners on the ground. Mark definites
   for later handling."
  (declare (special *sentence-in-core*))
  (push-debug `(,determiner ,head))
  (or *subcat-test*
      (let* ((parent-edge (parent-edge-for-referent))
	     (det-edge (left-edge-for-referent))
	     (det-word (edge-left-daughter det-edge)))
	(unless (or (definite-determiner? det-word)
		    (indefinite-determiner? det-word))
	  ;; There are a ton of categories that are defined to be
	  ;; syntactic determiners that deserve their own careful
	  ;; semantic treatment that might funnel through here
	  ;; We can dispatch of the type of the determner:
	  ;; quantity, approximator, etc. Pull them out of the
	  ;; modifiers dossier. 
	  (pushnew determiner *dets-seen*)
	  #+ignore (error "Didn't expect ~s to be read as a determiner" det-word))
	(setf (non-dli-mod-for head) (list 'determiner determiner))
	(cond
	  ((call-compose determiner head))
	  ((definite-determiner? determiner)
	   (let ((sentence (identify-current-sentence)))
	     ;; NOTE -- IMPORTANT
	     ;; this adds the definite determiner on the N-BAR, and does not, by iteself,
	     ;; mark the complete NP as a definite reference
	     ;; have to do something in complete-edge/hugin
	     ;; call to update-definite-determiner, defined in content-methods
	     (add-pending-def-ref determiner parent-edge sentence))))
	head)))


(defun possessive-np (possessive head)
  "Treating it as equialent to an 'of' treatment of genitive"
  (declare (special word::|of|))
  (or
   *subcat-test*
   (call-compose possessive head)
   (let ((var (subcategorized-variable head word::|of| possessive)))
     (if var
       (setq head (bind-variable var possessive head))
       (else
         ;; trace goes here
         (setq head (bind-variable 'modifier possessive head))))
     head)))




(defun quantifier-noun-compound (quantifier head)
  (declare (special category::no category::endurant category::perdurant
                    category::abstract category::quality category::determiner))
  ;; Not all quantifiers are equivalent. We want to idenify
  ;; cases of negation ("no increase") and eventually probably
  ;; float them up to the main verb, //// which will require
  ;; making a note somewhere on the sentence structure reminding
  ;; us to do that after the analysis dust has settled.
  ;;
  ;; Before doing quantifiers seriously find copy of Kurt vanLehn's
  ;; MS thesis and think about generalized quantifiers.
  ;; (push-debug `(,quantifier ,head)) (break "quantifier-noun-compound")
  ;;  (setq quantifier (car *) head (cadr *))
  (setq head (individual-for-ref head))
  (cond
    ((itypep quantifier category::no) ;; special handling for negation
     (setq head (bind-dli-variable 'negation quantifier head)))
    ((or
      (itypep head category::endurant)
      (itypep head category::perdurant) ;; we quantify perdurants like phosphorylations and pathway steps
      (itypep head category::abstract) ;; we quantify abstract items like "group"
      (itypep head 'bio-abstract) ;; we quantify abstract items like "group"
      (itypep head category::quality)	 ;; we quantify qualities "some level"
      (itypep head 'biological)  ;; we quantify things like "such models"
      (itypep head 'time-kind)) ;; we quanitfy things like "some time"
     (setf  (non-dli-mod-for head) (list 'quantifier quantifier))
     ;; don't use KRISP variables for quanitifiers -- put them in the mention
     ;;(setq  head (bind-dli-variable 'quantifier quantifier head))
     )
    ((itypep head category::determiner) ;; "all these"
     (setq  head (bind-dli-variable 'det-quantifier quantifier head)))
    (t
     (cerror "~&@@@@@ adding quantifier ~s to ~s~&"
	     (retrieve-surface-string quantifier)
	     (if (individual-p head)
                 (retrieve-surface-string head)
                 "**MISSING**"))
     (setq  head (bind-dli-variable 'quantifier quantifier head))))
  head)


(defun number-noun-compound (number head)
  (declare (special category::endurant))
  ;;/// for the moment there is a number variable on
  ;; endurant we can bind. Going forward we should automatically
  ;; make a composite individual using a collection.
  ;; See notes on forming plurals in morphology1
  (setq head (individual-for-ref head))
  (when (itypep head category::endurant) ;; J34: "Histone 2B"
    ;;    ~600 kinase
    (setf (non-dli-mod-for head) (list 'number number))
    ;;(setq  head (bind-dli-variable 'number number head))
    )
  head)


(defun verb+ing-noun-compound (qualifier head)
  (or
   (call-compose qualifier head)
   (link-in-verb+ing qualifier head)))

(defun link-in-verb+ing (qualifier head)
  (let ((premod-n-variable
         (subcategorized-variable head :m qualifier)))
    (if premod-n-variable
        (bind-dli-variable premod-n-variable qualifier head)
   
        (let ((subject (subcategorized-variable head :subject qualifier)))
          (cond
            (*subcat-test* subject)
            ((word-p qualifier)
             ;; probably a case of an unknown verb+ing created by morphology
             ;;  like "mating" in PMC352229
             ;; "the complementary mating type-switched strain PJ69–4A"
             ;; Dropping it on the floor seems ok since we don't know
             ;; what it means
             head)
            (t
             (setq qualifier (individual-for-ref qualifier))
             (when subject ;; really should check for passivizing
               (setq qualifier (create-predication-by-binding
                                subject head qualifier
                                (list 'link-in-verb+ing (parent-edge-for-referent)))))
             (setq head (bind-dli-variable 'predication qualifier head))
             head))))))

(defun create-predication-by-binding (var val pred source)
  (let ((new-predication (bind-dli-variable var **lambda-var** pred)))
    (cond (new-predication
	   (create-discourse-mention new-predication source)
	   ;; THIS IS WHERE WE SHOULD CREATE A MENTION FOR THE NEW PREDICATION
	   new-predication)
	  (t pred))))

(defun verb-noun-compound (qualifier head)
  ;;(break "verb-noun-compound")
  ;; goes with (verb+ed n-bar-type) syntactic rule
  (cond
    ((null *current-chunk*) ;; not in an NG chunk -- don't apply this rule at the top level
     nil)
    (*subcat-test* (subcategorized-variable qualifier :object head))
    (t (or (call-compose qualifier head)
	   ;; This case is to benefit marker-categories
	   (link-in-verb qualifier head)
	   (progn
	     ;; have cases like "pp170" where the head has a PW as referent -- don't know what to  do
	     (break "Can't deal with head whose interpretation is not an individual or category in verb-noun-compound, head is ~s~&" head)
	     nil)))))

(defun link-in-verb (qualifier head)
  (let ((var (subcategorized-variable qualifier :object head)
	  #+ignore (object-variable qualifier head)))
    (setq qualifier (individual-for-ref qualifier))
    (when var ;; really should check for passivizing
      (setq  qualifier (create-predication-by-binding var head qualifier
						      (list 'link-in-verb (parent-edge-for-referent)))))
    (setq  head (bind-dli-variable 'predication qualifier head))
    head))

;;;------------------
;;; Verb + Auxiliary
;;;------------------

(defun find-or-make-aspect-vector (vg)
  (declare (special category::perdurant category::relation
                    category::collection category::tense/aspect-vector))
  (unless (or (itypep vg category::perdurant)
	      (itypep vg category::relation) ;; from copular adjectives like "is essential"
              (and (collection-p vg)
                   (let ((vg1 (car (value-of 'items vg))))
                     (itypep vg1 category::perdurant))))
    (push-debug `(,vg))
    (break "~s is not an event, tense/aspect only applies to individuals that ~
            inherit from event." vg))
  (let ((known-aspect (value-of 'aspect vg)))
    ;; In "has entered" the individual for enter has aspect = #<category have>
    ;; that value should probably be replaced with this vector or the
    ;; original rule rewriten to FoM a tense/aspect-vevtor on its head
    ;; though that means that if that is followed up with absorb-auxiliary
    ;; that routine has to see if variables are already bound
    (cond
      ((and known-aspect (itypep known-aspect category::tense/aspect-vector))
       known-aspect)
      (t 
       (make/individual ;;<<<<<<<<<<<<<<<<<<<<<<<<<
	category::tense/aspect-vector nil)))))


(defun absorb-auxiliary (aux vg)
  (declare (special category::tense/aspect-vector))
  (cond
    (*subcat-test* t)
    (t
     (when (category-p vg)
       (setq vg (individual-for-ref vg)))

     ;; otherwise the variable is unavailable
     (let ((aux-type (etypecase aux
		       (individual (itype-of aux))
		       (category aux)))
	   (i (find-or-make-aspect-vector vg)))
       (assert (itypep i category::tense/aspect-vector))

       ;; Check for negation
       (when (value-of 'negation aux)
	 ;;/// RJB has negation on event too -- sort that out
	 (setq  i (bind-dli-variable 'negation (value-of 'negation aux) i)))

       ;; Propagate the auxiliary
       (case (cat-symbol aux-type)
	 ((category::be-able-to	;; see modals.lisp
	   category::future
	   category::conditional)
	  (setq  i (bind-dli-variable 'modal aux i)))
	 (category::anonymous-agentive-action) ;; do
	 (category::have
	  (setq  i (bind-dli-variable 'perfect aux i)))
	 (otherwise
	  (push-debug `(,aux ,vg))
	  (error "Assimilate the auxiliary category ~a~%  ~a"
		 aux-type aux)))
       ;;(push-debug `(,i)) (break "look at i")
       (setq vg (bind-dli-variable 'aspect i vg))
       vg))))



(defmethod add-tense/aspect ((aux category) (vg category))
  (add-tense/aspect (individual-for-ref aux)
                    (individual-for-ref vg)))

(defmethod add-tense/aspect ((aux individual) (vg category))
  (add-tense/aspect aux (individual-for-ref vg)))

(defmethod add-tense/aspect ((aux category) (vg individual))
  (push-debug `(,aux ,vg)) ;;(break "is this right?")
  ;;(push-debug `(,i)) (break "look at i")
  (bind-dli-variable 'aspect (make-vg-aux aux vg) vg))

(defmethod add-tense/aspect ((aux individual) (vg individual))
  (push-debug `(,aux ,vg)) ;;(break "is this right?")
  (bind-dli-variable 'aspect (make-vg-aux aux vg) vg))

(defun make-vg-aux (aux vg)
  (let ((aux-cat (if (individual-p aux)
                     (car (indiv-type aux))
                     aux))
        (i (find-or-make-aspect-vector vg)))
    (case (cat-symbol aux-cat)
      (category::be  ;; be + ing
       (setq  i (bind-dli-variable 'progressive aux i)))
      (category::have  ;; have + en
       (setq  i (bind-dli-variable 'perfect aux i)))
      (category::past
       (setq  i (bind-dli-variable 'past t i)))
      (otherwise
       (push-debug `(,aux ,vg))
       (error "Extend add-tense/aspect to handle ~a" aux)))
    i))

(defmethod add-tense/aspect-to-subordinate-clause ((aux category) (sc category))
  (or *subcat-test*
      (add-tense/aspect-to-subordinate-clause aux (individual-for-ref sc))))

(defmethod add-tense/aspect-to-subordinate-clause ((aux individual) (sc category))
  (or *subcat-test*
      (add-tense/aspect-to-subordinate-clause aux (individual-for-ref sc))))


(defmethod add-tense/aspect-to-subordinate-clause ((aux category) (sc individual))
  (or *subcat-test*
      ;;(push-debug `(,aux ,sc)) ;;(break "is this right?")
      (bind-dli-variable 'aspect  (make-vg-aux aux sc) sc)))

(defmethod add-tense/aspect-to-subordinate-clause ((aux individual) (sc individual))
  (or *subcat-test*
      ;;(push-debug `(,aux ,sc)) ;;(break "is this right?")
      (bind-dli-variable 'aspect  (make-vg-aux aux sc) sc)))




;;;-----------------
;;; VG + Complement
;;;-----------------

(defun vg-plus-adjective (vg adj)
  (cond
    (*subcat-test* t)
    (t
     (setq vg (individual-for-ref vg))
     (let ((var (object-variable vg)))
       (if var
	   (setq vg (bind-dli-variable var adj vg))
	   (setq vg (bind-dli-variable 'participant adj vg)))
       vg))))


;;;-------------
;;; VG + Adverb
;;;-------------

(defparameter *adverb+vg* nil)

(defparameter *subordinating-adverbs*
  '(consequently))

(defun interpret-adverb+verb (adverb vg-phrase) 
  (declare (special category::deictic-location category::pp))
  ;; (push-debug `(,adverb ,vg)) (break "look at adv, vg")
  ;; "direct binding" has a specitif meaning
  ;;/// so there should be a compose method to deal with that

  ;; default
  (if (word-p vg-phrase)
      (then (format t "vg-phrase ~s is not a category or an individual,~% probably defined by morphology, can't attach adverb~%"
                    vg-phrase)
            
            vg-phrase)
      (let
          ((vg (individual-for-ref vg-phrase)))
        #|need to diagnose among
        (time)
        (location)
        (purpose)    
        (circumstance)
        (manner)
        (aspect . tense/aspect)
        BUT UNTIL THEN, JUST BIND THE ADVERB
        |#

        (cond
          ((or
            (and ;; block "THERE IS"
             (itypep vg category::be)
             (itypep adverb category::deictic-location))
            (eq (edge-form (left-edge-for-referent)) category::pp))
           nil)
          (*subcat-test*
           (cond
             ((vg-has-adverb-variable? vg vg-phrase adverb) t)
             ((and
               (collection-p vg)
               (vg-has-adverb-variable? (car (value-of 'items vg)) vg-phrase adverb))
              t)
             (t
              (break "~&can't find adverb slot for ~s on verb ~s~& in sentence ~s~&"
                     (edge-string (left-edge-for-referent))
                     (edge-string (right-edge-for-referent))
                     (sentence-string *sentence-in-core*))
              nil)))
          ((member (cat-name adverb) *subordinating-adverbs*)
           (bind-dli-variable 'subordinate-conjunction adverb vg))
          ((collection-p vg)
           (bind-dli-variable 'adverb adverb vg))
          ((vg-has-adverb-variable? vg vg-phrase adverb)
           (setq  vg (bind-dli-variable 'adverb adverb vg)))
          (t vg)))))

(defun interpret-as-comp (as vp+ed)
  (declare (ignore as))
  (edge-referent vp+ed))

(defun adjoin-ascomp-to-vg (vp as-comp)
  (declare (special vp as-comp))
  (let* ((variable-to-bind
          ;; test if there is a known interpretation of the NP/PP combination
          (subcategorized-variable
           vp :as-comp category::as-comp)))
    (cond
     (*subcat-test* variable-to-bind)
     (variable-to-bind
      (if *collect-subcat-info*
          (push (subcat-instance vp 'as-comp variable-to-bind
                                 as-comp)
                *subcat-info*))
      (setq vp (individual-for-ref vp))
      (setq  vp (bind-dli-variable variable-to-bind as-comp vp))
      vp))))

(defun vg-has-adverb-variable? (vg vg-phrase adverb)
  (cond
   ((individual-p vg)
     (loop for category in (indiv-type vg)
       thereis
       (find-variable-for-category 'adverb category)))
    ((referential-category-p vg)
     (find-variable-for-category 'adverb vg))
    (t
     (error "Trying to add adverb to verbal element whose semantics won't take ~s.~% Semantics is ~s, ~%surface string is ~s"
	    adverb
	    vg-phrase
	    (sur-string vg)))))



;;;---------
;;; VG + PP
;;;---------

(defparameter *pobj-edge* nil
  "Used to generate useful error messages when the edge 
   referent is NIL.")

(defun identify-preposition (edge)
  "Utility subroutine that is used by any check that wants
   to identity the preposition in a pp, or prep-complement, etc."
  (declare (special category::preposition edge ))
  (let* ((prep-edge (edge-left-daughter edge))
         (prep-word (edge-left-daughter prep-edge)))
    (declare (special prep-edge prep-word))
    (cond
     ((word-p prep-word)
      prep-word)
     ((edge-p prep-word)
      ;; usually indicative that the preposition is a polyword
      (cond
       ((polyword-p (edge-rule prep-word))
        (edge-rule prep-word)) ;; return the pw
       ((and (memq (cat-name (edge-form prep-word))
                   '(preposition spatio-temporal-preposition 
                     spatial-preposition)) ;; sanity check
             ;; The word was elevated to a category, e.g. 'with'
             (word-p (edge-left-daughter prep-word)))
        (edge-left-daughter prep-word))
       ((and ;; "30 minutes after stimulation ..."
         (edge-p (edge-left-daughter prep-edge))
         (itypep (edge-referent (edge-left-daughter prep-edge))
                 'amount-of-time)
         (edge-p (edge-right-daughter prep-edge))
         (memq (cat-name (edge-form (edge-right-daughter prep-edge)))
               '(preposition spatio-temporal-preposition spatial-preposition)))
        (edge-left-daughter (edge-right-daughter prep-edge)))        
       (t
         (push-debug `(,edge ,prep-edge ,prep-word))
         (break "Unexpected pattern of an edge over a preposition:~%~a"
                prep-word))))
     (t
      (push-debug `(,edge ,prep-edge ,prep-word))
      (break "Unexpected type of preposition: ~a~%~a"
             (type-of prep-word) prep-word)))))


(defun adjoin-pp-to-vg (vg pp)
  ;; The VG is the head. We ask whether it subcategorizes for
  ;; the preposition in this PP and if so whether the complement
  ;; of the preposition satisfies the specified value restriction.
  ;; Otherwise we check for some anticipated cases and then
  ;; default to binding modifier.
  (let* ((pp-edge (right-edge-for-referent))
         (prep-word (identify-preposition pp-edge)) 
         (*pobj-edge* (edge-right-daughter pp-edge))
         (pobj-referent (edge-referent *pobj-edge*))
         (variable-to-bind
          ;; test if there is a known interpretation of the VG/PP combination
          (or (subcategorized-variable vg prep-word pobj-referent)
              (and (itypep pp 'upon-condition)
                   (find-variable-for-category 'context (itype-of vg)));; circumstance)
	      ;; or if we are making a last ditch effore
              (and *force-modifiers*
                   'modifier))))
    (declare (special *pobj-edge*))

    (cond
     (*subcat-test* variable-to-bind)
     (variable-to-bind
      (when *collect-subcat-info*
        (push (subcat-instance vg prep-word variable-to-bind pp)
              *subcat-info*))
      (setq vg (individual-for-ref vg))
      (setq pobj-referent (individual-for-ref pobj-referent))
      (setq  vg (bind-dli-variable variable-to-bind pobj-referent vg))
      vg))))


(defun adjoin-prepcomp-to-vg (vg prep-comp) ;; "by binding..."
  (let* ((comp-edge (right-edge-for-referent))
         (prep-word (identify-preposition comp-edge))
         (comp-ref (edge-referent (edge-right-daughter comp-edge))))
    (push-debug `(,prep-word ,comp-ref)) ;;(break "here")
    (let ((variable
           (subcategorized-variable vg prep-word comp-ref)))
      (cond
       (*subcat-test* variable)
       (variable
        (when *collect-subcat-info*
          (push (subcat-instance vg prep-word variable prep-comp)
                *subcat-info*))
        (setq vg (individual-for-ref vg)) ;; category => individual
        (setq vg (bind-dli-variable variable comp-ref vg))
        vg)))))


;;;----------------
;;; to complements
;;;----------------

(define-category to-comp
  :specializes abstract
  :binds ((prep)
          (comp))
  :documentation "Provides a scafolding to hold
   a generic to-comp as identified by
   the pp rules in grammar/rules/syntactic-rules.
   Primary consumer is the subcategorization checking
   code below. Note that if we make these with an
   unindexed individual (in make-pp) then the index
   information doesn't come into play"
  :index (:temporary :sequential-keys prep comp))

(define-category as-comp
  :specializes abstract
  :binds ((prep)
          (comp))
  :documentation "Provides a scafolding to hold
   a generic to-comp as identified by
   the pp rules in grammar/rules/syntactic-rules.
   Primary consumer is the subcategorization checking
   code below. Note that if we make these with an
   unindexed individual (in make-pp) then the index
   information doesn't come into play"
  :index (:temporary :sequential-keys prep comp))



(defun adjoin-tocomp-to-vg (vg tocomp)
  (assimilate-subcat vg :to-comp  tocomp ;;(value-of 'comp tocomp)
		     ))

(defun interpret-to-comp-adjunct-to-np (np to-comp)
  (declare (special np to-comp))
  (let* ((complement to-comp) ;;(value-of 'comp to-comp))
         (variable-to-bind
          ;; test if there is a known interpretation of the NP/PP combination
          (subcategorized-variable np :to-comp complement)))
    (cond
     (*subcat-test* variable-to-bind)
     (variable-to-bind
      (if *collect-subcat-info*
          (push (subcat-instance np 'to-comp variable-to-bind
                                 to-comp)
                *subcat-info*))
      (setq np (individual-for-ref np))
      (setq  np (bind-dli-variable variable-to-bind to-comp np))
      np))))

(defun interpret-to-comp-adjunct-to-s (s tocomp)
  (declare (special category::perdurant category::endurant))
  ;; Tbese are very likely to be purpose clauses. A sufficient test
  ;; for that is the the s and the complement are both eventualities
  ;; (aka perdurants). 
  #| (p "Mechanistically ASPP1 and ASPP2 bind RAS-GTP and potentiates RAS signalling 
  to enhance p53 mediated apoptosis [2].") |#
  (let* ((complement tocomp);; no longer bury interpretation (value-of 'comp tocomp))
       (to-comp-var ;; e.g. for "acts to dampen..."
        (subcategorized-variable s :to-comp complement)))
    (cond
     (to-comp-var 
      (or *subcat-test*
       (setq s (bind-dli-variable to-comp-var complement s))))
     (t
      (let ((ok? (and s (itypep s category::perdurant) (itypep complement category::perdurant))))
        (cond
         (*subcat-test* ok?)
         (ok?
          (setq s (bind-dli-variable 'purpose complement s))
          s)))))))

(defun interpret-for-to-comp (for-pp to-comp)
  (let* ((complement to-comp) ;;(value-of 'comp to-comp))
	 (for-subj (value-of 'pobj for-pp))
	 (subj-var
	  (subcategorized-variable complement :subject for-subj)))
    (if *subcat-test*
	subj-var
	(bind-dli-variable subj-var for-subj complement))))
		
	    
;;;---------
;;; NP + PP
;;;---------

(defun interpret-pp-adjunct-to-np (np pp)
  (cond
    ((null np) 
     (break "null interpretation for NP in interpret-pp-adjunct-to-np edge ~s~&"
            *left-edge-into-reference*)
     nil)
    (t
     (or (when (and np pp) (call-compose np pp))
         ;; guard against passing a null NP to call-compose
         ;; Rusty - this is the hook that allows for a custom interpretation
         ;; of the meaning of this pair. If you look up at verb-noun-compound
         ;; you see a note that says it's for 'type' cases, e.g. "the Ras protein".
         ;; In general it's a hook for any knowledge we have about particular
         ;; cases / co-composition

         (let* ((pp-edge (right-edge-for-referent))
                (prep-word (identify-preposition pp-edge))
                (*pobj-edge* (edge-right-daughter pp-edge))
                (pobj-referent (edge-referent *pobj-edge*))
                (of (word-named "of"))
                (variable-to-bind
                 ;; test if there is a known interpretation of the NP/PP combination
                 (or
                  (subcategorized-variable np prep-word pobj-referent)
                  (and (eq prep-word of)
                       (itypep np 'attribute))
                  ;; or if we are making a last ditch effort
                  ;; if not, then return NIL, failing the rule
                  (and *force-modifiers* 'modifier))))
           (cond
             (*subcat-test*
              variable-to-bind)
             ((and (eq prep-word of) (itypep np 'attribute))
              ;; The 'owner' of the "of" in this case is the pobj,
              ;; rather than the np.
              (find-or-make-individual 'quality-predicate
                                       :attribute (itype-of np) :item pobj-referent))
             (variable-to-bind
              (when *collect-subcat-info*
                (push (subcat-instance np prep-word variable-to-bind pp)
                      *subcat-info*))
              (setq np (individual-for-ref np))
              (setq  np (bind-dli-variable variable-to-bind pobj-referent np))
              np)))))))


(defun interpret-pp-as-head-of-np (np pp)
  (push-debug `(,np ,pp))
  (let* ((pp-edge (right-edge-for-referent))
         (prep-word (identify-preposition pp-edge))
         (pobj-edge (edge-right-daughter pp-edge))
         (pobj-referent (edge-referent pobj-edge))
         (variable-to-bind
          ;; test if there is a known interpretation of the NP/PP combination
          (or
           (subcategorized-variable
            ;; look at the subcategorization on the pobj not on the
            ;;  preceding np
            pobj-referent
            prep-word
            np)
           ;; or if we are making a last ditch effort
           ;; if not, then return NIL, failing the rule
           (and *force-modifiers* 'modifier))))
    (cond
     (*subcat-test* variable-to-bind)
     (variable-to-bind
      (if *collect-subcat-info*
          (push (subcat-instance np prep-word variable-to-bind
                                 pp)
                *subcat-info*))
      (setq pobj-referent (individual-for-ref pobj-referent))
      (setq  pobj-referent (bind-dli-variable variable-to-bind np pobj-referent))
      (revise-parent-edge :category (itype-of pobj-referent))
      pobj-referent))))


;;;-----------------
;;; NP + VP
;;;-----------------

(defparameter *warn-about-optional-objects* nil
  "Set to T to show cases where we have a parse in which a supposed transitive verb has no parsed object.")

(defun assimilate-subject (subj vp)
  (declare (special category::subordinate-clause))
  (when
      (and subj vp) ;; have had cases of uninterpreted VPs
    (cond
      ((transitive-vp-missing-object? vp)
       (when (not *subcat-test*)
         ;; the edge isn't available and shouldn't be chaged during the test phase
         (when *warn-about-optional-objects*
           (warn "~%transitive verb without object: ~s~%"
               (extract-string-spanned-by-edge (right-edge-for-referent))))
         (revise-parent-edge :form category::transitive-clause-without-object))
       (assimilate-subcat vp :subject subj))
      ((eq (edge-form (right-edge-for-referent)) category::subordinate-clause)
       (let* ((svp vp) ;;(value-of 'comp vp)) subordinate-clause is no longer buried
	      (vg-edge (edge-right-daughter (right-edge-for-referent))))
	 (if (and (edge-p vg-edge)
                  ;; vg-edge is :long-span for cases where the
                  ;;  subordinate clause is a conjunction
                  ;; HANDLE THESE CORRECTLY
                  (is-passive? vg-edge))
	     (when
		 (and (object-variable vg-edge)
		      (null (value-of (object-variable vg-edge) svp)))
	       (assimilate-subcat svp :object subj))
	     (when
                 (missing-subject-vars (edge-referent vg-edge))
	       (assimilate-subcat svp :subject subj)))))
      ((is-passive? (right-edge-for-referent))
       (assimilate-subcat vp :object subj))
      (t (assimilate-subcat vp :subject subj)))))

(defun transitive-vp-missing-object? (vp)
  ;; this is a case like "that MEK phosphorylates" which has
  ;;  a VG, not a VP, and no object -- want to make this a
  ;;  constituent with a gap
  (and (not (is-passive? (right-edge-for-referent)))
       (not (adjective-phrase? (right-edge-for-referent)))
       (missing-object-vars vp)
       (not (value-of 'statement vp))
       (not (thatcomp-verb (right-edge-for-referent)))
       (not (loop for v in (find-subcat-vars :to-comp vp)
               thereis (value-of v vp)))))

(defun adjective-phrase? (e)
  (declare (special category::adjective))
  (let ((re (and (edge-p e)
                 (edge-right-daughter e))))
    (and (edge-p re)
         (eq category::adjective (edge-form re)))))


;; special case where the vp is a gerund, and we make it an NP (not sure how often this is right)
(defun assimilate-subject-to-vp-ing (subj vp)
  (unless 
      ;; remove the printout until it is needed again
      t ;;   *subcat-test*
    (format t "~&----assimilate-subject-to-vp-ing make an NP for ~s and ~s---~&  in ~s~&" 
            subj vp
            (if (> (length (sentence-string *sentence-in-core*)) 0)
		(sentence-string *sentence-in-core*)
		*string-from-analyze-text-from-string*)))
  (if (is-passive? (right-edge-for-referent))
      (assimilate-subcat vp :object subj)
      (assimilate-subcat vp :subject subj)))


(defparameter *vp-ed-sentences* nil)
(defun assimilate-subject-to-vp-ed (subj vp)
  (push-debug `(,subj ,vp)) ;;  (setq subj (car *) vp (cadr *))
  (let* ((vp-edge (right-edge-for-referent))
         (vp-form (edge-form vp-edge)))
    ;; We have to determine whether this is an s (which the rule
    ;; that's being invoked assumes) or actually a reduced relative,
    ;; where the criteria is whether the verb is in oblique or tensed
    ;; form. If it turned out to be a RR then we do fairly serious
    ;; surgery on the edge.
    ;;(when (edge-p (edge-right-daughter vp-edge))
    ;; The other possibility is :single-term, which indicates
    ;; that we've just got a vg (one one form or another)
    ;; and not a full vp, in which case we're returning nil
    ;; so that the rule doesn't go through.
    (cond
      (*subcat-test*
       (or (can-fill-vp-subject? vp subj) ;; case for S not reduced relative
           (can-fill-vp-object? vp subj)))
      ((can-fill-vp-subject? vp subj)
       (if (transitive-vp-missing-object? vp)
           (revise-parent-edge :form category::transitive-clause-without-object))
       (assimilate-subcat vp :subject subj))
      ((can-fill-vp-object? vp subj)
       (setq  vp
	      (create-predication-by-binding (subcategorized-variable vp :object subj)
					     subj vp
					     (list 'apply-subject-relative-clause
						   (parent-edge-for-referent))))
       
       ;; link the rc to the np
       (setq  subj (bind-dli-variable 'predication vp subj))
       (revise-parent-edge :form category::np :category (itype-of subj))
       subj)
      (t (error "How can this happen? in assimilate-subject-to-vp-ed~%" )))))


(defun can-fill-vp-subject? (vp subj)
  (and
   ;; vp has a subject
   (missing-subject-vars vp) ;; which is not bound
   (subcategorized-variable vp :subject subj)
   (or
    ;; can't be a reduced relative, no available object-var
    (not (object-variable vp)) (bound-object-vars vp)
    ;; or a statement (clausal complement)
    (value-of 'statement vp)
    (preceding-that-whether-or-conjunction? (left-edge-for-referent)))))
       
(defun can-fill-vp-object? (vp subj)
  (and ;; vp has a bound subject -- NP can fill object
   (bound-subject-vars vp)
   (subcategorized-variable vp :object subj)))

(defun preceding-that-whether-or-conjunction? (left-edge)
  (declare (special left-edge))
  (when (and (edge-p left-edge)
             (position-p (pos-edge-starts-at left-edge)))
    (let* ((previous-treetop (left-treetop-at/only-edges (pos-edge-starts-at left-edge)))
	   (prev-form (and (edge-p previous-treetop)
			   (edge-form previous-treetop)))
	   (prev-cat (and (edge-p previous-treetop)
			  (edge-category previous-treetop))))
      (declare (special previous-treetop prev-form prev-cat))
      (cond
	((or
	  (and (category-p prev-form)
	       (member (cat-name prev-form)
                       '(SUBORDINATE-CONJUNCTION CONJUNCTION
                         SPATIO-TEMPORAL-PREPOSITION ADVERB)))
	  (and (category-p prev-cat)
	       (member (cat-name prev-cat) '(THAT))))
        
	 t)
	(t
	 ;;(format t "preceding-that-or-whether? prev-form=~s and prev-cat=~s~&" prev-form prev-cat)
	 nil)))))



;;;--------------------------
;;; subordinate conjunctions
;;;--------------------------

(defun interpret-subordinator (conj eventuality)
  "Goes with (subordinate-conjunction vp+ing) rule and others like it.
  The effect of the subordinate conjunction strictly depends on
  the conjunction or its class, so most of the work will be done
  by the method. If there's no applicable method then we mark
  the conjunction as a modifier just to keep it around. My reading
  of Quirk et al. is that the ones that we're most interested in
  have an adverbial function in structuring the discourse (19.55)."
  (or (call-compose conj eventuality)
      eventuality)) ;; for the moment dropping it on the floor


;;;----------------------
;;; "that" and "whether"
;;;----------------------

(defun create-thatcomp (that s)
  (declare (ignore that))
  s)

(defun create-whethercomp (that s)
  (declare (ignore that))
  s)

(defun create-howcomp (how s)
  (declare (ignore how))
  s)

(defun assimilate-object (vg obj)
  (assimilate-subcat vg :object obj))

(defun assimilate-np-to-v-as-object (vg obj)
  (let ((result
	 (if (and *current-chunk* (member 'ng (chunk-forms *current-chunk*)))
	     (verb-noun-compound vg obj)
	     (assimilate-object vg obj))))
    (cond
      (*subcat-test* result)
      (result
       (if (and *current-chunk* (member 'ng (chunk-forms *current-chunk*)))
	   (revise-parent-edge :category (itype-of obj)
			       :form category::n-bar
			       :referent result)
	   (revise-parent-edge :category (itype-of vg)
			       :form (ecase (cat-name (edge-form (parent-edge-for-referent)))
				       ((vg vp) category::vp)
				       ((vp+ing vg+ing) category::vp+ing)
				       ((vp+ed vg+ed) category::vp+ed))				   
			       :referent result))
       result))))
    



(defun assimilate-thatcomp (vg-or-np thatcomp)
  (assimilate-subcat vg-or-np :thatcomp thatcomp))

(defun assimilate-whethercomp (vg-or-np whethercomp)
  (assimilate-subcat vg-or-np :whethercomp whethercomp))

(defun assimilate-pp-subcat (head prep pobj)
  (assimilate-subcat head (subcategorized-variable head prep pobj) pobj))


;;;-----------------------------
;;; subcategorization machinery
;;;-----------------------------

(defun form-label-corresponding-to-subcat (subcat-label)
  ;; Used with pronouns to encode relationship when it's known
  (case subcat-label
    (:subject category::grammatical-subject)
    (:object category::direct-object)
    (otherwise nil)))

(defun assimilate-subcat (head subcat-label item)
  (let ((variable-to-bind
         ;; test if there is a known interpretation of the NP+VP combination
         (subcategorized-variable head subcat-label item)))
    (cond
     (*subcat-test* variable-to-bind)
     (variable-to-bind
      (collect-subcat-statistics head subcat-label variable-to-bind item)
      (setq head (individual-for-ref head))
      (setq item
	     (condition-anaphor-edge item subcat-label (var-value-restriction variable-to-bind)))
      (setq  head (bind-dli-variable variable-to-bind item head))
      head))))

(defun apply-control-or-raise (head label item)
  (declare (special head label item))
  (lsp-break "apply-control-or-raise")
  nil)



(defun condition-anaphor-edge (item subcat-label v/r)
  ;; We now know the restriction that any candidate referent for this
  ;; pronoun has to satisfy, and we know the v/r of the variable it has to bind. This
  ;; edge was recorded in the layout as a pronoun and will be retrieved in
  ;; the pass that does the search after all the parsing has finished, so
  ;; this is the edge that we work with. We need to record this
  ;; information, and we need to arrange a 'dummy' individual to be created
  ;; and bound to this variable during the parsing phase so that we can
  ;; track through its bound-in relation an replace it in that binding with
  ;; the correct referent once we've identified it. Kind of Rube Goldberg
  ;; -esque, but it's the price we pay for delaying rather than trying to
  ;; identify the referent at moment the pronoun is encountered.
  (cond
    ((and *do-anaphora* (is-pronoun? item))
     (let* ((pn-edge (edge-for-referent item))
            (ignore? (ignore-this-type-of-pronoun (edge-category pn-edge))))
       (tr :conditioning-anaphor-edge pn-edge)
       (cond
	 (ignore?
	  item)
	 (*constrain-pronouns-using-mentions*
          (tr :recording-pn-mention-v/r v/r)
	  (setf (mention-restriction (edge-mention pn-edge)) v/r)
	  item)
	 (t
	  (let ((relation-label (or (form-label-corresponding-to-subcat subcat-label)
                                    category::np))
                (restriction (or v/r category::unknown-grammatical-function)))
            (declare (special category::np category::unknown-grammatical-function))
	    (when (consp restriction)
	      ;; the first one after the :or
	      (setq restriction 
		    (or (loop for c in (cdr restriction) 
                              when (itypep (edge-referent pn-edge) c)
                              do (return c))
			(cadr restriction))))
            (tr :recording-pn-mention-v/r restriction)
	    (let ((new-ref (individual-for-ref restriction)))
	      (unless ignore?
                ;; If we're going to ignore the pronoun we don't want or
                ;; need to rework its edge
                (tr :anaphor-conditioned-to new-ref restriction relation-label)
		;; Encode the type-restriction in the category label
		;; and the grammatical relationship in the form
		(setf (edge-category pn-edge) restriction)
		(setf (edge-form pn-edge) relation-label)
		(setf (edge-referent pn-edge) new-ref)
		(setf (edge-rule pn-edge) 'condition-anaphor-edge))
	      new-ref))))))
    (t item)))

(defparameter *trivial-subcat-test* nil)
(defparameter *tight-subcats* nil)
(defparameter *dups* nil)

(defparameter *ambiguous-variables* (list nil))


(defun show-ambiguities ()
  (setq *ambiguous-variables* (list nil))
  (compare-to-snapshots)
  (display-subcat-ambiguities))


(defun display-subcat-ambiguities ()
  (np (setq *dups*
            (sort *ambiguous-variables* #'string<
                  :key #'(lambda(x)(if (individual-p (car x))(cat-name (itype-of (car x))) "")))))
  
  (loop for pat in
       (sort
	(loop for pat in 
	     (remove-duplicates (loop for x in *dups* collect (list (second x)(fifth x))) :test #'equal)
	   collect pat)
	#'string<
	:key
	#'(lambda (p)
	    (let ((key (car p)))
	      (etypecase key
		(word (word-pname key))
		(polyword (pw-pname key))
		(symbol key)))))
     do (terpri)(print pat)))

(defparameter *show-over-ridden-ambiguities* nil)

(defun subcategorized-variable (head label item)
  "Returns the variable on the HEAD that is subcategorized for
   the ITEM when it has the grammatical relation LABEL to
   the head."
  (declare (special item *pobj-edge*))
  ;; included in the subcategorization patterns of the head.
  ;; If so, check the value restriction and if it's satisfied
  ;; make the specified binding
  (loop while (edge-p label) ;; can happen for edges over polywords like "such as"
     do (setq label (edge-left-daughter label)))
  (cond
    ((null head)
     (break "~&null head in call to subcategorized-variable")
     nil)
    ((null item)
     (cond
       ((and (boundp '*pobj-edge*) *pobj-edge*)
	(warn "~&*** null item in subcategorized pobj for ~
                 edge ~s~&  in sentence: ~s~%" *pobj-edge*
                 (sentence-string *sentence-in-core*)))
       ((eq label :subject)
        (warn "~&*** null item in subcategorized subject for ~
                 clause ~s~&  in sentence: ~s~%"
              (retrieve-surface-string head)
              (sentence-string *sentence-in-core*)))
       ((eq label :object)
        (lsp-break "~&*** null item in subcategorized object for ~
                 clause ~s~&  in sentence: ~s~%"
              (retrieve-surface-string head)
              (sentence-string *sentence-in-core*)))
       (t
        (warn "~&*** null item in subcategorized-variable~& ~
                 edge ~s~&  in sentence: ~s~%" *pobj-edge*
                 (sentence-string *sentence-in-core*))))
     nil)
    ((consp item)
     (warn "what are you doing passing a CONS as an item, ~s~&" item)
     nil)
    (t
     ;; (when (itypep item 'to-comp) (setq item (value-of 'comp item)))
     ;;/// prep-comp, etc.
     (find-subcat-var item label head)
     )))


(defparameter *label* nil) ;; temporary hack to get the label down to satisfies-subcat-restriction?
(defparameter *head* nil)


(defparameter *subcat-use* nil ;; (make-hash-table :size 2000)
  )

(defun record-subcat-use (l category variable)
  (let* ((label (pname l))
         (c-name (cat-name category))
         (v-name (var-name variable))
         (var-alist (or
                     (assoc v-name (gethash c-name *subcat-use*))
                     (car (push (list v-name (list label 0))
                                (gethash c-name *subcat-use*)))))
         (l-val (assoc label (cdr var-alist))))
    (if l-val
        (incf (second l-val))
        (nconc var-alist (list (list label 1))))))

(defun show-subcat-use ()
  (let ((hh (hal *subcat-use*)))
    (loop for h in hh
       do
         (setf (cdr h)
               (sort (cdr h) #'string< :key #'car)))
    (np (sort hh #'string< :key #'car))))


(defun find-subcat-var (item label head)
  (declare (special item label head))
  (let ((category (itype-of head))
        (subcat-patterns (known-subcategorization? head)))
    (declare (special category subcat-patterns))
    (when subcat-patterns
      (setq *label* label)
      (setq *head* head)
      (let ((*trivial-subcat-test* nil)
            variable  over-ridden)
        (if (and *ambiguous-variables*
                 (not *subcat-test*))
            (let ( pats  sover-ridden )
              (loop for pat in subcat-patterns
                 as scr = (subcat-restriction pat)
                 do (when (eq label (subcat-label pat))
                      (when (satisfies-subcat-restriction? item scr)
                        (push pat pats))))
              (setq over-ridden (check-overridden-vars pats))
              (setq pats (loop for p in pats unless (member p over-ridden) collect p))
              (setq variable (variable-from-pats item head label pats subcat-patterns)))
            (dolist (entry subcat-patterns)
                (when (eq label (subcat-label entry))
                  (when (satisfies-subcat-restriction? item entry)
                    (setq variable (subcat-variable entry))
                    (return)))))
        
        (when (and *ambiguous-variables*
                   (consp variable))
          (setq variable
                (if over-ridden
                    (cond
                      ((or (equal '(agent object)
                                  (mapcar #'var-name variable))
                           (equal '(object agent)
                                  (mapcar #'var-name variable)))
                       (loop for v in variable
                          when (eq 'object (var-name v))
                          do (return v)))
                      (t
                       (announce-over-ridden-ambiguities item head label variable)
                       (define-disjunctive-lambda-variable variable category)))
                    ;; else
                    (define-disjunctive-lambda-variable variable category))))
        (when (and variable *subcat-use*)
          (record-subcat-use label (itype-of head) variable))
        variable ))))

(defun find-subcat-vars (label cat)
  (loop for pat in (subcat-patterns cat)
     when (eq label (subcat-label pat))
     collect (subcat-variable pat)))

(defun find-object-vars (cat)
  (find-subcat-vars :object cat))

(defun find-subject-vars (cat)
  (find-subcat-vars :subject cat))

(defun missing-object-vars (i)
  (let ((ov (find-object-vars i)))
    (and ov
         (not (get-tag :optional-object (itype-of i)))
         (not (loop for o in ov thereis (value-of o i))))))

(defun missing-subject-vars (i)
  (let ((sv (find-subject-vars i)))
    (and sv
         (not (loop for s in sv thereis (value-of s i))))))

(defun bound-object-vars (i)
  (loop for o in (find-object-vars i) thereis (value-of o i)))

(defun bound-subject-vars (i)
  (loop for s in (find-subject-vars i) thereis (value-of s i)))

(defun announce-over-ridden-ambiguities (item head label variable)
  (when *show-over-ridden-ambiguities*
    (format t "~%over-ridden ambiguity now preserved~
               ~%  ambiguous subcats for attaching ~s to ~s ~
                 with ~s:~%  ~s~%   ~s~%"
            item head label variable (sentence-string *sentence-in-core*))))

(defun variable-from-pats (item head label pats subcat-patterns)
  (declare (special category::number))
  (let ( variable )
    (cond
      ((cdr pats)
       (setq variable (mapcar #'subcat-variable pats))
       (if (itypep item category::number)
           (setq variable (car variable))
           ;; these are mostly bad parses with a dangling number -- we should collect them
           (push (list head label item
                       (sentence-string *sentence-in-core*)
                       (loop for pat in pats collect
                            (list (subcat-variable pat)(subcat-source pat))))
                 *ambiguous-variables*)))
      (pats
       (setq variable (subcat-variable (car pats)))))
    (when *trivial-subcat-test* 
      (unless variable
        (dolist (entry subcat-patterns)
            (when (eq label (subcat-label entry))
              (when (satisfies-subcat-restriction? item entry)
                (setq variable (subcat-variable entry))
                (return))))))
    variable))




(defparameter *biological-tests* nil)

(defun satisfies-subcat-restriction? (item pat-or-v/r)
  (declare (special category::pronoun/first/plural category::ordinal
                    category::this category::that category::these category::those
                    category::pronoun category::number category::ordinal))
  (let ((restriction
         (if (subcat-pattern-p pat-or-v/r)
             (subcat-restriction pat-or-v/r)
             pat-or-v/r))
        (source (when (subcat-pattern-p pat-or-v/r) (subcat-source pat-or-v/r)))
        (var (when (subcat-pattern-p pat-or-v/r) (subcat-variable pat-or-v/r)))
        (override-category (override-label (itype-of item))))
    (when (and *trivial-subcat-test*
               (note-failed-tests item restriction))
      (return-from satisfies-subcat-restriction? t))
    (flet ((subcat-itypep (item category)
             ;; For protein-families and such that are re-written
             ;; as a more general catgory (e.g. protein). There's no
             ;; provision for inheritance, but if we need it because
             ;; of the reach of the override we should do something
             ;; different with it.
             (cond
               ((itypep item category)) ;; handles conjunctions
               (t (eq category override-category)))))
      (cond
        ((or
          (itypep item category::this)
          (itypep item category::that)
          (itypep item category::these)
          (itypep item category::those))
         t)
        (;;(itypep item 'pronoun/first/plural) - but should add check for agentive verbs
         (itypep item category::pronoun) ;; of any sort
         t)
        ((and (itypep item category::number)
              (not (itypep item category::ordinal)))
         t)
        ((consp restriction)
         (cond
           ((eq (car restriction) :or)
            (loop for type in (cdr restriction)
               thereis (subcat-itypep item type)))
           ((eq (car restriction) :primitive)
            ;; this is usually meant for NAME (a WORD) or
            ;; other special cases
            nil)
           (t (error "subcat-restriction on is a cons but it ~
                      does not start with :or~%  ~a"
                     restriction))))
        ((category-p restriction)
         (subcat-itypep item restriction))
        ((symbolp restriction) ;; this is the case for :prep subcat-patterns
          nil)
        (t (error "Unexpected type of subcat restriction: ~a"
                  restriction))))))

(defun check-overridden-vars (pats)
  (cond
    ((and
      (eq (length pats) 2)
      (eq (subcat-label (first pats)) :m)
      (member (var-name (subcat-variable (first pats))) '(agent object))
      (member (var-name (subcat-variable (second pats))) '(agent object)))
     (if (eq (var-name (subcat-variable (first pats))) 'object)
         (list (second pats))
         (list (first pats))))
    (t
     (let (over-ridden)
       (loop for pat in pats
          do
            (loop for p in pats
               when
                 (and (not (eq (subcat-restriction p) (subcat-restriction pat)))
                      (not (consp (subcat-restriction p)))
                      (if (consp (subcat-restriction pat))
                          (loop for i in (cdr (subcat-restriction pat))
                             thereis (itypep i (subcat-restriction p)))
                          (itypep (subcat-restriction pat) (subcat-restriction p))))
               do (push p over-ridden)))
       over-ridden))))

(defun note-failed-tests (item restriction)
  ;; return non-null when tests failed
  (let ((*trivial-subcat-test* nil))
    (labels ((scat-symbol (c)
               (typecase c
                 (referential-category (simple-label c))
                 (cons (loop for s in c collect (scat-symbol s)))
                 (symbol c))))
      (when (not (satisfies-subcat-restriction? item restriction))
        ;; test would have failed -- collect it
        (pushnew `(,(scat-symbol (itype-of *head*))
                    ,*label*
                    ,(scat-symbol restriction)
                    ,(scat-symbol (itype-of item))
                    ,(list 
                      (when *left-edge-into-reference*
                        (actual-characters-of-word
                         (pos-edge-starts-at *left-edge-into-reference*)
                         (pos-edge-ends-at *left-edge-into-reference*) nil))
                      (when *right-edge-into-reference*
                        (actual-characters-of-word
                         (pos-edge-starts-at *right-edge-into-reference*)
                         (pos-edge-ends-at *right-edge-into-reference*) nil))))
                 *tight-subcats*
                 :test #'equal)))))
    



;;;----------------------
;;; Prepositional phrase
;;;----------------------

(define-category prepositional-phrase
  :specializes abstract
  :binds ((prep)
          (pobj))
  :documentation "Provides a scafolding to hold
  a generic prepositional phrase as identified by
  the pp rules in grammar/rules/syntactic-rules.
  Primary consumer is the subcategorization checking
  code below. Note that if we make these with an
  unindexed individual (in make-pp) then the index
  information doesn't come into play"
  :index (:temporary :sequential-keys prep pobj))

(mark-as-form-category category::prepositional-phrase)

(define-category relativized-prepositional-phrase
  :specializes prepositional-phrase
  :binds ((prep)
          (pobj))
  :documentation "Provides a scafolding to hold
  a generic prepositional phrase as identified by
  the pp rules in grammar/rules/syntactic-rules.
  Primary consumer is the subcategorization checking
  code below. Note that if we make these with an
  unindexed individual (in make-pp) then the index
  information doesn't come into play"
  :index (:temporary :sequential-keys prep pobj))
(mark-as-form-category category::relativized-prepositional-phrase)

(define-category prep-comp
  :specializes abstract
  :binds ((prep)
          (comp))
  :documentation "If to-comp picks up infinitive complements
  this picks up all the rest, e.g. 'by being phosphorylated'
  though the head decides what to do with it based on the
  composition. Same design as pps."
  :index (:temporary :sequential-keys prep comp)) 

(define-category subordinate-clause
  :specializes abstract
  :binds ((conj)
          (comp))
  :documentation "This picks up phrases like 'Thus MEK phosphorylates ERK...'
  though the head decides what to do with it based on the
  composition. Same design as pps."
  :index (:temporary :sequential-keys conj comp))

(mark-as-form-category category::subordinate-clause)




(define-category pp-relative-clause
  :specializes abstract
  :binds ((pp)
          (clause))
  :documentation "Provides a scafolding to hold
  a generic pp-relative clause such as 'in which ERK is phosphorylated
  in grammar/rules/syntactic-rules.
  Primary consumer is the subcategorization checking
  code below. Note that if we make these with an
  unindexed individual (in make-pp) then the index
  information doesn't come into play"
  :index (:temporary :sequential-keys prep pobj))

(defun make-pp (prep pobj)
  (or *subcat-test*
      (make-simple-individual ;;make-non-dli-individual <<<<<<<<<<<<
       category::prepositional-phrase
       `((prep ,prep) (pobj ,pobj)))))

(defun make-relativized-pp (prep pobj)
  (or *subcat-test*
      (make-simple-individual ;;make-non-dli-individual <<<<<<<<<<<<
       category::relativized-prepositional-phrase
       `((prep ,prep) (pobj ,pobj)))))

(defun make-ordinal-item (ordinal item)
  (setf (non-dli-mod-for item) (list 'ordinal ordinal))
  item)

(defun make-subordinate-clause (conj clause)
  (when (not (eq category::pp (edge-form (left-edge-for-referent))))
    (bind-dli-variable 'subordinate-conjunction conj clause)))

(defun make-pp-relative-clause (pp clause)
  (or *subcat-test*
      	      
      ;; place for trace or further adornment, storing
      ;; (p "activity of ras.")
      ;; (break "Look at who is calling make-pp")
      (make-simple-individual ;;<<<<<<<<<<<<<<<<<<<<<<<<<<<
       category::pp-relative-clause
       `((pp ,pp) (clause ,clause)))))


(defun make-prep-comp (prep complement)
  ;; Called for the pattern 
  ;; preposition + (vg vg+ing vg+ed vg+passive vp+passive & vp)
  (declare (special category::to category::prep-comp))
  ;;(push-debug `(,prep ,complement)) (break "where prep?") 
  (cond
    (*subcat-test*
     (and prep complement))
    ((eq prep category::to)
     (revise-parent-edge :form category::to-comp)
     complement)
    (t
     ;; If this starts to make a lot of preposition-specific
     ;; distinctions then we need to refactor and move the
     ;; cond up.
     (revise-parent-edge :form category::prepositional-phrase)	 
     (make-simple-individual ;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      category::prepositional-phrase
      `((prep ,prep) (comp ,complement))))))


;;;---------
;;; be + PP
;;;---------

(defun make-copular-pp (be-ref pp)
  (when (and
         (or (not (edge-p *left-edge-into-reference*))
             ;; case where there is no semantic predication established,
             ;; but there is a syntactic object
             ;; e.g. "was the result of defects in the developing embryo"
             (not (member (cat-name (edge-form *left-edge-into-reference*))
			  '(s vp thatcomp))))
	 (null (value-of 'predication be-ref)))
    ;; If this is not already a predicate copula ("is a drug")
    (let* ((prep (value-of 'prep pp))
           (pobj (value-of 'pobj pp)))
      (cond
       (*subcat-test*
        ;; when we have clausal "to-pp" like
        ;;  to enhance craf activation
        ;; this is NOT a copular PP
        (and prep pobj))
       (t
        (make-simple-individual ;;<<<<<<<<<<
              category::copular-pp
              `((copula ,be-ref)
                (prep ,prep) (pobj ,pobj))))))))

(defun apply-copular-pp (np copular-pp)
  (declare (special category::copular-predicate))
  (when
      (itypep copular-pp 'subordinate-clause)
    ;; this may no longer work -- get an example and test it
    (setq copular-pp (value-of 'comp copular-pp)))
  (let* ((prep (get-word-for-prep (value-of 'prep copular-pp)))
         (pobj (value-of 'pobj copular-pp))
         ;;(copula (value-of 'copula copular-pp))
         (variable-to-bind (subcategorized-variable np prep pobj)))
    (cond
     (*subcat-test* variable-to-bind)
     (t
      (when *collect-subcat-info*
        (push (subcat-instance np prep variable-to-bind copular-pp)
              *subcat-info*))
      (let ((predicate (bind-dli-variable
			variable-to-bind
			pobj
			(individual-for-ref np))))
	(revise-parent-edge :category category::copular-predicate)
        (make-simple-individual ;;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
         category::copular-predicate
         `((predicate ,predicate)
	   (predicated-of ,np))))))))

(defun get-word-for-prep (prep-val)
  (resolve/make ;; needs to be a word for the subcat frame!
   (string-downcase
    (symbol-name
     (cat-symbol prep-val)))))


;;;-----------------------
;;; type-queries on edges
;;;-----------------------

(defun is-passive? (edge)
  (declare (special category::subordinate-clause))
  (cond
    ((eq (edge-form edge) category::subordinate-clause)
     (is-passive? (edge-right-daughter edge)))
    (t
     (let ((cat-string (symbol-name (cat-name (edge-category edge)))))
       (and (> (length cat-string) 3)
	    (equalp "+ED" (subseq cat-string (- (length cat-string) 3))))))))


;;;-----------------
;;; There + BE
;;;-----------------

(defun make-there-exists (predication)
  (make-an-individual 'there-exists
                      :predication predication))

(defun make-exist-claim (right-edge)
  (let ((exists (make-unindexed-individual category::there-exists))) ;;<<<<<<<
    (bind-dli-variable 'object right-edge exists)))

;;; Adjuncts for clauses 
(defun add-adjunctive-clause-to-s (s adjunctive-clause)
  "If the clause (s) denotes a perdurant it will have a variable
  we can use to declare that it is causally related to the adjunct
  usually, it appears, because it causes it or creates the conditions
  that make it possible."
  ;;//// needs a lot more work on this relation
  (let* ((variable-to-bind 
          (find-variable-for-category 
           'cause-of (itype-of s))))
    (cond
     (*subcat-test* variable-to-bind)
     (variable-to-bind
      (setq s (bind-dli-variable variable-to-bind adjunctive-clause s))
      s))))



(defun add-time-adjunct (time vp)
  ;; treat both "now" and "then" as subordinate conjunctions
  ;; rather than time
  (if (member (cat-name (edge-form (left-edge-for-referent)))
              '(adjunct subordinate-conjunction))
      (bind-dli-variable 'subordinate-conjunction time (individual-for-ref vp))
      (bind-dli-variable 'time time (individual-for-ref vp))))
