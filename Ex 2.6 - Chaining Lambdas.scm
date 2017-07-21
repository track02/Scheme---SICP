#lang scheme

;In a language that can manipulate procedures we don't need numbers (at least positive integers)
;Consider the following representations of 0 and the operation of adding 1

(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

;Define one and two directly and provide a direct definition of the addition procedure +

;We are using functions to represent numbers - no actual numbers are used

;Zero
;Returns a procedure that takes an argument, f
;Which in turn returns a procedure that takes an argument and when evaluated returns x

;Add-1
;Takes in one argument, n
;Returns a procedure that takes an argument, f 
;Which in turn returns a procedure that takes the argument x 
;f is applied to (n applied to f) and x

;This representation is known as Church numerals
;We are basically counting how many times a function (f) is to be applied

;In provided definitions first lambda takes in the function and the second the function argument
;0 -> f(x) = x
;1 -> f(x) = f(x)
;2 -> f(x) = f(f(x))

;One -> Apply the procedure (f) once to argument (x)
(define one (lambda (f) (lambda (x)(f x))))

;One -> apply the procedure (f) twice to argument (x)
(define two (lambda (f) (lambda (x) (f (f x)))))
  
;Add -> Want to apply procedure (f) (a+b) times to x
(define (add a b)
;Apply f a times to f applied b times applied to x
(lambda (f) (lambda (x) ((a f) ((b f) x)))))
;-> a*f(b*f(x))

;Test procedure
(define (plus n)
  (+ n 1))

;> (define four (add two two))
;> ((two plus) 0)
;2
;> ((four plus) 0)
;4