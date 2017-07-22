#lang scheme

;Ex 2.7 - A system is developed for operating with intervals
;Intervals consist of two elements a lower-bound and upper-bound
;Several procedures are already defined for operating on intervals
;Write selectors upper-bound and lower-bound to complete the implementation

(define (make-interval a b) (cons a b))

;Upper bound is last element of list
(define (upper-bound i)
  (cdr i))

;Lower bound is first element of list
(define (lower-bound i)
  (car i))

;Testing
;> (define a (make-interval 5 10))
;> (define b (make-interval 10 20))
;> (add-interval a b)
;(15 . 30)
;> (mul-interval a b)
;(50 . 200)
;> (div-interval a b)
;(0.25 . 1.0)

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