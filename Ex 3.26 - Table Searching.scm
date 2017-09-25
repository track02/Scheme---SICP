#lang sicp

;Exercise 3.26
;To search a table as implemented above, one
;needs to scan through the list of records. is is basically
;the unordered list representation of Section 2.3.3. For large
;tables, it may be more efficient to structure the table in a different
;manner.

;Describe a table implementation where the
;(key, value) records are organized using a binary tree, assuming
;that keys can be ordered in some way (e.g., numerically
;or alphabetically).

;Compare to exercise 2.66

; A binary tree associates a key to a value by stepping through the tree node-to-node
; Each node key is compared to the parameter key
; If the key is less than the node key, move to the left branch
; If the key is greater than the node key, move to the right branch
; Repeat the process until a match is found or the end of the tree is reached
; This effectively halves the search space with each iteration (logN)

; This lookup method would replace the current assoc procedure used for tables
; giving a logN search time rather than the N search time of the old procedure which
; iterates over all list entries

; Adjustments to the lookup / insert values would then be needed to use the previously defined
; binary tree procedures

; the adjoin-set method would now be used to insert a key/value pair
; adjoin-set takes a key/value pair and a set
; similar to the lookup method it traverses the tree by checking the given key weighting
; to the current node weighting.
; If a matching key is found its updated with the value, if no match is found a new node is
; created with the key/value pair and empty left/right branches

; lookup would simply return the result of the  assoc method