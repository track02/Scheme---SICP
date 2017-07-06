#lang scheme

;Exercise 3.31: e internal procedure accept-action-procedure!
;defined in make-wire specifies that when a new action procedure
;is added to a wire, the procedure is immediately
;run.

;Explain why this initialization is necessary. In particular,
;trace through the half-adder example in the paragraphs
;above and say how the system’s response would differ if we
;had defined accept-action-procedure! as

(define (accept-action-procedure! proc)
  (set! action-procedures
        (cons proc action-procedures)))

;This initialisation is necessary because without it nothing would happen
;as after-delay adds any new action to the agenda

;E.g. when an inverter is added to a wire - invert input would be called
;This would in turn call after-delay which adds the action to the agenda
(define (inverter input output)
  (define (invert-input)
    (let ((new-value (logical-not (get-signal input))))
      (after-delay inverter-delay
                   (lambda () (set-signal! output new-value)))))
  (add-action! input invert-input) 'ok)
(define (logical-not s)
  (cond ((= s 0) 1)
        ((= s 1) 0)
        (else (error "Invalid signal" s))))

(define (after-delay delay action)
  (add-to-agenda! (+ delay (current-time the-agenda))
                  action
                  the-agenda))