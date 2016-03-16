#lang scheme

;Ex 1.35
;Show the golden ratio is a fixed point of the transformation
;x -> 1 + 1/x
;A fixed point of a function f is x if f(x) = x

;Golden ratio = 1 + sqrt(5) / 2 = 1.6180339887 ...

;x -> 1 + 1/x 
;x = 1 + 1/x
;x^2 = x + 1
;x^2 - x - 1 = 0
;x = 1/2(1-sqrt(5)) [Quadratic equation]
;x = 1/2(1+sqrt(5)) [Quadratic equation]

;And calculate the golden ratio using the provided
;fixed-point procedure and transformation

(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

;Result:
;(fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0)
; -> 1.6180327868852458
