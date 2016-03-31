#lang scheme

;Ex 1.45
;Implement a procedure for computing nth roots
;Making use of fixed-point, average-damp and repeated procedures
;Assuming any arithmetic operations are available as primitives


;Finding roots of equations via the half-interval method
;Root of f is an x value such that f(x) = 0, where f is a continuous function
;If given points a and b such that f(a) < 0 < 0 f(b)
;then f must have at least one zero somewhere between a and b
;To find this zero:
;1. Let x be the average of a and b
;2. Compute f(x)
;3. If f(x) < 0 then the zero must lie between x and b
    ;If f(x) > 0 then the zero must lie between a and x
;4. Depending on the result of step 3. repeat the process
    ;substituting either a or b with x
;5. Keep repeating until the interval is small enough then stop

;Finding fixed points of functions
;A function f has a fix point of f if f(x) = x
;For some functions a fixed point can be found by beginning with
;an initial guess and applying f repeatedly
;f(x), f(f(x)), f(f(f(x))),...
;until the value does not change much

;Square roots can be found by finding fixed point
;Sqrt = y -> x/y
;Cbrt = y -> x/y^2
;A function whose value at y is x/y
;Where f(y) = y 

;Tolerance used to stop process
(define tolerance 0.00001)

;Finds nth root of x
(define (n-root x n)
  (fixed-point
   ((repeated average-damp (floor (log2 n))) ;Determine no. repeats by log2 of n, remembering to floor result to integer
             (lambda (y) (/ x (expt y (- n 1)))))
   1.0))

;Testing shows that a new average-damp is required
;whenever n doubles

;E.g. with 3 average damps the procedure fails at finding the 16th root
;> (n-root 8192 13)
;2.0000029085658984
;> (n-root 16384 14)
;1.9999963265447058
;> (n-root 32768 15)
;2.0000040951543023
;> (n-root 65536 16)
;[Hangs]


;1,2,4,8,16,32, .... [n]
;0,1,2,3,4,5, .....  [average-damp repeats needed]

;This relationship can be mapped as follows
;2^[avg-damp] = n

;Using logs we can find x
;n = 2^x -> log2(n) = x 

;Scheme only provides a log function for natural log (e)
;So need we procedure to calculate log 2 
(define (log2 x)
  (/ (log x) (log 2)))

;> (log2 4)
;2.0
;> (log2 5)
;2.321928094887362
;> (log2 6)
;2.584962500721156
;> (log2 7)
;2.807354922057604
;> (log2 8)
;3.0


;Fixed point procedure
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

;Average damp procedure
(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (average x y)
  (/ (+ x y) 2))


;Repeated / Compose 
(define (repeated f i)
  (if (= i 1) ;If 1 is one, return function
      f
      (compose f (repeated f (- i 1))))) ;Otherwise "add" another function call, reduce counter

(define (compose f g)
  (lambda (x)
    (f(g x))))

