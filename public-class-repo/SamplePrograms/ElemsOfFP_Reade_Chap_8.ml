(* This file contains a translation of the Standard ML functions found
   in sections 1 and 2 of Chapter 8 of Chris Reade's book Elements of
   Functional Programming into OCaml.

   Note that these functions, just like those in Reade's book, will
   not evaluate.  They are meant to illustrate concepts of lazy
   functional programming.  Since Standard ML and OCaml use eager
   evaluation these functions do not work.  Thus, these have not
   been loaded into OCaml and thus may have smaller erros in them.

   This translation is provided only to remove the barrier of 
   translating from Standard ML when reading this chapter.

   Sometimes additional functions or values that are not in Reade's
   chapter 8 are defined (such as plus with the code from page 268) to
   help clarify the examples in Reade.
 *)

(* from page 266 *)
let f x = g (h x x)


let g x = 5
let rec h x y = h y x
let f x = g (h x x)



(* page 267 *)
snd (raise (Failure "undefined"), 5)


(* page 268 *)
let plus x y = x + y
let double x = plus x x



(* page 269 *)
let f x = E



(* page 270 *)
let rec f x = f x in f () 

let tl lst = 
  match lst with
  | (a::x) -> x
  | [] -> raise (Failure "tl of [] is undefined")


(* page 271 *)
let k5 x = 5
let k5pr (x, y) = 5


(* page 272 *)
let andf a b = 
  match a with
  | true -> b
  | false -> false

let orf a b =
  match a with
  | true -> true
  | false -> b


(* pate 273 *)
let cond c x y = 
  match c with
  | true -> x
  | false -> y

let rec equal_lists l1 l2 =   (* called just = in Reade *)
  match l1, l2 with
  | [], [] -> true
  | (a::x), (b::y) -> a = b && equal_lists x y
  | (a::x), [] -> false
  | [], (b::y) -> false

type 'a bintree = Lf of 'a
                | Nd of 'a bintree * 'a bintree
(* Note that Reade used "/\" instead of Nd and thus writes this
   operator using infix notation instead of prefix notation.  Thus,
   where you read "t1 /\ t2" in Reade, we would write it as "Nd t1
   t2".  (Note that OCaml does support some user-defined infix
   operators be we are not using that capability here.) *)



(* page 274 *)
let rec eqleaves t1 t2 = leavesof t1 = leavesof t2
and leavesof t =
  match t with
  | Lf x -> [x]
  | Nd (t1, t2) -> leavesof t1 @ leavesof t2


(* page 276 *)
let rec exists p lst = 
  match lst with
  | [] -> false
  | a::x -> if p a then true else exists p x

let null l = 
  match l with
  | [] -> true
  | _ -> false


let rec accumulate f a lst =    (* similar to fold_left *)
  match lst with 
  | [] -> a
  | b::x -> accumulate f (f a b) x

let rec reduce f a lst =        (* similar to fold_right *)
  match lst with
  | [] -> a
  | b::x -> f b (reduce f a x)

let cons h t = h :: t
let append x y = reduce cons y x


(* page 277 *)
let rec append2 x y = revonto y (rev x)
and rev x = revonto [] x
and revonto y x = accumulate consonto y x
and consonto y a = a :: y

let rec infbt1 = Nd (Lf 6, infbt1)
let rec infbt2 = Nd (Nd (infbt2, Lf 2), Nd (Lf 3, infbt1))



(* page 279 *)
let rec leftmostleaf t =
  match t with
  | Lf x -> x
  | Nd (left, right) -> leftmostleaf left

let rec ones = 1 :: ones


(* page 280 *)
let rec from n = n :: from (n + 1)
let nat = from 1

let rec zip f lst1 lst2 = 
  match lst1, lst2 with
  | [], [] -> []
  | a::x, b::y -> f a b :: zip f x y
  | _, _ -> raise (Failure "zipping lists of different lengths")

let rec nat = zip plus ones (0 :: nat)


(* page 281 *)
let rec factorials = 1 :: zip



(* page 282 *)
let rec sieve lst =
  match lst with
  | a::x -> a :: sieve (sift a x)

let primes = sieve (from 2)

let rec multipleof a b = b mod a = 0
and non p = fun x -> not p x
and sift a x = filter (non (multipleof a)) x


(* page 283 *)
let rec nextfind a b lst = 
  match lst with
  | c::x -> if c < b then c :: nextfind a b x else
            if c = b then nextfined a (a + b) x else
            nextfind a (a + b) (c :: x)
let sift a x = netfind a (2 * a) x


(* page 287 *)
let rec merge2 lst1 lst2 = 
  match lst1, lst2 with
  | a::x, b::y -> if a < b then a :: merge2 x (b::y) else
                  if a > b then b :: merge2 (a::x) y else
                  a :: merge2 x y

let merge3 x y z = merge2 x (merge2 y z)

let times a b = a * b

let rec hamming = 1 :: merge3 (map (times 2) hamming)
                              (map (times 3) hamming)
                              (map (times 5) hamming)
              
