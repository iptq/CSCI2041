# Homework 7: Using OCaml Modules

*CSci 2041: Advanced Programming Principles, Spring 2017*

**Due:** 26th April 2017, 5:00 PM

## Introduction

In class and in Chapter 9 of Real World OCaml we developed various
modules for implementing intervals.

Of particular interest were the means for constructing signatures (the
``module type`` declarations), defining modules that implemented a
signature (the ``module`` declarations that name a signature) and
functors. 

In this assignment you have some freedom in how you organize your code
in different files.  But you need at least one file, ``hwk_07.ml``,
that is placed in a ``Hwk_07`` directory 
in your individual repository.

We will use the command 
```
ocamlbuild hwk_07.byte
```
to compile your program.  Since ``ocamlbuild`` will detect dependencies
and compile the named programs you can put some modules in different
files.

Since ``ocamlbuild`` is not installed on the CSE labs machines you can't test 
this.  Use ``utop`` instead and ensure that some combination of ``#mod_use`` and ``#use`` 
directives can be used to load your code.

**Before you start** read these specifications twice.  Your first
reading will give you an overview of what is required but may leave
you with some questions since there are some dependencies between the
various components that make it difficult to enumerate all the
requirements in a linear fashion.  On a second reading you will find
answers to these questions.


## Functors and Signatures for Vectors

We have seen a few examples for implementing intervals and will use
what we learned from those to design modules and signatures for
operations over vectors.  When the size of a vector is 3, it has a
simple geometric interpretation in 3 dimensional space, but we will
consider vectors of any size.

Our vectors will be specified by a signature defining vector
operations (to be described below) and this signature should keep the
type for representing vectors abstract; that is, it is hidden so that
users of the vector cannot manipulate the underlying representation
directly.

Furthermore, vectors are to be parameterized by the kind of numeric
module that supports some basic arithmetic operations.  This module
describes the type and its supporting operations that are the elements
of a vector.  We could have a vector of integers, a vector of floating
point numbers, a vector of complex numbers, even a vector of intervals
of integers.  These "arithmetic" modules must implement the same
signature, perhaps called ``Arithmetic_intf`` (but this choice of name
is up to you).  This signature is similar to the ``Interval_intf`` we
defined in lecture.

Thus, you will need to define a functor for creating vectors.  This
functor takes a module as input that will support the operations that
let it be treated as a number.  This is similar to the ``Make_interval``
functor in the interval examples.

This input module should implement an interface that specifies what
operations (functions) are needed to treat it as a number so that we
can use it as the type of values in a vector.  Presumably there will
need to be an operation for adding and multiplying these values.  We
may also need values identifying the identity for addition (that is,
what the value zero is for this type) and the identity for
multiplication (that is, what the value one is for this type).  These
are only suggestions as the operations in this signature are really
determined by what is required by the operations in the vector
functor.  This signature is similar to the ``Comparable`` signature
used in the interval examples.  That ``Comparable`` signature had to
provide operations that were used in the functions in the
``Make_interval`` functor.


The operations that must be supplied by the module created by the
functor are described below.

+ ``create``. This function take in an integer specifying the size of
  the vector and an initial value to be copied into all positions in the
  new vector.  The type of this initial value is determined by the
  module given as input to the functor ``Make_vector``.

+ ``from_list``.  This function takes a list of element values and
  returns a vector containing those values.

+ ``to_list``.  This function takes a vector and returns a list
  containing the values in the vector.

+ ``scalar_add``.  This function takes a value and an vector in which
  the value is the same type as the elements of the vector.  It returns
  a new vector whose values are computed by adding this value to each
  element of the input vector.

+ ``scalar_mul`` This function takes a value and an vector in which
  the value is the same type as the elements of the vector.  It returns
  a new vector whose values are computed by multiplying this value with each
  element of the input vector.

+ ``scalar_prod``.  This function take two vectors of the same type
  and computes their scalar product, sometimes called the dot product.
  This value is returned in an ``option`` type.

  This operation requires that the vectors have the same number of
  elements.  It then multiplies each corresponding pair of values from
  the two vectors and then adds the up.  This multiply and addition
  operation are the ones defined in the module for the vector element
  type (that is, the input to the ``Make_vector`` functor).

  If the vectors are not the same size, the value of ``None`` is
  returned. If they are the same size, then it returns ``Some `` *x*
  where *x* is the scalar product of the two vectors.

