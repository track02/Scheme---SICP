#lang scheme

;Exercise 3.27: Memoization (also called tabulation) is a technique
;that enables a procedure to record, in a local table,
;values that have previously been computed. is technique
;can make a vast difference in the performance of a program.

;A memoized procedure maintains a table in which values
;of previous calls are stored using as keys the arguments
;that produced the values. When the memoized procedure
;is asked to compute a value, it first checks the table to see
;if the value is already there and, if so, just returns that value.

;Otherwise, it computes the new value in the ordinary way
;and stores this in the table. As an example of memoization,
;recall from Section 1.2.2 the exponential process for computing
;Fibonacci numbers:

;e memoized version of the same procedure is
(define memo-fib
(memoize ;Pass in a lambda form fib procedure to memoize
(lambda (n)
(cond ((= n 0) 0)
((= n 1) 1)
(else (+ (memo-fib (- n 1))
         (memo-fib (- n 2))))))))

;where the memoizer is defined as

(define (memoize f) ;Given a function f
  (let ((table (make-table)))  ;Local table
    (lambda (x) ;Returns function that takes x
      (let ((previously-computed-result ;Check local table for x and store result
             (lookup x table)))
        ;if previous result is true its returned
        ;otherwise calculate and store a new result
        ;(or #f 1) -> 1
        ;(or 3 #f) -> 3
        (or previously-computed-result 
            (let ((result (f x)))
              (insert! x result table)
              result))))))

;Draw an environment diagram to analyze the computation
;of (memo-fib 3). Explain why memo-fib computes the nth
;Fibonacci number in a number of steps proportional to n.

;memo-fib calculates each fibonacci value and saves the result in its table
;as the previous values are already available in the table
;there is no repeated execution of the entire fibonacci calculation
;so performance is constant or O(N)

;Would the scheme still work if we had simply defined memofib
;to be (memoize fib)?

;This will not function if we used (memoize fib)
;(fib x) is enclosed by the global environment
