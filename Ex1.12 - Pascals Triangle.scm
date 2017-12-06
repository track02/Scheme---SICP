#lang racket

;A procedure used to calculate the a value from Pascals Triangle at a given row and column
;Rows proceed from 0 to 1 starting at the top of the triangle
;For each row columns proceed from 0 to 1 starting at the leftmost value
;E.g. Row 3 Col 2 would equal 3

;     1
;    1 1
;   1 2 1
;  1 3 3 1
; 1 4 6 4 1


(define (pascalTriangle row col)

  ;If at the top/edges return 1
  (cond ((= row 0) 1) 
        ((= row col) 1) 
        ((= col 0) 1) 
  ;Otherwise, a value can be calculated by summing the two above it
        (else (+ (pascalTriangle (- row 1) (- col 1)) (pascalTriangle (- row 1) col))))) 
  

 
