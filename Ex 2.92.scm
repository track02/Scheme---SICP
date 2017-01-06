#lang scheme

;Exercise 2.92: By imposing an ordering on variables, extend
;the polynomial package so that addition and multiplication
;of polynomials works for polynomials in different
;variables

;We need to define a way to order variables such that polynomials can be converted "upwards"
;until the "lower" polynomial has the same variable as the "upper" polynomial
;Similar to the tower structure used in the number packages to convert numbers

;Lets assume polynomials can only make use of the variables A, B and C
;Ordering alphabetically this gives us the following tower
;(this could be extended to the entire alphabet)

;   A
;   ^
;   B
;   ^
;   C

;Polynomials with a variable A can be seen as the 'canonical form' of polynomial
;Methods would be needed to convert from C -> B and B -> C
;When an operation is performed on two differing polynomials, the polynomial lower in the tower is to be
;identified and converted upwards until it matches the other.