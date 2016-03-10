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


;Ex 1.33a - Implement a procedure that sums the squares of prime numbers from a to b
(define (sum-square-primes a b)
  (filtered-accumulate prime? + 0 square a next b))




;Prime? Filter (From Section 1.2.6)
(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b)
  (= (remainder b a) 0))
(define (prime? n)
  (= n (smallest-divisor n)))

;Term Procedure - Square a
(define (square a)
  (* a a))

;Next
(define (next a)
  (+ a 1))