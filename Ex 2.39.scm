#lang scheme

;Exercise 2.39 Complete the two procedures to reverse a sequence, using both fold-right and fold-left

;operation passed to fold right works with two arguments, x y
;x is the car of the sequence
;y is the cdr of the sequence
;y is already a list, so need to apply list to x and append the two together
(define (reverse-r sequence)
  (fold-right (lambda (x y) (append y (list x))) null sequence))

;fold-left works as follows
;starting with result null, rest (1,2,3)
;(iter (op null 1) (2 3)
;(iter (op (op null 1) 2) (3)
;(iter (op (op (op null 1) 2) 3) ())
; -> (op (op (op () 1) 2) 3)

;op works with two arguments, result and rest
;starts with null and works backwards to start of list
;just need to swap arguments order to reverse

(define (reverse-l sequence)
  (fold-left (lambda (x y) (cons y x)) null sequence))

;Same as accumulate
(define (fold-right op initial sequence)
   (if (null? sequence)
       initial
       (op (car sequence)
           (fold-right op initial (cdr sequence)))))

;fold-left implementation (provided)
(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

;Testing
(define x (list 1 2 3))

;> (reverse-r x)
;(3 2 1)
;> (reverse-l x)
;(3 2 1)

