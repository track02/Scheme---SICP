#lang scheme

; Exercise 3.49:

; Give a scenario where the deadlock-avoidance
; mechanism described above does not work.

; (Hint: In the exchange problem, each process knows
; in advance which accounts it will need to get access to.
; Consider a situation where a process must get access
; to some shared resources before it can know which additional
; shared resources it will require.)

; Acquiring resources in order of lowest-id to highest will not be suitable
; if we only know the resources to be modified once acquiring the lock
; and if the order of operation execution is important
; I.E it may not be possible to modify a1 first in the exchange
; E.g. - Database modifications
