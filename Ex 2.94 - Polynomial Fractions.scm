#lang scheme

;Polynomial fractions can be reduced to lowest terms using the same idea we used for integers
;dividing both the numerator and denominator by their greatest common divisor (gcd)
;E.g. (For Integers) 6/3 -> 2/1



;Ex 2.94
;Using div-terms implement the procedure remainder-terms
;Apply div-terms to define gcd-terms.
;Write a procedure gcd-poly that computes the polynomial GCD of two polys
;Return an error if the two polynomials are not of the same variable.
;Lastly install a generic operation, greatest-common-divisor that reduces to gcd-poly for polynomials
;and to ordinary gcd for primitive numbers.

;We can retrieve the remainder by accessing the second list element returned by div-terms
(define (remainder-terms a b)
  (cadr (div-terms a b)))

;Using this we  can then build our GCD procedure
(define (gcd-terms a b)
(if (empty-termlist? b)
a
(gcd-terms b (remainder-terms a b))))

;Find the gcd of two given polynomials
(define (gcd-poly p1 p2)
  (if (eqv? (variable p1) (variable p2)) ;Check variables
      ;Create a new polynomial of variable p1 and the gcd term-list
      (make-poly (variable p1) (gcd-terms (term-list p1) (term-list p2)))
      ;Otherwise - variable mismatch, signal an error.
      (error "Variable Mismatch")))


;Generic GCD procedures
(define (greatest-common-divisor a b)
  (apply-generic 'gcd a b))

;Following entries to dispatch table would be needed
;Operation name is the same but argument types differ, allowing correct gcd procedure call
(put 'gcd '(polynomial polynomial)
     (lambda (a b) (tag (gcd-poly a b))))

(put 'gcd '(scheme-number scheme-number)
     (lambda (a b) (gcd a b)))

  


;Modify the rational number package to use generic operations
;but change make-rat so it does not attempt to reduce fractions to lowest terms
;This would allow us to manipulate "fractions" of any data type (E.g. Polynomials)
;Assuming correct generic procedures have been defined

(define (install-rational-package)
  ;; internal procedures
  (define (numer x) (car x))
  (define (denom x) (cdr x))

  ;Remove the gcd call from make-rat, its now just a pair
  (define (make-rat n d)
    (cons n d))

  ;Where a primitive procedure is used (+ * - /) replace with the generic variant
  (define (add-rat x y)
    (make-rat (add (mul (numer x) (denom y))
                 (mul (numer y) (denom x)))
              (add (denom x) (denom y))))
  (define (sub-rat x y)
    (make-rat (sub (mul (numer x) (denom y))
                 (mul (numer y) (denom x)))
              (mul (denom x) (denom y))))
  (define (mul-rat x y)
    (make-rat (mul (numer x) (numer y))
              (mul (denom x) (denom y))))
  (define (div-rat x y)
    (make-rat (mul (numer x) (denom y))
              (mul (denom x) (numer y))))

  
;; interface to rest of the system
  (define (tag x) (attach-tag 'rational x))
  (put 'add '(rational rational)
       (lambda (x y) (tag (add-rat x y))))
  (put 'sub '(rational rational)
       (lambda (x y) (tag (sub-rat x y))))
  (put 'mul '(rational rational)
       (lambda (x y) (tag (mul-rat x y))))
  (put 'div '(rational rational)
       (lambda (x y) (tag (div-rat x y))))
  257
  (put 'make 'rational
       (lambda (n d) (tag (make-rat n d))))
  'done)
(define (make-rational n d)
  ((get 'make 'rational) n d))


;Div Terms procedure
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
  



;... Remaining Definitions ...