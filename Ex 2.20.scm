#lang scheme

;Complete the two implementations of square-list

;1)Square specific

(define (square-list items)
  (if (null? items)
      null
      (cons (* (car items) (car items)) (square-list (cdr items)))))

;> (square-list (list 1 2 3 4))
;(1 4 9 16


;2)General form using map

(define (square-list-map items)
  (map (lambda (x) (* x x)) items))

(define (map proc items)
  (if (null? items)
      null
      (cons (proc (car items))
            (map proc (cdr items)))))

;> (square-list-map (list 1 2 3 4))
;(1 4 9 16)