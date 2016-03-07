#lang scheme

; Ex 1.31 - Write a procedure similar  sum called product
; product should return the product of the values of a function at points over a given range

; Define factorial in the terms of product



;Sum - higher order procedure, manipulates procedures
;Using provided procedures (term, next) calculate the sum from a to b
(define (sum term a next b)
  (if (> a b) ;If a is greater than b, stop we've hit limit
      0
      (+ (term a) ;Otherwise recursively add f(a) to f(a+1) to f(a+2) ... 
         (sum term (next a) next b))))

(define (product term a next b cnd)
  (if (cnd a b);Use another procedure to determine when to stop, cnd
      1       ;Returning 1 due to multiplication, if 0 result would equal 0
      (* (term a) ;Otherwise multiply f(a)
         (product term (next a) next b cnd)))) ;with f(a+1)

;Factorial function using product
;5! -> 5 * 4 * 3 * 2 * 1
(define (factorial a)

  ;Term f(a) = a
  (define (term a)
    a)

  ;Next = a - 1
  (define (next a)
    (- a 1))

  ;Need to manage cnd
  (define (cnd a b)
    (< a b))
  
  (product term a next 1 cnd))

;Using product to compute approximations to Pi
;Following the formula
;
; Pi / 4 = 2/3 * 4/3 * 4/5 * 6/5 * 6/7 * 8/7 *
;
; If a is odd, numerator = a + 1, denominator = a + 2
; If a is even, numerator = a + 2, denominator = a + 1
(define (approx-pi n) ;Calculate approximation using product f(1) to f(n)

 ;Term f(a) = if (a%2 != 0) (a+1)/(a+2) else (a+2)/(a+1)
(define (term a)
  (if (even? a)
      (/ (+ a 2) (+ a 1))
      (/ (+ a 1) (+ a 2))))

 (define (next a)
   (+ a 1))

 (define (cnd a b)
   (> a b))

(* (product term 1 next n cnd) 4))
  

;Check if number is even
(define (even? a)
  (= (remainder a 2) 0)) ;If no remainder is left after a%2, even

;Write an iterative variation of product
(define (product-iter term a next b cnd)
  (define (iter a result) ;a and result are state variables used to keep track 
    (if (cnd a b) ;If stop condition is met 
        result  ;return the result
        (iter (next a) (* result (term a))))) ;Otherwise iterate again, incrementing a and updating the result
  (iter a 1)) ;Initial starting state a = a, result = 1 (multiplication)


  
  