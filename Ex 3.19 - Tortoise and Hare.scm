#lang sicp

;Exercise 3.19: Redo Exercise 3.18 using an algorithm that
;takes only a constant amount of space. (is requires a very clever idea.)

;I came across an algorithm that achieves this performance when investigating Exercise 3.18
;Tortoise and Hare operates using only two pointers, no additional space is allocated as the algorithm progresses

;Summary - from C2 Wiki

;A simple technique for detecting infinite loops inside lists, symlinks, state machines, etc.

;For example, to detect a loop inside a linked list:

;    make a pointer to the start of the list and call it the hare
;    make a pointer to the start of the list and call it the tortoise
;    advance the hare by two and the tortoise by one for every iteration
;    there's a loop if the tortoise and the hare meet
;    there's no loop if the hare reaches the end

;This algorithm is particularly interesting because it is O(n) time and O(1) space,
;which appears to be optimal more obvious algorithms are O(n) space. 

;See Exercise 3.18 for example
