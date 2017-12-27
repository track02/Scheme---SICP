#lang racket

(define (twoSquareSum a b c)

  (cond ((and (< a b) (< a c)) (+ (* b b) (* c c)))
        ((and (< b a) (< b c)) (+ (* a a) (* c c)))
        ((and (< c a) (< c b)) (+ (* a a) (* b b)))))

(twoSquareSum 2 3 1)
