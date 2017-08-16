#lang sicp

;Exercise 3.24: In the original table implementations, the keys
;are tested for equality using equal? (called by assoc). is
;is not always the appropriate test. For instance, we might
;have a table with numeric keys in which we don’t need an
;exact match to the number we’re looking up, but only a
;number within some tolerance of it.

;Design a table constructor
;make-table that takes as an argument a same-key?
;procedure that will be used to test “equality” of keys. maketable
;should return a dispatch procedure that can be used
;to access appropriate lookup and insert! procedures for a
;local table.

(define (make-table same-key?)
  
  (let ((local-table (list '*table*))) ;Create local table

    ;Include local definition of assoc to make use of same-key instead of equal?
    (define (assoc key records)
      (cond ((null? records) false)
            ((same-key? key (caar records)) (car records))
            (else (assoc key (cdr records)))))
    
    ;Lookup first finds the sub-table identified by key-1
    ;And the value within that subtable assigned to key-2
    (define (lookup key-1 key-2)
      (let ((subtable
             (assoc key-1 (cdr local-table))))
        (if subtable
            (let ((record
                   (assoc key-2 (cdr subtable))))
              (if record (cdr record) false))
            false)))

    ;Insert updates the entry at subtable (key-1) key (key-2) with the
    ;value provided
    (define (insert! key-1 key-2 value)
      (let ((subtable
             (assoc key-1 (cdr local-table))))
        (if subtable
            (let ((record
                   (assoc key-2 (cdr subtable))))
              (if record
                  (set-cdr! record value)
                  (set-cdr! subtable
                            (cons (cons key-2 value)
                                  (cdr subtable)))))
            (set-cdr! local-table
                      (cons (list key-1 (cons key-2 value))
                            (cdr local-table)))))
      'ok)

    ;Dispatch - returned by make-table, used to call table operations
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (display "Unknown operation: TABLE" m))))

    ;Return dispatch
    dispatch))
