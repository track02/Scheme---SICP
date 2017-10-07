#lang scheme

;Exercise 2.75.  Implement the constructor make-from-mag-ang
;in message-passing style. This procedure should be analogous to the make-from-real-imag procedure

;Message passing decomposes the operations table into columns - instead of using 'intelligent operations'
;that dispatch on data types we instead work with 'intelligent data objects'

;These objects dispatch on operations, this can be achieved by arranging things so that a data
;object such as a rectangular number is represented as a procedure that takes as input
;the required operation name and performs the operation indicated

;make-from-real-imag could be written as

;Creates an intelligent data object which represents a complex number
;Created using a real and imaginary component
(define (make-from-real-imag x y) 
  (define (dispatch op) ;Operation dispatch / contained operations
    (cond ((eq? op 'real-part) x) 
          ((eq? op 'imag-part) y) 
          ((eq? op 'magnitude) 
           (sqrt (+ (square x) (square y))))
          ((eq? op 'angle) (atan y x))
          (else
           (error "Unknown op -- MAKE-FROM-REAL-IMAG" op))))
  dispatch)

(define (square x)
  (* x x))

;Basically we create data objects can be asked (by passing the correct message) to perform certain operations

(define (make-from-mag-ang m a)
  (define (dispatch op)
    (cond ((eq? op 'real-part) (* m (cos a)))
          ((eq? op 'imag-part) (* m (sin a)))
          ((eq? op 'magnitude) m)
          ((eq? op 'angle) a)
           (else
           (error "Unknown op -- MAKE-FROM-MAG-ANG" op))))
  dispatch)