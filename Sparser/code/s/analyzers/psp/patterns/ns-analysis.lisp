(in-package :sparser)

;;; --------------------------------------------------------
;;; Code to explore the results of the NS example collection
;;; --------------------------------------------------------

(defun ns-examples->file (&optional (filename "sparser:tools;ns-stuff;ns-examples.lisp"))
  "Save the collected ns examples to a file"
  (with-open-file (stream filename :direction :output :if-exists :supersede)
    (pprint *collect-ns-examples* stream))
  filename)

(defun clean-up-ns-collection ()
  "Just some clean up to group things by pattern and rule once we've
collected a set of ns-examples"
  ;; results are of the form:

  ;; (((ADJECTIVE IN-VITRO) :HYPHEN :LOWER)
  ;; ((DO-RELATION-BETWEEN-FIRST-AND-SECOND PHOSPHORYLATE VP+ED) \"in vitro–phosphorylated\")
  ;; ((DO-RELATION-BETWEEN-FIRST-AND-SECOND LABELE VP+ED) \"in vitro–labeled\")
  ;; ((DO-RELATION-BETWEEN-FIRST-AND-SECOND TRANSLATE VP+ED) \"in vitro–translated\"))

  ;; which is (pattern of words/edges) followed by sets of ((rule to
  ;; form edge and edge-form and edge-category) \"actual text
  ;; examples\") for each type of (rule edge set) that exists
  (loop for i in (group-by (remove nil *collect-ns-examples*) #'caar)
        when (equal "==>" (second (first (second i)))) 
        ;; cases with no rules get dropped at this point e.g., >20% -- will need to catch these later
        collect 
        (let ((grouped (group-by (second i) #'third #'cdar)))
          (cons (car i)
                (loop for g in grouped
                      collect 
                      (cons (car g)
                            (remove-duplicates (mapcar #'car  (second g)) :test #'equal)))))))

(defun ns-pattern-rules (cleaned-ns)
  "Given the output of clean-up-ns-collection, just pull out the patterns and unique rules"
  (loop for i in cleaned-ns
        collect (list (car i) 
                      (remove-duplicates (loop for j in (cdr i)
                            collect (caar j))))))

(defun ns-multiple-rule-patterns (rule-patterns)
  "Given the output of ns-pattern-rules, return those patterns that have multiple rules"
  (loop for rp in rule-patterns
        when (second (second rp)) ;; checking there is more than one rule
        collect rp
          #+ignore (let ((psr-rules 0))
                  (cons (car rp)
                         (loop for r in (second rp)
                              do (if (eq (symbol-package r) (find-package 'rule))
                                     (incf psr-rules)
                                     collect r))
                         (format t "psr rules: ~s" rules-psr)))
          ))

#+ignore
(length (setq *ns-multiple* (ns-multiple-rule-patterns (setq *rule-patterns* (ns-pattern-rules (setq *cleaned-ns* (clean-up-ns-collection)))))))

;;; ---------------------------------------------------------------
;;; Code to filter NS for words to identify by TRIPS or other means
;;; ---------------------------------------------------------------

(defparameter *ns-unknown-sublist* nil)
(defun ns-unknown-sublist (&optional (ns-examples *collect-ns-examples*))
  (length (setq *ns-unknown-sublist*
         (loop for n in ns-examples
                ; do (print (car (third n)))
                ; do (print (caar n))
               unless
               (or (not (stringp (second (car n))))
                   (and (consp (third n))
                        (or (memq (car (third n)) 
                                  (list
                                   'DO-RELATION-BETWEEN-FIRST-AND-SECOND
                                    'MAKE-PROTEIN-COLLECTION
                                    'MAKE-BIO-COMPLEX
                                    'MAKE-AMINO-COLLECTION
                                    'COMPOSE-SALIENT-HYPHENATED-LITERALS
                                    'RESOLVE-TRAILING-STRANDED-HYPHEN
                                    'RESOLVE-INITIAL-STRANDED-HYPHEN
                                    'MAKE-EDGE-OVER-MUTATED-PROTEIN
                                    'RESOLVE-PROTEIN-PREFIX
                                    :REIFY-RESIDUE
                                    :REIFY-POINT-MUTATION-AND-MAKE-EDGE
                                    'PACKAGE-APPROXIMATION-NUMBER
                                    'MAKE-NS-PAIR ;; these are mostly not of interest, but may have some false-negs
                                    :NUMBER-FSA
                                    ))
                            (when (symbol-package (car (third n)))
                              (equal "RULE" (package-name (symbol-package (car (third n))))))
                            ))
                   (member (caaar n) 
                           (list :ASTERISK :GREEK_LUNATE_EPSILON_SYMBOL :HYPHEN :TILDA :PLUS-SIGN :EQUAL-SIGN
                                 :GREATER-THAN_OR_SLANTED_EQUAL_TO :GREATER-THAN_OR_EQUAL_TO :GREATER-THAN 
                                 :LESS-THAN_OR_SLANTED_EQUAL_TO :LESS-THAN_OR_EQUAL_TO :LESS-THAN
                                 :SHARP-SIGN :DIGITS :NUMBER :VERTICAL-BAR :UNDER-BAR :AND-SIGN 
                                 :LEFT-POINTING-DOUBLE-ANGLE-QUOTATION_MARK
                                 '(COMMON-NOUN |HTTP://|))
                         :test #'equal) 
                   ;; removed :SINGLE-DIGIT because there are several things of interest starting with 5α
                   (and (eq (length (caar n)) 1)
                        (memq (caaar n) '(:LOWER :SINGLE-CAP :SINGLE-LOWER :LITTLE-P)))
                   (and (eq (length (caar n)) 2)
                        (or (and (memq (second (caar n)) '(:HYPHEN :COLON))
                                 (memq (first (caar n)) '(:LOWER :SINGLE-LOWER :SINGLE-CAP
                                                         :SINGLE-DIGIT :PROTEIN :FORWARD-SLASH :HYPHEN)))
                            (and (eq (first (caar n)) :DOUBLE-QUOTE)
                                 (memq (second (caar n)) '(:LOWER :SINGLE-DIGIT :PROTEIN :CELLULAR-PROCESS 
                                                          :ACTIVATION-LOOP :CAPITALIZED))))))
               collect (list (caar n) (second (car n)) (car (third n)))))))

(defun ns-unknown-sublist->file (&optional (filename 
                                            "sparser:tools;ns-stuff;ns-unknown-sublist.lisp"))
  "Save the collected ns examples to a file"
  (with-open-file (stream filename :direction :output :if-exists :supersede)
    (pprint *ns-unknown-sublist* stream))
  filename)

(defparameter *ns-unknown-items* nil)

;; Set to ignore because of not everyone has ppcre loaded, so need to remove the ignore to do this step
#+ignore(defun ns-unknown-items (&optional (ns-unknown-sublist *ns-unknown-sublist*))
          "Split items at slashes and colons"
  (length (setq *ns-unknown-items*
                (remove-duplicates
                 (loop for n in ns-unknown-sublist
                       append (ppcre:split "[/:]" (second n)))
                 :test #'equal))))

(defparameter *rd-ns* nil)

;; Set to ignore because of not everyone has ppcre loaded, so need to remove the ignore to do this step
#+ignore(defun ns-unknown-rd-items (&optional (ns-unknown-items *ns-unknown-items*))
          "Remove items that start with any of several characters or end with hyphen, or have an em dash since those are really sentence punctuation; also remove any items that are a single character"
  (length (setq *rd-ns*
                (sort
                 (remove-duplicates
                  (loop for x in ns-unknown-items
                         ; do (print (length x))
                          unless
                          (or (search " " x)
                              (ppcre:scan "^[-~+#0-9_&«*]-$" x)
                              (search "—" x) 
                              ;; we need to not make em dashes
                              ;; equivalent to hyphens before no-space
                              ;; but that hasn't been done yet
                              (> 2 (length x))) ;; apparently > is actually ≥
                          collect x)
                  :test #'equal) #'string<))))

(defun ns-unknown-rd-items->file (&optional (filename 
                                            "sparser:tools;ns-stuff;ns-unknown-rd-items.lisp"))
  "Save the collected ns examples to a file"
  (with-open-file (stream filename :direction :output :if-exists :supersede)
    (pprint *rd-ns* stream))
  filename)
          
(defparameter *undef-ns* nil)
(defun remove-predef-ns (&optional (rd-ns *rd-ns*))
  "Remove items that resolve and hence are already defined in Sparser"
  (length (setq *undef-ns*
                 (loop for x in rd-ns
                       unless (or (< (length x) 3)
                                  (eq 0 (search "-" x))
                                  (eq 0 (search "p-" x))
                                  (eq 0 (search "phospho-" x))
                                  (resolve x)
                                  (resolve (string-downcase x)))
                       collect x))))

(defun ns-undef-items->file (&optional (filename "sparser:tools;ns-stuff;ns-undef-items.lisp"))
  "Save the collected undefined items to a file"
  (with-open-file (stream filename :direction :output :if-exists :supersede)
    (pprint *undef-ns* stream))
  filename)


(defparameter *prefixes* nil)        
(defun ns-prefixes (&optional (rd-ns *rd-ns*))
  "Pull out the prefixes (i.e., things before a hyphen) that don't already have definitions"
  (length (setq *prefixes* 
                (remove-duplicates 
                 (loop for x in *rd-ns* 
                       when (and (search "-" x) 
                                 (not (resolve (subseq x 0 (search "-" x))))) 
                       collect (subseq x 0 (search "-" x)))
                 :test #'equal))))

; preliminary versions of the above

#+ignore
(lsetq *ns-list*                       
   append  (ppcre:split "[/:]" (second (car n))))
#+ignore
(lsetq *rd-ns*
     (sort
        (remove-duplicates
          (loop for x in *ns-list*
               unless
                  (or (search " " x)
                  (loop for c in '("-" "~" "+" "=" "≥" ">" "<" "≤" "#" "%" "*" "&" "°" "1" "2" "3" "4" "5" "6" "7" "8" "9" "0") thereis (eq 0 (search c x))))
               collect x)
            :test #'equal) #'string<))
#+ignore
(lsetq *prefixes* (remove-duplicates (loop for x in *rd-ns* when (and (search "-" x) (not (resolve (subseq x 0 (search "-" x))))) collect (subseq x 0 (search "-" x))) :test #'equal))
