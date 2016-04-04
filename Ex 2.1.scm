#lang scheme

;Define an improved version of make-rat that handles both positive
;and negative arguments

;Make-rat should normalize the sign so that if the rational number is positive
;both the numerator and denominator are positive
;if the rational number is negative only the numerator is negative

;Given a numerator + denominator create representation of n/d
(define (make-rat n d)
  (let ((g (gcd n d))) ;Find GCD of both values
    (if (< d 0)
        ;If denominator is negative * -1 to leave positive
        ;multiply numerator by -1 to make negative
        ;if both n and d are negative then both become positive
        (cons (/ (* n -1) g) (/ (* d -1) g))
        ;Otherwise proceed as normal, reducing values to gcd
        (cons (/ n g) (/ d g))))) ;Create pair of (n/gcd), (g/gcd)

;Procedure to print rational numbers
(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

;Selectors / helper procedures
(define (numer x) (car x))
(define (denom x) (cdr x))