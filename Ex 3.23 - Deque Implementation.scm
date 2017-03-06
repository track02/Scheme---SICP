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

;If we need to traverse the rear pointer up and down the list each item will need to link what is adjacent on either side
;So we'll need three items
;
;(([x] [y]) [z])
;   |   |    |
;  Item |    |
;       |    |
;    Behind  |
;           Front

;car  --> ([x] [y])
;caar -->  [x]
;cadr -->      [y]
;cdr  -->  [z]

;Three steps to update the deque
;Generate a new item and set its [y] and [z] values to point to the correct element
;Update the structure of the deque to include the new item
;Update the pointers to point to the new-item 

;If an item is added to the rear then:
; -> The current rear item must be updated, so it's rear points to the new item
; -> The new item must be setup so it's front points to the current rear
; -> the rear pointer must be moved from the current rear to the new item

;Similar process if an item is added to the front:
; -> The current front item must be updated, so it's front points to the new item
; -> The new item must be setup so it's rear points to the current front
; -> the front pointer must be moved from the current front to the new item

;If we're deleting an item from the rear then:
; -> Update the rear pointer to point to the front of the current rear
; -> Null the rear of the current rear (item deleted)

;If we're deleting an item from the front then:
; -> Update the front pointer to point to the rear of the current front
; -> Null the front of the current front (item deleted)


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
      (let ((new-pair (cons (cons item '()) '()))) ;Bundle item (([x] [y]) [z]) 
        (cond ((empty-deque?) ;If queue is empty, then point both front and back to the item
               (set-front-ptr! new-pair)
               (set-rear-ptr!  new-pair))
              (else ;Otherwise set the cdr of the rear-ptr to the new-pair and point the rear-ptr to the item
               (set-cdr! new-pair rear-ptr) ;Update the new item front to equal current rear
               (set-cdr! (car rear-ptr) new-pair) ;Update the current rear to point to the new item
               (set-rear-ptr! new-pair))))) ;Set rear-ptr to point to the new item


    ;Insert a new item - adds an item to the front of the queue
    (define (front-insert-deque! item)
      (let ((new-pair (cons (cons item '()) '()))) ;Bundle item as a pair [x][o]
        (cond ((empty-deque?) ;If queue is empty, then point both front and back to the item
               (set-front-ptr! new-pair)
               (set-rear-ptr!  new-pair))
              (else ;Otherwise set the cdr of the new-pair to the current front-ptr and point the front-ptr to the item
               (set-cdr! front-ptr new-pair) ;Update the current front to point to the new item
               (set-cdr! (car new-pair) front-ptr) ;Update the new item rear to point to the current front
               (set-front-ptr! new-pair))))) ;Update the current front pointer to the new item

    
    
    ;Prints out the queue
    (define (print-queue)
      (define (iter input output)
        (if (null? input)
            output
            (iter (cdr input) (append output (list (car (car input))))))) ;Attach element to start of list
      (iter rear-ptr '()))

    ;Delete item - removes an item from the front
    (define (front-delete-deque!)
      (cond ((empty-deque?)
             (error "DELETE! called with an empty queue"))
            (else (set-front-ptr! (cdr (car front-ptr))) ;Set the front pointer to the rear of the current front 
                  (set-cdr! front-ptr '())))) ;Set the front of current front to null

    ;Delete item - removes an item from the back
    (define (rear-delete-deque!)
      (cond ((empty-deque?)
             (error "DELETE! called with an empty queue"))
            (else (set-rear-ptr! (cdr rear-ptr))
                  (set-cdr! (car rear-ptr) '())))) ;Null behind
           
    (define (dispatch m)
      (cond ((eq? m 'empty-deque?) (empty-deque?))
            ((eq? m 'front-deque) front-ptr)
            ((eq? m 'rear-deque) rear-ptr)
            ((eq? m 'rear-insert-deque!)  rear-insert-deque!)
            ((eq? m 'rear-delete-deque!) (rear-delete-deque!))
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
(q 'print) ;4213

(q 'front-delete-deque!)
(q 'print) ;421
(q 'rear-delete-deque!)
(q 'print) ;21


