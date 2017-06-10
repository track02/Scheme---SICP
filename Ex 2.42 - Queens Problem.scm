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

;This can be formulated recursively.

;Assume a generated sequence exists of all possible ways to place the queens in the first k-1 columns.

;For each of these ways generate an extended set of positions by placing a queen
;in each row of the kth column.

;Now filter these keeping only the positions which the kth queen is safe with respect to the others

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

;Represent an empty board - null
(define empty-board null)

;Adjoin-position, adds a new position to an existing set
(define (adjoin-position row column position-set)
  (append position-set (list (position column row))))

;Safe? - given a set of positions, is the kth column position safe?

;First Generate a list of unsafe rows in column k
;if position col = k and position row = {unsafe} - false / remove
(define (safe? k positions)
  
    (let ((unsafe (flatmap (lambda (p) ;transform each position into a list of unsafe rows and flatten into a single continuous list
                         (let ((col-diff (abs (- k (position-column p)))))
                           [cond
                             ((not(= (position-column p) k)) (list
                                                              (position-row p)
                                                              (+ (position-row p) col-diff)
                                                              (- (position-row p) col-diff)))
                             (else  null)]))
                      positions)))
      
      ;Now have a list of unsafe rows for column k (1 2 4 5 ... N)
      ;Need to compare rows of p to the elements in this list - if no matches then true/safe otherwise false/unsafe

      ;Store the potential queen in column k
      (let ((k-position (car (filter (lambda (p) (= k (position-column p))) positions))))

      ;Compare k position to unsafe positions
      (define (check-k seq)
        [cond
           ((null? seq) #t) ;Get to end of unsafe list - Safe
           ((and (= (position-row k-position) (car seq))) #f) ;Match with unsafe list - Not Safe
           (else (check-k (cdr seq)))]) ;Not at end of list / no match -> move to next element
      
      
        (check-k unsafe))))

;Implementation of Filter - checks each element in sequence - if it passes a test (predicate) keep it in the list
  (define (filter predicate sequence)
  (cond ((null? sequence) null)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

;Accumulate
(define (accumulate op init sequence)
  (if (null? sequence)
      init
      (op (car sequence)
          (accumulate op init (cdr sequence)))))

;Enumare Interval
(define (enumerate-interval low high)
  (if (> low high)
      null
      (cons low (enumerate-interval (+ low 1) high))))

;Flatmap
(define (flatmap op sequence)
  (accumulate append null (map op sequence)))

;Takes a board size and outputs all ways of placing queens in the first k columns 
(define (queens board-size)

  ;For a given column k, queen-cols returns all the queen combinations for the first k columns
  (define (queen-cols k)

    ;If K = 0, return null - can't place anything
    (if (= k 0)
        (list empty-board)

        ;Filters list leaving only valid queen positions
        (filter
         (lambda (positions) (safe? k positions)) 

         ;Places queens in first k-1 columns
         (flatmap
          (lambda (rest-of-queens)

            ;Places queens in rows of each column
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens)) 
                 (enumerate-interval 1 board-size)))
          
          (queen-cols (- k 1))))))
  (queen-cols board-size))

;Testing
