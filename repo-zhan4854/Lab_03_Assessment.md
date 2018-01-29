### Assessment for Lab 03

#### Total score: _109_ / _194_

Run on February 10, 16:54:06 PM.

+ Pass: Change into directory "Lab_03".

+ Pass: Check that file "hwk_01.ml" exists.

+  _2_ / _2_ : Pass: Check that an OCaml file "hwk_01.ml" has no syntax or type errors.

    OCaml file "hwk_01.ml" has no syntax or type errors.



+  _3_ / _3_ : Pass: Check that an OCaml file "hwk_01.ml" has warnings.

    OCaml file "hwk_01.ml" has no warnings.



+  _1_ / _1_ : Pass: Check that the result of evaluating `even 4` matches the pattern `true`.

   



+  _1_ / _1_ : Pass: Check that the result of evaluating `even 5` matches the pattern `false`.

   



+  _2_ / _2_ : Pass: Check that the result of evaluating `euclid 6 9` matches the pattern `3`.

   



+  _2_ / _2_ : Pass: Check that the result of evaluating `euclid 5 9` matches the pattern `1`.

   



+  _2_ / _2_ : Pass: Check that the result of evaluating `frac_add (1,2) (1,3)` matches the pattern `(5,6)`.

   



+  _2_ / _2_ : Pass: Check that the result of evaluating `frac_add (1,4) (1,4)` matches the pattern `(8,16)`.

   



+  _4_ / _4_ : Pass: Check that the result of evaluating `frac_simplify (8,16)` matches the pattern `(1,2)`.

   



+  _4_ / _4_ : Pass: Check that the result of evaluating `frac_simplify (4,9)` matches the pattern `(4,9)`.

   



+  _4_ / _4_ : Pass: Check that the result of evaluating `frac_simplify (3,9)` matches the pattern `(1,3)`.

   



+  _3_ / _3_ : Pass: Check that the result of evaluating `fst (square_approx 9.0 0.001)` matches the pattern `3.`.

   



+  _3_ / _3_ : Pass: Check that the result of evaluating `snd (square_approx 9.0 0.001)` matches the pattern `3.0`.

   



+  _3_ / _3_ : Pass: Check that the result of evaluating `fst (square_approx 81.0 0.1)` matches the pattern `8.9`.

   



+  _3_ / _3_ : Pass: Check that the result of evaluating `snd (square_approx 81.0 0.1)` matches the pattern `9.0`.

   



+  _4_ / _4_ : Pass: Check that the result of evaluating `max_list [1; 2; 5; 3; 2]` matches the pattern `5`.

   



+  _4_ / _4_ : Pass: Check that the result of evaluating `max_list [-1; -2; -5; -3; -2]` matches the pattern `-1`.

   



+  _3_ / _3_ : Pass: Check that the result of evaluating `drop 3 [1; 2; 3; 4; 5]` matches the pattern `[4; 5]`.

   



+  _3_ / _3_ : Pass: Check that the result of evaluating `drop 5 ["A"; "B"; "C"]` matches the pattern `[ ]`.

   



+  _3_ / _3_ : Pass: Check that the result of evaluating `drop 0 [1]` matches the pattern `[1]`.

   



+  _4_ / _4_ : Pass: Check that the result of evaluating `rev [1; 2; 3; 4; 5]` matches the pattern `[5; 4; 3; 2; 1]`.

   



+  _4_ / _4_ : Pass: Check that the result of evaluating `rev []` matches the pattern `[]`.

   



+  _6_ / _6_ : Pass: Check that the result of evaluating `perimeter [ (1.0, 1.0); (1.0, 3.0); (4.0, 4.0); (7.0, 3.0); (7.0, 1.0) ]` matches the pattern `16.3`.

   



+  _3_ / _3_ : Pass: Check that the result of evaluating `is_matrix [ [1;2;3]; [4;5;6] ]` matches the pattern `true`.

   



+  _3_ / _3_ : Pass: Check that the result of evaluating `is_matrix [ [1;2;3]; [4;6] ]` matches the pattern `false`.

   



+  _3_ / _3_ : Pass: Check that the result of evaluating `is_matrix [ [1] ]` matches the pattern `true`.

   



+  _5_ / _5_ : Pass: Check that the result of evaluating `matrix_scalar_add [ [1; 2; 3]; [4; 5; 6] ] 5` matches the pattern `[ [6; 7; 8]; [9; 10; 11] ]`.

   



#### Bonus Round!!

+  _5_ / _5_ : Pass: Check that the result of evaluating `matrix_transpose [ [1; 2; 3]; [4; 5; 6] ]` matches the pattern `[ [1; 4]; [2; 5]; [3; 6] ]`.

   



+  _5_ / _5_ : Pass: Check that the result of evaluating `matrix_multiply  [ [1; 2; 3]; [4; 5; 6] ] [ [1; 4]; [2; 5]; [3; 6] ]` matches the pattern ` [ [14; 32]; [32; 77]]`.

   



+  _0_ / _5_ : Pass: Check if the solution contains no semicolons in the .ml file - 5 points [only 0 or 5 (all or none)]

    

+  _5_ / _5_ : Pass: Check for clumsy list construction - 5 points [only 0 or 5 (all or none)]

    

+  _10_ / _10_ : Pass: Check if there are any inappropriate raise constructs in any functions - 10 points [5 points lost for first offense, another one loses all 10]

    

+  _0_ / _25_ : Pass: IMPROVEMENT 1: Is there any improvement in the code? - 25 
 - 'good' - Code is nice, no really bad stuff  - 25 
 - 'poor' attempt - obviously bad things  - 10 
 - 'no attempt' - 0 points if not description  - 0 


    

+  _0_ / _10_ : Pass: IMPROVEMENT 1: Does the solution provide a good desription of the improvement? - 10 
 - description matches the new code - what they say they did is present - 10 
 - exceedingly brief or inaccurate description - 5 
 - no comment - 0 


    

+  _0_ / _5_ : Pass: IMPROVEMENT 1: Proper attribution of ideas?

    

+  _0_ / _25_ : Pass: IMPROVEMENT 2: Is there any improvement in the code? - 25 
 - 'good' - Code is nice, no really bad stuff  - 25 
 - 'poor' attempt - obviously bad things  - 10 
 - 'no attempt' - 0 points if not description  - 0 


    

+  _0_ / _10_ : Pass: IMPROVEMENT 2: Does the solution provide a good desription of the improvement? - 10 
 - description matches the new code - what they say they did is present - 10 
 - exceedingly brief or inaccurate description - 5 
 - no comment - 0 


    

+  _0_ / _5_ : Pass: IMPROVEMENT 2: Proper attribution of ideas?

    

#### Total score: _109_ / _194_

