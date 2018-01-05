#lang scheme

; Exercise 3.40:
; Give all possible values of x that can result from executing:

(define x 10)
(parallel-execute (lambda () (set! x (* x x)))    ;P1
                  (lambda () (set! x (* x x x)))) ;P2


; Interleavable Code
; P11 - P1 reads value of first x
; P12 - P1 reads value of second x
; P13 - P1 sets result of multiplication
; P21 - P2 reads value of first x
; P22 - P2 reads value of second x
; P23 - P2 reads value of third x
; P24 - P2 sets result of multiplication

; Possible values


; P11(10) P12(10) P21(10) P22(10) P23(10) P24(1000) P13(100) = 100
; P21(10) P22(10) P23(10) P11(10) P12(10) P13(100) P24(1000) = 1000
; P21(10) P22(10) P23(10) P11(10) P24(1000) P12(10) P13(10,000) = 10,000
; P21(10) P11(10) P12(10) P13(100) P22(100) P23(100) P24(100,000) = 100,000
; P11(10) P12(10) P13(10) P21(100) P22(100) P23(100) P24(1,000,000) = 1,000,000

; Which of these possibilities remain
; if we instead use serialized procedures:
(define x 10)
(define s (make-serializer))
(parallel-execute (s (lambda () (set! x (* x x)))) ;P1
                  (s (lambda () (set! x (* x x x))))) ;P2

;Interleavable Code
;P1 - read two values of x, multiply and store
;P2 - read three values of x, multiply and store

;Possible values
;P1 (100) P2 (1,000,000) = 1,000,000
;P2 (1000) P1 (1,000,000) = 1,000,000