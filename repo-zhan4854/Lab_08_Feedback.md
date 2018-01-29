### Feedback for Lab 08

Run on March 08, 14:14:18 PM.

+ Pass: Change into directory "Lab_08".

+ Pass: Check that file "hwk_02.ml" exists.

+ Pass: Check that an OCaml file "hwk_02.ml" has no syntax or type errors.

    OCaml file "hwk_02.ml" has no syntax or type errors.



+ Pass: Make sure you are only using recursion in functions take, drop, read_chars

   



+ Pass: Check that the result of evaluating `length []` matches the pattern `0`.

   



+ Pass: Check that the result of evaluating `length [1;2;3;4;5;6]` matches the pattern `6`.

   



+ Pass: Check that the result of evaluating `rev []` matches the pattern `[ ]`.

   



+ Pass: Check that the result of evaluating `rev [1]` matches the pattern `[1]`.

   



+ Pass: Check that the result of evaluating `rev [1; 2; 3; 4]` matches the pattern `[4; 3; 2; 1]`.

   



+ Pass: Check that the result of evaluating `is_elem_by (fun x y -> (x+1) = y) 6 [2;3;5;7]` matches the pattern `true`.

   



+ Pass: Check that the result of evaluating `is_elem_by (fun x y -> (x+1) = y) 0 [2;3;5;7]` matches the pattern `false`.

   



+ Pass: Check that the result of evaluating `is_elem_by (fun x y -> x < y) 4 [2;3;5;7]` matches the pattern `true`.

   



+ Pass: Check that the result of evaluating `is_elem_by (fun x y -> x < y) 0 [2;3;5;7]` matches the pattern `false`.

   



+ Pass: Check that the result of evaluating `is_elem 3 []` matches the pattern `false`.

   



+ Pass: Check that the result of evaluating `is_elem 3 [1; 2; 3]` matches the pattern `true`.

   



+ Pass: Check that the result of evaluating `is_elem 4 [1; 2; 3]` matches the pattern `false`.

   



+ Pass: Check that the result of evaluating `List.sort (fun x y -> if x < y then -1 else 1) (dedup [1;1;4;5;2;3;2])` matches the pattern `[1; 2; 3; 4; 5]`.

   



+ Pass: Check that the result of evaluating 
   ```
List.sort (fun x y -> if x < y then -1 else 1) (dedup [[13; 1]; [13; 1]; [1; 2]; [10; 5]])
   ```
 matches the pattern `[[1; 2]; [10; 5]; [13; 1]]`.

   



+ Pass: Check that the result of evaluating `dedup []` matches the pattern `[ ]`.

   



+ Pass: Check that the result of evaluating `List.sort (fun x y -> if x < y then -1 else 1) (dedup [4;5;2;3])` matches the pattern `[2; 3; 4; 5]`.

   



+ Pass: Check that the result of evaluating `split_by (=) ['a';'b';'c';'d'] ['c']` matches the pattern `[['a'; 'b']; ['d']]`.

   



+ Pass: Check that the result of evaluating `split_by (>) ['a';'b';'c';'d'] ['c']` matches the pattern `[[]; []; ['c'; 'd']]`.

   



+ Pass: Check that the result of evaluating `split_by (=) ['a';'b';'c';'d'] []` matches the pattern `[['a'; 'b'; 'c'; 'd']]`.

   



+ Pass: Check that the result of evaluating `split_by (=) [] ['x']` matches the pattern `[[ ]]`.

   



+ Pass: Check that the result of evaluating `split_by (=) [] []` matches the pattern `[[ ]]`.

   



+ Pass: Check that the result of evaluating 
   ```
List.map (List.map (fun y -> List.map Char.lowercase y)) (convert_to_non_blank_lines_of_words ['W'; 'h'; 'e'; ','; 'a'; ' '; 'b'])
   ```
 matches the pattern `[[['w'; 'h'; 'e']; ['a']; ['b']]]`.

   



+ Pass: Check that the result of evaluating 
   ```
List.map (List.map (fun y -> List.map Char.lowercase y)) (convert_to_non_blank_lines_of_words ['W'; 'h'; 'e'; ','; 'a'; '
'; 'b'])
   ```
 matches the pattern `[[['w'; 'h'; 'e']; ['a']]; [['b']]]`.

   



+ Pass: Check that the result of evaluating 
   ```
List.map (List.map (fun y -> List.map Char.lowercase y)) (convert_to_non_blank_lines_of_words ['W'; 'h'; 'e'; ' '; ','; 'a'; '-'; 'b'])
   ```
 matches the pattern `[[['w'; 'h'; 'e']; ['a']; ['b']]]`.

   



+ Pass: Check that the result of evaluating 
   ```
paradelle "../../../../public-class-repo/Homework/Hwk_02/not_a_paradelle_emma_1.txt"
   ```
 matches the pattern `IncorrectLastStanza`.

   



+ Pass: Check that the result of evaluating 
   ```
paradelle "../../../../public-class-repo/Homework/Hwk_02/not_a_paradelle_empty_file.txt"
   ```
 matches the pattern `IncorrectNumLines 0`.

   



+ Pass: Check that the result of evaluating 
   ```
paradelle "../../../../public-class-repo/Homework/Hwk_02/not_a_paradelle_susan_1.txt"
   ```
 matches the pattern `IncorrectLines [(1, 2); (11, 12); (17, 18)]`.

   



+ Pass: Check that the result of evaluating 
   ```
paradelle "../../../../public-class-repo/Homework/Hwk_02/not_a_paradelle_susan_2.txt"
   ```
 matches the pattern `IncorrectLines [(11, 12); (17, 18)]`.

   



+ Pass: Check that the result of evaluating 
   ```
paradelle "../../../../public-class-repo/Homework/Hwk_02/not_a_paradelle_susan_3.txt"
   ```
 matches the pattern `IncorrectLines [(1, 2); (11, 12); (17, 18)]`.

   



+ Pass: Check that the result of evaluating 
   ```
paradelle "../../../../public-class-repo/Homework/Hwk_02/not_a_paradelle_wrong_line_count.txt"
   ```
 matches the pattern `IncorrectNumLines 9`.

   



+ Pass: Check that the result of evaluating `paradelle "../../../../public-class-repo/Homework/Hwk_02/paradelle_emma_1.txt"` matches the pattern `OK`.

   



+ Pass: Check that the result of evaluating `paradelle "../../../../public-class-repo/Homework/Hwk_02/paradelle_susan_1.txt"` matches the pattern `OK`.

   



+ Pass: Check that the result of evaluating `paradelle "../../../../public-class-repo/Homework/Hwk_02/paradelle_susan_2.txt"` matches the pattern `OK`.

   



+ Pass: Check that the result of evaluating `paradelle "../../../../public-class-repo/Homework/Hwk_02/abc.txt"` matches the pattern `FileNotFound "../../../../public-class-repo/Homework/Hwk_02/abc.txt"`.

   



