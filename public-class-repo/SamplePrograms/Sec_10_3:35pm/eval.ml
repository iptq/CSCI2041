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


(* let inc x = x + 1,    let inc = fun x -> x + 1 *)
let inc:expr = Lambda ("x", Add (Id "x", Value (Int 1)))
(* let add x y = x + y ...
   let add = fun x -> fun y -> x + y  
*)
let add:expr = Lambda ("x", Lambda ("y", Add (Id "x", Id "y")))

let four:expr = App (inc, Value (Int 3))



(* let y = 4  in
    let add4 = fun x -> x + y in
     add4 5

What is the value of add4 in "add4 5"

Closure ("x", ''x + y'', [("y". Int 4)] )

 *)

let rec freevars (e:expr) : string list = 
  match e with
  | Value v -> []
  | Add (e1, e2) -> freevars e1 @ 
                      freevars e2
  | App (f, a) -> freevars f @ freevars a
  | Lambda (i, body) -> 
     List.filter 
       (fun fv -> fv <> i)
       (freevars body)
  | Id i -> [i]
  | Let (i, dexpr, body) ->
     freevars dexpr @
     List.filter 
       (fun fv -> fv <> i)
       (freevars body)

type environment = ( string * value ) list
let rec eval (env:environment) (e:expr) : value =
  match e with
  | Value v -> v 
  | Add (e1, e2) -> 
     ( match eval env e1, eval env e2 with
       | Int i1, Int i2 -> Int (i1 + i2) 
       | _ -> raise (Failure "Incompatible types on Add")
     )
  | Sub (e1, e2) -> 
     ( match eval env e1, eval env e2 with
       | Int i1, Int i2 -> Int (i1 - i2) 
       | _ -> raise (Failure "Incompatible types on Sub")
     )
  | Lt (e1, e2) -> 
     ( match eval env e1, eval env e2 with
       | Int i1, Int i2 -> Bool (i1 < i2) 
       | _ -> raise (Failure "Incompatible types on Lt")
     )

