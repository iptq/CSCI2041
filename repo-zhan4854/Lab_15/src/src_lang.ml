open Common

type program = func list * expr
and func = string * (string * typ_) list * expr
and expr = Array of expr list
         | BinOp of binop * expr * expr
         | Bool of bool
         | Call of string * expr list
         | Fold of string * expr
         | If of expr * expr * expr
         | Int of int
         | Let of string * expr * expr
         | Map of string * expr
         | MapSeq of string * expr
         | Not of expr
         | Var of string
and typ_ = ArrayType
         | BoolType
         | FuncType of typ_ list * typ_
         | IntType
exception NotAFunction of string
exception TypeError of expr * typ_ * typ_
exception UndefinedFunction of string
exception UndefinedVar of string

let rec type_assert (env: typ_ env) (wanted_type: typ_) (expr: expr) =
  let got_type = type_of env expr
  in if got_type <> wanted_type
  then raise (TypeError (expr, got_type, wanted_type))

and type_of (env: typ_ env) (expr: expr) : typ_ =
  match expr with
  | Array arr ->
    ignore (List.map (type_assert env IntType) arr);
    ArrayType
  | BinOp (op, l, r) ->
    let (in_ty, out_ty) = match binop_kind op with
      | Arithmetic -> (IntType, IntType)
      | Relational -> (IntType, BoolType)
      | Logical -> (BoolType, BoolType)
    in
    type_assert env in_ty l;
    type_assert env in_ty r;
    out_ty
  | Bool _ -> BoolType
  | Call (name, args) ->
    let arg_types = List.map (type_of env) args
    in (match env_get env name with
        | Some (FuncType (params, return)) ->
          if arg_types <> params
          then raise (TypeError (Var name, FuncType (params, return), return))
          else return
        | Some _ -> raise (NotAFunction name)
        | None -> raise (UndefinedFunction name))
  | Fold (func, arr) ->
    type_assert env (FuncType ([IntType; IntType], IntType)) (Var func);
    type_assert env ArrayType arr;
    IntType
  | If (c, t, e) ->
    type_assert env BoolType c;
    let t_ty = type_of env t in
    let e_ty = type_of env e in
    if t_ty = e_ty
    then t_ty
    else raise (TypeError (expr, e_ty, t_ty))
  | Int _ -> IntType
  | Let (k, v, b) ->
    let v_type = type_of env v
    in let env' = env_put env k v_type
    in type_of env' b
  | Map (func, arr) ->
    type_assert env (FuncType ([IntType], IntType)) (Var func);
    type_of env arr
  | MapSeq (func, arr) ->
    type_assert env (FuncType ([IntType], IntType)) (Var func);
    type_of env arr
  | Not expr ->
    type_assert env BoolType expr;
    BoolType
  | Var name ->
    (match env_get env name with
     | Some typ -> typ
     | None -> raise (UndefinedVar name))

and type_of_func (env: typ_ env) ((name, params, body): func) : typ_ =
  let param_types = List.map snd params
  in let ty = FuncType (List.map snd params, IntType)
  in let return_type = type_of ((name, ty) :: params @ env) body
  in FuncType (param_types, return_type)

let rec string_of_expr : expr -> string = function
  | Array arr ->
    let vals = List.map string_of_expr arr
    in "[" ^ String.concat ", " vals ^ "]"
  | BinOp (op, l, r) ->
    String.concat ""
      [ "("
      ; string_of_expr l
      ; " "
      ; string_of_binop op
      ; " "
      ; string_of_expr r
      ; ")"
      ]
  | Bool b ->
    if b
    then "true"
    else "false"
  | Call (name, args) ->
    String.concat ""
      [ name
      ; "("
      ; String.concat ", " (List.map string_of_expr args)
      ; ")"
      ]
  | Fold (func, arr) ->
    String.concat ""
      [ "fold("
      ; func
      ; ", "
      ; string_of_expr arr
      ; ")"
      ]
  | If (c, t, e) ->
    String.concat " "
      [ "if"
      ; string_of_expr c
      ; "then"
      ; string_of_expr t
      ; "else"
      ; string_of_expr e
      ; "end"
      ]
  | Int i -> string_of_int i
  | Let (k, v, b) ->
    String.concat " "
      [ "let"
      ; k
      ; "="
      ; string_of_expr v
      ; "in"
      ; string_of_expr b
      ]
  | Map (func, arr) ->
    String.concat ""
      [ "map("
      ; func
      ; ", "
      ; string_of_expr arr
      ; ")"
      ]
  | MapSeq (func, arr) ->
    String.concat ""
      [ "mapseq("
      ; func
      ; ", "
      ; string_of_expr arr
      ; ")"
      ]
  | Not expr -> "!" ^ string_of_expr expr
  | Var name -> name

and string_of_func (func: func) : string =
  let (name, args, body) = func
  and arg_helper (name, typ_) = name ^ " : " ^ string_of_type typ_
  in let args = String.concat ", " (List.map arg_helper args)
  in String.concat ""
    [ "function "
    ; name
    ; "("
    ; args
    ; ") =\n\t"
    ; string_of_expr body
    ]

and string_of_program (program: program) : string =
  let (funcs, init) = program
  in let funcs = List.map string_of_func funcs
  and init = string_of_expr init
  in String.concat ";\n" (funcs @ [init])

and string_of_type : typ_ -> string = function
  | ArrayType -> "int[]"
  | BoolType -> "bool"
  | FuncType (params, return) ->
    let params = String.concat ", " (List.map string_of_type params)
    and return = string_of_type return
    in "(" ^ params ^ ") -> " ^ return
  | IntType -> "int"
