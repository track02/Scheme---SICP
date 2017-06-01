#lang scheme

;Exercise 2.34 - Fill in the following template to produce a
;procedure that evaluates a polynomial using Horner’s rule.

;Accumlate has the following structure
(define (accumulate op init seq)
  (if (null? seq) init
      (op (car seq)
          (accumulate op init (cdr seq)))))

;Horner's Rule
;Start with an, multiply by x, add an-1 multiply sum by x, add an-2, multiply sum by x ...
;Repeat until a0

;this-coeff = car of coefficient-sequence
;higher-terms = accumulation of remaining coefficients
;x = value for x

;E.g. (horner-eval 2 (list 1 2)) -> 1 + 2x where x = 2, want 5

;accumulate (1, 2) =  (+ (* 2 2) 1) = 5
;this-coeff = 1
;higher terms = accumulate(2) = (+ (0 * 2) 2) = 2
;                 this-coeff   = 2
;                 higher terms = 0
;                                0

;Multiply higher terms by x and add 1

;Other way around wouldn't work (multiplying this-coeff by x and adding higher)

;accumulate (1,2) = (+ (* 1 2) 4) = 6
;this-coeff = 1
;higher terms = accumulate (2) = (+ (* 2 2) 0) = 4
;               this-coeff = 2
;               higher-terms = 0


(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms)
                (+ (* higher-terms x) this-coeff))
              0
              coefficient-sequence))


