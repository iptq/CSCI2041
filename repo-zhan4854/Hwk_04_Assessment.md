### Assessment for Homework 04

#### Total score: _100_ / _100_

Run on March 27, 18:18:29 PM.

+ Pass: Change into directory "Hwk_04".

#### Feedback for ``aritmetic.ml``

+ Pass: Check that file "arithmetic.ml" exists.

+ Pass: Check that an OCaml file "arithmetic.ml" has no syntax or type errors.

    OCaml file "arithmetic.ml" has no syntax or type errors.



##### ``show_expr``

+  _3_ / _3_ : Pass: Check that the result of evaluating `show_expr (Add(Const 1, Const 3))` matches the pattern `"(1+3)"`.

   



+  _3_ / _3_ : Pass: Check that the result of evaluating ` show_expr (Add (Const 1, Mul (Const 3, Const 4)))` matches the pattern `"(1+(3*4))"`.

   



+  _4_ / _4_ : Pass: Check that the result of evaluating `show_expr (Mul (Add(Const 1, Const 3),  Div(Const 8, Const 4)))` matches the pattern `"((1+3)*(8/4))"`.

   



##### ``show_pretty_expr``

+  _2_ / _2_ : Pass: Check that the result of evaluating `show_pretty_expr (Add (Const 1, Mul (Const 3, Const 4)))` matches the pattern `"1+3*4"`.

   



+  _3_ / _3_ : Pass: Check that the result of evaluating `show_pretty_expr (Add (Mul (Const 1, Const 3), Const 4))` matches the pattern `"1*3+4"`.

   



+  _4_ / _4_ : Pass: Check that the result of evaluating `show_pretty_expr (Add (Const 1, Add (Const 3, Const 4)))` matches the pattern `"1+(3+4)"`.

   



+  _3_ / _3_ : Pass: Check that the result of evaluating `show_pretty_expr (Add (Add (Const 1, Const 3), Const 4))` matches the pattern `"1+3+4"`.

   



+  _4_ / _4_ : Pass: Check that the result of evaluating `show_pretty_expr (Mul (Const 4, Add (Const 3, Const 2)))` matches the pattern `"4*(3+2)"`.

   



+  _4_ / _4_ : Pass: Check that the result of evaluating `show_pretty_expr (Sub (Sub (Const 1, Const 2), Sub (Const 3, Const 4)))` matches the pattern `"1-2-(3-4)"`.

   



#### Feedback for ``eval.ml``

+ Pass: Check that file "eval.ml" exists.

+ Pass: Check that an OCaml file "eval.ml" has no syntax or type errors.

    OCaml file "eval.ml" has no syntax or type errors.



##### ``freevars``

+  _2_ / _2_ : Pass: Check that the result of evaluating `freevars (Add (Value (Int 3), Mul (Id "x", Id "y")))` matches the pattern `["x"; "y"]`.

   



+  _2_ / _2_ : Pass: Check that the result of evaluating `freevars (Let ("x", Id "z", Add (Value (Int 3), Mul (Id "x", Id "y"))))` matches the pattern `["z"; "y"]`.

   



+  _2_ / _2_ : Pass: Check that the result of evaluating `freevars (Let ("x", Id "x", Add (Value (Int 3), Mul (Id "x", Id "y"))))` matches the pattern `["x"; "y"]`.

   



+  _2_ / _2_ : Pass: Check that the result of evaluating `freevars (Lambda ("x", Add (Value (Int 3), Mul (Id "x", Id "y"))))` matches the pattern `["y"]`.

   



+  _2_ / _2_ : Pass: Check that the result of evaluating `freevars sumToN_expr` matches the pattern `[]`.

   



##### ``evaluate - arithmetic``

+  _5_ / _5_ : Pass: Check that the result of evaluating `evaluate (Add (Value (Int 1), Mul (Value (Int 2), Value (Int 3))))` matches the pattern `Int 7`.

   



##### ``evaluate - logical``

+  _2_ / _2_ : Pass: Check that the result of evaluating `evaluate (Eq (Value (Int 1), Mul (Value (Int 2), Value (Int 3))))` matches the pattern `Bool false`.

   



+  _3_ / _3_ : Pass: Check that the result of evaluating `evaluate (Lt (Value (Int 1), Mul (Value (Int 2), Value (Int 3))))` matches the pattern `Bool true`.

   



##### ``evaluate - conditional``

+  _2_ / _2_ : Pass: Check that the result of evaluating 
   ```
evaluate (If (Lt (Value (Int 1), Mul (Value (Int 2), Value (Int 3))), Value (Int 4), Value (Int 5)))
   ```
 matches the pattern `Int 4`.

   



+  _3_ / _3_ : Pass: Check that the result of evaluating 
   ```
evaluate (If (Lt (Value (Int 10), Mul (Value (Int 2), Value (Int 3))), Value (Int 4), Value (Int 5)))
   ```
 matches the pattern `Int 5`.

   



##### ``evaluate - let expressions``

+  _5_ / _5_ : Pass: Check that the result of evaluating `evaluate (Let ("x", Value (Int 2), Add (Id "x", Value (Int 4))))` matches the pattern `Int 6`.

   



+  _5_ / _5_ : Pass: Check that the result of evaluating 
   ```
evaluate (Let ("x", Value (Int 2), Let ("y", Add (Id "x", Value (Int 4)), Add (Id "x", Id "y"))))
   ```
 matches the pattern `Int 8`.

   



##### ``evaluate - non-recursive functions``

+  _4_ / _4_ : Pass: Check that the result of evaluating `evaluate (App (add, Value (Int 1)))` matches the pattern `Closure ("y", Add (Id "x", Id "y"), [("x", Int 1)])`.

   



+  _5_ / _5_ : Pass: Check that the result of evaluating `evaluate (App ( (App (add, Value (Int 1))), Value (Int 2)))` matches the pattern `Int 3`.

   



+  _6_ / _6_ : Pass: Check that the result of evaluating 
   ```
evaluate (Let ("add2", Let ("two", Value (Int 2), Lambda ("x", Add (Id "x", Id "two"))), App (Id "add2", Value (Int 4))))
   ```
 matches the pattern `Int 6`.

   



##### ``evaluate - recursive functions``

+  _2_ / _2_ : Pass: Check that the result of evaluating `evaluate (App (sumToN_expr, Value (Int 0)))` matches the pattern `Int 0`.

   



+  _8_ / _8_ : Pass: Check that the result of evaluating `evaluate (App (sumToN_expr, Value (Int 1)))` matches the pattern `Int 1`.

   



+  _10_ / _10_ : Pass: Check that the result of evaluating `evaluate (App (sumToN_expr, Value (Int 10)))` matches the pattern `Int 55`.

   



#### Total score: _100_ / _100_

