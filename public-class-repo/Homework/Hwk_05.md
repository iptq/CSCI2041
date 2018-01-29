# Homework 5: Lazy Evaluation

*CSci 2041: Advanced Programming Principles, Spring 2017*

**Due:**  5pm Wednesday, April 5


## Part 1: Expression evaluation by-hand 

In class, and demonstrated in the document "Expression Evaluation
Examples" on Moodle, we have evaluated expressions by hand, step by
step, to understand the different ways in which call by value
semantics, call by name semantics, and lazy evaluation work.

#### Question 1

Consider the following definitions:
```
sum [] = 0
sum x::xs -> x + sum xs

take 0 lst = [ ]
take n [ ] = [ ]
take n (x::xs) = x::take (n-1) xs

some_squares_from 0 v = [ ]
some_squares_from n v = v*v :: some_squares_from (n-1) (v+1)
```

Evaluate 
```
sum (take 3 (some_squares_from 5 1))
``` 
using call by value semantics, call by name semantics, and lazy
evaluation.

Each of these three evaluations must be clearly labeled with the form
of evaluation used.

Furthermore, all must be produced electronically.  No handwritten work
will be accepted.  You may use a text editor and turn in a text file.
These are relatively simple so there is no need to use MarkDown or
generate a PDF file.

Your name and University Internet ID must appear in the upper left of
the document. 

Name this file ``question_1.txt`` and place it in a directory named
``Hwk_05`` in your GitHub repository.



#### Question 2

Recall our definitions for ``foldl`` and ``foldr`` as well as the
functions for folding ``and`` over a list of boolean values.  (Note
that we removed the underscores from the names as they appeared on the
slides.)
```
foldr f [] v = v
foldr f (x::xs) v = f x (foldr f xs v)

foldl f v [] = v
foldl f v (x::xs) = foldl f (f v x) xs

and b1 b2 = if b1 then b2 else false

andl l = foldl and true l
andr l = foldr and l true
```

You are asked to evaluate the expressions
```
andl (t::f::t::t::[])
```
and
```
andr (t::f::t::t::[])
```
using both call by value and call by name semantics.

A few things to note:

+ Since anytime a function uses an argument more than once
  (this only happens with ``f`` in the two fold functions) it is given
  a value and not an unevaluated expression, there is no benefit from
  the optimization we get with lazy evaluation.  So we don't need to
  consider it here.

+ To save space we are not spelling out the full name of the values
  ``true`` and ``false`` but are instead abbreviating them here as
  ``t`` and ``f``.  Do not consider these to be variables!  They are
  the boolean literals for true and false.  You may do the same in
  your homework.

+ Lists are written in their basic form using the cons (``::``) and
  nil (``[]``) operators instead of the syntactic sugar form using
  semicolons to separate lists values between square brackets.


Clearly label each evaluation with the kind of semantics used for it.

After you have completed all four of them, explain which one is the
most efficient  and why.

Each of these three evaluations must be clearly labeled with the form
of evaluation used.

Furthermore, all must be produced electronically.  No handwritten work
will be accepted.  As before, you may use a text editor and turn in a
text file.

Your name and University Internet ID must appear in the upper left of
the document.

Name this file ``question_2.txt`` and place it 
in the ``Hwk_05`` directory your created for question 1.





## Part 2: Efficiently computing the conjunction of a list of boolean values in OCaml

Write an OCaml function named ``ands`` with the type
``bool list -> bool`` that computes the same result as the 
``andl`` and ``andr`` functions described in the problem above.

Your OCaml function should be written so that it does not examine or
traverse the entire list if it does not need to.  We saw this behavior
in one of the by-hand evaluations above.  If a ``false`` value is
encountered then it the computation can terminate and return
``false``.


This function should, following the pattern of past assignments, be
placed in a file named ``hwk_05.ml``.  This file must be placed in a
directory named ``Hwk_05`` in your GitHub repository.



## Part 3: Implementing Streams in OCaml

In class, and demonstrated in the file ``streams.ml`` in the
code-examples directory of the public repositories, we developed a
type constructor ``stream`` that can be used to create lazy streams
and make use of lazy evaluation techniques in a strict/eager language.

Below you are asked to define a collection of stream values and
functions over streams.

To start this part of the assignment, first copy the ``streams.ml``
file into your ``Hwk_05`` directory.  Add the following functions to
the end of that file.  But you should clearly mark the parts of this
file that you did not write and attribute them to their author (your
instructor) and then indicate where your work starts in the file by
adding you name and a comment to this effect.

#### ``cubes_from``

Define a function ``cubes_from`` with the type ``int -> int stream``
that creates a stream of the cubes of numbers starting with the
input value.  For example, ``cubes_from 5`` should return a stream
that contains the values 125, 216, 343, ...

Demonstrate to yourself that this work by using ``take`` to generate a
finite number of cubes. 

