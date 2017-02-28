#lang scheme

;Implementation of cons

(define (cons x y)
  (define (set-x! v) (set! x v))
  (define (set-y! v) (set! y v))
  (define (dispatch m)
    (cond ((eq? m 'car) x)
          ((eq? m 'cdr) y)
          ((eq? m 'set-car!) set-x!)
          ((eq? m 'set-cdr!) set-y!)
          (else
           (error "Undefined operation: CONS" m))))
  dispatch)

(define (car z) (z 'car))
(define (cdr z) (z 'cdr))
(define (set-car! z new-value)
  ((z 'set-car!) new-value) z)
(define (set-cdr! z new-value)
  ((z 'set-cdr!) new-value) z)



;Exercise 3.22: Instead of representing a queue as a pair of
;pointers, we can build a queue as a procedure with local state.

;e local state will consist of pointers to the beginning
;and the end of an ordinary list. us, the make-queue procedure will have the form

;Complete the definition of make-queue and provide implementations
;of the queue operations using this representation.


(define (make-queue-proc)
  (let ((front-ptr '())
        (rear-ptr '()))

    ;Procedures to update front / rear ptr
    (define (set-front-ptr! item)
      (set! front-ptr item))
    
    (define (set-rear-ptr! item)
      (set! rear-ptr item))

    ;Empty queue check
    (define (empty-queue?)
      (null? front-ptr ))

    ;Return first element
    (define (front-queue)
      (if (empty-queue?)
          (error "FRONT called with an empty queue")
          (car front-ptr)))

    ;Insert a new item - adds an item to the back
    (define (insert-queue! item)
      (let ((new-pair (cons item '()))) ;Bundle iterm as a pair [x][o]
        (cond ((empty-queue?) ;If queue is empty, then point both front and back to the item
               (set-front-ptr! new-pair)
               (set-rear-ptr!  new-pair))
              (else ;Otherwise set the cdr of the rear-ptr to the new-pair and point the rear-ptr to the item
               (set-cdr! rear-ptr new-pair)
               (set-rear-ptr! new-pair)))))
    
    ;Prints out the queue
    (define (print-queue)
      (define (iter input output)
        (if (null? input)
            output
            (iter (cdr input) (append (list (car input)) output))))
      (iter front-ptr '()))

    ;Delete item - removes an item from the front
    (define (delete-queue!)
      (cond ((empty-queue?)
             (error "DELETE! called with an empty queue"))
            (else (set-front-ptr! (cdr front-ptr))
                  )))
           
    (define (dispatch m)
      (cond ((eq? m 'empty-queue?) (empty-queue?))
            ((eq? m 'front-queue) (front-queue))
            ((eq? m 'insert-queue!) insert-queue!)
            ((eq? m 'delete-queue) (delete-queue!))
            ((eq? m 'print) (print-queue))
            (else (error "Procedure does not exist"))))
      
    dispatch))


;Testing

;> (define q (make-queue-proc))
;> ((q 'insert-queue!) 5)
;> ((q 'insert-queue!) 6)
;> ((q 'insert-queue!) 7)
;> (q 'print)
;(7 6 5)
;> (q 'delete-queue)
;> (q 'print)
;(7 6)

