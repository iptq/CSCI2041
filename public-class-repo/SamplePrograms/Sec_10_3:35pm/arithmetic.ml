type expr 
  = Int of int
  | Add of expr * expr 
  | Sub of expr * expr
  | Mul of expr * expr
  | Div of expr * expr

(* eval: expr -> int *)
let rec eval = function
  | Int i -> i
  | Add (e1, e2) -> eval e1 + eval e2
  | Sub (e1, e2) -> eval e1 - eval e2
  | Mul (e1, e2) -> eval e1 * eval e2
  | Div (e1, e2) -> eval e1 / eval e2

(* 1 + 2 * 3 *)
let e1 = Add (Int 1, Mul (Int 2, Int 3))
let e2 = Sub (Int 10, Div (e1, Int 3))


