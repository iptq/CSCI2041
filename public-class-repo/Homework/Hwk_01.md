# Homework 1: OCaml introduction: functions, lists, tuples

*CSci 2041: Advanced Programming Principles, Spring 2017*

**Due:** Monday, January 30 at 5:00pm

## Introduction

Below, you are asked to write a number of OCaml functions.  Some are
simple, such as a function to determine if an integer input is even or
not.  Others are more interesting and ask you to compute the square
root of a floating point number to a specified degree of accuracy.

Designing and implementing these functions will give you the
opportunity to test your knowledge of OCaml and how to write recursive
functions in it.  Successfully completing these will set you up for
the more advanced (and more interesting) topics covered in this
course.

Recall that while some labs may be done collaboratively, *this work
is meant to be done on your own.*

## Designing and implementing functions in OCaml

All functions should be placed in a file named ``hwk_01.ml`` which
resides in a directory named ``Hwk_01``.  This directory should be in
your GitHub repository.

In implementing these functions, do not use any functions from the
``List`` module.  If you need some helper functions over lists, write
them yourself.

Also, you should only use the pure, non-imperative features of OCaml.
No while-loops or references.  But since we've not discussed these
they are easy to avoid.



### even or odd

Write an OCaml function named ``even`` with the type ``int -> bool``
that returns ``true`` if its input is even, ``false`` otherwise.

Recall that we used the OCaml infix operator ``mod`` in class.  You
may find it useful here.

Some example evaluations:
+ ``even 4`` evaluates to ``true``
+ ``even 5`` evaluates to ``false``



### Another GCD, Euclid's algorithmm

In class we wrote a greatest common divisor function that computed the
GCD of two positive integers by counting down by 1 from an initial
value that was greater than or equal to the GCD until we reached a
common divisor.

You are now asked to write another GCD function that is both simpler
to write and faster.

This one is based on the following observations:
+ gcd(a,b) = a, if a = b
+ gcd(a,b) = gcd(a, b-a), if a<b
+ gcd(a,b) = gcd(a-b,b) if a>b

This function should be named ``euclid`` and have the type ``int ->
int -> int``.

To get full credit on this problem, your solution must be based on the
observations listed above.

Some example evaluations:
+ ``euclid 6 9`` evaluates to ``3``
+ ``euclid 5 9`` evaluates to ``1``



### Adding and multiplying fractions

We can use OCaml's tuples to represent fractions as a pair of
integers.  For example, the value ``(1,2)`` of type ``int * int``
represents the value one-half; ``(5,8)`` represents the value
five-eighths.

Consider the following function for multiplying two fractions
```
let frac_mul (n1,d1) (n2,d2) = (n1 *n2, d1 * d2)
```
It has type ``int * int -> int * int -> int * int``.

The expression ``frac_mul (1,2) (1,3)`` evaluates to ``(1,6)``.

Now write a function named ``frac_add`` that adds two fractions.  It
should have the same type as our addition function: ``(int * int) ->
(int * int) -> (int * int)``.

You may assume that the denominator of any fraction is never 0.

Some example evaluations:
+ ``frac_add (1,2) (1,3)`` evaluates to ``(5,6)``
+ ``frac_add (1,4) (1,4)`` evaluates to ``(8,16)``

We see here that your addition function need not simplify fractions,
that is the job of the next function.



### Simplifiying fractions

Write another fraction function that simplifies fractions.  It should
be called 
``frac_simplify`` with type ``(int * int) -> (int * int)``.

Consider the following sample evaluations:
+ ``frac_simplify (8,16)`` evaluates to ``(1,2)``
+ ``frac_simplify (4,9)`` evaluates to ``(4,9)``
+ ``frac_simplify (3,9)`` evaluates to ``(1,3)``

As before, you may assume that the denominator is never 0.

You may want to use your ``euclid`` function in writing ``frac_simplify``.



### Square root approximation

Consider the following algorithms written in psuedo-code similar to C.
Assume that the "input" value ``n`` is greater than 1.0 and all
variables hold real numbers.
```
lower = 1.0;
upper = n;
accuracy = 0.001;
while ( (upper-lower) > accuracy ) {
  guess = (lower + upper) / 2.0;
  if ( (guess*guess) > n)
     upper = guess;
  else
     lower = guess;
}
```
After this algorithm terminates we know that 
*upper >= sqrt(n) >= lower* and 
*upper - lower <= accuracy*.  
That is, lower and upper proivde a bound on the actual square root of
n and that this bound is within the specified accuracy.

You are asked to write a function named ``square_approx`` with type
``float -> float -> (float * float)`` that implements the above
imperative algorithm, returning a pair of values corresponding to
``lower`` and ``upper`` in the imperative psuedo-code.

The first argument corresponds to ``n``, the value of which
we want to take the square root, and the second corresponds
to ``accuracy``.

Of course, this should be a recursive function that does not use any
of OCaml's imperative features such as while-loops and references.

Consider the gcd function that we wrote in class since it has some
characteristics that are similar to those needed for this function -
namely the need to carry additional changing values along the chain of
recursive function calls as additional parameters.

