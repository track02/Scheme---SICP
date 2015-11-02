#lang racket

(define (cube x)
  (* x x x))

;For approximating cube roots (x/y^2) + 2y / 3 calculates
;an improved approximation - where y = guess and x = value to find
;cube root
(define (improve y x)
  (/ (+ (/ x (* y y) ) (* 2 y)) 3))

(define (good-enough? guess x)
  (< (abs (- (cube guess) x)) 0.0001))

(define (cubert-iter guess x)
  (if (good-enough? guess x)
      guess
      (cubert-iter (improve guess x)
                 x)))

(cubert-iter 1 8)