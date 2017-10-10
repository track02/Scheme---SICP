#lang scheme

;Ex 2.79 Define a generic equality predicate equ?
;that tests the equality of two numbers, and
;install it in the generic arithmetic package.
;This operation should work for ordinary numbers, rational numbers, and complex numbers.

;Generic procedure - table lookup
(define (equ? x y) (apply-generic ’equ? x y))

;Internal procedure for scheme number package
(define (scheme-number-package)
  
  ;Pass operator directly to table
  (put 'equ? '(scheme-number scheme-number) =) ;Operation type 'equ? with two scheme-number args
  
  'done);Finished package

;Internal procedure for rational number package
(define (rational-number-package)

  ;Can check if two fractions are equal by comparing product of numerator(x) * denominator(y)
  (define (equ? x y)
    (= (* (numer x) (denom y)) (* (numer y) (denom x))))

  ;Put operation into the table
  (put 'equ? '(rational rational) equ?) ;Operation type 'equ? with two rational args
  
  'done);Finished package


;Internal procedure for complex package
(define (complex-number-package)

  ;Check real / imaginary parts of complex number
  (define (equ? x y)
    (and (= (real x) (real y)) (= (imag x) (imag y))))

  ;Put opereation into the table
  (put 'equ? '(complex complex) equ?) ;Operator type 'equ? with two complex args
  
  'done);Finished Package
