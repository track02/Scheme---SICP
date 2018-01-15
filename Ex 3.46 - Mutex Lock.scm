#lang scheme

; Exercise 3.46: Suppose that we implement test-and-set!
; using an ordinary procedure as shown in the text, without
; attempting to make the operation atomic.

(define (test-and-set! cell)
  (without-interrupts
   (lambda ()
     (if (car cell)
         true
         (begin (set-car! cell true)
                false)))))

; Draw a timing diagram like the one in Figure 3.29 to demonstrate how the
; mutex implementation can fail by allowing two processes
; to acquire the mutex at the same time.

; Two processes A and B
; If both processes acquire the mutex simultaneously
; Cell is set to true and the mutex is locked but both processes execute
; As each process completes, they then both set the cell back to true as it is released

;   A                    B
;   |                    |
; (Cell=F)             (Cell=F)
;   |                    |
; Test/Set--(Cell=T)     |
;   |       (Cell=T)-- Test/Set
;   |                    |
;   |                    |
;   |                    |
;   |       (Cell=F)----Release
; Release---(Cell=F)