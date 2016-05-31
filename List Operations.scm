#lang scheme

(define x (list 1 2 3))
(define y (list 1 2 (list 3 4 5) 6))

(define (iterate-forwards input)
  (cond [(pair? (car input)) (iterate-forwards (car input))]
        [else   (display (car input))])
  
  (cond [(not (null? (cdr input))) (iterate-forwards (cdr input))]))

(define (reverse input)
  (if (null? input) null
      (append (reverse (cdr input))
              (cond [(pair? (car input)) (reverse (car input))]
                    [else (list (car input))]))))
              
(define (iterate-backwards list)
  (iterate-forwards (reverse list)))

(define (map proc input)
  (if (null? input) null
  (cons (cond [(pair? (car input)) (map proc (car input))]
              [else(proc (car input))])
        (map proc (cdr input)))))