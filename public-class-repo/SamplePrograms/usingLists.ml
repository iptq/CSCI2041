(* This file contains some uses of functions in "ourList.ml"

   If this files is used in utop, then be sure to enter the following
   to make the OurList module available.

        #mod_use "ourList.ml" ;;

 *)


let length l = OurList.foldr (fun _ length_of_tail -> 1 + length_of_tail) 0 l

let sum xs = OurList.foldl (+) 0 xs

let () =
  print_endline "Hello" ;
  print_endline (string_of_int (sum [1;2;3;4]))
