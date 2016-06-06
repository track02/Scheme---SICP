#lang scheme

;Exercise 2.35 - Implement the count-leaves procedures using accumulate

;Accumlate has the following structure
(define (accumulate op init seq)
  (if (null? seq) init
      (op (car seq)
          (accumulate op init (cdr seq)))))

;count-leaves is implemented as follows
(define (count-leaves x)
  (cond ((null? x) 0)  
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))


;count-leaves-accumulate
(define (count-leaves-accumulate tree)
  (accumulate (lambda (x y)
                (if (pair? x) ;working with trees - need to check for sublists
                    (count-leaves-accumulate x) ;If it's a sublist - work through its elements
                    (+ x y))) ;otherwise simply add the elements - y is the result of adding all elements after x
              0 tree))