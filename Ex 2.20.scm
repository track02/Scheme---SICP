#lang scheme

;Ex 2.20 write a procedure same-parity that takes one or more integers
;and returns a list of all the arguments with the same even-odd parity as the first

;e.g.
;(same-parity 1 2 3 4 5 6 7)
;(1 3 5 7)
;(same-parity 2 3 4 5 6 7)
;(2 4 6)

;First element is odd -> return all odd numbers
;First element is even -> return all even numbers


;List operations
;cons -> constructs a pair using two provided elements (can be lists, pairs, anything)
;list -> creates a list of the provided arguments, if passed 1 argument a pair will be created
;        with a null cdr (list 1) -> (1,)
;append -> merges two lists together (1 2 3) (4 5 6) -> (1 2 3 4 5 6)


(define (same-parity x . y)
  ;Check parity of first integer
  (if (even? x)
      ;Depending on parity pass required filter
      (append (list x) (extract even? y)) ;Append x to result of list extraction
      (append (list x) (extract odd? y)))); " "
  
;Takes in a comparison function and a list of inputs
(define (extract comp inputs)
  (if (null? inputs) ;If inputs are empty
      inputs ;stop, cap off list with empty list ()
      (if (comp (car inputs)) ;Otherwise check first element
          ;If it passes filter append it to the next suitable element
          ;If there are no suitable elements it will be appended to an empty list
          (append (list (car inputs)) (extract comp (cdr inputs))) 
          ;Otherwise check the next element (rest of list)
          (extract comp (cdr inputs)))))

;Check for even numbers
(define (even? n)
  (= (remainder n 2) 0))

;Check for odd numbers
(define (odd? n)
  (not (= (remainder n 2) 0)))

;Testing

;> (same-parity 1 2 3 4 5 6)
;(1 3 5)
;> (same-parity 2 3 4 5 6 7 8)
;(2 4 6 8)
