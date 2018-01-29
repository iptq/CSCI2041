# Lab 5: Quiz 1 results, OCaml versions, Hwk 2

*CSci 2041: Advanced Programming Principles, Spring 2017*


This lab has three components.

1. return quiz 1, discuss results, ask questions

2. use the locally installed version of OCaml

3. run initial tests

4. remove warnings from your ``hwk_02.ml`` file



## Quiz 1

Your TAs will return your quiz and go over solutions to the problems.
We will not dedicate lecture time to the quiz, so be sure to get your
questions answered during lab.

## OCaml versions.

To make sure we are using the same version of OCaml that you are using
for your work, please ensure that you are using version 4.02.3.

(This check is to be done on your CSE labs account.  If you are using
your own laptop for your work, make sure you tests on your CSE labs
account or verify that the automated feedback is what you expect.)

Type the following to check the version number:
```
ocaml -version
```

If you get something else, try
```
module initrm soft/ocaml
```
and then try the previous version check.

If you still are using something other than version 4.02.3 then ask
your TA to help you fix the problem.


### The automated tests
The automated feedback tests for homework 2 are now turned on.  Make a
change to your solution and push it to trigger the tests.  

Make sure that the tests are what you expect and that either your
solution is passing them all or you understand why it is not.


### No warnings 

In homework 2 the automated tests code that has warnings is not
graded.  You do need to remove all warning from your code.

In doing this, you may need to raise exceptions for data that is not
expected by one of your functions.  Follow the guidelines we used in
lab 3 for doing this.


