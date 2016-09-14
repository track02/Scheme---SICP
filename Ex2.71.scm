#lang scheme

;Ex2.71 Suppose we have a Huffman tree for an alphabet of n symbols, and that the relative
;frequencies of the symbols are 1, 2, 4, ..., 2^n-1
;Sketch the tree for n=5; for n=10.
;In such a tree (for general n) how may bits are required
;to encode the most frequent symbol? the least frequent symbol?


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