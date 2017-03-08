#lang scheme

;Ex 1.43
;Write a procedure that takes as inputs a procedure
;that computes f and a positive integer n and returns the procedure
;that returns the procedure that computes the nth repeated application of f


(define (repeated f i)
  (if (= i 1) ;If 1 is one, return function
      f
      (compose f (repeated f (- i 1))))) ;Otherwise "add" another function call, reduce counter

(define (compose f g)
  (lambda (x)
    (f(g x))))

(define (square x)
  (* x x))

(define (inc x)
  (+ x 1))

;Testing
;> ((repeated square 2) 5)
;625

;> ((repeated square 3) 3)
;6561
