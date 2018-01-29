
type estring = char list


let rec explode = function
  | "" -> []
  | s  -> String.get s 0 :: explode (String.sub s 1 ((String.length s) - 1))

let rec implode = function
  | []    -> ""
  | c::cs -> String.make 1 c ^ implode cs

(* Modifed from functions found at http://www.csc.villanova.edu/~dmatusze/8310summer2001/assignments/ocaml-functions.html *)


let get_excited (cs:char list) = 
  let helper c =
    match c with
    | '.' -> '!'
    | _   -> c
  in
  let helper' = function
    | '.' -> '!'
    | c   -> c
  in map helper' cs
