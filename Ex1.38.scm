#lang scheme


;Ex 1.38 - write a program that uses cont-frac to approximate e
;Continuous Fraction for e-2
;Ni are all 1
;Di are successively 1,2,1,1,4,1,1,6 ...


(define (cont-frac n d k) 
  (define (divide i)
    (if (< i k)
        (/ (n i) (+ (d i) (divide (+ i 1))))
        (/ (n i) (d i))))
  (divide 1))
  

;Know procedure for N
;(lambda (i) 1.0)

;But need to devise a procedure to produce Di from a given i
; (i) 1,2,3,4,5,6,7,8,9
; (d) 1,2,1,1,4,1,1,6,1

; Starting from 2 every 3rd value for i results in d(i) = i - int(i/3)
; Check if i + 1 is a multiple of 3
; Yes -> i - (i / 3)
; No -> 1

;Check if number a multiple of b
(define (multiple? a b)
  (= (remainder a b) 0))

;Integer division, dividing a by b ignoring any remainder
(define (div a b)
  (define (int-div a b count)
    (if (> a b)
        (int-div (- a b) b (+ count 1))
        count))
  (int-div a b 0))
  
;D(i)
(define (d i)
  (if (multiple? (+ i 1) 3)
      (- i (div i 3))
      1))

;Calculate e
(define (calc-e)
  (+ (cont-frac (lambda (i) 1.0) d 10) 2)) ;remember to add 2

