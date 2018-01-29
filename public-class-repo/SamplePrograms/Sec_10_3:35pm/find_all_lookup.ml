let m = [ ("dog", 1); ("chicken", 2); ("dog", 3); ("cat", 5) ]

let rec lookup_all s m =
  match m with
  | [] -> []
  | (name,value)::ms -> 
     let rest = lookup_all s ms
     in if s = name  then value :: rest else rest

(* find all by : (’a -> ’a ->bool) -> ’a ->
                        ’a list -> ’a list
 *)
let streq s1 s2 =   s1 = s2
let check (s,i) s' =  s = s'
let rec find_all_by eq v l =
  match l with
  | [] -> []
  | x::xs -> if eq x v 
             then x :: find_all_by eq v xs
             else find_all_by eq v xs

let rec snds l =
  match l with
  | [] -> [] 
  | (f,s)::rest -> s :: snds rest

let rec find_all_with f lst =  match lst with
  | [] -> []
  | x::xs ->
     let rest = find_all_with f xs
     in if f x then x::rest else rest

let find_all_by' eq e lst = find_all_with (fun x -> eq x e) lst

(*
drop_while even  [2;4;6;8;9;4;2] ==>  [9;4;2]
drop_until even  [1;3;5;2;4;6;8;9;4;2]  ==> [2;4;6;8;9;4;2] 
 *)

(* flip:  ('a -> 'b -> 'c) -> ('b -> ('a -> 'c)) *)
let flip f x y = f y x


(* (’b->’c)->(’a->’b)->(’a->’c) *)
let compose f g x = f (g x)



