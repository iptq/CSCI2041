open Common
open Driver
open Src_lang

let () =
  let path = match Array.to_list Sys.argv with
    | [] | [_]  -> "examples/four.src.txt"
    | [_; path] -> path
    | self::_ -> prerr_endline ("\x1b[1;31m" ^ "Usage: " ^ self ^ " [path]\x1b[0m");
      exit (-1)
  in let program = parse_file path in
  prerr_endline ("\x1b[1;34m" ^ string_of_program program ^ "\x1b[0m");
  try
    print_endline (compile program);
    prerr_endline "\x1b[1;32mCompiled!\x1b[0m"
  with
  | Failure err ->
    prerr_endline ("\x1b[1;31m" ^ err ^ "\x1b[0m");
    exit (-1)
