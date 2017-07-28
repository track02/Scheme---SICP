#lang scheme

;Ex 2.61  Give an implementation of adjoin-set using the ordered representation. By
;analogy with element-of-set? show how to take advantage of the ordering to produce a
;procedure that requires on the average about half as many steps as with the unordered representation.

;Adjoin-set takes an object and a set as arguments and returns a set that contains
;the elements of the original set and the adjoined element

;Initial implementation - unordered, needs to examine every element of the set
;as element to insert may already be present as the last element of the set

;(define (element-of-set? x set)
;  (cond ((null? set) false)
;        ((equal? x (car set)) true)
;        (else (element-of-set? x (cdr set)))))

;(define (adjoin-set x set)
;  (if (element-of-set? x set)
;      set
;      (cons x set)))

;If sets are ordered we can stop as soon as the current set element is bigger than
;the element we are comparing

;But we can no longer cons the element with the set - it must be placed in its correct location

(define (adjoin-set x set)
  (cond ((null? set) (cons x '())) ;null set - return a set with just x
        ((= x (car set)) set) ;x is found - return the set
        ((< x (car set)) (cons x set)) ;x is less than current value add x to the front
        ((> x (car set)) (cons (car set) ;x is bigger than current value - join current element
                               (adjoin-set x (cdr set)))))) ;to result of evaluating the next

;Testing
;> (adjoin-set 1 '())
;(1)
;> (adjoin-set 1 '(2 3 4 5))
;(1 2 3 4 5)
;> (adjoin-set 3 '(1 2 4 5))
;(1 2 3 4 5)
;> (adjoin-set 3 '(1 2 3))
