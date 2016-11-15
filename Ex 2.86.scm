#lang scheme


;Ex 2.86   Suppose we want to handle complex numbers whose real parts, imaginary parts,
;magnitudes, and angles can be either ordinary numbers, rational numbers, or other numbers we might
;wish to add to the system. Describe and implement the changes to the system needed to accommodate
;this. You will have to define operations such as sine and cosine that are generic over ordinary
;numbers and rational numbers. 


;We'llneed to update the underlying rectangular / polar packages to work with any type of number

;This requires we introduce new generic operations:
;square-root
;square
;sine
;arctan
;cosine


;Wrapper for generic operations
(define (square-root x) (apply-generic 'square-root))
(define (square x) (apply-generic 'square))
(define (sine x) (apply-generic 'sine x))
(define (cosine x) (apply-generic 'cosine x))
(define (arctan x y) (apply-generic 'arctan x y))


;Package specific implementations

;Integer
;...

(put 'square-root '(integer) (lambda (x)  (make-real (sqrt x)))
(put 'square '(integer) (lambda (x) (make-integer (tag (* x x))))) ;Tag result as integer
(put 'sine '(integer) (lambda (x) (make-real (sin x))))
(put 'cosine '(integer) (lambda (x) (make-real (cos x))))
(put 'arctan '(integer integer) (lambda (x y) (make-real (atan x y))))
;...



;Rational
;...

(put 'square-root    '(rational)           (lambda (x)   (make-real (sqrt (/ (numer x) (denom x))))))
(put 'square     '(rational)           (lambda (x)   (tag (mul-rat x x)))) ;Tag result as rational
(put 'sine       '(rational)           (lambda (x)   (make-real (sin (/ (numer x) (denom x)))))
(put 'cosine     '(rational)           (lambda (x)   (make-real (cos (/ (numer x) (denom x))))))
(put 'arctan     '(rational rational)  (lambda (x y) (make-real (atan (/ (numer x) (denom x))
                                                                      (/ (numer x) (denom x))))))
;...


;Real
;...
(put 'square-root    '(real)           (lambda (x)   (tag (sqrt  x)))) ;Tag result as real
(put 'square     '(real)           (lambda (x)   (tag (* x x)))) ;Tag result as real
(put 'sine       '(real)           (lambda (x)   (tag (sin x)))) ;Tag result as real
(put 'cosine     '(real)           (lambda (x)   (tag (cos x)))) ;Tag result as real
(put 'arctan     '(real real)      (lambda (x y) (tag (atan x y)))) ;Tag result as real


;Rectangular Package
(define (install-rectangular-package)
;; internal procedures
  (define (real-part z) (car z))
  (define (imag-part z) (cdr z))
  (define (make-from-real-imag x y) (cons x y))
  (define (magnitude z)
    (sqrt (add (square (real-part z))
             (square (imag-part z)))))
  (define (angle z)
    (atan (imag-part z) (real-part z)))
  (define (make-from-mag-ang r a) 
    (cons (multiply r (cosine a)) (multiply r (sine a))))
;; interface to the rest of the system
  (define (tag x) (attach-tag ’rectangular x))
  (put ’real-part ’(rectangular) real-part)
  (put ’imag-part ’(rectangular) imag-part)
  (put ’magnitude ’(rectangular) magnitude)
  (put ’angle ’(rectangular) angle)
  (put ’make-from-real-imag ’rectangular 
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put ’make-from-mag-ang ’rectangular 
       (lambda (r a) (tag (make-from-mag-ang r a))))
  ’done)


;Polar Package
(define (install-polar-package)
;; internal procedures
  (define (magnitude z) (car z))
  (define (angle z) (cdr z))
  (define (make-from-mag-ang r a) (cons r a))
  (define (real-part z)
    (multiply (magnitude z) (cos (angle z))))
  
  (define (imag-part z)
    (multiply (magnitude z) (sin (angle z))))
  
  (define (make-from-real-imag x y) 
    (cons (square-root (add (square x) (square y)))
          (arctan y x)))
  
;; interface to the rest of the system
  (define (tag x) (attach-tag ’polar x))
  (put ’real-part ’(polar) real-part)
  (put ’imag-part ’(polar) imag-part)
  (put ’magnitude ’(polar) magnitude)
  (put ’angle ’(polar) angle)
  (put ’make-from-real-imag ’polar
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put ’make-from-mag-ang ’polar 
       (lambda (r a) (tag (make-from-mag-ang r a))))
  ’done)



;Complex number package
(define (install-complex-package)
  
;; imported procedures from rectangular and polar packages
  (define (make-from-real-imag x y)
    ((get ’make-from-real-imag ’rectangular) x y))
  (define (make-from-mag-ang r a)
    ((get ’make-from-mag-ang ’polar) r a))
  
;; internal procedures
  (define (add-complex z1 z2) ;Adds two complex numbers together
    (make-from-real-imag (+ (real-part z1) (real-part z2)) ;Create a new complex number
                         (+ (imag-part z1) (imag-part z2)))) ;by summing real / imag parts
  (define (sub-complex z1 z2) ;Subtracts two complex numbers
    (make-from-real-imag (- (real-part z1) (real-part z2)) ;Create a new complex number
                         (- (imag-part z1) (imag-part z2)))) ;by subtracting real / imag parts
  (define (mul-complex z1 z2) ;Multiple two complex numbers
    (make-from-mag-ang (* (magnitude z1) (magnitude z2)) ;Create a new complex number
                       (+ (angle z1) (angle z2)))) ;by multiplying magnitudes and summing angles
  (define (div-complex z1 z2) ;Divide two complex numbers
    (make-from-mag-ang (/ (magnitude z1) (magnitude z2)) ;Create a new complex number
                       (- (angle z1) (angle z2)))) ;by dividing magnitudes and subtracting angles

;;Now link the internal procedures against external generic operation names
;; interface to rest of the system
  (define (tag z) (attach-tag ’complex z)) ;Tags a value with the 'complex tag
  (put ’add ’(complex complex)  ;Associate 'add and '(complex complex) with the add-complex procedure
       (lambda (z1 z2) (tag (add-complex z1 z2))))
  (put ’sub ’(complex complex) ;Associate 'sub '(complex complex) with the sub-complex procedure
       (lambda (z1 z2) (tag (sub-complex z1 z2)))) 
  (put ’mul ’(complex complex) ;Associate 'mul '(complex complex) with the mul-complex procedure
       (lambda (z1 z2) (tag (mul-complex z1 z2))))
  (put ’div ’(complex complex) ;Associate 'div '(complex complex) with the div-complete procedure
       (lambda (z1 z2) (tag (div-complex z1 z2))))
  (put ’make-from-real-imag ’complex ;Associate 'make-from-real-imag 'complex with make-from-real-imag procedure
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put ’make-from-mag-ang ’complex ;Associate 'make-from-mag-ang 'complex with make-from-mag-ang procedure
       (lambda (r a) (tag (make-from-mag-ang r a))))
  ’done)







