; Write an iterative variation of the exponent calculator
; Make use of the rule that (b^n/2)^2 = (b^2)^n/2 
; To reduce steps required for even exponents down to
; O(log(n))

#lang racket
(define (exp-finder b n)

;If exponent equals 0 return 1
;If exponent equals 1 return base
;Otherwise begin search process
(cond ((= 0 n) 1)
((= 1 n) b)
(else (start-find b n))))

  
;Iterative - Entire state is passed to next call
;Answer stored using a which keeps running total
(define (exp-iter a b n)
(cond ((= n 0) a)
(else (exp-iter (* a b) b (- n 1)))))

;Checks if a number is even - used to divide exponent
(define (even n)
(= (remainder n 2) 0))

;Divides exponent and squares base until no longer possible
;Halves search space each time
;Begins exponent calculation once exponent is odd
(define (start-find b n)
(cond ((even n) (start-find (* b b) (/ n 2)))
(else (exp-iter 1 b n))))
