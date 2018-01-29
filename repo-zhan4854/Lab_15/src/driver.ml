open Common
open Lexing
open Translate

let parse_file (filename: string) : Src_lang.program =
  try
    Parser.program Lexer.src_lang (Lexing.from_channel (open_in filename))
  with
  | Parsing.Parse_error -> failwith
                             ( String.concat ""
                                 [ "Parse error on line "
                                 ; string_of_int (Parsing.symbol_start_pos ()).pos_lnum
                                 ; "..."
                                 ]
                             )

let compile (src: Src_lang.program) : string =
  try
    let tgt = translate src
    in Tgt_lang.type_check_program env_empty tgt;
    String.concat ""
      [ "/* Source program:\n"
      ; Src_lang.string_of_program src
      ; "\n*/\n\n"
      ; Tgt_lang.string_of_program tgt
      ]
  with
  | Src_lang.TypeError (expr, got, wanted) ->
    Printexc.print_backtrace stderr;
    failwith (String.concat ""
                [ "In source language: Type error in `"
                ; Src_lang.string_of_expr expr
                ; "': got type `"
                ; Src_lang.string_of_type got
                ; "', wanted type `"
                ; Src_lang.string_of_type wanted
                ; "'."
                ])
  | Src_lang.UndefinedVar name ->
    Printexc.print_backtrace stderr;
    failwith (String.concat ""
                [ "In source language: Undefined variable `"
                ; name
                ; "'."
                ])
  | Tgt_lang.CallTypeError (expr, got, wanted) ->
    Printexc.print_backtrace stderr;
    failwith (String.concat ""
                [ "In target language: Type error in arguments in expression `"
                ; Tgt_lang.string_of_expr expr
                ; "': got types `"
                ; String.concat ", " (List.map Tgt_lang.string_of_type got)
                ; "', wanted types `"
                ; String.concat ", " (List.map Tgt_lang.string_of_type wanted)
                ; "'."
                ])
  | Tgt_lang.ExprTypeError (expr, got, wanted) ->
    Printexc.print_backtrace stderr;
    failwith (String.concat ""
                [ "In target language: Type error in expression `"
                ; Tgt_lang.string_of_expr expr
                ; "': got type `"
                ; Tgt_lang.string_of_type got
                ; "', wanted type `"
                ; Tgt_lang.string_of_type wanted
                ; "'."
                ])
  | Tgt_lang.StmtTypeError (stmt, expr, got, wanted) ->
    Printexc.print_backtrace stderr;
    failwith (String.concat ""
                [ "In target language: Type error in expression `"
                ; Tgt_lang.string_of_expr expr
                ; "' in statement `"
                ; Tgt_lang.string_of_stmt stmt
                ; "': got type `"
                ; Tgt_lang.string_of_type got
                ; "', wanted type `"
                ; Tgt_lang.string_of_type wanted
                ; "'."
                ])
  | Tgt_lang.InitReturn typ_ ->
    Printexc.print_backtrace stderr;
    failwith (String.concat ""
                [ "In target language: init returns `"
                ; Tgt_lang.string_of_type typ_
                ; "', wanted type `"
                ; Tgt_lang.string_of_type Tgt_lang.IntType
                ; "'."
                ])
  | Tgt_lang.NotAFunction (expr, name) ->
    Printexc.print_backtrace stderr;
    failwith (String.concat ""
                [ "In target language: `"
                ; name
                ; "' in expression `"
                ; Tgt_lang.string_of_expr expr
                ; "' is not a function."
                ])
  | Tgt_lang.UndefinedFunc (expr, name) ->
    Printexc.print_backtrace stderr;
    failwith (String.concat ""
                [ "In target language: Undefined function `"
                ; name
                ; "' in expression `"
                ; Tgt_lang.string_of_expr expr
                ; "'."
                ])
  | Tgt_lang.UndefinedVar name ->
    Printexc.print_backtrace stderr;
    failwith (String.concat ""
                [ "In target language: Undefined variable `"
                ; name
                ; "'."
                ])
  | Match_failure (file, line, column) ->
    Printexc.print_backtrace stderr;
    failwith (String.concat ""
                [ "Match failure at "
                ; file
                ; ", line "
                ; string_of_int line
                ; ", column "
                ; string_of_int column
                ; "."
                ])
  | err -> Printexc.print_backtrace stderr; raise err
