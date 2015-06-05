;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER LISP) -*-
;;; copyright (c) 1992-1996,2013-2015  David D. McDonald  -- all rights reserved
;;;
;;;     File:  "alphabet"
;;;   Module:  "analyzers:tokenizer:"
;;;  Version:  0.3 May 2015

;; file created 9/15/92 v2.3, populated 9/21
;; 8/20/93 fixed mistake in entry for #127
;; 0.1 (5/31/96) Started adding cases above 128 for umlauted character and such
;;      using the encoding scheme on the Macintosh
;;     (5/23/13) Added Soft_Hyphen at 173 (Latin-1 char set)
;; 0.2 (9/23/13) Adding characters in the Latin-1 range of UTF-8.
;; 0.3 (2/3/14) Added entry-for-out-of-band-character and friends to
;;      accommodate characters above that.
;;     (2/27/14) Added lowercase greek up to lambda
;;     (6/12/14) added em-dash. Refined the error message.
;;     (4/15/15) added correct entry for a right arrow
;;     (6/5/15) Massive infusion of new characters



;; NOTE: the encodings of unicode characters are in HEX, so #\+2192 is 5894 decimal
;;  while the alist (*entries-for-out-of-band-characters*) for out-of-band characters
;;  uses decimal encoding, so in *entries-for-out-of-band-characters* we need
;;  (8594 ;; rightwards arrow
;;    (:punctuation . ,(punctuation-named #\U+2192)))


(in-package :sparser)

;;;----------------------
;;; populating the array
;;;----------------------

;;---------------- extended (Mac) char set ------------

(defun announce-out-of-range-character ()
  (let* ((character (elt *character-buffer-in-use* *index-of-next-character*))
         (code (char-code character)))
    (push-debug `(,character ,code))

    (break "~%The input stream contains the character \"~A\", whose character code~
            ~%is ~A.  That character is not part of the ascii character set~
            ~%(0 to 127), and has not yet been entered into either Sparser's ~
            ~%extended character array (128 to 255) or its table of 'out of bound'~
            ~%characters. Note that above ascii the character encoding is~
            ~%expected to be unicode, UTF-8.~

            ~%   If the character shouldn't have been in the stream, then you~
            ~%should just remove it and try again. If it does belong there, then ~
            ~%you can extend the character set. If you meta-. on this function~
            ~%that will take you to the file analyzers/tokenizer/alphabet.lisp~
            ~%where you can see examples to copy and read more details.~
            ~%"
           character code (length *character-dispatch-array*))))

#| When you get that error it's likely because the text you're running
has a UTF-8 character that we don't have an entry for yet. The error message
showed you what the character was visually, and identified the code point
that has to be added to the *entries-for-out-of-band-characters* alist at
the bottom of this file. Your job, is to figure out what "normal" character
that corresponds to (e.g. a unicode left-single-quotation-mark corresponds
to an ascii single quote), as least for the purpose of telling the token fsa
how to handle it -- the original character won't be replaced in the token.

This will usually entail a web search. There are lots of unicode web pages.
This is a reasonable choice http://www.fileformat.info/info/unicode/char/search.htm

|#


#+:apple ;; old character set, hopefully OBE
(setf (elt *character-dispatch-array* 138)  ;; #\212  "a" with an umlaut
      `(:alphabetical
        . (:lowercase . ,#\212 )))


#|
Entries are decoded by continue-token which uses the car to determine
the character type (for token boundaries), then the cdr is accumulated
and eventually passed to finish-token where the capitalization information
is noted by the capitalization-fsa and the character is entered into
the buffer that is fed to find-word and becomes part of the word's pname.

(:alphabetical . (:lowercase . ,#\212 ))

|#

;;---------------- standard ascii ----------------

(setf (elt *character-dispatch-array* 0)  ;; #\null
      '(:punctuation
        . :meaningless))

(setf (elt *character-dispatch-array* 1)  ;; #\^A
      '(:punctuation
        . :source-start))  ;; needed for the punctuation, but
                           ;; never appears in the input

(setf (elt *character-dispatch-array* 2)  ;; #\^B
      '(:punctuation
        . :end-of-source))

(setf (elt *character-dispatch-array* 3)  ;; #\Enter  ^C
      '(:punctuation
        . :meaningless))

(setf (elt *character-dispatch-array* 4)  ;; #\^D
      '(:punctuation
        . :end-of-buffer))

(setf (elt *character-dispatch-array* 5)  ;; #\^E
      '(:punctuation
        . :meaningless))

(setf (elt *character-dispatch-array* 6)  ;; #\^F
      '(:punctuation
        . :meaningless))

(setf (elt *character-dispatch-array* 7)  ;; #\Bell  ^G
      '(:punctuation
        . :meaningless))

(setf (elt *character-dispatch-array* 8)  ;; #\Backspace  ^H
      '(:punctuation
        . :meaningless))

(setf (elt *character-dispatch-array* 9)  ;; #\Tab  ^I
      `(:punctuation
        . ,(punctuation-named #\Tab )))

(setf (elt *character-dispatch-array* 10)  ;; #\Linefeed  ^J
      `(:punctuation
        . ,(punctuation-named #\Linefeed )))

(setf (elt *character-dispatch-array* 11)  ;; #\^K
      '(:punctuation
        . :meaningless))

(setf (elt *character-dispatch-array* 12)  ;; #\Page      ^L
      `(:punctuation
        . ,(punctuation-named #\Page )))

(setf (elt *character-dispatch-array* 13)  ;; #\Newline   ^M
      `(:punctuation
        . ,(punctuation-named #\Newline )))

(setf (elt *character-dispatch-array* 14)  ;; #\^N
      '(:punctuation
        . :meaningless))

(setf (elt *character-dispatch-array* 15)  ;; #\^O
      '(:punctuation
        . :meaningless))

(setf (elt *character-dispatch-array* 16)  ;; #\^P
      '(:punctuation
        . :meaningless))

(setf (elt *character-dispatch-array* 17)  ;; #\CommandMark  ^Q
      '(:punctuation
        . :meaningless))

(setf (elt *character-dispatch-array* 18)  ;; #\CheckMark    ^R
      '(:punctuation
        . :meaningless))

(setf (elt *character-dispatch-array* 19)  ;; #\DiamondMark  ^S
      '(:punctuation
        . :meaningless))

