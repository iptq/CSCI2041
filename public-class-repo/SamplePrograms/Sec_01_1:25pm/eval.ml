type expr 
  = Add of expr * expr
  | Sub of expr * expr
  | Mul of expr * expr
  | Div of expr * expr
  
  | Lt of expr * expr
  | Eq of expr * expr
  | And of expr * expr
  | Not of expr
  | If of expr * expr * expr

  | Let of string * expr * expr
  | Id of string

  | App of expr * expr
  | Lambda of string * expr

  | Value of value
and value 
  = Int of int
  | Bool of bool
  | 

(* let add = fun x -> fun y -> x + y 
   let add x y = x + y *)
let add = Lambda ("x", Lambda( "y", Add (Id "x", Id "y")))

let inc = Lambda ("x", Add (Id "x", Value (Int 1)))

let two = App inc (Value (Int 1))


