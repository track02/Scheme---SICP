#lang scheme

;Ex 2.41 -   Write a procedure to find all ordered triples of distinct positive integers 
;i,j, and k less than or equal to a given integer n that sum to a given integer s.

;Lets start by creating all possible triplets for a given number, n

;Enumerate list will create a list (start, start + 1, start + n, stop)
(define (enumerate-list start stop)
  (if (> start stop)
      null
      (cons start (enumerate-list (+ start 1) stop))))

;Accumulate
(define (accumulate op init sequence)
  (if (null? sequence)
      init
      (op (car sequence)
          (accumulate op init (cdr sequence)))))

;Flatmap
(define (flatmap op sequence)
  (accumulate append null (map op sequence)))

;Unique-pairs procedure from previous
(define (unique-pairs n)
   (flatmap
    (lambda (i)
      (map (lambda (j) (list i j))
           (enumerate-list 1 (- i 1))))
    (enumerate-list 1 n)))

;Works by mapping along the sequence
;(enumerate-list 1 n)
;For each i in this sequence do the following
;(enumerate-list 1 (- i 1))
;For each j in this subsequence do the following
;(list i j)


;Start by finding triples
;Same as above but 3 levels deep, 3 maps
(define (triples n)
  (map (lambda (i)
       (map (lambda (j)
              (map (lambda (k)
                     (list i j k))
                     (enumerate-list 1 (- j 1))))
            (enumerate-list 1 (- i 1))))
       (enumerate-list 1 n)))

;(define x triples 5)
;(() (()) (() ((3 2 1))) (() ((4 2 1)) ((4 3 1) (4 3 2))) (() ((5 2 1)) ((5 3 1) (5 3 2)) ((5 4 1) (5 4 2) (5 4 3))))

;Need to flatten this mapping now
;Using accumulate to append elements
;Once will reduce into sublists
;Twice will reduce into single list

;> (define y (accumulate append null x))
;> y
;(() () ((3 2 1)) () ((4 2 1)) ((4 3 1) (4 3 2)) () ((5 2 1)) ((5 3 1) (5 3 2)) ((5 4 1) (5 4 2) (5 4 3)))
;> (define z (accumulate append null y))
;> z
;((3 2 1) (4 2 1) (4 3 1) (4 3 2) (5 2 1) (5 3 1) (5 3 2) (5 4 1) (5 4 2) (5 4 3))

;We can combine these two steps using flatmap procedure
;flatmap performs the map operation and then flattens the list using append accumulate to merge lists together
(define (triples-flat n)
  (flatmap (lambda (i)
       (flatmap (lambda (j)
              (map (lambda (k)
                     (list i j k))
                     (enumerate-list 1 (- j 1))))
            (enumerate-list 1 (- i 1))))
       (enumerate-list 1 n)))

;Now we are
;Generating the list 1 to n
;For each element of this list (i) generate a list (1, (- i 1))
;For each element of this list (j) generate a list (1, (- j 1))
;For each element of this list create triplet (i j k)

;We want to now filter out elements that do not sum to a given value s

(define (triple-sum n s)
  ;Define filter check in here (block structure), allows sharing of s argument can pass sum? straight to filter
  (define (sum? triple)
    ;Simply sum up elements using accumulate
    (= s (accumulate + 0 triple)))
  ;Now filter results
  (filter sum? (triples-flat n)))

;Provided filter sequence
(define (filter predicate sequence)
  (cond ((null? sequence) null)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

;Testing
;> (triple-sum 5 7)
;((4 2 1))
;> (triple-sum 12 12)
;((5 4 3) (6 4 2) (6 5 1) (7 3 2) (7 4 1) (8 3 1) (9 2 1))