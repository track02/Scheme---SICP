#lang scheme

;Exercise 3.28: Define an or-gate as a primitive function
;box. Your or-gate constructor should be similar to andgate.

;or gate has two input signals a1, a2 and an output signal
(define (or-gate a1 a2 output)

  ;or-action-procedure - after a time delay determine new-value and
  ;set the output signal accordingly
  (define (or-action-procedure)

    ;Our new-value is equal to the logical-or of a1 / a2
    (let ((new-value
           (logical-or (get-signal a1) (get-signal a2))))
      ;After or-gate-delay execute the given procedure
      (after-delay
       or-gate-delay
       (lambda () (set-signal! output new-value)))))

  ;Add action associates the or-action-procedure with the input wire
  ;the procedure is run whenever the signal on the input wire changes
  (add-action! a1 or-action-procedure)
  (add-action! a2 or-action-procedure)
  'ok)

;logical-or
(define (logical-or s1 s2)
(cond ((= s1 1) 1) ;If s1 is 1 
      ((= s2 1) 1) ;If s2 is 1
      ((= s1 s2 0) 0) ;If both s1 and s2 are 0
      (else (error "Invalid Signal" s))))
