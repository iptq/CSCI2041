# Homework 2: Working with higher order functions.

*CSci 2041: Advanced Programming Principles, Spring 2017*

**Due:** Friday, February 17 at 5:00pm

Lab 4 on February 7 and Lab 5 on February 14 will be dedicated to
answering questions about this assignment and to providing
clarifications if any are needed.

Note that for this assignment you are not to write **any** 
recursive functions. Further information on this restriction is
detailed in Part 3 of the assignment.

## Corrections to mistakes in original specification
+ The type of ``convert_to_non_blank_lines_of_words`` shoud be ``char list -> line list`` not ``string -> line list``.

## Introduction - The Paradelle

In this homework assignment you will write an OCaml program that
reads a text file and reports if it contains a poem that fits the
"fixed-form" style known as a *paradelle*.

Below is a sample paradelle called "Paradelle for Susan" by Billy
Collins from his book *Picnic, Lightning*.


> I remember the quick, nervous bird of your love. <br/>
> I remember the quick, nervous bird of your love. <br/>
> Always perched on the thinnest, highest branch. <br/> 
> Always perched on the thinnest, highest branch. <br/>
> Thinnest of love, remember the quick branch. <br/>
> Always nervous, I perched on your highest bird the.  
>
> It is time for me to cross the mountain.  <br/>
> It is time for me to cross the mountain.  <br/>
> And find another shore to darken with my pain.  <br/>
> And find another shore to darken with my pain.  <br/>
> Another pain for me to darken the mountain.  <br/>
> And find the time, cross my shore, to with it is to. 
>
> The weather warm, the handwriting familiar.  <br/>
> The weather warm, the handwriting familiar.  <br/>
> Your letter flies from my hand into the waters below. <br/>
> Your letter flies from my hand into the waters below. <br/>
> The familiar waters below my warm hand. <br/>
> Into handwriting your weather flies your letter the from the. 
>
> I always cross the highest letter, the thinnest bird. <br/>
> Below the waters of my warm familiar pain, <br/>
> Another hand to remember your handwriting. <br/>
> The weather perched for me on the shore. <br/>
> Quick, your nervous branch flies for love. <br/>
> Darken the mountain, time and find my into it with from to to is.


Following this poem, Collins provides the following description of this form:

>  The paradelle is one of the more demanding French fixed forms, first
appearing in the *langue d'oc* love poetry of the eleventh century.  It
is a poem of four six-line stanzas in which the first and second lines,
as well as the third and fourth lines of the first three stanzas, must
be identical.  The fifth and sixth lines, which traditionally resolve
these stanzas, must use *all* the words from the preceding
lines and *only* those words.  Similarly, the final stanza must
use *every* word from *all* the preceding stanzas and
*only* those words.

Collins is actually being satirical here and poking fun at overly
rigid fixed-form styles of poetry.  There is actually no form known as
the *paradelle*.  This did not stop people from going off and trying
to write their own however.  In fact, the above poem is slightly
modified from his original so that it actually conforms to the rules
of a paradelle.


To write an OCaml program to detect if a text file contains a paradelle
we add some more specific requirements to Collin's description above.
You should take these into consideration when completing this
assignment:

+  Blank lines are allowed, but we will assume that blank lines
  consist of only a single newline ``'\n'`` character. 

+  Punctuation and spacing (tabs and the space characters) should
  not affect the comparison of lines in a stanza.  For example, the
  following two lines would be considered as "identical" because the
  same words are used in the same order even though spacing and
  punctuation are different. 

  ``"And find  the time,cross my shore, to with it is to"``

  ``"And find the time , cross my shore, to with it is to ."``

  Thus, we will want to ignore punctuation symbols to some extent, 
  being careful to notice that they can separate words as in ``"time,cross"``.

  Specifically, the punctuation we will
  consider are the following : 
  
   ``.  !  ?  ,  ;  : -``

  Other punctuation symbols will not be used in any input to assess
  your program.

+ Also, we will need to split lines in the file (of Ocaml type
  ``string``) into a list of lines 
    and then split each line individual line  into a list of
    words.  In the list of words there
    should be no spaces, tabs, or punctuation symbols.  Then we can
    compare lists of words.

+ Capitalization does not matter.  The words ``"Thinnest"``
  and "``thinnest"`` are to be considered as the same.


