### Feedback for Lab 03

Run on January 31, 08:54:26 AM.

+ Pass: Change into directory "Lab_03".

+ Pass: Check that file "hwk_01.ml" exists.

+ Pass: Check that an OCaml file "hwk_01.ml" has no syntax or type errors.

    OCaml file "hwk_01.ml" has no syntax or type errors.



+ Pass: Check that an OCaml file "hwk_01.ml" has warnings.

    OCaml file "hwk_01.ml" has no warnings.



+ Pass: Check that the result of evaluating `even 4` matches the pattern `true`.

   



+ Pass: Check that the result of evaluating `even 5` matches the pattern `false`.

   



+ Pass: Check that the result of evaluating `euclid 6 9` matches the pattern `3`.

   



+ Pass: Check that the result of evaluating `euclid 5 9` matches the pattern `1`.

   



+ Pass: Check that the result of evaluating `frac_add (1,2) (1,3)` matches the pattern `(5,6)`.

   



+ Pass: Check that the result of evaluating `frac_add (1,4) (1,4)` matches the pattern `(8,16)`.

   



+ Pass: Check that the result of evaluating `frac_simplify (8,16)` matches the pattern `(1,2)`.

   



+ Pass: Check that the result of evaluating `frac_simplify (4,9)` matches the pattern `(4,9)`.

   



+ Pass: Check that the result of evaluating `frac_simplify (3,9)` matches the pattern `(1,3)`.

   



+ Pass: Check that the result of evaluating `fst (square_approx 9.0 0.001)` matches the pattern `3.`.

   



+ Pass: Check that the result of evaluating `snd (square_approx 9.0 0.001)` matches the pattern `3.0`.

   



+ Pass: Check that the result of evaluating `fst (square_approx 81.0 0.1)` matches the pattern `8.9`.

   



+ Pass: Check that the result of evaluating `snd (square_approx 81.0 0.1)` matches the pattern `9.0`.

   



+ Pass: Check that the result of evaluating `max_list [1; 2; 5; 3; 2]` matches the pattern `5`.

   



+ Pass: Check that the result of evaluating `max_list [-1; -2; -5; -3; -2]` matches the pattern `-1`.

   



+ Pass: Check that the result of evaluating `drop 3 [1; 2; 3; 4; 5]` matches the pattern `[4; 5]`.

   



+ Pass: Check that the result of evaluating `drop 5 ["A"; "B"; "C"]` matches the pattern `[ ]`.

   



+ Pass: Check that the result of evaluating `drop 0 [1]` matches the pattern `[1]`.

   



+ Pass: Check that the result of evaluating `rev [1; 2; 3; 4; 5]` matches the pattern `[5; 4; 3; 2; 1]`.

   



+ Pass: Check that the result of evaluating `rev []` matches the pattern `[]`.

   



+ Pass: Check that the result of evaluating `perimeter [ (1.0, 1.0); (1.0, 3.0); (4.0, 4.0); (7.0, 3.0); (7.0, 1.0) ]` matches the pattern `16.3`.

   



+ Pass: Check that the result of evaluating `is_matrix [ [1;2;3]; [4;5;6] ]` matches the pattern `true`.

   



+ Pass: Check that the result of evaluating `is_matrix [ [1;2;3]; [4;6] ]` matches the pattern `false`.

   



+ Pass: Check that the result of evaluating `is_matrix [ [1] ]` matches the pattern `true`.

   



+ Pass: Check that the result of evaluating `matrix_scalar_add [ [1; 2; 3]; [4; 5; 6] ] 5` matches the pattern `[ [6; 7; 8]; [9; 10; 11] ]`.

   



#### Bonus Round!!

+ Pass: Check that the result of evaluating `matrix_transpose [ [1; 2; 3]; [4; 5; 6] ]` matches the pattern `[ [1; 4]; [2; 5]; [3; 6] ]`.

   



+ Pass: Check that the result of evaluating `matrix_multiply  [ [1; 2; 3]; [4; 5; 6] ] [ [1; 4]; [2; 5]; [3; 6] ]` matches the pattern ` [ [14; 32]; [32; 77]]`.

   



