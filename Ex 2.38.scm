#lang scheme

;Exercise 2.38   The accumulate procedure is also known as fold-right, because it combines
;the first element of the sequence with the result of combining all the elements to the right. There is
;also a fold-left, which is similar to fold-right, except that it combines elements working in the opposite direction:

;Same as accumulate
(define (fold-right op initial sequence)
   (if (null? sequence)
       initial
       (op (car sequence)
           (fold-right op initial (cdr sequence)))))

;fold-left implementation (provided)
(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

; What are the values of 
;(fold-right / 1 (list 1 2 3)) -> -> 1.5
;(fold-left / 1 (list 1 2 3)) -> 1/6
;(fold-right list nil (list 1 2 3)) -> (list 1 (list 2 (list 3 null))) -> (1 (2 (3 ())))
;(fold-left list nil (list 1 2 3)) -> (list (list (list null 1) 2) 3)

;What's a property that op should statisfy in order to guarantee that fold-right / fold-left will produce
;the same values for any sequence

;Any operator that is not argument dependent will produce the same results
;e.g. a + b = b + a or a * b = b * a
;This property is known as commutativity
