

##1.1) Elements of Programming

A programming language serves as a framework in which to organise ideas about processes 
and offers the means to combine simple ideas in order to form more complex ideas.

There are three key mechanisms for accomplishing this:
- Primitive Expressions, the simplest entities the language is concerned with
- Means of Combination, how complex elements are formed from simpler ones
- Means of Abstraction, by which compound elements can be named and manipulated as units.


### Expressions

The interpreter evaluates a given expression and returns the result of the evaluation.

```scheme
 500
>500
```

Expressions may be combined using another expression representing a primitive procedure, this forms a compound expression.

```scheme
(+ 5 10)
>  15

(* 3 6)
>  18
 
(- 10 5 3)
>  2
```

Expressions formed in this manner are called combinations.
The leftmost element in the list is the operator and the remaining elements are the operands.

The value of a combination is determined by applying the procedure specified by the operator to the 
values of the operands (arguments).

Placing the operator to the left of it's operands is known as prefix notation.

### Naming and the Evironment

A name can be used to identify a variable whose value is the object.

In Scheme, we name objects using `define`.
Once a name has been associated with a value that value can be referred to by name.

```scheme
(define size 2)
size
>  2

(* 5 size)
>  10`
```

Associating values with symbols requires that the interpreter maintains some memory in order to keep track of
the name-object pairings, this memory is known as the global environment.
 
### Evaluating Combinations

In order to evaluate a combination the following rule is used:

  - Evaluate the subexpressions of the combination
  - Apply the procedure that is the value of the leftmost subexpression (operator)
    to the arguments that are the values of the other subexpressions (operands)
    
This is a recursive rule, as in order to evaluate a combination we must first evaluate each element of the combination.

There are exceptions to this rule known as special forms which have their own unique evaluation rules.
`define` is one example as `(define y 4)` does not apply `define` to the two arguments.
Instead 'define associates `y` with `4`


### Compound Procedures

Procedure Definition is an abstraction technique in which a compound operation can be named and referred to as a unit.

The general form of a Procedure Definition is as follows:

```scheme
(define (<name> <formal parameters>) <body>)
```

For example, the compound procedure cube represents the operation of multiplying a value by itself twice:

```scheme
(define (cube x) (* x x x))
```

Compound procedures are used in exactly the same way as primitive procedures:

```scheme
(cube 3)
> 27
```

### The Substitution Model for Procedure Application

Evaluate the body of the procedure with each formal parameter replaced by the corresponding argument.

Using the previously defined cube procedure:

```scheme
(define (cube x) (* x x x))
```
And applying in to an argument of three:

`(cube 3)`

Would result in, the following evaluation of a combinator.
The operator is evaluated to determine the procedure to apply to the arguments.

```scheme
(* 3 3 3)
```

Giving a result of `27`.

If an argument itself is a procedure then it must also be evaluated.

####Applicative Order & Normal Order

Currently we've looked at first evaluating the operator and operands and then applying the resulting procedure to the resulting arguments (Applicative Order Evaluation).

An alternative evaluation model (Normal Order Evaluation) would not evaluate the operands until their values are needed, instead it would substitute operand expressions for paramters until it obtained an expression involving only primitive operators and then would perform the evaluation.

For example, evaluating `(f 5)` this way, where `f` is defined below:

```scheme
(define (f a)
  (sum-of-squares (+ a 1) (* a 2)))

(sum-of-squares (+ 5 1) (* 5 2))

(+ (square (+ 5 1)) (square (* 5 2)))

(+ (* (+ 5 1) (+ 5 1)) (* (* 5 2) (* 5 2)))

(+ (* 6 6) (* 10 10))
(+ 36 100)

> 136
```

If we were to compare this to our original model:

We begin by retrieving the body of f:

```scheme
(sum-of-squares (+ a 1) (* a 2))
```

Then we replace the formal parameter a by the argument 5:

```scheme
(sum-of-squares (+ 5 1) (* 5 2))

