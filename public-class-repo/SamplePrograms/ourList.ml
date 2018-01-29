(* A file containing various list processing functions.

   This is can be used as a module from other files.
 *)

let rec map f l = match l with
  | [ ] -> [ ]
  | x::xs -> f x :: map f xs


let rec filter f l = match l with
  | [ ] -> [ ]
  | x::xs -> let rest = filter f xs
	     in if f x then x :: rest else rest

let rec foldr f v l = match l with
  | [] -> v
  | x::xs -> f x (foldr f v xs)

let rec foldl f v l = match l with
  | [] -> v
  | x::xs -> foldl f (f v x) xs

let is_elem v l =
  foldr (fun x in_rest -> if x = v then true else in_rest) false l


let rec explode = function
  | "" -> []
  | s  -> String.get s 0 :: explode (String.sub s 1 ((String.length s) - 1))

let rec implode = function
  | []    -> ""
  | c::cs -> String.make 1 c ^ implode cs
