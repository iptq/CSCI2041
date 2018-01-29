(* Sec 01, Feb 3 *)

(*   fold (+) 0 [1;2;3;4] 
  fold: ( 'a -> 'b -> 'a )
    ->  'a
    ->  'a list
    ->  'b 

We can see this as
   1 + (2 + (3 + (4 + 0)))
 *)

let rec fold_v1 f i l =
  match l with
  | [] -> i
  | x::rest -> f x (fold_v1 f i rest)

let string_folder x s =  string_of_int x ^ " " ^ s

(* fold (+) 0 [1;2;3;4]
   as
   ((((0 + 1) + 2) + 3) + 4) 
 *)
let rec fold_v2 f i l =
  match l with
  | [] -> i
  | x::rest -> fold_v2 f (f i x) rest



let rec foldr (f:'a -> 'b -> 'b) (l:'a list) (v:'b) : 'b =
  match l with
  | [] -> v
  | x::xs -> f x (foldr f xs v)

(* foldl (+) 0 [1;2;3;4]
   as
   ((((0 + 1) + 2) + 3) + 4) *)
let rec foldl f v l =
  match l with
  | [] -> v
  | x::xs ->  foldl f (f v x) xs

let length lst = foldl (fun n x -> n + 1 ) 0 lst 


let sum lst = foldl (+) 0 lst
