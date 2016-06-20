#lang scheme

;8 Queens Problem
;How can eight queens be placed on a chessboard in such a way
;that no queen is in check from any other
;So, no two queens share the same row, column or diagonal

;Example, Q represents a queen on 8x8 board

;[ ] [ ] [ ] [ ] [ ] [Q] [ ] [ ]
;[ ] [ ] [Q] [ ] [ ] [ ] [ ] [ ]
;[Q] [ ] [ ] [ ] [ ] [ ] [ ] [ ]
;[ ] [ ] [ ] [ ] [ ] [ ] [Q] [ ]
;[ ] [ ] [ ] [ ] [Q] [ ] [ ] [ ]
;[ ] [ ] [ ] [ ] [ ] [ ] [ ] [Q]
;[ ] [Q] [ ] [ ] [ ] [ ] [ ] [ ]
;[ ] [ ] [ ] [Q] [ ] [ ] [ ] [ ]

;One way to solve the puzzle is to work across the board
;and place a queen in each column
;Once k-1 (7) queens have been placed we must place the kth (8) queen
;in such a way that it does not check any of the queens already on the board

;This can be formulated recursively. Assume a generate sequence exists
;of all possible ways to place the queens in the first k-1 columns.
;For each of these ways generate an extended set of positions by placing
;a queen in each row of the kth column, now filter these keeping only the
;positions which the kth queen is safe with respect to the others
;By continuing this process we can produce multiple solutions



;Ex 2.42
;A) Implement a representation for sets of board positions

;Write a procedure adjoin-position adds a new position to an existing set
;Define empty-board which represents an empty set of positions

;Write a safe? procedure which determines for a set of positions whether
;the queen in the kth column is safe, with respect to the others.

;Note: we only need to check whether the newly added queen is safe

;A) Representation for board position
;A position consists of a column and row number -> pair

;Constructor
(define (position col row)
  (cons col row))

;Selectors
(define (position-column position)
  (car position))

(define (position-row position)
  (cdr position))

;Adjoin-position, adds a new position to an existing set
(define (adjoin-position position-set new-position)
  (cons positions (list new-position)))


;(define (queens board-size)
;  (define (queen-cols k)  
;    (if (= k 0)
;        (list empty-board)
;        (filter
;        (lambda (positions) (safe? k positions))
;         (flatmap
;          (lambda (rest-of-queens)
;            (map (lambda (new-row)
;                   (adjoin-position new-row k rest-of-queens))
;                 (enumerate-interval 1 board-size)))
;          (queen-cols (- k 1))))))
;  (queen-cols board-size))