+ ``to_string`` converts a vector to a string.  This string wraps a
  vector in double angle brackets and prints its size and values.  The
  size and values are separated by a vertical bar ``|`` and the values
  are separated by commas.  Examples can be seen below.

+ ``size``.  This function takes a vector and returns the number of
  elements contained in it.

To summarize, the following are needed:
1. A signature for the vector modules
2. A functor for creating vector modules that implements the signature
   for vector modules.
3. A signature defining the type and operations for the numeric values
   that will be the elements of the vector.  Modules implementing this
   signature will be the input module to the functor.



## Modules and Signatures for Vector Elements and Vectors

We will create two modules that will be given to the ``Make_vector``
functor; these are to be named ``Int_arithmetic`` and
``Complex_arithmetic``.  The first is for integer values, the second
for complex numbers in which the real and imaginary parts are floating
point numbers.

These are similar in spirit to the ``Int_comparable`` modules in
``v6/intInterval.ml``. 

Just as ``Int_comparable`` exposed the representation type (there it
was ``int``) here the ``Int_arithmetic`` should also expose this
``int`` type and the ``Complex_arithmetic`` module should expose the
representation type for complex numbers - specifically ``float *
float``.  This can be seen in the examples below.

Both of these will implement the signature for numeric values (the
signature in #3 in the list above).

Thus, we can define the following two modules for two different kinds
of vectors:
```
module Int_vector = Make_vector (Int_arithmetic)

module Complex_vector = Make_vector (Complex_arithmetic)
```

Thus you are required to define the following names of the objects
described above:
+ ``Make_vector``
+ ``Int_arithmetic``
+ ``Complex_arithmetic``
+ ``Int_vector``
+ ``Complex_vector``


## Example evaluations

Assuming the above declaration of ``Int_vector``
has been made consider the following declarations
of integer vectors.
```
let v1 = Int_vector.create 10 1

let v2 = Int_vector.from_list [1;2;3;4;5]

let v3 = Int_vector.scalar_add 3 v2

let v4 = Int_vector.scalar_mul 10 v2

let i1 = Int_vector.scalar_prod v3 v4

let l1 = Int_vector.to_list v3 

let i2 = Int_vector.size v4

let s1 = Int_vector.to_string v1

let s2 = Int_vector.to_string v2

let s3 = Int_vector.to_string v3

let s4 = Int_vector.to_string v4
```

When these declarations are loaded in to utop (assuming the
appropriate module declarations have already been loaded) the
following is displayed by utop when it reports what has been loaded:
```
val v1 : Int_vector.t = <abstr>
val v2 : Int_vector.t = <abstr>
val v3 : Int_vector.t = <abstr>
val v4 : Int_vector.t = <abstr>
val i1 : int option = Some 1000
val l1 : int list = [4; 5; 6; 7; 8]
val i2 : int = 5
val s1 : string = "<< 10 | 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 >>"
val s2 : string = "<< 5 | 1, 2, 3, 4, 5 >>"
val s3 : string = "<< 5 | 4, 5, 6, 7, 8 >>"
val s4 : string = "<< 5 | 10, 20, 30, 40, 50 >>"
```

As you can see, the four vectors ``v1``, ``v2``, ``v3``, and ``v4``
have abstract  values that cannot be displayed by utop.

Also, we can see how the vectors are converted to strings.

This should make it clear how the various vector functions operate.

Similar behavior is observed when complex numbers are used in the
vector instead of integers.

When ``Complex_vector`` has been defined as shown above, consider the
following declarations:
```
let v5 = Complex_vector.from_list [ (1.0, 2.0); (3.0, 4.0); (5.0, 6.0) ]

let v6 = Complex_vector.scalar_add (5.0, 5.0) v5

let c1 = Complex_vector.scalar_prod v5 v6

let s5 = Complex_vector.to_string v5

let s6 = Complex_vector.to_string v6
```
When loaded into utop, the following is displayed by utop when it
reports what has been loaded:
```
val v5 : Complex_vector.t = <abstr>
val v6 : Complex_vector.t = <abstr>
val c1 : Complex_vector.elemType option = Some (-36., 193.)
val s5 : string = "<< 3 | (1.+2.i), (3.+4.i), (5.+6.i) >>"
val s6 : string = "<< 3 | (6.+7.i), (8.+9.i), (10.+11.i) >>"
```
(Note that in the type of ``c1`` you see the name that the solution
uses for the element type, namely ``elemType``.  You may choose another
name for this.  Assessments will not be based on this particular
name.)


