#lang scheme

;Exercise 3.12: e following procedure for appending lists
;was introduced in Section 2.2.1:

(define (append x y)
  (if (null? x)
      y
      (cons (car x) (append (cdr x) y))))

;append forms a new list by successively consing the elements
;of x onto y.


;e procedure append! is similar to
;append, but it is a mutator rather than a constructor. It appends
;the lists by splicing them together, modifying the final
;pair of x so that its cdr is now y. (It is an error to call
;append! with an empty x.)

(define (append! x y)
  (set-cdr! (last-pair x) y)
  x)

;Here last-pair is a procedure that returns the last pair in
;its argument:

(define (last-pair x)
  (if (null? (cdr x)) x (last-pair (cdr x))))

;Consider the interaction

(define x (list 'a 'b))
(define y (list 'c 'd))
(define z (append x y))
z
;>(a b c d)
(cdr x)

;
; X ---> [x][x]----->[x][o]
;         |           |
;         A           B

;
; Y ---> [x][x]----->[x][o]
;         |           |
;         C           D


;         A             B              C               D
;         |             |              |               |
; Z ---> [x][x] -----> [x][x] ------> [x][x] -------> [x][o[



;>'(b)

;append! modifies the data bound to x, and sets its cdr to the last pair of y
(define w (append! x y))
w
;>(a b c d)
(cdr x)

;         A             B              C               D
;         |             |              |               |
; X ---> [x][x] -----> [x][x] ------> [x][x] -------> [x][o[
;                                      ^
;                                      |
;                          Y  ---------/
;

;>'(b c d)

;What are the missing results?
;Draw box-and-pointer diagrams to explain your answer.