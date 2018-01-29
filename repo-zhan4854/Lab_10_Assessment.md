### Assessment for Lab 10

#### Total score: _25_ / _25_

Run on April 10, 00:36:30 AM.

+ Pass: Change into directory "Lab_10".

+ Pass: Check that file "lab_10.ml" exists.

+ Pass: Check that an OCaml file "lab_10.ml" has no syntax or type errors.

    OCaml file "lab_10.ml" has no syntax or type errors.



+  _5_ / _5_ : Pass: Check that the result of evaluating `take 5 (str_from 10)` matches the pattern `["10"; "11"; "12"; "13"; "14"]`.

   



+  _5_ / _5_ : Pass: Check that the result of evaluating `take 5 str_nats` matches the pattern `["1"; "2"; "3"; "4"; "5"]`.

   



+  _5_ / _5_ : Pass: Check that the result of evaluating `take 10 (separators 2 "$$")` matches the pattern `["$$"; "$$"; "
"; "$$"; "$$"; "
"; "$$"; "$$"; "
"; "$$"] (* Note that the newline characters do not appear in this sample output.  Markdown does not treat the "backslash n" character as a new line.  Just make sure your output of "print_endline str_105_nats" looks correct and that there are now extra spaces except as part of the "comma and space" separator value passed into your function "separators" *)`.

   



+  _5_ / _5_ : Pass: Check that the result of evaluating `take 10 (alternate nats (from 100))` matches the pattern `[1; 100; 2; 101; 3; 102; 4; 103; 5; 104]`.

   



+  _5_ / _5_ : Pass: Check that the result of evaluating `str_105_nats` matches the pattern `"1, 2, 3, 4, 5, 6, 7, 8, 9, 10
11, 12, 13, 14, 15, 16, 17, 18, 19, 20
21, 22, 23, 24, 25, 26, 27, 28, 29, 30
31, 32, 33, 34, 35, 36, 37, 38, 39, 40
41, 42, 43, 44, 45, 46, 47, 48, 49, 50
51, 52, 53, 54, 55, 56, 57, 58, 59, 60
61, 62, 63, 64, 65, 66, 67, 68, 69, 70
71, 72, 73, 74, 75, 76, 77, 78, 79, 80
81, 82, 83, 84, 85, 86, 87, 88, 89, 90
91, 92, 93, 94, 95, 96, 97, 98, 99, 100
101, 102, 103, 104, 105" (* Note that the newline characters do not appear in this sample output.  Markdown does not treat the "backslash n" character as a new line.  Just make sure your output of "print_endline str_105_nats" looks correct and that there are now extra spaces except as part of the "comma and space" separator value passed into your function "separators" *)`.

   



