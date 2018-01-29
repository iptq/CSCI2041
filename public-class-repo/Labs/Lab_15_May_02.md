# Lab 15: Parallel Evaluation

*CSci 2041: Advanced Programming Principles, Spring 2017*

**Due:** Friday, Mary 5 at 5:00pm. You may be able to complete
this work during lab, but it may take a bit more time.

## Lab goals.
In this lab you will get a chance to see how to generate parallel code
based on the map and fold constructs we've studied in class.

This lab was developed by Nathan Ringo, who has been working in my (Eric's) lab
and doing some interesting things with parallel programming in Cilk.  Thanks Nathan!

## Getting started.
Copy the file ``Lab_15.tar`` from the ``Labs`` directory in the public
class repository into your individual repository.  This file should be
at the top level - next to all the feedback and assessment files.

Next, type
```
  tar xf Lab_15.tar
```
and this should create a ``Lab_15`` directory in which you will do
your work.

Next, type
```
   git add Lab_15
```
Now Git knows about all the files you'll need to turn in.  You'll need
to commit and push these later, of course.


## Exploring the code.

You'll notice that there are a lot of files in this directory.

It is a working compiler for a small functional language.  It includes
specifications for a scanner and parser.  It includes a definition of
the source and target language as well as how to do some of the
translation.

#### Examples

To get a feel for the source language, look at the ``*.src.txt`` files
in the ``examples`` directory.

There you'll find a few programs in the source language.  These
consist of a sequence of functions (which may be no functions) and a
final expression that is evaluated (often calling these functions).

You don't need to write any more example programs.


#### Run the translator.

Try running some examples.  Return to the ``Lab_15`` directory and
type
```
   ./build.sh examples/arithmetic.src.txt
```
You should see OCaml build the translator, display and compile this
program and show the result - which should be 7.

Try it also for ``funcs.src.txt`` and ``mapseq.src.txt``.

Also, try ``fibseq.src.txt``.  Note how long this takes?  When you
implement parallel map this parallel version in ``fib.src.txt`` should
execute faster.

The parallel map in ``map.src.txt`` and ``fib.src.txt`` and the fold
in ``fold.src.txt`` are not yet implemented.  So don't run these yet.


#### The source language

Next, navigate to the ``src`` directory and look at ``common.ml``.

This file has definition of binary operators that is shared by both
the source and target language.  It also contains some functions for
accessing the environment - but you shouldn't need to use these.

Next, look in the ``src_lang.ml`` file.  This file defines the
``Src_lang`` module (as a file-based module).

Here you see the definition the program syntax, starting with
``program`` - indicating that a source language program is a list of
functions (``func``) and an expression (``expr``).

Functions (``func``) consist of a name, then a list of parameters
(each parameter has a name and a type) and then the expression that is
the body of the function.

Expressions and types then follow.  These should be mostly self
explanatory, but few comments are worthwhile.

+ ``Array`` creates an array from a list of values
+ ``Call`` is a function call.  Note that functions are just names, as strings.
+ ``Fold`` takes just a function name and an expression that should be
   an array.
+ ``Map`` will map the function (again just a name) across the array
  expression. 
+ ``MapSeq`` is a sequential version of map.  ``Map`` will have to be
  translated into parallel code.

The remainder of the file does some type checking of the code.  You
need not read this.

#### The target language

Now take a look at ``tgt_lang.ml`` which defines the target language
of this translator.  Programs written in the source language (as
defined in ``src_lang.md``) are translated into the target language
(as defined in ``tgt_lang.md``).

The target language is similar to the source in that these programs
are also a collection of functions followed by an expression.

(The target language is then translated to C and executed.  This was
visible when running the ``build.sh`` script.)

Expressions are similar but there are some interesting additions
+ ``ArrayGet`` will access an array (the first ``expr``) at some index
  (the second ``expr``).  Indexing begins at position 0, like in C.
+ ``ArraySize`` returns the size of an array.
+ ``Block`` lets statements be written as expressions.  A ``Block``
expression contains a list of statements that are executed. These are
followed by an expression.  This expression is then evaluated and the
value of this expression is returned as the value of the ``Block``
expression.
+ ``Call`` function calls are the same as before
+ ``Spawn`` will spawn the evaluation of an expression.  But the
expression that a ``Spawn`` contains should be a ``Call`` expression. 

Statements are also part of this target language.
+ ``ArraySet`` is an assignment-like statement that sets the value of
an array (the first ``expr``) at an index position (the second
``expr``) to be a new value (the third ``expr``).
+ ``Decl`` creates a new declaration of a variable using it name,
type, and initializing value.
+ A ``For`` loop declares a new integer index variable (its first
``string`` argument) that ranges from the value of the second ``expr``
up to 1 LESS THAN the third ``expr``.  This lets one write for loops
that range over all indices of an array by counting from 0 to the size
of the array.  The body of the for loop is ``stmt list``.
+ ``Sync`` is the Cilk sync statement we discussed in class.
+ ``Sleep`` will delay execution and might be useful in writing slow
functions that will exhibit speedup when run in parallel.  Without
this, some functions are so fast that we don't notice any parallel
speedup.

#### The translation

OK, you should now look at ``translate.ml``.  This defines the
functions ``translate``, ``translate_expr``, ``translate_func``
and a few more.

##### Some simple cases
You need only worry about ``translate_expr`` and the incomplete
definition of ``fold_helper``.

First look over ``translate_expr``.  It does some type checking of the
source language program and translates it to the target language.

The first case of the ``match`` translate array expressions.  It does
this by mapping the translate function over the list of expressions
(``arr``) that are the value that go into the array.

Similarly, translations of ``BinOp`` binary operations like ``Add``
and ``Mul`` are simple too.

Translating Boolean values (``Bool``) and function calls are also
simple.

There are other simple translations later in the file.

##### Sequential map.

The first interesting translation is for the sequential version map
function.  This code does some type checking and then at the end
generates the ``Tgt_lang.Block`` construct that is the translation of
``MapSeq``.  This block declares the output array, followed by the for
loop that sequentially walks down the array applying the function over
array elements.  The final expression is just a reference (``Var
"_map_array"``) that is the value returned.

##### Parallel map.

The first task you should complete it to implement the parallel
version of the map.  This is the ``Map`` construct.

It is suggested that you copy the translation for the sequential map
and modify it by adding appropriate ``Spawn`` and ``Sync`` constructs.

When finished, return to the ``Lab_15`` directory and run
```
   ./build.sh examples/map.src.txt
```
to run the parallel version of ``mapseq.src.txt``

Note that there is no noticeable speedup since the work to be done is so
small.

But you should see a difference between ``figseq.src.txt`` and the
parallel ``fib.src.txt``.


##### The fold construct

The next interesting translation is for ``Fold`` operations.  Here
the provided code does some type checking and translates to a function
call to the ``fold_helper`` function that is defined (partially) at
the top of this file.   This is what we discussed in class last week.
The ``fold_helper`` function should implement the parallel execution
of a fold function.  

There is nothing to do here.  Instead you should complete the
definition of ``fold_helper``.

This will require some careful consideration.  So think about this
before you start programming.  Ask yourself

+ where will the result be stored?

+ since there is no assignment statement, how can I use ``ArraySet``
  to store a single value?  Hint: create an array of size 1 and store a
  temporary result in it.

  To get started, an array of size 1 named ``out`` is already
  declared.

+ what do the parameter ``start`` and ``end`` represent, exactly?

  what values of ``start`` and ``end`` indicate that the range
  contains only 1 item?


This part of the lab will be considered as extra credit worth about
1/2 of what a lab is worth.
