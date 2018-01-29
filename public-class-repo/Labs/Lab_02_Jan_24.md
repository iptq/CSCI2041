# Lab 2: Introduction to OCaml

*CSci 2041: Advanced Programming Principles, Spring 2017*

**Due:** Friday, January 27 at 5:00pm.  You should be able to complete
lab work during the lab.   But occasionally some work may not get
completed, thus this due date. 

# Introduction

### Goals of this lab:

+ In this lab you will write a few functions in OCaml to begin the
process of learning how best to use it.

+ You will create a file named *lab_02.ml* in a *Lab_02* directory
  inside your individual class repository.  

  Since we use some scripts in grading different aspects of your work
  it is critical that you name your directories and files exactly as
  specified.


# Getting started.

In your individual repository, make a directory named *Lab_02* and
change into it: 
```
% mkdir Lab_02
% cd Lab_02
```

Create an empty file with the name *lab_02.ml*:
```
% touch lab_02.ml
```

It is in this file that you will put your solutions to the programming 
problems below.

In a separate terminal window, run ``utop`` (the system used in lecture) or ``ocaml`` 
to start the OCaml interpreter.  To load the contents of your file type 
```
#use "lab_02.ml" ;;
```
at the ``#`` prompt.  As you edit your file you'll need to do this again each time
to load your changes.


# OCaml programming 

Some of the functions that you are asked to solve below are similar to
ones we've solved in class.  These can be found in ``simple.ml`` in
the ``code-examples`` directory of the public repository.  Open
another tab in your browser and you can see that file
[here](https://github.umn.edu/umn-csci-2041S17/public-class-repo/blob/master/SamplePrograms/simple.ml).

### #1 Circle area, version 1

Write a function named ``circle_area_v1`` with the type ``float ->
float``.  This function should take as input the **diameter** (not the
radius) of a circle and compute its area.

For this version, do not use any nested let-expressions or function
calls; only use literals like ``3.1415`` and floating point operators
such as ``*.``, ``+.``, or ``/.``.

For example, ``circle_area_v1 2.5`` should evaluate to about ``4.90``.

### #2 Circle area, version 2

Now write another version of this function, this time named
``circle_area_v2`` with the same type as ``circle_area_v1``.

This version, however, must use a nested let-expression to define the
constant ``pi`` to have the appropriate value.  If there are any
computations that are duplicated (perhaps computing the radius from
the diameter provided as input) use a nested let-expression to give
that sub-computation a name and use it accordingly in the computation.

### #3 Product of a list of elements

In lecture, we wrote a function to compute the sum of all the values
in a list of integers.  It had the type ``int list -> int``.

Write a similar function named ``product`` that computes the product
of the values in a list of integers.  It will have the same type as
the sum function.

For example, ``product [2; 3; 4]`` should evaluate to ``24``.


### #4 Sum of differences

For this problem, you are to write a function that again has the type
``int list -> int``.  It must be called ``sum_diffs`` and it will
compute the sum of the differences between all successive pairs of
numbers in the list.

For example, ``sum_diffs [4; 5; 2]`` will evaluate to ``2``.

You just write a recursive list-processing function for this task,
despite the fact that some arithmetic simplification of the
computation (in the case above it would be (4-5) + (5-2)) would let us
do the computation in just one subtraction operation.  Write the function so
that it carries out the operation naively and computes the difference between
each successive pair of numbers.

You may assume that this function will only be passed lists of length
2 or more, so you don't need patterns to handle, for example, the
empty list.  Instead, our "base case" will be a pattern that matches
a 2-element list, like the following:
```
  | x1::(x2::[]) -> x1 - x2
```
This pattern has something more complex than a simple name to the
right of the ``::`` cons constructor.  It has another nested pattern that
matches a list of one element.  Together, this pattern only
matches lists with exactly 2 elements.  Note that the parenthesis are
not required here; they only make it explicit that the cons
constructor is right associative.

You will also need and another pattern that matches lists of 2 or more
elements.  This second pattern will need to bind 2 elements of the
list some names so that your expression can compute their difference.
It will be similar to the one above, but you need to figure out the
details.


Don't hesitate to discuss this problem with your fellow students or your TAs.


### #5 2D points and distance between them

Tuples in OCaml are simple data structures for holding a few values of
possibly different types.  For example, we might represent points on a
plane using two floating point values in a tuple.  This type is
written ``float * float``.

A function that returns ``true`` if a point is in the "upper-right" quadrant 
of a plane might be implemented as follows:
```
let upper_right (x,y) = x > 0.0 && y > 0.0
```
This function has the type ``float * float -> bool``.

Implement a function named ``distance`` with type ``float * float ->
float * float -> float`` to compute the distance between two points
(each represented as a tuple of 2 ``float`` values).

You may find the ``sqrt`` function useful in this function.


### #6 Triangle perimeter

This problem asks you to compute the perimeter of a triangle.  For a
triangle with 3 corners named p1, p2, and p3, the perimeter is the
distance from p1 to p2 plus the distance from p2 to p3 plus the
distance from p3 back to p1.

Implement a function named ``triangle_perimeter`` with type ``float *
float -> float * float -> float * float -> float`` to do this.



*This concludes lab 02.*


**Due:** Friday, January 27 at 5:00pm.  You should be able to
complete lab work during the lab.  But occasionally some work may not
get completed, thus this due date.

Note that these changes must exist in your repository on
github.umn.edu.  Doing the work, but failing to push those changes to
your central repository cannot be assessed.

