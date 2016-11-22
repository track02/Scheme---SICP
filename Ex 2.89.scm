#lang scheme


;Define procedures that implement the term-list representation for dense polynomial


;Representation of term lists
;The final task is to determine a sufficient representation for the term-lists
;In effect a term-list is a set of coefficients keyed by the order of the term.
;This means any methods for representing sets can be applied here.
;But because add-terms and mul-terms access term lists sequentially from highest to lowest
;Some kind of ordered list representation will be required.


;Polynomial density will need to be considered, a dense polynomial has nonzero coefficients
;in terms of most orders whilst a sparse polynomial has many zero terms

;Dense: x^5 + 2x^4 + 3x^2 - 2x - 5
;Sparse: x^100 + 2x^2 + 1

;The term list for dense polynomials are most efficiently represented as lists of the coefficients

;E.g. (1 2 0 3 -2 -5) would represent the dense polynomial above
;The order of each term is the length of the sublist beginning with that term's coefficient decremented by 1


;We'll need to alter the implementation of adjoin term and first term

;Adjoin term now needs to place a term in the correct position depending on coefficient/power
(define (adjoin-term term term-list)

;If order of term is greater than length of term list, create a list padded with zeros and append term-list
    (define (create-blanks term blanks)
    (if (= blanks 0)
        (cons term '())
        (cons term (create-blanks 0 (- blanks 1)))))
  


(define (the-empty-termlist) ’())

;If we leave terms in their current representation (coefficient order)
;All we need to alter are the term-list implementations for procedures
;that return terms, in order to reflect the change in structure

(define (first-term term-list) (make-term (car term-list) (- (length term-list) 1)))
(define (rest-terms term-list) (cdr term-list))

(define (empty-termlist? term-list) (null? term-list))

(define (make-term order coeff) (list order coeff))
(define (order term) (car term))
(define (coeff term) (cadr term))


