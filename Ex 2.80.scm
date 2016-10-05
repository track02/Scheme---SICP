#lang scheme

;Ex 2.80.  Define a generic predicate =zero?
;that tests if its argument is zero, and install it in
;the generic arithmetic package. This operation should work for ordinary numbers, rational numbers,
;and complex numbers. 

;Generic procedure - table lookup
(define (=zero? x ) (apply-generic '=zero? x))

;Internal procedure for scheme number package
(define (scheme-number-package)

  (define (=zero? x)
    (= x 0))
  
  ;Pass operator directly to table
  (put '=zero? '(scheme-number) =zero?) ;Operation type 'equ? with two scheme-number args
  
  'done);Finished package

;Internal procedure for rational number package
(define (rational-number-package)

  ;Can check if two fractions are equal by comparing product of numerator(x) * denominator(y)
  (define (=zero? x)
    (= (numer x) 0))

  ;Put operation into the table
  (put '=zero? '(rational) =zero?) ;Operation type 'equ? with two rational args
  
  'done);Finished package


;Internal procedure for complex package
(define (complex-number-package)

  ;Check real / imaginary parts of complex number
  (define (=zero? x)
    (and (= (real x) 0) (= (imag x) 0)))

  ;Put opereation into the table
  (put '=zero? '(complex) =zero?) ;Operator type 'equ? with two complex args
  
  'done);Finished Package