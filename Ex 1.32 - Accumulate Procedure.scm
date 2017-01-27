#lang scheme

; Exercise 1.32 
; Show that sum and product are both special cases of a more general notion called accumulate
; Write an accumulate procedure with the following structure
; (accumulate combiner null-value term a next b)
; Accumulate takes as arguments the same term and range specifications as sum and product
; combiner is a two-argument procedure that specifies how the current term is to be combined with the accumulation of the proceeding terms
; null-value specifies the base value to use when the terms run out

(define (accumulate combiner null-value term a next b)
  (if (> a b) ;If reached end of range
      null-value ;return the null value
      (combiner (term a) ;Otherwise combine f(a) with f(next(a))
                (accumulate combiner null-value term (next a) next b))))

(define (test-accumulate-sum)
  (define (term a)
    a)
  (define (next a)
    (+ a 1))
  (accumulate + 0 term 0 next 10))

(define (test-accumulate-product)
  (define (term a)
    a)
  (define (next a)
    (+ a 1))
  (accumulate * 1 term 1 next 10))

;b. If your accumulate procedure generates a recursive
;process, write one that generates an iterative process.
;If it generates an iterative process, write one that generates
;a recursive process.

;Keep track of final result using null value, updated with each iteration
(define (iterative-accumulate combiner null-value term a next b)
  (if (> a b) ;If reached end of range
      null-value ;return the null value
      ;Otherwise move to next iterations
      ;Update null-value - combine with current null value and a
      ;Increase a to next value
      (iterative-accumulate combiner (combiner null-term a) term (next a) next b))))
  
  