(+ (square 6) (square 10))
```
If we use the definition of square, this reduces to

```scheme
(+ (* 6 6) (* 10 10))
```
which reduces by multiplication to

```scheme
(+ 36 100)
```

and finally to

`136`

We get the same result either way but the process differs, Normal Order results in `(+ 5 1)` and `(* 5 2)` being performed twice due to the reduction of the expression `(* x x)`. 

Applicative order evaluation is used by List because of the additional efficients (no multiple evaluations of expressions) and because of the relative simplicity of applicative order evaluation in comparison to normal order evaluation.


### Conditional Expressions and Predicates

The general form of a conditional expression is as follows:

```scheme
(cond ({P1} {E1})
      ({P2} {E2})
      ...
      (PN} {EN}))
```
It cosists of the the symbol cond followed by pairs of expressions `({p} {e})` called clauses.
The first expression in a clause pair is a predicate, it evaluates to either true or false.
A conditional expression is evaluated as follows, the first predicate is evaluated, if it is false then the second predicate  is evaluated. This process continues until a predicate is found which evaluates to true, the interpreter then returns the value of the corresponding consequent expression `{e}`. If no predicates are found to be true, the value of the cond is undefined.

There is also a restricted conditional that can be used if there are two cases in the case analysis, it takes the form of an `if` expression.

```scheme
(if {predicate} {consequent} {alternative})
```

With an `if` expression, the interpreter starts by evaluating the predicate, if it evaluates to true then `consequent` is evaluated and its value returned otherwise `alternative` is evaluated and its value returned instead.

In addition to primitive predicates such as `<`, `=` and `>` there are also logical composition operations which enable us to construct compound predicates:

```scheme
(and {e1} ... {e2})
(or  {e1} ... {e2}) 
(not {e1})
```

`and` - If any expression evaluates to false the value of the and expression is false and the remaining expressions are not evaluated.

`or` - If any expression evaluates to true the value of the or expression is true and the remaining expressions are not evaluated.

`not` - The value of a not expression is true when the expression `e` is false, and false otherwise.

### Procedures as Black Box Extractions

Each procedure should accomplied a clearly identifiable task that can be used as a module in the definition of further procedures.

Looking at the following procedure definition:

```scheme
(define (good-enough? guess x)
 (< (abs (- (square guess) x)) 0.001))
```

We are able to define the `square` procedure as a black box, at this moment we are not concerned with how the procedure computes square but just with the fact that it computes square. The inner workings can be considered at a later time.

`square` is not seen as a concrete procedure but rather an abstraction of a procedure or a procedural abstraction. (at the moment its just 'something' that computes the square). 

At this level of abstraction any procedure that computes the square is equally valid meaning that the following two procedures should be indistinguishable.

```scheme
(define (square x) (* x x))
(define (square x) (exp (double (log x))))
(define (double x) (+ x x))
```

So, a procedure definition should be able to suppress details and allow users of the procedure not to concern themselves with the inner workings and implementations of the procedure, it is just a black box that when given values computes the expected result.


## The Environment Model of Evaluation

A variable must somehow designate a place in which values can be stored, in the environmental model of evaluation these places will be maintained in structures called environments.

An environment is a sequence of frames and each frame is a table of bindings which associate variable names with their corresponding values.

A frame may contain at most one binding for any variable, that is the same variable cannot be bound to two different values.
Each frame also has a pointer to its enclosing environment, unless the frame is considered to be global.

The value of a variable wrt to an environment is te value given by the binding of said vairable in the first frame in the environment that contains a binding for that variable.

If no frame in the environment sequence specifies a binding for a variable, it is is said to be unbound in the environment.


![Environment 1](/SICP - Images/Environment_Example_1.png)


Above is a simple environment structure consisting of three frames (I, II and III). The arrows A, B, C and D represent pointers to environments.

C and D both point to the same environment, the variables `z` and `x` are bound in Frame II whilst `y` and `x` are bound in Frame I. The value of `x`in Environment D is 3 the value of `x` with respect to environment B is also 3.

This is determined as follows:

- We look at the first frame in the seqence, if no binding for the variable is found we proceed to the enclosing environment 
- If no binding is found we proceed to the next enclosing environment, if there are no further environments no binding exists.

Following these steps, we can tell that the value of `x` in Environment A is 7 because the first frame in the sequence contains a binding of `x` to 7. With respect to environment A, the binding of `x` to 7 in Frame II is said to shadow the binding of `x` to 3 in Frame I.

The environment is crucial to the evaluation process as it determines the context in which an expression should be evaluated.
An expression acquires meaning only with respect to some environment in which it is evaluated.


## The Rules of Evaluation

Even when applying the Environmental Model of Evaluation, the method in which the interpreter evaluates a combination remains the same:

- Evaluate the subexpressions of a combination
- Apply the value of the operator subexpression to the values of the operand subexpressions.

The Environmental Model replaces the Substitution Model in specifying what it means to apply a compound procedure to arguments. In the Environmental Model a procedure is always a pair consisting of some code and a pointer to an environment.

Procedures can only be created by evaluation a λ-expression. This creates a procedure whose code is obtained from the contents (text) of the λ-expression and whose environment is the environment in which the λ-expression itself was evaluated to produce the procedure.

Consider the following procedure definition being evaluated in the global environment.

```scheme
(define (square x)
 (* x x))
