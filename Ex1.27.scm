#lang scheme

;Ex 1.27 update fermat test to test full range of values from 1 to N-1
;Test procedure using carmichael numbers, show they fool the test
;> (fermat-test-full 561)
;Prime!
;> (fermat-test-full 1105)
;Prime!
;> (fermat-test-full 1729)
;Prime!
;> (fermat-test-full 2465)
;Prime!
;> (fermat-test-full 2821)
;Prime!
;> (fermat-test-full 6601)
;Prime!

;Fermat Test
;Test all values from 1 to n-1
(define (fermat-test-full n)
  (define (testVal a n)
    [cond ((= a n) (display "Prime!"))    ;If a = n, end of test - we have a prime
          ((= (expmod a n n) a) (testVal (+ a 1) n)) ;If test passes (a^n % n = 0) move onto the next n value
          (else (display "Not Prime!"))])   ;Otherwise test has failed
  (testVal 1 n)) ;Start test beginning from 1


;Square input
(define (square x)
  (* x x))

;Expmod - computes the exponential of a number modulo another number
(define (expmod base exp m)
  (cond ((= exp 0) 1) ;a^0 = 1
        ((even? exp)  ;if exponent is even
         (remainder (square (expmod base (/ exp 2) m)) ;Recursively divide, similar to fast-exponent
                    m))                                ;Successive squaring -> O(log(n)) growth
        (else
         (remainder (* base (expmod base (- exp 1) m)) ;If odd subtract 1
                    m))))

;Check if number is even - if no remainder is left after dividing by 2
(define (even? n)
  (= (remainder n 2) 0))

;Recursively subtract d until remainder is left
(define (remainder n d)
  (if (< n d)
      n
      (remainder (- n d) d)))