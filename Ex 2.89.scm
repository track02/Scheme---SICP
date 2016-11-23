#lang scheme


;Ex 2.89 Define procedures that implement the term-list representation for dense polynomial


;Dense: x^5 + 2x^4 + 3x^2 - 2x - 5
;The term list for dense polynomials are most efficiently represented as lists of the coefficients

;E.g. (1 2 0 3 -2 -5) would represent the dense polynomial above
;The order of each term is the length of the sublist beginning with that term's coefficient decremented by 1


;We'll need to alter the implementation of adjoin term and first term

;Adjoin term now needs to place a term in the correct position depending on coefficient/power
(define (adjoin-term term term-list)
  (if (> (term-order term) (length term-list))
      ;If order of term is greater than length of term list, create a list padded with zeros and append term-list
      (append (create-zeroes (term-coefficient term) (- (term-order term) (length term-list))) term-list)
      ;Else update term list by adding coefficient to correct position
      (update-coeff '() (term-coefficient term) term-list (- (-(length term-list) 1) (term-order term)))))


(define (create-zeroes value zerocount)
  (if (= zerocount 0)
      (cons value '())
      (cons value (create-zeroes 0 (- zerocount 1)))))

(define (update-coeff prev-elements value next-elements i)
  (if (= 0 i)
      (append prev-elements (list (+ value (car next-elements))) (cdr next-elements))
      (update-coeff (append prev-elements (list (car next-elements))) value (cdr next-elements) (- i 1))))
      
  
(define test-terms '(3 0 1))   ;3x^2 + 1
(define test-term-1 '(1 2))    ;x^2
(define test-term-2 '(5 5))  ;5x^5
(define test-term-3 '(10 0)) ;10

;Testing
;> (adjoin-term test-term-1 test-terms)
;(4 0 1)
;> (adjoin-term test-term-2 test-terms)
;(5 0 0 3 0 1)
;> (adjoin-term test-term-3 test-terms)
;(3 0 11)

(define (the-empty-termlist) '())

;If we leave terms in their current representation (coefficient order)
;All we need to alter are the term-list implementations for procedures
;that return terms, in order to reflect the change in structure

(define (first-term term-list) (make-term (car term-list) (- (length term-list) 1)))

;Testing
;> (first-term test-terms)
;(3 2)


(define (rest-terms term-list) (cdr term-list))

(define (make-term coefficient order)
  (list coefficient order))

(define (term-order term)
  (cadr term))

(define (term-coefficient term)
  (car term))