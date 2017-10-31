#lang scheme

;2.88 -   Extend the polynomial system to include subtraction of polynomials. (Hint: You may
;find it helpful to define a generic negation operation.) 

;We can treat subtraction as the addition of a negated polynomial

;We'll need to define a generic negate procedure

(define (negate x)
  (apply-generic 'negate x))

;And the type specific implementations
;....



(define (sub-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2)) ;If both polys have the same variable
      (make-poly (variable p1) ;Make a new poly with that variable
                 (add-terms (term-list p1) ;And add term list of p1
                            ((negate  p2)))) ;To negated p2
      (error "Polys not in same var -- ADD-POLY" ;Else return an error
             (list p1 p2))))


(define (add-poly p1 p2)
  (if (same-variable? (variable p1) (variable p2)) ;If both polys have the same variable
      (make-poly (variable p1) ;Make a new poly with that variable
                 (add-terms (term-list p1) ;And the sum of the two term lists
                            (term-list p2)))
      (error "Polys not in same var -- ADD-POLY" ;Else return an error
             (list p1 p2))))



(define (mul-poly p1 p2)
  (if (same-variable? (variable p1) (variable p2)) 
      (make-poly (variable p1) ;Same as add, make a new poly with the variable
                 (mul-terms (term-list p1) ;But this time multiply the term lists
                            (term-list p2)))
      (error "Polys not in same var -- MUL-POLY"
             (list p1 p2))))



define (install-polynomial-package)
;; internal procedures
;; representation of poly
  (define (make-poly variable term-list)
    (cons variable term-list))
  (define (variable p) (car p))
  (define (term-list p) (cdr p))
  <procedures same-variable? and variable? from section 2.3.2>
;; representation of terms and term lists
  <procedures adjoin-term ...coeff from text below>
;; continued on next page
  (define (add-poly p1 p2) ...)
  <procedures used by add-poly>
  (define (mul-poly p1 p2) ...)
  <procedures used by mul-poly>
;; interface to rest of the system

;;Negate a polynomial, make a new polynomial with the same variable but negate the terms
(define (negate-poly p)
  (make-poly (variable p) (negate-terms (term-list p))))




  (define (tag p) (attach-tag ’polynomial p))
  (put ’add ’(polynomial polynomial) 
       (lambda (p1 p2) (tag (add-poly p1 p2))))
  (put ’mul ’(polynomial polynomial) 
       (lambda (p1 p2) (tag (mul-poly p1 p2))))
  (put ’make ’polynomial
       (lambda (var terms) (tag (make-poly var terms))))
  (put 'negate 'polynomial (lambda (poly) (make-poly poly)))
  ’done)


;Polynomial addition is performed termwise, terms of the same order (those with the same power of the indeterminate)
;must be combined together.
;This is achieved by a forming a new term of the same order whose coefficient is the sum of the coefficients of the addends

;Terms in one addends for which there are no terms of the same oder in the other addend
;are simply accumulated into the sum polynomial being constructed

;To manipulate term lists we assume the following constructors exist
;the-empty-termlist which returns an empty-termlist
;adjoin-term  that adjoins a new term to the term list
;make-term which constructs a term with a given order and coefficient

;We assume a predicate empty-termlist? exists which returns true if a given term list is empty

;We also assume the following selectors are present
;first-term which returns the highest-order term from a term list
;rest-terms that returns all but the highest-order term
;order returns the order of a term
;coeff returns the coefficient of a term


;add-terms procedure constructs the term list for the sum of two polys
;Note that the generic add procedure is used to add together coefficients rather than the primitive + operator


(define (add-terms L1 L2)
  (cond ((empty-termlist? L1) L2) ;If either poly has an empty term-list return the other
        ((empty-termlist? L2) L1)
        (else
         (let ((t1 (first-term L1)) (t2 (first-term L2))) ;Retrieve the highest order term
           (cond ((> (order t1) (order t2)) ;If t1 has the greater order (not equal)
                  (adjoin-term ;Add t1 to the term list and the result of adding the rest of L1 to L2
                   t1 (add-terms (rest-terms L1) L2)))
                 ((< (order t1) (order t2)) ;If t2 has the greater order
                  (adjoin-term ;Add t2 to the term list and the result of adding the rest of L2 to L1
                   t2 (add-terms L1 (rest-terms L2))))
                 (else ;Otherwise the two terms have equal order
                  (adjoin-term ;Add to the term list 
                   (make-term (order t1) ;A new term with the order of t1 and the coeff of t1 + t2
                              (add (coeff t1) (coeff t2)))
                   (add-terms (rest-terms L1) ;and the result of adding the remaining terms of l1 / l2
                              (rest-terms L2)))))))))


;In order to multiply two term lists we multiply each term of the first list by all the terms of the other list
;repeatedly using mul-term-by-all-terms which multiplies a given term by all terms in a given list

;The resulting term lists (one for each term of the first list) are accumulated into a sum.
;Multiplying two terms forms a term whose order is the sum of the orders of the factors and whose coefficient is the
;product of the coefficients of the factors.


;Negates an individual term
(define (negate-term t)
  (make-term (order t)
             (negate (coeff t)))) ;Apply generic negate procedure to the coefficient of the term
  

;Iteratively negate a term list
(define (negate-terms l) ;Takes in an input termlist l
  
  (define (negate-termlist tl nl) ;Inner procedure, handles termlist tl and a new list nl
    (if (empty-termlist tl) nl ;If tl is empty then return nl
        ;Otherwise negate the first element of tl and adjoin it to nl, call negate-termlist again for rest of tl
        (negate-termlist (rest-terms tl) (adjoin-term (negate-term (first-term tl)) nl))))

  ;Start procedure using input termlist and an empty list
  (negate-termlist l (the-empty-termlist)))
  

;Multiplies two term lists
(define (mul-terms L1 L2)
  (if (empty-termlist? L1)
      (the-empty-termlist)
      (add-terms (mul-term-by-all-terms (first-term L1) L2)
                 (mul-terms (rest-terms L1) L2))))

;Multiplies a single term with a term-list
(define (mul-term-by-all-terms t1 L)
  (if (empty-termlist? L)
      (the-empty-termlist)
      (let ((t2 (first-term L)))
        (adjoin-term
         (make-term (+ (order t1) (order t2))
                    (mul (coeff t1) (coeff t2)))
         (mul-term-by-all-terms t1 (rest-terms L))))))


(define (adjoin-term term term-list)
  (if (=zero? (coeff term))
      term-list
      (cons term term-list)))
  
(define (the-empty-termlist) ’())
(define (first-term term-list) (car term-list))
(define (rest-terms term-list) (cdr term-list))
(define (empty-termlist? term-list) (null? term-list))
(define (make-term order coeff) (list order coeff))
(define (order term) (car term))
(define (coeff term) (cadr term))


;Tagged polynomials can be created with the following procedure
(define (make-polynomial var terms)
  ((get ’make ’polynomial) var terms))


;Install =zero?
;for polynomials in the generic arithmetic package. This will allow 
;adjoin-term to work for polynomials with coefficients that are themselves polynomials. 

(define (poly-zero? pol)
  (empty-termlist? (term-list pol)))

(put '=zero? '(polynomial) (lambda (x) (poly-zero? x))) ;If a polynomial has no terms, we can say its 0
