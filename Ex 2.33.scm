#lang scheme

;Exercise 2.33. Fill in the missing expressions to complete the following definitions of some basic
;list-manipulation operations as accumulations: 


;Accumlate has the following structure
(define (accumulate op init seq)
  (if (null? seq) init
      (op (car seq)
          (accumulate op init (cdr seq)))))

;Apply procedure to car and join to y (accumulate of cdr)
(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) null sequence))

;Iterate through seq1 then cons seq2 as the init
(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

;Increment a counter with each call, ignoring car
(define (length sequence)
  (accumulate (lambda (x y) (+ 1 y)) 0 sequence))

;Testing

;Square function
(define (square x) (* x x))

;Test lists
(define x (list 1 2 3 4))
(define y (list 5 6 7))

;> (map square x)
;(1 4 9 16)

;> (append x y)
;(1 2 3 4 5 6 7)

;> (length x)
;4