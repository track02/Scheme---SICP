#lang scheme

;Ex 2.10 - modify the interval division procedure to check for intervals that span zero

(define (make-interval a b) (cons a b))

;Upper bound is last element of list
(define (upper-bound i)
  (cdr i))

;Lower bound is first element of list
(define (lower-bound i)
  (car i))

;Division multiplies x by (1/y)
;If an interval spans zero then the lower bound is <= 0 and the upper bound is >= 0
(define (zero-span? y)
   (and (<= (lower-bound y) 0)
        (>= (upper-bound y) 0)))

(define (div-interval x y)
  (if (zero-span? y)
      (display "Error - Zero Spanning Interval")
      (mul-interval x 
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y))))))

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

