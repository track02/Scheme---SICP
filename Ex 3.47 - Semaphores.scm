#lang scheme

; Exercise 3.47:
; A semaphore (of sizen) is a generalization of
; a mutex. Like a mutex, a semaphore supports acquire and
; release operations, but it is more general in that up to n
; processes can acquire it concurrently.

; Additional processes that attempt to acquire
; the semaphore must wait for release operations.

; Give implementations of semaphores
; a. in terms of mutexes
; b. in terms of atomic test-and-set! operations.



    (define (make-semaphore proc)
      (let ((processes proc)
            (mutex (make-mutex)))
        (define (the-semaphore m)
          (cond ((eq? m 'acquire)
                 (mutex 'acquire) ; Acquire mutex to prevent any other operations affecting count
                 (if (processes > 0) ; Space for semaphore to be acquired
                     (begin
                       (set! processes (- processes 1))
                       (mutex 'release))
                     (begin ;Else no space available
                       (mutex 'release)
                       (the-semaphore 'acquire)))) ;Try acquiring again
                
                ((eq? m 'release) ; When asked to release
                 (mutex 'acquire) ; Acquire mutex to lock operation
                 (set! processes (+ processes 1)) ; update process space
                 (mutex 'release))))) ; Release mutex
        
        the-semaphore)