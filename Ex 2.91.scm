#lang scheme

;Polynomial division can be performed as follows:

; Divide the highest order terms in the dividend and divisor
; Save this result
; Multiply the divisor by the result, name this value N
; Subtract N from the dividend
; Dividend - N becomes the new Dividend
; Repeat the process until the order of the divisor is greater than the dividend
; Assemble the results, the undivided dividend is the remainder

;E.g.
;
; x^5 - 1 / x^2 - 1 [Division to perform]
;
; x^5 / x^2 -> x^3 [Dividend order is greater, first result]
;
; x^3 (x^2 - 1) -> x^5 - x^3 [Divisor * 1st Result]
;
; x^5 - 1 - x^5 - x^3 -> -x^3 - 1 [New Divisor]
;
; -x^3 - 1 / x^2 - 1  [Division to perform]
;
; -x^3 / x^2 -> -x [Dividend order is greater, second result]
;
; -x (x^2 - 1) -> -x^3 + x [Divisor * 2nd Result]
;
; -x^3 -1 + x^3 +x -> x - 1 [New Dividend]
;
; x - 1 / x^2 - 1 [Division to Perform]
;
; x / x^2 [Divisor has greater order, stop]
;
; x^3 - x [Assemble results]
; x - 1 [Remainder is divisor]


;Ex 2.91 - Complete the following div-terms procedure
(define (div-terms L1 L2)
  (if (empty-termlist? L1)
      (list (the-empty-termlist) (the-empty-termlist))
      ;Extract Terms
      (let ((t1 (first-term L1)) 
            (t2 (first-term L2)))
        ;Check Order
        (if (> (order t2) (order t1))
            ;If Divisor bigger, return L1 as remainder (empty termlist identifies end of result?)
            (list (the-empty-termlist) L1)
            ;Else determine new result term elements, divide coefficients and subtract terms
            (let ((new-c (div (coeff t1) (coeff t2)))
                  (new-o (- (order t1) (order t2))))              
              (let ((rest-of-result
                     ;Dividend becomes result of (L1 - (Result * L2))
                     ;Divisor stays the same
                     (div-terms (sub-terms L1 (mul-terms L2 (list (make-term new-o new-c)))) L2)))

                ;Final result should be a list with two term-lists, the result of the division and the remainder
                ;Remainder is prefixed by an empty list which prevents it being adjoined into the result term-list
                ;Join current result with the next result (car)
                (list (adjoin-term                    
                       (make-term new-o new-c)
                       (car rest-of-result))
                      ;Add remaining results to end of list
                      (cadr rest-of-result))))))))


;Outline a div-poly method that makes use of div-terms
(define (div-poly p1 p2)
  ;Check poly variables match
  (if (same-variable> (variable p1) (variable p2))
      ;Store results of division
      (let ((div-result (div-terms (term-list p1) (term-list p2))))
        ;Return a list of two polynomials, the division result and the remainder
        (list (make-poly (variable p1) (car result)))
        (list (make-poly (variable p1) (cadr result))))
      ;Error if variables do not match
      (error "Polynomial variables are not the same")))
  
  