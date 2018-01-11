#lang scheme

; Exercise 3.44: Consider the problem of transferring an amount
; from one account to another.

; Ben Bitdiddle claims that this can be accomplished
; with the following procedure, even if
; there are multiple people concurrently transferring money
; among multiple accounts, using any account mechanism
; that serializes deposit and withdrawal transactions.

(define (transfer from-account to-account amount)
  ((from-account 'withdraw) amount)
  ((to-account 'deposit) amount))

; Louis Reasoner claims that there is a problem here, and
; that we need to use a more sophisticated method, such as
; the one required for dealing with the exchange problem.

; Is Louis right? If not, what is the essential difference between
; the transfer problem and the exchange problem? (You should
; assume that the balance in from-account is at least the amount needed.)

; The previous exchange procedure accessed each account twice
; Once during the difference calculation and again during the add/subtract
; This could lead values being written due to overlap with another exchange
; in the middle of these two account accesses

; Here each account is accessed only a single time add / subtract
; And no matter the order of operations the balance will remain the same.
; There is no chance for incorrect values to be introduced/