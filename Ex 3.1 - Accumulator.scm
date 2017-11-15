#lang scheme

;An accumulator is a procedure that is called repeatedly with a single numeric argument
;and accumulates its arguments into a sum

;Ex 3.1 - Write a procedure make-accumulator which generates accumulators
;The input to make-accumulator should specifiy the specify the intial  value of the sum

(define (make-accumulator sum)
  (lambda (amount)
    (set! sum (+ sum amount))
    sum))
