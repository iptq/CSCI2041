(* A module for intervals over integers. 

   This is not an abstract type, all types are exposed.

   The module is used only to collect the types and values
   into a single entity.

   This code is based on the Interval examples in Chapter 9 of Real
   World OCaml by Jason Hickey, Anil Madhavapeddy and Yaron Minsky.
 *)

type intInterval = Interval of int * int 
		 | Empty

let is_empty (i:intInterval) : bool =
  match i with
  | Empty -> true
  | Interval _ -> false

let contains (i:intInterval) (x:int) : bool =
  match i with
  | Empty -> false
  | Interval (l,h) -> l <= x && x <= h

let intersect (i1:intInterval) (i2:intInterval) : intInterval =
  match i1, i2 with
  | Empty, _ | _, Empty -> Empty
  | Interval (l1, h1), Interval (l2, h2) ->
     Interval (max l1 l2, min h1 h2)

let to_string (i:intInterval) : string =
  match i with
  | Empty -> "Empty"
  | Interval (l,h) -> "(" ^ string_of_int l ^ ", " ^ string_of_int h ^ ")"


