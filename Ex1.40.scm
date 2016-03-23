#lang scheme

;Ex 1.40
; Define a procedure cubic that can be used together with the 
; newtons-method procedure in expressions of the form
; (newtons-method (cubic a b c) 1)


(define tolerance 0.00001) ;Tolerance value used for fixed-point

;Repeatedly tests a function until results are within tolerance
(define (fixed-point f first-guess) ;start with function f and a guess

  (define (close-enough? v1 v2)     ;checks whether two values are
    (< (abs (- v1 v2)) tolerance))  ;within tolerance

  (define (try guess)               ;Calculates next guess using previous
    (let ((next (f guess)))         ;next = f(guess)
      (if (close-enough? guess next);if next is close enough to guess
          next                      ;return next
          (try next))))             ;otherwise guess = next
  
  (try first-guess))


(define dx 0.00001) ;dx used for differentiation

(define (deriv g)  ;Takes a procedure g
  (lambda (x)      ;Returns differentiated procedure that takes one argument
    (/ (- (g (+ x dx)) (g x)) ;g'(x) = g(x+dx) - g(x) / dx
       dx)))

(define (newton-transform g) ;Takes a procedure g
  (lambda (x)                ;Creates a new procedure x - g(x) / g'(x) 
    (- x (/ (g x) ((deriv g) x)))))

(define (newtons-method g guess) ;Finds fixed point for a given function
  (fixed-point (newton-transform g) guess)) ;After transforming it

;Cubic should return a procedure compatible with newtons method
;cubic(a,b,c) -> c(x)
;x^3 + ax^2 + bx + c
(define (cubic a b c)
  (lambda (x)
    (+ (* x x x)
       (* a x x)
       (* b x)
       c)))