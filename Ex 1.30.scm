#lang scheme

; Ex 1.30 - Rewrite sum procedure as iterative variant



;Sum - higher order procedure, manipulates procedures
;Using provided procedures (term, next) calculate the sum from a to b
(define (sum term a next b)
  (if (> a b) ;If a is greater than b, stop we've hit limit
      0
      (+ (term a) ;Otherwise recursively add f(a) to f(a+1) to f(a+2) ... 
         (sum term (next a) next b))))


(define (sum-iter term a next b)
  (define (iter a result) ;a and result are state variables used to keep track 
    (if (> a b) ;If a has passed b, need to stop iterating 
        result  ;and return the result
        (iter (next a) (+ result (term a))))) ;Otherwise iterate again, incrementing a and updating the result
  (iter a 0)) ;Initial starting state a = a, result = 0