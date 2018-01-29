type formula = And of formula * formula
	     | Or  of formula * formula
	     | Not of formula 
	     | Prop of string
	     | True
	     | False

exception KeepLooking

type subst = (string * bool) list

let show_list show l =
  let rec sl l =
    match l with 
    | [] -> ""
    | [x] -> show x
    | x::xs -> show x ^ "; " ^ sl xs
  in "[ " ^ sl l ^ " ]"

let show_string_bool_pair (s,b) =
  "(\"" ^ s ^ "\"," ^ (if b then "true" else "false") ^ ")"

let show_subst = show_list show_string_bool_pair

let is_elem v l =
  List.fold_right (fun x in_rest -> if x = v then true else in_rest) l false

let rec explode = function
  | "" -> []
  | s  -> String.get s 0 :: explode (String.sub s 1 ((String.length s) - 1))

let dedup lst =
  let f elem to_keep =
    if is_elem elem to_keep then to_keep else elem::to_keep
  in List.fold_right f lst []




(* ACTUAL CODE START HERE *)

let rec lookup (s:string) (a:subst): bool =
  match a with
  | [] -> raise (Failure ("Prop " ^ s ^ " not found."))
  | (a, b)::xs -> if a = s then b else (lookup s xs)

let rec eval (f:formula) (s:subst): bool =
  match f with
  | And (a, b) -> (eval a s) && (eval b s)
  | Or (a, b) -> (eval a s) || (eval b s)
  | Not a -> not (eval a s)
  | Prop a -> lookup a s
  | True -> true
  | False -> false

let freevars (f:formula): string list =
  let rec freevars' (f:formula) (s:string list): string list =
    match f with
    | And (a, b) -> (freevars' a s) @ (freevars' b s)
    | Or (a, b) -> (freevars' a s) @ (freevars' b s)
    | Not a -> (freevars' a s)
    | Prop a -> a :: s
    | True -> s
    | False -> s
  in dedup (freevars' f [])

let get_subst (vars:string list) (n:int): subst =
  let rec on i lst =
    match lst with
    | [] -> []
    | x::xs -> (on (i + 1) xs) @ [(x, ((n lsr i) mod 2) = 1)]
  in on 0 vars

let is_tautology (f:formula) (h:(subst -> subst option)): subst option =
  let vars = freevars f in
  let rec tautology (n:int) =
    let s = get_subst vars n in
    let res = eval f s in
    try (if res then raise KeepLooking else h s) with
    | KeepLooking -> if n > 0 then tautology (n - 1) else None
  in tautology ((1 lsl (List.length vars)) - 1)

let is_tautology_first f = is_tautology f (fun s -> Some s)

let is_tautology_print_all f =
  is_tautology f (fun s -> print_endline (show_subst s); raise KeepLooking)