```

The procedure definition syntax `(define ...` is just syntactic sugar for an underlying λ-expression, it's equivalent to:

```scheme
(define square
 (lambda (x) (* x x)))
```

Which evaluates `(lambda (x) (* x x))` and binds square to the resulting values, all in the global environment. The figure below illustrates this process:


![Environment 2](/SICP - Images/Environment_Example_2.png)

The procedure object is a pair whose code specifies that the procedure has a single formal parameter `x` and a procedure body `(* x x)`. The environment part of the procedure is a pointer to the global environment since that is where the λ-expression was evaluated to produce the procedure.

A new binding associates the procedure object with the symbol `square` which has been added to the global frame. In general `define` creates definitions by adding bindings to frames.

## Applying Procedures

Under the Environmental Model, to apply a procedure to argument create a new environment containing a frame that binds the parameters to the values of the arguments. The enclosing environment of the frame is the environment specified by the procedure. 
Within this new evironment the procedure body is evaluated.

Below is illustration showing the environment structure created by evaluating `(square 5)` in the global environment, where `square` is the procedure generated in the previous section.

![Environment 3](/SICP - Images/Environment_Example_3.png)

Applying the procedure results in the creation of a new environment (E1) that begins with a frame in which `x` the formal parameter for the procedure is bound to the argument `5`. The pointer leading from the frame shows that the enclosing environment for the frame is the global environment.  The global environment is chosen here as this is the environment that is indicated as part of the `square` procedure object.

Within E1 the body of the procedures `(* x x)` is evaluated and because `x` is bound to `5` the result is `(* 5 5)` or `25`.

So, the environmental model of procedure application can be summed up as foolows:

- A procedure object is applied to a set of arguments be constructing a frame, binding the formal parameters of the procedure to the arguments of the call and then evaluating the body of the procedure in the context of the new environment constructed. The new frame has as its enclosing environment the environment part of the procedure object being applied.

- A procedure is created through the evaluation of a λ-expression relative to a given environment. This results in a procedure object which is a pair consisting of the text of the λ-expression and a pointer to the environment in which the procedure was created.

We also specify that defining a symbol using `define` creates a binding in the current environment frame and assigns to the symbol the indicated value. Lastly we'll look at `set!`, evaluating the expressions `(set! {var} {value})` in some environment locates the binding of the variable in the environment and changes the binding to indicate the new value. That is, the first frame in the environment which contains the binding is located and modified. If the variable is not bound then `set!` will return an error.