+ In checking criteria for an individual stanza, each instance of
  a word is counted.  But in checking that the final stanza uses all
  the words of the first 3, duplicate words should be removed. 

  That is, in checking that two lines "use the same words" we must
  check that each word is used the same number of times in each line.

  In checking that the final stanza uses all (and only) words from the
  first 3 stanza, we do not care about how many times a word is
  used. So if a word is used 4 times in the first 3 stanzas, it need
  not be used 4 times in the final stanza.


+ Your program must return a correct answer for any text file.
  For example, your program should report that an empty file or a file
  containing a single character or the source code for this assignment
  are not in the form of a paradelle.



## Getting started

Copy the contexts of the ``Homework/Hwk_02`` directory from the public
class repository into a ``Hwk_02`` directory in your individual
repository. 

This file ``hwk_02.ml`` contains some helper functions that we'll use
in this assignment.  The remainder are sample files containing
paradelles or text that is not a paradelle.  The file names should
make this all clear.



## Part 1. Some useful functions.

Your first step is to define these functions that will be useful in
solving the paradelle check.  Place this near the top of the
``hwk_02.ml`` file, just after the comment that says
```
(* Place part 1 functions 'take', 'drop', 'length', 'rev',
   'is_elem_by', 'is_elem', 'dedup', and 'split_by' here. *)
```

### a length function, ``length``

Write a function, named ``length`` that, as you would expect, takes a
list and returns its length as a value of type ``int``

Annotate your function with types or add a comment
indicating the type of the function.  


### list reverse  ``rev``

Complete the definition of the reverse function ``rev`` in
``hwk_02.ml``.  Currently is just raises an exception.  Remove this
and replace the body with an expression that uses  List.fold_left
or List.fold_right to do the work of reversing the list.

### list membership ``is_elem_by`` and ``is_elem``

Define a function ``is_elem_by`` which has the type
```
('a -> 'b -> bool) -> 'b -> 'a list -> bool
```
The first argument is a function to check if an element in the list
(the third argument) matches the values of the second argument.  It
will return ``true`` if any element in the list "matches" (based on
what the first argument determines) an element in the list.

For example, both
```
is_elem_by (=) 4 [1; 2; 3; 4; 5; 6; 7]
```
and
```is_elem_by (fun c i -> Char.code c = i)  99 ['a'; 'b'; 'c'; 'd']``
evaluate to true.

Next, define a function ``is_elem`` whose first argument is a value and second
argument is a list of values of the same type.  The function returns
``true`` if the value is in the list.

For example, ``is_elem 4 [1; 2; 3; 4; 5; 6; 7]`` should evaluate to
``true`` while ``is_elem 4 [1; 2; 3; 5; 6; 7]`` and ``is_elem 4 [ ]``
should both evaluate to ``false``.

``is_elem`` should be be implemented by calling ``is_elem_by``.

Annotate both of your functions with type information on the arguments
and for the result type.


### removing duplicates from a list, ``dedup``

Write a function named ``dedup`` that takes a list and removes all
duplicates from the list.  The order of list elements returned is up
to you.  This can be done with only a call to ``List.fold_right``,
providing you pass it the correct function that can be used to fold a
list up into one without any duplicate elements.


### a splitting function, ``split_by``

Write a splitting function named ``split_by`` that takes three arguments

1. an equality checking function that takes two values
   and returns a value of type ``bool``,

2. a list of values that are to be separated,

3. and a list of separators values.


This function will split the second list into a list of lists.  If the
checking function indicates that an element of the first list
(the second argument) is an element of the second list (the third
argument) then that element indicates that the list should be split at
that point.  Note that this "splitting element" does not appear
in any list in the output list of lists.

For example, 
+ ``split_by (=) [1;2;3;4;5;6;7;8;9;10;11] [3;7]`` should evaluate to 
  ``[ [1;2]; [4;5;6]; [8;9;10;11] ]`` and
+ ``split_by (=) [1;2;3;3;3;4;5;6;7;7;7;8;9;10;11] [3;7]`` should
evaluate to ``[[1; 2]; []; []; [4; 5; 6]; []; []; [8; 9; 10; 11]]``.

  Note the empty lists.  These are the list that occur between the 3's
  and 7's.

+ ``split_by (=) ["A"; "B"; "C"; "D"] ["E"]`` should evaluate to
  ``[["A"; "B"; "C"; "D"]]``
 
Annotate your function with types.

Also add a comment explaining the behavior of your function and its
type. Try to write this function so that the type is as general as
possible.


## Reading file contents.

Notice the provide helper functions ``read_chars`` and ``read_file``.
The second will read a file and return the list of characters, wrapped
up in an ``option`` type if it finds the file.  If the file, with the
name passed to the function, can't be found, it will return ``None``.



## Part 2. Preparing text for the paradelle check.

The poems that we aim to check are stored as values of type ``string``
in text files.  But the ``read_file`` function above will return this
data in a value of type ``char list option``.

We will need to break the input into a list of lines of text, removing
the blank lines, and also splitting the lines of text into lists of
words.

We need to write a function called
``convert_to_non_blank_lines_of_words`` that takes as input the poem
as an OCaml ``char list`` and returns a list of lines, where each line is
a list of words, and each word is a list of characters.

Thus, ``convert_to_non_blank_lines_of_words`` can be seen as having
the type ``char list -> char list list list``.

We can use the type system to name new types that make this type
easier to read.

First define the type ``word`` to be ``char list`` by
```
type word = char list
```
Then define a ``line`` type to be a ``word list``.

Then, we can specify that 
 ``convert_to_non_blank_lines_of_words`` has
the type ``char list -> line list``.

In writing ``convert_to_non_blank_lines_of_words`` you may want to
consider a helper function that breaks up a ``char
list`` into lines, separated by new line characters (``'\n'``) and
another that breaks up lines into lists of words.


At this point you are not required to directly address the problems
relating to capitalization of letters which we eventually need to
address in checking that the same words appear in various parts of the
poem.  You are also not required to deal with issues of punctuation,
but you may need to do something the be sure that words are correctly
separated.  For example, we would want to see ``that,barn`` as two
words.


## Part 3. The paradelle check.

We will now need to consider how punctuation is to be handled, how
words are to be compared and, in the comparisons of lines, when
duplicate words should be dropped and when they should not be.

We can now begin to write the function to check that a poem is a
"paradelle".

To do this, write a function named ``paradelle`` that takes as input a
filename (a ``string``) of a file containing a potential paradelle.
This function then returns a value of the following type:
```
type result = OK 
	    | FileNotFound of string
	    | IncorrectNumLines of int 
	    | IncorrectLines of (int * int) list
	    | IncorrectLastStanza
