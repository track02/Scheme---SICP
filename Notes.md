
Brief notes for each Chapter/Section.






##1.1) Elements of Programming

A programming language serves as a framework in which to organise ideas about processes 
and offers the means to combine simple ideas in order to form more complex ideas.

There are three key mechanisms for accomplishing this:
- Primitive Expressions, the simplest entities the language is concerned with
- Means of Combination, how complex elements are formed from simpler ones
- Means of Abstraction, by which compound elements can be named and manipulated as units.


###1.1.1) Expressions

The interpreter evaluates a given expression and returns the result of the evaluation.

`> 500`

`  500`

Expressions may be combined using another expression representing a primitive procedure, this forms a compound expression.

`> (+ 5 10)`

`  15`

`> (* 3 6)`

`  18`
  
`> (- 10 5 3)`

`  2`

Expressions formed in this manner are called combinations.
The leftmost element in the list is the operator and the remaining elements are the operands.

The value of a combination is determined by applying the procedure specified by the operator to the 
values of the operands (arguments).

Placing the operator to the left of it's operands is known as prefix notation.

###1.1.2) Naming and the Evironment

A name can be used to identify a variable whose value is the object.

In Scheme, we name objects using `define`.
Once a name has been associated with a value that value can be referred to by name.

`> (define size 2)`

`> size`

`  2`

`> (* 5 size)`

`  10`

Associating values with symbols requires that the interpreter maintains some memory in order to keep track of
the name-object pairings, this memory is known as the global environment.
 
###1.1.3) Evaluating Combinations

In order to evaluate a combination the following rule is used:

  - Evaluate the subexpressions of the combination
  - Apply the procedure that is the value of the leftmost subexpression (operator)
    to the arguments that are the values of the other subexpressions (operands)
    
This is a recursive rule, as in order to evaluate a combination we must first evaluate each element of the combination.

There are exceptions to this rule known as special forms which have their own unique evaluation rules.
`define` is one example as `(define y 4)` does not apply `define` to the two arguments.
Instead 'define associates `y` with `4`


###1.1.4) Compound Procedures

Procedure Definition is an abstraction technique in which a compound operation can be named and referred to as a unit.

The general form of a Procedure Definition is as follows:

`(define (<name> <formal parameters>) <body>)`

For example, the compound procedure cube represents the operation of multiplying a value by itself twice:

`(define (cube x) (* x x x))`

Compound procedures are used in exactly the same way as primitive procedures:

`> (cube 3)`

`27`

###1.1.5) The Substitution Model for Procedure Application

Evaluate the body of the procedure with each formal parameter replaced by the corresponding argument.

Using the previously defined cube procedure:

`(define (cube x) (* x x x))`

And applying in to an argument of three:

`(cube 3)`

Would result in, the following evaluation of a combinator.
The operator is evaluated to determine the procedure to apply to the arguments.

`(* 3 3 3)`

Giving a result of `27`.

If an argument itself is a procedure then it must also be evaluated.

####Applicative Order & Normal Order

Currently we've looked at first evaluating the operator and operands and then applying the resulting procedure to the resulting arguments (Applicative Order Evaluation).

An alternative evaluation model (Normal Order Evaluation) would not evaluate the operands until their values are needed, instead it would substitute operand expressions for paramters until it obtained an expression involving only primitive operators and then would perform the evaluation.

For example, evaluating `(f 5)` this way, where `f` is defined below:

`(define (f a)`

  `(sum-of-squares (+ a 1) (* a 2)))`

`(sum-of-squares (+ 5 1) (* 5 2))`

`(+ (square (+ 5 1)) (square (* 5 2)) )`

`(+ (* (+ 5 1) (+ 5 1)) (* (* 5 2) (* 5 2)))`

`(+ (* 6 6) (* 10 10))`
`(+ 36 100)`

`136`


If we were to compare this to our original model:

We begin by retrieving the body of f:

`(sum-of-squares (+ a 1) (* a 2))`

Then we replace the formal parameter a by the argument 5:

`(sum-of-squares (+ 5 1) (* 5 2))`

`(+ (square 6) (square 10))`

If we use the definition of square, this reduces to

`(+ (* 6 6) (* 10 10))`

which reduces by multiplication to

`(+ 36 100)`

and finally to

`136`

We get the same result either way but the process differs, Normal Order results in `(+ 5 1)` and `(* 5 2)` being performed twice due to the reduction of the expression `(* x x)`. 

Applicative order evaluation is used by List because of the additional efficients (no multiple evaluations of expressions) and because of the relative simplicity of applicative order evaluation in comparison to normal order evaluation.


##3.2) The Environment Model of Evaluation

A variable must somehow designate a place in which values can be stored, in the environmental model of evaluation these places will be maintained in structures called environments.

An environment is a sequence of frames and each frame is a table of bindings which associate variable names with their corresponding values.

A frame may contain at most one binding for any variable, that is the same variable cannot be bound to two different values.
Each frame also has a pointer to its enclosing environment, unless the frame is considered to be global.

The value of a variable wrt to an environment is te value given by the binding of said vairable in the first frame in the environment that contains a binding for that variable.

If no frame in the environment sequence specifies a binding for a variable, it is is said to be unbound in the environment.
