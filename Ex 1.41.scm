#lang scheme

;Ex 1.41 - Define a procedure double that takes a procedure as an argument
;double returns a procedure that applies the original procedure twice

(define (double f)
  (lambda (x)
    (f (f x))))

;Test double using a procedure inc which adds 1 to its argument
(define (inc x)
  (+ 1 x))

;What would happen if the following procedure were called
;(((double (double double)) inc) 5)
;Returns 21 -> 5 + 16


;(double double) would return a procedure that applies double twice (4)
;name this function 2_double
;(double 2_double) would return a procedure that applies 2_double twice (4)
; -> 16