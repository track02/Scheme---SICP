 #lang scheme


;Exercise 2.62.  Give a  O(n) implementation of union-set for sets represented as ordered lists

;Union-set computes the union of two sets, this is the set containing each element that appears in either argument
;Want to perform this operation in O(n)

;If both sets are ordered iterate over each set and compare values
;
;Basically compare elements and keep the smallest, then move to next element

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
;> (union-set '(1 2 3) '(3 4 5 6))
;(1 2 3 4 5 6)

