#lang scheme

;Ex 2.59 Write a procedure, Union that creates the union of two sets (unordered lists)

;Provided procedure, determines whether an item is an element of a set
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))


(define (union set-1 set-2)
  (cond [(and (null? set-1) (null? set-2)) '()] ;Both sets empty - return empty set
        [(null? set-1) set-2] ;Set-1 empty, return set-2
        [(null? set-2) set-1] ;Set-2 empty, return set-1
        [(element-of-set? (car set-2) set-1) (union set-1 (cdr set-2))] ;If the current element already exists in set-1, move on to next element
        [else (union (cons (car set-2) set-1) (cdr set-2))])) ;Otherwise element is not in set-1, add it to set-1 and move to next element

;Testing
;> (union '(1 2 3) '(4 5 6))
;(6 5 4 1 2 3)
;> (union '() '(1 2 3))
;(1 2 3)
;> (union '(1 2 3) '())
;(1 2 3)
;> (union '(1 2 3) '(1 2 3))
;(1 2 3)
;> (union '(1 2 3) '(4 5 1))
;(5 4 1 2 3)