#lang scheme

;Ex 3.2 - It is often useful to be able to count the number of times a given procedure is called.
;Write a procedure make-monitored that takes as input a procedure f that itself takes one input.

;The result returned by make-monitored is a third procedure mf that keeps track of the number of times
;it has been called by maintaining an internal counter

;If the input to mf is the special symbol how-many-calls then mf returns the  value of the counter
;If the special symbol reset-count is used then mf resets the counter to 0
;For any other input mf returns the result of calling f

(define (make-monitored f) ;Make monitored takes in a procedure, f
  (let ((count 0)) ;Create local count variable
    
  (define (mf input) ;Define inner function
    (cond ((eq? input 'how-many-calls?) count) ;If 'how-many-calls? return count
          ((eq? input 'reset-count) (set! count 0)) ;If 'reset-count then set count back to 0
          (else (begin (set! count (+ count 1)) (f input))))) ;Else apply f to input
    
    mf)) ;Return mf

;
;> (define mon-sqrt (make-monitored sqrt))
;> (mon-sqrt 4)
;2
;> (mon-sqrt 9)
;3
;> (mon-sqrt 'how-many-calls?)
;2
;> (mon-sqrt 'reset-count)
;> (mon-sqrt 'how-many-calls?)
;0