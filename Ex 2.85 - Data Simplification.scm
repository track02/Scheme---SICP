#lang scheme

;Exercise 2.85.

;This section mentioned a method for ‘‘simplifying’’ a data object
;by lowering it in the tower of types as far as possible.

;Design a procedure drop  that accomplishes this for the tower described in exercise 2.83

;The key is to decide, in some general way, whether an object can be
;lowered. For example, the complex number 1.5 + 0i can be lowered as far as real

;The complex number 1 + 0i  can be lowered as far as integer

;The complex number 2 + 3i cannot be lowered at all.

;Here is a plan for determining whether an object can be lowered:
;Begin by defining a generic operation project  that ‘‘pushes’’ an object down in the tower.
;For example, projecting a complex number would involve throwing away the imaginary part.

;Then a number can be dropped if, when we project it and raise
;the result back to the type we started with, we end up with something equal
;to what we started with.

;Show how to implement this idea in detail, by writing a drop procedure that
;drops an object as far as possible.

;You will need to design the various projection operations and install project
;as a generic operation in the system.

;You will also need to make use of a generic equality predicate, such as described in 
;exercise 2.79.

;Finally, use drop to rewrite apply-genericfrom exercise 2.84 so that it ‘‘simplifies’’ its answers.


;Start with out generic project procedure which will push a given value down in the tower
(define (project x) (apply-generic 'project x))


;Drop procedure, drops a value as far down the tower as possible
(define (drop x)
  ;Stop if we reach the bottom of the tower
  (if (= (level x) 0)
      x
      ;Otherwise try lowering x down a level
      (let ((proj (project z)))
        ;If we can successfully raise proj back to x, continue drop
        (if (eq? x (raise proj))
            (drop proj)
            ;Else stop here
            x))))



;For each package we  need a project operation for apply-generic to find
;Complex->Real
(define (complex->real x)
  (make-real (real-part x)))

;Real->Rational
;Real numbers can be integer, rational or irrational
(define (real->rational x)
  (let ((exact (inexact->exact x))) ;Convert to an exact value
    (cond ((integer? exact) (make-rational exact 1)) ;Integer, x/1
          ;If the real can be expressed as a rational number, extract the numerator and denominator
          ((rational? exact) (make-rational (numerator exact) (denominator exact)))
          ;Otherwise, truncate x and return x/1
          (else (make-rational (truncate exact) 1)))))

;Rational->Integer
(define (rational->integer x)
  ;Divide numer by denom and truncate result
  (make-integer (truncate (/ (numerator x) (denominator x)))))

;Add each package operation to the table upon install
;...
(put 'project '(complex) complex->real)
(put 'project '(real) real->rational)
(put 'project '(rational) rational->integer)


;Using the level procedure defined in previous exercise
(define (level arg)
  (cond ((= (type-tag arg) 'integer) 0)
        ((= (type-tag arg) 'rational) 1)
        ((= (type-tag arg) 'real) 2)
((= (type-tag arg) 'complex 3))))


;Apply-generic
;Note - Commented solution from Schemewiki, not my own implementation
  (define (apply-generic op . args)

    ;Iterates over args list and comes back with the highest level type
    (define (higher-type types) 
      (define (iter x types)
        (cond ((null? types) x) 
              ((> (level x) (level (car types))) 
               (iter x (cdr types))) 
              (else  
               (iter (car types) (cdr types))))) 
      (if (null? (cdr types))
          (car types)
          (iter (car types) (cdr types))))

    ;Iterates over args list and raises each arg to specified level
    (define (raise-args args level-high-type) 
      (define (iter-raise arg level-high-type) 
        (if (< (level (type-tag arg)) level-high-type) ;If less than specified
            (iter-raise (raise arg) level-high-type)  ;Iteratively raise
            arg)) ;Else already at required level
      (map (lambda (arg) (iter-raise arg level-high-type)) args)) ;Map rais-args to a list 

    ;Checks types of arg list
    (define (not-all-same-type? lst) 
      (define (loop lst) 
        (cond ((null? lst) #f) 
              ((eq? #f (car lst)) #t) 
              (else (loop (cdr lst))))) 
      (loop (map (lambda (x) (eq? (car lst) x)) 
                 (cdr lst))))
    
    ;Extracts type tags
    (let ((type-tags (map type-tag args)))

      ;Get procedure
      (let ((proc (get op type-tags)))

        ;If valid procedure found
        (if proc
            ;Store result
            (let ((res (apply proc (map contents args))))

              ;If operation is a raise or equal
              (if (or (eq? op 'raise) (eq? op 'equ?))
                  res ;Return result (T/F)
                  (drop res))) ;Otherwise drop result to simplify

            ;Else If tags differ
            (if (not-all-same-type? type-tags)
                ;Find highest level tag
                (let ((high-type (higher-type type-tags)))
                  ;Raise arguments
                  (let ((raised-args (raise-args args (level high-type))))
                    ;Call apply-generic again
                    (apply apply-generic (cons op raised-args)))) 
                (error  
                 "No Method for these types -- APPLY-GENERIC" 
                 (list op type-tags))))))) 