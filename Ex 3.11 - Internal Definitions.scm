#lang scheme

;Exercise 3.11: In Section 3.2.3 we saw how the environment
;model described the behavior of procedures with local
;state. Now we have seen how internal definitions work.

;A typical message-passing procedure contains both of these
;aspects. Consider the bank account procedure of Section 3.1.1:

(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else
           (error "Unknown request: MAKE-ACCOUNT"
                  m))))
  dispatch)

;Show the environment structure generated by the sequence of interactions

(define acc (make-account 50))
((acc 'deposit) 40)
((acc 'withdraw) 60)

;   ______________________________
; /           GLOBAL ENV          \ <-------\  /----------> Param: initial-amount
; |                                |        |  |            Body: <....>
; | make-account ----------------- |-----> [x][x]
; | acc------------------\         |
; |                      |         |
;  \_____________________|________/           
;                  ^     |
;                  |     |
;                  |     |
;                  |     V             (Env 1)
;                  |--- [X][X]-------> Balance: 50
;                                      Withdraw ---------->[X][X] Env2
;                                      Deposit  ---------->[X][X] Env3
;                                      Dispatch ---------->[X][X] Env4
;                                       ^     ^
;                                       |     |
;                                       |     \------\ 
;                                   m: 'deposit      |
;                                                    |
;                                                    |
;                                                 amount: 40
;
;
;Call to define acc binds a procedure object to acc, which points back to the global environment
;and to a new frame which consists of bindings of the balance and internal definitions
;
;Each internal definition is bound to its own procedure object which itself points back to E1 and to a frame consisting of args/body
;
;Calling ((acc 'deposit) 40) causes a new frame to be created pointing to Env1 (where dispatch is defined)
;This is turn results in the evaluation of (deposit 40) in a third frame pointing Env1 which updates the balance

;A call to ((acc 'withdraw) 60) would function in the same way, instead with withdraw executing rather than deposit
;The additional frames are discarded once execution is complete

;Where is the local state for acc kept?

;The local state is kept within the separate frame/environment, bound to balance

;Suppose we defineanother account
(define acc2 (make-account 100))

;How are the local states for the two accounts kept distinct?

;A second independent environment will be created for acc2, keeping the internal state separate from acc

;Which parts of the environment structure are shared between
;acc and acc2?

;Both share the global environment