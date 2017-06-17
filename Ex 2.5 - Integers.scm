#lang scheme

;Ex 2.5 Represent a pair of integers a,b as the product
;of 2^a * 3^b
;Write cons,car,cdr procedures to store a pair and
;extract a and b

;(a,b) -> 2^a * 3^b
;(1,1) = 6
;(1,2) = 18
;(2,1) = 12
;(2,2) = 36

;Cons Procedure
;Given two numbers a,b produce a
;pair representation in the form 2^a * 3^b
(define (cons a b)
  (* (expt 2 a) ;expt -> 2^a
     (expt 3 b)))

;Car Procedure
;Divide by two until no longer possible
;Keeping count of each division
;Essentially left with 1*3^b and some count n, where n = a
(define (car x)
  (define (div-2 x c)
    (if (factor x 2)
        (div-2 (/ x 2) (+ c 1))
        c))
  (div-2 x 0))

;Cdr Procedure
;Divide by three until no longer possible
;Keeping count of each division
;Essentially left with 2^a*1 and some count n, where n = b
(define (cdr x)
  (define (div-3 x c)
    (if (factor x 3)
        (div-3 (/ x 3) (+ c 1))
        c))
  (div-3 x 0))

;Remainder check
(define (factor a b)
  (= (remainder a b) 0))
    