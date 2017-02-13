#lang scheme

;Note - set-car / set-cdr are now in the mpair module
;Mutable lists and operators begin with m-
(require scheme/mpair)

(define x (mlist 'a 'b))
(define z1 (mcons x x))
(define z2 (mcons (mlist 'a 'b) (mlist 'a 'b)))


(define (set-to-wow! x) (set-mcar! (mcar x) 'wow) x)

z1
;{{a b} a b}
z2
;{{a b} a b}

(set-to-wow! z1)
;{{wow b} wow b}
(set-to-wow! z2)
;{{wow b} a b}

;Exercise 3.15: Draw box-and-pointer diagrams to explain
;the effect of set-to-wow! on the structures z1 and z2 above.

;set-to-wow! functions by updating the car of the given list (x) to 'wow

;Remember - car of z1 is the list x, so the car of x will be updated!


;Before Call to set-to-wow!
;        a          b
;x ---> [x][x]---->[x][o]
;        ^^-\
;        |  |
;        |  |
;z1 --->[x][x]
;
;        a          b
;       [x][x]---->[x][o]
;        ^
;        |
;        |
;z2 --->[x][x]
;           |
;        ___|
;        |
;        V
;       [x][x]---->[x][o]
;        a          b


;After Call to set-to-wow!
;       'wow        b
;x ---> [x][x]---->[x][o]
;        ^^-\
;        |  |
;        |  |
;z1 --->[x][x] 
;
;       'wow           b
;       [x][x]---->[x][o]
;        ^
;        |
;        |
;z2 --->[x][x]
;           |
;        ___|
;        |
;        V
;       [x][x]---->[x][o]
;        a          b
