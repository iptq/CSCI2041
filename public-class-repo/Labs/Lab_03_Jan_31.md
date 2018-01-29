# Lab 3: Improving your OCaml code

*CSci 2041: Advanced Programming Principles, Spring 2017*

**Due:** Friday, February 3 at 5:00pm.  You should be able to complete
the discussion portion of this lab work during the lab.  But you may
need additional time to complete the work on your functions to make
sure that they meet the new requirements for writing "good" code.
This work needs to be completed by the due date.

# Introduction

### Goals of this lab:

In this lab you will work with 1 or 2 of your classmates to improve
the structure and style of your OCaml functions.  You will view your
classmates solutions to Hwk 01 and allow them to view your solution.

This sort of sharing is only allowed, obviously, after the due date.

You will also

1. remove all ``;;`` since they are not needed in an OCaml file;
they only indicate the end of the input when typing a declaration or
expression into the interpreter, 

2. remove a clumsy list construction idiom if you are using it (see
below), and

3. improve your functions so that there are no warning
messages generated when loading your file into OCaml. (Again, see below).


Details about how to make these changes are provided below.


# Form groups.

Find 1 or 2 people that you want to work with in lab.  Feel free to
move around in lab to sit next to the people you are going to work
with.   Introduce yourselves.

You will all want to log into the computer on your desk.  Then you
should log into GitHub and open the page with ``hwk_01.ml`` so that
your solution is visible.


# Prepare the files for lab 3

Create a new directory named ``Lab_03`` and copy your ``hwk_01.ml``
file from ``Hwk_01`` into this new directory.  

At the top of this new file, add a comment with your name.  Also
include the names of the other member or members of your group.


# Determine questions to share.

As a group, you need to decide which 3 functions you want to share
with others in your group, discuss, and then improve your
implementation of that function.

Do not choose the very simple functions ``even``, ``frac_add``, or
``frac_mul``.


# Discuss the first function.

In this part, you will move this selected function to the top of your
new ``hwk_01.ml`` file (after the comment with the names) and add a
new comment above that describes the changes that you made to the
function to address the concerns described below.  You must also
specify if you are borrowing code from another student and give them
proper credit for their work.

Read this entire section before making any more changes to your new
``hwk_01.ml`` file.

**Each of you needs to explain your solution of the first function to
the other 1 or 2 members of your group. Take turns doing this.**

After (or during) this, discuss the characteristics of the different
implementations that you think represent well-written functions.  Also
discuss the characteristics of your functions that you think that you
can improve.

In doing so, consider the 3 points of improvement listed above.
Fixing the first 1 is easy.  Read the next two sections to understand
how to address the more interesting second and third concerns.
Continue your discussion after you've read over these two sections.

### clumsy list construction

When constructing a new list, only use the append operator (``@``)
when the left argument to ``@`` is a list for which you do not know
the size.  

Do not write, for example, ``[ x ] @ my_function rest``.

Instead use the cons operator (``::``) and write
``x :: my_function rest``.


### fixing all warnings

The automated tests for this lab will reject your code if there are
any warning generated for it.  Thus you'll need to fix those.

For example, you may have written a ``head`` function to return the
first element of a list as follows:
```
let head = function
  | x::xs -> x
```

This would yield a warning message like the following:
```
File "hwk_01.ml", line 42, characters 4-144:
Warning 8: this pattern-matching is not exhaustive.
Here is an example of a value that is not matched:
[]
```
telling you that your function doesn't have a clause for the empty
list (``[]``).

The ``head`` function with type ``'a list -> `a`` can only work if it
is given a non-empty list.  If it is called with an empty list, this
is an error in the call of the function, not the function itself.
Thus, the author of ``head`` is justified in raising an exception if
this input is the empty list.  Thus the function should be implemented
as follows:
```
let head = function
  | x::xs -> x
  | _ -> raise (Failure "Incorrect input: empty list passed to head")
```

The idea here is that functions need to be explicit about what kind of
input they can accept.  The type of the function is a good first
approximation of this.  The type indicates what "type" of data can be
passed in, and what "type" of data will be returned.  The type system
will ensure that these requirement will be satisfied by any call to
the function.  Any function call with the incorrect types will be
rejected by the type checker.

But this isn't quite enough for functions like ``head``, ``tail``,
``max_list``, or ``matrix_transpose``.  These function have additional
requirements on their inputs that cannot be specified by the type
system.  For example, that a list is not empty.

If these cases, it is appropriate to raise an exception with a message
stating that the input provided to the function is not correct, or
does not meet the specified requirements of the function.

Note that a function like reverse (``rev``) must work for all possible
inputs (that don't have type errors) and thus, for this assignment,
there must be no ``raise`` constructs in those functions.

Part of your revision of each function is to ensure that none of your
functions have any warning when loaded into OCaml.  For some, this
will require raising an exception in the appropriate place.

Below is a list of when it is allowed to raise exceptions.  Please
consult this in your work.


# Which functions can raise exceptions?

+ ``drop``, ``rev``, and ``perimeter`` must work on all (type-correct)
input and thus must not have any ``raise`` constructs in their
implementation. 

+ ``euclid`` can raise an exception if either of its inputs is not a
positive integer.

+ ``frac_add`` can raise an exception if the denominator is 0.  But it
is OK if you do not and simply do the computation.

+ ``frac_simplify`` can raise an exception if the denominator is 0. 

+ ``square_approx`` can raise an exception if the input is not greater
than 1.0.

+ ``max_list`` can raise an exception if the list is empty.  This is
better than returning ``0`` for the empty list.

+ ``matrix_scalar_add`` can raise an exception if the input is not a
matrix.  Your function ``is_matrix`` is now useful here.

+ The bonus-round problems ``matrix_transpose`` can raise an exception
if its input is not

+ The bonus-round problem ``matrix_multiply`` can raise an exception if
either input is not a matrix or if their sizes are such that they
cannot be multiplied.

+ Helper functions such as ``head`` or ``tail`` can raise appropriate
exceptions.  But most other helper functions probably don't need to.



# Repeat this process for the next 2 functions that you have chosen.

If you run low on time and can only complete 2 functions that is OK.


# What to turn in.

You need to turn in your new ``hwk_01.ml`` file in the new ``Lab_03``
directory via GitHub.

This file must contain your name and the names of those you worked
with.

For each function that your worked on with your group, you must
provide a detailed comment above it explaining the changes that you
made and explain how they improve the implementation of your function.
You must also indicate where the ideas for the changes came from -
that is, who in your group contributed them.

For the remainder of the functions, use what you learned from these
discussions with your classmates to make sure that none of them
produce any warnings and raise exceptions with an appropriate message
and only in the cases described above.
