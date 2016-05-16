#lang scheme


;Scheme - Trees - Section 2.2.2

;One way to think of sequences whose elements are also sequences is as trees
;The elements of the sequence are tree branches and the elements themselves
;that are sub-sequences are subtrees;

;Recursion is a natural too for dealing with trees
;Operations on trees can be reduced to operations on branches
;this can repeat until the leaves of a tree are reached

;Counting leaves
;The leaf sum of a tree, x is the leaf sum of the car plus the leaf sum of the cdr
(define (count-leaves x)
  (cond ((null? x) 0)  
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))

;Write a procedure fringe which takes a tree (represented as a list)
;and returns a list whose elements are all leaves of the tree
;arranged in left-to-right order

(define (fringe x) ;Takes a list x as argument
  (cond [(null? x) null] ;If we reach end of the list return null - finished, all leaves explored
        [(not (pair? x)) (list x)] ;If not a pair and not null - must be a leaf, package up
        [else (append (fringe (car x)) ;While there are subtrees to explore 
                       (fringe (cdr x)))])) ;Append first subtree leaf to the second

;Testing
(define x (list (list 1 2) (list 3 4) (list 1 2) (list 5 6)))

;> (fringe x)
;(1 2 3 4 1 2 5 6)