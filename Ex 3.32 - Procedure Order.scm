#lang scheme


;Exercise 3.32: e procedures to be run during each time
;segment of the agenda are kept in a queue.

;us, the procedures for each segment are called in the order in which
;they were added to the agenda (first in, first out).

;Explain why this order must be used.
;In particular, trace the behavior of an and-gate whose inputs change from 0, 1 to 1, 0
;in the same segment and say how the behavior would differ
;if we stored a segment’s procedures in an ordinary list,
;adding and removing procedures only at the front (last in,
;first out).

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;The agenda data structure is used to hold procedures scheduled for future execution
;Time Segments are held by the agenda, each being a pair consisting of a number (time) and a queue
;This queue holds the procedures that are scheduled to be run during that time segment

;The agenda itself is a one-dimensional table of time segment
;The segments are sorted in order of increasing time
;The current time (the time of the last action processed) is stored at the head of the agenda

;A new agenda has no time segments and a current time of 0

;To add an action to the agenda -
    ;Is it empty - create and add a new segment
    ;Does a segment for this time already exist - add action to the queue
    ;Otherwise - create and insert a new segment into correct location

;Remove an item from the agenda first removes the first item in the first time-segment queue
;If the time-segment queue becomes empty then the segment is removed

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;If a normal list were used instead of a queue the actions being added to the agenda could be called out of order
;An action with a time before the last element in the list would not be correctly inserted
;This would cause actions to be executed in the incorrect order leading to the wrong final result