```
This type describes the possible outcomes of the analysis.  For example,
1. ``OK``- The file contains a paradelle.
1. ``FileNotFound "test.txt"`` - The file ``test.txt`` was not found.
1. ``IncorrectNumLines 18`` - The file contained 18 lines after the
   blank lines were removed.  A paradelle must have 24 lines.
1. ``IncorrectLines [ (1,2); (11,12) ]`` - Lines 1 and 2 are not the
   same and thus this is not a paradelle.  Also lines 11 and 12, in the
   second stanza, do not have the same words as in the first 4 lines
   of that stanza, and
   this is another reason why this one is not a paradelle.
1. ``IncorrectLastStanza`` - the last stanza does not properly contain
   the words from the first three stanzas.


**Remember, you are not to write any recursive functions.**  Only
  ``read_chars``, ``take``, and ``drop`` can be used.


Furthermore, below is a list of functions from various OCaml modules
that you may also use.  Functions not in this list may not be used.
(Except for functions such as ``input_char`` in functions that were
given to you.)
+ List.map, List.filter, List.fold_left, List.fold_right
+ List.sort, List.concat,
+ Char.lowercase, Char.uppercase
+ string_of_int

The ``sort`` function takes comparison functions as its first argument.
We saw how such functions are written and used in lecture.  

These restrictions are in place so that you can see how interesting
computations can be specified using the common idioms of mapping,
filtering, and folding lists.  The goal of this assignment is not
simply to get the paradelle checker to work, but to get it to work and
for you to understand how these higher order functions can be used.


## Some advice.
You will want to get started on this assignment sooner rather than
later.  There are many aspects that you need to think about.  Most
importantly is the structure of your program the various helper
functions that you may want to use.

We recommend writing your helper functions at the "top level" instead
of nested in a ``let`` expression so that you can inspect the type
inferred for them by OCaml and also run them on sample input to check
that they are correct.


## Feedback tests.

Feedback tests are not initially turned on.  You should read these
specifications and make an effort to understand them based on the
descriptions.

If you have questions, ask your TAs in lab or post them to the "Hwk
02" forum on Moodle.

Feedback tests will be available next week.


