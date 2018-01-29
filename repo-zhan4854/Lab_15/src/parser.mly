%{

open Common
open Src_lang

%}

%token LET IN BOOL FUNCTION INT ARROW
%token IF THEN ELSE END
%token MAP FOLD
%token MAPSEQ
%token <string> IDENTIFIER
%token <int> LITERAL
%token TRUE FALSE
%token COMMA COLON SEMICOLON
%token OP_ADD OP_SUB OP_MUL OP_DIV OP_MOD
%token OP_AND OP_EQ OP_GT OP_GTE OP_LT OP_LTE OP_NEQ OP_NOT OP_OR
%token EQUALS
%token PAREN_OPEN PAREN_CLOSE
%token ARRAY_OPEN ARRAY_CLOSE
%token EOF

%nonassoc IN THEN
%left OP_EQ OP_GT OP_GTE OP_LT OP_LTE OP_NEQ
%left OP_AND OP_OR OP_NOT
%left OP_ADD OP_SUB
%left OP_MUL OP_DIV OP_MOD

%start program
%type <Src_lang.program> program

%%

program:
| function_defs expr EOF { ($1, $2) }

function_defs:
| { [] }
| function_def SEMICOLON function_defs { $1 :: $3 }

function_def:
| FUNCTION IDENTIFIER PAREN_OPEN params PAREN_CLOSE EQUALS expr {
    ($2, $4, $7)
}

params:
| { [] }
| IDENTIFIER COLON typ_ { [($1, $3)] }
| IDENTIFIER COLON typ_ COMMA params { ($1, $3) :: $5 }

types:
| { [] }
| typ_ { [$1] }
| typ_ COMMA types { $1 :: $3 }

typ_:
| BOOL { BoolType }
| INT { IntType }
| INT ARRAY_OPEN ARRAY_CLOSE { ArrayType }
| PAREN_OPEN types PAREN_CLOSE ARROW typ_ { FuncType ($2, $5) }

exprs:
| { [] }
| expr { [$1] }
| expr COMMA exprs { $1 :: $3 }

expr:
| PAREN_OPEN expr PAREN_CLOSE { $2 }
| LET IDENTIFIER EQUALS expr IN expr { Let ($2, $4, $6) }
| IF expr THEN expr ELSE expr END { If ($2, $4, $6) }
| expr OP_ADD expr { BinOp (Add, $1, $3) }
| expr OP_AND expr { BinOp (And, $1, $3) }
| expr OP_DIV expr { BinOp (Div, $1, $3) }
| expr OP_EQ expr  { BinOp (Eq, $1, $3) }
| expr OP_GT expr  { BinOp (Gt, $1, $3) }
| expr OP_GTE expr { BinOp (Gte, $1, $3) }
| expr OP_LT expr  { BinOp (Lt, $1, $3) }
| expr OP_LTE expr { BinOp (Lte, $1, $3) }
| expr OP_MOD expr { BinOp (Mod, $1, $3) }
| expr OP_MUL expr { BinOp (Mul, $1, $3) }
| expr OP_NEQ expr { BinOp (Neq, $1, $3) }
| expr OP_SUB expr { BinOp (Sub, $1, $3) }
| OP_NOT expr { Not $2 }
| FALSE { Bool false }
| TRUE { Bool true }
| LITERAL { Int $1 }
| IDENTIFIER { Var $1 }
| ARRAY_OPEN exprs ARRAY_CLOSE { Array ($2) }
| IDENTIFIER PAREN_OPEN exprs PAREN_CLOSE { Call ($1, $3) }
| FOLD PAREN_OPEN IDENTIFIER COMMA expr PAREN_CLOSE { Fold ($3, $5) }
| MAP PAREN_OPEN IDENTIFIER COMMA expr PAREN_CLOSE { Map ($3, $5) }
| MAPSEQ PAREN_OPEN IDENTIFIER COMMA expr PAREN_CLOSE { MapSeq ($3, $5) }
