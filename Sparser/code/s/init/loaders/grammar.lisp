;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1994-2000,2010-2016  David D. McDonald  -- all rights reserved
;;; Copyright (c) 2007-2010 BBNT Solutions LLC. All Rights Reserved
;;;
;;;      File:  "grammar"
;;;    Module:  "init;loaders;"
;;;   version:  July 2016

;; broken out from loaders;master-loader 4/19/94. Added Whos-news-post-dossiers-loader
;;  4/29 added [words;whitespace assignments].  5/25 consolidated the
;;  adjuncts.  6/17 gated the call to the 2d loader for Who's News.
;;  7/13 uncommented loading of pronouns 7/22 put them under their own gate
;;  so they'd show up in the right place in the grammar menu.  8/10 reordered
;;  resource initializations now that they use kconses.  9/18 moved [analyzers;dm&p:
;;  measure] to the last point in the load so that all the categories will be
;;  defined before it loads.  10/12 move pct in from whos-news.  10/24 put a gate
;;  on the call to [syntax;loader] because none of those modules are showing up
;;  in the menu.  1/5/95 gated the HA loader, put in [newlines:loader].
;;  1/26 added *specific-sources*.  2/28 put gate around collections.
;;  3/18 reviewed all the calls to be sure they were via logicals.
;;  3/31 revised the gate on pronouns.   5/5 added *da* case.    7/13 revised
;;  the gate on core;pronoun.  11/9 ordered tree-families after syntax
;;  11/10 took it back.  12/20 broke out part of the loading of numbers, and
;;  added financials. 12/26 renamed financials to ern -- financials is empty as
;;  a core module. 1/13/96 gave financials back some content.  6/4 amended the
;;  gate for delayed loading.  6/5 added an additional gate around the 2d-stage
;;  loader for titles.  6/17 added edge types.  6/25 added some gates for copy-file
;;  and moved in some files that weren't within the grammar directory tree.
;; 7/21 added *nih*. 8/16/97 added gates for no model. 10/11 coverted over to gload.
;; 12/6 conditionalized loading of tree-families on *lattice-points*. 7/12/98 included
;; *ern* into the conditionalization. 12/13/99 added *kinds*. 3/18/00 conditionally
;; bumped the company loader to 2 for *lattice-points*. 3/21 ditto collections.
;; 5/1 moved collections and proper-names after tree families. 6/14 moved collections
;; after numbers to get the right category for 'number'. Moved companies after collections
;; and also numbers-part-2. 9/6 conditionalized finance and amounts to *lattice-points*
;; 2/9/07 Added *SDM&P*. 7/27 moved collections ahead of amounts and numbers.
;; 10/5/09 Moved in [tree-families;correspondences] because it has to be after most
;; if not all of the grammar has been loaded. 6/19/10 added Porter-stemmer.
;; 11/12/10 Removed *poirot* since that code's being revamped and redistributed
;; and we don't have rights to its source anyway. Added mumble-interface next to
;; correspondences. 7/10/11 Added hook for the generic lexicon with call to setup-
;; comlex. 7/19 added *generic-military*. 8/1 uncommented loading of (very minimal)
;; upper-model so general categories are available earlier. 8/25 Moved collections
;; up just after the upper-model because they had followed location which depended
;; on them to formulate plurals. 9/16 Broke words loader into two parts: loader1
;; and loader-part-2. 9/29 moved 32d part later. 12/16/11 added hurricanes.
;; 12/3/12 Removed bracket files to their own loader. 3/18/13 added 2d-loader
;; for kinds.  Also bumped title loader to 3.  7/1/13 Added a post-loader for adjunct
;; rules. 12/2/13 waypoints. 1/29/14 Removing the *c3* guards to see if everything
;; will load compatibly. 3/28/14 converted loading kinds;upper-model to kinds;1st-loader
;; so that file could be broken into more useful pieces. 4/16/14 moved it just below
;; collections so plural realizations would work. 5/25/14 added a call to make temporal
;; sequences among the final operations after dossiers are loaded. 6/1/14 added
;; more temporal bits that late. 6/4/14 Removed NIH. 6/15/14 Adding more grammar
;; module gates so we get a better tally of how  many words, etc. we have. 12/10/14
;; moved 1st-kinds in front of collections, which led to adjustments in the construction
;; of plurals for the lemmas in 1st-kinds. 1/30/15 had to change conditionalization
;; on situation to get text structure to load. 9/22/15 Want to refer to the upper model
;; in the categories that are defined with the words so moved kinds;1st-loader ahead
;; of words. 10/6/15 added blocks-world. 12/3/15 added mid-level. 12/23/15 put in
;; special-case aspect of switch settings at very beginning before any individuals
;; are created. 3/15/16 Moved kinds 1st loader out to the master loader.
;; 4/5/16 Moved finance after ERN which implies that ERN should move to core.

