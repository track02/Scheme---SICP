#lang scheme

;Ex 1.46
;Iterative improvement
;Take an guess value
;If its good enough return it
;Otherwise improve it

;Write a procedure iterative-improve that takes two procedures as arguments
;One procedure to test whether a guess is good enough
;The second to improve a guess
;iterative-improve should return a procedure that takes a guess
;and keeps improving it until its good enough


;Takes in two procedures
(define (iterative-improve guess-check guess-improve)
  ;Produces a procedure combining the two that works on a "guess" argument
  ;Define inner procedure - can't use lambda as procedure needs to call itself
  (define (ii x)
    (if (guess-check x)
        x
        (ii (guess-improve x))))
  ;Return inner procedure
  ii)
    
 ;Rewrite Sqrt and fixed-point to use iterative-improve

; sqrt procedure and sub-procedures from SICP 1.1.7
;(define (sqrt x)
;  (sqrt-iter 1.0 x))
;
;(define (sqrt-iter guess x)
;  (if (good-enough? guess x)
;      guess
;      (sqrt-iter (improve guess x)
;                 x)))
;
;Improve procedure
;(define (improve guess x)
;  (average guess (/ x guess)))
;
;Good enough procedure
;(define (good-enough? guess x)
;  (< (abs (- (square guess) x)) 0.001))

; fixed-point procedure from SICP 1.3.3
;(define tolerance 0.00001)
;
;(define (fixed-point f first-guess)
;   (define (close-enough? v1 v2) <--- Good-enough
;     (< (abs (- v1 v2)) tolerance))
;   (define (try guess)
;     (let ((next (f guess)))
;       (if (close-enough? guess next)
;           next
;           (try next))))
;   (try first-guess))



(define (average x y)
  (/ (+ x y) 2))

(define (square x) (* x x))

;Iterative-improve version of sqrt
(define (iter-sqrt x)
  
  ;Pass in good-enough / improve procedures and give initial guess 1.0
  ((iterative-improve (lambda (guess)
                       (< (abs (- (square guess) x)) 0.001))
                     (lambda (guess)
                       (average guess (/ x guess))))
   1.0))

;Iterative-improve version of fixed-point
;Takes a function and initial guess
(define (iter-fixp f x)
    ((iterative-improve (lambda (guess)
                       (< (abs (- (f guess) guess)) 0.001)) ;Difference between current and next guess
                     (lambda (guess)
                       (f guess))) ;Apply function to current guess to find next
   x))