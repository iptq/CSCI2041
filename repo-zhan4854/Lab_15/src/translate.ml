open Common

let fold_helper : Tgt_lang.func =
  ( "fold_helper"
  , [ ("f", Tgt_lang.FuncType ([Tgt_lang.IntType; Tgt_lang.IntType], Tgt_lang.IntType))
    ; ("arr", Tgt_lang.ArrayType)
    ; ("start", Tgt_lang.IntType)
    ; ("end", Tgt_lang.IntType)
    ]
  , Tgt_lang.IntType
  , Tgt_lang.Block (
      [ Tgt_lang.Decl
          ( "out"
          , Tgt_lang.ArrayType
          , Tgt_lang.Array [Tgt_lang.Int 0]
          )

      (* Add the remainder of this function below. Now this
         function just returns 0. *)



      ],
      (* Below is the value to return, out[0]. *)
      Tgt_lang.ArrayGet
        ( Tgt_lang.Var "out"
        , Tgt_lang.Int 0
        ))
  )

let rec translate (src: Src_lang.program) : Tgt_lang.program =
  let (funcs, init) = src
  in let (env, funcs) = translate_funcs
         [("fold_helper", Src_lang.FuncType
             ([ Src_lang.FuncType
                  ([ Src_lang.IntType
                   ; Src_lang.IntType
                   ], Src_lang.IntType)
              ; Src_lang.ArrayType
              ; Src_lang.IntType
              ; Src_lang.IntType
              ], Src_lang.IntType))]
         funcs
  in let init = translate_expr env init
  in (fold_helper :: funcs, init)

