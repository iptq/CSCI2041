(* NOTE: This file will be updated as the lectures cover more search
   techniques.  It is NOT COMPLETE as it now stands. 

   Below are the functions developed in lecture for the unit on search
   as a programmin technique.  The slides are S6_Search.
 *)


(* Below, we generate all possible subsets of a set of values.
   Note that we are using lists to represent sets and simply
   assume that we do not have duplicates.  If this is a concern
   we could use a "dedup" function to remove duplicates.

   The important point here is to see that for each element in the
   list we have to make a choice - include it in the subset or do not
   include it.

   This leads to the two recursive calls, one that returns subsets
   with it, and one that returns subsets without it.

   See how the search tree we drew on the whiteboard corresponds to
   the "call graph" of the functions?
 *)

let gen_subsets lst =
  let rec helper partial_list rest
    =  match rest with
    | [] -> [ partial_list ]
    | x::xs -> (helper (x::partial_list) xs)
               @
                 (helper partial_list      xs)
  in helper [] lst


(* using List.map, courtesy of Ruoyun Chen *)
let rec gen_subset lst = match lst with
  | [ ] ->[ [ ] ]
  | x::rest-> List.map (fun xs->x::xs) (gen_subset rest) @
                List.map (fun xs->xs) (gen_subset rest) 


(* --- 
   Options
   ---
 *)

let s = [ 1; 3; -2; 5; -6 ]   (* sample set from the S6 slides *)

let sum lst = List.fold_left (+) 0 lst

(* Our first implementation of subsetsum uses options to indicate if
   we found a solution or not.  If our searching function 'try_subset'
   fails to find a value, it returns None; if it finds what we are
   looking for, then it returns that values wrapped up in a Some.
 *)

let subsetsum_v1 (lst: int list) : int list option =
  let rec helper partial_list rest
    = if sum partial_list = 0 && partial_list <> []
      then Some partial_list
      else
        match rest with
        | [] -> None 
        | x::xs -> (match helper (x::partial_list) xs with
                    | Some solution -> Some solution
                    | None -> helper partial_list xs
                   )
  in helper [] lst


(* Here is another implementation of the above algorithm using
   options.  The final value returned by the function is an int list,
   however.  The empty list indicating that no subset was found.

   The reason for writing this function is only to make it clear that
   using an option in the return type of the subsetsum function above
   was not related to our use of options in the recursive search
   procedure.
 *)
let subsetsum_option_v2 (lst: int list) : int list =
  let rec try_subset partial_subset rest_of_the_set =
    if sum partial_subset = 0 && partial_subset <> [] && rest_of_the_set = []
    then Some partial_subset 
    else match rest_of_the_set with
	 | [] -> None
	 | x::xs -> match try_subset (partial_subset @ [x]) xs with
		    | None -> try_subset partial_subset  xs
		    | Some result -> Some result

    in match try_subset [] lst with
       | None -> []
       | Some result -> result


(* Below we see how we can keep searching once we've found a solution to 
   the problem.
   It may be that this solution is not acceptable to the user or there
   is simply some other evaluation criteria that we with to apply to
   the found solution.
   This lets the program keep looking even after finding a solution.
 *)

(* First, a function for converting lists into strings *)
let show_list show l =
  let rec sl l =
    match l with 
    | [] -> ""
    | [x] -> show x
    | x::xs -> show x ^ "; " ^ sl xs
  in "[ " ^ sl l ^ " ]"

(* Now, is_elem which is used in processing the solution *)
let is_elem v l =
  List.fold_right (fun x in_rest -> if x = v then true else in_rest) l false

let rec explode = function
  | "" -> []
  | s  -> String.get s 0 :: explode (String.sub s 1 ((String.length s) - 1))

let rec implode = function
  | []    -> ""
  | c::cs -> String.make 1 c ^ implode cs

(* We need to learn about modules soon ... S7 coming soon. *)




(* This function processes a solution, letting the user decide if
   the solution is acceptable or not.

   If not, then we want to keep looking.  Thus, it returns None,
   indicating that we have not yet found a solution, at least not one
   that we want to keep.

   If it is acceptable, then Some s (the proposed solution) is returned. 

   The function also takes a show function to print out the solution
   to the user.
 *)
let rec process_solution_option show s =
  print_endline ("Here is a solution: " ^ show s) ;
  print_endline ("Do you like it ?" ) ;
  match is_elem 'Y' (explode (String.capitalize (read_line ()))) with
  | true  -> print_endline "Thanks for playing..." ; Some s
  | false -> None

(* This version of subsetsum will let the user choose from the
   discovered solutions, one at a time, until an acceptable one is
   found.

   The process_solution_optoin function returns None of a Some value
   to indicate that the search should continue or end.
 *)
let subsetsum_option (lst: int list) : int list option =
  let rec try_subset partial_subset rest_of_the_set =
    if sum partial_subset = 0 && partial_subset <> [] && rest_of_the_set = []
    then (* Instead of returning Some partial_subset and quitting we let 
            the user decide to keep looking for more solutions or not. *)
      process_solution_option (show_list string_of_int) partial_subset 
    else match rest_of_the_set with
	 | [] -> None
	 | x::xs -> match try_subset (partial_subset @ [x]) xs with
		    | None -> try_subset partial_subset  xs
		    | Some result -> Some result

    in try_subset [] lst




