; Exercise 3.53:

; Without running the program, describe the
; elements of the stream defined by

(define s (cons-stream 1 (add-streams s s)))

(define (add-streams s1 s2) (stream-map + s1 s2))

; At any point enough of s has been generated for it to be fed back into add-streams

; add-streams returns result of adding car of s (initially 1)
; this result is the joined onto s [1, 2]
; the next call to add-streams moves to the cadr of s, which is now 2
; this process repeats infinitely, doubling the value each time

; [1, result of previous elements]
;  ^ add-streams
; [1, 2, result of adding previous elements]
;     ^ add-streams
; [1, 2, 4, result of adding previous elements]
;        ^ add-streams
