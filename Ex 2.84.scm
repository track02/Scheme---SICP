#lang scheme

;Exercise 2.84.

;Using the raise operation of exercise 2.83, modify the apply-generic procedure
;so that it coerces its arguments to have the same type by the method of successive raising, as discussed
;in this section. You will need to devise a way to test which of two types is higher in the tower. Do this
;in a manner that is ‘‘compatible’’ with the rest of the system and will not lead to problems in adding
;new levels to the tower. 


;We currently have type tags assigned to our arguments
;If we treat each level of the tower (type) as a number we can determine which of two types is higher

(define (level arg)
  (cond ((= (type-tag arg) 'integer) 0)
        ((= (type-tag arg) 'rational) 1)
        ((= (type-tag arg) 'real) 2)
        ((= (type-tag arg) 'complex 3))))


(define (highest-level type-1 type-2)
  (if (> (level type-1) (level type-2))
      type-1
      type-2))


;Provided apply-generic
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2)
              (let ((type1 (car type-tags))
                    (type2 (cadr type-tags))
                    (a1 (car args))
                    (a2 (cadr args)))
                (let ((t1->t2 (get-coercion type1 type2))
                      (t2->t1 (get-coercion type2 type1)))
                  (cond (t1->t2
                         (apply-generic op (t1->t2 a1) a2))
                        (t2->t1
                         (apply-generic op a1 (t2->t1 a2)))
                        (else
                         (error "No method for these types"
                                (list op type-tags))))))
              (error "No method for these types"
                     (list op type-tags)))))))








;Alternatively when installing a package we could assign each type a number and add it to the table
(put 'level 'integer 0)
(put 'level 'rational 1)
(put 'level 'real 2)
(put 'level 'complex 3)

;And hide this behind a get-level procedure
(define (get-level arg)
  (apply-generic 'level arg))

;Mock procedures type-tag
(define (type-tag x)
  x)

(define (put op type proc)
  proc)

(define (get op type)
  op)