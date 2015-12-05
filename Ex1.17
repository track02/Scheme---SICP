#lang racket

;Create a recursive multiplication procedure
;With a log(n) complexity, wrt input value b


;Initial multiplcation procedure
;Steps performed linear to input of b
;E.g. 2 * 3
; (+ 2 (* 2 2))
; (+ 2 (+ (* 2 1)))
; (+ 2 (+ 2 (+ 2 (* 2 0)))) #Depth of 3
; (+ 2 (+ 2 (+ 2 0)
; (+ 2 (+ 2 2)
; (+ 2 4)
; -> 6
(define (* a b)
(if (= b 0)
0
(+ a (* a (- b 1))))) 

;Modified procedure
;Now b is repeatedly halved until equal to 1
;A new step added when b doubles in size
(define (fast-multiply a b)
 
  (cond ((= b 0) 0)
        ((= b 1) a)
        ((= (remainder b 2) 0) (fast-multiply (double a) (halve b)))
        (else (+ a (fast-multiply a (- b 1))))))

(define (double i)
(+ i i))

(define (halve i)
(/ i 2))

