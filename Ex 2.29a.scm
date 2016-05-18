#lang scheme

;Ex 2.29 A binary mobile consists of two branches, left and right
;Each branch has a specific length and from it hangs either a weight or another binary mobile


;A binary mobile can be implemented as follows
(define (make-mobile left right)
  (list left right))

;And a branch can be implemented as
(define (make-branch length structure)
  (list length structure))

;Ex 2.29a - Write corresponding selectors left-branch / right-branch
;which return the branches of a mobile and branch-length / branch-structure which
;return the components of a branch

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (car(cdr mobile)))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (car (cdr branch)))

(define my-mobile (make-mobile (make-branch 2 10) (make-branch 3 5)))
