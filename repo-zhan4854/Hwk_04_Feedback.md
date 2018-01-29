### Feedback for Homework 04

Run on March 28, 08:49:48 AM.

+ Pass: Change into directory "Hwk_04".

#### Feedback for ``aritmetic.ml``

+ Pass: Check that file "arithmetic.ml" exists.

+ Pass: Check that an OCaml file "arithmetic.ml" has no syntax or type errors.

    OCaml file "arithmetic.ml" has no syntax or type errors.



##### ``show_expr``

+ Pass: Check that the result of evaluating `show_expr (Add(Const 1, Const 3))` matches the pattern `"(1+3)"`.

   



+ Pass: Check that the result of evaluating ` show_expr (Add (Const 1, Mul (Const 3, Const 4)))` matches the pattern `"(1+(3*4))"`.

   



+ Pass: Check that the result of evaluating `show_expr (Mul (Add(Const 1, Const 3),  Div(Const 8, Const 4)))` matches the pattern `"((1+3)*(8/4))"`.

   



##### ``show_pretty_expr``

+ Pass: Check that the result of evaluating `show_pretty_expr (Add (Const 1, Mul (Const 3, Const 4)))` matches the pattern `"1+3*4"`.

   



+ Pass: Check that the result of evaluating `show_pretty_expr (Add (Mul (Const 1, Const 3), Const 4))` matches the pattern `"1*3+4"`.

   



+ Pass: Check that the result of evaluating `show_pretty_expr (Add (Const 1, Add (Const 3, Const 4)))` matches the pattern `"1+(3+4)"`.

   



+ Pass: Check that the result of evaluating `show_pretty_expr (Add (Add (Const 1, Const 3), Const 4))` matches the pattern `"1+3+4"`.

   



+ Pass: Check that the result of evaluating `show_pretty_expr (Mul (Const 4, Add (Const 3, Const 2)))` matches the pattern `"4*(3+2)"`.

   



+ Pass: Check that the result of evaluating `show_pretty_expr (Sub (Sub (Const 1, Const 2), Sub (Const 3, Const 4)))` matches the pattern `"1-2-(3-4)"`.

   



#### Feedback for ``eval.ml``

+ Pass: Check that file "eval.ml" exists.

+ Pass: Check that an OCaml file "eval.ml" has no syntax or type errors.

    OCaml file "eval.ml" has no syntax or type errors.



##### ``freevars``

+ Pass: Check that the result of evaluating `freevars (Add (Value (Int 3), Mul (Id "x", Id "y")))` matches the pattern `["x"; "y"]`.

   



+ Pass: Check that the result of evaluating `freevars (Let ("x", Id "z", Add (Value (Int 3), Mul (Id "x", Id "y"))))` matches the pattern `["z"; "y"]`.

   



+ Pass: Check that the result of evaluating `freevars (Let ("x", Id "x", Add (Value (Int 3), Mul (Id "x", Id "y"))))` matches the pattern `["x"; "y"]`.

   



+ Pass: Check that the result of evaluating `freevars (Lambda ("x", Add (Value (Int 3), Mul (Id "x", Id "y"))))` matches the pattern `["y"]`.

   



+ Pass: Check that the result of evaluating `freevars sumToN_expr` matches the pattern `[]`.

   



##### ``evaluate - arithmetic``

+ Pass: Check that the result of evaluating `evaluate (Add (Value (Int 1), Mul (Value (Int 2), Value (Int 3))))` matches the pattern `Int 7`.

   



##### ``evaluate - logical``

+ Pass: Check that the result of evaluating `evaluate (Eq (Value (Int 1), Mul (Value (Int 2), Value (Int 3))))` matches the pattern `Bool false`.

   



+ Pass: Check that the result of evaluating `evaluate (Lt (Value (Int 1), Mul (Value (Int 2), Value (Int 3))))` matches the pattern `Bool true`.

   



##### ``evaluate - conditional``

+ Pass: Check that the result of evaluating 
   ```
evaluate (If (Lt (Value (Int 1), Mul (Value (Int 2), Value (Int 3))), Value (Int 4), Value (Int 5)))
   ```
 matches the pattern `Int 4`.

   



+ Pass: Check that the result of evaluating 
   ```
evaluate (If (Lt (Value (Int 10), Mul (Value (Int 2), Value (Int 3))), Value (Int 4), Value (Int 5)))
   ```
 matches the pattern `Int 5`.

   



##### ``evaluate - let expressions``

+ Pass: Check that the result of evaluating `evaluate (Let ("x", Value (Int 2), Add (Id "x", Value (Int 4))))` matches the pattern `Int 6`.

   



+ Pass: Check that the result of evaluating 
   ```
evaluate (Let ("x", Value (Int 2), Let ("y", Add (Id "x", Value (Int 4)), Add (Id "x", Id "y"))))
   ```
 matches the pattern `Int 8`.

   



##### ``evaluate - non-recursive functions``

+ Pass: Check that the result of evaluating `evaluate (App (add, Value (Int 1)))` matches the pattern `Closure ("y", Add (Id "x", Id "y"), [("x", Int 1)])`.

   



+ Pass: Check that the result of evaluating `evaluate (App ( (App (add, Value (Int 1))), Value (Int 2)))` matches the pattern `Int 3`.

   



+ Pass: Check that the result of evaluating 
   ```
evaluate (Let ("add2", Let ("two", Value (Int 2), Lambda ("x", Add (Id "x", Id "two"))), App (Id "add2", Value (Int 4))))
   ```
 matches the pattern `Int 6`.

   



##### ``evaluate - recursive functions``

+ Pass: Check that the result of evaluating `evaluate (App (sumToN_expr, Value (Int 0)))` matches the pattern `Int 0`.

   



+ Pass: Check that the result of evaluating `evaluate (App (sumToN_expr, Value (Int 1)))` matches the pattern `Int 1`.

   



+ Pass: Check that the result of evaluating `evaluate (App (sumToN_expr, Value (Int 10)))` matches the pattern `Int 55`.

   



The total score is used only to count the number of tests passed.  Actual point value for individual tests will change for assessment.

#### Total score: _100_ / _100_

