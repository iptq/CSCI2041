(* from Feb 13 *)

(* What are the pieces of the type definition above?

1. the name of the type constructor: tree

2. the arguments of the type constructor: 'a

3. the variants names: Leaf and Fork
   these are also called value constructors

4. the values associated with those names
   a. Leaf which holds a value of type 'a
   b. Fork which holds a value and two sub trees.

*)

(* tree is parametric polymorphic type *)
type 'a tree = Leaf of 'a
             | Fork of 'a * 'a tree * 'a tree

let t1 = Leaf 5
let t2 = Fork (3, Leaf 1, Fork (6, t1, t1) )
let t3 = Fork ("Hello", Leaf "World", Leaf "!")

let rec tsize t = 
  match t with 
  | Leaf _ -> 1
  | Fork (_, t1, t2) -> 1 + tsize t1 + tsize t2

let rec tsum = function
  | Leaf v -> v
  | Fork (v, t1, t2) -> v + tsum t1 + tsum t2

let rec tsum' = fun t ->
  match t with
  | Leaf v -> v
  | Fork (v, t1, t2) -> v + tsum' t1 + tsum' t2


let rec tmap (eq:'a -> 'b) (t:'a tree) : 'b tree =
  match t with 
  | Leaf x -> Leaf (eq x)
  | Fork (x, t1, t2) -> Fork (eq x, tmap eq t1, tmap eq t2)

let rec tfold (l: 'a -> 'b) (f: 'a -> 'b -> 'b -> 'b) (t: 'a tree) : 'b = 
  match t with
  | Leaf v -> l v 
  | Fork (v, t1, t2) -> f v (tfold l f t1) (tfold l f t2)

(* For Wednesday, use tfold to 
  1. write an identity function for trees
  2. compute the number of characters in a string tree, such as t3
 *)

(* inttree is a monomorphic type *)
type inttree = ILeaf of int
             | IFork of int * inttree * inttree

