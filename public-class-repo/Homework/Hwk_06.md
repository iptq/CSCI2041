# Homework 6: Search as a Programming Technique

*CSci 2041: Advanced Programming Principles, Spring 2017*

**Due:**  11:59pm Monday, April 17


## Introduction

You will solve two searching problems in this assignment.  The first
is a tautology checker, the second is a maze runner.

## Part 1: Tautology Checker 

### Getting Started

Your task for this homework is to write tautology checker for logical
formulas.  You should be familiar with the code we wrote for the
``subsetsum`` problem in lecture before starting this assignment.  *If
you don't understand that code, then the work below will be very
difficult.*


Below are a few type definitions and functions that you will want to
use.  As we've done before, place these in a file named ``tautology.ml``
in a directory named ``Hwk_06``.  This ``Hwk_06`` directory should be
in your individual repository.


Our formulas are represented by the following OCaml type:
```
type formula = And of formula * formula
	     | Or  of formula * formula
	     | Not of formula 
	     | Prop of string
	     | True
	     | False
```

You will implement the tautology checker in the style that uses
exceptions, specifically the style that raises an exception to
indicate that the search process should continue.

Thus we will use the following exception for that.
```
exception KeepLooking
```

Our tautology checker will search for substitutions for the
propositions in the formula for which the formula will evaluate to
``false``.  The substitutions are similar in structure to the
environments that we had in homework 4.

We'll introduce a name for them, ``subst``, with the following type
definition.
```
type subst = (string * bool) list
```


Here is a function for converting substitutions to
strings.  We'll use this in printing our results.
```
let show_list show l =
  let rec sl l =
    match l with 
    | [] -> ""
    | [x] -> show x
    | x::xs -> show x ^ "; " ^ sl xs
  in "[ " ^ sl l ^ " ]"

let show_string_bool_pair (s,b) =
  "(\"" ^ s ^ "\"," ^ (if b then "true" else "false") ^ ")"

let show_subst = show_list show_string_bool_pair
```

You might also find these helpful
```
let is_elem v l =
  List.fold_right (fun x in_rest -> if x = v then true else in_rest) l false

let rec explode = function
  | "" -> []
  | s  -> String.get s 0 :: explode (String.sub s 1 ((String.length s) - 1))

let dedup lst =
  let f elem to_keep =
    if is_elem elem to_keep then to_keep else elem::to_keep
  in List.fold_right f lst []
```


### Formula evaluation

In the process of searching for substitutions for a formula that
indicate that the formula is not a tautology, we will want to evaluate
a formula for a given substitution.

This is very much like the expression evaluators that we created for
homework 4, except now the environment (or substitution as we've
called it here) is a part of the input of the evaluation process.

This is because our formulas have variables, here called propositions,
but they don't have let-clauses that would introduce binding into an
environment.  So that complete environment/substitution must be passed
in.

Write a function named ``eval`` with the type
``formula -> subst -> bool`` that evaluates the input formula using
the input substitution to return a value of ``true`` or ``false``.

In case a proposition occurs in the formula that does not appear in
the substitution, just raise an exception.  The tests run on your code
will only provide proper substitutions (no missing binding) to
evaluations. 

For example:
```
eval (And ( Prop "P", Prop "Q")) [("P",true); ("Q",false)]
```
will evaluate to ``false``
and
```
eval (And ( Prop "P", Prop "Q")) [("P",true); ("Q",true)]
```
will evaluate to ``true``.


### "Freevars" for formulas

The search space for our tautology checker is the set of substitutions
for the propositions in a formula.  Thus we must determine what
variables are used in a formula.

This is reminiscent of the ``freevars`` function we wrote for
expressions in homework 4.

Write a function ``freevars`` with the type ``formula -> string list``
that returns the names of all the propositions in the formula.  Be
sure to remove duplicates since when we create substitutions based on this
list we cannot have more than one binding for the same propositional
variable.

Here are a few evaluations.
```
freevars (And ( Prop "P", Prop "Q"))
``` 
evaluates to ``["P"; "Q"]`` and 
```
freevars (And ( Prop "Q", Prop "P"))
```
evaluates to ``["Q"; "P"]``.  But order doesn't matter.

