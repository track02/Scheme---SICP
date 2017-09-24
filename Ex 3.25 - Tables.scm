#lang sicp

;Exercise 3.25 - Generalizing one and two-dimensional tables,
;show how to implement a table in which values are
;stored under an arbitrary number of keys and different values
;may be stored under different numbers of keys. e
;lookup and insert! procedures should take as input a list
;of keys used to access the table.

;This says nothing about structuring tables over multiple dimensions
;Only implementing a table system capable of storing values varying different numbers of keys

;We can use the entire list as a key itself

;Scheme - comparison operators

;equal? recursively compares two objects (of any type) for equality.  (lists)

;eqv? tests two objects to determine if both are "normally regarded as the same object". (pointers + primitives)

;eq? is the same as eqv? but may be able to discern finer distinctions, and may be implemented more efficiently. (pointers)

;= compares numbers for numerical equality.

;We can use equal? to as our same-key? procedure

(define (make-table same-key?)
  
  (let ((local-table (list '*table*))) ;Create local table

    ;Include local definition of assoc to make use of same-key instead of equal?
    (define (assoc key records)
      (cond ((null? records) false)
            ((same-key? key (caar records)) (car records))
            (else (assoc key (cdr records)))))

    (define (lookup key)
      (let ((record (assoc key (cdr local-table))))
        (if record
            (cdr record)
            false)))
    

    (define (insert! key value)
      (let ((record (assoc key (cdr local-table))))
        (if record
            (set-cdr! record value)
            (set-cdr! local-table
                      (cons (cons key value)
                            (cdr local-table)))))
      'Values-Inserted)

    ;Dispatch - returned by make-table, used to call table operations
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            ((eq? m 'print) local-table)
            (else (display "Unknown operation: TABLE" m))))

    ;Return dispatch
    dispatch))

;Testing
(define my-table (make-table equal?))
((my-table 'insert-proc!) '(a b c) 55)
((my-table 'lookup-proc) '(a b c))
((my-table 'lookup-proc) '(a b b))
((my-table 'lookup-proc) '(a c))
((my-table 'insert-proc!) '(a a a) 21)
((my-table 'lookup-proc) '(a a a))
