#lang scheme

;Complete Number-Polynomial Package used to test this exercise - (see https://wizardbook.wordpress.com) - Note: Implements put/get table from Chapter 3
(require "Number-Packages.scm")
(require sicp)
(require racket/trace)


;Ex 2.97 - Write a procedure reduce-terms which implements the following algorithm:
;
; - Compute the gcd of the numerator and denominator using gcd-terms
; - Multiply both numerator and denominator by the same integerizing factor to prevent introduction of non-int coeffs
;     - For the factor, use the leading coefficient of the gcd raised to the power 1 + o1 - o2
;     - Where O2 is the gcd order and O1 is the maximum of the orders of the n and d
;     - This will result in a numerator and denominator with integer coefficients
; - Remove the redundant factors by computing the gcd of coefficients of the integer numerator and divide through
;
;Bundle this procedure into reduce-poly so that it can be applied to polynomials

;(define (reduce-terms n d)  
  (let*
      ;;Find gcd of num / denom
      ((term-gcd (gcd-terms n d))
       ;Determine factor
       (o1 (if (> (order (first-term n)) (order (first-term d))) (order (first-term n)) (order (first-term d))))
       (o2 (order (first-term term-gcd)))
       (int-factor (expt (coeff (first-term term-gcd)) (+ 1 (- o1 o2))))
       ;Multiply by factor
       (nn (mul-terms (make-term 0 int-factor) n))
       (dd (mul-terms (make-term 0 int-factor) d))
       ;Divide results by gcd
       (new-term-gcd (gcd-terms nn dd)))
    (list (car (div-terms nn new-term-gcd)) (car (div-terms dd new-term-gcd)))))

(define (reduce-poly p1 p2)
  (if (same-variable? (variable p1) (variable p2))
      (let ((div-result (reduce-terms (term-list p1) (term-list p2))))
        (list (make-poly (variable p1) (car div-result))
              (make-poly (variable p1) (cadr div-result))))))


;Define a generic reduce operation

;generic procedure
(define (reduce a b) (apply-generic 'reduce x y))

;In integer package
(define (reduce-integers n d)
(let ((g (gcd n d)))
(list (/ n g) (/ d g))))

;Adding to tables
;Integer
(put 'reduce '(integer integer) (lambda (x y) (map tag (reduce-integers x y))))

;Terms package
(put 'reduce             '(sparse sparse)  (lambda (t1 t2)       (map tag (reduce-terms t1 t2))))
(put 'reduce             '(sparse dense)   (lambda (t1 t2)       (map tag (reduce-terms t1 (dense->sparse t2)))))
(put 'reduce             '(dense dense)   (lambda (t1 t2)       (map tag (reduce-terms t1 t2))))
(put 'reduce             '(dense sparse)  (lambda (t1 t2)       (map tag (reduce-terms t1 (sparse->dense t2)))))

;Polynomial
(put 'reduce      '(polynomial polynomial) (lambda (p1 p2)       (reduce-poly p1 p2)))
