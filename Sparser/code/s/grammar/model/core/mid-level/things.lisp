;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 2017 David D. McDonald  -- all rights reserved
;;;
;;;     File:  "things"
;;;   Module:  "model;core:mid-level:"
;;;  version:  August 2017

;; Initiated 8/15/17 to hold general noun-like stuff, oarticularly the
;; vocabulary need for the fixed texts in generate.lisp

(in-package :sparser)

#| 

"information" is a 'information-functional-objects' in Trips
  < functional-object < abstract-object-nontemporal

JDP: information appears to be a primitive notion

Information and goals are both things one can 'have' or 'get'
They both can be put to use for some purpose
  and their suitability for that purpose can be judged: 'relevant'
Information carries a notion of scalar quantity: 'more', 'enough'

Fixed text: "I don't have enough information to do that."
invites this reply: "What (else) do you need to know?"
|#

(define-category information
  :specializes abstract ;; non-physical < endurant ??
  :mixins (scalar)
  :instantiates self
  :lemma (:common-noun "information")
  :documentation
    "A proper axiomatization of the concept of information (Shannon, bits,
  information theory, becoming informed about something) needs a companion
  theory of knowledge and belief, which we don't need to just talk about
  messages. So we'll treat information as a [[non-physical endurant]]
  without being more specific than that. It's just a primitive that's
  not analyzed further.
  Notes:
     Information can be described or characterized, and it can be
  embodied in a medium that acts as a container for the information.
     Information must be distinguished from the the medium that carries
  it (bitstream, music score, book). The same information can be
  carried by different media and in different instances,
  i.e. information can be copied without losing its identity (which
  makes it a very special kind of stuff and drives the MPAA nuts).
  We can talk about the fidelity of a copy (compare different people
  singing the Star Spangled Banner at ball games) but poor copies are
  still copies of the same information.")



#|
"intent" is the 'result' of having an intention
   It's an 'intent' to do something
"I intend to get a new car" (same force as 'will', maybe 'expect')
"It is my intention to ..."
  (which sounds more natural that "my intent"
The noun is something you can 'have' / 'possess'
  (could be a transform from the 

"relevant" and "enough" are attributes. 
They are relational and have an explicit or implicit (contextual)
  'figure' (?) that they're predicating of. 
Tr: "relevant", "applicable", "pertinent"
  < relevant-val < information-property-val < property-val

Tr: "enough" qua 'adequate' is a quantity-related-property-val
 pred-s-post-templ  "I've talked about it enough"
 post-adv-optional-xp-templ "is it quiet enough (for you)?"
 post-adv-xp-templ: "is it quiet enough to sing?"
  and as a quantifier: Cabot calls the modifier 'size'

--- specific cases
 relevant goal
 (enough) information
 structure (I don't have any structure in mind)
 "in mind"
"Is your [intent] to ~a something?"
|#

#|
"goal" is a ps-object < mental-object < mental-construction
    < abstract-object-non-temporal
Tr "goal" words: "intent" "objective" "target"
  taking a figure/ground and formal

Dolce: mental-object
|#

;;;---------------
;;; Having a name
;;;---------------
#|
(define-category has-a-name
  :specializes has-attribute ;; vars: item, attribute, value
  :mixins (patient)
  :restrict ((agent physical-agent)
             )
  :documentation " The attribute per se is 'name'
    and with particular names ('RAS', 'David') as the
    values of the attribute.
"
  :realization 
    (:verb "name"
     :eft svo
     :s agent  ;; "we[s] named him[o] Daniel[
     :s patient
     :o patient
     :

;; "call" is in general-verbs as svo bio-rhetorical

     
(define-category give-something-a-name
  :specializes has-attribute ;; vars: item, attribute, value
  :mixins (agent patient)
  :restrict ((agent physical-agent)
             )
  :documentation "If there's an agent it's the entity
    that assigned the name to the patient (e.g. a parent
    or an NIH committee). The attribute per se is 'name'
    and with particular names ('RAS', 'David') as the
    values of the attribute.
"
  :realization 
    (:verb "name"
     :eft svoa ;; subject,verb,object,a value -- like "paint them red"
     :s agent  ;; "we[s] named him[o] Daniel[
     :s patient
     :o patient
     :
     |#


;;--- "model"
#|  'create/make/build a model where <description>
"add X to the model",  "remove X from" => make is a container
"the model contains X"
"build a model" -- artifact (like 'stack')
Show sents:  
  "a novel model for", "an established in vitro model for" <== dominant case
      -- purpose?
  "our model suggests"  --- information?
  "supporting the model that"
  "in this model P" -- the contents of the model do P
  |#
(define-category model
  :specializes container
  :mixins (predication) ;; make "consistent"/bio-relation's theme v/r happy
  :realization (:noun "model"))



;;--- "contain" is also in general-verbs as a bio-relation
#|
sp> (p/s "the model contains MEK")
[the model ][contains ][MEK]
                    source-start
e7    CONTAIN       1 "the model contains MEK" 5
                    end-of-source
(#<contain 92950>
 (participant (#<model 92947> (has-determiner (#<the 106> (word "the")))))
 (theme
  (#<protein-family MEK 85897> (raw-text "MEK") (name "MEK") (uid "BE:MEK")))
 (present #<ref-category PRESENT>))


;;--- "contruct" is also in general-verbs as a bio-method
probably to get the noun reading
|#
