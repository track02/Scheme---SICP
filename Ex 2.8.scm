#lang scheme

;Ex 2.8 - Write a procedure to create an interval that is equal
;to the difference between two given intervals (subtraction)

(define (make-interval a b) (cons a b))

;Upper bound is last element of list
(define (upper-bound i)
  (cdr i))

;Lower bound is first element of list
(define (lower-bound i)
  (car i))

(define (div-interval x y)
  (mul-interval x 
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (lower-bound y))
                 (- (upper-bound x) (upper-bound y))))

;Testing
;> (define a (make-interval 1 2))
;> (define b (make-interval 3 4))
;> (sub-interval b a)
;(2 . 2)
