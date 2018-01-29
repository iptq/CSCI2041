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
let rec dummy : box = Box (999, ref dummy)

let c = 
  let ref_in_one = ref dummy in
  let one = Box (1, ref_in_one) in
  let three = Box (3, ref one) in
  let two = Box (2, ref three) in
  let () =  ref_in_one := two in
  ref one

let rec c' = 
  Box (1, ref (Box (2, ref (Box (3, ref c')))))

let rec first_n (n:int) (b:box) : int list =
  match n, b with
  | 0, _ -> [] 
  | _, Box (v, nb) -> v :: first_n (n-1) (!nb)
