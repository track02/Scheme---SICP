#lang scheme

;Exercise 2.92: By imposing an ordering on variables, extend
;the polynomial package so that addition and multiplication
;of polynomials works for polynomials in different
;variables

;We need to define a way to order variables such that polynomials can be converted "upwards"
;until the "lower" polynomial has the same variable as the "upper" polynomial
;Similar to the tower structure used in the number packages to convert numbers

;Lets assume polynomials can only make use of the variables A, B and C
;Ordering alphabetically this gives us the following tower
;(this could be extended to the entire alphabet)

;   A
;   ^
;   B
;   ^
;   C

;   A > B > C

;Polynomials with a variable A can be seen as the 'canonical form' of polynomial
;Methods would be needed to convert from C -> B and B -> C
;When an operation is performed on two differing polynomials, the polynomial lower in the tower is to be
;identified and converted upwards until it matches the other.


;Need a method to determine the order of two given polynomials - which is at the top of the tower
;If var-order returns true if the variable of P1 is ">" than P2
;Using the string<? procedure which checks if the given arguments are increasings (A->B->C)
;Need to convert the variables from symbols 'x to strings "x" using symbol->string procedure
(define (var-order p1 p2)
  (string<? (symbol->string (variable p1)) (symbol->string (variable p2))))

;A coerce method is then needed to convert polynomials
;If we want to convert a polynomail in B (pB) to a polynomial in A (pA)
;We create a new polynomial in A consisting of a single zero-order term
;pB -> 0A^n + 0A^n-1 ... + 0A + pB


;coerce-polynomial converts p1 to p2
(define (coerce-polynomial p1 p2)
  ;Start building a new polynomial of the same type as p1
  ;Set poly-builder to the correct procedure, depending on type of p1
  (let ((poly-builder (if (eq? (type-tag (contents p1)) 'dense)
                    make-dense-poly
                    make-sparse-poly))
        (zeroth-term (make-term 0 (tag p1)))) ;Create a zero order term consisting of p1
    ;Return the contents the creating a polynomial in the variable of p2 consisting of a zero-order p1 term
    (contents (poly-builder (variable p2) (list zeroth-term))))) 
  

;Using this coerce procedure we can now define add/multiply procedures
(define (add-poly p1 p2)
  (if (eq? (variable p1) (variable p2))
      ;Both variables equal - add as normal where add is a generic procedure
      (make-poly (variable p1) (add (term-list p1) (term-list p2)))
      ;Otherwise find which polynomial has the 'greater' variable
      (if (var-order p1 p2) ;P1 is greater, convert P2 into P1
          (add-poly p1 (coerce-polynomial p2 p1))
          (add-poly (coerce-polynomial p1 p2) p2))))
                    
;Using a similar structure for multiply
(define (multiply-poly p1 p2)
  (if (eq? (variable p1) (variable p2))
      ;Both variables equal - add as normal where add is a generic procedure
      (make-poly (variable p1) (multiply (term-list p1) (term-list p2)))
      ;Otherwise find which polynomial has the 'greater' variable
      (if (var-order p1 p2) ;P1 is greater, convert P2 into P1
          (multiply-poly p1 (coerce-polynomial p2 p1))
          (multiply-poly (coerce-polynomial p1 p2) p2))))