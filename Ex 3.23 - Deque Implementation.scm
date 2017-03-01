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



;Exercise 3.23 - A deque (“double-ended queue”) is a sequence
;in which items can be inserted and deleted at either the
;front or the rear.

;Operations on deques are the constructor
;make-deque
;the predicate empty-deque?
;selectors front-deque and rear-deque
;mutators front-insert-deque!, rear-insert-deque!,
;front-delete-deque!, and rear-deletedeque!.

;Show how to represent deques using pairs, and
;give implementations of the operations.

;All operations should be accomplished in O(1) steps.

(define (make-deque)
  (let ((front-ptr '())
        (rear-ptr '()))

    ;Procedures to update front / rear ptr
    (define (set-front-ptr! item)
      (set! front-ptr item))
    
    (define (set-rear-ptr! item)
      (set! rear-ptr item))

    

    ;Empty queue check
    (define (empty-deque?)
      (and (null? front-ptr) (null? rear-ptr)))

    ;Insert a new item - adds an item to the back of the queue
    (define (rear-insert-deque! item)
      (let ((new-pair (cons item '()))) ;Bundle item as a pair [x][o]
        (cond ((empty-deque?) ;If queue is empty, then point both front and back to the item
               (set-front-ptr! new-pair)
               (set-rear-ptr!  new-pair))
              (else ;Otherwise set the cdr of the rear-ptr to the new-pair and point the rear-ptr to the item
               (set-cdr! rear-ptr new-pair)
               (set-rear-ptr! new-pair)))))


    ;Insert a new item - adds an item to the front of the queue
    (define (front-insert-deque! item)
      (let ((new-pair (cons item '()))) ;Bundle item as a pair [x][o]
        (cond ((empty-deque?) ;If queue is empty, then point both front and back to the item
               (set-front-ptr! new-pair)
               (set-rear-ptr!  new-pair))
              (else ;Otherwise set the cdr of the new-pair to the current front-ptr and point the front-ptr to the item
               (set-cdr! new-pair front-ptr)
               (set-front-ptr! new-pair)))))

    
    
    ;Prints out the queue
    (define (print-queue)
      (define (iter input output)
        (if (null? input)
            output
            (iter (cdr input) (append (list (car input)) output))))
      (iter front-ptr '()))

    ;Delete item - removes an item from the front
    (define (front-delete-deque!)
      (cond ((empty-deque?)
             (error "DELETE! called with an empty queue"))
            (else (set-front-ptr! (cdr front-ptr)))))

    ;Delete item - removes an item from the back
    (define (rear-delete-deque!)
      (cond ((empty-deque?)
             (error "DELETE! called with an empty queue"))
            (else (set-rear-ptr! (cdr front-ptr)))))
           
    (define (dispatch m)
      (cond ((eq? m 'empty-deque?) (empty-deque?))
            ((eq? m 'front-deque) front-ptr)
            ((eq? m 'rear-deque) rear-ptr)
            ((eq? m 'rear-insert-deque!)  rear-insert-deque!)
            ((eq? m 'front-insert-deque!) front-insert-deque!)
            ((eq? m 'front-delete-deque!) (front-delete-deque!))
            ((eq? m 'print) (print-queue))
            (else (error "Procedure does not exist"))))
      
    dispatch))


;Testing

(define q (make-deque))
((q 'rear-insert-deque!) 1)
((q 'rear-insert-deque!) 2)
((q 'front-insert-deque!) 3)
((q 'rear-insert-deque!) 4)
(q 'print)


