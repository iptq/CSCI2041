### Assessment for Lab 08

Below are the automated scores for Lab 08.  If you feel that our scripts are incorrectly assessing your work then please email ``csci2041@.umn.edu`` and explain the problem.  If your code is right you will get credit for it - just maybe not right away.

#### Total score: _59_ / _109_

Run on April 28, 15:10:28 PM.

+ Pass: Change into directory "Lab_08".

+ Pass: Check that file "hwk_02.ml" exists.

+  _5_ / _5_ : Pass: Check that an OCaml file "hwk_02.ml" has no syntax or type errors.

    OCaml file "hwk_02.ml" has no syntax or type errors.



+  _5_ / _5_ : Pass: Check that an OCaml file "hwk_02.ml" has warnings.

    OCaml file "hwk_02.ml" has no warnings.



+ Pass: Make sure you are only using recursion in functions take, drop, read_chars

   



+  _1_ / _1_ : Pass: 
Check that the result of evaluating
   ```
   length []
   ```
   matches the pattern `0`.

   




+  _1_ / _1_ : Pass: 
Check that the result of evaluating
   ```
   length [1;2;3;4;5;6]
   ```
   matches the pattern `6`.

   




+  _1_ / _1_ : Pass: 
Check that the result of evaluating
   ```
   rev []
   ```
   matches the pattern `[ ]`.

   




+  _1_ / _1_ : Pass: 
Check that the result of evaluating
   ```
   rev [1]
   ```
   matches the pattern `[1]`.

   




+  _1_ / _1_ : Pass: 
Check that the result of evaluating
   ```
   rev [1; 2; 3; 4]
   ```
   matches the pattern `[4; 3; 2; 1]`.

   




+  _1_ / _1_ : Pass: 
Check that the result of evaluating
   ```
   is_elem_by (fun x y -> (x+1) = y) 6 [2;3;5;7]
   ```
   matches the pattern `true`.

   




+  _1_ / _1_ : Pass: 
Check that the result of evaluating
   ```
   is_elem_by (fun x y -> (x+1) = y) 0 [2;3;5;7]
   ```
   matches the pattern `false`.

   




+  _1_ / _1_ : Pass: 
Check that the result of evaluating
   ```
   is_elem_by (fun x y -> x < y) 4 [2;3;5;7]
   ```
   matches the pattern `true`.

   




+  _1_ / _1_ : Pass: 
Check that the result of evaluating
   ```
   is_elem_by (fun x y -> x < y) 0 [2;3;5;7]
   ```
   matches the pattern `false`.

   




+  _1_ / _1_ : Pass: 
Check that the result of evaluating
   ```
   is_elem 3 []
   ```
   matches the pattern `false`.

   




+  _1_ / _1_ : Pass: 
Check that the result of evaluating
   ```
   is_elem 3 [1; 2; 3]
   ```
   matches the pattern `true`.

   




+  _1_ / _1_ : Pass: 
Check that the result of evaluating
   ```
   is_elem 4 [1; 2; 3]
   ```
   matches the pattern `false`.

   




+  _1_ / _1_ : Pass: 
Check that the result of evaluating
   ```
   List.sort (fun x y -> if x < y then -1 else 1) (dedup [1;1;4;5;2;3;2])
   ```
   matches the pattern `[1; 2; 3; 4; 5]`.

   




+  _1_ / _1_ : Pass: 
Check that the result of evaluating
   ```
   List.sort (fun x y -> if x < y then -1 else 1) (dedup [[13; 1]; [13; 1]; [1; 2]; [10; 5]])
   ```
   matches the pattern `[[1; 2]; [10; 5]; [13; 1]]`.

   




+  _1_ / _1_ : Pass: 
Check that the result of evaluating
   ```
   dedup []
   ```
   matches the pattern `[ ]`.

   




+  _1_ / _1_ : Pass: 
Check that the result of evaluating
   ```
   List.sort (fun x y -> if x < y then -1 else 1) (dedup [4;5;2;3])
   ```
   matches the pattern `[2; 3; 4; 5]`.

   




+  _1_ / _1_ : Pass: 
Check that the result of evaluating
   ```
   split_by (=) ['a';'b';'c';'d'] ['c']
   ```
   matches the pattern `[['a'; 'b']; ['d']]`.

   




+  _1_ / _1_ : Pass: 
Check that the result of evaluating
   ```
   split_by (>) ['a';'b';'c';'d'] ['c']
   ```
   matches the pattern `[[]; []; ['c'; 'd']]`.

   




+  _1_ / _1_ : Pass: 
Check that the result of evaluating
   ```
   split_by (=) ['a';'b';'c';'d'] []
   ```
   matches the pattern `[['a'; 'b'; 'c'; 'd']]`.

   




+  _1_ / _1_ : Pass: 
Check that the result of evaluating
   ```
   split_by (=) [] ['x']
   ```
   matches the pattern `[[ ]]`.

   




+  _1_ / _1_ : Pass: 
Check that the result of evaluating
   ```
   split_by (=) [] []
   ```
   matches the pattern `[[ ]]`.

   




