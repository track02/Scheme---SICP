#lang racket

;The function f(n) is defined as follows:
;If n < 3 -> n
;Else f(n) = f(n - 1) + 2f(n - 2) + 3f(n - 3)


;Recursive process - operations deferred until needed
(define (f-rec n)
  (cond ((< n 3) n)
        (else (+ (f-rec (- n 1))
                 (* 2 (f-rec (- n 2)))
                 (* 3 (f-rec (- n 3)))))))

;Iterative process - keep track of state using inner function f-itr
;Work up from f(0) to f(n) instead, keeping a running total
(define (f n)

  ; a -> f(count - 1, b -> f(count - 2), c -> f(count - 3)
  (define (f-itr a b c count)
    ;n is present in outer routine - so available here (block structure scoping)
    (if (= count n)
        ;If we are at f(n) then calculate f(n) using f(n-1) + 2f(n - 2) + 3f(n - 3), using the three parameters present (a, b, c)
        (+ a (* 2 b) (* 3 c))
        ;Otherwise want to calculate f(count + 1) so need to call f-itr(f(count), f(count - 1), f(count -2))
        ;f(count) -> f(count - 1) + 2f(count-2) + 3f(count - 3) [a, b, c - parameters we currently have]
        ;Have new value for a (count - 1), push previous values down -> b = a, c = b
        (f-itr (+ a (* 2 b) (* 3 c)) a b (+ count 1))))
             
  
  (if (< n 3)
      n
      (f-itr 2 1 0 3))) ;Starting from f(3) work up to f(n)
