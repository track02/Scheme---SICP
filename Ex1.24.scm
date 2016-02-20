#lang scheme

;Ex 1.24 update timed prime test to use the fast-prime? procedure (fermats)
;Fermat's Little Theorem
;If n is a prime and a is any positive integer less than n, then a raised to the nth power is congruent to a modulo n
;a^n % n = a % n


; Displays input and begins prime test
(define (timed-prime-test n)
  (start-prime-test n (current-milliseconds)))

;If n is a prime number print output and time taken
;Return false if non-prime, any non-#f values in scheme are interpreted as true
(define (start-prime-test n start-time)
  (cond [(fast-prime? n (- n 1)) (report-prime (- (current-milliseconds) start-time))]
        [else #f])) ;Return false if not prime 
  

;Prints 3 *'s and the total time taken
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

;Runs fermat-test a nnumber of times, returning true if every test passes
(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

;Square input
(define (square x)
  (* x x))

;Fermat Test
(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a)) ;a^n % n = a
  (try-it (+ 1 (random (- n 1))))) ;Try using a random value for a, 1 less than n

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