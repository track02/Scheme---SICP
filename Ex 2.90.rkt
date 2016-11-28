#lang racket

;Will use racket language for this - allows for an implementation of put/get so the exercise can be tested

;Ex 2.90   Suppose we want to have a polynomial system that is efficient for both sparse and
;dense polynomials. One way to do this is to allow both kinds of term-list representations in our
;system. The situation is analogous to the complex-number example of section 2.4
;where we allowed both rectangular and polar representations.

;To do this we must distinguish different types of term lists
;and make the operations on term lists generic. Redesign the polynomial system to implement this
;generalization. This is a major effort, not a local change.

;The two term-list representations could each be contained within a package
;With a tag being used to identify the implementation

;The current existing term-list operations would instead dispatch the correct method using a
;call to a procedure analagous to the earlier apply-generic

;This would allow the polynomial package to remain unchanged as only the underlying term-list representations
;would need to be updated

;Current Polynomial Package

(define (install-polynomial-package)
;; internal procedures
;; representation of poly
  (define (make-poly variable term-list)
    (cons variable term-list))
  (define (variable p) (car p))
  (define (term-list p) (cdr p))
;;  <procedures same-variable? and variable? from section 2.3.2>
;; representation of terms and term lists
;;  <procedures adjoin-term ...coeff from text below>
;; continued on next page
  (define (add-poly p1 p2)
    (make-poly (variable p1) (add-terms (term-list p1) (term-list p2))))
;  <procedures used by add-poly>
  (define (mul-poly p1 p2)
        (make-poly (variable p1) (mul-terms (term-list p1) (term-list p2))))
;  <procedures used by mul-poly>
;; interface to rest of the system
  (define (tag p) (attach-tag 'polynomial p))
  (put 'add '(polynomial polynomial) 
       (lambda (p1 p2) (tag (add-poly p1 p2))))
  (put 'mul '(polynomial polynomial) 
       (lambda (p1 p2) (tag (mul-poly p1 p2))))
  (put 'make 'polynomial
       (lambda (var terms) (tag (make-poly var terms))))
  'done)

;Add two term lists together
(define (add-terms L1 L2)
  (cond ((empty-termlist? L1) L2)
        ((empty-termlist? L2) L1)
        (else
         (let ((t1 (first-term L1)) (t2 (first-term L2)))
           (cond ((> (order t1) (order t2))
                  (adjoin-term
                   t1 (add-terms (rest-terms L1) L2)))
                 ((< (order t1) (order t2))
                  (adjoin-term
                   t2 (add-terms L1 (rest-terms L2))))
                 (else
                  (adjoin-term
                   (make-term (order t1)
                              (add (coeff t1) (coeff t2)))
                   (add-terms (rest-terms L1)
                              (rest-terms L2)))))))))


;Multiply two term-lists together
(define (mul-terms L1 L2)
  (if (empty-termlist? L1)
      (the-empty-termlist)
      (add-terms (mul-term-by-all-terms (first-term L1) L2)
                 (mul-terms (rest-terms L1) L2))))
(define (mul-term-by-all-terms t1 L)
  (if (empty-termlist? L)
      (the-empty-termlist)
      (let ((t2 (first-term L)))
        (adjoin-term
         (make-term (+ (order t1) (order t2))
                    (mul (coeff t1) (coeff t2)))
         (mul-term-by-all-terms t1 (rest-terms L))))))


;Term-List Operations
(define (adjoin-term term term-list)
  (if (=zero? (coeff term))
      term-list
      (cons term term-list)))
(define (the-empty-termlist) '())
(define (first-term term-list) (car term-list))
(define (rest-terms term-list) (cdr term-list))
(define (empty-termlist? term-list) (null? term-list))

;Term operations
(define (make-term order coeff) (list order coeff))
(define (order term) (car term))
(define (coeff term) (cadr term))

;Tag Operations
(define (attach-tag tag-name p)
  (list tag-name p))
(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum -- TYPE-TAG" datum)))
(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum -- CONTENTS" datum)))

;Implementation of get/put  - allows for testing
(define *op-table* (make-hash))

(define (put op type proc)
  (hash-set! *op-table* (list op type) proc))

(define (get op type)
  (hash-ref *op-table* (list op type) '()))


;Simple Implementation of apply-generic
;No coercion present, will only use integers for coefficients / orders
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (error
            "No method for these types -- APPLY-GENERIC"
            (list op type-tags))))))

;We'll assume the number packages are already installed, allowing generic add/mul/=zero?
;Use dummy methods for now and will stick to integers to keep things simple
(define (add x y)
  (+ x y))

(define (mul x y)
  (* x y))

(define (=zero? x)
  (= 0 x))

(define (make-poly coeff term-list)
  ((get 'make 'polynomial) coeff term-list))

(install-polynomial-package)
(define p1 (make-poly 'x '((1 2) (3 0))))
(define p2 (make-poly 'x '((2 2) (4 0))))


