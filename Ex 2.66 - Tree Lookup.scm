#lang scheme

;Exercise 2.66.  Implement the lookup  procedure for the case where the set of records is structured as
;a binary tree, ordered by the numerical values of the keys.

;Tree Procedures
(define (key tree) (caar tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (entry tree) (car (cdr (car tree)))) 
(define (make-tree entry key left right)
  (list list(key entry) left right))

;Each tree entry now consists of a key which the tree is sorted by and an associated record (currently a value), represented below as a [boxed value]

;                                         7[19]
;                                        /     \
;                                    5[22]     9[4]
;                                   /     \
;                              2[100]     6 [5]
;

(define db-tree '((7 19) ((5 22) ((2 100) () ()) ((6 5) () ())) ((9 4) () ())))

;Testing
;> (key db-tree)
;7
;> (entry db-tree)
;19
;> (left-branch db-tree)
;((5 22) ((2 100) '() '()) ((6 5) '() '()))
;> (right-branch db-tree)
;((9 4) '() '())
;> (key (left-branch db-tree))
;5
;> (key (right-branch db-tree))
;9


;Navigate the tree, moving left / right depending on current entry value
;If we reach null then the value is not present
(define (tree-lookup given-key set-of-records)
  (cond ((null? set-of-records) false)
        ((equal? given-key (key set-of-records)) (entry set-of-records))
        ((< given-key (key set-of-records)) (tree-lookup given-key (left-branch set-of-records)))
        ((> given-key (key set-of-records)) (tree-lookup given-key (right-branch set-of-records)))))

;Testing
;> (tree-lookup 6 db-tree)
;5
;> (tree-lookup 9 db-tree)
;4
;> (tree-lookup 1 db-tree)
;#f

(define end (left-branch (left-branch (left-branch db-tree))))

