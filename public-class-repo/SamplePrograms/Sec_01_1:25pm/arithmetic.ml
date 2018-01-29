
type expr 
  = Const of int
  | Add of expr * expr
  | Sub of expr * expr
  | Mul of expr * expr
  | Div of expr * expr 

let rec eval (e:expr) : int =
  match e with
  | Const x -> x
  | Add (e1, e2) -> eval e1 + eval e2
  | Sub (e1, e2) -> eval e1 - eval e2
  | Mul (e1, e2) -> eval e1 * eval e2
  | Div (e1, e2) -> eval e1 / eval e2

let e1 = Add (Const 1, Mul (Const 2, Const 3))
let e2 = Sub (Const 10, Div (e1, Const 2))
