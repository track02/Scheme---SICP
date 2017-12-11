#lang racket

;Making use of the following transformations
;T [a <- a + b,  b <- a] (Regular fibonacci proccedure - repeatedly apply T n times to produce the pairs Fib(n+1) and Fib(n)
;Tpq [a <- bq + aq + ap, b <- bp + aq] where T is a special case (p = 0 and q = 1)
;Applying Tpq twice is the equivalent of applying Tp'q' once

;Can use substitution to determine how p' and q' are calculated
;
; a <- bq + aq + ap
; b <- bp + aq

; a <- b(q) + a(q) + a(p)
; b <- b(p) + a(q)

; Find next values of a,b by using current
; a2 <- (b1)(q) + (a1)(q) + (a1)(p)
; b2 <- (b1)(p) + (a1)(q)

; Substitute (bq + aq + ap) for a1 and (bp + aq) for b1
; a2 <- (bp+aq)(q) + (bq + aq + ap)(q) + (bq + aq + ap)(p)
; b2 <- (bp + aq)(p) + (bq + aq + ap)(q)

; a2 <- bpq + aqq + bqq + aqq + apq + bqp + aqp + app
; b2 <- bpp + aqp + bqq + aqq + apq

; Remember
; b2 <- b(p') + a(q')

; Rearrange expansion
; b2 <- b(pp + qq) + a(2qp + qq)

; p' = p^2 + q^2
; q' = 2qp + q^2

; Verify using transformation for a
; a2 <- b(q') + a(q') + a(p')
; a2 <- b(2pq + qq) + a(2pq + qq) + a(qq + pp)

;Complete the iterative fibonacci procedure
;Allow for a logarithmic number of steps


(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
    (cond ((= count 0) b)
          ((even? count)
           (fib-iter a
                     b
                     (+(* p p)(* q q)) ;Compute p'
                     (+(* 2 q p)(* q q)) ;Compute q'
                     (/ count 2)))
          (else (fib-iter (+ (* b q) (* a q) (* a p))
                          (+ (* b p) (* a q))
                          p
                          q
                          (- count 1)))))
