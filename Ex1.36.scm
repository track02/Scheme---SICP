#lang scheme

;Ex 1.36
;Modify fixed-point so that it prints
;the sequence of approximations it generates
;use the newline and display primitives

(define tolerance 0.00001)          ;Fixed point seeks to find x such that f(x) = x
(define (fixed-point f first-guess) ;Takes in a function and initial guess
  (define (close-enough? v1 v2)     ;Compares difference between two values against given tolerance
    (< (abs (- v1 v2)) tolerance))
  (define (try guess) ;Tests a guess using close enough
    (display guess)   ;Display guess
    (newline)         ;Output a newline
    (let ((next (f guess))) ;Let next = f(guess)
      (if (close-enough? guess next) ;If difference between guess & next is acceptable
          next ;Output f(x)
          (try next)))) ;Otherwise next becomes guess - repeat
  (try first-guess)) ;Start off procedure 


;Find a solution to x^x = 1000
;by finding a fixed point of x -> log(1000)/log(x)
;Compare results with / without average damping

;Average damping is a technique used to limit the change between guesses
;We can make a new guess that is not as far from y as x/y by averaging y with x/y

(define (average x y)
  (/ (+ x y) 2))


;> (fixed-point (lambda (x) (/ (log 1000) (log x))) 2.0)
;2.0
;...
;4.555532270803653
;34 Steps

;> (fixed-point (lambda (x) (average x (/ (log 1000) (log x)))) 2.0)
;2.0
;....
;4.555537551999825
;10 Steps