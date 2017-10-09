#lang scheme


;Fig 2.24 shows a complex (rectangular number) 3 + 4i

; 
; -----> | o | o-|----->| o | o-|----->| o | o |
;          |              |              |   |
;          |              |              |   |
;          V              V              V   V
;         Complex     Rectangular       [3] [4]

;This is a two-level tag system, the outer tage directs the number towrads the complex package.
;Once within the complex package the rectangular tag is used to direct the number to the rectangular package

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



;Rectangular Package
(define (install-rectangular-package)
;; internal procedures
  (define (real-part z) (car z))
  (define (imag-part z) (cdr z))
  (define (make-from-real-imag x y) (cons x y))
  (define (magnitude z)
    (sqrt (+ (square (real-part z))
             (square (imag-part z)))))
  (define (angle z)
    (atan (imag-part z) (real-part z)))
  (define (make-from-mag-ang r a) 
    (cons (* r (cos a)) (* r (sin a))))
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
    (* (magnitude z) (cos (angle z))))
  (define (imag-part z)
    (* (magnitude z) (sin (angle z))))
  (define (make-from-real-imag x y) 
    (cons (sqrt (+ (square x) (square y)))
          (atan y x)))
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

;;Apply generic procedure
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (error
            "No method for these types -- APPLY-GENERIC"
            (list op type-tags))))))

;Example application
(define (add x y) (apply-generic ’add x y))

;Exercise 2.77.  Louis Reasoner tries to evaluate the expression 
;(magnitude z) where z is the object shown in figure 2.24


;To his surprise, instead of the answer 5 he gets an error message from 
;apply-generic, saying there is no method for the operation magnitude
;on the types (complex)

;He shows this interaction to Alyssa P. Hacker, who says ‘‘The problem is that the
;complex-number selectors were never defined for complex numbers, just for 
;polar and rectangular numbers. All you have to do to make this work is add the following to the 
;complex package:’’

;Note - these are the generic selectors e.g. (apply-generic 'magnitude z)
;(put ’real-part ’(complex) real-part)
;(put ’imag-part ’(complex) imag-part)
;(put ’magnitude ’(complex) magnitude)
;(put ’angle ’(complex) angle)

;Describe in detail why this works. As an example, trace through all the procedures called in evaluating
;the expression (magnitude z) where z is the object shown in figure 2.24

;In particular, how many times is apply-generic invoked? What procedure is dispatched to in each case?

;No magnitude operation is present for the complex type package, only the sub-types rectangular / polar

;If we associate the generic selectors with the top-most package - when we ask for the magnitude of a complex
;number then apply-generic will be called twice

;The first time calls the generic magnitude operation and the second dispatches to the inner procedure
;defined in rectangular;

;Outermost tag is stripped each time apply-generic is called
;So, when (magnitude z) is called where z is ('complex ('rectangular (3 4)))
;apply-generic 'magnitude z is first applied
;this sees the 'complex tag and dispatches to the complex package implementation of magnitude
;which is (apply-generic 'magnitude z)
;this causes apply-generic to be called again being passed the operation tag 'magnitude and z which
;is now ('rectangular (3 4))
;apply-generic sees the 'rectangular tag and now dispatches to the rectangular packages implementation
;of magnitude, which is (sqrt (+ (square (real-part z)) (square (imag-part z)))
;giving a result of 5

;(define z (make-from-real-imag 3 4)) -> ('complex ('rectangular (3 4))
;(magnitude z) -> (apply-generic 'magnitude ('complex ('rectangular (3 4)))
;-> (apply-generic 'magnitude ('rectangular (3 4)))
;-> (magnitude (3 4))
;-> 5

;This allows for the implementation of a hierarchy, with a topmost package passing down
;dispatch requests to those below.


