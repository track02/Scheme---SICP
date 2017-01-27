#lang scheme

;Exercise 1.37 (Part A)
;A continuous fraction has the form
;f = N1 / D1 + N2 / D2 + N3 / D3 + ...
;Truncating the expansion after a given number of terms
;produces a k-term finite continued fraction which has the form
; N1 / D1 + N2 / D2 + N3 / D3 + Nk / Dk

;Supposing n and d are procedures of one argument (term index i)
;that return the Ni and Di of the terms of the continued fraction
;Write a procedure, cont-frac of the form (cont-frac n d k)
;cont-frac should compute the value of the k-term finite continued fraction

(define (cont-frac n d k) 
  (define (divide i)
    (if (< i k)
        (/ (n i) (+ (d i) (divide (+ i 1))))
        (/ (n i) (d i))))
  (divide 1))
  
;Test the procedure by evaluating:
;(cont-frac (lambda (i) 1.0)
;            (lambda (i) 1.0)
;            5)

; >>> 0.625 (1 / golden ratio)  
