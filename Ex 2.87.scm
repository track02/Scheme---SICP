#lang scheme

;2.5.3 Symbolic Algebra


;We cab view algebraic expressions as a hierarchical structure, a tree of operators applied to operands
;Algebraic expressions can be constructed using a set of primitives (constants / variables) and
;combining them via algebraic operators (addition, multiplication)

;We may also form abstractions allowing us to refer to compound objects in simple terms
;Typical symbolic algebra abstractions are ideas such as linear combinations, polynomials
;rational functions or trigonometric functions.

;We regard these as compound types which are useful for directing the processing of expressions

;x^2 * sin(y^2 + 1) + x * cos(2y) + cos(y^3 - 2y^2)

;We could describe the above expression as a polynomial (expression of multiple terms)
;in x with coefficients that are trigonometric functions of polynomials in y
;whose coefficients are integers.


;~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=


;Arithmetic on Polynomials

;First we need to decide what a polynomial is
;Usually polynomials are defined relative to certain variables (the indeterminates)
;For now we'll consider only polynomials with a single indeterminate, univariate polynomials

;We will define a polynomial to be a sum of terms, with each term being one of the following:
; a coefficient
; a power of the indeterminate
; a product of a coefficient and a power of indeterminate

;A coefficient is an algebraic expression not dependent upon the indeterminate of the polynomial

;5x^2 + 3x + 7

;Is a simple polynomial in x

;(y^2 + 1)x^3 + (3y)x + 1

;Is a polynomial in x whose coefficients are polynomials in y

;There are several issues that need to be reviewed,
;We may consider 5x^2 + 3x + 7 to be the same as 5y^2 + 3y + 7
;If we're considering polynomials to be purely mathematical functions (the indeterminate makes no difference)
;But if we consider polynomials as a syntactic form then the two are not equal.

;The second polynomial is algebraically equivalent to a polynomial in y whose coefficients are polynomials in x
;There are also different ways to represent a polynomial such as a product of factors or a set of roots.

;Our system will treat polynomials as a particular syntactic form rather than a pure mathematical functions
;For now we will only consider addition and multiplication and insist that two polynomials must have the
;same indeterminate in order to be combined

;Polynomials will be represented by a data structure called poly
;poly consists of a variable and a collection of terms
;we assume we have selectors variable and term-list that extract those parts from a poly
;a constructor is also assumed, make-poly that assembles a poly from a given variable and term list

;a variable will be a symbol and can be compared using the same-variable? procedure

;The following procedures define addition and multiplication of polys

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


;We can also incorporate polynomials into our generic system, we'll use the tag polynomial
;and install appropriate operations on tagged polynomials in the operation table, e.g:

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
  (define (tag p) (attach-tag ’polynomial p))
  (put ’add ’(polynomial polynomial) 
       (lambda (p1 p2) (tag (add-poly p1 p2))))
  (put ’mul ’(polynomial polynomial) 
       (lambda (p1 p2) (tag (mul-poly p1 p2))))
  (put ’make ’polynomial
       (lambda (var terms) (tag (make-poly var terms))))
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

;By using generic procedures (add / mul) the package can handle any type of coefficient
;And if we were to include a coercion mechanism then we could also handle polynomials with differing
;coefficient types.

;Because we've installed add-poly and mul-poly into the generic package as add and mul operations
;for type polynomial our system is also able to handle operations such as

;[(y + 1)x^2 + (y^2 + 1)x + (y - 1)] * [(y - 2)x + (y^3 + 7)]

;This is possible because when the system attempts to combine coefficients it will dispatch
;through add and mul, as there coeffecients themselves are polynomials (in y) these will be combined
;using add-poly and mul-poly.

;This results in a type of data-directed-recursion, a call to mul-poly results in recursive calls to mul-poly
;in order to multiply the polynomial coefficients.

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

;For a sparse polynomial this would be a poor representation, as we'd have a large list of zeros with
;only a couple non-zero entries. For a sparse polynomial a list of non-zero terms would be more effective
;Where each term is a list containing the order and coefficient

;E.g. ((100 1) (2 2) (0 1))

;As sparse polynomials are more common we will use this representation for our system
;With a representation determined we can now implement selectors and constructors for terms and term-lists

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


;Ex 2.87   Install =zero?
;for polynomials in the generic arithmetic package. This will allow 
;adjoin-term to work for polynomials with coefficients that are themselves polynomials. 

(define (poly-zero? pol)
  (empty-termlist? (term-list pol)))

(put '=zero? '(polynomial) (lambda (x) (poly-zero? x))) ;If a polynomial has no terms, we can say its 0
