
let rec filter f l =
  match l with
  | [] -> [] 
  | x::xs -> 
     let rest = filter f xs 
     in
     if f x 
     then x :: rest
     else rest

let rec filter' f l =
  match l with
  | [] -> []
  | x::xs when f x -> x :: filter f xs
  | x::xs -> filter f xs

let filter_out f l = filter (fun v -> not (f v)) l
