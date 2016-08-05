;;; -*- Mode: Lisp; Syntax: Common-lisp; Package: sparser; -*-
;;; Copyright (c) 2010-2016 David D. McDonald 
;;;
;;;            "attribution"
;;;   Module:  "model;core:kinds:"
;;;  version:  July 2016

(in-package :sparser)

#| This is a conceptualization of the relationships among
an entity, its properties ('qualities'), the value of those
properties at a given moment, and the spaces of those values
per se, independent of any of the things that could have them. 

For any attribute, we want to represent

-- A category that says that the attribute is applicable.
It would typically be used as a mixin, and supply the
variable to which values of the attribute are bound.

-- A category for the values the attribute can have. 
For values that have names ("red", "fast", "tall").
We represent the values as instances of this category.

-- The attribute per se. Assuming the attribute is the sort
that has a simple name ("color", "speed", "height") this
representation will supply the referent for the edge over
that word.

-- Because you can talk about an attribute and the thing
it applies to in a maximal projection ("the color of the block",
"the block's color"), there ought to be a way to represent
that. 

-- There are other linguistic factorings of the triple of
attribute, value, and object to which it applies. And there
will need to be 'carriers' for tense/aspect and presumably
the context(s) in which the triple is germane. 

-- For instance there is a predicate projected just from
the value. The simple gloss of this might be, e.g. "being tall".
But we can't just use the attribute value for this, since
we need to be able to represent, e.g. "are never tall.",
so the representation of this predicate needs the right hooks.

-- If think about predicates then we naturally think about
the predications that arise from applying the predicate to
a 'subject', e.g. "southern Chinese girls are never tall"

|#

;;;------------------------------------------------------
;;; the super-categories of the per-attribute categories
;;;------------------------------------------------------

;;--- "size", "color"
;;
(define-category attribute
  :documentation "Represents the identity of the attribute
 as such. Corresponds to Dolce's 'quality type'. Refering to
 an attribute by name ('(its) size') will take us to a
 instance of this category. Provides a 'coat-hook'
 for recording ancilary information that helps in parsing,
 notably the variable."
  :specializes named-type
  :mixins (has-name)
  :binds ((var :primitive lambda-variable)))

#| Note: It's not unreasonable to contemplate the alternative
where the specific attributes (size, ethnicity, eye color) are
done as individuals. I couldn't make that work (ddm July 2016)
but if you were to go that way then these slots will have to
be added to attribute so it knows how to handle the individuals.
  :instantiates attribute
  :index (:permanent :key name)
  :rule-label attribute
  :realization (:common-noun name)    |#

;;--- "red", "big"
;;
(define-category attribute-value
  :documentation "This is for the values that an attribute
 can take. Dolce would say that this is defines the
 'region' or 'space' within which the values reside.
 We record the attribute as part of this class to make
 it easier for the parser to do the right thing if all you have
 is the word, as in 'red block'."
  :specializes abstract-region ;; more like point in the region
  :instantiates :self
  :mixins (has-name)
  :binds ((attribute :primitive category))
  :index (:permanent :key name))


;;;--------------------------------------------
;;; general categories instantiated by parsing
;;;--------------------------------------------

;;--- "the block is red"
;;
(define-category has-attribute
  :specializes predication
  :documentation "The relationship between a particular
 entity (the block in my hand, a waypoint, the caterpillar on
 that branch) and the value of some attribute."
  :instantiates :self
  :binds ((item)
          (attribute :primitive category)
          (value attribute-value))
  :index (:sequential-keys attribute item value))


;;--- "the color of the block"
;;    "the block's color"
;;    "the block has a color"

