let m = [ ("dog", 1); ("chicken",2); ("dog",3); ("cat",5)]

let rec lookup_all s m =
  match m with
  | [] -> []
  | (name,value)::ms -> 
     let rest = lookup_all s ms
     in if s = name  then value :: rest else rest

(* find all by : (’a -> ’a ->bool) -> ’a ->
                        ’a list -> ’a list
 *)

let streq s1 s2 =  s1  = s2
let check (s2,v) s1 = s1 = s2
let rec find_all_by equals v lst =
  match lst with
  | [] -> []
  | x::xs when equals x v -> x :: find_all_by equals v xs
  | x::xs -> find_all_by equals v xs

let rec snds l =
  match l with 
  | [] -> []
  | (v1,v2)::rest -> v2 :: snds rest

let lookup_all' s m = snds (find_all_by check s m)  

let is_elem_by equals e l =
  match find_all_by equals e l with
  | [] -> false
  | _::_  -> true


let rec find_all_with f l =
  match l with
  | [] -> []
  | x::xs ->
     let rest = find_all_with f xs
     in if f x then x::rest else rest

let find_all_by' eq v l = find_all_with (fun x -> eq x v) l

let find_all_by'' eq v = find_all_with (fun x -> eq x v)

let find_all_with' f l = find_all_by (fun x y -> f x = y) true

let find_all x = find_all_with ((=) x)

(* drop while: ’a list -> (’a -> bool) -> ’a list 

   drop_while ( (=) 4 ) [4;4;4;5;6;7]  =  [5;6;7]  *)

let rec drop_while l f =
  match l with
  | [] -> [] 
  | v::rest -> if f v then drop_while rest f else v::rest
