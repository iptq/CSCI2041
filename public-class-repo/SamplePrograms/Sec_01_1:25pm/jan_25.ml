let is_empty_1 l = 
   if l = [] then true else false

let is_empty_2 l = 
  match l with
  | [] -> true
  | _ -> false

let is_empty3 l = l = []

let head l = 
  match l with
  | [] -> None 
  | h::_ -> Some h

let head' l =
  match l with
  | [] -> raise (Failure "hey, genius, your list was empty")
  | h::_ -> h

let rec drop_value td l =
  match l with
  | [] -> []
  | h::t when h = td -> drop_value td t
  | h::t -> h :: drop_value td t

let both_empty l1 l2  =
 match (l1, l2) with
 | ([], []) -> true
 | (_,  _ ) -> false 


(*
 Can you complete lookup_all?
let rec lookup_all v l = 
  match l with
  | [] -> []
  | (key,value)::rest when key = v ->  ......
 *)


let rec fib x = 
  match x with
  | 0 -> 0
  | 1 -> 1
  | n -> fib(n-1) + fib(n-2) 
