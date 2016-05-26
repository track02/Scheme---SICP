#lang scheme

;Ex 2.32 Complete the implementation of the subsets function
;subsets will produce the superset of a given set (list)
;(1 2 3) -> (() (1) (2) (3) (1 2) (2 3) (1 3) (1 2 3))

;Basic superset algorithm
;If a set is empty -> done, no further supersets available
;Otherwise -> Remove an element from the set (car) leaving a subset
;          -> Repeat the algorithm on the subset
;          -> Return the set composed of the following
;             (1) Power set of the subset
;             (2) The subset with each element unioned with the previously removed element


(define (subsets s)
  (if (null? s)
      (list null) ;reached null - stop
      (let ((rest (subsets (cdr s)))) ;Find superset of the subset (removed head)
        (append rest (map (lambda (x) (cons (car s) x))  rest))))) ;Join P(subset) with (head U P(subset))

(define test-list (list 1 2 3))

;Testing
;> (subsets test-list)
;(() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))
