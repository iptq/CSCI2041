### Assessment for Homework 01

Below are the automated scores for Homework 1.  If you feel that our scripts are incorrectly assessing your work then please email ``csci2041@cs.umn.edu`` and explain the problem.  If your code is right you will get credit for it - just maybe not right away.

**Contains fix for rounding error!** Please email ``csci2041@cs.umn.edu`` if this reduces your score. Please note that this was ran on what was in your directory shortly after the due date on January 30th, 5PM.

#### Total score: _100_ / _100_

Run on February 10, 19:27:45 PM.

*Tests were ran on code present in this repository at January 30, 19:00:00 PM.*

+ Pass: Change into directory "Hwk_01".

+ Pass: Check that file "hwk_01.ml" exists.

+  _5_ / _5_ : Pass: Check that an OCaml file "hwk_01.ml" has no syntax or type errors.

    OCaml file "hwk_01.ml" has no syntax or type errors.



+  _1_ / _1_ : Pass: Check that the result of evaluating `even 4` matches the pattern `true`.

   



+  _1_ / _1_ : Pass: Check that the result of evaluating `even 5` matches the pattern `false`.

   



+  _2_ / _2_ : Pass: Check that the result of evaluating `euclid 6 9` matches the pattern `3`.

   



+  _2_ / _2_ : Pass: Check that the result of evaluating `euclid 5 9` matches the pattern `1`.

   



+  _2_ / _2_ : Pass: Check that the result of evaluating `frac_add (1,2) (1,3)` matches the pattern `(5,6)`.

   



+  _2_ / _2_ : Pass: Check that the result of evaluating `frac_add (1,4) (1,4)` matches the pattern `(8,16)`.

   



+  _4_ / _4_ : Pass: Check that the result of evaluating `frac_simplify (8,16)` matches the pattern `(1,2)`.

   



+  _4_ / _4_ : Pass: Check that the result of evaluating `frac_simplify (4,9)` matches the pattern `(4,9)`.

   



+  _4_ / _4_ : Pass: Check that the result of evaluating `frac_simplify (3,9)` matches the pattern `(1,3)`.

   



+  _3_ / _3_ : Pass: Check that the result of evaluating `fst (square_approx 9.2 0.001)` is within 0.1 of `3.0`.

   



+  _3_ / _3_ : Pass: Check that the result of evaluating `snd (square_approx 9.2 0.001)` is within 0.1 of `3.0`.

   



+  _3_ / _3_ : Pass: Check that the result of evaluating `fst (square_approx 81.2 0.1)` is within 0.2 of `9.0`.

   



+  _3_ / _3_ : Pass: Check that the result of evaluating `snd (square_approx 81.2 0.1)` is within 0.2 of `9.0`.

   



+  _4_ / _4_ : Pass: Check that the result of evaluating `max_list [1; 2; 5; 3; 2]` matches the pattern `5`.

   



+  _4_ / _4_ : Pass: Check that the result of evaluating `max_list [-1; -2; -5; -3; -2]` matches the pattern `-1`.

   



+  _3_ / _3_ : Pass: Check that the result of evaluating `drop 3 [1; 2; 3; 4; 5]` matches the pattern `[4; 5]`.

   



+  _3_ / _3_ : Pass: Check that the result of evaluating `drop 5 ["A"; "B"; "C"]` matches the pattern `[ ]`.

   



+  _3_ / _3_ : Pass: Check that the result of evaluating `drop 0 [1]` matches the pattern `[1]`.

   



+  _4_ / _4_ : Pass: Check that the result of evaluating `rev [1; 2; 3; 4; 5]` matches the pattern `[5; 4; 3; 2; 1]`.

   



+  _4_ / _4_ : Pass: Check that the result of evaluating `rev []` matches the pattern `[]`.

   



+  _6_ / _6_ : Pass: Check that the result of evaluating `perimeter [ (1.0, 1.0); (1.0, 2.0); (2.0, 2.0); (2.0, 1.0) ]` matches the pattern `4.`.

   



+  _6_ / _6_ : Pass: Check that the result of evaluating `perimeter [ (1.0, 1.0); (1.0, 3.0); (4.0, 4.0); (7.0, 3.0); (7.0, 1.0) ]` matches the pattern `16.3`.

   



+  _3_ / _3_ : Pass: Check that the result of evaluating `is_matrix [ [1;2;3]; [4;5;6] ]` matches the pattern `true`.

   



+  _3_ / _3_ : Pass: Check that the result of evaluating `is_matrix [ [1;2;3]; [4;6] ]` matches the pattern `false`.

   



+  _3_ / _3_ : Pass: Check that the result of evaluating `is_matrix [ [1] ]` matches the pattern `true`.

   



+  _5_ / _5_ : Pass: Check that the result of evaluating `is_matrix [ [1; 2; 3]; [4; 5; 6]; [10; 11; 12] ]` matches the pattern `true`.

   



+  _5_ / _5_ : Pass: Check that the result of evaluating `matrix_scalar_add [ [1; 2; 3]; [4; 5; 6] ] 5` matches the pattern `[ [6; 7; 8]; [9; 10; 11] ]`.

   



+  _5_ / _5_ : Pass: Check that the result of evaluating `matrix_scalar_add [ [1; 2; 3]; [4; 5; 6]; [10; 11; 12] ] 5` matches the pattern `[ [6; 7; 8]; [9; 10; 11]; [15; 16; 17] ]`.

   



#### Bonus Round!!

+ Pass: Check that the result of evaluating `matrix_transpose [ [1; 2; 3]; [4; 5; 6] ]` matches the pattern `[ [1; 4]; [2; 5]; [3; 6] ]`.

   



+ Pass: Check that the result of evaluating `matrix_transpose [ [1; 2; 3]; [4; 5; 6]; [10; 11; 12] ]` matches the pattern `[ [1; 4; 10]; [2; 5; 11]; [3; 6; 12] ]`.

   



+ Pass: Check that the result of evaluating `matrix_multiply  [ [1; 2; 3]; [4; 5; 6] ] [ [1; 4]; [2; 5]; [3; 6] ]` matches the pattern ` [ [14; 32]; [32; 77]]`.

   



#### Total score: _100_ / _100_

