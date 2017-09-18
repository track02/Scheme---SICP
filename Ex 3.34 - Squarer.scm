#lang scheme

;Exercise 3.34: Louis Reasoner wants to build a squarer, a
;constraint device with two terminals such that the value
;of connector b on the second terminal will always be the
;square of the value a on the first terminal. He proposes the
;following simple device made from a multiplier:

(define (squarer a b)
  (multiplier a a b))

;ere is a serious flaw in this idea. Explain.

;Multiplier expects 2 out of 3 values to be available
;It then determines the missing value 
;The squarer will work if a has a value and b doesn't

;Howevere if reversed the squarer will not work
;As the multiplier uses 2 values to work backwards via division
;The squarer would need to use a square root operation instead.