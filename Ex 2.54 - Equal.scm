#lang scheme

;Ex 2.54, two lists are said to be equal if they contain the same elements in the same order
;write a procedure equal? to check two arguments

;If a and b are both symbols, return eq? a b
;If a and b are both lists return equal? a b
;Otherwise return false

(define (equal? a b)
  ;First check if a/b are not lists or null, return compairon result
  (cond [(or (and (not (list? a)) (not (list? b))) (or (null? a) (null? b))) (eq? a b)]
        ;If both elements are lists and the first elements are equal, compare the remaining elements
        [(and (list? a) (list? b)) (and (equal? (car a) (car b)) (equal? (cdr a) (cdr b)))]
        ;Otherwise return false
        [else #f]))
  

;Testing

(equal? '() '())
;#t
(equal? '() 'a)
;#f
(equal? '((x1 x2) (y1 y2)) '((x1 x2) (y1 y2)))
;#t
(equal? '((x1 x2) (y1 y2)) '((x1 x2 x3) (y1 y2)))
;#f
(equal? '(x1 x2) 'y1)
;#f
(equal? 'abc 'abc)
;#t
(equal? 123 123)
;#t
(equal? 2 5)
;#f
(equal? (list 1 2 3) '(1 2 3))
