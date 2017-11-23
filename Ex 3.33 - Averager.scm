#lang scheme

; Ex 3.33 - Using primitive multipler, adder and constant constraints, define
; a procedure averager that takes three connectors a,b and c as inputs
; and establishes the constraint that the value of c is the average of
; the values a and b.
;       ______            ______
; A -> |      |      /-> |      |
;      |  +   | ----/    |  *   | ---> C
; B -> |______|      /-> |______|
;                   /
;       CONST (0.5)/
;


(define (averager a b c)
  
  ;Define additional connectors
  (let ((add_result (make-connector))
       (half_constant (make-connector)))
        
    ;Set  constant
    (constant 0.5 half_constant)

    ;Buildup adder and multiplier
    (adder a b add_result)
    (multiplier add_result half_constant c)
    'ok))
