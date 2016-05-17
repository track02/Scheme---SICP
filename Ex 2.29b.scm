#lang scheme

;Ex 2.29 A binary mobile consists of two branches, left and right
;Each branch has a specific length and from it hangs either a weight or another binary mobile


;A binary mobile can be implemented as follows
(define (make-mobile left right)
  (list left right))

;And a branch can be implemented as
(define (make-branch length structure)
  (list length structure))

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (car(cdr mobile)))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (car (cdr branch)))

(define my-mobile (make-mobile (make-branch 2 10)
                               (make-branch 3
                                            (make-mobile (make-branch 4 12)
                                                         (make-branch 5 15)))))

;Ex 2.29b - Use the selectors to define a total-weight procedure
;total-weight needs to return the total weight of a mobile

;For a given mobile sum up with weight of the left / right branches
;A branch can either hold a weight or another mobile -> pair?

;Start the summing process
(define (total-weight mobile)
  ;Add the weights of the left and right branches of the 'parent' mobile
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))

(define (branch-weight branch)
  ;Firstly check if a branch holds a weight or mobile
  ;If branch holds a mobile add up the weights of its left/right branches
  (cond ((pair? (branch-structure branch)) (+ (branch-weight (left-branch (branch-structure branch)))
                                              (branch-weight (right-branch (branch-structure branch)))))
        ;If the branch holds only a weight - return it up to be added
        (else (branch-structure branch))))