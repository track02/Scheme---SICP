#lang scheme

;Ex 2.13 There exists a simple formula for approximating the % tolerances
;of the product of two intervals - assuming all numbers are positive, what is the formula

;  X       Y
; a b     c d
;[+ +] * [+ +] -> [ac db]

;[9,11] -> Center 10, % Tolerance 10
;[18,22] -> Center 20, % Tolerance 10
;[9,11] * [18,22] -> [162,242] -> Center 202, % Tolerance 20 (19.8)

;Tolerance of a product can be approximated by adding the % Tolerance of each interval


;Mathematical Explanation (From Scheme Wiki)

;We already know that for positive intervals
;[a,b] × [c,d] = [ac, db]

;We can represent an interval in terms of its center (c) and percentage tolerance (p)

;x = [cx - cx(px/100), cx + cx(px/100)]
; => [cx(1 - pi/100),  cx(1 + pi/100)]

;y = [cy - cy(py/100), cy + cy(py/100)]
; => [cy(1 - pi/100),  cy(1 + pi/100)]

;Multiplying the two
;xy = [cxcy(1 - px/100)(1 - py/100), cxcy(1 + px/100)(1 + py/100)]
;  => [cxcy(1 - (px + py)/100 + pxpy/10,000), cxcy(1 + (px + py)/100 + pxpy/10,000)]

;Ignoring the very small terms (pxpy/10000)

;xy = [cxcy(1 - (px + py)/100), cxcy(1 + (px + py)/100)]

;We can see the center -> cxcy and the percent tolerance -> px + py