(in-package :sparser)

(defun load-the-grammar ()
  "Depending on the value of *load-the-grammar* this routine will
either be run now as part of launching Everything, or will be
omitted and then run (perhaps) after the image has been launched."

  (what-to-do-with-unknown-words :capitalization-digits-&-morphology)
  (initialize-cons-resource)
  (when *include-model-facilities*
    (initialize-individuals-resource)
    (establish-binding-resource))

  (load-grammar-specific-edge-types)

  (gload "fsa;loader - model")

  (gate-grammar *standard-syntactic-categories*
    (gload "the-categories;categories"))

  (gate-grammar *brackets*
    ;; the bracket definitions reference syntactic categories
    (gload "brackets;loader"))

  (gate-grammar *tree-families*
    (gload "tree-families;shortcut-loader"))

  (gate-grammar *general-words*
    (gload "words;loader")
    ;; the function words make reference to bracket types and upper model categories
    (gload "words;whitespace assignments"))

  (gate-grammar *tree-families*
    ;; This should come after any of the modules whose categories
    ;; it references
    (gload "tree-families;loader"))

  (gate-grammar *collections*
    ;; sequence-of-numbers requires sequence. Collections had been after
    ;; the loading of amounts
    (gload "collections;loader"))

  (gate-grammar *kinds* ;; older upper model
    ;; The upper model proper is loaded by the-master-loader
    ;; as part of loading objects because the doc and
    ;; situation modules refer to parts of it
    (gload "kinds;loader"))

  (gate-grammar *qualities*
    (gload "qualities;loader"))
  
  (gate-grammar *mid-level-ontology*
    (gload "mid-level;loader"))

  (gate-grammar *proper-names*
    (gload "names;loader")
    (setq *try-character-type-fsas* t))

  (gate-grammar *location* ;; for spatial prepositions in general-words
    (gload "places;loader"))

  (gate-grammar *standard-adjuncts*
    (gload "adjuncts;loader"))

  (gate-grammar *syntax*
    ;; be & have (etc) reference tree-families
    (gload "syntax;loader"))

  (gate-grammar *general-words*
    (gload "words;loader 2"))

  (gate-grammar *paired-punctuation*
    (gload "traversal;loader"))

;  (gate-grammar *location*
;    (gload "places;loader"))

  (gate-grammar *digits-fsa*
    (gload "numbers;fsa digits"))

  (gate-grammar *numbers*
    (gload "numbers;loader"))

  (gate-grammar *amounts*
    (gload "amounts;loader"))

  (gate-grammar *numbers*
    ;; this is just a definition for 'fractions' whick conflicts with the
    ;; current treatment of "first quarter"
    (gload "numbers;loader 2"))

  (gate-grammar *people*
    (gload "people;loader"))

  (gate-grammar *companies*
    (gload "companies;loader"))

  (gate-grammar *time*  ;; needs find/ordinal
    (gload "core;time;loader"))

  (gate-grammar *titles* ;; needs calculated-time
    (gload "titles;loader"))

  (gate-grammar *money*
    (gload "money;loader"))

  (gate-grammar *pronoun-objects*
    (gload "pronouns;loader"))


  (gate-grammar *paragraph-detection*
    ;; n.b. paragraphs;words requires spaces to be defined
    (gload "para;loader")
    (gload "newlines;loader"))


  (gate-grammar *reports*
    (gload "reports;loader"))

  (gate-grammar *pct*
    (gload "pct;loader"))

  (gate-grammar *whos-news*
    (gload "Who's News;loader"))

  (gate-grammar *ern*
    (gload "ern;loader"))
  (gate-grammar *finance*
    (gload "finance;loader"))


  (gate-grammar *ambush*
    (gload "ambush;loader"))

  (gate-grammar *checkpoint-ops*
    (gload "ckpt;loader"))

  (gate-grammar *generic-military*
    (gload "mil;loader"))

  (gate-grammar *disease*
    (gload "disease;loader"))

  (gate-grammar *hurricanes*
    (gload "hurricanes;loader"))

  (gate-grammar *middle-east*
    (gload "mideast;loader"))

  (gate-grammar *Banking*
    (gload "banking;loader"))

  (gate-grammar *ISR*
    (gload "isr;loader"))
  (gload "sit-rules;loader") ;; depends on ISR categories

  (gate-grammar *blocks-world*
    (gload "blocks;loader"))

  (gate-grammar *biocuration*
    (gload "biocuration;loader"))

  (gate-grammar *waypoints*
    (gload "waypoints;loader"))


#| irrelevant until GL comes back up
  (gate-grammar *load-Tipster-grammar-into-image*
    (gate-grammar *gl*
      (gload "gl form;loader"))
    (gload "model;sl;jv;loader")) |#

  (gate-grammar *ca*
    (gload "ca;loader"))

  (gate-grammar *ha*
    (gload "ha;loader"))

  (gate-grammar *da*
    (gload "da-rules;loader"))

  (gate-grammar *DM&P*
    (gload "DM&P;loader"))

  (gate-grammar *SDM&P*
    (gload "SDM&P;loader"))

  (gate-grammar *context-variables*
    (gload "context-rules;loader"))

  (gate-grammar *sgml*
    (gload "SGML;categories")
    (gload "SGML;loader"))

  #| [loader1] is 1991 hacks for avoiding wsj headers, [loader2]
      is empty from a never-completed revision
  (gate-grammar *recognize-sections-within-articles*
    (gload "sect-rules;loader"))  |#

  (gate-grammar *specific-sources*
    (gload "sources;loader"))


  ;;--------------------------------------------------------------
  ;; These have to go last because they will refer to categories
  ;; defined by the rest of the grammar -- they don't introduce
  ;; any new categories

  (when (find-package :mumble)
    (gate-grammar *tree-families*
       (gload "tree-families;correspondences")))

  (gate-grammar *proper-names*
    (gload "names;loader 2"))

  (gate-grammar *titles*
    (gate-grammar *pct*
      (titles-2d-stage-loader)))

  (gate-grammar *kinds*
    (gload "kinds;loader 2"))

  (gate-grammar *standard-adjuncts*
    (gload "adjuncts;rules"))

  (gload "cat-prefs;category preferences")

  (unless *nothing-Mac-specific*
    (gload "ad-tableau;autodef tableau"))

  (when *DM&P*
    (gload "DM&P;measure"))

  (gload "words;frequency")
  (gload "words;porter-stemmer")
  (gload "one-offs;loader")

  (gload "dossiers;loader")
  (gate-grammar *whos-news*
    (whos-news-post-dossiers-loader))

  (gate-grammar *time*
    (late-time-files)
    (when *clos*
      (make-temporal-sequences)))

  (when *incorporate-generic-lexicon*
    (prime-comlex))

  (gate-grammar *biology*
    (gload "bio;loader"))

  (gate-grammar *testing*
    (gate-grammar *miscellaneous*
      (gload "grammar;tests;loader"))
    (gate-grammar *citations*
      (gload "citations;loader")))

  (when *external-grammar-files*
    (load *external-grammar-files*))
  (when *external-grammar-dossier-files*
    (load *external-grammar-dossier-files*))

  ;; KRAQL might not need a gate-grammar invocation...
  ;;(gate-grammar *kraql*
  ;;  (gload "kraql;loader"))

  (postprocess-grammar-indexes))

