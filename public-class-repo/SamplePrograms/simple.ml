(* A collection of simple functions for used in introductory
   lectures on OCaml. 
   by Eric Van Wyk
 *)

let inc_v1 = fun x -> x + 1

let inc_v2 x = x + 1 

let square x = x * x

let cube x = x * x * x

let add x y = x + y

let inc_v3 = add 1

let add3 x y z = x + y + z

let greater x y = if x > y then x else y

let circumference radius =
  let pi = 3.1415 in
     2.0 *. pi *. radius

let rec sum xs =
  match xs with
  | [ ] -> 0
  | x::rest -> x + sum rest


