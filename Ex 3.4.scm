#lang scheme

;Ex 3.4, Modify 3.3 by adding another local state variable which counts the no. of times
;an account is accessed with an incorrect password.

;A call to make-account sets up an environment two local state variables:
;balance
;password
;Within this environment three procedures are setup, withdraw, deposit and dispatch
;dispatch is used to select and return a procedure (message passing)
;dispatch is then returned itself and represents the bank-account object
(define (make-account balance password) 
  (define wrong-pw-count 0) ;Local variable to count no. times incorrect password is used, can use define instead of let
  
  (define (withdraw amount) ;Withdraw, subtracts an amount from the balance
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  
  (define (deposit amount) ;Deposit, adds an amount to the balance
    (set! balance (+ balance amount))
    balance)
  
  (define (call-the-cops)
    (display "Calling the cops!"))
  
  (define (dispatch m pw) ;Dispatch, this procedure is 'returned' on the creation of an account
    (if (eq? pw password) ;Wrap access to the procedure in a password check
        (cond ((eq? m 'withdraw) withdraw) ;Dispatch provides a public facing interface to the encapsulated procedures
              ((eq? m 'deposit) deposit)
              (else (error "Unknown request: MAKE-ACCOUNT"
                           m)))
        (begin (set! wrong-pw-count (+ wrong-pw-count 1)) ;If password is wrong, increment counter
               (if (>= wrong-pw-count 7) ;If counter >= 7 invoke call-the-cops
                   ;Remember, dispatch returns a procedure - so create a lambda which accepts an argument (amount)
                   ;But does nothing with it, instead it prints out a warning message or calls the cops
                   (lambda (x) (call-the-cops))
                   (lambda (x) (begin
                                 (display "Incorrect password, attempts remaining: ")
                                 (display (- 7 wrong-pw-count))))))))
  
  dispatch)

;Testing

;> (define acc (make-account 100 'pw))

;> ((acc 'withdraw 'pq) 1000)
;Incorrect password, attempts remaining: 6
;> ((acc 'withdraw 'pq) 1000)
;Incorrect password, attempts remaining: 5
;> ((acc 'withdraw 'pq) 1000)
;Incorrect password, attempts remaining: 4
;> ((acc 'withdraw 'pq) 1000)
;Incorrect password, attempts remaining: 3
;> ((acc 'withdraw 'pq) 1000)
;Incorrect password, attempts remaining: 2
;> ((acc 'withdraw 'pq) 1000)
;Incorrect password, attempts remaining: 1
;> ((acc 'withdraw 'pq) 1000)
;Calling the cops!
