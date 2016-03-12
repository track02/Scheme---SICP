#lang scheme

; Ex 1.33
; Write a generic variation of accumulate called filtered-accumulate
; Takes the same arguments as accumulate along with an additional filter arrgument
; The filter argument applies a filter on the terms been combined
(define (filtered-accumulate filter combiner null-value term a next b)
  (if (> a b) ;If reached end of range
      null-value ;return the null value
      (if (filter a) ;Else check a against filter
          (combiner (term a)   (filtered-accumulate filter combiner null-value term (next a) next b))   ;Passes -> combine a with a_next
          (combiner null-value (filtered-accumulate filter combiner null-value term (next a) next b))))) ;Otherwise -> combine null with a_next

;Test filtered-accumulate (sum)
(define (test-filter-sum)
  (define (term a)
    a)
  (define (next a)
    (+ a 1))
  (define (filter a)
    (= (remainder a 2) 0))
  (filtered-accumulate filter + 0 term 0 next 10))

;Test filtered-accumulate (product)
(define (test-filter-product)
  (define (term a)
    a)
  (define (next a)
    (+ a 1))
  (define (filter a)
    (= (remainder a 2) 0))
  (filtered-accumulate filter * 1 term 1 next 10))


;Ex 1.33b - Implement a procedure that find the product of all integers less than n that are relatively prime to n
;Relatively Prime -> GCD(i, n) = 1
(define (product-relative-primes b)
  (define (isCoprime? a) ;Note - Have to define filter here in order to provide it with an initial b value 
    (= (gcd a b) 1))
  (filtered-accumulate isCoprime? * 1 term 1 next b))

;GCD Procedure from section 1.2.5
(define (gcd a b)
   (if (= b 0)
       a
       (gcd b (remainder a b))))


;Term Procedure - Square a
(define (term a)
  a)

;Next
(define (next a)
  (+ a 1))