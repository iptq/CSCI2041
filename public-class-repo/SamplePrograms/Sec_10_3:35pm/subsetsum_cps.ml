(* ---
   Continuation Passing Style
   ---
 *)


(* First, a function for converting lists into strings *)
let show_list show l =
  let rec sl l =
    match l with 
    | [] -> ""
    | [x] -> show x
    | x::xs -> show x ^ "; " ^ sl xs
  in "[ " ^ sl l ^ " ]"

(* Now is_elem which are used in processing the solution *)

let is_elem v l =
  List.fold_right (fun x in_rest -> if x = v then true else in_rest) l false


let rec explode = function
  | "" -> []
  | s  -> String.get s 0 :: explode (String.sub s 1 ((String.length s) - 1))

let rec implode = function
  | []    -> ""
  | c::cs -> String.make 1 c ^ implode cs

(* We use a sum function below, so we'll bring in the needed functions
   for that. *)

let sum xs = List.fold_left (+) 0 xs



(* Continuation passing style is a style of writing programs in which
   the computation that happens after a function returns is packaged
   as a function and passed to that function instead where it is
   called directly.

   In CPS, functions do not return.  The computation that happens next
   is passed along as an argument in the form of a continuation
   function.

   In the subsetsum problem we pass two continuations, one to evaluate
   if we succeed and find a subset that sums to 0, and another one in
   the case in which we fail and reach a deadend in the search
   process.
 *)

let rec process_solution_cps_v1 show s succ fail =
  print_endline ("Here is a solution: \n" ^ show s) ;
  print_endline ("Do you like it?");

  match is_elem 'Y' (explode (String.capitalize (read_line ()))) with
  | true  -> succ ()
  | false -> fail ()



let rec try_subset_cps_v1 partial_subset rest_of_the_set succ fail =
  if sum partial_subset = 0 && partial_subset <> [] && rest_of_the_set = []

  then process_solution_cps_v1 (show_list string_of_int) 
			       partial_subset succ fail

  else match rest_of_the_set with
       | [] -> fail ()
       | x::xs -> 
	  try_subset_cps_v1 
	    (partial_subset @ [x]) xs 
	    succ 
	    (fun () -> try_subset_cps_v1 partial_subset xs succ fail)
            (* Here the failure continuation will try to other
               possibility of not including x in the partial subset.*)


let subsetsum_cps_v1 (lst: int list)  =
   try_subset_cps_v1 
     [] lst 
     (* Our success and failure continuations just print a message. *)
     (fun () -> print_endline "Yeah, we found one")
     (fun () -> print_endline "Oh no, no subset found.")



(* Another version in which the success continuation takes the chosen
   subset as an argument.
 *)

let rec process_solution_cps_v2 show s succ fail = 
  print_endline ( "Here is a solution:\n" ^ show s) ;
  print_endline ("Do you like it?") ;

  match is_elem 'Y' (explode (String.capitalize (read_line ()))) with
  | true  -> succ s
  | false -> fail ()


let rec try_subset_cps_v2 partial_subset rest_of_the_set succ fail =
  if sum partial_subset = 0 && partial_subset <> [] && rest_of_the_set = []

  then process_solution_cps_v2 (show_list string_of_int) 
			       partial_subset succ fail

  else match rest_of_the_set with
       | [] -> fail ()
       | x::xs -> 
	  try_subset_cps_v2 
	    (partial_subset @ [x]) xs 
	    succ 
	    (fun () -> try_subset_cps_v2 partial_subset xs succ fail)

let subsetsum_cps_v2 (lst: int list)  =
   try_subset_cps_v2 
     [] lst 
     (fun ss -> print_endline ("Yeah, we found one.\n" ^ 
		  "It is as follows:\n" ^
		    show_list string_of_int ss))
     (fun () -> print_endline "Oh no, no subset found.")
