#lang scheme

;Exercise 3.29: Another way to construct an or-gate is as
;a compound digital logic device, built from and-gates and
;inverters. Define a procedure or-gate that accomplishes this

; We can make an or-gate by observing the following
;
; A B AND
; 0 0  0
; 0 1  0
; 1 0  0
; 1 1  1

; !A !B AND
; 0  0  1
; 0  1  0
; 1  0  0
; 1  1  0

; !A !B !AND
; 0  0  0
; 0  1  1
; 1  0  1
; 1  1  1

;So we need to take the inverse of our two input wires A / B
;Pass the output to an and procedure then invert the result

; Need to build the or-gate out of existing and-gate and inverter
;Our or-gate takes in two inputs and output wire
(define (or-gate a1 a2 output)

  ;We'll need to create two wires to read the output from inverting a1/a2
  ;And a third wire to hold the result of the and-gate
  ((let ((inv-a1 (make-wire))
         (inv-a2 (make-wire))
         (and-result (make-wire)))
     (inverter a1 inv-a1) ;Invert a1
     (inverter a2 inv-a2) ;Invert a2
     (and-gate inv-a1 inv-a2 and-result) ;Take the and
     (inverter and-result output))) ;invert the result and set output wire

  ;The total delay will be that of 3 inverters and 1 and-gate