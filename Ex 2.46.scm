#lang scheme

;Exercise 2.46.  A two-dimensional vector v
;running from the origin to a point can be represented as a
;pair consisting of an x-coordinate and a y-coordinate.

;Implement a data abstraction for vectors by giving a constructor 
;make-vect and corresponding selectors xcor-vect and ycor-vect

;In terms of your selectors and constructor, implement procedures 
;add-vect, sub-vect, and scale-vect
;that perform the operations vector addition, vector subtraction,
;and multiplying a vector by a scalar: 


;(x1,y1) + (x2,y2) = (x1 + x2, y1 + y2)
;(x1,y1) - (x2,y2) = (x1 - x2, y1 - y2)
;s * (x1,y1) = (sx1, sy1)

;Vectors can be implemented as a pair

;Constructor
(define (make-vect x y)
  (cons x y))

;Selectors
(define (xcor-vect v)
  (car v))

(define (ycor-vect v)
  (cdr v))

;Testing
;> (define v1 (make-vect 5 3))
;> (xcor-vect v1)
;5
;> (ycor-vect v1)
;3

;Procedures

(define (add-vect v1 v2)
  (make-vect (+ (xcor-vect v1)
                (xcor-vect v2))
             (+ (ycor-vect v1)
                (ycor-vect v2))))

(define (sub-vect v1 v2)
  (make-vect (- (xcor-vect v1)
                (xcor-vect v2))
             (- (ycor-vect v1)
                (ycor-vect v2))))

(define (scale-vect v1 s)
  (make-vect (* s (xcor-vect v1))
             (* s (ycor-vect v1))))

;Testing
;> (define v1 (make-vect 3 3))
;> (define v2 (make-vect 2 2))
;> (add-vect v1 v2)
;(5 . 5)
;> (sub-vect v1 v2)
;(1 . 1)
;> (scale-vect v1 2)
;(6 . 6)