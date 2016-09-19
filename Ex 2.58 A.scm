#lang scheme

;Ex 2.58 (a) - Modify the program to allow differentiation of expresions presentd in infix form e.g.
;(x + (3 * (x + (y + 2))))
;Assuming that + and * always take two arguments and expressions are fully parenthisized

;We need to change how sums and products are represented
;Symbol moves from first list item to the second

;Testing
;> (deriv '(x ** 2) 'x)
;(2 * x)
;> (deriv '(x * y) 'x)
;y
;> (deriv '(x + (3 * (x + (y + 2)))) 'x) [x + 3x + 3y + 6] 
; 4


;Constructors and Selectors
(define (variable? x) (symbol? x)) ;Variables are symbols ('x) and can be identified using the primitive symbol? predicate

(define (same-variable? v1 v2) ;If both values are variables and the symbols representing them are equal
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=number? exp num) ;Is an expression a number and is it equal to the given number
  (and (number? exp) (= exp num)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2) ;If a1 is zero only return a2 (0 + a2 = a2)
        ((=number? a2 0) a1) ;If a2 is zero only return a1 (0 + a1 = a1)
        ((and (number? a1) (number? a2)) (+ a1 a2)) ;If both elements are just numbers, add them together
        (else (list a1 '+ a2)))) ;If an element is an expression create a list

(define (make-product m1 m2) 
  (cond ((or (=number? m1 0) (=number? m2 0)) 0) ;If either element equals zero, return 0
        ((=number? m1 1) m2) ;If m1 equals 1 return m2
        ((=number? m2 1) m1) ;If m2 equals 2 return m1
        ((and (number? m1) (number? m2)) (* m1 m2)) ;If both elements are numbers, multiply them
        (else (list m1 '* m2)))) ;Otherwise form a list

(define (sum? x) ;is x a list and is the second element a "+"
  (and (pair? x) (eq? (cadr x) '+)))

;First element of a sum
(define (addend s) (car s))

;Third element(s) of a sum
(define (augend s) (caddr s)) ;Return third element 
      

;Is x a list and is the second element a "*"
(define (product? x)
  (and (pair? x) (eq? (cadr x) '*)))

;First element of a produc
(define (multiplier p) (car p))

;Third element of a product
(define (multiplicand p) (caddr p)) ;Return third element


;Similar to product? and sum? checks if argument is a list and whether first element is **
(define (exponentiation? x)
  (and (pair? x) (eq? (cadr x) '**))) ;

;first element
(define (base x)
  (car x))

;Third element
(define (exponent x)
  (caddr x))

;Make-exponentiation
(define (make-exponentiation u n)
  [cond [(=number? n 0) 1]
        [(=number? n 1) u]
        [(and (number? u) (number? n)) (expt u n)]
        [else (list u '** n)]])


;Testing
;> (make-exponentiation 2 2)
;4
;> (make-exponentiation 'x 5)
;(** x 5)
;> (make-exponentiation 2 0)
;1
;> (make-exponentiation 2 1)
;2


;Symbolic Differentiation Algorithm
;Incorporates the following rules

;dc/dx = 0 (where c is a constant)
;dx/dx = 1
;d(u + v) / dx = du/dx + dv/dx
;d(uv)/dx = u(dv/dx) + v(du/dx)

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))
           (make-product (deriv (multiplier exp) var)
                         (multiplicand exp))))
        ((exponentiation? exp)
         (make-product
          (exponent exp)
          (make-product
           (make-exponentiation
            (base exp)
            (make-sum (exponent exp) -1))
           (deriv (base exp) var))))
        (else
         (error "unknown expression type -- DERIV" exp))))

;Testing
;> (deriv (list '** 'x 5) 'x)
;(* 5 (** x 4))
