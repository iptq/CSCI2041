### Assessment for Homework 05

This is the automated grading for homework 5. More grading will be done for the written components of this assignment.

#### Total score: _65_ / _65_

Run on April 14, 14:04:12 PM.

+ Pass: Change into directory "Hwk_05".

### Feedback for ``hwk_05.ml``

+ Pass: Check that file "hwk_05.ml" exists.

+ Pass: Check that an OCaml file "hwk_05.ml" has no syntax or type errors.

    OCaml file "hwk_05.ml" has no syntax or type errors.



+  _2_ / _2_ : Pass: 
Check that the result of evaluating
   ```
   ands [ true; true; true ]
   ```
   matches the pattern `true`.

   




+  _1_ / _1_ : Pass: 
Check that the result of evaluating
   ```
   ands [ ]
   ```
   matches the pattern `true`.

   




+  _2_ / _2_ : Pass: 
Check that the result of evaluating
   ```
   ands [ true; false; true ]
   ```
   matches the pattern `false`.

   




### Feedback for ``streams.ml``

+ Pass: Check that file "streams.ml" exists.

+ Pass: Check that an OCaml file "streams.ml" has no syntax or type errors.

    OCaml file "streams.ml" has no syntax or type errors.



##### ``cubes_from``

+  _2_ / _2_ : Pass: 
Check that the result of evaluating
   ```
   head (cubes_from 2)
   ```
   matches the pattern `8`.

   




+  _3_ / _3_ : Pass: 
Check that the result of evaluating
   ```
   take 5 (cubes_from 3)
   ```
   matches the pattern `[27; 64; 125; 216; 343]`.

   




##### ``drop``

+  _2_ / _2_ : Pass: 
Check that the result of evaluating
   ```
   head ( drop 3 nats )
   ```
   matches the pattern `4`.

   




+  _3_ / _3_ : Pass: 
Check that the result of evaluating
   ```
   take 2 ( drop 3 ( squares ) )
   ```
   matches the pattern `[ 16; 25 ]`.

   




##### ``drop_until``

+  _2_ / _2_ : Pass: 
Check that the result of evaluating
   ```
   head (drop_until (fun v -> v > 35) squares)
   ```
   matches the pattern `36`.

   




+  _3_ / _3_ : Pass: 
Check that the result of evaluating
   ```
   take 3 (drop_until (fun x -> x > 10) nats)
   ```
   matches the pattern `[11; 12; 13]`.

   




##### ``map``

+  _2_ / _2_ : Pass: 
Check that the result of evaluating
   ```
   head (map (fun x -> x mod 2 = 0) nats)
   ```
   matches the pattern `false`.

   




+  _3_ / _3_ : Pass: 
Check that the result of evaluating
   ```
   take 4 (map (fun x -> x mod 2 = 0) nats)
   ```
   matches the pattern `[false; true; false; true]`.

   




##### ``squares_again``

+  _2_ / _2_ : Pass: 
Check that the result of evaluating
   ```
   head squares_again
   ```
   matches the pattern `1`.

   




+  _3_ / _3_ : Pass: 
Check that the result of evaluating
   ```
   take 5 squares_again
   ```
   matches the pattern `[1; 4; 9; 16; 25]`.

   




##### square root approximations

+  _5_ / _5_ : Pass: Check that the result of evaluating `head (sqrt_approximations 49.0)` is within 1.0 of `25.`.

   



+  _5_ / _5_ : Pass: Check that the result of evaluating `head (drop 4 (sqrt_approximations 49.0))` is within 0.5 of `8.5`.

   



+  _5_ / _5_ : Pass: Check that the result of evaluating `head diminishing` is within 1.0 of `16.0`.

   



+  _5_ / _5_ : Pass: Check that the result of evaluating `head (drop 6 diminishing)` is within 0.05 of `0.25`.

   



+  _5_ / _5_ : Pass: Check that the result of evaluating `epsilon_diff 0.3 diminishing` is within 0.3 of `0.25`.

   



+  _5_ / _5_ : Pass: Check that the result of evaluating `precise_calculation` is within 0.05 of `7.07`.

   



##### another square root approximation

+  _5_ / _5_ : Pass: Check that the result of evaluating `sqrt_threshold 50.0 3.0` is within 0.5 of `7.12`.

   



#### Total score: _65_ / _65_

