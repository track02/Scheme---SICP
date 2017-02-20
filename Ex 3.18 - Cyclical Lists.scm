#lang sicp


;Exercise 3.18: Write a procedure that examines a list and
;determines whether it contains a cycle, that is, whether a
;program that tried to find the end of the list by taking successive
;cdrs would go into an infinite loop.

;Tortoise & Hare
;Operates using two pointers, tortoise and hare
;General idea is that the hare moves through the list two elements and a time and the tortoise one element
;If there is a cycle the hare will eventually loop around and catch the tortoise

;Steps
;Make a pointer at the start of the list - hare
;Make a pointer at the start of the list - tortoise
;Each iteration, advance hare by two and tortoise by one
;There's a loop if the tortoise and hare meet
;There's no loop if the hare reaches the end

;(t/h)
; A ---> B ---> C ---> D
; ^                    |
; |                    |
; \--------------------/


;        t      h
; A ---> B ---> C ---> D
; ^                    |
; |                    |
; \--------------------/


; h             t
; A ---> B ---> C ---> D
; ^                    |
; |                    |
; \--------------------/


;               h      t
; A ---> B ---> C ---> D
; ^                    |
; |                    |
; \--------------------/

; ht                   
; A ---> B ---> C ---> D
; ^                    |
; |                    |
; \--------------------/


(define (cycle-check input-list)

  (define (tortoise-and-hare t h)
    (cond
      ;End conditions
      ((null? h) #f) ;Check if h is at the end of the list
      ((null? (cdr h)) #f) ;Also need to check cdr, as hare jumps two spaces
      ((eq? h t) #t) ;If hare / tortoise are equal - cycle (Note: eq? returns true if the address of the two arguments is the same)
      (else (tortoise-and-hare (cdr t) (cddr h)))))

  (if (null? input-list) #f
      (tortoise-and-hare input-list (cdr input-list))))


(define looplist (list 'a 'b 'c 'a))
(set-cdr! (cdr (cdr looplist)) looplist)

(define normallist (list 'a 'b 'c 'd 'e))

(define ptrlooplist looplist)

