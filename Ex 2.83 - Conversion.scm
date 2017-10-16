#lang scheme

;Exercise 2.83.
; Suppose you are designing a generic arithmetic system for dealing with the tower of
;types shown in figure 2.25: integer, rational, real, complex.

;For each type (except complex), design a procedure that raises objects of that type one level in the tower.
;Show how to install a generic raise operation that will work for each type (except complex).


;Each package would have a have a procedure for converting upwards that would be assigned to a generic 'raise operation

;Integer to Rational

(define (integer->rational int)
  (make-rational int 1)) ;Create a rational number by applying a denominator of 1

(put 'raise 'integer integer->rational)  ;Add to table


;Rational to Real

(define (rational->real rat)
  (make-real (/ (numer rat) (denom rat)))) ;Create a real number by dividing numerator and denominator

(put 'raise 'rational  rational->real) ;Add to table

;Real to Complex

(define (real->complex comp)
  (make-from-real-imag comp 0)) ;Create a new complex number with 0 for imaginary component

(put 'raise 'real real->complex) ;Add to table

;We can wrap this in a procedure
(define (raise a)
  (apply-generic 'raise a))