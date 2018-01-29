# Homework 4: Programs as Data.

*CSci 2041: Advanced Programming Principles, Spring 2017*

**Due:** Wednesday, March 22 at 5:00pm.

## Introduction

In this assignment you'll write a few functions that work with
inductive values representing expressions for a small subset of
OCaml.  

In part 1 your functions will convert arithmetic expressions
into strings, in an easy way and then in a way that doesn't generate
unnecessary parenthesis.

In part 2 you'll write an evaluation function the computes the value
of an expression.   But these expressions may define and use recursive
functions so they are computationally interesting.

I expect that this assignment may take up to 10 or 12 hours to
complete, if not more.  So you should start early and not wait until
after spring break to begin.  Be sure to get the help you may need
from TAs before spring break.

There is plenty of time to do this work if you start now.  The due
date will not be pushed back.


## Getting started

## Part 1 - arithmetic expressions as strings

To begin this component, copy the file ``arithmetic.ml`` from
the directory ``Homework/Hwk_04`` in the public class repository and
place it in a directory named ``Hwk_04`` in your repository.


### Simple "unparsing"

Consider the following type for expressions.  We've used variants of
this in class for a number of examples:
```
type expr 
  = Const of int
  | Add of  expr * expr
  | Mul of expr * expr
  | Sub of expr * expr
  | Div of expr * expr
```
This type definition can be found in ``arithmetic.ml``.

Write a function named ``show_expr`` that converts an ``expr`` value
into a ``string`` representation using traditional infix symbols for
the operators.  The output of this function should be something you
could copy and paste into the OCaml interpreter and have it evaluate
to the expected value.

Addition, multiplication, subtraction, and division
should be wrapped in parenthesis so that the generated string
represents the same expression as the input ``expr`` value.  
Constants, however, should not be wrapped in parenthesis.

Your function must include type annotations indicate the types of the
arguments and the return type.

Here are some example evaluations of ``show_expr``:
+ ``show_expr (Add(Const 1, Const 3))`` evaluates to ``"(1+3)"``

+ ``show_expr (Add (Const 1, Mul (Const 3, Const 4)))`` evaluates to ``"(1+(3*4))"``

+ ``show_expr (Mul (Add(Const 1, Const 3),  Div(Const 8, Const 4)))`` evaluates to ``"((1+3)*(8/4))"``


### Pretty-printing expressions

While the function ``show_expr`` should create legal expression
strings, they often have extra parenthesis that are not needed to
understand the meaning of the expression.  This
problem asks you to write a similar function named
``show_pretty_expr`` that does not create any unnecessary parenthesis.

A pair of parenthesis, that is a matching "(" and ")", in 
a string representation of an expression are unnecessary if the value
of the expression with the parenthesis and the value of the expression
without the parenthesis are the same.

Consider the following example using ``show_expr``:
+ ``show_expr (Add (Const 1, Mul (Const 3, Const 4)))`` 
  evaluates to ``"(1+(3*4))"``

The parenthesis around the product "3*4" are not necessary.  Neither
are the parenthesis around the entire expression.

However, in the following case
+ ``show_expr (Mul (Const 4, Add (Const 3, Const 2)))`` 
  evaluates to ``"(4*(3+2))"``

The inner parenthesis around ``3+2`` are needed.  Again, the outer
parenthesis are not needed.  This is because multiplication has higher
precedence than addition.

These examples illustrate that an expression needs to be wrapped
in parenthesis if its operator's precedence is lower than the
operator of the expression containing it.

We think of operator precedence as being equal to, lower than,
or higher than the precedence of other operators.  This suggest that
we use integers to represent the precedence of different operators.

We must also consider the associativity of an operation. Consider this
``expr`` value and the result of applying ``show_expr`` to it.

+ ``show_expr (Sub (Sub (Const 1, Const 2), Sub (Const 3, Const 4)))`` 
  evaluates to ``"((1-2)-(3-4))"``

