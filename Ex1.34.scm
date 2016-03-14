#lang scheme

;Ex 1.34 - What happens if the interpreter is asked to evaluate the
;combinations of (f f), where:

(define (f g)
  (g 2))

;If we submit the combination of (f f)
;(f f)
;(f 2)
;(2 2)
;Resulting in an error -> 2 is not a valid procedure

;Output:
;application: not a procedure;
;expected a procedure that can be applied to arguments
;given: 2
;arguments...: