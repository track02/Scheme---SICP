#lang scheme

;Exercise 3.6: It is useful to be able to reset a random-number
;generator to produce a sequence starting from a given value.

;Design a new rand procedure that is called with an argument
;that is either the symbol generate or the symbol
;reset and behaves as follows:

;(rand 'generate) produces a new random number
; ((rand 'reset) ⟨new-value ⟩) resets the internal state variable to the designated ⟨new-value ⟩.

;Thus, by resetting the state, one can generate repeatable sequences.
;These are very handy to have when testing and debugging programs that use random numbers.

(define (rand start-value)
  (let ((value start-value))
    (define (dispatch op)
      (cond ((eq? op 'reset) (lambda (x) (set! value x)))
            ((eq? op 'generate) (begin (set! value (rand-seq value))
                                       value))))
    dispatch))
      

;Basic sequence generator
(define (rand-seq value)
  (+ (* value (/ value 2)) 2))


;Testing

;> (define rng (rand 0))
;> (rng 'generate)
;2
;> (rng 'generate)
;4
;> ((rng 'reset) 12)
;> (rng 'generate)
;74
;> (rng 'generate)
;2740
;> ((rng 'reset) 0)
;> (rng 'generate)
;2
;> (rng 'generate)
;4
