type binop = Add | Sub | Mul | Div | Mod
           | Eq | Neq | Lt | Lte | Gt | Gte
           | And | Or
type opkind = Arithmetic | Logical | Relational

let string_of_binop : binop -> string = function
  | Add -> "+"
  | Sub -> "-"
  | Mul -> "*"
  | Div -> "/"
  | Mod -> "%"
  | Eq  -> "=="
  | Neq -> "!="
  | Lt  -> "<"
  | Lte -> "<="
  | Gt  -> ">"
  | Gte -> ">="
  | And -> "&&"
  | Or  -> "||"
let binop_kind : binop -> opkind = function
  | Add | Sub | Mul | Div | Mod -> Arithmetic
  | Eq  | Neq | Lt  | Lte | Gt  | Gte -> Relational
  | And | Or -> Logical

type 'a env = (string * 'a) list

let env_empty : 'a env = []

let rec env_get (m: 'a env) (key: string) : 'a option =
  match m with
  | []         -> None
  | (k, v)::m' -> if key = k then Some v else env_get m' key

let env_put (m: 'a env) (key: string) (value: 'a) : 'a env =
  (key, value) :: m
