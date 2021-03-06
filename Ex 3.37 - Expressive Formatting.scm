#lang scheme

; Exercise 3.37.  The celsius-fahrenheit-converter procedure is cumbersome
; when compared with a more expression-oriented style of definition, such as
;
;     (define (celsius-fahrenheit-converter x)
;       (c+ (c* (c/ (cv 9) (cv 5))
;               x)
;           (cv 32)))
;     (define C (make-connector))
;     (define F (celsius-fahrenheit-converter C))
;
; Here c+, c*, etc. are the ``constraint'' versions of the arithmetic
; operations. For example, c+ takes two connectors as arguments and returns
; a connector that is related to these by an adder constraint:
;
;     (define (c+ x y)
;       (let ((z (make-connector)))
;         (adder x y z)
;         z))
;
; Define analogous procedures c-, c*, c/, and cv (constant value) that enable
; us to define compound constraints as in the converter example above. [33]

(define (c- x y)
  (let ((z (make-connector)))
    ; We can subtract by rearranging the subtraction to an addition
    ; x + y = z
    ; x - y = z
    ; z + y = x
    (adder z y x)
    z))

(define (c* x y)
  (let ((z (make-connector)))
    (multiplier x y z)
    z))

(define (c/ x y)
  (let ((z (make-connector)))
    ; In a simlar fashion, we can do the same for division with a multiplier
    ; x * y = z
    ; x / y = z
    ; z * y = x
    (multiplier z y x)
    z))

(define (cv c)
  (let ((z (make-connector)))
    (z 'set-value! c 'constant-value)))