(* filter: ('a -> bool) -> 'a list -> 'a list  *)

let rec filter exp xs =
  match xs with
  | [] -> []
  | x1::rest -> if exp x1 then x1::filter exp rest else filter exp rest

let rec filter' exp xs =
  match xs with
  | [] -> []
  | x1::rest when exp x1 -> x1::filter exp rest
  | x1::rest -> filter exp rest
