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
  | Ref of expr

and environment
  = (string * value) list
  (* You may need an extra constructor for this type. *)


let rec is_elem (v:'a) (y:'a list): bool =
  match y with
  | [] -> false
  | x::xs -> if x = v then true else is_elem v xs


let freevars (e:expr): string list =
  let rec freevars' (e:expr) (env:string list): string list =
    match e with
    | Add (a, b) -> freevars' a env @ freevars' b env
    | Sub (a, b) -> freevars' a env @ freevars' b env
    | Mul (a, b) -> freevars' a env @ freevars' b env
    | Div (a, b) -> freevars' a env @ freevars' b env

    | Lt (a, b) -> freevars' a env @ freevars' b env
    | Eq (a, b) -> freevars' a env @ freevars' b env
    | And (a, b) -> freevars' a env @ freevars' b env
    
    | If (a, b, c) -> freevars' a env @ freevars' b env @ freevars' c env

    | Let (key, value, expr) -> freevars' value env @ freevars' expr (key :: env)
    | LetRec (key, value, expr) -> freevars' value (key :: env) @ freevars' expr (key :: env)

    | App (a, b) -> freevars' a env @ freevars' b env
    | Lambda (var, expr) -> freevars' expr (var :: env)
    | Value v -> []

    | Id id -> if is_elem id env then [] else [id]
  in freevars' e []


let sumToN_expr: expr =
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

let rec getkey (key:string) (dict:environment): value =
  match dict with
  | [] -> raise (Failure ("key " ^ key ^ " not found"))
  | (a, b)::xs -> if key = a then b else getkey key xs

(* let print_env (env:environment) =
  match env with
  | [] -> print_string ""
  | (a, b)::xs -> print_string (a ^ ": " ^ (match b with Int x -> string_of_int x | Bool x -> if x then "true" else "false" | Ref v -> "ref" | Closure (a, b, c) -> "lambda " ^ a) ^ ",") *)

let rec evaluate' (e:expr) (env:environment): value =
  match e with
  | Value v -> v
  | Id x -> getkey x env

  | Add (a, b) -> (match (evaluate' a env, evaluate' b env) with
      | (Int c, Int d) -> Int (c + d)
      | _ -> raise (Failure "bad +")
    )
  | Sub (a, b) -> (match (evaluate' a env, evaluate' b env) with
      | (Int c, Int d) -> Int (c - d)
      | _ -> raise (Failure "bad -")
    )
  | Mul (a, b) -> (match (evaluate' a env, evaluate' b env) with
      | (Int c, Int d) -> Int (c * d)
      | _ -> raise (Failure "bad *")
    )
  | Div (a, b) -> (match (evaluate' a env, evaluate' b env) with
      | (Int c, Int d) -> Int (c / d)
      | _ -> raise (Failure "bad /")
    )

  | Eq (a, b) -> Bool (evaluate' a env = evaluate' b env)
  | Lt (a, b) -> Bool (evaluate' a env < evaluate' b env)
  | And (a, b) -> (match (evaluate' a env, evaluate' b env) with
      | (Bool c, Bool d) -> Bool (c && d)
      | _ -> raise (Failure "bad bool")
    )

  | If (a, b, c) -> (match evaluate' a env with
      | Bool true -> evaluate' b env
      | Bool false -> evaluate' c env
      | _ -> raise (Failure "bad bool")
    )

  | Let (a, b, c) -> evaluate' c ((a, evaluate' b env) :: env)
  | LetRec (a, b, c) -> evaluate' c ((a, evaluate' b ((a, Ref b) :: env)) :: env)

  | Lambda (a, b) -> Closure (a, b, env)
  | App (a, b) -> (match evaluate' a env with
      | Ref f -> evaluate' (App (f, b)) env
      | Closure (c, d, e) -> evaluate' d ((c, evaluate' b env) :: e)
      | _ -> raise (Failure "?")
    )
  
let evaluate (e:expr): value = evaluate' e []


let inc = Lambda ("n", Add(Id "n", Value (Int 1)))
let add = Lambda ("x", Lambda ("y", Add (Id "x", Id "y")))

(* let twenty_one : value = evaluate (App (sumToN_expr, Value (Int 6))); *)
