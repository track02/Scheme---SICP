#lang scheme

;Ex 2.17 - define a procedure last-pair that returns the
;list that contains only the last element of a given list

(define (last-pair list)
  (if (null? (cdr list)) ;Check if last element of list is null
             (car list)  ;Yes -> return the first element
             (last-pair (cdr list)))) ;Else process last element


; 1 |
;   V
;   2  |
;      V
;      3 |
;        V
;        4 X


;Testing
;> (define a (list 1 2 3 4))
;> (last-pair a)
;4