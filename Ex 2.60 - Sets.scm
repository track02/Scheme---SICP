#lang scheme

;Ex 2.60, sets have previously been represented as a list without duplicates, suppose we allow duplicates
;for examples, {1,2,3} could be represented as the list (2 3 2 1 3 2 2)

;Design the following procedures that operate on the representation

;element-of-set?
(define (element-of-set? x set)
  (cond [(null? set) #f]
        [(null? (car set)) #f]
        [(= x (car set)) #t]
        [else (element-of-set? x (cdr set))]))

;Testing
;> (element-of-set? 1 '(2 3 4 5 1 3))
;#t
;> (element-of-set? 2 '(3 4 5 6 1 4 5 6))
;#f

;Performance
;This may be slower than the previous implementation (no duplicates)
;if a set is "padded" with many duplicates before reaching the end / matching value
;performance time will be impacted

;Worst case is still the same however O(n) where the entire set must be checked, but the set size n may be larger

;adjoin-set
;Adds an element to a set - because duplicate are allowed no checks are required
(define (adjoin-set x set)
  (cons x set))

;Testing
;> (adjoin-set 'x '(1 2 3 4 5))
;(x 1 2 3 4 5)

;Performance
;This is a quicker procedure and will complete in O(1), a single operation is performed regardless of set size
;No checks for duplicates need to be made


;union-set
;If duplicates are allowed just join the two sets
(define (union-set set1 set2)
  (append set1 set2))


;Testing
;> (union-set '(1 2 3) '(1 3 4))
;(1 2 3 1 3 4)


;Performance here is now O(n), length of one of the sets
;No checking is needed for each element, improving performance from the initial O(n^2)


