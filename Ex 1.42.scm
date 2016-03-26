#lang scheme

;Ex 1.42
;If f and g are both one argument functions the composition of f after g
;is defined as x -> f(g(x))
;Define a procedure compose that implements composition

(define (compose f g)
  (lambda (x)
    (f(g x))))

;Test compose by calling the following 
;((compose square inc) 6)


(define (square x)
  (* x x))

(define (inc x)
  (+ x 1))

;> ((compose square inc) 6)
;49