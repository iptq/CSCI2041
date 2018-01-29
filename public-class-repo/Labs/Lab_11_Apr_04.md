# Lab 11: Denotational Semantics

*CSci 2041: Advanced Programming Principles, Spring 2017*

**Due:** Friday, April 7 at 5:00pm. You should be able to complete
this work during lab.  


## Lab goals
This lab will explore the interpreter that we wrote in lecture and
extend it a bit.

## Getting started.
Copy the file ``interpreter.ml`` from either the
``SamplePrograms/Sec_01_1:25pm`` or
``SamplePrograms/Sec_10_3:35pm`` directory of
the public class repository into a
new directory named ``Lab_11``.  Name the copy of this file
``interpreter.ml``.

## Review
Open the file and familiarize your self with the data types and the
functions ``eval`` and ``exec``.

Run ``exec program_2 []``.  And enter ``10``.  How many times does
``sum`` appear in the final state?

Create a let-binding in your file of the from
```
let num_sum = ...
```
where ``...`` is replaced by the number of times that ``sum`` appears
in the final state.


## Add and conditional statement -- if-then-else

Add a new constructor of the following form to ``stmt``:
```
  | IfThenElse expr * stmt * stmt
```
Then write to clause for this new constructor in the ``match``
expression in ``exec``.

Next, add a modulus operator constructor to ``expr``:
```
  | Mod of expr * expr
```
Then write the clause for this new constructor in the ``match``
expression in ``eval``.

Hint: in OCaml, ``mod`` is the infix operator for modulus.  Try it out
in ``utop``.

## Another program:
Construct a new program of type ``stmt`` named ``program_3``.  It
should correspond to the following comment already in
``interpreter.ml``.  Note how ``program_1`` and ``program_2`` both
have similar comments for them.  You need to construct a let-binding
for ``program_3`` that corresponds to the program in the comment below:
```
(* read x;
   i = 0;
   sum_evens = 0;
   sum_odds = 0;
   while (i < x) {
     write i;
     if i mod 2 = 0 then
        sum_evens = sum_evens + i;
     else
        sum_odds = sum_odds + i;
     i = i + 1
   }
   write sum_evens;
   write sum_odds
 *)
```

## Test your extended ``exec``

Run ``exec program_3 []`` and enter ``8`` when prompted to enter a
number.

It should print out the integers from 0 to 7 and the print 12 and then
16.

Run ``exec program_3 []`` and enter ``15`` when prompted.

Create the following let-bindings in your file:
```
let val_sum_evens =
let val_sum_odds =
let num_sum_evens =
let num_sum_odds =
```
+ give ``val_sum_evens`` the value of ``sum_evens`` in the final state
+ give ``val_sum_odds`` the value of ``sum_odds`` in the final state
+ give ``num_sum_evens`` the number of times ``sum_evens`` appears in
  the final state
+ give ``num_sum_odds`` the number of times ``sum_odds`` appears in
  the final state


## Create a testable version of program_3
Define ``program_3_test`` in your file to be the same as
``program_3``, but replace
```
Read "x"
```
 with 
```
Assign ("x", Value (Int 12))
```


The following should evaluate to ``Int 30``
```
lookup "sum_evens" (exec program_3_test [])
```

This is one of the automated tests.

## An if-then and a skip statement
Add the following constructors to ``stmt``:
```
  | IfThen of expr * stmt
  | Skip
```
The first is the if-then statement you should expect.  The second is a
"skip" statement that does nothing.  It is like ``pass`` in Python or
a "noop" in assembly language.

Complete the implementation of ``exec`` to handle these new
constructs.   You might implement the ``IfThen`` construct based on
the observation that executing "if ...cond... then ...stmt..." is the same as
executing "if ...cond... then ...stmt... else skip".

Next, define ``program_4`` to correspond to to the following comment:
```
(* y = 0;
   if x mod 2 = 0 then y = y + 2;
   if x mod 3 = 0 then y = y + 3;
   if x mod 4 = 0 then y = y + 4;
  *)
```
Now try ``exec program_4 [ ("x",Int 4) ]``.  

For example ``lookup "y" (exec program_4 [ ("x",Int 4) ])`` should
evaluate to ``Int 6``.

## Push your work.
Now be sure to commit and push your work.  Check the feedback file
that should be generated each time you push this work.


