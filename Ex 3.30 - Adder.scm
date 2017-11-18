#lang scheme

;[Referring to Fig 3.27 of linked Full Adders] is is the simplest form
;of parallel adder for adding two n-bit binary numbers. e
;inputs A1, A2, A3, : : :, An and B1, B2, B3, : : :, Bn are the
;two binary numbers to be added (each Ak and Bk is a 0 or
;a 1). e circuit generates S1, S2, S3, : : :, Sn, the n bits of
;the sum, and C, the carry from the addition.

;Write a procedure ripple-carry-adder that generates this circuit. e
;procedure should take as arguments three lists of n wires
;each—the Ak , the Bk , and the Sk —and also another wire C.

;e major drawback of the ripple-carry adder is the need
;to wait for the carry signals to propagate. What is the delay
;needed to obtain the complete output from an n-bit ripplecarry
;adder, expressed in terms of the delays for and-gates,
;or-gates, and inverters?

;Half Adder
;S - Sum
;C - Carry
;A B S C
;0 0 0 0
;0 1 1 0
;1 0 1 0
;1 1 0 1
(define (half-adder a b s c)
  (let ((d (make-wire)) (e (make-wire)))
    (or-gate a b d)
    (and-gate a b c)
    (inverter c e)
    (and-gate d e s)
  'ok))
;A Full Adder is composed of two Half Adders

;A and B are inputs to the first half adder
;The output is a sum and carry, that sum needs to be added
;to the carry-in from the previous column
;So the intermediate sum / carry-in form the inputs to the second adder
;The sum from the second adder is the final sum

;Carry-In is the carry bit from a previous addition one place to the right
;The generated sum is the bit for the corresponding position
;Carry-Out is the carry-bit to be propagated to the left (next addition)

;I - Carry In / O - Carry Out

;A B I S O
;0 0 0 0 0
;0 1 0 1 0
;1 0 0 1 0
;1 1 0 0 1
;0 0 1 1 0
;0 1 1 0 1
;1 0 1 0 1
;1 1 1 1 1
;
(define (full-adder a b c-in sum c-out)
  (let ((s (make-wire)) (c1 (make-wire)) (c2 (make-wire)))
    (half-adder b c-in s c1)
    (half-adder a s sum c2)
    (or-gate c1 c2 c-out)
    'ok))

;Full adders can be linked indefinitely to add n-bit numbers
;Assuming a ripple-carry starts with a c-in of 0 and specifies wires for sum and wire for final c-out
(define (ripple-carry a b sum c-out)
  (define (ripple-carry-iter a b c-i sum c-o)
    ;If we're at last wire
    (if (null? (cdr a))
        (full-adder (car a) (car b) c-i (car sum) c-out) ;Write out to c-out
        ;Else continue - create an adder and iterate to next wire
        (begin
            (full-adder (car a) (car b) c-i (car sum) c-o)
            ;Carry Out becomes Carry In + New wire is needed for the carry out
            (ripple-carry-iter (cdr a) (cdr b) c-o (cdr sum) (make-wire)))
    '(ok))
  (ripple-carry-iter a b (make-wire) sum (make-wire)))) ;Start iteration, with a new wire for c-in / c-out
  
