#lang scheme

;Exercise 3.9:
;In Section 1.2.1 we used the substitution model
;to analyze two procedures for computing factorials, a recursive version

(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))

;and an iterative version

(define (factorial n) (fact-iter 1 1 n))
(define (fact-iter product counter max-count)
  (if (> counter max-count)
      product
      (fact-iter (* counter product)
                 (+ counter 1)
                 max-count)))

;Show the environment structures created by evaluating
;(factorial 6) using each version of the factorial procedure.


;A procedure is created by evaluating a lambda expression relative to a given environment
;The resulting procedure object is a pair cosisting of the lambda-expression text
;and a pointer to the environment in which the procedure was created

;A procedure object is applied to a set of arguments by constructing a frame
;binding the formal parameters of the procedure to the arguments of the call
;and evaluating the body of the procedure in the context of the new environment constructed
;The new frame has as its enclosing environment the environment same environment of the procedure object
;being applied

;Recursive

;   ______________________________
; /           GLOBAL ENV           \ <-------\        
; |                                 |        |   
; | factorial ----------------------|-----> [x][x]
; |                                 |           |
;  \_______________________________/            |
;   ^     ^    ^    ^    ^    ^                 \-----> parameters : n
;   F1    F2   F3   F4   F5   F6                        body: <........>
;   n:6   n:5  n:4  n:3  n:2  n:1
;   body  body body body body body
;

;(factorial 6)
;An initial frame is created which points to global
;The passed in parameter is bound n : 6
;The procedure body is then evaluated

;6 not equal to 1 so evaluate the following expression
;(* 6 (factorial (- n 1))

;(factorial 5)
;A second frame is created, pointing to global, body is evaluated using binding
;n : 5

;(factorial 4)
;A third frame is created, pointing to global, body is evaluated using binding
;n : 4

;(factorial 3)
;A fourth frame is created, pointing to global, body is evaluated using binding
;n : 3

;(factorial 2)
;A fifth frame is created, pointing to global, body is evaluated using binding
;n : 2

;(factorial 1)
;A sixth frame is created, pointing to global, body is evaluated using binding
;n : 1
;Evaluates to 1

;Iterative - Similar process, multiple frames are created
;First is a factorial frame, remaining are fact-iter frames

;   ______________________________
; /           GLOBAL ENV           \       
; |                                 |           
; | factorial ----------------------|-----> [x][x] - iterative procedure object
; | fact-iter  ---------------------|-----> [x][x] - fact-iter procedure object
;  \_______________________________/            
;   ^   ^   ^   ^   ^   ^   ^   ^             
;   F1  F2  F3  F4  F5  F6  F7  F8

;Frame 1 <factorial>
; n: 6

;Frame 2 <fact-iter>
; product : 1
; counter : 1
; max-count : 6

;Frame 3 <fact-iter>
; product: 1
; counter: 2
; max-count: 6

;Frame 4 <fact-iter>
; product: 2
; counter: 3
; max-count: 6

;Frame 5 <fact-iter>
; product: 6
; counter: 4
; max-count: 6

;Frame 6 <fact-iter>
; product: 24
; counter: 5
; max-count: 6

;Frame 7 <fact-iter>
; product: 120
; counter: 6
; max-count: 6

;Frame 8 <fact-iter>
; product: 720
; counter: 7
; max-count: 6

;No further calls - Frame 8 evaluates to 720