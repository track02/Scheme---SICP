#lang scheme


;Ex 3.3 Modify the make-account procedure so that it creates password-protected accounts.
;at is, make-account should take a symbol as an additional argument

;A call to make-account sets up an environment two local state variables:
;balance
;password
;Within this environment three procedures are setup, withdraw, deposit and dispatch
;dispatch is used to select and return a procedure (message passing)
;dispatch is then returned itself and represents the bank-account object
(define (make-account balance password) 
  
  (define (withdraw amount) ;Withdraw, subtracts an amount from the balance
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  
  (define (deposit amount) ;Deposit, adds an amount to the balance
    (set! balance (+ balance amount))
    balance)
  
  (define (dispatch m pw) ;Dispatch, this procedure is 'returned' on the creation of an account
    (if (eq? pw password) ;Wrap access to the procedure in a password check
        (cond ((eq? m 'withdraw) withdraw) ;Dispatch provides a public facing interface to the encapsulated procedures
              ((eq? m 'deposit) deposit)
              (else (error "Unknown request: MAKE-ACCOUNT"
                           m)))
        (error "Incorrect Password")))
   
  dispatch)

;> (define acc (make-account 100 'itsasecret))
;> ((acc 'withdraw 'itsasecret) 50)
;50
;> ((acc 'deposit 'itsasecret) 150)
;200
;> ((acc 'withdraw 'pwguess) 1000)
; Incorrect Password

