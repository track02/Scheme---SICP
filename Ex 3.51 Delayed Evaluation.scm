; Exercise 3.51: In order to take a closer look at delayed evaluation,
; we will use the following procedure, which simply
; returns its argument aer printing it:

(define (show x)
  (display-line x)  
  x)

; What does the interpreter print in response to evaluating
; each expression in the following sequence?

; Whenever a stream object is evaluated the computed value is stored
; Subsequent forcings (cdr) will simply return the stored value and no repeat the computation

; Element 0-10 is mapped to a show function which closes over the value
; This function will only be evaluated when the object is accessed, printing the object and evaluating to it's value
(define x
  (stream-map show
              (stream-enumerate-interval 0 10)))

; First element of a stream is evaluated upon creation
; => 0

(stream-ref x 5)
; Already evaluated 0, so it's not printed again
; => 1
; => 2
; => 3
; => 4
; => 5

(stream-ref x 7)

; Already evaluated up to 5 so they're not printed again
; =>6
; =>7