(setf (elt *character-dispatch-array* 20)  ;; #\AppleMark    ~T
      '(:punctuation
        . :meaningless))

(setf (elt *character-dispatch-array* 21)  ;; #\^U
      '(:punctuation
        . :meaningless))

(setf (elt *character-dispatch-array* 22)  ;; #\^V
      '(:punctuation
        . :meaningless))

(setf (elt *character-dispatch-array* 23)  ;; #\^W
      '(:punctuation
        . :meaningless))

(setf (elt *character-dispatch-array* 24)  ;; #\^X
      '(:punctuation
        . :meaningless))

(setf (elt *character-dispatch-array* 25)  ;; #\^Y
      '(:punctuation
        . :meaningless))

(setf (elt *character-dispatch-array* 26)  ;; #\^Z
      '(:punctuation
        . :meaningless))

(setf (elt *character-dispatch-array* 27)  ;; #\Clear
      '(:punctuation
        . :meaningless))

(setf (elt *character-dispatch-array* 28)  ;; #\BackArrow
      '(:punctuation
        . :meaningless))

(setf (elt *character-dispatch-array* 29)  ;; #\ForwardArrow
      '(:punctuation
        . :meaningless))

(setf (elt *character-dispatch-array* 30)  ;; #\UpArrow
      '(:punctuation
        . :meaningless))

(setf (elt *character-dispatch-array* 31)  ;; #\DownArrow
      '(:punctuation
        . :meaningless))

(setf (elt *character-dispatch-array* 32)  ;; #\Space
      '(:punctuation
        . :space))

