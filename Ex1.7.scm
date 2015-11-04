#lang racket

(define (average x y)
  (/ (+ x y) 2))

(define (square x)
  (* x x))

(define (improve guess x)
  (average guess (/ x guess)))


;Define a new good-enough procedure
;Watch how guess changes between iterations
;Stop when the change is a very small fraction of the guess

;Checking for a fixed difference will break down with very small number
;E.g. If the guess was 0.000005 and the actual square root was 0.000010
;The guess would be accepted - however at this scale there is large % difference between values 

;Large numbers also pose a problem
;Due to lack of precision very small differences cannot be represented
;As values get larger we may be unable to represent it to a tolerance of 0.0001
;This can result in an infinite loop of recursive calls


;Note - changed from (< guessdiff 0.0001) to (< guessdiff (* guess 0.0001))
;Want to check if change is a small fraction _of_ guess, not a small fraction
(define (good-enough?-v2 guess prevguess)
  (< (abs (- guess prevguess)) (* guess 0.0001)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.0001))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))

;New procedure takes in previous guess along w/ improved
(define (sqrt-iter-v2 guess prevguess x)
  (if (good-enough?-v2 guess prevguess)
      guess
      (sqrt-iter-v2 (improve guess x) guess x)))

;Actual Sqrt -> 0.0007
;Returned result -> 0.007
(sqrt-iter 1 0.0000005)

;Alternative variant -> 0.0007
(sqrt-iter-v2 1 2 0.0000005)
