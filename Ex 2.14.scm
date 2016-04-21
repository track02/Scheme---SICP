#lang scheme

;Ex 2.14 - There are two algebraically equivalent formulae for parallel resistors
;
; R1R2 / R1 + R2
; 1 / (1/R1) + (1/R2)


;The following two procedures are provided for each formula
(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))
(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
        (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))

;Show that each procedure gives a different answer when applied to the same intervals
;Make some intervals, A and B and use them in computer the expressions A/A and A/B
;You will get the most insight using intervals whose width is a small percentage of
;the center value.

;Examing the results of the cmoputation in center-percent form (Ex 2.12)

;A = [9.9, 10.1] -> Center 10, 1%
;B = [19.8, 20.2] -> Center 20, 1%

;Expect A/A = [1,1] 
;Expect A/B = [0.5,0.5]







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


;Takes in an interval i
(define (percent i)

  ;We can find the center using the already defined procedure
  ;% Diff = (Difference / Center) * 100
  (* 100 (/ (- (upper-bound i) (center i)) (center i))))

;Operations

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

(define (zero-span? y)
   (and (<= (lower-bound y) 0)
        (>= (upper-bound y) 0)))