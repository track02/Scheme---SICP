#lang scheme

;Ex 2.4 Verify that (car (cons x y))
;yields x for any objects x and y

(define (cons x y)
  (lambda (m) (m x y)))
(define (car z)
  (z (lambda (p q) p)))

;Using substitution

;(cons x y)
;produces a function that takes m
;and applies it to x,y

;(car z)
;Returns z applied to a function that takes 2 args
;and returns the first


;(car (cons x y)
;
;((cons x y) (lambda (p q)  p))
;
;((lambda (m) (m x y)) (lambda (p q) p))
;     ^F                     ^G

;Results in F being applied to G
;Results in G being applied to x y
;Results in x being returned


;Implement cdr following the same method
;Same as car but returns second argument
(define (cdr z)
  (z (lambda (p q) q)))

;Testing
;> (car (cons 4 5))
;4
;> (cdr (cons 4 5))
;5
