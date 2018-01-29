
(* Construct a circular structure of the form
 
c -->  1  -->  2  -->  3 
       ^               |
       |               |
       +---------------+

Write a function that returns the first n elements.

Each number above should be a pair with an int and a reference to the
next pair.  
*)
type box = Box of int * box ref

let rec dummy = Box (999, ref dummy)
let c =
  let box_ref = dummy in
  let box_thr = Box (3, box_ref ) in
  let box_two = Box (2, ref box_thr ) in
  let box_one = Box (1, ref box_two ) in
  let () = box_ref := box_one in
  box_one

let rec firstn (b:box) (n:int) : int list =
  match n, b with
  | 0, _ -> []
  | _, Box (v, br) -> v :: firstn (!br) (n-1)
