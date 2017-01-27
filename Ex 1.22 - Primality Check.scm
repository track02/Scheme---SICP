#lang scheme

;Exercise 1.22 Most Lisp implementations include a primitive
;called runtime that returns an integer that specifies the amount of time the system has been running 
;(measured, for example, in microseconds). 

;The following timedprime-test procedure, when called with an integer n, prints n and checks to see if n is prime.
;If n is prime, the procedure prints three asterisks followed by the amount of time used in performing the test.

;Using this procedure, write a procedure search-for-primes 
;that checks the primality of consecutive odd integers in a specified range.


;Write a function that finds the first 3 primes numbers starting from a given value

; Displays input and begins prime test
(define (timed-prime-test n)
  (newline) 
  (display n)
  (start-prime-test n (current-milliseconds)))

;If n is a prime number print output and time taken
;Return false if non-prime, any non-#f values in scheme are interpreted as true
(define (start-prime-test n start-time)
  (cond [(prime? n) (report-prime (- (current-milliseconds) start-time))]
        [else #f])) ;Return false if not prime 
  

;Prints 3 *'s and the total time taken
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

;Find smallest divisor of n
;Starts by checking n with 2
;Will increment divisor by 1 until sqrt(n) is reacher
;If d is a divisor of n then
;n = kd
;Neither k or d can be greater than sqrt(n) (else kd would be larger than n!)
;Only concerned with divisor, not multiple so reduce search space to sqrt(n)
(define (smallest-divisor n)
  (find-divisor n 2))

;Checks input n against potential divisor
(define (find-divisor n d)
  (cond ((> (square d) n) n) ;Gone past sqrt, n must be prime
        ((divides? d n) d) ;If n divides by d cleanly (n%d = 0) then d is a divisor
        (else (find-divisor n (+ d 1))))) ;Otherwise move on to the next value of d

;Does a divide into b cleanly
(define (divides? a b)
  (= (remainder b a) 0))

;If a numbers smallest divisor is itself -> prime
(define (prime? n)
  (= n (smallest-divisor n)))

;Square input
(define (square x)
  (* x x))

;Find first 3 primes in a range, checking only odd values
(define (search-for-primes n counter)
  (cond [(> counter 0) ;If counter is greater than 0, primes left to find
         (cond [(divides? 2 n) (search-for-primes (+ n 1) counter)] ;If even, add one and try again
               [(timed-prime-test n) (search-for-primes (+ n 2) (- counter 1))] ;If prime, add 2 and reduce counter
               [else (search-for-primes (+ n 2) counter)])])) ;If odd non-prime, add 2 and reduce counter
