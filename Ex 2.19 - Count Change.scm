#lang scheme

;Below is the count change example from Section 1
;We want to rewrite cc to also take a list of values of coins to use
;rather than an integer specifying which coins to use
;e.g. (cc 100 us-coins)

;count-change computes the total number of ways to change any amount of money

(define us-coins (list 50 25 10 5 1))
(define us-coins-reverse (list 1 5 10 25 50))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))

(define (count-change amount)
  (cc amount ))

(define (cc amount coin-values)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
         (+ (cc amount
                (except-first-denomination coin-values))
            (cc (- amount
                   (first-denomination coin-values))
                coin-values)))))

;Will coin order matter?

;It shouldnt as all list elements (sub-lists) are evaluated

;> (cc 100 us-coins)
;292

;> (cc 100 us-coins-reverse)
;292


;Define the following procedures in terms of list procedures

;True if coin list is empty
(define (no-more? coin-values)
  (null? coin-values))

;Return coin list except the first denomination
(define (except-first-denomination coin-values)
  (cdr coin-values))

;Return first denomination
(define (first-denomination coin-values)
  (car coin-values))
