#lang scheme

;Exercise 2.78.  The internal procedures in the scheme-number package are essentially nothing
;more than calls to the primitive procedures +, -, etc.

;It was not possible to use the primitives of the language directly because
;our type-tag system requires that each data object have a type attached to it.

;In fact, however, all Lisp implementations do have a type system, which they use internally.
;Primitive predicates such as symbol? and number? determine whether data objects have particular types.

;Modify the definitions of type-tag, contents, and attach-tag from section 
;2.4.2 so that our generic system takes advantage of Scheme’s internal type system.

;That is to say, the system should work as before except that
;ordinary numbers should be represented simply as Scheme numbers rather than as pairs
;whose car is the symbol scheme-number. 


;Number package
(define (install-scheme-number-package)
  (define (tag x)
    (attach-tag ’scheme-number x))    
  (put ’add ’(scheme-number scheme-number)
       (lambda (x y) (tag (+ x y))))
  (put ’sub ’(scheme-number scheme-number)
       (lambda (x y) (tag (- x y))))
  (put ’mul ’(scheme-number scheme-number)
       (lambda (x y) (tag (* x y))))
  (put ’div ’(scheme-number scheme-number)
       (lambda (x y) (tag (/ x y))))
  (put ’make ’scheme-number
       (lambda (x) (tag x)))
  ’done)

(define (add x y) (apply-generic ’add x y))
(define (sub x y) (apply-generic ’sub x y))
(define (mul x y) (apply-generic ’mul x y))
(define (div x y) (apply-generic ’div x y))

;Tag Definitions
(define (attach-tag type-tag contents)
  ;If the contents are not a primitive number add a tag
  (if (not (number? contents))
  (cons type-tag contents)
  ;Otherwise just pass back the contents
  contents))

(define (type-tag datum)
  (if (number? datum) ;If datum is just a number, not tag
      'scheme-number ;identify it as a 'scheme-number
      (if (pair? datum)
      (car datum)
      (error "Bad tagged datum -- TYPE-TAG" datum))))

(define (contents datum)
  (if (number? datum) ;If datum is just a number, no tag
      datum ;Return the number
      (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum -- CONTENTS" datum))))