(* Homework 1 *)
(* by Michael Zhang, Tianjiao Yu, Eric Nguyen *)

(* even *)

let rec even n = if n = 0 then true
                 else if n = 1 then false
                      else even (n-2) ;;

(* gcd *)

let rec euclid a b = if a = b then a
                     else if a < b then euclid a (b-a)
                          else euclid (a-b) b ;;

(* frac_add *)

let frac_add (n1,d1) (n2,d2) = ((n1*d2 + n2*d1), (d1*d2)) ;;

(* frac_simplify *)

let rec frac_simplify (n,d) = if (euclid n d) = 1 then (n,d)
                              else frac_simplify (n/(euclid n d), d/(euclid n d)) ;;

(* sqrt_approx *)

let square_approx n accuracy = 
  let rec square_approx_helper n accuracy lower upper = if (upper-.lower) > accuracy then
                                                          let guess = (lower +. upper) /. 2.0 in
                                                          if (guess*.guess) > n then (square_approx_helper n accuracy lower guess)
                                                          else (square_approx_helper n accuracy guess upper)
                                                      else (lower, upper) in
  (square_approx_helper n accuracy 1.0 n) ;;

(* max_list *)

let rec max_list xs = match xs with
                      | x::[] -> x
                      | x::rest -> (let y = (max_list rest) in if x > y then x else y)
                      | [] -> 0 ;;

(* drop *)

let rec drop x xs = if x=0 then xs else (match xs with
    | el::rest -> drop (x-1) rest
    | [] -> [])

(* reverse *)

let rec rev xs = match xs with
                 | [] -> []
                 | x::rest -> (rev rest)@[x] ;;

(* perimeter *)

let distance (x1,y1) (x2,y2) = let square x = x*.x in sqrt (square (x2-.x1) +. square (y2-.y1))

let perimeter points = match points with
  | [] -> 0.0
  | (x,y)::rest -> let rec perimeter' points = match points with
    | (x1,y1)::(x2,y2)::rest -> (distance (x1,y1) (x2,y2))+.(perimeter' ((x2,y2)::rest))
    | (x,y)::rest -> 0.0
    | [] -> 0.0
  in (perimeter' (points@((x,y)::[]))) ;;


(* is_matrix *)

let rec len xs = match xs with
  | [] -> 0
  | x::rest -> 1+(len rest) ;;
let rec is_matrix a = match a with
  | [] -> true
  | row::rest -> let rec len_match b = match b with
    | [] -> true
    | row'::rest' -> if ((len row) = (len row'))
      then (len_match rest') else false
  in (len_match rest) ;;

(* matrix_scalar_add *)

let rec matrix_scalar_add a c =
  let rec add_row r = match r with
    | [] -> []
    | x::rest -> (x+c)::(add_row rest)
  in match a with
    | [] -> []
    | x::rest -> (add_row x)::(matrix_scalar_add rest c) ;;


(* matrix_transpose *)

let rec matrix_transpose matrix =
  let rec rins l i =
    match l with
      | [] -> [i]
      | a::b -> a::(rins b i) in
  let rec append m v =
    match m with
      | m'::rest -> (match v with
        | v'::rest' -> (rins m' v')::(append rest rest')
        | [] -> [])
      | [] -> [] in
  let rec transpose mat init = 
    match mat with
      | [] -> init
      | a::b -> transpose b (append init a) in
  let rec head lst =
    match lst with
      | a::b -> a
      | [] -> [] in
  let rec create_empty v init =
    match v with
      | [] -> init
      | a::b -> []::(create_empty b init) in
  transpose matrix (create_empty (head matrix) []) ;;

let rec matrix_multiply a b =
  let rec dot_multiply a' b' =
    match a' with
      | x::rest -> (match b' with
        | y::rest' -> (x*y) + (dot_multiply rest rest')
        | [] -> 0)
      | [] -> 0 in
  let rec multiply_row row b =
    match b with
      | b'::rest -> (dot_multiply row b')::(multiply_row row rest)
      | [] -> [] in
  match a with
    | a'::rest -> (multiply_row a' (matrix_transpose b))::(matrix_multiply rest b)
    | [] -> []

let rec print_matrix matrix =
  let rec print_list lst = match lst with
    | x::rest -> print_string (string_of_int x); print_string ", "; print_list rest
    | [] -> print_string "" in
  match matrix with
    | x::rest -> print_string "["; print_list x; print_string "]\n"; print_matrix rest
    | [] -> print_string "" ;;

(* let a = [[1; 2; 3]; [4; 5; 6]] ;;
let b = [[7; 8]; [9; 10]; [11; 12]] ;;
print_matrix a ;;

print_matrix (matrix_transpose a) ;;
print_matrix (matrix_multiply a b) *)
