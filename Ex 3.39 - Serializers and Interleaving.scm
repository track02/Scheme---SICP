#lang scheme

; Ex 3.39 consider the parallel-execution of procedures below
; With the use of a serializer s, what are the possible values of x?

(define x 10)
(define s (make-serializer))
(parallel-execute
(lambda () (set! x ((s (lambda () (* x x)))))) ;P1
(s (lambda () (set! x (+ x 1))))) ;P2


; Interleaving Code
;P11 - Read two values of x
;P12 - Set value of x
;P2  - Read x, add 1 and set

; Possible values
; P11(10) P12(100) P2(100->101) = 101 
; P2(10->11) P11(11) P12(11->121) = 121
; P11(10) P2(10->11) P12(11->100) = 100


