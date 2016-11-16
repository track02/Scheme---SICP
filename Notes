
Brief notes for each Chapter/Section.

1.1) Elements of Programming

A programming language serves as a framework in which to organise ideas about processes 
and offers the means to combine simple ideas in order to form more complex ideas.

There are three key mechanisms for accomplishing this:
- Primitive Expressions, the simplest entities the language is concerned with
- Means of Combination, how complex elements are formed from simpler ones
- Means of Abstraction, by which compound elements can be named and manipulated as units.


1.1.1) Expressions

The interpreter evaluates a given expression and returns the result of the evaluation.

'> 500
'  500

Expressions may be combined using another expression representing a primitive procedure, this forms a compound expression.

'> (+ 5 10)
'  15

'> (* 3 6)
'  18
  
'> (- 10 5 3)
'  2

Expressions formed in this manner are called combinations.
The leftmost element in the list is the operator and the remaining elements are the operands.

The value of a combination is determined by applying the procedure specified by the operator to the 
values of the operands (arguments).

Placing the operator to the left of it's operands is known as prefix notation.

1.1.2) Naming and the Evironment

A name can be used to identify a variable whose value is the object.

In Scheme, we name objects using 'define.
Once a name has been associated with a value that value can be referred to by name.

'> (define size 2)
'> size
'  2
'> (* 5 size)
'  10

Associating values with symbols requires that the interpreter maintains some memory in order to keep track of
the name-object pairings, this memory is known as the global environment.
 
1.1.3) Evaluating Combinations

In order to evaluate a combination the following rule is usede:

  - Evaluate the subexpressions of the combination
  - Apply the procedure that is the value of the leftmost subexpression (operator)
    to the arguments that are the values of the other subexpressions (operands)
    
This is a recursive rule, as in order to evaluate a combination we must first evaluate each element of the combination.

There are exceptions to this rule known as special forms which have their own unique evaluation rules.
'define is one example as (define y 4) does not apply 'define to the two arguments.
Instead 'define associates 'y with '4






