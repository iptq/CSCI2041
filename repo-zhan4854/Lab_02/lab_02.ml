(* Lab 2 *)
(* by Michael Zhang *)

(* circle_area_v1 *)

let circle_area_v1 d = let r = d/.2.0 in 3.1415926*.r*.r

(* circle_area_v2 *)

let circle_area_v2 d = let r = d/.2.0 in let pi = 3.1415926 in pi*.r*.r

(* product *)

let rec product xs = match xs with
    | x::rest -> x*(product rest)
    | [] -> 1

(* sum_diffs *)

let rec sum_diffs xs = match xs with
    | x1::x2::rest -> (x1-x2)+(sum_diffs (x2::rest))
    | x::rest -> 0
    | [] -> 0

(* distance *)

let distance (x1,y1) (x2,y2) = let square x = x*.x in sqrt (square (x2-.x1) +. square (y2-.y1))

(* triangle_perimeter *)

let triangle_perimeter (x1,y1) (x2,y2) (x3,y3) = (distance (x1,y1) (x2,y2))+.(distance (x3,y3) (x2,y2))+.(distance (x3,y3) (x1,y1))