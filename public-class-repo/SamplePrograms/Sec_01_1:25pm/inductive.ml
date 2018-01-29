(*
Some sample evaluations from the exercises on Feb 6.

let x = 1 + 2 in let y = x + 3 in x + y

let x = 3 in let y = x + 3 in x + y

let x = 3 in let y = 3 + 3 in 3 + y

let x = 3 in let y = 6 in 3 + y

let x = 3 in let y = 6 in 3 + 6

let y = 6 in 3 + 6

3 + 6

9



let rec rev = function
       | [] -> []
       | x::xs -> rev xs @ [x]

rev (1::2::3::[])

rev (2::3::[]) @ [1]

(rev (3::[]) @ [2]) @ [1]

rev ([]) @ [3] @ [2] @ [1]

(([] @ [3]) @ [2]) @ [1]

([3] @ [2]) @ [1]

[3; 2] @ [1]

[3;2;1]

 *)


type color = Red
           | Green
           | Blue

let isRed d = 
  match d with
    Red -> true
  | _-> false




type days = Sunday 
          | Monday
          | Tuesday
          | Wednesday
          | Thursday
          | Friday
          | Saturday

let isWeekDay d =
  match d with 
  | Sunday | Saturday -> false
  | Monday | Tuesday | Wednesday | Thursday | Friday -> true

type intorstr = Int of int 
              | Str of string

(* this has the same functionality as the one in the slides *)
let rec sumList l =
  match l with
  | [] -> 0 
  | (Int i):: tl -> i + sumList tl
  | (Str s):: tl -> sumList tl


(* The OCaml standard library offers the following type:
type 'a option = None
               | Some of 'a

   It is useful for so-called "optional" values.  These are useful in
   circumstances when a function may return a value, but it might not.
   A function that is to read the contents of a file, for example.  It
   may be successful and return a string or char list, or the file
   might not be found and thus it doesn't return a value.

 *)

