#lang scheme

;Accumulate
(define (accumulate op initial sequence)
   (if (null? sequence)
       initial
       (op (car sequence)
           (accumulate op initial (cdr sequence)))))


;Provided flatmap procedure
;Given a sequence and procedure
;Appends the results of mapping the procedure to the sequence
;Nested loop
(define (flatmap proc seq)
  (accumulate append null (map proc seq))) 

;Provided enumerate interval method
;Produces a list within provided interval
(define (enumerate-interval low high)
  (if (> low high)
      null
      (cons low (enumerate-interval (+ low 1) high))))

;Square
(define (square x) (* x x))

;Finds the smallest divisor of a number
(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b)
  (= (remainder b a) 0))

;Checks if number is prime, if its smallest divisor is itself
(define (prime? n)
  (= n (smallest-divisor n)))

;Checks if pair is prime
(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

;Provided make-pair-sum
;Creates a list from a given pair (car, cdr, cdr+car)
(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

;Combining flatmap / enumerate produce all pairings (i,j) such that
; j<i<=n and j + i = prime
(define (prime-sum-pairs n)

  ;Creates (car, cdr, car+cdr) lists for 
  (map make-pair-sum
       (filter prime-sum? ;the filtered prime-sum pairs produced by
               (flatmap   ;mapping over the list 1 to n, (i)
                (lambda (i) ;for each element
                  (map (lambda (j) (list i j)) ;join it with all values below it (j)
                       (enumerate-interval 1 (- i 1)))) ;created by enumerating from 1 to (i - 1)
                (enumerate-interval 1 n)))))

;Ex 2.40 Write a procedure unique-pairs which when given an integer, n generates the
;sequence of pairs (i, j) with 1 <= j < i <= n
(define (unique-pairs n)
  (flatmap ;
   (lambda (i)  ;For each element (i) from the list 1 to n
     (map (lambda (j) (list i j)) ;Map (list i j) seq, where seq is the list 1 to i-1
          (enumerate-interval 1 (- i 1))))
   (enumerate-interval 1 n))) ;Using a base sequence of 1 to n

;Testing
;> (unique-pairs 3)
;((2 1) (3 1) (3 2))
;> (unique-pairs 4)
;((2 1) (3 1) (3 2) (4 1) (4 2) (4 3))

;Use unique-pairs to simplify the prime-sum-pairs procedure
;Combining flatmap / enumerate produce all pairings (i,j) such that
; j<i<=n and j + i = prime
(define (simple-prime-sum-pairs n)

  ;Creates (car, cdr, car+cdr) lists for 
  (map make-pair-sum
       (filter prime-sum? ;the filtered prime-sum pairs produced by
               (unique-pairs n))))

;Testing
;> (prime-sum-pairs 4)
;((2 1 3) (3 2 5) (4 1 5) (4 3 7))
;> (simple-prime-sum-pairs 4)
;((2 1 3) (3 2 5) (4 1 5) (4 3 7))