Note that since subtraction is left associative (a value between two
subtraction operators is associated with the one to its left) the
parenthesis around ``1-2`` are not needed, but those around ``3-4``
are needed.

All operations represented in our ``expr`` type are left associative.
So when the enclosing operator has the same precedence, it may suffice
for an expression to know if it should be wrapped in parenthesis or
not, by knowing if it is the left child or right child (if either) of
the expression that it is a component of.

Of course in some cases, such as at the root of the expression, it
might not be a component of a binary operator.


Write a function ``show_pretty_expr`` that generates a ``string``
representation of an ``expr`` similar to ``show_expr`` but without any
unnecessary parenthesis.  In doing so, write appropriate helper
functions to avoid an overabundance of copy-and-pasted code fragments
that are non-trivial near exact copies of one another.

Also, be sure to use disjoint union types where appropriate.  While
integers are appropriate for representing precedence of operators,
they may not be appropriate in dealing with issues of associativity.

A few more sample evaluations:
+ ``show_pretty_expr (Add (Const 1, Mul (Const 3, Const 4)))`` 
  evaluates to ``"1+3*4"``

+ ``show_pretty_expr (Add (Mul (Const 1, Const 3), Const 4))`` 
  evaluates to ``"1*3+4"``

+ ``show_pretty_expr (Add (Const 1, Add (Const 3, Const 4)))`` 
  evaluates to ``"1+(3+4)"``

+ ``show_pretty_expr (Add (Add (Const 1, Const 3), Const 4))`` 
  evaluates to ``"1+3+4"``

+ ``show_pretty_expr (Mul (Const 4, Add (Const 3, Const 2)))`` 
  evaluates to ``"4*(3+2)"``

+ ``show_pretty_expr (Sub (Sub (Const 1, Const 2), Sub (Const 3, Const 4)))``
   evaluates to ``"1-2-(3-4)"``


It should be clear that ``show_pretty_expr`` cannot be a simple
recursive function with only an ``expr`` as input and a ``string`` as
output.  Nested expressions will likely need to know what kind of
expression they are nested in, and maybe other information as well.
Thus ``show_pretty_expr`` will likely call another function that has
additional inputs that actually does the work of constructing the
string.  Determining what this additional information is and how it is
passed around in the function calls is the interesting part of this
exercise.


## Part 2 - evaluation of expressions with functional values

In class we've written bits and pieces of evalutors for different
kinds of expressions with different kinds or representations for
values. 

In this part of the assignment we pull all these pieces together to
build an interpreter for a small but computationally powerful subset
of OCaml.

For this part of the assignment you will implement a function named
``evaluate`` that has the type ``expr -> value``.

The type for ``expr`` is provided below and an incomplete
specification for the type ``value`` is also given.

```
type expr 
  = Add of expr * expr
  | Sub of expr * expr
  | Mul of expr * expr
  | Div of expr * expr
  
  | Lt of expr * expr
  | Eq of expr * expr
  | And of expr * expr

  | If of expr * expr * expr

  | Id of string
  
  | Let of string * expr * expr
  | LetRec of string * expr * expr

  | App of expr * expr
  | Lambda of string * expr

  | Value of value

and value 
  = Int of int
  | Bool of bool
  | Closure of string * expr * environment
```

To begin this component, copy the file ``eval.ml`` from
the directory ``Homework/Hwk_04`` and place it in a directory named
``Hwk_04`` in your repository.  That file has the type definitions
given above.


### Step 1 - determining the free variables in an expression

To get started with this richer form of expressions write a function
named ``freevars`` that has the type ``expr -> string list``.

This function will, as the name suggests, return the list of free
variables that appear in an expression.  These are the names that are
not "bound" by a let-expression or a by a lambda-expression.

Note that we also have a "let-rec" expression that we will be using
for recursive functions.  It is intended to have the same semantics as
the ``let rec`` construct in OCaml.  For this constucts, the free
variables are those found in either of the two component expressions,
except that we don't include the name bound by the let-rec in the list
of names that are returned.

