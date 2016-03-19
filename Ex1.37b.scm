#lang scheme

;A continuous fraction has the form
;f = N1 / D1 + N2 / D2 + N3 / D3 + ...
;Truncating the expansion after a given number of terms
;produces a k-term finite continued fraction which has the form
; N1 / D1 + N2 / D2 + N3 / D3 + Nk / Dk

;Supposing n and d are procedures of one argument (term index i)
;that return the Ni and Di of the terms of the continued fraction
;Write a procedure, cont-frac of the form (cont-frac n d k)
;cont-frac should compute the value of the k-term finite continued fraction

;Exercise 1.37b -> Write an iterative version of cont-frac

(define (cont-frac-iter n d k)
  (define (divide-iter i result)
    (if (= i 0)
        result ;Reached end state -> return result
        (divide-iter (- i 1) (/ (n i) (+ (d i) result))))) ;Otherwise, reduce i and update result, result = ni / di + result
    (divide-iter (- k 1) (/ (n k) (d k)))) ;Start process - setting result as n1 / d1
