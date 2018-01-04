#lang scheme

; Ex 3.39 consider the parallel-execution of procedures below
; With the use of a serializer s, what are the possible values of x?

(define x 10)
(define s (make-serializer))
(parallel-execute
(lambda () (set! x ((s (lambda () (* x x))))))
(s (lambda () (set! x (+ x 1)))))

; Atomic / Serial Procedures - no interleaving may occur during their execution
; [S +] = [set! x [+ x 1]]
; [*] = [* x x] 
; Non-Serial Procedures
; (S) = (set! x ...)

; This results in three possible combinations
; Interleaving is possible between the Set operation not enclosed in a serializer
; (S [S +] [*]) -> 100
; [S +] (S [*]) -> 121
; (S [*]) [S +] -> 101