Consider these sample evaluations of a correct implementation of
``freevars``: 

+ ``freevars (Add (Value (Int 3), Mul (Id "x", Id "y")))``
  evaluates to ``["x"; "y"]``

+ ``freevars (Let ("x", Id "z", Add (Value (Int 3), Mul (Id "x", Id "y")))`)`
    evaluates to ``["z"; "y"]``

+ ``freevars (Let ("x", Id "x", Add (Value (Int 3), Mul (Id "x", Id "y")))`)`
    evaluates to ``["x"; "y"]``

+ ``freevars (Lambda ("x", Add (Value (Int 3), Mul (Id "x", Id "y"))))`` 
  evaluates to ``["y"]``

+ ``freevars sumToN_expr`` 
  evaluates to ``[]``

  where ``sumToN_expr`` is as defined at the end of this file and in the 
  ``eval.ml`` file you copied from the public repository.


### Step 2 - environments

The function that the tests will call must be named 
``evaluate`` and must have the type ``expr -> value``.  You will need
to use environments in this work in a manner similar to what we did in
some of the in-class examples.  Thus you might write a helper function
called ``eval`` that can take any extra needed arguments to actually
perform the evaluation.


### Step 3 - arithmetic expressions

To get stared, first ensure that ``evaluate`` will work for the
arithmetic operations and integer constants.  Much of the work for this
has been done in some of the in-class example already.

An example evaluation:

+ ``evaluate (Add (Value (Int 1), Mul (Value (Int 2), Value (Int 3))))``
  evaluates to ``Int 7``


 
### Step 4 - logical and relational expressions

Logical and relational operations are also straightforward:

Some sample evaluations:

+ ``evaluate (Eq (Value (Int 1), Mul (Value (Int 2), Value (Int 3))))``
  evaluates to ``Bool false``

+ ``evaluate (Lt (Value (Int 1), Mul (Value (Int 2), Value (Int 3))))``
  evaluates to ``Bool true``

### Step 5 - conditional expressions
Conditional expressions should also pose not significant challenge.  
For example 

```
evaluate 
 (If (Lt (Value (Int 1), Mul (Value (Int 2), Value (Int 3))),
     Value (Int 4),
     Value (Int 5)))
```

evaluates to ``Int 4  ``



### Step 6  let expressions
We've implemented non-recursive let-expressions in a forms in
class. Adapting that work to this setting should be straightforward.



### Step 7 - non-recursive functions
We've spent some time in class discussing closures as the way to
represent the value of a lambda expression.  The slides have several
examples of this, a few of which are reproduced here.

The values ``inc`` and ``add`` are defined as follows:
```
let inc = Lambda ("n", Add(Id "n", Value (Int 1)))

let add = Lambda ("x",
                  Lambda ("y", Add (Id "x", Id "y"))
                 )
```

Some sample evaluations:

+ ``evaluate inc``
  evaluates to ``Closure ("n", Add (Id "n", Value (Int 1)), [])``

+ ``evaluate add``
  evaluates to ``Closure ("x", Lambda ("y", Add (Id "x", Id "y")), [])``

+ ``evaluate (App (add, Value (Int 1)))``
  evaluates to ``Closure ("y", Add (Id "x", Id "y"), [("x", Int 1)])``

+ ``evaluate  (App ( (App (add, Value (Int 1))), Value (Int 2)))``
  evaluates to ``Int 3``


### Step 8 - recursive functions

Consider the ``sumToN`` function we discussed in class.  In OCaml,
we'd write this function as follows:
```
let rec sumToN = fun n ->
      if n = 0 then 0 else n + sumToN (n-1)
in sumToN 4
```
To represent this function in our mini-OCaml language defined by the
``expr`` type, we'd represent the function as follows:
```
let sumToN_expr : expr =
    LetRec ("sumToN", 
            Lambda ("n", 
                    If (Eq (Id "n", Value (Int 0)),
                        Value (Int 0),
                        Add (Id "n", 
                             App (Id "sumToN", 
                                  Sub (Id "n", Value (Int 1))
                                 )
                            )
                       )
                   ),
            Id "sumToN"
           )
```
Here we've given the name ``sumToN_expr`` to the ``expr`` value that
represent our ``sumToN`` function.


+ ``evaluate (App (sumToN_expr, Value (Int 10)))``
  evaluates to ``Int 55``



### Handling ill-formed expressions

#### Type errors

Expressions, that is values of type ``expr``, do not necessarily
represent well-typed programs.

For example,
```
   Add (Value (Int 4), Value (Bool true))
```
is type-correct OCaml code, but it represents an expression that is
not type-correct.

Your evaluation function should handle type errors like this by
raising an exception of type ``Failure`` whose string component has
the phrase "incompatible types".

For example

+ ``evaluate (Add (Value (Int 4), Value (Bool true)))``
  raises the exception ``Exception: Failure "incompatible types, Add".``

In the reference solution, this is accomplished by evaluating this
expression:
```
raise (Failure "incompatible types on Add")
```

Your solution should generate messages for ``Failure`` exceptions that
have this form: "incompatible types on AAA" where AAA is replaced by
the 
constructor name that is used in the type ``expr``

Similar exceptions should be raised for other type errors on other
constructors such as ``Mul``, ``Lt``, ``If``, etc.


#### Unbound identifiers

Expressions may also have free variable and evaluating these should
raise an exception as well.

For example,
+ ``evaluate (Add (Id "x", Value (Int 3)))``
  should raise a ``Failure`` exception with the phrase "x not in
  scope".   If the name was "y" then the phrase should be "y not in
  scope. 


#### Recursive let expressions

Recursive let expressions should only bind names to lambda
expressions.

That is, ``expr`` values of the form
```
LetRec (_, Lambda (_, _), )
```
are valid, but a ``LetRec`` that does not have a ``Lambda`` as the
expression as its second component is considered invalid.

If this invalid form of expression is evaluated then your solution
should raise a ``Failure`` exception with the message containing the
phrase "let rec expressions must declare a function".



## Part 3 - Optional next steps

If you are interested in developing these ideas further you are
encouraged to attempt the following problems.

### Static error detection - type checking

Instead of raising an exception when an ill-formed expression, of the
type described above, we could instead do some so-called static
analysis of the expressions to detect the problems *before* evaluating
it. 

One way to detect type errors is to do what is called type checking.
In this approach we would extend the ``Lambda``, ``Let``, and
``LetRec`` constructors so that some indication of the type of the
name being introduced is part of these constructors.

For example, we may indicate that a name ``x`` is to have integer type
in a let with the following:
```
  Let ("x", IntType, Value (Int 4), Add (Id "x", Value (Int 5)))
```
Similar annotations would be needed for the other mentioned
constructors.

With this information in the representation of the expression can you
write a function the checks for the above mentioned forms of invalid
expressions without evaluating them?

What would this function return?

### Static error detection - type inference

How might we statically detect this kinds of errors but without adding
the type annotations described above.  That is, using the existing
definition of `expr` can we detect possible type errors statically?

A correct solution to either of these static error detection problems
would give a guarantee that if no static errors are reported, then
during evaluation there will be no type errors, regardless of the
input. 


### More interesting data structures

Can you extend ``expr`` and ``value`` to support lists and tuples as
they are found in OCaml?

Can you extend your type checking or type inference solutions to work
with these new constructs?

### Turning in your work

If you do want to try these problems, create a file (of files) for
your solution that is different from the ``eval.ml`` solution that
will be the basis of our assessment of the required parts of this
problem.

Any solution must come with significant documentation explaining what
it is that you've done and how your solution works.

Doing this work may improve your grade in this course, but there is no
guarantee of that.  You attempt these problems because you find the
problems interesting and challenging - not because you want to improve
your grade.


