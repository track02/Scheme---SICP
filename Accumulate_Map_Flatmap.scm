#lang scheme

;Accumulate
;Applies the operation to the car of the sequence and the
;result of accumulate applied to the cdr of the list
;A(1 2 3)
;OP(1, A(2 3))
;      OP(2, A(3))
;            OP(3, A(NULL))
;                  NULL
;Example use is to sum up the elements of a list
(define (accumulate op initial sequence)
   (if (null? sequence)
       initial
       (op (car sequence)
           (accumulate op initial (cdr sequence)))))

;Map
;Applies an operation to the first element of a given list
;Then pairs (cons) this with the result of applying Map to the rest of the list
;M([+ 1], (1 2 3)
;CONS((+ 1 1) M(2 3)
;             CONS((+ 2 1) M(3))
;                          CONS((+ 3 1) M(NULL))
;                                       NULL
;CONS 2 CONS 3 CONS 4 CONS NULL -> (2, 3, 4)
;Example use is to transform a list by operating on each element
(define (map op sequence)
  (if (null? sequence)
      null
      (cons (op (car sequence))
            (map op (cdr sequence)))))


;Flatmap
;Combination of map and accumulate
;Basically "flattens" the result of a mapping
;((1,2,3), (4,5,6), (7,8,9)) -> (1,2,3,4,5,6,7,8,9)
;Firstly apply the operation to the sequence to retrieve the transformed seq
;Now appen each sequence element with the next using accumulate
;If the sequence is a list of sublists, then the result will be a flat list
;If list is a contains sublists with sublists then it will need to be flatmapped twice
(define (flatmap op sequence)
  (accumulate append null (map op sequence))) 


