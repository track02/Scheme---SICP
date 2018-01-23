; Exercise 3.50:
; Complete the following definition, which generalizes
; stream-map to allow procedures that take multiple arguments

; Takes a procedure taking n arguments alongside n lists
; This procedure is applied to first element of each list, then second, and third, results are mapped to a single list
(define (stream-map proc . argstreams) 
  (if (stream-null? (car argstreams)) ; No streams presented - end condition
  the-empty-stream ; Evaluate to empty-stream
  (cons-stream ; Cons application of procedure to first element
   (apply proc (map stream-car argstreams)) 
   (apply stream-map ; With result of stream-mapping cdr of each argstream
          (cons proc (map stream-cdr argstreams)))))) ;Map cdr to drop first element of each arg stream

