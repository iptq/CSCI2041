(*

Some reductions from lecture on Feb 6.

let x = 1 + 2 in let y = x + 3 in x + y

let x = 3 in let y = x + 3 in x + y

let x = 3 in let y = 3 + 3 in x + y

let x = 3 in let y = 6 in x + y

let x = 3 in let y = 6 in 3 + y

let x = 3 in let y = 6 in 3 + 6

3 + 6

9


let rec rev = function
       | [] -> []
       | x::xs -> rev xs @ [x]

rev (1::2::3::[])

rev (2::3::[]) @ [1]

(rev (3::[]) @ [2]) @ [1]

((rev ([]) @ [3]) @ [2]) @ [1]

([] @ [3]) @ [2]) @ [1]

([3] @ [2]) @ [1]

[3;2] @ [1]

[3;2;1]


match n with
| 0 ->
| 1 ->
| n -> 

match lst with
| [] ->
| x::xs -> 

 *)


type color = Red | Blue | Green 

type weekday = Monday | Tuesday | Wednesday | Thursday | Friday

let isMonday day = 
  match day with 
    Monday -> true
  | _ -> false


type day = Sun | Mon | Tue | Wed | Thr | Fri | Sat 

let isWeekDay d = 
  match d with 
  | Mon | Tue | Wed | Thr | Fri -> true
  | _ -> false


type intorstr = Int of int | Str of string

let getIntValue ios =
  match ios with
  | Int n -> n
  | Str _ -> 99


let rec sumList l =
  match l with
  | [] -> 0 
  | hd:: tl ->
              match hd with
              | Int i -> i + sumList tl
              | Str s -> sumList tl

let sample1 = [ Int 8; Str "Hello"; Int 10 ] 
let sample2 = Int 8 :: Str "Hello" :: Int 0 :: [] 



type coord = float * float
type circ_desc = coord * float
type tri_desc = coord * coord * coord
type sqr_desc = coord * coord * coord * coord
type rec_desc = coord * coord * coord * coord

type shape = Circ of circ_desc
           | Tri of float * float * float  (* tri_desc *)
           | Sqr of sqr_desc
           | Rec of rec_desc

type shape2 = irc_desc
           | tri_desc
           | sqr_desc
           | rec_desc
(*
type intorstr = Foo of int | Bar of string

let getNum i =
 match i with 
 | n -> n + 5
 | s -> s ^ "Hello"
 *)



let foo fn = 
  match read_file fn with
  | None -> raise (Failuere "No file")
  | Some s -> String.length s