#### ``drop``

Write a function named ``drop`` with the type ``int -> 'a stream -> 'a
stream``.  This function is the stream version of the ``drop``
function that you've written for lists.  Note the difference of the
type for ``drop`` for that of ``take`` over lists.  Since ``take``
will remove a finite number of elements from a stream we have decided
to store them in a list instead.

#### ``drop_until``

Write a function named ``drop_until`` with the type 
``('a -> bool) -> 'a stream -> 'a stream`` that returns the "tail" of
a stream after dropping all of the initial values for which the first
argument function returns ``false``.

That is, this function keeps dropping elements of the input stream
until it finds one for which the function returns ``true``.  This
element, and all those that follow it, form the stream that is
returned.

For example, using ``head`` and ``squares`` from our original
``streams.ml`` file 
```
head (drop_until (fun v -> v > 35) squares)
```
should evaluate to ``36``


#### ``map``

In ``streams.ml`` we defined the functions ``filter`` and ``zip`` to
work over lists.   You are now asked to define a ``map`` function over
steams with the type ``('a -> 'b) -> 'a stream -> 'b stream``.  This
is the analog to ``map`` over lists.


#### ``squares``, again.

In the class examples we defined the stream of squares of natural
numbers using ``zip`` so that ``squares = zip ( * ) nats nats``.

We could also define ``squares`` as ``squares_from 1`` using the
function defined above.

Define ``squares_again`` to be equal to ``squares`` but define it
using the ``map`` function written above.


#### square roots

You've previously seen a recursive function and an imperative loop to
compute the square root of a floating point number to some specified
degree of accuracy.

We now make use of lazy evaluation to pull apart two aspects of this
algorithm 

1. the part the generates a sequence of approximations to
   the square root of a number, and 
2. the part that determines when the approximations generated so far
   are close enough that we can stop generating them

The **first task** is to define the function ``sqrt_approximations`` with
the type ``float -> float stream`` that takes a floating point number
and generates the stream of approximations to its square root.  This
sequence corresponds to the sequence of values that the local variable
``guess`` took in a previous implementation of this algorithm.

For example, ``take 10 (sqrt_approximations 49.0)`` evaluates to 
```
[25.; 13.; 7.; 10.; 8.5; 7.75; 7.375; 7.1875; 7.09375; 7.046875]
```

(Recall that floating point values are approximations or real numbers
and thus there may be small round off errors that cause your results
to be slightly different from these.)

The **second task** is to write a function whose purpose is similar to
the ``accuracy`` value used in the previous implementations, that is,
to determine when to stop generating approximations.

This function should be named ``epsilon_diff`` with the type ``float
-> float stream -> float``.  The first argument is a floating point
value, perhaps named ``epsilon``.  This function pulls values out of the
stream until the difference between two successive values in the
stream is less than epsilon.  It then returns the second of those two
values.

An example below uses a ``stream`` named ``diminishing`` which begins
at ``16.0`` and each following value is half of its preceding on.
For example, in utop:
```
# take 10 diminishing ;;
- : float list = [16.; 8.; 4.; 2.; 1.; 0.5; 0.25; 0.125; 0.0625; 0.03125]
```
Define ``diminishing`` in your file.

We can use ``epsilon_diff`` to as follows:
```
# epsilon_diff 0.3 diminishing ;;
- : float = 0.25
```
Since the difference between ``0.5`` and ``0.25`` is the first one
that is less than ``0.3``, the second of them is returned.


As a **third task**, include the following declarations to compute the
square root of ``50.0`` to different degrees of accuracy:
```
let rough_guess = epsilon_diff 1.0 (sqrt_approximations 50.0) 

let precise_calculation = epsilon_diff 0.00001 (sqrt_approximations 50.0) 
```

#### another square root

The function ``epsilon_diff`` looked at two successive values to
determine when to stop traversing a stream.

We now want to write a square root approximation function that picks
the first element out of ``sqrt_approximations`` that is within some
threshold.  This one looks at the elements of ``sqrt_approximations``
separately instead of comparing two of them in determining what value
to return.

This function, named ``sqrt_threshold``, has the type ``float -> float
-> float``.  The first floating point value is the one we would like
to take the square root of, call it ``v``.  The second is a threshold
value, call it ``t``.  We want return the first element, say ``s``, of
``sqrt_approximations`` for which the absolute value of ``(s *. s)
-. v`` is less than ``t``.

For full credit this function should make appropriate use of the
functions you've already written and those in the ``streams.ml`` file
we developed in class.

This function, at first glance, seems to return more accurate
answers than our value of epsilon might suggest. For example, 
```
sqrt_threshold 50.0 3.0
```
evaluates to ``7.125``.

Write a comment in your OCaml file just above the definition of
``sqrt_threshold`` that explains why this is.



