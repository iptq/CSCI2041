{

open Parser

let line_num = ref 1
exception Syntax_error of string
let syntax_error msg =
    raise (Syntax_error (msg ^ " on line " ^ string_of_int !line_num))

}

let blank = [' ' '\r' '\t']
let digit = ['0'-'9']
let digits = digit*
let alpha = ['a'-'z' 'A'-'Z']
let ident = alpha (alpha | digit | '_')*

rule src_lang = parse
    | ","  { COMMA }
    | ":"  { COLON }
    | ";"  { SEMICOLON }
    | "+"  { OP_ADD }
    | "-"  { OP_SUB }
    | "*"  { OP_MUL }
    | "/"  { OP_DIV }
    | "%"  { OP_MOD }
    | "==" { OP_EQ }
    | "!=" { OP_NEQ }
    | "<"  { OP_LT }
    | "<=" { OP_LTE }
    | ">"  { OP_GT }
    | ">=" { OP_GTE }
    | "!"  { OP_NOT }
    | "&&" { OP_AND }
    | "||" { OP_OR }
    | "="  { EQUALS }
    | "("  { PAREN_OPEN }
    | ")"  { PAREN_CLOSE }
    | "["  { ARRAY_OPEN }
    | "]"  { ARRAY_CLOSE }
    | "let"      { LET }
    | "in"       { IN }
    | "if"       { IF }
    | "then"     { THEN }
    | "else"     { ELSE }
    | "end"      { END }
    | "function" { FUNCTION }
    | "int"      { INT }
    | "->"       { ARROW }
    | "map"      { MAP }
    | "mapseq"   { MAPSEQ }
    | "fold"     { FOLD }
    | ident as name { IDENTIFIER name }
    | digits as num { LITERAL (int_of_string num) }
    | '\n'  { incr line_num; src_lang lexbuf }
    | blank { src_lang lexbuf }
    | _     { syntax_error "unknown token" }
    | eof   { EOF }
