#lang scheme

;Give combinations of cars and cdrs
;that will pick 7 from each of the following lists:
;(1 3 (5 7) 9)
;((7))
;(1 (2 (3 (4 (5 (6 7))))))

(define a (list 1 3 (list 5 7) 9))
(define b (list (list 7)))
(define c (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))

;Note - cdr yields the _list_ without the first element
;     - car yields the first _element_ of the list

;> (car (cdr (car (cdr (cdr a)))))
;7

;> (car (car b))
;7

;> (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr c))))))))))))
;7
