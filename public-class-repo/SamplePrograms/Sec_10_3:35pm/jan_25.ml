let is_empty_1 l = 
  match l with
  | [] -> true
  | x::rest -> false

let is_empty_2 l = 
  if l = [] then true else false

let is_empty_3 l = l = [] 

let is_empty_4 l = 
  match l with
  | [] -> true
  | _::_  -> false


let head l = 
  match l with
  | [] -> raise (Failure "hey genius, not empty lists allowed") 
  | x::_ -> x

let head' l =
  match l with
  | [] -> None
  | x::_ -> Some x


let rec drop_value to_drop l =
  match l with
  | [] -> []
  | hd::tl when hd = to_drop -> drop_value to_drop tl
  | hd::tl -> hd :: drop_value to_drop tl

(*
let rec lookup_all v m =
  match m with
  | [] -> []
  | (key,value)::rest when key = v -> 

 *)

let rec fib x =
  if x = 0 then 0 else
    if x = 1 then 1 else fib (x-1) + fib (x-2)

let rec fib' x = 
  match x with
  | 0 -> 0
  | 1 -> 1
  | _ -> fib'(x-1) + fib'(x-2)
