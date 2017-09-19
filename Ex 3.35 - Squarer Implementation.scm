#lang scheme

;Exercise 3.35: Ben Bitdiddle tells Louis that one way to
;avoid the trouble in Exercise 3.34 is to define a squarer
;as a new primitive constraint. Fill in the missing portions
;in Ben’s outline for a procedure to implement such a constraint:


(define (squarer a b)
  
  (define (process-new-value)
    (if (has-value? b) ;If B has a value work backwards
        (if (< (get-value b) 0) ;B is less than 0 throw an error
            (error "square less than 0: SQUARER" (get-value b))
            (set-value! a (sqrt (get-value b)) me)) ;Otherwise B is greater than zero - set a to sqrt of B
        (set-value! b (* (get-value a) (get-value a)) me))) ;Otherwise square A
    
    (define (process-forget-value)
      (forget-value! a)
      (forget-value! b)
      (process-new-value))
    
    (define (me request)
      (cond ((eq? request 'I-have-a-value) (process-new-value))
            ((eq? request 'I-lost-my-value) (process-forget-value))
            (else (error "Unknown request: MULTIPLIER" request))))  
    
    (connect a me)
    (connect b me)
    
  me)
