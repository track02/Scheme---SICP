#lang scheme

; Ex 1.29 - Implement Simpsons Rule for numerical integration



;Sum - higher order procedure, manipulates procedures
;Using provided procedures (term, next) calculate the sum from a to b
(define (sum term a next b)
  (if (> a b) ;If a is greater than b, stop we've hit limit
      0
      (+ (term a) ;Otherwise recursively add f(a) to f(a+1) to f(a+2) ... 
         (sum term (next a) next b))))

;Cubes a value
(define (cube x)
  (* x x x))

;Calculate integral of a function between limits a,b
;(a,b) f = f[(a + dx/2) + f(a + dx + dx/2) + f(a + 2dx + dx/2) + ... ]
(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))

;Simpsons Rule
;Integral for a function between limits a,b is approximated as
;
;
; h/3[y(0) + 4y(1) + 2y(2) + 4y(3) + 2y(4) + ... + 2y(n-2) + 4y(n-1) + y(n)]
; Bracket value (0) (1) (2) are k
;
;Where h = (b - a) / n for some even integer n
;y(k) = f(a + kh)
(define (integral-simpson f a b n)
  (define h (/ (- b a) n)) ;Calculates h
  (define (next a) (+ a 1)) ;Increment counter by 1 (Next procedure in Sum)
  (define (y k) (f (+ (* k h)))) ;Find next y (part of term procedure in Sum)
  (define (term k) ;Depending on if k is odd,even, 0 or 1, y must be multiplied by a value
    (cond
      [(or (= k 0) (= k n)) (y k)] ;0 or N 
      [(even? k) (* 2 (y k))]      ;Even
      [(not (even? k)) (* 4 (y k))];Odd
      )    
  )
  (* (sum term 0 next n) (/ h 3)))
  
(define (even? n)
  (= (remainder n 2) 0))