+  _1_ / _1_ : Pass: 
Check that the result of evaluating
   ```
   List.map (List.map (fun y -> List.map Char.lowercase y)) (convert_to_non_blank_lines_of_words ['W'; 'h'; 'e'; ','; 'a'; ' '; 'b'])
   ```
   matches the pattern `[[['w'; 'h'; 'e']; ['a']; ['b']]]`.

   




+  _1_ / _1_ : Pass: 
Check that the result of evaluating
   ```
   List.map (List.map (fun y -> List.map Char.lowercase y)) (convert_to_non_blank_lines_of_words ['W'; 'h'; 'e'; ','; 'a'; '
'; 'b'])
   ```
   matches the pattern `[[['w'; 'h'; 'e']; ['a']]; [['b']]]`.

   




+  _1_ / _1_ : Pass: 
Check that the result of evaluating
   ```
   List.map (List.map (fun y -> List.map Char.lowercase y)) (convert_to_non_blank_lines_of_words ['W'; 'h'; 'e'; ' '; ','; 'a'; '-'; 'b'])
   ```
   matches the pattern `[[['w'; 'h'; 'e']; ['a']; ['b']]]`.

   




+  _1_ / _1_ : Pass: 
Check that the result of evaluating
   ```
   paradelle "../../../../public-class-repo/Homework/Hwk_02/not_a_paradelle_emma_1.txt"
   ```
   matches the pattern `IncorrectLastStanza`.

   




+  _1_ / _1_ : Pass: 
Check that the result of evaluating
   ```
   paradelle "../../../../public-class-repo/Homework/Hwk_02/not_a_paradelle_empty_file.txt"
   ```
   matches the pattern `IncorrectNumLines 0`.

   




+  _1_ / _1_ : Pass: 
Check that the result of evaluating
   ```
   paradelle "../../../../public-class-repo/Homework/Hwk_02/not_a_paradelle_susan_1.txt"
   ```
   matches the pattern `IncorrectLines [(1, 2); (11, 12); (17, 18)]`.

   




+  _1_ / _1_ : Pass: 
Check that the result of evaluating
   ```
   paradelle "../../../../public-class-repo/Homework/Hwk_02/not_a_paradelle_susan_2.txt"
   ```
   matches the pattern `IncorrectLines [(11, 12); (17, 18)]`.

   




+  _1_ / _1_ : Pass: 
Check that the result of evaluating
   ```
   paradelle "../../../../public-class-repo/Homework/Hwk_02/not_a_paradelle_susan_3.txt"
   ```
   matches the pattern `IncorrectLines [(1, 2); (11, 12); (17, 18)]`.

   




+  _1_ / _1_ : Pass: 
Check that the result of evaluating
   ```
   paradelle "../../../../public-class-repo/Homework/Hwk_02/not_a_paradelle_wrong_line_count.txt"
   ```
   matches the pattern `IncorrectNumLines 9`.

   




+  _1_ / _1_ : Pass: 
Check that the result of evaluating
   ```
   paradelle "../../../../public-class-repo/Homework/Hwk_02/paradelle_emma_1.txt"
   ```
   matches the pattern `OK`.

   




+  _1_ / _1_ : Pass: 
Check that the result of evaluating
   ```
   paradelle "../../../../public-class-repo/Homework/Hwk_02/paradelle_susan_1.txt"
   ```
   matches the pattern `OK`.

   




+  _1_ / _1_ : Pass: 
Check that the result of evaluating
   ```
   paradelle "../../../../public-class-repo/Homework/Hwk_02/paradelle_susan_2.txt"
   ```
   matches the pattern `OK`.

   




+  _1_ / _1_ : Pass: 
Check that the result of evaluating
   ```
   paradelle "../../../../public-class-repo/Homework/Hwk_02/abc.txt"
   ```
   matches the pattern `FileNotFound "../../../../public-class-repo/Homework/Hwk_02/abc.txt"`.

   




+  _5_ / _5_ : Pass: Check if the solution contains no semicolons in the .ml file - 5 points [only 0 or 5 (all or none)]

    

+  _5_ / _5_ : Pass: Check for clumsy list construction - 5 points [only 0 or 5 (all or none)]

    

+  _5_ / _5_ : Pass: No grotesque formatting - Specify lines if there is an issue[all or none]

    

+  _0_ / _10_ : Pass: IMPROVEMENT 1: Code improvements were made and they match the comment describing them.

    What was improved? Not mentioned. 

+  _0_ / _10_ : Pass: IMPROVEMENT 1: Does the solution provide a good desription of the improvement? - half credit for brief descriptions 

    

+  _0_ / _5_ : Pass: IMPROVEMENT 1: Proper attribution of ideas?

    

+  _0_ / _10_ : Pass: IMPROVEMENT 2:  Code improvements were made and they match the comment describing them.

    

+  _0_ / _10_ : Pass: IMPROVEMENT 2: Does the solution provide a good desription of the improvement?  - half credit for brief descriptions 

    

+  _0_ / _5_ : Pass: IMPROVEMENT 2: Proper attribution of ideas?

    

#### Total score: _59_ / _109_

