#lang scheme

;Ex 2.73, below is a rewrite of the differentiation program for section 2.3.2
;Note - based on an imaginary implementation of a operation/data-type table and will not run


(define (deriv exp var)
   (cond ((number? exp) 0)
         ((variable? exp) (if (same-variable? exp var) 1 0))
         (else ((get ’deriv (operator exp)) (operands exp)
                                            var))))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

;A) Explain how the above system functions and explain why the predicates number? and
;same-variable? cannot be added into the table

;Given an expression and a variable the deriv procedure will differentiate the expression wrt the variable
;E.g. (deriv '(+ x 3) 'x) -> (+ 1 0)

;Following these basic reduction rules
; dc/dx = 0
; dx/dx = 1
;d(u+v)/dx = du/dx + dv/dx
;d(uv)/dx = u(dv/dx) + v(du/dx)

;If the expression is a constant return 0
;If the expression is a variable different than the one supplied return 0, if it's the same return 1
;Otherwise get the deriv procedure that applies to the operator of the expression (e.g. + in (+ x 3))
;Now apply the deriv procedure to the operands (x 3) and variable (x)
;Recurse until the procedure terminates

;number? and same-variable? do not be added into the table because the same procedure is applied to
;all data types, a lookup is not required

;B) Write the code to install the procedures required for derivatives of sums and products

(define (install-deriv-package)

  ;Differentiate a sum
  
  (define (make-sum a1 a2) (list ’+ a1 a2))
  (define (addend s) (cadr s))
  (define (augend s) (caddr s))
  
  (define (sum-deriv exp var)       
      (make-sum (deriv (addend exp) var)
                (deriv (augend exp) var)))

  ;Differentiate a product

  (define (multiplier p) (cadr p))
  (define (multiplicand p) (caddr p))
  (define (make-product m1 m2) (list ’* m1 m2))

  (define (product-deriv exp var)
      (make-sum
          (make-product (multiplier exp)
                        (deriv (multiplicand exp) var))
          (make-product (deriv (multiplier exp) var)
                        (multiplicand exp))))

  ;C) - Add another rule to the package - differentiate exponents
  
  (define (base x) (cadr x))
  (define (exponent x) (caddr x))

  (define (exponent-deriv exp var)
   (make-product
          (exponent exp)
          (make-product
           (make-exponentiation
            (base exp)
            (make-sum (exponent exp) -1))
           (deriv (base exp) var))))  
    
  ;Attach appropriate deriv procedure to correct operation
  (put 'deriv '+ sum-deriv)
  (put 'deriv '* product-deriv)
  (put 'deriv '** exponent-deriv))

;D) Suppose procedures were indexed in the opposite way, so that the dispatch line looked like this

((get (operator exp) ’deriv) (operands exp) var)

;What changes to the system would be required?

;Basically flipped the table to procedures/operations instead of operations/procedures
;So only the argument order for put would need to be reversed

