### Feedback for Homework 06

Run on April 23, 14:49:22 PM.

+ Pass: Change into directory "Hwk_06".

#### Feedback for ``tautology.ml``

+ Pass: Check that file "tautology.ml" exists.

+ Pass: Check that an OCaml file "tautology.ml" has no syntax or type errors.

    OCaml file "tautology.ml" has no syntax or type errors.



##### ``eval``

+ Pass: 
Check that the result of evaluating
   ```
   eval (And ( Prop "P", Prop "Q")) [("P",true); ("Q",false)]
   ```
   matches the pattern `false`.

   




+ Pass: 
Check that the result of evaluating
   ```
   eval (And ( Prop "P", Prop "Q")) [("P",true); ("Q",true)]
   ```
   matches the pattern `true`.

   




+ Pass: 
Check that the result of evaluating
   ```
   eval (Or (Prop "P", Or (Prop "Q", Prop "R"))) [("P",false); ("Q",false); ("R",false)]
   ```
   matches the pattern `false`.

   




+ Pass: 
Check that the result of evaluating
   ```
   eval (Or (Prop "P", Or (Prop "Q", Prop "R"))) [("P",false); ("Q",false); ("R",true)]
   ```
   matches the pattern `true`.

   




+ Pass: 
Check that the result of evaluating
   ```
   eval (Or (Prop "P", Or (Prop "Q", Not (Prop "R")))) [("P",false); ("Q",false); ("R",true)]
   ```
   matches the pattern `false`.

   




+ Pass: 
Check that the result of evaluating
   ```
   eval (Or (Prop "P", Or (Prop "Q", Not (Prop "R")))) [("P",false); ("Q",false); ("R",false)]
   ```
   matches the pattern `true`.

   




##### ``freevars``

+ Pass: 
Check that the result of evaluating
   ```
   List.exists ( (=) "P" ) (freevars (And (Prop "P", Prop "Q")))
   ```
   matches the pattern `true`.

   




+ Pass: 
Check that the result of evaluating
   ```
   List.exists ( (=) "Q" ) (freevars (Or (Prop "P", Prop "Q")))
   ```
   matches the pattern `true`.

   




+ Pass: 
Check that the result of evaluating
   ```
   List.length (freevars (And ( Prop "P", Or (Prop "Q", Prop "P"))))
   ```
   matches the pattern `2`.

   




+ Pass: 
Check that the result of evaluating
   ```
   freevars (And (True, False))
   ```
   matches the pattern `[ ]`.

   




##### ``is_tautology``

+ Pass: 
Check that the result of evaluating
   ```
   let f = Or (Prop "P", Not (Prop "P")) in
      match is_tautology f (fun s -> Some s) with 
        | None -> "yes" 
        | Some _ -> "no"
   ```
   matches the pattern `"yes"`.

   




+ Pass: 
Check that the result of evaluating
   ```
   let f = Or (Or (Not (Prop "P"), Prop "Q"), Or (Not (Prop "Q"), Prop "P")) in
      match is_tautology f (fun s -> Some s) with 
        | None -> "yes" 
        | Some _ -> "no"
   ```
   matches the pattern `"yes"`.

   




+ Pass: 
Check that the result of evaluating
   ```
   let f = Or (Prop "P", Prop "Q") in
      match is_tautology f (fun s -> Some s) with 
        | None -> "yes" 
        | Some _ -> "no"
   ```
   matches the pattern `"no"`.

   




+ Pass: 
Check that the result of evaluating
   ```
   let f = And (Prop "P", Prop "Q") in
      match is_tautology f (fun s -> Some s) with 
        | None -> "yes" 
        | Some _ -> "no"
   ```
   matches the pattern `"no"`.

   




+ Pass: 
Check that the result of evaluating
   ```
   let f = And (Prop "P", Prop "Q") in
      match is_tautology f (fun s -> Some s) with 
        | None -> "yes" 
        | Some subst when eval f subst = false -> "no" 
        | Some _ -> "fail, error in is_tautology or eval" 
   ```
   matches the pattern `"no"`.

   




+ Pass: 
Check that the result of evaluating
   ```
   let f = And (Not (Prop "P"), Or (Prop "Q", Prop "P")) in
      match is_tautology f (fun s -> Some s) with 
        | None -> "yes" 
        | Some subst when eval f subst = false -> "no" 
        | Some _ -> "fail, error in is_tautology or eval" 
   ```
   matches the pattern `"no"`.

   




#### Feedback for ``maze.ml``

+ Pass: Check that file "maze.ml" exists.

+ Fail: Check that an OCaml file "maze.ml" has no syntax or type errors.

    OCaml file maze.ml has errors.

    Run "ocaml maze.ml" to see them.

    Make sure that you are using ocaml version 4.02.3.  Run "ocaml -version" to check the version number.  Check the specification from Lab 5 again if you are still having problems with this.

+ Skip: 
Check that the result of evaluating
   ```
   (maze () = Some [ (2,3); (1,3); (1,2); (2,2); (3,2); (3,3); (3,4); (4,4); (4,5); (3,5) ]) ||
   (maze () = Some [ (2,3); (1,3); (1,2); (2,2); (3,2); (3,3); (4,3); (5,3); (5,2); (5,1) ]) ||
   (maze () = Some [ (2,3); (1,3); (1,4); (1,5); (2,5); (2,4); (3,4); (3,3); (4,3); (5,3); (5,2); (5,1) ]) ||
   (maze () = Some [ (2,3); (1,3); (1,4); (1,5); (2,5); (2,4); (3,4); (4,4); (4,5); (3,5) ])
   ```
   matches the pattern `true`.

   


  This test was not run because of an earlier failing test.

#### Total score: _16_ / _17_

The total score is used only to count the number of tests passed.  Actual point value for individual tests will change for assessment.