Here are a few examples of possible tests that may be run on your
solution:
```
List.exists ( (=) "P" ) (freevars (And ( Prop "P", Prop "Q"))) = true

List.length (freevars (And ( Prop "P", Or (Prop "Q", Prop "P")))) = 2
```


### Tautology Checker

Given the types and functions defined above we can now get to writing
our tautology checker.

The function will be named ``is_tautology`` and will have the type
``formula -> (subst -> subst option) -> subst option``.

The first argument is, not surprisingly, the formula we wish to check.

The second argument is a function similar to the ``process_solution``
functions we used in the implementations of ``subsetsum``.  This
function is called when the search process finds a substitution for
which the formula evaluates to ``false``.  The function gets this
substitution as input and can decide to accept it (perhaps by
interacting with the user) and in that case returns that substitution
in a ``Some`` value.

If the function does not accept the solution, it should raise the
``KeepLooking`` exception.

We could then use ``is_tautology`` in some interesting ways, just 
like we did for ``subsetsum`` in lecture.  First,
we could define the following to return the first substitution that is
found: 
```
let is_tautology_first f = is_tautology f (fun s -> Some s)
```

Second, we could define the following to print out all substitutions
and always raise the ``KeepLooking`` exception.  It will then print
all substitutions that make the formula evaluate to ``false`` and the
finally return ``None`` as the value of the call to
``is_tautology_print_all``. 
```
let is_tautology_print_all f =
  is_tautology 
    f
    (fun s -> print_endline (show_subst s); 
	      raise KeepLooking)
```

For the formula
```
Or (Prop "P", Not (Prop "P"))
```
your tautology checker should find that it is a tautology and never
generate a substitution.

For the formula
```
Or (Prop "P", Prop "Q")
```
your tautology checker should find that it is not a tautology and
generate (among others) the substitution
```
[ ("Q",false); ("P",false) ]
```
or
```
[ ("P",false); ("Q",false) ]
```
since the order in which binding appear in the substitution does not
matter.

For the formula 
```
And ( Prop "P", Prop "Q")
```
your tautology checker should find that it is not a tautology and
generate 3 substitutions (if they are all demanded) that make the
formula false. 

Try 
```
is_tautology_print_all (And (Prop "P", Prop "Q"))
```
and make sure you see the proper 3 substitutions.



Your functions will also be checked that they conform to the proper
style and use exceptions as described in class to implement
backtracking search.



## Part 2: Maze Runner

Consider the maze shown below, where "S" marks the start position and
"G" marks the two goal positions.

<img src="http://www-users.cs.umn.edu/~evw/Maze.png" alt="Maze" width ="300px"/>

Your task is to write a function ``maze`` that returns the first
path from an "S" position to one of the "G" positions that is found.

To keep this computation from happening when we load the file into
utop, the function should take ``()`` the unit value as input and
return a list of pairs on integer representing a path, wrapped up in
an ``option`` type.

This function will have some things in common with the
wolf-goat-cabbage problem that we solved in class, so make sure you
understand that before attempting this one.


It is suggested that you write a function ``maze_moves`` that takes a
position as input with the type ``int * int`` and then returns a list
of positions, with type ``(int * int) list`` that are all the
positions that could be moved to, while respecting the boundaries and
lines in the maze.  For example, one cannot move from position
``(3,1)`` to position ``(4,1)``.   

You can implement this with a rather large ``match`` expression that
just hard-codes the moves seen in the image above.


For example, your solution may execute the search in an order so that
``maze ()`` evaluates to
```
Some [ (2,3); (1,3); (1,2); (2,2); (3,2); (3,3); (3,4); (4,4); (4,5); (3,5) ]
```
Or, your ``maze`` function might instead return the path
```
Some [ (2,3); (1,3); (1,2); (2,2); (3,2); (3,3); (4,3); (5,3); (5,2); (5,1) ]
```

Thus, the type of ``maze`` must be
```
unit -> (int * int) list option
```

Your maze runner solution should use the same ``KeepLooking``
exception to indicate when a deadend in the search has been reached or
when some other reason exists to keep looking for solutions.

Your functions will also be checked that they conform to the proper
style and use exceptions as described in class to implement
backtracking search.



