#lang scheme

; Ex 3.38 - Suppose Peter, Paul and Mary share an account
; This account initially contains £100
; Concurrently, Peter deposits £10, Paul withdraws £20
; and Mary withdraws half the money in the account

Peter: (set! balance (+ balance 10))
Paul: (set! balance (- balance 20))
Mary: (set! balance (- balance (/ balance 2)))

; Part A)
; List all possible balances, assuming that each process is run sequentially in some order

; First Process:  £110 (Peter)               | £80 (Paul)                | £50 (Mary)
; Second Process: £90 (Paul) / £55 (Mary)    | £90 (Peter) / £40 (Mary)  | £60 (Peter) / £30 (Paul)
; Third Process:  £45 (Mary) | £35 (Paul)    | £45 (Mary)  / £30 (Peter) | £40 (Paul) /  £40 (Peter)

; Part B)
; If the processes could be interleaved, what are some other values that might be produced
; With interleaving it's possible for a process to execute before the previous has completed

; If Peter interleaves with Paul, the balance left for Mary could be £80 or £110 depending on which completes first
; If Paul interleaved with Mary, the final balance could be either £90 or £55 depending on which complete sfirst
; If all three interleaved, the end value could be £50 if Peter/Paul transactions complete between Mary's Start/End 
