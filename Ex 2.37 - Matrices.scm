#lang scheme

;Exercise 2.3 Fill in the missing expressions in the following procedures for computing the other matrix operations.
;(The procedure accumulate-n is defined in exercise 2.36.)

;Dot product

;[a1 a2 a3] * [b1 b2 b3] = [a1b1 + a2b2 + a3b3]


;dot product can be defined as
(define (dot-product v w)
  (accumulate + 0 (map * v w)))


;Scalar - single number
;Vector - list of numbers (row or  col)
;Matrix - array of numbers (multiple rows / cols)


;multiply matrix by vector
;[a1 a2 a3]   [b1]     [a1b1 + a2b2 + a3b3]
;[a4 a5 a6] * [b2]   = [a4b1 + a5b2 + a6b3]
;[a7 a8 a9]   [b3]     [a7b1 + a8b2 + a9b3]

;Basically applying dot product row by row
;applying map to a matrix will apply the given procedure to each row (matrix is a list of lists) and return result
;so take dot product of row and vector

(define (matrix-*-vector m v)
  (map (lambda (row) (dot-product row v))  m)) 


;The transpose of a matrix is formed by turning all rows into columns and vice versa

;                      [a1 a4]             
; [a1 a2 a3]           [a2 a5]
; [a4 a5 a6]    ->     [a3 a6]
;
; Only want to join element_i of each sublist together
; accumulate-n operates on element-n of each sublist with each call and joins the created lists
; accumulate-n needs to cons each sublist element together (row to column) and cons the columns together to create a matrix

(define (transpose mat)
  (accumulate-n cons null mat))


;multiplying two matrices

;[a1 a2] * [a5 a6  a7] = [(a1a5 + a2a8) (a1a6 + a2a9)  (a1a7 + a2a10)]
;[a3 a4]   [a8 a9 a10] = [(a3a5 + a4a8) (a3a6 + a4a9)  (a3a7 + a4a10)]

;If second matrix is transposed

; [a5  a8]
; [a6  a9]
; [a7 a10]

;This gives two matrices with same number of columns

;take each row of m as a vector and multiply with transposed matrix
;this produces a row of the product with each application
;make use of previously implemented matrix-*-vector procedure

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (row) (matrix-*-vector cols row)) m))) ;multiplies transposed n by each row of m

;accumulate-n
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

;> (define v (list 1 3 -5))
;> (define w (list 4 -2 -1))
;> (dot-product v w)
;3
;> (define m (list (list 1 2 3) (list 4 5 6)))
;> (define v (list 1 2 3))
;> (matrix-*-vector m v)
;(14 32)
;> (define a (list (list 14 9 3) (list 2 11 15) (list 0 12 17) (list 5 2 3)))
;> (define b (list (list 12 25) (list 9 10) (list 8 5)))
;> (matrix-*-matrix a b)
;((273 455) (243 235) (244 205) (102 160))
