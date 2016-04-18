#lang scheme

;Ex 2.11 when multiplying two intervals it is possible to take note of the
;signs of the upper / lower values and devise 9 possible cases
;Only one of these cases will require the standard multiplication procedure to be applied
;(Min / Max checking)

;Rewrite the multiplication procedure to check for these cases


;Cases - possible combinations of signs
;Remember structure of interval (low,high)
;Have the following possible signs:

;[+ +]
;[- -]
;[- +]

;Combinations = 9 (3!)

;For each combination the resulting product is equal to
;MIN -> ac, ad, bc, bd
;MAX -> ac, ad, bc, bd

;  X       Y
; a b     c d
;[+ +] * [+ +] -> [ac db]
;[+ +] * [- -] -> [bc ad]
;[+ +] * [- +] -> [bc bd]

;[- -] * [+ +] -> [ad bc]
;[- -] * [- -] -> [bd ac]
;[- -] * [- +] -> [ad ac]

;[- +] * [+ +] -> [ad bd]
;[- +] * [- -] -> [bc ac]
;[- +] * [- +] -> [MIN(bc ad) MAX(ac bd)

(define (mul-interval x y)
  (let ((a (lower-bound x))
        (b (upper-bound x))
        (c (lower-bound y))
        (d (upper-bound y)))
        (cond
          ;[+ +] * [+ +] -> [ac db]
          [(and (>= a 0) (>= b 0) (>= c 0) (>= d 0))  (make-interval (* a c) (* d b))]
          ;[+ +] * [- -] -> [bc ad]
          [(and (>= a 0) (>= b 0) (< c 0)  (< d 0))   (make-interval (* b c) (* a d))]
          ;[+ +] * [- +] -> [bc bd]
          [(and (>= a 0) (>= b 0) (< c 0)  (>= d 0))  (make-interval (* b c) (* b d))]
          ;[- -] * [+ +] -> [ad bc]
          [(and (< a 0)  (< b 0)  (>= c 0) (>= d 0))  (make-interval (* a d) (* b c))]
          ;[- -] * [- -] -> [bd ac]
          [(and (< a 0) (< b 0)   (< c 0)  (< d 0))   (make-interval (* b d) (* a c))]
          ;[- -] * [- +] -> [ad ac]
          [(and (< a 0)  (< b 0)  (< c 0)  (>= d 0))  (make-interval (* a d) (* a c))]
          ;[- +] * [+ +] -> [ad bd]
          [(and (< a 0)  (>= b 0) (>= c 0) (>= d 0))  (make-interval (* a d) (* b d))]
          ;[- +] * [- -] -> [bc ac]
          [(and (< a 0)  (>= b 0)  (< c 0)  (< d 0))  (make-interval (* b c) (* a c))]
          ;[- +] * [- +] -> [MIN(bc ad) MAX(ac bd)
          [(and (< a 0) (>= b 0) (< c 0) (>= d 0))    (make-interval (min (* b c) (* a d)) 
                                                                     (max (* a c) (* b d)))])))


;Interval constructor / selectors
(define (make-interval a b) (cons a b))

(define (upper-bound i)
  (cdr i))

(define (lower-bound i)
  (car i))