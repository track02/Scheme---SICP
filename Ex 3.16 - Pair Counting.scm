#lang scheme
(require scheme/mpair)

;Exercise 3.16: Ben Bitdiddle decides to write a procedure
;to count the number of pairs in any list structure. “It’s easy,”
;he reasons. “e number of pairs in any structure is the
;number in the car plus the number in the cdr plus one
;more to count the current pair.” So Ben writes the following
;procedure:

(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))

;Show that this procedure is not correct.
;In particular, draw box-and-pointer diagrams representing list structures made
;up of exactly three pairs for which Ben’s procedure would
;return 3; return 4; return 7; never return at all.

;count-pairs works by summing up each pair in the car/cdr of the given list


(define 3Pairs (list 'a 'b 'c))

;              a (1)     b (2)     c (3)
; 3Pairs ---> [x][x]--->[x][x]--->[x][o]
;

(define 4Pairs (list 'a 'b '(c)))

;              a (1)     b (2)      (3)  
; 4Pairs ---> [x][x]--->[x][x]--->[x][o]
;                                  |
;                                  |
;                                 [x][o]
;                                  c (4)


(define 7Pairs (list '(a) '(b) '(c d)))

;                (1)       (3)       (5)  
; 7Pairs ---> [x][x]--->[x][x]--->[x][o]
;              |         |         |
;              |         |         |
;             [x][o]    [x][o]    [x][x]---->[x][o]
;              a (2)     b (4)     c (6)      d (7)


(define LoopPairs (list 'a 'b 'c))
(set-cdr! (cdr (cdr LoopPairs)) LoopPairs) ;Point the cdr to the start of the list

;                 a         b         c
; LoopPairs ---> [x][x]--->[x][x]--->[x][x]
;                 |                      |
;                 \----------------------/