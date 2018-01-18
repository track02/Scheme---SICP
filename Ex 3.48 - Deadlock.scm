#lang scheme

; Ex 3.48
; Explain how the serialized exchange
; procedure avoids deadlock by assigning
; each account an identifier

; If a procedure tries to access a protected accounts
; The account with the lowest id will be activated first

; This helps avoid deadlock in an exchange process
; because no procedure will ever be waiting for another procedure to
; release an account

; All procedures will "queue" up to access the same account
; before all moving onto the next one

; This system gives an ordering to the access order of
; accounts.


; Update make-account to take an additional message which assigns an identifier
(define (make-account-and-serializer balance id) ; account now takes an identifier
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount)) balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount)) balance)
  420
  (let ((balance-serializer (make-serializer)))
    (define (dispatch m)
      (cond ((eq? m 'withdraw) (balance-serializer withdraw))
            ((eq? m 'deposit) (balance-serializer deposit))
            ((eq? m 'balance) balance)
            ((eq? m 'serializer) balance-serializer)
            ((eq? m 'id) id) ; Return identifier when queried
            (else (error "Unknown request: MAKE-ACCOUNT" m))))
    dispatch))

; Update serialized exchange to make use of account id's
(define (serialized-exchange account1 account2)
  (let ((serializer1 ; check account id's to determine which account is first
         (if ((account1 'id) < (account2 'id))
             (account1 'serializer)
             (account2 'serializer)))
        (serializer2 ; and which account is second
         (if ((account1 'id) < (account2 'id))
             (account2 'serializer)
             (account1 'serializer))))
    ((serializer1 (serializer2 exchange))
     account1
     account2)))
