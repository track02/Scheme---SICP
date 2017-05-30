#lang scheme

;Ex 2.31 abstract Ex 2.30 to produce a tree-map function
;such that square-tree could be defined as
;(define (square-tree tree) (tree-map square tree)

(define (tree-map proc tree)
  (cond [(null? tree) null]
        [(not (pair? tree)) (proc tree)]
        [else (cons (tree-map proc (car tree))
                    (tree-map proc (cdr tree)))]))
                                 

(define (square x) (* x x))

(define (square-tree tree) (tree-map square tree))

(define test-tree (list 1 (list 2 (list 3 4) 5) (list 6 7)))


;Testing

;> (square-tree test-tree)
;(1 (4 (9 16) 25) (36 49))
