#lang scheme

;Exercise 2.48   A directed line segment in the plane can be represented
;as a pair of vectors -- the vector running from the origin to the start-point
;of the segment, and the vector running from the origin to the end-point
;of the segment.

;Use your vector representation from exercise 2.46 to define a
;representation for segments with a constructor make-segment
;and selectors start-segment and end-segment. 


;Vector implementation - From Ex 2.48

;Constructor
(define (make-vect x y)
  (cons x y))

;Selectors
(define (xcor-vect v)
  (car v))

(define (ycor-vect v)
  (cdr v))

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

;Segment implementation

;Constructor - Segment is a pair of vector
(define (make-segment start-vector end-vector)
  (cons start-vector end-vector))

;Selectors
(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cdr segment))

;Testing

(define v1 (make-vect 5 5))
(define v2 (make-vect 7 7))

;> (define s1 (make-segment v1 v2))
;> s1
;((5 . 5) 7 . 7)
;> (start-segment s1)
;(5 . 5)
;> (end-segment s1)
;(7 . 7)


