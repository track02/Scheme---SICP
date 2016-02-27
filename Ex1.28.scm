#lang scheme

;Ex 1.28 implement the Miller-Rabin variant
;Fermats Theorem -> n is prime, if for any positive integer, a < n the following holds
; a^n % n = a % n
; (or) a^n-1 % n = 1 (% n)
;Miller Rabin is variant of Fermat
;When checking for congruency, also check for a non-trivial square root (ntsr)
;An ntsr is a number not equal to 1 or (n - 1) and whose square is equal to 1%n

(define (miller-rabin n)
  (miller-rabin-test (- n 1) n))

(define (miller-rabin-test a n)
  (cond [(= a 0) #t] ;If test has held for [0, n) then we have a prime number
        [(= (expmod a (- n 1) n) 1) (miller-rabin-test (- a 1) n )];If a^(n-1) % n == 1 (1%n) then test has held - proceed to next a
        [else #f])) ;Otherwise return false, test has failed

;Expmod - Calculates base^exp % mod
(define (expmod base exp mod)
  (cond ((= exp 0) 1) ;If exponent is 0 then return 1, 1%x = 1
        ((even? exp)  ;If exponent is even we can reduce steps via successive squaring
         ;If a non-trivial-root is found, return 0 otherwise carry out successive square
         (if (non-trivial-root? (expmod base (/ exp 2) mod) mod) 0 (remainder (square (expmod base (/ exp 2) mod)) mod)))
         (else ;If exponent is odd, subtract one and continue (exponent becomes even and successive squaring can take place)
         (remainder (* base (expmod base (- exp 1) mod)) mod))))        
         
;Check for non-trivial-sqrt
;a != 1 or n-1
;a^2 = 1 % n (1)
(define (non-trivial-root? a n)
  (if (and (not (or (= a 1) (= a (- n 1)))) ;Check a does not equal 1 or n-1
           (= (remainder (* a a) n) 1))     ;Check that a%n = 1
      #t                                    ;Both conditions true -> return true, non trivial root
      #f))                                  ;Otherwise return false
  
;Checks if a number is even
(define (even? x)
  (= (remainder x 2) 0)) ;if x%2 = 0 then must be even

;Squares a number
(define (square x)
  (* x x))