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


;Implementation of a Queue Data Structure
;A queue is represented as a pair of pointers (front-ptr and rear-ptr) which indicate
;the first and last pairs in an ordinary list.
;This prevents the need for iteration over the list each time the first/last element is required

;So the queue is a pair of pointer which point to an underlying list

;
;q ---> [x][x]-----------------\
;        |                     |
;        | front-ptr           |  rear-ptr
;        |                     |
;        V                     V
;       [x][x]---->[x][x]---->[x][o]
;        A          B          C

;The following procedures enable us to select and modify
;the front and rear queue pointers

(define (front-ptr queue) (car queue))
(define (rear-ptr queue) (cdr queue))

(define (set-front-ptr! queue item)
  (set-car! queue item))

(define (set-rear-ptr! queue item)
  (set-cdr! queue item))

;A queue can be considered empty if the fromt pointer is the empty list
(define (empty-queue? queue)
  (null? (front-ptr queue)))

;The constructor returns an initially empty queue
(define (make-queue) (cons '() '()))

;To select the first item in the queue
;return the car of the front pointer
(define (front-queue queue)
  (if (empty-queue? queue)
      (error "FRONT called with an empty queue" queue)
      (car (front-ptr queue))))

;To insert an item we create a new pair containing the item  to insert as its car and an empty list as the cdr
;If the queue is empty, point the front-ptr  and rear-ptr to this pair
;If the queue isnt empty, modify the final pair in the queue to point to the new pair and update the rear pointer to the new pair
(define (insert-queue! queue item)
  (let ((new-pair (cons item '())))
    (cond ((empty-queue? queue)
           (set-front-ptr! queue new-pair)
           (set-rear-ptr! queue new-pair)
           queue)
          (else
           (set-cdr! (rear-ptr queue) new-pair)
           (set-rear-ptr! queue new-pair)
           queue))))

;If we want to delete an item we modify the front pointer to point to the second item in the queue
;This is found by following the cdr pointer of the first item
(define (delete-queue! queue)
  (cond ((empty-queue? queue)
         (error "DELETE! called with an empty queue" queue))
        (else (set-front-ptr! queue (cdr (front-ptr queue)))
              queue)))


;Exercise 3.21: Ben Bitdiddle decides to test the queue implementation
;described above. He types in the procedures
;to the Lisp interpreter and proceeds to try them out:
(define q1 (make-queue))
(insert-queue! q1 'a)
;((a) a)
(insert-queue! q1 'b)
;((a b) b)
(delete-queue! q1)
;((b) b)
(delete-queue! q1)
;(() b)

;“It’s all wrong!” he complains. “e interpreter’s response
;shows that the last item is inserted into the queue twice.
;And when I delete both items, the second b is still there,
;so the queue isn’t empty, even though it’s supposed to be.”

;Eva Lu Ator suggests that Ben has misunderstood what is
;happening. “It’s not that the items are going into the queue
;twice,” she explains. “It’s just that the standard Lisp printer
;doesn’t know how to make sense of the queue representation.
;If you want to see the queue printed correctly, you’ll
;have to define your own print procedure for queues.”

;Explain what Eva Lu is talking about. In particular, show why
;Ben’s examples produce the printed results that they do.

;Start with an initially empty queue with front and read both pointing to same element
;
;  f
;  r  
; [x][o]
; '()'()


;When the element 'a is inserted a pair is created ['a '()], because the queue is empty both pointers are set to point to the same element
;
;  f
;  r
; [x][o]
;  a '()

;The first result ((a) a) is produced because for an empty queue the front and rear ptr are both set to the same item


;When a second element is inserted, the first element of the queue is updated so that it's cdr points to
;the newly created pair, the rear ptr is updated to point to the new element the front-ptr remains unchanged

;
;  f          r
;
; [x][x] --> [x][o]
;  a          b



;When delete-queue is called the front ptr is updated to point to the cdr of the current front element (b)
;The rear-ptr remains unchanged ((b) b)


;             f
;             r
; [x][x] --> [x][o]
;  a          b
;


;When delete-queue is called again, the front ptr is updated to point to the cdr of the current front element
;And the rear-ptr remains unchanged

;                f
;             r
; [x][x] --> [x][o]
;  a          b
;


;Lastly, define a procedure print-queue that takes a queue as input
;and prints the sequence of items in the queue.

(define (print-queue queue)
  (define (iter input output)
    (if (null? input)
        output
        (iter (cdr input) (append (list (car input)) output))))
  (iter (car queue) '()))
  
    

(define myqueue (make-queue))
(insert-queue! myqueue 1) ;1 is at front
(insert-queue! myqueue 2)
(insert-queue! myqueue 3) ;3 is at back

;> (print-queue myqueue)
;(3 2 1)


(delete-queue! myqueue) ;remove front element - 1

;> (print-queue myqueue)
;(3 2)