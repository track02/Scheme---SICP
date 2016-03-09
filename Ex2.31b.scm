#lang scheme

; Ex 1.32b
; Write an iterative version of accumulate


(define (accumulate combiner null-value term a next b)
  (if (> a b) ;If reached end of range
      null-value ;return the null value
      (combiner (term a) ;Otherwise combine f(a) with f(next(a))
                (accumulate combiner null-value term (next a) next b))))


(define (accumulate-iter combiner null-value term a next b)
  (define (iter a result) ;use a and result as state variables
    (if (> a b) ;If end of range
        result  ;return result
        (iter (next a) (combiner result (term a))))) ;else perform next iteration
  (iter a null-value)) ;Starting conditions
  

(define (test-accumulate-iter-sum)
  (define (term a)
    a)
  (define (next a)
    (+ a 1))
  (accumulate-iter + 0 term 0 next 10))


(define (test-accumulate-iter-product)
  (define (term a)
    a)
  (define (next a)
    (+ a 1))
  (accumulate-iter * 1 term 1 next 10))


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




  
  ;Write an iterative variation of product
(define (product-iter term a next b cnd)
  (define (iter a result) ;a and result are state variables used to keep track 
    (if (cnd a b) ;If stop condition is met 
        result  ;return the result
        (iter (next a) (* result (term a))))) ;Otherwise iterate again, incrementing a and updating the result
  (iter a 1)) ;Initial starting state a = a, result = 1 (multiplication)