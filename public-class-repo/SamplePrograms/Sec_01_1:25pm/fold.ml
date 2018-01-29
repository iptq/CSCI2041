(* Sec 01, Feb 3 *)

(*
  fold (+) 0 [1;2;3;4]
We can see this as
   1 + (2 + (3 + (4 + 0)))
 *)

let rec fold_v1 f e l =
  match l with
  | [] -> e
  | x::xs -> f x (fold_v1 f e xs)

let f : (int -> string -> string) =
  fun x -> fun s -> string_of_int x ^ ", " ^ s


(*  fold (+) 0 [1;2;3;4]
as
((((0 + 1) + 2) + 3) + 4)
 *)

let rec fold_v2 f e lst = 
  match lst with 
  | [] -> e
  | hd::tail -> fold_v2 f (f e hd) tail


let g : (string -> int -> string) =
  fun s -> fun x -> s ^ ", " ^ string_of_int x


(* Below are the versions of these functions from the slides.  They
   are the same excpet for their names.  Below we chose 'l' and 'r' to
   indicate if we are folding lists up from the left of from the
   right. *)

let rec foldr (f:'a -> 'b -> 'b) (l:'a list) (v:'b) : 'b =
  match l with
  | [] -> v
  | x::xs -> f x (foldr f xs v)

(* Notice how 'f' replaces '::' and 'v' replaces '[]' *)

let rec foldl f v l =
  match l with
  | [] -> v
  | x::xs ->  foldl f (f v x) xs

let length (lst: 'a list) : int =  foldl (fun n _ -> n + 1 ) 0 lst
