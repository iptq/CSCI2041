(* from Feb 13 *)

type 'a tree = Leaf of 'a
             | Fork of 'a * 'a tree * 'a tree

(* What are the pieces of the type definition above?

1. the name of the type constructor: tree

2. the arguments of the type constructor: 'a

3. the variants names: Leaf and Fork
   these are also called value constructors

4. the values associated with those names
   a. Leaf which holds a value of type 'a
   b. Fork which holds a value and two sub trees.

*)


(* This is the 'monomorphic version - it only allows for integer trees
   and is much less general than the 'tree' above.*)
type inttree = ILeaf of int
             | IFork of int * inttree * inttree



let t1 = Leaf 5
let t2 = Fork (3, Leaf 3, Fork (2, t1, t1))
let t3 = Fork ("Hello", Leaf "World", Leaf "!")

let rec size t =
  match t with
  | Leaf _ -> 1
  | Fork (_, ta, tb) -> 1 + size ta + size tb

let rec size' = fun t ->
  match t with
  | Leaf _ -> 1
  | Fork (_, ta, tb) -> 1 + size ta + size tb

let rec sum = function
  | Leaf v -> v
  | Fork (v, t1, t2) -> v + sum t1 + sum t2



let rec tfold (l:'a -> 'b) (f:'a -> 'b -> 'b -> 'b)  (t:'a tree) : 'b = 
 match t with
 | Leaf v -> l v
 | Fork (v, t1, t2) -> f v (tfold l f t1) (tfold l f t2)

let rec tmap (f:'a -> 'b) (t: 'a tree) : 'b tree = match t with
  | Leaf v -> Leaf (f v)
  | Fork (v, t1, t2) -> Fork (f v, tmap f t1, tmap f t2)

(* This is not the kind of folds that we want.  It is better to have
   folds the have a function (or value) for each value constructor
   of the type.  Thus `tfold` above has two functions, one for Leaf, 
   one for Fork.

   So don't write functions like the one below, at least not for creating
   general multi-purpose kinds of folding functions.
 *)
let rec tfold' (f:'a -> 'b -> 'b) (accum:'b) (t:'a tree) : 'b =
  match t with 
  | Leaf v -> f v accum
  | Fork (v, t1, t2) -> let l' = tfold' f accum t1 in
                        let r' = tfold' f l' t2 in
                        f v r'

