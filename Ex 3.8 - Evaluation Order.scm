#lang scheme

;Exercise 3.8
;When we defined the evaluation model in Section 1.1.3,
;we said that the first step in evaluating an expression is to evaluate its subexpressions.

;But we never specified the order in which the subexpressions should be
;evaluated (e.g., le to right or right to le).

;When we introduce assignment, the order in which the arguments to a
;procedure are evaluated can make a difference to the result.

;Define a simple procedure f such that evaluating:

;(+ (f 0) (f 1))

;will return 0 if the arguments to + are evaluated from le to
;right but will return 1 if the arguments are evaluated from
;right to le.

;(+ (f 0) (f 1)) -> 0
;(+ (f 1) (f 0)) -> 1

;If the previous call accepted a zero as an argument, return 0 the next time

(define f ;Note f is not a procedure - instead, bind f to the result of following evaluation
  (let ((previous 1)) ;Local variable used to hold previous argument
    (lambda (x) 
      (if (eq? previous 0) ;If last argument was a 0
          (begin
            (set! previous x) ;Update previous
            0) ;Return 0, irregardless of x
          (begin ;Else
            (set! previous x) ;Update previous
            x))))) ;Return x
           
;Testing

;> (+ (f 0) (f 1))
;0
;> (+ (f 1) (f 0))
;1

;Because assignment is used we need to be more careful with how we evaluate
;Internal "state" of procedures may be different depending on when they're called