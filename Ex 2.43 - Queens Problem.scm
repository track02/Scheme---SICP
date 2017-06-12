;Ex 2.43 - the following implementation of the queens procedure works but runs very slowly
;it turns out the order of the nested mappings is interchanged
;explain why this interchange makes the program run so slowly
;provide an estimate on how long it will take solve the eight-queens puzzle assuming 2.42 solves it in time T

;(flatmap
; (lambda (new-row)
;   (map (lambda (rest-of-queens)
;         (adjoin-position new-row k rest-of-queens))
;       (queen-cols (- k 1))))
;(enumerate-interval 1 board-size))

;2.42 Implementation

;(flatmap
; (lambda (rest-of-queens)
;   (map (lambda (new-row)
;          (adjoin-position new-row k rest-of-queens))
;        (enumerate-interval 1 board-size)))
; (queen-cols (- k 1))))))

;Placing queens-col in the inner loop means it is called
;for each row in each column instead of once for per column
;Time would take T^boardsize to complete
