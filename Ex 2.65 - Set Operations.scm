#lang scheme



;Ex 2.65 - Using the results from Exercise 2.63 / 2.64 give 
; O(n) implementations of union-set and intersection-set
;for sets implemented as (balanced) binary trees.


;Entry is the value of the node
(define (entry tree) (car tree))

;Left branch are values less than the entry
(define (left-branch tree) (cadr tree))

;Right branch are values greater than the entry
(define (right-branch tree) (caddr tree))

;Create a tree by supplying the entry value and left/right branches
(define (make-tree entry left right)
  (list entry left right))


;Converts a tree to a list
(define (tree->list tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))

;Converts a list to a tree
(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))


;Union-Set, we already created a procedure to determine the union set of two ordered lists in exercise 2.62
;Start by making modifications to that procedure

;General process will be

;Tree -> List
;Union-Set
;List-> Tree

(define (union-set-tree tree1 tree2)
  (list->tree (union-set (tree->list tree1) (tree->list tree2))))

(define (union-set set1 set2)
  (cond
        ;Start with empty-list checks 
        ;[(and (null? set1) (not (null? set2))) (cons (car set2) (union-set set1 (cdr set2)))] ;If set1 is empty and set2 is not - advance set2
        ;[(and (not (null? set1)) (null? set2)) (cons (car set1) (union-set (cdr set1) set2))] ;If set2 is empty and set1 is not - advance set1
        ;[(and (null? set1) (null? set2)) '()] ;If both sets are empty -> finished, return empty list

        ;Null checks can be shortened
        [(null? set1) set2] ;If set1 is null return whatever remains of set2
        [(null? set2) set1] ;If set2 is null return whatever remains of set1
        [(< (car set1) (car set2)) (cons (car set1) (union-set (cdr set1) set2))] ;If set1 element is smaller - advance set1
        [(< (car set2) (car set1)) (cons (car set2) (union-set set1 (cdr set2)))] ;If set2 element is smaller - advance set2
        [(= (car set1) (car set2)) (cons (car set1) (union-set (cdr set1) (cdr set2)))])) ;If both set elements are the same - advance set1 and set2

;Testing

(define tree1 '(5 (2 () ()) (6 () (7 () (8 () ())))))
(define tree2 '(5 (4 (3 () ()) ()) (6 () (7 () ()))))

;Expect
;(5 (3 (2 () ()) (4 () ())) (7 (6 () ()) (8 () ())))
;> (union-set-tree tree1 tree2)
;(5 (3 (2 () ()) (4 () ())) (7 (6 () ()) (8 () ())))


;Intersection Set
;Very similar to union, however only cons when both elements are equal
(define (intersection-set set1 set2)
  (cond
        ;Start with empty-list checks 
        ;[(and (null? set1) (not (null? set2))) (cons (car set2) (union-set set1 (cdr set2)))] ;If set1 is empty and set2 is not - advance set2
        ;[(and (not (null? set1)) (null? set2)) (cons (car set1) (union-set (cdr set1) set2))] ;If set2 is empty and set1 is not - advance set1
        ;[(and (null? set1) (null? set2)) '()] ;If both sets are empty -> finished, return empty list

        ;Null checks can be shortened
        [(null? set1) '()] ;If set1 is null return whatever remains of set2
        [(null? set2) '()] ;If set2 is null return whatever remains of set1
        [(< (car set1) (car set2)) (intersection-set (cdr set1) set2)] ;If set1 element is smaller - advance set1
        [(< (car set2) (car set1)) (intersection-set set1 (cdr set2))] ;If set2 element is smaller - advance set2
        [(= (car set1) (car set2)) (cons (car set1) (intersection-set (cdr set1) (cdr set2)))])) ;If both set elements are the same - advance set1 and set2

(define (intersection-set-tree tree1 tree2)
  (list->tree (intersection-set (tree->list tree1) (tree->list tree2))))

;Testing - with lists

(define list1 '(1 2 3 4 5))
(define list2 '(2 3 4))

;> (intersection-set list1 list2)
;(2 3 4)

;Testing with trees
;Expect (6 (5 () ()) (7 () ()))
;(6 (5 () ()) (7 () ()))
