#lang scheme

;Ex 2.22 - Explain why the following procedure produces a list in reverse order

(define (square-list items)
  (define (iter things answer) ;takes in a list and an answer
    (if (null? things) ;If list is null
        answer ;return answer
        (iter (cdr things)  ;re-iterate over cdr of current list
              (cons (square (car things)) ;update answer as car^2 paired with answer
                    answer))))
  (iter items null))


;Problem lies when updating the answer, newest value is being added
;to the front of the list rather than the back
;Example list 1 2 3

; iter -> (1,2,3,()) ()
; iter -> (2,3,()) (1,())
; iter -> (3,()) (4, 1, ())
; iter -> () (9,4,1,())
; -> (9,4,1,())

(define (square x)
  ( * x x))

;The following fix is made but it doesn't help either - explain why

(define (square-list-fix items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square (car things))))))
  (iter items null))

;Example list (1,2,3)

;Here the problem is caused by pairing
;with null as the first argument

;(cons 1 null) -> (1)
;(cons null 1) -> ((), 1)

;Null is treated as an empty list
;resulting in list,integer pairings


;iter -> (1,2,3,()) ()
;iter -> (2,3,()) ((), 1)
;iter -> (3,()) (((),1), 4)
;iter -> () ((((),1), 4), 9)
;((((),1),4),9)
