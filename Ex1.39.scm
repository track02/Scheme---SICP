#lang scheme


;Ex 1.39 - write a program that uses cont-frac to approximate tan
;Continuous Fraction based on lambert's formula
;Ni are x,x^2,x^2,x^2 ....
;Di are 1,3,5,7,9 ...

;Define a procedure (tan-cf x k)
;Where x is in radians and k specifies the no. of terms to compute


;N can be defined as
; k = 1 -> x
; else -> x^2
; where x is the input value

;D can be defined as
; k = 1 - > 1
; else -> i + (i - 1)

(define (tan-cf x k)
  (define (N k)
    (if (= 1 k) x
        (- (* x x))))
  (define (D k)
    (if (= 1 k)
        1
        (+ k (- k 1))))
  (cont-frac N D k))
  

(define (cont-frac n d k) 
  (define (divide i)
    (if (< i k)
        (/ (n i) (+ (d i) (divide (+ i 1))))
        (/ (n i) (d i))))
  (divide 1))
  




