#lang scheme

;Ex 2.60, sets have previously been represented as a list without duplicates, suppose we allow duplicates
;for examples, {1,2,3} could be represented as the list (2 3 2 1 3 2 2)

;Design the following procedures that operate on the representation

;element-of-set?
(define (element-of-set? x set)
  (cond [(null? set) #f]
        [(null? (car set)) #f]
        [(= x (car set)) #t]
        [else (element-of-set? x (cdr set))]))

;Testing
;> (element-of-set? 1 '(2 3 4 5 1 3))
;#t
;> (element-of-set? 2 '(3 4 5 6 1 4 5 6))
;#f

;adjoin-set

;union-set