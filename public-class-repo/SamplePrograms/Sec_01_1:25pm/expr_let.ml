type expr 
  = Const of int
  | Add of expr * expr
  | Sub of expr * expr
  | Mul of expr * expr
  | Div of expr * expr 

  | Let of string * expr * expr
  | Id of string

type environment = (string * int) list

let rec lookup (n:string) (env: environment) : int =
  match env with
  | [] -> raise (Failure ("Identifier " ^ n ^ " not in scope"))
  | (n',v) :: rest when n = n' -> v
  | _ :: rest -> lookup n rest

let rec eval (env: environment) (e:expr) : int =
  match e with
  | Const x -> x
  | Add (e1, e2) -> eval env e1 + eval env e2
  | Sub (e1, e2) -> eval env e1 - eval env e2
  | Mul (e1, e2) -> eval env e1 * eval env e2
  | Div (e1, e2) -> eval env e1 / eval env e2
  | Let (n, dexpr, body) -> 
     let dexpr_v = eval env dexpr in 
     let body_v = eval ((n,dexpr_v)::env) body  in
     body_v

  | Id n -> lookup n env

let e1 = Add (Const 1, Mul (Const 2, Const 3))
let e2 = Sub (Const 10, Div (e1, Const 2))
let e3 = Let ("x", Const 5, Add (Id "x", Const 4))
let e4 = Let ("y", Const 5, Let ("x", Add (Id "y", Const 5), Add (Id "x", Id "y")))
