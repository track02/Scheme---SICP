#lang scheme

;Define a constructor make-segmen and selectors start-segment and end-segment
;That define a segment in term of points
;Additionally specify a constructor and selectors for representing a point
;Finally define a procedure midpoint-segment that takes a segment and
;returns the midpoints

;-----------------------------
;      midpoint-segment
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
;     Segment operations
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
;  make-segment, start, end
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
;     Segment as point pair
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
; make-point, x-point, y-point
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
;     Point as a pair
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
;       Cons, Cdr, Car
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
;     Pair Implementation
;-----------------------------


;Point
(define (make-point x y)
  (cons x y))

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

;Procedure to print points
(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))


;Segment
(define (make-segment start end)
  (cons start end))

(define (start-segment seg)
  (car seg))

(define (end-segment seg)
  (cdr seg))

;Midpoint Procedure
(define (midpoint-segment seg)
  (let ((midx
         (/ (+ (x-point(start-segment seg))
               (x-point(end-segment seg)))
            2))
        (midy
         (/ (+ (y-point(start-segment seg))
               (y-point(end-segment seg)))
            2)))
    (make-point midx midy)))
    
        


  