#lang scheme

;Ex 2.30 define a procedure square-tree
;square-tree takes a tree (list) as an argument
;and return a tree consisting of the argument elements squared

;Ex 2.30a -> define square-tree directly using no higher functions
(define (square-tree tree)
  (cond [(null? tree) null]
        [(not (pair? tree)) (* tree tree)]
        [else (cons (square-tree (car tree))
                    (square-tree (cdr tree)))]))
                                 

(define test-tree (list 1 (list 2 (list 3 4) 5) (list 6 7)))
            
