#lang racket


;Exercise 3.14: e following procedure is quite useful, although obscure:

(define (mystery x)
  (define (loop x y)
    (if (null? x)
        y
        (let ((temp (cdr x)))
          (set-cdr! x y)
          (loop temp x))))
  (loop x '()))

;loop uses the “temporary” variable temp to hold the old value of the cdr of x,
;since the set-cdr! on the next line destroys the cdr.

;Explain what mystery does in general.


;Mystery reverses the given list

;Given a list mystery passes it to the inner procedure loop as x along with an empty list '() as y
;loop works by storing the cdr from x in a variable (temp)
;loop then updates the cdr of x  with y
;on the first step this sets x to the first element of the list (a b c) -> (a), with the cdr stored in temp (b c)
;loop calls itself again, passing temp (the cdr) as x (b c) and the updated x as y (a)
;The process repeats, storing the cdr of x as a temp (c) and updating the cdr of x with y (b a)
;Then again resulting in a temp of '() and x of (c b a)
;Temp is null -> return y, (c b a)

;Suppose v is defined by (define v (list 'a 'b 'c 'd)).
;Draw the box-and-pointer diagram that represents the list to which v is bound.

;         a         b         c          d
; V ---> [x][x]--->[x][x]--->[x][x]---->[x][o]
;


;Suppose that we now evaluate:

(define w (mystery v))

;Draw box-and-pointer diagrams that show the structures v and w aer evaluating this
;expression.

;         d         c         b         a
; W ---> [x][x]--->[x][x]--->[x][x]--->[x][o]
;                                       ^
;                                       |
;                                       V

;In the first pass, the cdr of V is set to '()
;The list is then rearranged and and V is pushed to the end as the cdr is set


;What would be printed as the values of v and w?

; w
;>(d,c,b,a)
; v
;>(a)
