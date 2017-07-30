#lang scheme

;Implementation for a tree structure - a tree has 3 parts, entry, left branch and right branch

;Entry is the value of the node
(define (entry tree) (car tree))

;Left branch are values less than the entry
(define (left-branch tree) (cadr tree))

;Right branch are values greater than the entry
(define (right-branch tree) (caddr tree))

;Create a tree by supplying the entry value and left/right branches
(define (make-tree entry left right)
  (list entry left right))

;Ex 2.63   Each of the following two procedures converts a binary tree to a list

;a1) Do the two procedures produce the same result for every tree? If not, how do the results differ?

;Create a test tree
(define test-tree '(15 (10 (5 () (6 () ())) (12 () (14 () ()))) (20 (17 () ()) (25 (24 (22 () ()) ()) (28 () ()))))) 

;                                               15
;                                      |--------|--------|
;                                      |                 |
;                                      10                20                                       
;                                      / \              /  \
;                                    5    12           17   25
;                                     \     \              /  \
;                                      6     14           24  28
;                                                        /
;                                                       22

;Expect to see (5 6 10 12 14 15 17 20 22 24 25 28)

;> (tree->list-1 test-tree)
;(5 6 10 12 14 15 17 20 22 24 25 28)

;> (tree->list-2 test-tree)
;(5 6 10 12 14 15 17 20 22 24 25 28)

;Both procedures produce the same ordered lists

;a2)What lists do the two procedures produce for the trees in figure 2.16?

(define tree1 '(7 (3 (1 () ()) (5 () ())) (9 () (11 () ()))))
(define tree2 '(3 (1 () ()) (7 (5 () ()) (9 () (11 () ())))))
(define tree3 '(5 (3 (1 () ()) ()) (9 (7 () ()) (11 () ()))))

;For each tree expect (1 3 5 7 9 11)

;> (tree->list-1 tree1)
;(1 3 5 7 9 11)
;> (tree->list-1 tree2)
;(1 3 5 7 9 11)
;> (tree->list-1 tree3)
;(1 3 5 7 9 11)

;> (tree->list-2 tree1)
;(1 3 5 7 9 11)
;> (tree->list-2 tree2)
;(1 3 5 7 9 11)
;> (tree->list-2 tree3)
;(1 3 5 7 9 11)

;Both procedures produce the same ordered lists

;B) - Do the two procedures have the same order of growth in the number of steps required to convert a balanced tree
;with n elements to a list - if not which one grows more slowly

;In a balanced tree the number of elements halves each "step"

;First procedure uses append which will iterate over all elements in the given list -> O(nlogn)
;Second procedure only relies on cons which is a single operation -> O(n)

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))
