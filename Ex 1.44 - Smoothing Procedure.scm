#lang scheme

;Ex 1.44
;Write a smoothing procedure that takes in a function f
;and produces a smoothed f
;where smoothed f = f(x-dx) + f(x) + f(x+dx) / 3

;Define dx, might be better served as a parameter to smooth
(define dx 0.7)

;Takes in a procedure and returns a procedure that computes the smoothed variant
(define (smooth f)
  (lambda (x) (/
               (+
                (f (- x dx))
                (f x)
                (f (+ x dx)))
               3)))

;Show how an n-fold smoothed function can be generated using smooth and repeated
;Repeated / Compose from previous exercise
(define (repeated f i)
  (if (= i 1) ;If 1 is one, return function
      f
      (compose f (repeated f (- i 1))))) ;Otherwise "add" another function call, reduce counter

(define (compose f g)
  (lambda (x)
    (f(g x))))

;Given a function and a number, n repeatedly smooth the function n times
(define (n-fold-smooth f n)
  (repeated (smooth f) n))
