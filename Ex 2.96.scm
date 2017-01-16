#lang scheme

;Complete Number-Polynomial Package used to test this exercise - (see https://wizardbook.wordpress.com) - Note: Implements put/get table from Chapter 3
(require "Number-Packages.scm")
(require sicp)
(require racket/trace)


;Ex 2.96 - In the previous exercise a problem arose when rational fractions were introduced into the division process
;We can solve this issue by modifying the GCD algorithm (which is really only designed for polynomials with integer coefficients)
;Before any polynomial division is performed in the GCD computation we multiply the dividend by an integer constant factor
;This factor is chosen to guarantee that no fractions will arise during the division process.
;
;This factor will cause our final answer to differn from the actual GCD by an integer constant factor, but this doesn't matte when
;reducing rational functions to lowest terms.
;
;
;If P and Q are polynomials, lets O1 be the order of P (that is the order of the largest term of P) and let O2 be
;the order of Q. Let c be the leading coefficient of Q.
;
;It can be shown that if we multiply p by the integerizing factor c^(1+O1-O2) the resulting polynomial can be divided by Q.
;Using the standard div-terms algorithm without introducing any fractions.

;The operation of multiplying the dividend by this constant and then dividing is known as pseudodivision of P by Q
;The remainder of the division is called the pseudoremainder

;Part A) Implement the procedure pseudoremainder-terms which multiplies the dividend by the intergrizing factor before calling div-terms
;Modify gcd-terms to use pseudoremainder-terms and verify that greatest-common-divisor now produces an answer with integer coefficients

;Part B) The GCD now has integer coefficients but they are larger than those of P1
;Modify gcd-terms so that it removes common factors from the coefficients of the answer
;by dividing all coefficients by their gcd

;Implementation of pseudoremainder terms - incorporated into number-polynomial package.

;  ;Given two term-lists determine the integerizing factor
;  (define (int-factor pt qt)
;
;    ;Extract vars
;    (let ((o1 (order (first-term pt)))
;          (o2 (order (first-term qt)))
;          (c  (coeff (first-term qt))))
;
;    ;factor = c^(1+O1-O2)
;    (expt c (+ 1 (- o1 o2)))))
;
;  Now perform division
;  (define (pseudoremainder-terms p q)
;    (cadr (div-terms (mul-integer-terms(int-factor p q) p) q)))
;
; Update gcd-terms to use pseudoremainder
; (define (gcd-terms a b)
;    (if (empty-termlist? b)
;        a
;        (gcd-terms b (pseudoremainder-terms a b)))

                    

;Polynomials defined from Ex 2.95

(define p1 (make-sparse-polynomial 'x '((2 1) (1 -2) (0 1))))
(define p2 (make-sparse-polynomial 'x '((2 11) (0 7))))
(define p3 (make-sparse-polynomial 'x '((1 13) (0 5))))

(define q1 (mul p1 p2))
(define q2 (mul p1 p3))

(define q3 (greatest-common-divisor q1 q2))

;No more fractions present in Q3
;> q3
;{polynomial x sparse {2 1458} {1 -2916} {0 1458}}

;Now need to modify gcd-terms to divide term coeffecients by gcd
;  (define (gcd-terms a b)
;    ;Finished finding gcd
;    (if (empty-termlist? b)
;        ;a is our set of results
;        (let* ((coeffs (map cadr a)) ;Extract all coefficients, result of mapping cadr to each term ;Note - using let* allows referencing previous bindings
;              (coeff-gcd (apply gcd coeffs))) ;Find the gcd for this list, use apply to call gcd on all list elements at once (gcd 1 2 3 4) -> (apply gcd '(1 2 3 4))
;          (map (lambda (t) (make-term (order t) ((coeff t) / gcd))) a)) ;divide each term by the gcd and return new list
;        (gcd-terms b (pseudoremainder-terms a b)))) ;Otherwise repeat process

