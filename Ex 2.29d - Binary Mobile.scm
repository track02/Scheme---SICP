#lang scheme

;Ex 2.29 A binary mobile consists of two branches, left and right
;Each branch has a specific length and from it hangs either a weight or another binary mobile


;Ex 2.29d - suppose the representation of a mobile and branch are changed
;to using cons instead of list
;what needs to change in the program to support this change?
;Using pairs now - access using car / cdr rather than (car (cdr))


;A binary mobile can be implemented as follows
(define (make-mobile left right)
  (cons left right))

;And a branch can be implemented as
(define (make-branch length structure)
  (cons length structure))

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (cdr mobile))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (cdr branch))

(define my-mobile (make-mobile (make-branch 2 10)
                               (make-branch 3
                                            (make-mobile (make-branch 4 12)
                                                         (make-branch 5 15)))))

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

;Ex 2.29c A mobile is balanced if the length of the left branch * the weight of the branch
;is equal to the same product of the right branch. Each submobile hanging from the mobile must also
;be balanced

;Write a test which determines whether a given mobile is balanced

;For a mobile to be balanced - L/R torque must be equal
;And all submobiles must themselves be balanced (checked using this procedure)
(define (balanced? mobile)
  (and (= (branch-torque (left-branch mobile))
          (branch-torque (right-branch mobile)))
       (submobiles-balanced (left-branch mobile))
       (submobiles-balanced (right-branch mobile))))

;Sum up total branch weight and multiply by the length
(define (branch-torque branch)
  (* (branch-weight branch) (branch-length branch)))

;If a branch contains a submobile - check if that's balanced
;If a branch only contains a weight - return true
(define (submobiles-balanced branch)
  (cond ((pair? (branch-structure branch))
         (balanced? (branch-structure branch)))
        (else true)))
  
  
;Testing

;Weights of left/right both the same - torques both the same - right submobile balanced -> True
(define x (make-mobile (make-branch 2 25) (make-branch 2 (make-mobile (make-branch 1 20) (make-branch 4 5)))))
;> (balanced? x)
;#t

;Weights of left/right differ - torques differ - right submobile unbalanced -> False
(define y (make-mobile (make-branch 2 25) (make-branch 2 (make-mobile (make-branch 1 20) (make-branch 4 3)))))
;> (balanced? y)
;#f

;Weights of left/right both the same - torques differ - right submobile balanced -> False
(define z (make-mobile (make-branch 2 25) (make-branch 3 (make-mobile (make-branch 1 20) (make-branch 4 5)))))
;> (balanced? z)
;#f

