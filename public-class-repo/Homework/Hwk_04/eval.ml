type expr 
  = Add of expr * expr
  | Sub of expr * expr
  | Mul of expr * expr
  | Div of expr * expr
  
  | Lt of expr * expr
  | Eq of expr * expr
  | And of expr * expr

  | If of expr * expr * expr

  | Id of string
  
  | Let of string * expr * expr
  | LetRec of string * expr * expr

  | App of expr * expr
  | Lambda of string * expr

  | Value of value

and value 
  = Int of int
  | Bool of bool
  | Closure of string * expr * environment
  (* You may need an extra constructor for this type. *)




let evaluate (e:expr) : value = 
  raise (Failure "Complete this function...")



(* Some sample expressions *)

let inc = Lambda ("n", Add(Id "n", Value (Int 1)))

let add = Lambda ("x",
                  Lambda ("y", Add (Id "x", Id "y"))
                 )

(* The 'sumToN' function *)
let sumToN_expr : expr =
    LetRec ("sumToN", 
            Lambda ("n", 
                    If (Eq (Id "n", Value (Int 0)),
                        Value (Int 0),
                        Add (Id "n", 
                             App (Id "sumToN", 
                                  Sub (Id "n", Value (Int 1))
                                 )
                            )
                       )
                   ),
            Id "sumToN"
           )


let twenty_one : value = evaluate (App (sumToN_expr, Value (Int 6)));
