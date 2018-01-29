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

  | Value of value
and value 
  = Int of int
  | Bool of bool


(* freevars (Add(Id "x", Value (Int 3)))  ---->>  ["x"]
   freevars (Let ("x", Id "y", (Add(Id "x", Value (Int 3)))))  ---->>  ["y"] *)
let rec freevars (e:expr)  : string list =  
  match e with
  | Value v -> []
  | Add (e1, e2) -> freevars e1 @ freevars e2
  | Let (i, dexpr, body) -> 
     freevars dexpr @ List.filter (fun i' -> i' <> i) (freevars body)
  | Id i -> [i]


type environment = (string * value) list

let rec eval (env:environment) (e:expr) : value =
  match e with 
  | Value v -> v
  | Add (e1, e2) -> 
    ( match eval env e1, eval env e2 with
      | Int i1, Int i2 -> Int (i1 + i2)
      | _, _ -> raise (Failure "incompatible type on Add")
    )
  | Sub (e1, e2) -> 
     ( match eval env e1, eval env e2 with
       | Int i1, Int i2 -> Int (i1 - i2)
       | _, _ -> raise (Failure "incompatible type on Sub")
     )
  | Lt (e1, e2) -> 
     ( match eval env e1, eval env e2 with
       | Int i1, Int i2 -> Bool (i1 < i2)
       | _, _ -> raise (Failure "incompatible type on Lt")
     )

let e1 = Add (Value (Int 1), Sub (Value (Int 10), Value (Int 3)))

