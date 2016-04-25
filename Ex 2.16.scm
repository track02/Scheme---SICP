#lang scheme

;Ex 2.16, explain why the equivalent algebraic expressions lead to different answers?
;And is it possible to devise an interval-arithmetic package that does not have this issue


;Dependency Problem

;This cannot be accomplished due to the dependency problem
;interval methods can determine the result of elementary operations and functions very accurately
;but this is not always true for complex functions
;If an interval occurs several times and each occurence is independent this can lead to
;unwanted expansion of the resulting intervals

;E.g.
;f(x) = x^2 + x
;The values of this function over the interval [-1,1] are really [-1/4, 2]
;[-1,1]^2 + [-1,-1] = [0,1] + [-1, 1] = [-1, 2] which is slightly larger