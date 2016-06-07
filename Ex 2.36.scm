#lang scheme

;Exercise 2.36 - accumulate-n is similar to accumulate except that it takes as its third argument
;a sequence of sequences all of which are assumed to have the same number of elements
;It applies the accumulation procedure to combine all the first elements of the sequences
;all the second elements of the sequences and so on

;E.g. Given s, ((1 2 3) (4 5 6) (7 8 9) (10 11 12))
;(accumulate-n + 0 s) would produce
;([1 + 4 + 7 + 10] [2 + 5 + 8 + 11] [3 + 6 + 9 + 12])
;(22 26 30)


;Key is to use the map procedure to produce the required list for accumulate (first elements of each sublist)
;and to produce the required list for the next call of accumulate-n (first elements of each sublist removed)
;E.g. given a list, x as ((1 2 3) (4 5 6) (7 8 9))
;(map car x) -> (1, 4, 7) giving first elements of each sublist
;(map cdr x) -> ((2 3) (5 6) (8 9))
;(map (car (map cdr x)) -> (2 5 8)
;(map (cdr (map cdr x))) -> ((3) (6) (9))
;(map (car (map cdr (map cdr x)))) -> (3 6 9)


;Fill in the missing expressions to produce a definition of accumulate-n
(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      null
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))

;Accumlate has the following structure
(define (accumulate op init seq)
  (if (null? seq) init
      (op (car seq)
          (accumulate op init (cdr seq)))))

;Testing
(define test-list (list (list 1 2 3) (list 4 5 6) (list 7 8 9) (list 10 11 12)))

;> (accumulate-n + 0 test-list)
;(22 26 30)


