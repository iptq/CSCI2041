(* OCaml functions for comparing leaves in binary trees.  Based on
   examples in Chapters 8 and 9 of Chris Reade's Elements of
   Functional Programming *)

type 'a bintree = Lf of 'a
                | Nd of 'a bintree * 'a bintree

let rec equal_list l1 l2 = match l1, l2 with
  | [], [] -> true
  | (x::xs), (y::ys) -> if x = y then equal_list xs ys else false
  | _, _ -> false

let rec append l1 l2 = match l1 with
  | [] -> l2
  | (x::xs) -> x :: append xs l2

let rec flatten t = match t with
  | Lf x -> [x]
  | Nd (t1,t2) -> append (flatten t1) (flatten t2)

(* If we evaluate the following function eagerly, it is slow because it 
   must flatten each tree completely before making any comparisons. 
   If we evaluate it lazily, we can avoid some unnecessary computaions. *)
let eqleaves_v1 t1 t2 = equal_list (flatten t1) (flatten t2)




(* This is the fast version that only flattens trees as much as is
   necessary.  This complexity is needed in a language that uses eager
   evaluation.  It is not needed in a lazy language.  *)
let rec eqleaves_v2 t1 t2 = comparestacks [t1] [t2]
and comparestacks f1 f2 = 
  match f1, f2 with
    | [ ], [ ] -> true
    | [ ], a::x -> false
    | a::x, [ ] -> false
    | (Nd (l, r) :: x), y -> comparestacks (l::r::x) y
    | x, (Nd (l, r) :: y) -> comparestacks x (l::r::y)
    | (Lf a)::x, (Lf b)::y -> if a = b then comparestacks x y else false


(* a few simple sample trees *)
let t1 = Lf (3 * 2)
let t2 = Nd (Lf (3 + 3), Lf 5)



(* Some sample evaluations:

Version 1 - using lazy evalution, and thus "fast"
  eqleaves_v1 (Lf (3 * 3)) (Nd (Lf (3 + 3), Lf (2 * 5)))
= equal_list (flatten (Lf (3 * 3))) (flatten (Nd (Lf (3 + 3), Lf (2 * 5))))
= equal_list [3 * 3] (flatten (Nd (Lf (3 + 3), Lf (2 * 5))))
= equal_list [3 * 3] (append (flatten (Lf (3 + 3))) (flatten (Lf (2 * 5))))
= equal_list [3 * 3] (append [3 + 3] (flatten (Lf (2 * 5))))
= equal_list [3 * 3] (append [3 + 3] (flatten (Lf (2 * 5))))
= equal_list [3 * 3] (3 + 3 :: append [] (flatten (Lf (2 * 5))))
= if (3 * 3) = (3 + 3)
  then equal_list [] (append [] flatten (Lf (2 * 5))) 
  else false
= if 9 = (3 + 3)
  then equal_list [] (append [] flatten (Lf (2 * 5))) 
  else false
= if 9 = 6
  then equal_list [] (append [] flatten (Lf (2 * 5))) 
  else false
= false
  then equal_list [] (append [] flatten (Lf (2 * 5))) 
  else false
= false


Version 1 - eagerly and slow
  eqleaves_v1 (Lf (3 * 3)) (Nd (Lf (3 + 3), Lf (2 * 5)))
= eqleaves_v1 (Lf 9) (Nd (Lf 6, Lf 10))
= equal_list (flatten (Lf 9)) (flatten (Nd (Lf 6, Lf 10)))

= equal_list [9] (flatten (Nd (Lf 6, Lf 10)))
= equal_list [9] (append (flatten (Lf 6)) (flatten (Lf 10)))
= equal_list [9] (append [6] (flatten (Lf 10)))
= equal_list [9] (6 :: append [] (flatten (Lf 10)))
= equal_list [9] (6 :: (flatten (Lf 10)))
= equal_list [9] (6 :: [10])
= equal_list [9] [6; 10]
= if 9 = 6 then equal_list [] [10] else false
= false

Version 2 - eagerly and fast

  eqleaves_v2 (Lf (3 * 3)) (Nd (Lf (3 + 3), Lf (2 * 5)))
= eqleaves_v2 (Lf 9) (Nd (Lf 6, Lf 10))
= comparestacks [Lf 9] [Nd (Lf 6, Lf 10)]
= comparestacks [Lf 9] [Lf 6; Lf 10]
= if 9 = 6 then comparestacks [] [Lf 10] else false
= false



 *)

