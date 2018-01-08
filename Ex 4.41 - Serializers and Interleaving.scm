#lang scheme
 
; Exercise 3.41: Ben Bitdiddle worries that it would be better
; to implement the bank account as follows
; (where the commented line has been changed):

; because allowing unserialized access to the bank balance
; can result in anomalous behavior. Do you agree? Is there
; any scenario that demonstrates Ben’s concern?

; I do not think this is necessary
; because deposit/withdraw are serialized, access to balance can only occur
; before or after these operations execute or complete
; balance cannot be accessed in the middle of an operation
; serializing balance itself has no effect as balance is a single step operation
; so there is no possibility of interleaving.


(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance
                     (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (let ((protected (make-serializer)))
    (define (dispatch m)
      (cond ((eq? m 'withdraw) (protected withdraw))
            ((eq? m 'deposit) (protected deposit))
            ((eq? m 'balance) ((protected (lambda () balance)))) ; serialized
            (else
             (error "Unknown request: MAKE-ACCOUNT"
                    m))))
    dispatch))