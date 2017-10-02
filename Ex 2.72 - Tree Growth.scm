#lang scheme

;Ex2.72 - Consider the encoding procedure designed in Ex 2.68
;What is the order of growth in the number of steps needed to encode a symbol?

;Consider the special case where the relative frequencies of the n
;symbols are as described in exercise 2.71, and give the order of growth (as a function of n)
;of the number of steps needed to encode the most frequent and least frequent symbols in the alphabet. 

;For the most frequent symbol, the symbol set needs to be examined once O(N)
;For the lest frequent symbol, successively smaller symbol sets need to be examined, in the example below to encode A
;(A B C D E) -> (A B C) -> (A B)
;O(N) + O(N-1) + O(N-2)...
;O(N^2)

;n = 5
;A 1
;B 2
;C 4
;D 8
;E 16


;                  (A B C D E)
;                  /         \ 
;                (A B C)      E
;                /    \
;              (A B)   C
;              /   \
;             A    B



;n = 10
;A 1
;B 2
;C 4 
;D 8 
;E 16
;F 32
;G 64
;H 128 
;I 256 
;J 512

;                                     (A B C D E F G H I J)
;                                     /                   \
;                             (A B C D E F G H I)          J
;                             /                 \
;                          (A B C D E F G H)     I
;                          /               \
;                     (A B C D E F G)       H
;                     /             \
;                (A B C D E F)       G
;                /           \
;           (A B C D E)       F
;           /         \
;       (A B C D)      E
;       /       \
;     (A B C)    D
;     /     \
;   (A B)    C
;   /   \
;  A     B


;Bits required for the most frequent symbol = 1
;Bits required for the least frequent symbol = n-1

