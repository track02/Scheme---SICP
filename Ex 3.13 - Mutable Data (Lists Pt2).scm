#lang scheme


;Exercise 3.13: Consider the following make-cycle procedure,
;which uses the last-pair procedure defined in Exercise 3.12:

;Returns last pair of a list
(define (last-pair x)
  (if (null? (cdr x)) x (last-pair (cdr x))))


(define (make-cycle x)
  ;Replaces cdr of first argument with the second argument
  (set-cdr! (last-pair x) x)
  x)

;Draw a box-and-pointer diagram that shows the structure z created by:

(define z (make-cycle (list 'a 'b 'c)))


;Update the final pair of the list to point to the list
;Creating a cyclical structure


;          a        b        c       
;          |        |        |        
; z ----> [x][x]-->[x][x]-->[x][x]]
;          ^                    |
;          |                    |
;          \--------------------/

;What happens if we try to compute (last-pair z)?

;There is no null element we've created a cyclical structure.
;The procedure would repeatedly evaluate