Consider the following sample evaluations:
+ ``square_approx 9.0 0.001`` evaluates to ``(3.,3.0009765625)``
+ ``square_approx 81.0 0.1`` evaluates to ``(8.96875,9.046875)``

(Small round off errors of floating point values are acceptable of
course.) 



### Maximum in a list

Write a function ``max_list`` that takes a list of integers as input
and returns the maximum. 
This function should have the type ``int list -> int``.

In your solution, write a comment that specifies any restrictions on
the lists that can be passed as input to your function.

Some sample interactions:
+ ``max_list [1; 2; 5; 3; 2]`` evaluates to ``5``
+ ``max_list [-1; -2; -5; -3; -2]`` evaluates to ``-1``



### Dropping list elements

Write another list processing function called ``drop`` with type ``int -> 'a list -> 'a list`` that drops a specified number of elements
from the input list.

For example, consider these evaluations:
+ ``drop 3 [1; 2; 3; 4; 5]`` evaluates to ``[4; 5]``
+ ``drop 5 ["A"; "B"; "C"]`` evaluates to ``[ ]``
+ ``drop 0 [1]`` evaluates to ``[1]``

You may assume that only non-negative numbers will be passed as the
first argument to ``drop``.



### List reverse

Write a function named ``rev`` that takes a list and returns the
reverse of that list. 

Recall that ``@`` is the list append operator, you may find this useful.

Some sample interactions:
+ ``rev [1; 2; 3; 4; 5]`` evaluates to ``[5; 4; 3; 2; 1]``
+ ``rev []`` evaluates to ``[]``



### Closed polygon perimeter 

This final problem asks you to compute the perimeter of a closed polygon
represented by a list of points.

You may assume that the list contains at least 3 elements (though our
solution only requires that the list be non-empty).  You may also
assume that drawing line segments between each successive pair of
points leads to a closed polygon with no crossing lines.

Your function should be named ``perimeter`` and have the type
``(float * float) list -> float``.


This function is similar to ``sum_diffs`` from Lab 02 in that we apply
some function to each successive pair of points.  In this case that
function is ``distance`` (also from Lab 02) instead of integer
subtraction.

But we must also include the distance between the first point in the
list and the last point in the list.  So when our recursive function
gets to the base case of having just one more point in the list, it
must have access to the first point in the list so that we can return
the distance between the first and last points.

You will likely need to write a helper function, in a let-expression
nested in your definition of ``perimeter`` that carries along the
value of the first point until it is needed.

Recall how, in our GCD function, we carried along the value of the
potential GCD value that was decremented in each recursive call.  You
will need to do something similar here; the only difference being that
the "carried along" value doesn't change with each call to the
recursive function.


A sample interaction:
+ ``perimeter [ (1.0, 1.0); (1.0, 3.0); (4.0, 4.0); (7.0, 3.0); (7.0, 1.0) ]`` 
  evalutes to, roughly ``16.32``



### Representing matrices as lists of lists

We could consider representing matrices as lists of lists of numbers.
For example the list ``[ [1; 2; 3] ; [4; 5; 6] ]`` might represent a
matrix with two rows (each row corresponding to one of the "inner"
lists) and three columns.

Here the type is ``int list list`` - a list of integer lists.

Of course, the type allows for values that do not correspond to
matrices. For example, ``[ [1; 2; 3] ; [4; 5] ]`` would not represent
a matrix since the first "row" has 3 elements and the second has only
2.

Write a function ``is_matrix`` that takes in values such as the list
of lists given above and returns a boolean value of ``true`` if the
list of lists represents a proper matrix and ``false`` otherwise.

This function checks that all the "inner" lists have the same length.
Since you are not to use any library functions you need to write your
own function to determine the length of a list.

Some sample interactions:
+ ``is_matrix [ [1;2;3]; [4;5;6] ]`` evaluates to ``true``
+ ``is_matrix [ [1;2;3]; [4;6] ]`` evaluates to ``false``
+ ``is_matrix [ [1] ]`` evaluates to ``true``



### A simple matrix operation: matrix scalar addition

Write a function, ``matrix_scalar_add`` with type ``int list list ->
int -> int list list`` that implements matrix scalar addition.  This
is simply the operation of adding the integer value to each element of
the matrix.

For example,
+ ``matrix_scalar_add [ [1; 2 ;3]; [4; 5; 6] ]  5`` evaluates to 
  ``[ [6; 7; 8]; [9; 10; 11] ]`` 

You may assume that only matrices for which ``is_matrix`` evaluates to
``true`` are passed to this function.



## Bonus round

For a small number of extra credit points implement a matrix transpose
function named ``matrix_transpose`` that has type ``'a list list -> 'a
list list``.  It should transpose a matrix such as ``[ [1; 2; 3]; [4;
5; 6] ]`` into ``[ [1; 4]; [2; 5]; [3; 6] ]``.

If you're feeling ambitious, try a matrix multiply function as well.
To simplify this, we'll assume that matrices hold integers and thus
your ``matrix_multiply`` function should have type ``int list list ->
int list list -> int list list``.



