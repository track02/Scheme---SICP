#lang scheme

;Ex 2.17 - define a procedure reverse that reverses the order of a given list
;(reverse (list 1 2 3 4)) - > (4 3 2 1)


;Reverses a given list
;Given a list append the cdr to the car after reversing the cdr
(define (reverse input)
  (if (null? input) ;If the list is null we can stop reversing 
      input ;and return the list
      (append (reverse (cdr input)) (list (car input))))) ;Add the reversed cdr to the car
  

  
;Provided list operators
(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))