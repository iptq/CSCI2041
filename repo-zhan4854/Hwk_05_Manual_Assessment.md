### Hwk_05 score

Below are your scores for Hwk 05

If these scores are different from what you expect, please see the concerned TA to ensure the potential error is fixed.

Run on April 15, 15:12:11 PM.

### Grader : _Charles Harper_ 

### Part 1, Question 1

At the end of this file is the rubric used for grading these problems and an explanation of how to interpret the numbers in the 'Incorrect steps' entry.

+ _3_ /  _5_ : _call by value_ evaluation of ``sum (take 3 (some_squares_from 5 1))``

		Incorrect steps : Need to evaluate each arithmetic operation separately. Final additions carried out in incorrect order. 

		Addition problems : Adding values in incorrect order, place parantheses for correct ordering of addition. 



+ _6_ /  _10_ : _call by name_ evaluation of ``sum (take 3 (some_squares_from 5 1))``

		Incorrect steps : Need to evaluate each arithmetic operation separately. Outermost addition not done in semantic evaluation order. 

		Addition problems : Adding values in incorrect order, place parantheses for correct ordering of addition. 



+ _6_ /  _10_ : _lazy evaluation_ evaluation of ``sum (take 3 (some_squares_from 5 1))``

		Incorrect steps : Incorrect evaluation: line 2. Need to explicitly evaluate binding to v before using it: lines 7,13. Incorrect order of evaluating outermost addition. 

		Addition problems : Adding values in incorrect order, place parantheses for correct ordering of addition. 



### Part 1, Question 2

+ _0_ /  _5_ : _call by value_ evaluation of ``andl (t::f::t::t::[])``

		Incorrect steps :  

		Additional problems :  



+ _5_ /  _5_ : _call by name_ evaluation of ``andl (t::f::t::t::[])``

		Incorrect steps :  

		Additional problems :  



+ _0_ /  _5_ : _call by value_ evaluation of ``andr (t::f::t::t::[])``

		Incorrect steps :  

		Additional problems :  



+ _0_ /  _5_ : _call by name_ evaluation of ``andr (t::f::t::t::[])``

		Incorrect steps :  

		Additional problems :  



+ _0_ / _2_ : _Which evaluation technique is most efficient?_ 


+ _0_ / _3_ : _Why?_ 


### Part 2
 + _ands_ : _5_ / _5_  Full credit only if the function does not continue to traverse the list after encountering the first ``false``

### Part 3


 + _5_ / _5_ : ``squares_again`` works mainly by using the ``map`` function that the students were asked to use.

 + _5_ / _5_ : declarations of ``rough_guess`` and ``precise_calculation`` appear as given in homework description.

 + _5_ / _5_ : ``sqrt_threshold`` works mainly by using ``sqrt_approximations``.

 + _0_ / _5_ : explanation of why ``sqrt_threshold``, at first glance, seems to return more accurate answers than the value of epsilon might suggest.

Total: _40_ / 75 



## Notes on Assessments

To specify the numbers for the incorrect steps in Part 1, start counting expressions in the sequence starting at 0.  If an expression is not the correct one, then that expression number is the step number listed in the 'Incorrect Steps' field.

So if the evaluation from the first (expression 0) to the second expression (expression 1) is incorrect then enter 1 (at least) in the 'incorrect steps' column for that problem.

If there are many that are incorrect and then only the first few may be indicated.

#### Assessment specifications for 5 point parts of Questions 1 and 2:

+ Award all 5 points if just one step is out of order.

+ Deduct 1 point for 2nd step that is out of order.

+ Deduct another point for 4th step out of order.

+ Award 3 points if there is evidence of understanding how call-by-value semantics works but more than 4 mistakes.

+ Award 1 point if at least 5 steps are in the right order.

+ Award 0 points if fewer than 5 are in the right order.

+ No deductions for adding values in incorrect order, but this should be indicated in the 'Additional Comments' field.

#### Assessment specifications for 10 point parts of Questions 1 and 2:

+ Award all 10 points if just one step is out of order.

+ Deduct 2 points for 2nd step that is out of order.

+ Deduct another 2 points for 4th step out of order.

+ Award 6 points if there is evidence of understanding how call-by-value semantics works but more than 4 mistakes.

+ Award 2 points if at least 5 steps are in the right order.

+ Award 0 points if fewer than 5 are in the right order.

+ No deductions for adding values in incorrect order, but indicate this so mistakes are clear.

