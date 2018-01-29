(* This file contains a few helper functions and type declarations
   that are to be used in Homework 2. *)

(* Place part 1 functions 'take', 'drop', 'length', 'rev',
   'is_elem_by', 'is_elem', 'dedup', and 'split_by' here. *)

let rec take n l = match l with
  | [] -> [] 
  | x::xs -> if n > 0 then x::take (n-1) xs else []

let rec drop n l = match l with
  | [] -> []
  | x::xs -> if n > 0 then drop (n-1) xs else l

let length (lst:'a list): int = List.fold_right (fun x y -> y + 1) lst 0
let rev (lst:'a list): 'a list = List.fold_right (fun x y -> y @ [x]) lst []
let is_elem_by (f:'a -> 'b -> bool) (el:'b) (lst:'a list): bool = List.fold_right (fun x y -> if (f x el) then true else y) lst false
let is_elem (el:'b) (lst:'a list): bool = is_elem_by (=) el lst
let dedup (lst:'a list): 'a list = List.fold_right (fun x y -> if (is_elem x y) then y else x::y) lst []
 
let split_by (f:'a -> 'b -> bool) (lst:'b list) (sep:'a list): 'b list list =
  let f x y =
    if (is_elem_by f x sep)
    then []::y
    else match y with
      | hd::tail -> (x::hd)::tail
      | [] -> [] in
  List.fold_right f lst [[]]

let read_file (filename:string) : char list option =
  let rec read_chars channel sofar =
    try 
      let ch = input_char channel
      in read_chars channel (ch :: sofar)
    with
    | _ -> sofar
  in
  try 
    let channel = open_in filename
    in 
    let chars_in_reverse = read_chars channel []
    in Some (rev chars_in_reverse)
  with
    _ -> None

type result = OK 
  | FileNotFound of string
  | IncorrectNumLines of int 
  | IncorrectLines of (int * int) list
  | IncorrectLastStanza

type word = char list
type line = word list

let remove_empty (lst:'a list list): 'a list list = List.fold_right (fun x y -> if x = [] then y else x::y) lst []
let first (lst:'a list): 'a = match lst with hd::tail -> hd | [] -> raise (Failure "no first")

let convert_to_non_blank_lines_of_words (text:char list): line list =
  let split_line (x:word) (y:line list): line list = remove_empty (split_by (=) x [' '; '.'; '!'; '?'; ','; ';'; ':'; '-'])::y in
  List.fold_right split_line (remove_empty (split_by (=) text ['\n'])) []

let clean_line (line:line) = List.sort (fun x y -> if x < y then -1 else if x = y then 0 else 1) (List.map (fun x -> List.map Char.lowercase x) line)
let check_pair (lst:line list) n = clean_line (first (take 1 (drop (n-1) lst))) = clean_line (first (take 1 (drop n lst)))
let unidentical_lines (lines:line list) = List.map first (remove_empty (List.map (fun x -> if check_pair lines x then [] else (x, x+1)::[]) [1; 3; 7; 9; 13; 15]))
let squash (lines:line list): line = List.fold_right (fun x y -> x@y) lines []
let longest (lines:line list): line = List.fold_right (fun x y -> if length x > length y then x else y) lines []
(*let check_last (lst:line list) n = clean_line (squash (take 2 (drop (n-4) lst))) = clean_line (squash (take 2 (drop (n-1) lst)))*)
let check_last (lst:line list) n = 
  clean_line (squash ((longest (take 2 (drop (n-5) lst))) :: (longest (take 1 (drop (n-3) lst))) :: []))
  = clean_line (squash (take 2 (drop (n-1) lst)))
let wrong_last_lines lines = List.map first (remove_empty (List.map (fun x -> if check_last lines x then [] else (x, x+1)::[]) [5; 11; 17]))
let last_stanza lines = dedup (clean_line (squash (take 18 lines))) = dedup (clean_line (squash (drop 18 lines)))

(* DEBUG *)
(*let get_lines filename = convert_to_non_blank_lines_of_words (match read_file filename with | None -> raise (Failure "shiet") | Some lines -> lines)
let rec char_of_string str = match str with "" -> [] | ch -> (String.get ch 0)::(char_of_string (String.sub ch 1 ((String.length ch)-1)))*)

let paradelle (filename:string): result =
  match read_file filename with
  | None -> FileNotFound filename
  | Some content ->
    let lines = convert_to_non_blank_lines_of_words (content) in
    let lst = remove_empty lines in
    let n = length lst in
    if n = 24 then (
      let wrong_lines = unidentical_lines lst @ wrong_last_lines lst in
      if length wrong_lines = 0 then (
        if last_stanza lines then OK
        else IncorrectLastStanza
      )
      else IncorrectLines wrong_lines
    )
    else IncorrectNumLines n