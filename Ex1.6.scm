#lang racket

;Define a new-if as a procedure
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))


(define (average x y)
  (/ (+ x y) 2))

(define (square x)
  (* x x))

(define (improve guess x)
  (average guess (/ x guess)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.0001))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))

;Using new-if will result in an infinite loop
;Because new-if is a procedure all of its arguments will
;be evaluated upon execution, unlike the special form if
;which evaluates only the predicate and then either
;the consequent or alternative

;So when new-if is called the argument (sqrt-iter-new (improve guess x)
;Will be evaluated causing new-if to be called again and so on
(define (sqrt-iter-new guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter-new (improve guess x)
                         x)))

;Output~3
(sqrt-iter 1 9)

;Error / Infinite Loop
(sqrt-iter-new 1 9)