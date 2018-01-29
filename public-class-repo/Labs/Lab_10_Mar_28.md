# Lab 10: Lazy Evaluation

*CSci 2041: Advanced Programming Principles, Spring 2017*

**Due:** Friday, March 31 at 5:00pm. You should be able to complete
this work during lab.  

## Lab goals
Doing this lab should get you set up to work on the programming
portion of Homework 05 as some of the programming tasks in this lab
are similar to those in the homework.

## Getting started.
Copy the file ``streams.ml`` from the public class repository into a
new directory named ``Lab_10``.  Name the copy of this file
``lab_10.ml``.

Add the following functions to the end of that file.  But you should
clearly mark the parts of this file that you did not write and
attribute them to their author (your instructor) and then indicate
where your work starts in the file by adding you name and a comment to
this effect.

Read over the contents of this file and test out the various functions
by running them so that you understand how these streams work.

## Streams
Below you are asked to define a series of values (some are functional
values) that lead to the definition of ``str_105_nats`` of type
``string`` so that it prints out as seen in the following interaction
in utop:
```
utop # print_endline str_105_nats ;;
1, 2, 3, 4, 5, 6, 7, 8, 9, 10
11, 12, 13, 14, 15, 16, 17, 18, 19, 20
21, 22, 23, 24, 25, 26, 27, 28, 29, 30
31, 32, 33, 34, 35, 36, 37, 38, 39, 40
41, 42, 43, 44, 45, 46, 47, 48, 49, 50
51, 52, 53, 54, 55, 56, 57, 58, 59, 60
61, 62, 63, 64, 65, 66, 67, 68, 69, 70
71, 72, 73, 74, 75, 76, 77, 78, 79, 80
81, 82, 83, 84, 85, 86, 87, 88, 89, 90
91, 92, 93, 94, 95, 96, 97, 98, 99, 100
101, 102, 103, 104, 105
- : unit = ()
```

#### natural numbers as strings

First define a function ``str_from`` of type ``int -> string
stream``.  This function has the same behavior as ``from`` defined in
``streams.ml`` except that the numbers are converted into strings.

For example, ``take 5 (str_from 10)`` should evaluate to the string
list ``["10"; "11"; "12"; "13"; "14"]``.

Next, define ``str_nats`` of type ``string stream``.  It corresponds
to ``nats``.

The expression ``take 5 str_nats`` should evaluat to the string list
``["1"; "2"; "3"; "4"; "5"]``.

#### a stream of separator strings
In the output above, you'll notice that some numbers are separated by
a comma and a space and that others are separated by a newline.  You
now need to define 
the stream of strings that are these appropriate separator values.

Write a function ``separators`` with the type
``int -> string -> string stream``.  

Let's call the first argument ``n`` and the second one ``sep``.

This function returns a stream of strings in which the first ``n``
elements of the stream are the string ``sep``, and the next one is
that string containing a single new line character, that is ("\n").
Then there are ``n`` more copies of ``sep`` before another string with
the newline character.  This pattern repeats indefinitely.

For example, the expression
``take 10 (separators 2 "$$")`` will evaluate to the following string
list
```
["$$"; "$$"; "\n"; "$$"; "$$"; "\n"; "$$"; "$$"; "\n"; "$$"] 
```

Keep in mind that the second input to ``take`` is a steam, not a
list.  Only its output is a list.

When you look at the result of the test for this function in your
Feedback file on GitHub please note that the newline characters do not
appear in the sample output that your expression is supposed to match.
That output displays the values and the embedded newline characters
just create new lines.  But Markdown does not treat newlines as
paragraph brakes so the strings just appear mashed together in the
output.  Just make sure your output of this function looks correct.


Next define the value ``ten_per_line`` of type ``string stream`` that
can be used in the following functions to help create the output of
``str_105_nats`` seen above.

#### alternate
Next, write the function ``alternate`` that has the type
```
'a stream -> 'a stream -> 'a stream

```
and combines two streams into one by alternating their values.  The 
result of evaluating the expression ``take 10 (alternate nats (from
100))`` is the int list
```
[1; 100; 2; 101; 3; 102; 4; 103; 5; 104]
```

#### the string with 105 natural numbers
Finally, define ``str_105_nats`` that as type ``string`` and whose
value can be seen above.

To this you'll need to combine the functions and values you've defined
above, perhaps some from ``streams.ml``, and also either
``List.fold_left`` or ``List.fold_right`` to fold up some list of
strings (that originally came from ``str_nats`` and out of a call to
``separators``) into the single string seen above.


Note that the newline characters don't appear in the output in the
Feedback file on GitHub for the test for ``str_105_nats`` either.
Just make sure that your output looks like the example above
and that there are now extra spaces except as part of the
"comma and space" separator value passed into your function
``separators``.

