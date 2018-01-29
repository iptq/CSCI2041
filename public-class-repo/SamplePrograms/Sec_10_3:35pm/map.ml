(* map : ('a -> 'b) -> 'a list -> 'b list *)

let inc x = x + 1

let rec map f l =
  match l with
  | [] -> []
  | a::rest -> f a :: map f rest


let r = map inc [1;2;3;4] ;
