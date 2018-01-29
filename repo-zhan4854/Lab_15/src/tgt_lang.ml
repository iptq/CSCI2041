open Common

type program = func list * expr
and func = string * (string * typ_) list * typ_ * expr
and expr = Array of expr list
         | ArrayGet of expr * expr
         | ArraySize of expr
         | Bool of bool
         | BinOp of binop * expr * expr
         | Block of stmt list * expr
         | Call of string * expr list
         | Equals of expr * expr
         | IfExpr of expr * expr * expr
         | Int of int
         | Not of expr
         | Spawn of expr
         | Var of string
and stmt = ArraySet of expr * expr * expr
         | Decl of string * typ_ * expr
         | Expr of expr
         | FuncDecl of func
         | For of string * expr * expr * stmt list
         | IfStmt of expr * stmt list * stmt list
         | Sleep of float
         | Sync
and typ_ = ArrayType
         | BoolType
         | FuncType of typ_ list * typ_
         | IntType

exception CallTypeError of expr * typ_ list * typ_ list
exception ExprTypeError of expr * typ_ * typ_
exception StmtTypeError of stmt * expr * typ_ * typ_
exception InitReturn of typ_
exception NotAFunction of expr * string
exception UndefinedFunc of expr * string
exception UndefinedVar of string

let rec find (pred: 'a -> bool) : 'a list -> 'a option = function
  | []   -> None
  | h::t -> if pred h
    then Some h
    else find pred t

let rec type_assert (env: typ_ env) (wanted_type: typ_) (expr: expr) : unit =
  let got_type = type_of_expr env expr
  in if got_type <> wanted_type
  then raise (ExprTypeError (expr, got_type, wanted_type))

and type_check_program (env: typ_ env) (program: program) : unit =
  let (funcs, init) = program
  in match funcs with
  | [] ->
    let init_type = type_of_expr env init
    in (match init_type with
        | FuncType _ -> raise (InitReturn init_type)
        | _ -> ())
  | h::t ->
    let (name, _, _, _) = h
    and typ_ = type_of_func env h
    in let env' = env_put env name typ_
    in type_check_program env' (t, init)

and type_check_stmt (env: typ_ env) (stmt: stmt) : (string * typ_) option =
  match stmt with
  | ArraySet (arr, index, value) ->
    type_assert env ArrayType arr;
    type_assert env IntType index;
    type_assert env IntType value;
    None
  | Decl (name, typ_, expr) ->
    type_assert env typ_ expr;
    Some (name, type_of_expr env expr)
  | Expr e ->
    ignore (type_of_expr env e);
    None
  | For (idx_name, start, end_, body) ->
    let env' = env_put env idx_name IntType
    in ignore (List.map (type_check_stmt env') body);
    None
  | FuncDecl func ->
    let (name, params, return, expr) = func
    in let typ_ = FuncType (List.map snd params, return)
    in let env' = env_put env name typ_
    in type_assert env' return expr;
    Some (name, type_of_func env' func)
  | IfStmt (c, t, e) ->
    type_assert env BoolType c;
    ignore (type_of_block env t (Int 0));
    ignore (type_of_block env e (Int 0));
    None
  | Sleep _ | Sync -> None

and type_of_block (env: typ_ env) (stmts: stmt list) (expr: expr) : typ_ =
  match stmts with
  | []   -> type_of_expr env expr
  | h::t ->
    let env' = match type_check_stmt env h with
      | Some (name, typ_) -> env_put env name typ_
      | None              -> env
    in type_of_block env' t expr

and type_of_expr (env: typ_ env) (expr: expr) : typ_ =
  match expr with
  | Array arr ->
    ignore (List.map (type_assert env IntType) arr);
    ArrayType
  | ArrayGet (arr, idx) ->
    type_assert env ArrayType arr;
    type_assert env IntType idx;
    IntType
  | ArraySize arr ->
    type_assert env ArrayType arr;
    IntType
  | Bool _ -> BoolType
  | BinOp (op, l, r) ->
    let (in_ty, out_ty) = match binop_kind op with
      | Arithmetic -> (IntType, IntType)
      | Relational -> (IntType, BoolType)
      | Logical -> (BoolType, BoolType)
    in
    type_assert env in_ty l;
    type_assert env in_ty r;
    out_ty
  | Block (stmts, expr) -> type_of_block env stmts expr
  | Call (func, args) ->
    (match env_get env func with
     | Some (FuncType (params, ret)) ->
       let arg_types = List.map (type_of_expr env) args
       in if arg_types <> params
       then raise (CallTypeError (expr, arg_types, params))
       else ret
     | Some _ -> raise (NotAFunction (expr, func))
     | None -> raise (UndefinedFunc (expr, func)))
  | Equals (l, r) ->
    type_assert env IntType l;
    type_assert env IntType r;
    BoolType
  | IfExpr (c, t, e) ->
    type_assert env BoolType c;
    let t_type = type_of_expr env t
    and e_type = type_of_expr env e
    in if t_type = e_type
    then t_type
    else raise (ExprTypeError (expr, t_type, e_type))
  | Int _ -> IntType
  | Not expr ->
    type_assert env BoolType expr;
    BoolType
  | Spawn expr -> type_of_expr env expr
  | Var name ->
    (match env_get env name with
     | Some typ -> typ
     | None     -> raise (UndefinedVar name))

and type_of_func (env: typ_ env) (func: func) : typ_ =
  let (name, params, return, body) = func
  in let ty = FuncType (List.map snd params, return)
  in let body_type = type_of_expr ((name, ty) :: params @ env) body
  in if return <> body_type
  then raise (ExprTypeError (body, body_type, return))
  else ty

let rec string_of_program (program: program) =
  let (funcs, init) = program
  in let funcs = String.concat "\n" (List.map string_of_func funcs)
  and env = List.fold_left (fun env func ->
      let (name, params, return, _) = func
      in let typ_ = FuncType (List.map snd params, return)
      in env_put env name typ_) env_empty funcs
  in let init_type = type_of_expr env init
  in let init = string_of_func ("init", [], init_type, init)
  in String.concat ""
    ["#include \"runtime.h\"\n\n"
    ; funcs
    ; "\n"
    ; init
    ; "\n\ndeclare_main_returning_"
    ; string_of_type init_type
    ; "()\n"
    ]

and string_of_expr : expr -> string = function
  | Array arr ->
    String.concat ""
      [ "make_array("
      ; string_of_int (List.length arr)
      ; ", "
      ; String.concat ", " (List.map string_of_expr arr)
      ; ")"
      ]
  | ArrayGet (arr, idx) ->
    String.concat ""
      [ string_of_expr arr
      ; ".data["
      ; string_of_expr idx
      ; "]"
      ]
  | ArraySize arr ->
    String.concat ""
      [ string_of_expr arr
      ; ".size"
      ]
  | BinOp (op, l, r) ->
    let inner = String.concat " "
        [ string_of_expr l
        ; string_of_binop op
        ; string_of_expr r
        ]
    in "(" ^ inner ^ ")"
  | Bool true -> "true"
  | Bool false -> "false"
  | Block (stmts, expr) ->
    String.concat ""
      [ "({\n"
      ; String.concat "\n" (List.map string_of_stmt stmts)
      ; "\n"
      ; string_of_expr expr
      ; ";\n})"
      ]
  | Call (func, args) ->
    String.concat ""
      [ func
      ; "("
      ; String.concat ", " (List.map string_of_expr args)
      ; ")"
      ]
  | Equals (a, b) -> string_of_expr a ^ " == " ^ string_of_expr b
  | IfExpr (c, t, e) ->
    String.concat ""
      [ string_of_expr c
      ; " ? "
      ; string_of_expr t
      ; " : "
      ; string_of_expr e
      ]
  | Int i -> string_of_int i
  | Not expr -> "!" ^ string_of_expr expr
  | Spawn expr -> "spawn " ^ string_of_expr expr
  | Var name -> name

and string_of_func (func: func) : string =
  let (name, params, return_type, body) = func
  in let string_of_param (name, typ_) = string_of_type_decl name typ_
  in let params = List.map string_of_param params
  and func_body = match body with
    | Block (stmts, expr) ->
      let stmts = String.concat "\n" (List.map string_of_stmt stmts)
      and expr = "return " ^ string_of_expr expr ^ ";"
      in stmts ^ "\n" ^ expr
    | _ -> "return " ^ string_of_expr body ^ ";"
  in let func_name = name ^ "(" ^ String.concat ", " params ^ ")"
  in String.concat ""
    [ string_of_type_decl func_name return_type
    ; " {\n"
    ; func_body
    ; "\n}\n"
    ]

and string_of_stmt : stmt -> string = function
  | ArraySet (arr, idx, value) ->
    String.concat ""
      [ string_of_expr arr
      ; ".data["
      ; string_of_expr idx
      ; "] = "
      ; string_of_expr value
      ; ";"
      ]
  | Decl (name, typ_, value) ->
    String.concat ""
      [ string_of_type_decl name typ_
      ; " = "
      ; string_of_expr value
      ; ";"
      ]
  | Expr e -> string_of_expr e ^ ";"
  | For (idx_name, start, end_, body) ->
    let body' = String.concat "\n" (List.map string_of_stmt body)
    in String.concat ""
      [ "for(int "
      ; idx_name
      ; " = "
      ; string_of_expr start
      ; "; "
      ; idx_name
      ; " < "
      ; string_of_expr end_
      ; "; "
      ; idx_name
      ; "++) {\n"
      ; body'
      ; "}\n"
      ]
  | FuncDecl func -> string_of_func func
  | IfStmt (c, t, e) ->
    let t' = String.concat "\n" (List.map string_of_stmt t)
    and e' = String.concat "\n" (List.map string_of_stmt e)
    in String.concat ""
      [ "if("
      ; string_of_expr c
      ; ") {\n"
      ; t'
      ; "} else {\n"
      ; e'
      ; "}\n"
      ]
  | Sleep time ->
    String.concat ""
      [ "usleep("
      ; string_of_int (truncate (time *. 1_000_000.))
      ; ");"
      ]
  | Sync -> "sync;"

and string_of_type : typ_ -> string = function
  | ArrayType -> "array"
  | BoolType -> "bool"
  | FuncType (params, return) ->
    String.concat ""
      [ string_of_type return
      ; "(*)("
      ; String.concat ", " (List.map string_of_type params)
      ; ")"
      ]
  | IntType -> "int"

and string_of_type_decl (name: string) : typ_ -> string = function
  | ArrayType -> "array " ^ name
  | BoolType -> "bool " ^ name
  | FuncType (params, return) ->
    String.concat ""
      [ string_of_type return
      ; "(*"
      ; name
      ;")("
      ; String.concat ", " (List.map string_of_type params)
      ; ")"
      ]
  | IntType -> "int " ^ name
