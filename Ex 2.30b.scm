#lang scheme

;Ex 2.30 define a procedure square-tree
;square-tree takes a tree (list) as an argument
;and return a tree consisting of the argument elements squared

;Ex 2.30b -> define square-tree using map and recursion

;Map
;Takes a procedure and a list as an argument
;returns a list of reuslts produced by applying the procedure to each element in the list

;Given a tree
(define (square-tree tree)
  ;Map the following procedure
  (map (lambda (tree)
         (cond [(null? tree) null] 
               [(not (pair? tree)) (* tree tree)] ;If element - square
               [else (square-tree tree)])) ;If sub-tree then map
       tree))

(define test-tree (list 1 (list 2 (list 3 4) 5) (list 6 7)))

;Testing
;> (square-tree test-tree)
;(1 (4 (9 16) 25) (36 49))