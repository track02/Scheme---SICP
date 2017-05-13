#lang scheme

;Ex 2.23 -> the procedure for each is similar to map
;it takes as arguments a procedure and a last
;for each then applies the procedure to each list element
;Give an implementation of for-each

(define (for-each list procedure)
  (cond [(null? list) #t] ;Return true -> do "nothing"
        [else (procedure (car list)) ;Otherwise apply procedure
              (for-each (cdr list) procedure)])) ;Move to next element

;Testing
;> (for-each (list 1 2 3) (lambda (x) (newline) (display (* x x))))
;1
;4
;9


   