(setf (elt *character-dispatch-array* 33)  ;; #\!
      `(:punctuation
        . ,(punctuation-named #\! )))

(setf (elt *character-dispatch-array* 34)  ;; #\"
      `(:punctuation
        . ,(punctuation-named #\" )))

(setf (elt *character-dispatch-array* 35)  ;; #\#
      `(:punctuation
        . ,(punctuation-named #\# )))

(setf (elt *character-dispatch-array* 36)  ;; #\$
      `(:punctuation
        . ,(punctuation-named #\$ )))

(setf (elt *character-dispatch-array* 37)  ;; #\%
      `(:punctuation
        . ,(punctuation-named #\% )))

(setf (elt *character-dispatch-array* 38)  ;; #\&
      `(:punctuation
        . ,(punctuation-named #\& )))

(setf (elt *character-dispatch-array* 39)  ;; #\'
      `(:punctuation
        . ,(punctuation-named #\' )))

(setf (elt *character-dispatch-array* 40)  ;; #\(
      `(:punctuation
        . ,(punctuation-named #\( )))

(setf (elt *character-dispatch-array* 41)  ;; #\)
      `(:punctuation
        . ,(punctuation-named #\) )))

(setf (elt *character-dispatch-array* 42)  ;; #\*
      `(:punctuation
        . ,(punctuation-named #\* )))

(setf (elt *character-dispatch-array* 43)  ;; #\+
      `(:punctuation
        . ,(punctuation-named #\+ )))

(setf (elt *character-dispatch-array* 44)  ;; #\,
      `(:punctuation
        . ,(punctuation-named #\, )))

(setf (elt *character-dispatch-array* 45)  ;; #\-
      `(:punctuation
        . ,(punctuation-named #\- )))

(setf (elt *character-dispatch-array* 46)  ;; #\.
      `(:punctuation
        . ,(punctuation-named #\. )))

(setf (elt *character-dispatch-array* 47)  ;; #\/
      `(:punctuation
        . ,(punctuation-named #\/ )))

(setf (elt *character-dispatch-array* 48)  ;; #\0
      `(:number
        . (:digit . ,#\0)))

(setf (elt *character-dispatch-array* 49)  ;; #\1
      `(:number
        . (:digit . ,#\1 )))

(setf (elt *character-dispatch-array* 50)  ;; #\2
      `(:number
        . (:digit . ,#\2 )))

(setf (elt *character-dispatch-array* 51)  ;; #\3
      `(:number
        . (:digit . ,#\3 )))

(setf (elt *character-dispatch-array* 52)  ;; #\4
      `(:number
        . (:digit . ,#\4 )))

(setf (elt *character-dispatch-array* 53)  ;; #\5
      `(:number
        . (:digit . ,#\5 )))

(setf (elt *character-dispatch-array* 54)  ;; #\6
      `(:number
        . (:digit . ,#\6 )))

(setf (elt *character-dispatch-array* 55)  ;; #\7
      `(:number
        . (:digit . ,#\7 )))

(setf (elt *character-dispatch-array* 56)  ;; #\8
      `(:number
        . (:digit . ,#\8 )))

(setf (elt *character-dispatch-array* 57)  ;; #\9
      `(:number
        . (:digit . ,#\9 )))

(setf (elt *character-dispatch-array* 58)  ;; #\:
      `(:punctuation
        . ,(punctuation-named #\: )))

(setf (elt *character-dispatch-array* 59)  ;; #\;
      `(:punctuation
        . ,(punctuation-named #\; )))

(setf (elt *character-dispatch-array* 60)  ;; #\<
      `(:punctuation
        . ,(punctuation-named #\< )))

(setf (elt *character-dispatch-array* 61)  ;; #\=
      `(:punctuation
        . ,(punctuation-named #\= )))

(setf (elt *character-dispatch-array* 62)  ;; #\>
      `(:punctuation
        . ,(punctuation-named #\> )))

(setf (elt *character-dispatch-array* 63)  ;; #\?
      `(:punctuation
        . ,(punctuation-named #\? )))

(setf (elt *character-dispatch-array* 64)  ;; #\@
      `(:punctuation
        . ,(punctuation-named #\@ )))

(setf (elt *character-dispatch-array* 65)  ;; #\A
      `(:alphabetical
        . (:uppercase . ,#\a )))

(setf (elt *character-dispatch-array* 66)  ;; #\B
      `(:alphabetical
        . (:uppercase . ,#\b )))

(setf (elt *character-dispatch-array* 67)  ;; #\C
      `(:alphabetical
        . (:uppercase . ,#\c )))

(setf (elt *character-dispatch-array* 68)  ;; #\D
      `(:alphabetical
        . (:uppercase . ,#\d )))

(setf (elt *character-dispatch-array* 69)  ;; #\E
      `(:alphabetical
        . (:uppercase . ,#\e )))

(setf (elt *character-dispatch-array* 70)  ;; #\F
      `(:alphabetical
        . (:uppercase . ,#\f )))

(setf (elt *character-dispatch-array* 71)  ;; #\G
      `(:alphabetical
        . (:uppercase . ,#\g )))

(setf (elt *character-dispatch-array* 72)  ;; #\H
      `(:alphabetical
        . (:uppercase . ,#\h )))

(setf (elt *character-dispatch-array* 73)  ;; #\I
      `(:alphabetical
        . (:uppercase . ,#\i )))

(setf (elt *character-dispatch-array* 74)  ;; #\J
      `(:alphabetical
        . (:uppercase . ,#\j )))

(setf (elt *character-dispatch-array* 75)  ;; #\K
      `(:alphabetical
        . (:uppercase . ,#\k )))

(setf (elt *character-dispatch-array* 76)  ;; #\L
      `(:alphabetical
        . (:uppercase . ,#\l )))

(setf (elt *character-dispatch-array* 77)  ;; #\M
      `(:alphabetical
        . (:uppercase . ,#\m )))

(setf (elt *character-dispatch-array* 78)  ;; #\N
      `(:alphabetical
        . (:uppercase . ,#\n )))

(setf (elt *character-dispatch-array* 79)  ;; #\O
      `(:alphabetical
        . (:uppercase . ,#\o )))

(setf (elt *character-dispatch-array* 80)  ;; #\P
      `(:alphabetical
        . (:uppercase . ,#\p )))

(setf (elt *character-dispatch-array* 81)  ;; #\Q
      `(:alphabetical
        . (:uppercase . ,#\q )))

(setf (elt *character-dispatch-array* 82)  ;; #\R
      `(:alphabetical
        . (:uppercase . ,#\r )))

(setf (elt *character-dispatch-array* 83)  ;; #\S
      `(:alphabetical
        . (:uppercase . ,#\s )))

(setf (elt *character-dispatch-array* 84)  ;; #\T
      `(:alphabetical
        . (:uppercase . ,#\t )))

(setf (elt *character-dispatch-array* 85)  ;; #\U
      `(:alphabetical
        . (:uppercase . ,#\u )))

(setf (elt *character-dispatch-array* 86)  ;; #\V
      `(:alphabetical
        . (:uppercase . ,#\v )))

(setf (elt *character-dispatch-array* 87)  ;; #\W
      `(:alphabetical
        . (:uppercase . ,#\w )))

(setf (elt *character-dispatch-array* 88)  ;; #\X
      `(:alphabetical
        . (:uppercase . ,#\x )))

(setf (elt *character-dispatch-array* 89)  ;; #\Y
      `(:alphabetical
        . (:uppercase . ,#\y )))

(setf (elt *character-dispatch-array* 90)  ;; #\Z
      `(:alphabetical
        . (:uppercase . ,#\z )))

(setf (elt *character-dispatch-array* 91)  ;; #\[
      `(:punctuation
        . ,(punctuation-named #\[ )))

(setf (elt *character-dispatch-array* 92)  ;; #\\
      `(:punctuation
        . ,(punctuation-named #\\ )))

(setf (elt *character-dispatch-array* 93)  ;; #\]
      `(:punctuation
        . ,(punctuation-named #\] )))

(setf (elt *character-dispatch-array* 94)  ;; #\^
      `(:punctuation
        . ,(punctuation-named #\^ )))

(setf (elt *character-dispatch-array* 95)  ;; #\_
      `(:punctuation
        . ,(punctuation-named #\_ )))

(setf (elt *character-dispatch-array* 96)  ;; #\`
      `(:punctuation
        . ,(punctuation-named #\` )))

(setf (elt *character-dispatch-array* 97)  ;; #\a
      `(:alphabetical
        . (:lowercase . ,#\a )))

(setf (elt *character-dispatch-array* 98)  ;; #\b
      `(:alphabetical
        . (:lowercase . ,#\b )))

(setf (elt *character-dispatch-array* 99)  ;; #\c
      `(:alphabetical
        . (:lowercase . ,#\c )))

(setf (elt *character-dispatch-array* 100) ;; #\d
      `(:alphabetical
        . (:lowercase . ,#\d )))

(setf (elt *character-dispatch-array* 101) ;; #\e
      `(:alphabetical
        . (:lowercase . ,#\e )))

(setf (elt *character-dispatch-array* 102) ;; #\f
      `(:alphabetical
        . (:lowercase . ,#\f )))

(setf (elt *character-dispatch-array* 103) ;; #\g
      `(:alphabetical
        . (:lowercase . ,#\g )))

(setf (elt *character-dispatch-array* 104) ;; #\h
      `(:alphabetical
        . (:lowercase . ,#\h )))

(setf (elt *character-dispatch-array* 105) ;; #\i
      `(:alphabetical
        . (:lowercase . ,#\i )))

(setf (elt *character-dispatch-array* 106) ;; #\j
      `(:alphabetical
        . (:lowercase . ,#\j )))

(setf (elt *character-dispatch-array* 107) ;; #\k
      `(:alphabetical
        . (:lowercase . ,#\k )))

(setf (elt *character-dispatch-array* 108) ;; #\l
      `(:alphabetical
        . (:lowercase . ,#\l )))

(setf (elt *character-dispatch-array* 109) ;; #\m
      `(:alphabetical
        . (:lowercase . ,#\m )))

(setf (elt *character-dispatch-array* 110) ;; #\n
      `(:alphabetical
        . (:lowercase . ,#\n )))

(setf (elt *character-dispatch-array* 111) ;; #\o
      `(:alphabetical
        . (:lowercase . ,#\o )))

(setf (elt *character-dispatch-array* 112) ;; #\p
      `(:alphabetical
        . (:lowercase . ,#\p )))

(setf (elt *character-dispatch-array* 113) ;; #\q
      `(:alphabetical
        . (:lowercase . ,#\q )))

(setf (elt *character-dispatch-array* 114) ;; #\r
      `(:alphabetical
        . (:lowercase . ,#\r )))

(setf (elt *character-dispatch-array* 115) ;; #\s
      `(:alphabetical
        . (:lowercase . ,#\s )))

(setf (elt *character-dispatch-array* 116) ;; #\t
      `(:alphabetical
        . (:lowercase . ,#\t )))

(setf (elt *character-dispatch-array* 117) ;; #\u
      `(:alphabetical
        . (:lowercase . ,#\u )))

(setf (elt *character-dispatch-array* 118) ;; #\v
      `(:alphabetical
        . (:lowercase . ,#\v )))

(setf (elt *character-dispatch-array* 119) ;; #\w
      `(:alphabetical
        . (:lowercase . ,#\w )))

(setf (elt *character-dispatch-array* 120) ;; #\x
      `(:alphabetical
        . (:lowercase . ,#\x )))

(setf (elt *character-dispatch-array* 121) ;; #\y
      `(:alphabetical
        . (:lowercase . ,#\y )))

(setf (elt *character-dispatch-array* 122) ;; #\z
      `(:alphabetical
        . (:lowercase . ,#\z )))

(setf (elt *character-dispatch-array* 123) ;; #\{
      `(:punctuation
        . ,(punctuation-named #\{ )))

(setf (elt *character-dispatch-array* 124) ;; #\|
      `(:punctuation
        . ,(punctuation-named #\| )))

(setf (elt *character-dispatch-array* 125) ;; #\}
      `(:punctuation
        . ,(punctuation-named #\} )))

(setf (elt *character-dispatch-array* 126) ;; #\~
      `(:punctuation
        . ,(punctuation-named #\~ )))

(setf (elt *character-dispatch-array* 127) ;; #\Rubout
      `(:punctuation
        . :meaningless))


;;---- selected characters above 127 and below 256

(setf (elt *character-dispatch-array* 160) ;; #\No-break_Space
      '(:punctuation
        . :space))

(setf (elt *character-dispatch-array* 173) ;; #\Soft_Hyphen
      `(:punctuation
        . ,(punctuation-named #\- )))

(setf (elt *character-dispatch-array* 176) ;; #\Degree_Sign
      `(:punctuation
        . ,(punctuation-named #\* )))

(setf (elt *character-dispatch-array* 177) ;; #\Plus-Minus_Sign
      '(:punctuation
        . :space)) ;;////////////////////////////////////////

(setf (elt *character-dispatch-array* 181) ;; #\Micro_Sign
      '(:punctuation
        . :space)) ;;////////////////////////////////////////

(setf (elt *character-dispatch-array* 194) ;; #\Latin_Capital_Letter_A_With_Circumflex
      `(:punctuation
        . :space))

(setf (elt *character-dispatch-array* 215) ;; #\Multiplication_Sign
      `(:punctuation
        . ,(punctuation-named #\* )))

(setf (elt *character-dispatch-array* 239) ;; #\Latin_Small_Letter_I_With_Diaeresis
      `(:alphabetical . (:lowercase . #\l)))

(setf (elt *character-dispatch-array* 247) ;; division sign
      ``(:punctuation
        . ,(punctuation-named #\÷)))


;; Loading the utf-8 file into Hemlock it appears as a space,
;; in Emacs (in whatever it's default is -- Hemloc says its utf-8)
;; is appears as \302\240, and ACL just rolls over it.)
;; in the character buffer itself is appears like it says: as an
;; a with a circumflex over it.
;      `(:alphabetical
;        . (:uppercase . ,#\a )))

;;;-------------------------------------------
;;; Machinery for characters higher than that
;;;-------------------------------------------

;; (code-char 954) => #\Greek_Small_Letter_Kappa
;; (format nil "~x" 954) => 3BA

(defparameter *entries-for-out-of-band-characters*
  `(

    (263 ;; #\Latin_Small_Letter_C_With_Acute
     (:alphabetical . (:lowercase . #\c))) ;;"ć", (code = 263)
    (353  ;; #\Latin_Small_Letter_S_With_Caron
     (:alphabetical . (:lowercase . #\s)))

    (603 ;; #\Latin_Small_Letter_Open_E
     (:alphabetical . (:lowercase . #\e))) ;;"ɛ", (code = 603)

    (729 ;; #\Dot_Above
     (:punctuation . #\*)) ;;"˙", (code = 729)
    (730 ;; #\Ring_Above
     (:punctuation . (:lowercase . #\e))) ;;"˚", (code = 730)
    (732 ;; #\Small_Tilde
     (:punctuation . (:lowercase . #\~))) ;;"˜", (code = 732)

    (769  ;; #\Combining_Acute_Accent
     (:punctuation . ,(punctuation-named #\')))

    (772 ;; #\Combining_Macron
     (:punctuation . ,(punctuation-named  (code-char 772)))) ;;"̄", (code = 772)

    (776  ;; #\Combining_Diaeresis
     (:punctuation . ,(punctuation-named #\' )))

    (894 (:punctuation . ,(punctuation-named  (code-char 894)))) ;;";", (code = 894)

    (916 ;; #\Greek_Capital_Letter_Delta
     (:alphabetical . (:lowercase . ,(code-char 916))))



(924 (:alphabetical . (:lowercase . , (code-char 924)))) ;;"Μ", (code = 924)
(925 (:alphabetical . (:lowercase . , (code-char 925)))) ;;"Ν", (code = 925)
(932 (:alphabetical . (:lowercase . , (code-char 932)))) ;;"Τ", (code = 932)
(934 (:alphabetical . (:lowercase . , (code-char 934)))) ;;"Φ", (code = 934)
(935 (:alphabetical . (:lowercase . , (code-char 935)))) ;;"Χ", (code = 935)
(936 (:alphabetical . (:lowercase . , (code-char 936)))) ;;"Ψ", (code = 936)
(937 (:alphabetical . (:lowercase . , (code-char 937)))) ;;"Ω", (code = 937)
(940 (:alphabetical . (:lowercase . , (code-char 940)))) ;;"ά", (code = 940)

    ;; 03B1
    (945 ;; #\Greek_Small_Letter_Alpha
     (:alphabetical . (:lowercase . ,(code-char 945))))
    (946 ;; #\Greek_Small_Letter_Beta
     (:alphabetical . (:lowercase . ,(code-char 946))))
    (947 ;; #\Greek_Small_Letter_Gamma
     (:alphabetical . (:lowercase . ,(code-char 947))))
    (948 ;; #\Greek_Small_Letter_Delta
     (:alphabetical . (:lowercase . ,(code-char 948))))
    (949 ;; #\Greek_Small_Letter_Epsilon
     (:alphabetical . (:lowercase . ,(code-char 949))))
    (950 ;; #\Greek_Small_Letter_Ze49
     (:alphabetical . (:lowercase . ,(code-char 950))))
    (951 ;; #\Greek_Small_Letter_Eta
     (:alphabetical . (:lowercase . ,(code-char 951))))
    (952 ;; #\Greek_Small_Letter_Theta
     (:alphabetical . (:lowercase . ,(code-char 952))))
    (953 ;; #\Greek_Small_Letter_Iota
     (:alphabetical . (:lowercase . ,(code-char 953))))
    (954 ;; #\Greek_Small_Letter_Kappa  U#03BA
     (:alphabetical . (:lowercase . ,(code-char 954))))
    (955 ;; #\Greek_Small_Letter_Lambda
     (:alphabetical . (:lowercase . ,(code-char 955))))
    (956 ;; #\Greek_Small_Letter_Mu
     (:alphabetical . (:lowercase . ,(code-char 956))))
(959 (:alphabetical . (:lowercase . , (code-char 959)))) ;;"ο", (code = 959)
(960 (:alphabetical . (:lowercase . , (code-char 960)))) ;;"π", (code = 960)
(961 (:alphabetical . (:lowercase . , (code-char 961)))) ;;"ρ", (code = 961)
    (963;; #\Greek_Small_Letter_Sigma
     (:alphabetical . (:lowercase . ,(code-char 963))))
(964 (:alphabetical . (:lowercase . , (code-char 964)))) ;;"τ", (code = 964)
(967 (:alphabetical . (:lowercase . , (code-char 967)))) ;;"χ", (code = 967)
(968 (:alphabetical . (:lowercase . , (code-char 968)))) ;;"ψ", (code = 968)
(969 (:alphabetical . (:lowercase . , (code-char 969)))) ;;"ω", (code = 969)
(981 (:alphabetical . (:lowercase . , (code-char 981)))) ;;"ϕ", (code = 981)
(1082 (:alphabetical . (:lowercase . , (code-char 1082)))) ;;"к", (code = 1082)
(8197 (:punctuation . ,(punctuation-named  (code-char 8197)))) ;;" ", (code = 8197)
(8201 (:punctuation . ,(punctuation-named  (code-char 8201)))) ;;" ", (code = 8201)
(8202 (:punctuation . ,(punctuation-named  (code-char 8202)))) ;;" ", (code = 8202)
(8208 (:punctuation . ,(punctuation-named  (code-char 8208)))) ;;"‐", (code = 8208)

    (8211  ;; en dash
     (:punctuation . ,(punctuation-named #\- )))
    (8212  ;; em dash, html: &mdash;
     ;; Doesn't appear to have a symbolic form in ccl
     (:punctuation . ,(punctuation-named #\- )))
(8213 (:punctuation . ,(punctuation-named  (code-char 8213)))) ;;"―", (code = 8213)

    (8216 ;; left single quote
     (:punctuation . ,(punctuation-named #\' )))
    (8217 ;; right single quote
     (:punctuation . ,(punctuation-named #\' )))
(8218 (:punctuation . ,(punctuation-named  (code-char 8218)))) ;;"‚", (code = 8218)

    (8220 ;; left double quote
     (:punctuation . ,(punctuation-named #\" )))
    (8221 ;; right double quote
     (:punctuation . ,(punctuation-named #\" )))
(8226 (:punctuation . ,(punctuation-named  (code-char 8226)))) ;;"•", (code = 8226)
(8230 (:punctuation . ,(punctuation-named  (code-char 8230)))) ;;"…", (code = 8230)
(8232 (:punctuation . ,(punctuation-named  (code-char 8232)))) ;;"", (code = 8232)
(8240 (:punctuation . ,(punctuation-named  (code-char 8240)))) ;;"‰", (code = 8240)

    (8242 ;; "prime"
     (:punctuation . ,(or
                       #-allegro
                       (punctuation-named #\U+2032 )
                       #+allegro
                       (punctuation-named (code-char #x2032))
                       (punctuation-named #\'))))


(8243 (:punctuation . ,(punctuation-named  (code-char 8243)))) ;;"″", (code = 8243)

(8451 (:punctuation . ,(punctuation-named  (code-char 8451)))) ;;"℃", (code = 8451)
(8482 (:punctuation . ,(punctuation-named  (code-char 8482)))) ;;"™", (code = 8482)
(8488 
     (:alphabetical . (:uppercase . , #\ℨ)))
    (8491 ;; "Å"
     (:punctuation . ,(punctuation-named (code-char 8491))))
(8545 (:punctuation . ,(punctuation-named  (code-char 8545)))) ;;"Ⅱ", (code = 8545)
(8593 (:punctuation . ,(punctuation-named  (code-char 8593)))) ;;"↑", (code = 8593)
    (8594 ;; rightwards arrow
     #-allegro
     (:punctuation . ,(punctuation-named #\U+2192))
     #+allegro
     (:punctuation . ,(punctuation-named (code-char #x2192)))
     )
(8595 (:punctuation . ,(punctuation-named  (code-char 8595)))) ;;"↓", (code = 8595)
(8596 (:punctuation . ,(punctuation-named  (code-char 8596)))) ;;"↔", (code = 8596)
(8706 (:punctuation . ,(punctuation-named  (code-char 8706)))) ;;"∂", (code = 8706)
    (8722
     (:punctuation . ,(or
                       #-allegro
                       (punctuation-named #\U+2212)
                       #+allegro
                       (punctuation-named (code-char #x2212))
                       (punctuation-named #\-))))
    (8734 (:punctuation . ,(punctuation-named  (code-char 8734)))) ;;"∞", (code = 8734)
    (8758 ;; ratio  #\U+2236
     (:punctuation . ,(punctuation-named #\:)))
    (8764
     (:punctuation . ,(or
                        #-allegro
                        (punctuation-named #\U+223C)
                        #+allegro
                        (punctuation-named (code-char #x223C))
                        (punctuation-named #\~))))
(8776 (:punctuation . ,(punctuation-named  (code-char 8776)))) ;;"≈", (code = 8776)
(8781 (:punctuation . ,(punctuation-named  (code-char 8781)))) ;;"≍", (code = 8781)


    (8804 ;;  "≤"
     (:punctuation . ,(punctuation-named (code-char 8804))))


(8805 (:punctuation . ,(punctuation-named  (code-char 8805)))) ;;"≥", (code = 8805)
(8806 (:punctuation . ,(punctuation-named  (code-char 8806)))) ;;"≦", (code = 8806)
(8901 (:punctuation . ,(punctuation-named  (code-char 8901)))) ;;"⋅", (code = 8901)
(10878 (:punctuation . ,(punctuation-named  (code-char 10878)))) ;;"⩾", (code = 10878)
(64257 (:alphabetical . (:lowercase . , (code-char 64257)))) ;;"ﬁ", (code = 64257)
(64258 (:alphabetical . (:lowercase . ,  (code-char 64258)))) ;;"ﬂ", (code = 64258)
(65288 (:punctuation . ,(punctuation-named  (code-char 65288)))) ;;"（", (code = 65288)
(65293 (:punctuation . ,(punctuation-named  (code-char 65293)))) ;;"－", (code = 65293)


    )
  "If it's not a defparameter, CCL won't let us extend it
   in a running lisp.")


(defparameter *cache-out-of-band-characters* t)

(defun entry-for-out-of-band-character (char-code)
  (let ((entry
         (cadr (assoc char-code *entries-for-out-of-band-characters*))))
    (or entry
        (when *cache-out-of-band-characters*
          (cache-out-of-band-character char-code))
        (announce-out-of-range-character))))

(defvar *new-characters-to-define* nil
  "Holds a list of character points that require definition.
   Needs to be emptied by hand. No provision as yet for storing
   across runs if you don't actually make the definitions.")

(defun cache-out-of-band-character (char-code)
  ;; Called from character-entry when zero is returned or from
  ;; entry-given-char-code for the characters above 256.
  ;; Announce what's happening. Store the character code.
  ;; Return an inoccuous character is its place.
  (let ((character (elt *character-buffer-in-use* *index-of-next-character*)))
    (format t "~&~%The character \"~a\", (code = ~a) is not in the alphabet yet.~
                 ~%Using a space in its place.~%~%"
            character char-code)
    (push (cons character char-code)
          *new-characters-to-define*)
    '(:punctuation
        . :space)))

  

