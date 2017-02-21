#lang scheme

;We can implement mutable
;data objects as procedures using assignment and local state. For
;instance, we can extend the above pair implementation to handle setcar!
;and set-cdr!


(define (cons x y)
  (define (set-x! v) (set! x v))
  (define (set-y! v) (set! y v))
  (define (dispatch m)
    (cond ((eq? m 'car) x)
          ((eq? m 'cdr) y)
          ((eq? m 'set-car!) set-x!)
          ((eq? m 'set-cdr!) set-y!)
          (else
           (error "Undefined operation: CONS" m))))
  dispatch)

(define (car z) (z 'car))
(define (cdr z) (z 'cdr))
(define (set-car! z new-value)
  ((z 'set-car!) new-value) z)
(define (set-cdr! z new-value)
  ((z 'set-cdr!) new-value) z)

;Exercise 3.20: Draw environment diagrams to illustrate
;the evaluation of the sequence of expressions

(define x (cons 1 2))
(define z (cons x x))
(set-car! (cdr z) 17)
(car x)


;(define x ...) and (define z ...)
;Creates new bindings in global which point to frames E1 and E2 holding local bindings

;
; Global Env
; _____________________________
;| cons ------------------------|-----> (x)(x)----> Param: x y
;| x--|                         |<-------|          Body: cons body
;| z--|-----------------|       |
;|____|_________________|_______|
;    |                  |
;    | [x]              |--------------------------------------|  [z]
;    V              __________                                 V                      __________
;   (x)(x)-------->| E1       |                              (x)(x) --------------->| E2       |
;   Param x,y      | x: 1     |                              Param x,y              | x: x     |
;   Body: ...      | y: 2     |                              Body ...               | y: x     |
;                  | set-x ---|------------------>(x)(x)<---------------------------| set-x    |
;                  | set-y ---|------------------>(x)(x)<---------------------------| set-y    |
;                  | dispatch-|------------------>(x)(x)<---------------------------| dispatch |
;                  |          |               Internal Procedures                   |          |
;                  |__________|                (are these shared?)                  |__________|
;
;

;(set-car! (cdr z) 17)

;First (cdr z) is evaluated to (cdr z) (z 'cdr))
;This is a call to z's dispatch with the 'cdr symbol
;A new frame is created pointing to E2 for the call to dispatch
;resulting in the object bound to y (x)

; _________
;|E2       |
;|x: x     |
;|y: x     |
;|set-x    |
;|set-y    |
;|dispatch |
;|_________|
;    ^
;    |
;    |
; ___|_____
;|E3       |
;|m: 'cdr  |
;|_________|
;

;Now we are evaluating
;(set-car! x 17)
;This firstly evaluates to
;((z 'set-car!) new-value))
;So a new frame is created E4 which points to E1 (working with x now)
;(z 'set-car!) is a call to x's dispatch with 'set-car symbol
;This results in the set-x! procedure
;

;Now we are evaluating
;(set-x! 17)

;A new frame is created, and results in the x value being updated to 17


; A call to (car x) results in a call to dispatch with the 'car symbol as an argument
; A new frame is created 

; _________
;|E1       |
;|x:  17   |
;|y: 2     |
;|set-x    |
;|set-y    |
;|dispatch |
;|_________|
;    ^  ^  ^
;    |  |  |_____________________
;    |  |_________               |
; ___|________  __|_______  _____|____
;|E4          ||E5        ||E6        |
;|m: 'set-car ||v: 17     ||m: 'car   |
;|new-vale: 17||          ||          |
;|____________||__________||__________| 
;  [set-car!]    [set-x!]   [car x]