(define-category quality-predicate
  :specializes predicate
  :binds ((attribute :primitive category)
          (item))
  :documentation "Represents that there is a particular
 attribute on a particular thing without concern for what
 value it has. This is a description of the value of attribute.
 Qualities by definition inhere in / are linked to the thing
 that has the quality. The (unrepresented) open variable is
 that thing. [N.b. need to consider generics: 'the size of
 an elephant']")

;;--- "is red"  "(its) color is red"
;;
(define-category quality-value-predicate
  :specializes predicate
  :documentation "The relationship between some attribute
 and the value that it has. It reflects the value of the
 attribute at a particular moment / in a particular situation
 and tacitly for a particular individual. Loosely corresponds
 to Dolce's quale ('ql') relation. Instances of this relation
 don't need to be object-specific -- any number of things
 could have the same color, be of the same height, etc. 
 They should all make referent to the same attribute-value
 instance."  
  :binds ((attribute :primitive category)
          (value attribute-value))
  :index (:permanent :sequential-keys attribute value))



;;;-----------------------------------
;;; macro to create simple attributes
;;;-----------------------------------

(defmacro define-attribute
    (attribute-name ;; a symbol, e.g. 'size'
     &key
       ((:var name-of-variable))
       ((:mixin name-of-mixin-category))
       ((:word word-that-denotes-attribute))
       ((:a-pos attribute-part-of-speech))
       ((:value-cat name-of-field-category))
       ((:def-fn name-of-define-fn))
       ((:value-pos field-part-of-speech))
       ((:val-rule-label rule-label-for-values)))
  "Makes the function and three categories required to define
 an attribute. Constructs names for them based on the symbol that
 is passed in. Keyword arguments are provided to override the
 defaults."
   (flet ((sintern (&rest strings)
           (intern (apply #'string-append strings)
                   (find-package :sparser))))
     (let* ((var-name ;; 'size
             (or name-of-variable attribute-name))
            (mixin-name ;; has-size
             (or name-of-mixin-category
                 (sintern '#:has- var-name)))
            (v/r-category ;; 'size
             ;; must be same as name of attribute class
             attribute-name)
            (attribute-word ;; "size"
             (or word-that-denotes-attribute
                 (resolve/make
                  (string-downcase (symbol-name attribute-name)))))
            (attribute-pos
             (or attribute-part-of-speech :common-noun))            
            (attibute-field-name ;; size-value
             (or name-of-field-category
                 (sintern var-name '#:-value)))
            (instance-maker
             (or name-of-define-fn
                 (sintern '#:define- var-name)))
            (field-pos
             (or field-part-of-speech
                 :adjective))
            (field-rule-label ;; size
             (or rule-label-for-values
                 attribute-name)))
       `(progn
         ;; Suppose the name of the attribute
         ;; is 'size' and we're using all defaults
         
         ;; mixin-name: has-size
         ;; var-name: size
         ;; v/r-category: size
         (define-category ,mixin-name
           :specializes relation
           :binds ((,var-name ,v/r-category)))

         ;; attribute-name: size
         ;; attribute-pos: :common-noun
         ;; attribute-word: "size"
         (define-category ,attribute-name
           :specializes attribute
           :bindings (var
                       (find-variable-for-category
                        ',var-name ',mixin-name))
           :realization (,attribute-pos ,attribute-word))

         ;; attribute-field-name: size-value
         ;; attribute-name: size
         ;; field-rule-label size
         ;; field-pos: :adjective
         (define-category ,attibute-field-name
           :specializes attribute-value
           :bindings (attribute ',attribute-name)
           :rule-label ,field-rule-label
           :realization (,field-pos name))

         ;; instance-maker: define-size
         (defun ,instance-maker (string)
           (define-or-find-individual ',attibute-field-name
               :name string)) ))))




;;; syntax functions

(defun handle-attribute-of-head (attribute-value head)
  "Called from adj-noun-compound, e.g. 'red block'. The value
   it returns becomes the referent of the edge that spans them.
   Arguments are already individuals."
  ;; We want to know what variable to bind on the head.
  ;; Some navigation is needed, starting with the category
  ;; of the individual.
  (let* ((type-category (itype-of attribute-value))
         (attribute ;; then we look up the attribute
          (value-of 'attribute type-category))
         (variable ;; then retrieve the lambda variable
          (value-of 'var attribute))
         (type-restriction-on-head (var-category variable))
         (v/r-on-value (var-value-restriction variable)))
    ;; If we are going to worry about those two restrictions
    ;; as a condition on the applicablity of the rule, then
    ;; we need to package up the checks as functions we can
    ;; use independently of this composition machinery
    (declare (ignore type-restriction-on-head v/r-on-value))

    (setq head (bind-variable variable attribute-value head))
    head))
