#lang scheme

; Ex 3.36 - Consider the evaluation of the following sequence in the global env
; (define a (make-connector))
; (define b (make-connector))
; (set-value! a 10 'user)

; As some time during the evaluation of set-value! the following expression from the
; connector's local procedure is evaluated

; (for-each-except
;    setter inform-about-value constraints)

; Produce an environment diagram showing the environment in which the above expression is evaluated
; Environment creation is described below

; Firstly make-connector is evaluated twice, each time 'me' is returned
; 'me' is itself a procedure enclosed in an environment containing set-value, forget-my-value, connect
; a and b refer to unique instances of 'me'
; 'me' is enclosed within a let-statement and as such contains local state for value, informant and constraint 
; set-value is then called creating a new frame refering to global (e1)
; this is evaluated and a request is made to the 'me' procedure held by a
; a new frame is created referencing the 'me' frame (e2) as this is where set-value is defined
; this is evaluated a results in the set-my-value procedure being called, creating a new frame (e3), referencing 'me' as this is where set-my-value is defined
; during the execution of set-my-value for-each-except is executed creating another environment (e4), referencing global as this is where for-each-except is defined
; executing for-each-except causes the internal procedure loop to executing creating a final 5th frame (e5), referencing e4


;