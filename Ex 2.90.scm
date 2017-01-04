#lang scheme

;Decided to simplify this solution
;Each term-list package contains a unique implementation of adjoin-term due to the differing structures
;Unique first-term/rest-term procedures are also needed

;Dense term-list package
;Term Order = length of sublist beginning with that terms coefficient
;[1 2 0 3 -5]
; x^4 + 2x^3 + 3x - 5
(define (install-dense-term-list-package)

  (define (make-dense-term-list term-list) (tag term-list))
  
  (define (adjoin-term-dense term-list term)
    (if (> (order term) (length term-list))
        ;If order of term is greater than length of term list, create a list padded with zeros and append term-list
        (append (create-zeroes (coeff term) (- (order term) (length term-list))) term-list)
        ;Else update term list by adding coefficient to correct position
        (update-coeff '() (coeff term) term-list (- (-(length term-list) 1) (order term)))))

  (define (create-zeroes value zerocount)
    (if (= zerocount 0)
        (cons value '())
        (cons value (create-zeroes 0 (- zerocount 1)))))
  
  (define (update-coeff prev-elements value next-elements i)
    (if (= 0 i)
        (append prev-elements (list (+ value (car next-elements))) (cdr next-elements))
        (update-coeff (append prev-elements (list (car next-elements))) value (cdr next-elements) (- i 1))))

   ;A dense term-list would need to build a term
  (define (first-term term-list)
    (make-term (car term-list) ;Coefficient
               (- (length term-list) 1))) ;Order - using length of list

  ;To retrieve the remaining terms they need to be created and placed into a list
  (define (rest-terms term-list)
    (define (build-terms term-list)
      (if (null? term-list)
          '()
          (cons (first-term term-list) (build-terms (cdr term-list))))))
          
 
  (define (tag tl) (attach-tag 'dense-term-list tl))

  ;Store a procedure in the table, which calls adjoin-term-dense and tags the result as a dense-term-list
  (put 'adjoin-term 'dense-term-list (lambda (term-list term) (tag (adjoin-term-dense term-list term))))
  (put 'first-term 'dense-term-list (lambda (term-list) (first-term term-list)))
  (put 'rest-terms 'dense-term-list (lambda (term-list) (rest-terms term-list)))

  
  'done)

;Sparse term-list package
;Contains individual terms as order/coefficient pairs
;((100 1) (2 2) (0 1))
;  x^100 + 2x^2 + 1
(define (install-sparse-term-list-package)
  
  (define (make-sparse-term-list term-list) (tag term-list))
  
  (define (adjoin-term-sparse term-list term)
  (if (=zero? (coeff term))
      term-list
      (cons term term-list)))

  ;Here only need to return first element
  (define (first-term term-list)
    (car term-list))

  ;Or the remaining elements
  (define (rest-terms term-list)
    (cdr term-list))

  (define (tag tl) (attach-tag 'sparse-term-list tl))
  
  ;Store a procedure in the table, which calls adjoin-term-spare and tags the result as a spare-term-list
  (put 'adjoin 'sparse-term-list (lambda (term-list term) (tag (adjoin-term-sparse term-list term))))
  (put 'first-term 'sparse-term-list (lambda (term-list) (first-term term-list)))
  (put 'rest-terms 'sparse-term-list (lambda (term-list) (rest-terms term-list)))
  
'done)


;Generic Methods - Would use apply-generic to the dispatch correct method where required
;This provides a set of generic procedures for use in the add-terms / mul-terms procedures
(define (first-term tl)
  (apply-generic tl))

(define (rest-terms tl)
  (apply-generic tl))

(define (adjoin-term tl t)
  ((apply-generic tl) t))

(define (empty-termlist? tl)
  (null? tl))



;Add two term lists together
(define (add-terms L1 L2)
  (cond ((empty-termlist? L1) L2)
        ((empty-termlist? L2) L1)
        (else
         (let ((t1 (first-term L1)) (t2 (first-term L2)))
           (cond ((> (order t1) (order t2))
                  (adjoin-term ;Apply generic here
                   t1 (add-terms (rest-terms L1) L2)))
                 ((< (order t1) (order t2))
                  (adjoin-term ;Apply generic here
                   t2 (add-terms L1 (rest-terms L2))))
                 (else
                  (adjoin-term
                   (make-term (order t1)
                              (add (coeff t1) (coeff t2)))
                   (add-terms (rest-terms L1)
                              (rest-terms L2)))))))))


;Multiply two term-lists together
(define (mul-terms L1 L2)
  (if (empty-termlist? L1)
      (the-empty-termlist)
      (add-terms (mul-term-by-all-terms (first-term L1) L2)
                 (mul-terms (rest-terms L1) L2))))
(define (mul-term-by-all-terms t1 L)
  (if (empty-termlist? L)
      (the-empty-termlist)
      (let ((t2 (first-term L)))
        (adjoin-term
         (make-term (+ (order t1) (order t2))
                    (mul (coeff t1) (coeff t2)))
         (mul-term-by-all-terms t1 (rest-terms L))))))



