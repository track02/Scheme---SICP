#lang scheme

;Ex 2.12 Define a constructore make-center-percent that takes a center
;and a percentage tolerance and produces the desired interval

;Takes in a center value - c and +- percentage p
(define (make-center-percent c p)
  (let ((op (/ c 100)))
    (make-interval (- c (* op p)) (+ c (* op p)))))
       
;Testing
;> (make-center-percent 100 5)
;(95 . 105)

;You must also define a selector percent that produces
;the percentage tolerance for a given interval. 

;Takes in an interval i
(define (percent i)

  ;We can find the center using the already defined procedure
  ;% Diff = (Difference / Center) * 100
  (* 100 (/ (- (upper-bound i) (center i)) (center i))))

;Interval constructor / selectors (+ center variants)
(define (make-interval a b) (cons a b))

(define (upper-bound i)
  (cdr i))

(define (lower-bound i)
  (car i))

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))
  
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (width i)
  
  (/ (- (upper-bound i) (lower-bound i)) 2))
