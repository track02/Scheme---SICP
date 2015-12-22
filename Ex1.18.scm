#lang racket

;Create an iterative multiplication procedure
;With a log(n) complexity, wrt input value b

;Similar to recursive b is halved and a is doubled when possible
;State is kept using a new parameter called C
;At each step B is either halved (and a double) or reduced by 1 depending on whether it is even or odd
;Each time B is reduced by 1 the value of C is increased by the current value of A
;When B reaches 0 the value held in C is returned giving the final value

(define (* a b)
  (iter-multiply a b 0))
  
(define (double i)
(+ i i))

(define (halve i)
(/ i 2))

(define (iter-multiply a b c)
  (cond ((= b 0) c)
        ((= (remainder b 2) 0) (iter-multiply (double a) (halve b) c))
        (else (iter-multiply a (- b 1) (+ c a)))))
  