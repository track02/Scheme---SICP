#lang scheme

; Exercise 3.43: Suppose that the balances in three accounts
; start out as $10, $20, and $30, and that multiple processes
; run, exchanging the balances in the accounts.

; Argue that if the processes are run sequentially,
; afer any number of concurrent exchanges,
; the account balances should be $10, $20,
; and $30 in some order.

; /****************************************************************\
; If the processes are run sequentially then the order doesn't matter
; a + b - c = -c + b + a
; /****************************************************************\

; Draw a timing diagram like the one in Figure 3.29
; to show how this condition can be violated
; if the exchanges are implemented using the first version of
; the account-exchange program in this section.

(define (exchange account1 account2)
  (let ((difference (- (account1 'balance)
                       (account2 'balance))))
    ((account1 'withdraw) difference)
    ((account2 'deposit) difference)))

; /*****************************************************************\
; In the original version of the account-exchange program the withdraw
; and deposit procedures are serialized on a single resource but not
; across resources.

; This means that multiple withdraw process can
; take place on the same account simultaneously

; As while the withdraw / deposit are serialised within one exchange process
; The concurrent sets of these procedures are not serialised and may
; overlap with each other, only the procedures within cannot 

;  Withdraw - 1
;  Calc Diff                  Withdraw - 2
;  Withdraw A                 Calc Diff
;  Deposit B                  Withdraw B
;                             Deposit C                              


; Consider the transfer of a1 -> a2 -> a3
; <Parallel Execution>
; (exchange a1 a2) ;P1
; (exchange a2 a3) ;P2

; Where a1 = 10, a2 = 20, a3 = 30 

; P1
; difference = a1 - a2 ; P11
; from a1 withdraw difference ;P12
; to a2 deposit difference ;P13

;P2
; difference = a2 - a3 ; P21
; from a2 withdraw difference ;P22
; to a3 deposit difference ;P23


; P11 (-10)              P21 (-10)
; P12 (a1 = 20)          P22 (a2 = 30)
;                        P23 (a3 = 20)
; P13 (a2 = 20)

; Now a1 = 20, a2 = 20, a3 = 20
; /*****************************************************************\


; On the other hand, argue that even with this exchange program, the sum
; of the balances in the accounts will be preserved.

; /*****************************************************************\
; 20 + 20 + 20 = 10 + 20 + 30
; /*****************************************************************\

; Draw a timing diagram to show how even this condition would be
; violated if we did not serialize the transactions on individual
; accounts.

; If no serialisation is present on individual accounts then the
; same situations can still occur
