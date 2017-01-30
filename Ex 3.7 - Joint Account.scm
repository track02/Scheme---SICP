#lang scheme

;Exercise 3.6 - Consider the bank account objects created by make-account,
;with the password modification described in Exercise 3.3.

;Suppose that our banking system requires the ability to make joint accounts.
;Define a procedure make-joint that accomplishes this.

;make-joint should take three arguments.
;The first is a password-protected account.

;The second argument must match the password with which the account was defined
;in order for the make-joint operation to proceed.

;The third argument is a new password.

;makejoint is to create an additional access to the original account
;using the new password.

;E.g. (define paul-acc (make-joint peter-acc 'open-sesame 'rosebud))

;A call to make-account sets up an environment two local state variables:
;balance
;password
;Within this environment three procedures are setup, withdraw, deposit and dispatch
;dispatch is used to select and return a procedure (message passing)
;dispatch is then returned itself and represents the bank-account object
(define (make-account balance password)

  ;If we'll have multiple passwords - lets store them in a list
  (define password-list (list password))
  
  (define (withdraw amount) ;Withdraw, subtracts an amount from the balance
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  
  (define (deposit amount) ;Deposit, adds an amount to the balance
    (set! balance (+ balance amount))
    balance)

  ;Adds a new password to the password list and returns dispatch (the new account)
  (define (add-new-password new-password)
    (set! password-list (append password-list (list new-password)))
    dispatch)
  
  
  (define (dispatch m pw) ;Dispatch, this procedure is 'returned' on the creation of an account
    (if (check-password password-list pw) ;Wrap access to the procedure in a password check
        (cond ((eq? m 'withdraw) withdraw) ;Dispatch provides a public facing interface to the encapsulated procedures
              ((eq? m 'deposit) deposit)
              ((eq? m 'add-new-password) add-new-password)
              (else (error "Unknown request: MAKE-ACCOUNT"
                           m)))
        (error "Incorrect Password")))
  
  ;We'll also implement a procedure to check a given password against what's in the list
  (define (check-password passwords input_pw)
    (cond ((null? passwords)  #f) ;Exhausted list
          ((eq? (car passwords) input_pw) #t)
          (else (check-password (cdr passwords) input_pw))))    

  ;Return the account (represented by the dispatch function)
  dispatch)

 

;> (define acc (make-account 100 'itsasecret))

;> ((acc 'withdraw 'itsasecret) 50)
;50

;> ((acc 'deposit 'itsasecret) 150)
;200

;> (define joint-acc (make-joint acc 'itsasecret 'mynewpassword))

;> ((joint-acc 'deposit 'mynewpassword) 50)
;250

;> ((joint-acc 'withdraw 'itsasecret) 75)
;175

;Another solution is to wrap the account in a second dispatch layer
(define (make-joint acc account-password new-password)
  (define (wrap-dispatch operation password)
    (if (eq? password new-password)
        (acc account-password operation)
        (error "Incorrect Joint Password")))
  wrap-dispatch);
