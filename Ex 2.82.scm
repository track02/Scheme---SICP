#lang scheme

;Needs reviewing - Cannot be run, code is missing - assumed to be introduced later in the book


;Ex 2.82  Show how to generalize apply-generic to handle coercion in the general case of
;multiple arguments.

;One strategy is to attempt to coerce all the arguments to the type of the first
;argument, then to the type of the second argument, and so on.

;Coercion - Apply Generic, for multiple arguments
(define (apply-generic op . args)

(define (convert-args-list arg-list conv-type) ;Pass in conversion type 
  (if (null? args) '() ;Args list empty, null
      (let ((type (type-tag (car arg-list)))) ;Get the type of the first item
        (let ((t1->t2 (get-coercion type conv-typ))) ;Get the conversion procedure to change types
          (if t1->t2 ;If valid
              (cons (t1->t2 (car arg-list)) (convert-args-list (cdr arg-list) conv-type)) ;Convert rest of the list
              (cons (car arg-list) (convert-args-list (cdr arg-list) conv-type))))))) ;Otherwise leave this arg and move to next
  
(define (apply-converted arg-list)
     (if (null? arg-list) ;No arguments 
       (error "No method for given arguments") 
       (let ((converted-list (convert-args-list args (type-tag (car arg-list))))) ;Convert arguments to type of first list element
         (let ((proc (get op (map type-tag coerced-list)))) ;Lookup available procedures for converted set
           (if proc 
             (apply proc (map contents coerced-list))  ;If something is found - apply it
             (apply-converted (cdr arg-list)))))))  ;Otherwise try again with second list element
             ;Note scope usage here -> convert-args-list takes in original arg list, not the shortened cdr arg-list each time
             ;cdr arg-list is only used to retrieve type information
             ;proc is applied to coerced-list which is built from the original args list.
  
  (let ((type-tags (map type-tag args))) ;Create a list of argument types
    (let ((proc (get op type-tags))) ;Retrieve the procedure which applies to the argument types
      (if proc ;If something is found for this combination of types apply the procedur
          (apply proc (map contents args))
          ;Otherwise try converting the arguments and applying the procedure
          (apply-converted args)))))



         
;Give an example of a situation where this strategy
;(and likewise the two-argument version given above) is not sufficiently general.

;(Hint: Consider the case where there are some suitable mixed-type
;operations present in the table that will;not be tried.)

;This procedure only converts the parameters to types that are present in the list - a more suitable
;procedure may be available but would require the values to be converted to a type not present in the
;argument list.