and translate_expr (env: Src_lang.typ_ env) (expr: Src_lang.expr) : Tgt_lang.expr =
  match expr with
  | Src_lang.Array arr -> Tgt_lang.Array (List.map (translate_expr env) arr)

  | Src_lang.BinOp (op, l, r) ->
    Tgt_lang.BinOp
      ( op
      , translate_expr env l
      , translate_expr env r
      )
  | Src_lang.Bool b -> Tgt_lang.Int (if b then 1 else 0)
  | Src_lang.Call (name, args) -> Tgt_lang.Call (name, List.map (translate_expr env) args)

  | Src_lang.MapSeq (func, arr) ->
    let arr' = translate_expr env arr
    and arr_type = Src_lang.type_of env arr
    and func' = translate_expr env (Src_lang.Var func)
    and func_type = Src_lang.type_of env (Src_lang.Var func)
    in if func_type <> Src_lang.FuncType ([Src_lang.IntType], Src_lang.IntType)
    then raise (Tgt_lang.ExprTypeError
                  ( func'
                  , translate_type func_type
                  , Tgt_lang.FuncType ([Tgt_lang.IntType], Tgt_lang.IntType)))
    else if arr_type <> Src_lang.ArrayType
    then raise (Tgt_lang.ExprTypeError (arr', translate_type arr_type, Tgt_lang.ArrayType))
    else
      let array = Tgt_lang.Var "_map_array"
      and index = Tgt_lang.Var "_map_index"
      in Tgt_lang.Block (
        [ Tgt_lang.Decl ("_map_array", Tgt_lang.ArrayType, arr')
        ; Tgt_lang.For ("_map_index", Tgt_lang.Int 0, Tgt_lang.ArraySize array,
                        [ Tgt_lang.ArraySet
                            ( array
                            , index
                            , Tgt_lang.Call
                                ( func   (* this is and should be func, no need to translate strings *)
                                , [ Tgt_lang.ArrayGet (array, index)
                                  ]
                                )
                            )
                        ])
        ], Tgt_lang.Var "_map_array")

  | Src_lang.Map (func, arr) ->
    let arr' = translate_expr env arr
    and arr_type = Src_lang.type_of env arr
    and func' = translate_expr env (Src_lang.Var func)
    and func_type = Src_lang.type_of env (Src_lang.Var func)
    in if func_type <> Src_lang.FuncType ([Src_lang.IntType], Src_lang.IntType)
    then raise (Tgt_lang.ExprTypeError
                  ( func'
                  , translate_type func_type
                  , Tgt_lang.FuncType ([Tgt_lang.IntType], Tgt_lang.IntType)))
    else if arr_type <> Src_lang.ArrayType
    then raise (Tgt_lang.ExprTypeError (arr', translate_type arr_type, Tgt_lang.ArrayType))
    else
      let array = Tgt_lang.Var "_map_array"
      and index = Tgt_lang.Var "_map_index"
      in
      (*raise (Failure "Implement Src_lang.Map in translate_expr!")*)
      (* Write the solution for Map here.  Then remove the above exception. *)
      Tgt_lang.Block ([
          Tgt_lang.Decl ("_map_array", Tgt_lang.ArrayType, arr');
          Tgt_lang.For("_map_index", Tgt_lang.Int 0, Tgt_lang.ArraySize array, [
              Tgt_lang.ArraySet (array, index, Tgt_lang.Spawn (Tgt_lang.Call (func, [
                  Tgt_lang.ArrayGet (array, index)
                ])))
            ]);
          Tgt_lang.Sync], Tgt_lang.Var "_map_array")

  | Src_lang.Fold (func, arr) ->
    let arr' = translate_expr env arr
    and arr_type = Src_lang.type_of env arr
    and func' = translate_expr env (Src_lang.Var func)
    and func_type = Src_lang.type_of env (Src_lang.Var func)
    in if func_type <> Src_lang.FuncType ([Src_lang.IntType; Src_lang.IntType], Src_lang.IntType)
    then raise (Tgt_lang.ExprTypeError
                  ( func'
                  , translate_type func_type
                  , Tgt_lang.FuncType ([Tgt_lang.IntType; Tgt_lang.IntType], Tgt_lang.IntType)))
    else if arr_type <> Src_lang.ArrayType
    then raise (Tgt_lang.ExprTypeError (arr', translate_type arr_type, Tgt_lang.ArrayType))
    else Tgt_lang.Call ("fold_helper",
                        [ func'
                        ; arr'
                        ; Tgt_lang.Int 0
                        ; Tgt_lang.ArraySize arr'
                        ])

  | Src_lang.If (c, t, e) ->
    let c_type = Src_lang.type_of env c
    and t_type = Src_lang.type_of env t
    and e_type = Src_lang.type_of env e
    in if c_type <> Src_lang.BoolType
    then raise (Src_lang.TypeError (c, c_type, Src_lang.BoolType))
    else if t_type <> e_type
    then raise (Src_lang.TypeError (Src_lang.If (c, t, e), t_type, e_type))
    else let c' = translate_expr env c
      and t' = translate_expr env t
      and e' = translate_expr env e
      in Tgt_lang.IfExpr (c', t', e')

  | Src_lang.Int i -> Tgt_lang.Int i

  | Src_lang.Let (name, value, body) ->
    let typ_ = Src_lang.type_of env value
    in let decl = Tgt_lang.Decl (name, translate_type typ_, translate_expr env value)
    and env' = env_put env name typ_
    in Tgt_lang.Block ([decl], translate_expr env' body)

  | Src_lang.Not expr -> Tgt_lang.Not (translate_expr env expr)
  | Src_lang.Var name -> Tgt_lang.Var name

and translate_func (env: Src_lang.typ_ env) (func: Src_lang.func) : Tgt_lang.func =
  let (name, params, body) = func
  in let translate_env (name, typ_) = (name, translate_type typ_)
  in let func_type = Src_lang.type_of_func env func
  in let env' = List.map translate_env ((name, func_type) :: params @ env)
  and params' = List.map translate_env params
  and body' = translate_expr ((name, func_type) :: params @ env) body
  in let typ_ = Tgt_lang.type_of_expr env' body'
  in (name, params', typ_, body')

and translate_funcs (env: Src_lang.typ_ env) (funcs: Src_lang.func list) : Src_lang.typ_ env * Tgt_lang.func list =
  match funcs with
  | []   -> (env_empty, [])
  | h::t ->
    let func = translate_func env h
    and typ_ = Src_lang.type_of_func env h
    and (name, _, _) = h
    in let (rest_env, rest_funcs) = translate_funcs (env_put env name typ_) t
    in (env_put rest_env name typ_, func :: rest_funcs)

and translate_type : Src_lang.typ_ -> Tgt_lang.typ_ = function
  | Src_lang.ArrayType -> Tgt_lang.ArrayType
  | Src_lang.BoolType -> Tgt_lang.BoolType
  | Src_lang.FuncType (params, return) ->
    let params' = List.map translate_type params
    and return' = translate_type return
    in Tgt_lang.FuncType (params', return')
  | Src_lang.IntType -> Tgt_lang.IntType
