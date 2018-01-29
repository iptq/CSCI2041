
type expr 
  = Const of int
  | Add of  expr * expr
  | Mul of expr * expr
  | Sub of expr * expr
  | Div of expr * expr

let rec show_expr (e:expr): string =
  match e with
  | Const i -> string_of_int i
  | Add (a, b) -> "(" ^ (show_expr a) ^ "+" ^ (show_expr b) ^ ")"
  | Mul (a, b) -> "(" ^ (show_expr a) ^ "*" ^ (show_expr b) ^ ")"
  | Sub (a, b) -> "(" ^ (show_expr a) ^ "-" ^ (show_expr b) ^ ")"
  | Div (a, b) -> "(" ^ (show_expr a) ^ "/" ^ (show_expr b) ^ ")"

let rec show_pretty_expr (e:expr): string =
  let add_sub_left (e:expr): bool =
    match e with
      | Const i -> false
      | Add (a, b) -> false
      | Sub (a, b) -> false
      | Mul (a, b) -> false
      | Div (a, b) -> false in
  let mul_div_left (e:expr): bool =
    match e with
      | Const i -> false
      | Add (a, b) -> true
      | Sub (a, b) -> true
      | Mul (a, b) -> false
      | Div (a, b) -> false in
  let needs_paren_left (e:expr): bool =
    match e with
    | Const i -> raise (Failure "This shouldn't be called here.")
    | Add (a, b) -> add_sub_left a
    | Sub (a, b) -> add_sub_left a
    | Mul (a, b) -> mul_div_left a
    | Div (a, b) -> mul_div_left a in
  let add_sub_right (add:bool) (e:expr): bool =
    match e with
      | Const i -> false
      | Add (a, b) -> add
      | Sub (a, b) -> true
      | Mul (a, b) -> false
      | Div (a, b) -> false in
  let mul_div_right (mul:bool) (e:expr): bool =
    match e with
      | Const i -> false
      | Add (a, b) -> true
      | Sub (a, b) -> true
      | Mul (a, b) -> mul
      | Div (a, b) -> true in
  let needs_paren_right (e:expr): bool =
    match e with
    | Const i -> raise (Failure "This shouldn't be called here.")
    | Add (a, b) -> add_sub_right true b
    | Sub (a, b) -> add_sub_right false b
    | Mul (a, b) -> mul_div_right true b
    | Div (a, b) -> mul_div_right false b in
  let wrap (b:bool) (s:bytes): bytes =
    (if b then "(" else "") ^ s ^ (if b then ")" else "") in
  match e with
  | Const i -> string_of_int i
  | Add (a, b) -> wrap (needs_paren_left e) (show_pretty_expr a) ^ "+" ^ wrap (needs_paren_right e) (show_pretty_expr b)
  | Sub (a, b) -> wrap (needs_paren_left e) (show_pretty_expr a) ^ "-" ^ wrap (needs_paren_right e) (show_pretty_expr b)
  | Mul (a, b) -> wrap (needs_paren_left e) (show_pretty_expr a) ^ "*" ^ wrap (needs_paren_right e) (show_pretty_expr b)
  | Div (a, b) -> wrap (needs_paren_left e) (show_pretty_expr a) ^ "/" ^ wrap (needs_paren_right e) (show_pretty_expr b)

