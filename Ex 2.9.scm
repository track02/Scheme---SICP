#lang scheme

;The width  of an interval is half of the difference between its upper and lower bounds.
;The width is a measure of the uncertainty of the number specified by the interval.
;For some arithmetic operations the width of the result of combining two intervals
;is a function only of the widths of the argument intervals.

;Whereas for others the width of the combination is not a function of the widths of
;the argument intervals.

;Show that the width of the sum (or difference) of two intervals is a function
;only of the widths of the intervals being added (or subtracted).

;Give examples to show that this is not true for multiplication or division.

;Addition
;Interval x (1,2)
;Interval y (3,4)

;Width of x -> 0.5
;Width of y -> 0.5

;x + y -> z (4,6)
;Width of z -> 1
;Width of z = Width of x + Width of y

;Multiplication
;Interval x (1,2)
;Interval y (3,4)

;Width of x -> 0.5
;Width of y -> 0.5

;P1 -> 3
;P2 -> 4
;P3 -> 6
;P4 -> 8

;x * y = z (3,8)
;Width of z -> 2.5

;2.5 != 0.5 + 0.5