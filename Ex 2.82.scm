#lang scheme


;Ex 2.82  Show how to generalize apply-generic to handle coercion in the general case of
;multiple arguments.

;One strategy is to attempt to coerce all the arguments to the type of the first
;argument, then to the type of the second argument, and so on.

;Coercion - Apply Generic, for two arguments
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc

          


(define (convert-args-list args)
  (if (null? args) '() ;Args list empty, null
      (let ((type1 (type-tag (car args))) ;Get type of first 
            (type2 (type-tag (cadr args))));and second argument
        (let ((t1->t2 (get-coercion type1 type2)));Find appropriate conversion procedure
          ;Join first element with the result of converting the rest of the list
          ;Note we convert the 2nd element (cadr) and join the rest of the list to it.
          (cons (car args) (convert-args-list (cons (t1->t2 (cadr args)) (cddr args))))))))
  
        
  



;Give an example of a situation where this strategy
;(and likewise the two-argument version given above) is not sufficiently general.

;(Hint: Consider the case where there are some suitable mixed-type
;operations present in the table that will;not be tried.)

