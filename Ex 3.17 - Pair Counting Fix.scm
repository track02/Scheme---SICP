#lang scheme
(require scheme/mpair)


;Exercise 3.17: Devise a correct version of the count-pairs
;procedure of Exercise 3.16 that returns the number of distinct
;pairs in any structure.

;(Hint: Traverse the structure, maintaining an auxiliary data structure that is used to keep
;track of which pairs have already been counted.)


(define (count-pairs x)
  (let ((seen '())) ;Build up a list of pairs we've seen already
    (define (check x)
      (if (or (not (pair? x)) (memq x seen)) 0 ;If current x value is not a pair or has already been seen, return 0 not unique
          (begin
            (set! seen (cons x seen)) ;Attaches current x value to the seen list
            (+ (check (car x)) ;Checks the car of x
               (check (cdr x)) ;Checks the cdr of x
               1)))) ;Adds a 1 for this unique pair
    (check x)))


;Note on memq
;
;(memq a b)
;if a is an element of b then memq will return a sublist of b beginning with a and ending with the final element of b
;otherwise it will return false
;can be used to determine whether an element in inside a list


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


(define LoopPairs (mlist 'a 'b 'c))
(set-mcdr! (mcdr (mcdr LoopPairs)) LoopPairs) ;Point the cdr to the start of the list

;                 a         b         c
; LoopPairs ---> [x][x]--->[x][x]--->[x][x]
;                 |                      |
;                 \----------------------/