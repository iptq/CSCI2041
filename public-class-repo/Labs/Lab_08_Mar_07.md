Lab 8: Improving your OCaml Code
================================
*CSci 2041: Advanced Programming Principles, Spring 2017*

**Due:** Friday, March 10 at 5:00pm. You should be able to complete the 
discussion portion of this lab work during the lab. But you may need additional 
time to complete the work on your functions to make sure that they meet the new 
requirements for writing "good" code. This work needs to be completed by the due
date.

## Introduction
### Goals of this lab
Similar to what you did in Lab 03, 
in this lab you will work with 1 or 2 of your classmates to improve the structure 
and style of your OCaml functions. You will view your classmates solutions to 
Hwk 02 and allow them to view your solution.

This sort of sharing is only allowed, obviously, after the due date.

You will also:

0. Format your code for readability and understanding (see below) .
1. Confirm there are no `;;` in your ocaml file. They are only are used when 
  interacting with the interpreter
2. Remove all clumsy list construction (see Lab 03).
3. Remove all warnings from the file (see Lab 03).

## Prepare the files for Lab 8
Create a new directory named `Lab_08` and copy your `hwk_02.ml` file from 
`Hwk_02` into this new directory. Keep the filename as `hwk_02.ml`.

You will all want to log into the computer on your desk. Then you should log 
into GitHub and open the page with `hwk_02.ml` so that your solution is visible.

## Code Formatting
In this part, you're not going to make any functional improvements to your 
programs, instead you will be enhancing your code's readability and to try to 
help your future partners (and TAs) better understand the logic behind your 
code.

Code formatting is an important part of writing software. While most languages 
don't require any special formatting for the function of your software, 
maintaining a consistent and readable code style can make 
understanding and reasoning about your software much easier for yourself and 
your peers. This is true for OCaml and any other language you find yourself 
working in.

We highly recommend that you attempt to emulate the style that is recommended 
by the OCaml community. 
[The OCaml website has a style guide that can be found here.]
(https://ocaml.org/learn/tutorials/guidelines.html) Nearly any questions about
style and formatting for OCaml can be answered by this guide. We'd like to see 
everyone try to use these styles on future assignments.

The guide has a key point that it makes right at the beginning:

>**Writing programs law:** A program is written once, modified ten times, and 
>read 100 times. So simplify its writing, always keep future modifications in 
>mind, and never jeopardize readability.

This statement is true in any language. Speaking from experience, as the size of
the application you work on increases, this statement gains more and more truth.

For the purpose of this assignment, we'd like you to make a few modifications to
your code to try to improve your partners' ability to read and understand your 
logic. Here are a couple of guidelines for common constructs that can be found 
within most OCaml files (reiterated from the above guide):

`if cond then e1 else e2` statements should be written differently based on the
size of `cond`, `e1`, and `e2`. If they are short, then writing them on the same
line is fine. As the size of the statements grow, place them on their own lines.
Here is an example where both `e1` and `e2` are long:

```OCaml
if cond then
  e1
else
  e2
```

`match` statements should have the clauses aligned with the beginning of the 
construct. If the expression to the right of the pattern matching arrrow is 
too  large, cut the line after the arrow.

```OCaml
match lam with
| Abs (x, body) ->
   1 + size_lambda body
| App (lam1, lam2) ->
   size_lambda lam1 + size_lambda lam2
| Var v -> v
```

**Naming lambda expressions** is something you have encountered in this 
assignment. When the body of lambda expression is long (spanning a few lines
give the function a name by defining it in a let-expression.  Consider this
lambda expression:
```OCaml
List.map
(fun x ->
  blabla
  blabla
  blabla)
l
```

Rewrite it as a let statement and name the function like this:

```OCaml
let f x =
  blabla
  blabla
  blabla in
List.map f l
```

This is much clearer to read, in particular if the name given to the function is
meaningful.

Please make these style changes to the `Lab_08/hwk_02.ml` file, then commit 
and push them to your repository before continuing. You can also continue to 
improve your code as your work with your group. Please try to style your code 
like this on future assignments :) 

## Form Groups
Find 1 or 2 people that you want to work with in lab. Feel free to move around
to sit next to the people you are going to work with. Introduce 
yourselves.

You will all want to log into the computer on your desk. Then you should log 
into GitHub and open the page with `hwk_02.ml` so that your solution is visible.
Please make sure that your formatting changes have been committed and pushed!

As you start to work on your assignment, make sure to include a comment with 
the names of your group members! It is important to give credit for your 
improvements!

## Determine the Questions to Share
As a group, figure out which 3 functions you want to share with each other. You 
will be sharing, discussing, and improving your implementations.

Do not choose the either of the two simplest functions from the assignment 
`length` and `rev`. Treat `is_elem` and `is_elem_by` as one function for the 
purposes of improvement. Make sure to include at least one of `paradelle` or 
`convert_to_non_blank_lines_of_word` as one of the functions you discuss.

## Discuss the First Function
In this part, you will add a new comment above the function that describes the 
changes that you made to the function to address the concerns described below.
You must also specify if you are borrowing code from another student and give 
them proper credit for their work.

Read this entire section before making any more changes to your new `hwk_02.ml`
file.

**Each of you needs to explain your solution of the first function to the other 
1 or 2 members of your group. Take turns doing this.**

After (or during) this, discuss the characteristics of the different 
implementations that you think represent well-written functions. Also discuss 
the characteristics of your functions that you think that you can improve.

In doing so, make sure that the `;;` are removed from the file, there are no
clumsy list construction instances, and that there are no warnings raised. 
Review the Lab 03 description for details on these issues.

Compare your usages of the functions you wrote in Part 1 (`dedup`, `split_by`, 
etc) in Part 2 and 3. Did you effectively use these functions in your 
definitions for `convert_to_non_blank_lines_of_word` and `paradelle`? Did you 
rewrite some of the functionality of `is_elem` inside of your `split_by` 
implementation? Discuss with your group members when and where you used your 
useful functions from Part 1.

## Repeat this Process for the Next 2 Functions
If you run low on time and can only complete two functions that is fine.

## What to Turn In
You need to turn in your new `hwk_02.ml` file in the new `Lab_08` directory via 
GitHub.

**This file must contain your name and the names of those you worked with!**

For each function that your worked on with your group, you must provide a 
detailed comment above it explaining the changes that you made and explain how 
they improve the implementation of your function. You must also indicate where 
the ideas for the changes came from - that is, who in your group contributed 
them.

For the remainder of the functions, use what you learned from these discussions 
with your classmates to make sure that none of them produce any warnings and 
raise exceptions with an appropriate message. Also, try to format them for
readability. 

