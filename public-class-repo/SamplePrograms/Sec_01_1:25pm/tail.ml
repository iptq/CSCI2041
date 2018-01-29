(* Some functions used in S4.3 Improving Performance 

Some of this material comes from section 9.4 of Chris Reade's book
``Elements of Functional Programming''.  This is in the `Resources`
directory of the public class repository.

Some were written by Charlie Harper.

 *)


let rec listof n =
  match n with
  | 0 -> []
  | _ -> n :: listof (n-1)

let rec append l1 l2 =
  match l1 with
  | [] -> l2
  | x::xs -> x :: (append xs l2)



(* Problem 1: what is wrong with this function? *)
let rec rev lst =
  match lst with
  | [] -> []
  | x::xs -> append (rev xs) [x]




(* Problem 2: how can these be improved? *)
let rec length lst = match lst with
  | [] -> 0 
  | _::xs -> 1 + length xs

let rec sumlist lst = match lst with
  | [] -> 0
  | x::xs -> x + sumlist xs


(*- stacking up the additions 

Evaluation - if delay additions a bit
  sumlist 1::2::3::[]
  1 + (sumlist 2::3::[])
  1 + (2 + (sumlist 3::[])
  1 + (2 + (3 + sumlist [])
  1 + (2 + (3 + 0))


*)






(* Some solutions
   --------------
 *)

(* Use an accumulating parameter to convert reverse from
   quadradic to linear time. *)
let rev_a lst =
  let rec revaccum lst accum =
    match lst with
    | [] -> accum
    | x::xs -> revaccum xs (x::accum)
  in
  revaccum lst []

(* Does the above function remind us of imperative programming? 

   accum = [] ;
   while lst <> [] do
      x::xs = lst

      lst = xs
      accum = x::accum

*)


let length_tr lst =
  let rec ltr lst accum =
    match lst with
    | [] -> accum
    | x::xs -> ltr xs (accum + 1)
  in
  ltr lst 0






(* We can also avoid stacking up the additions by using
   an accumulating parameter. *)
let sumlist_a lst =
  let rec accsum lst n =
    match lst with
    | [] -> n
    | x::xs -> accsum xs (n+x)
  in
  accsum lst 0


(* 
We delayed the additions - so not really call by value
sumlist_a [1;2;3]
accsum [1;2;3] 0
accsum [2;3] (0+1)
accsum [3] ((0+1)+2)
accsum [] (((0+1)+2)+3)
(((0+1)+2)+3)



 *)




(* Exercise: what is the tail recurive version of length? *)



(* Fibonacci numbers *)
let rec fib n = match n with
  | 0 -> 0
  | 1 -> 1
  | n -> fib (n-1) + fib (n-2)
(* What is the tail recursive version of the fib function
   that uses accumulators to avoid all the recomputation?
 *)

let fib_tr n =
  let rec fib_acc a b n = match n with
    | 0 -> a
    | n -> fib_acc b (a+b) (n-1)
  in
  fib_acc 0 1 n


(* Another exercise: how does this relate to the imperative
   version? *)


(* Let's recall sumlist and sumlist_tr.

   Haven't we seen this before? *) 


let rec foldl f v l =
  match l with
  | [] -> v
  | x::xs ->  foldl f (f v x) xs

let sum_f xs = foldl (+) 0 xs

(*-
foldl (+) 0 (1::2::3::[])
foldl (+) (0+1) (2::3::[])
foldl (+) 1 (2::3::[])
foldl (+) (1+2) (3::[])
foldl (+) 3 (3::[])
foldl (+) (3+3) []
foldl (+) 6 []
6

Or without evaluating + so early
foldl (+) 0 (1::2::3::[])
foldl (+) (0+1) (2::3::[])
foldl (+) ((0+1)+2) (3::[])
foldl (+) (((0+1)+2)+3) []
(((0+1)+2)+3)
6
 *)


