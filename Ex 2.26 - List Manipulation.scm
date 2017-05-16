#lang scheme

;Ex 2.26 using the following definitions

(define x (list 1 2 3))
(define y (list 4 5 6))

;What will be the result of the following expressions

;(append x y)
;List y will be added to the end of list x
;(1 2 3 4 5 6)
;>(1 2 3 4 5 6)

;(cons x y)
;cons creates a list with x as the first element and y as the second
;((1 2 3) 4 5 6)
;>((1 2 3) 4 5 6)

;(list x y)
;list will create a new list with elements x y
;((1 2 3) (4 5 6))
;>((1 2 3) (4 5 6))
