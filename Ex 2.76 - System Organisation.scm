#lang scheme

;Exercise 2.76.
;As a large system with generic operations evolves, new types of data objects or new
;operations may be needed.

;For each of the three strategies -- generic operations with explicit dispatch,
;data-directed style, and message-passing-style -- describe the changes that must be made to a system in
;order to add new types or new operations.

;Which organization would be most appropriate for a system
;in which new types must often be added? Which would be most appropriate for a system in which new
;operations must often be added?

;Explicit Dispatch
;To add new data types - checks for the new type need to be added in each generic operation
;To add new operations - new procedure that checks for all existing types


;Data-directed approach
;To add new data types - add the operations/type entries into the operation table with a new type package
;To add new operations - update each type package to include the new operations


;Message Passing
;To add new data types - create a new implementation of that type
;To add new operations - update each type implementation to include the new operation

;I think both approaches could be suitable, but creating new data types is simpler using message-passing
;where the data-directed approach is more appropriate for adding operations.

;data-directed requires registering new types into the table 
;message-passing operations are tightly bound to the data available via constructor
