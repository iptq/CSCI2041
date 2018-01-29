type 'a tree = Leaf of 'a
	| Fork of 'a * 'a tree * 'a tree

let t1 = Leaf 5
let t2 = Fork (3, Leaf 3, Fork (2, t1, t1))
let t3 = Fork ("Hello", Leaf "World", Leaf "!")
let t4 = Fork (7, Fork (5, Leaf 1, Leaf 2), Fork (6, Leaf 3, Leaf 4))

let rec t_size (tree:'a tree) :int =
	match tree with
	| Leaf x -> 1
	| Fork (x, y, z) -> 1 + t_size y + t_size z

let rec t_sum (tree:int tree) :int =
	match tree with
	| Leaf x -> x
	| Fork (x, y, z) -> x + t_sum y + t_sum z

let rec t_charcount (tree:string tree) :int =
	match tree with
	| Leaf x -> String.length x
	| Fork (x, y, z) -> String.length x + t_charcount y + t_charcount z

let rec t_concat (tree:string tree) :string =
	match tree with
	| Leaf x -> x
	| Fork (x, y, z) -> x ^ t_concat y ^ t_concat z

(* Part B* *)

let t5:string option tree = Fork (Some "a", Leaf (Some "b"), Fork (Some "c", Leaf None, Leaf (Some "d")))
let t7:int option tree = (Fork (Some 1, Leaf (Some 2), Fork (Some 3, Leaf None, Leaf None)))
let t8:string option tree = (Fork (Some "a", Leaf (Some "b"), Fork (Some "c", Leaf None, Leaf (Some "d"))))

let rec t_opt_size (tree:'a option tree) :int =
	match tree with
	| Leaf None -> 0
	| Leaf (Some x) -> 1
	| Fork (None, y, z) -> t_opt_size y + t_opt_size z
	| Fork (Some x, y, z) -> 1 + t_opt_size y + t_opt_size z

let rec t_opt_sum (tree:int option tree) :int =
	match tree with
	| Leaf None -> 0
	| Leaf (Some x) -> x
	| Fork (None, y, z) -> t_opt_sum y + t_opt_sum z
	| Fork (Some x, y, z) -> x + t_opt_sum y + t_opt_sum z

let rec t_opt_charcount (tree:string option tree) :int =
	match tree with
	| Leaf None -> 0
	| Leaf (Some x) -> String.length x
	| Fork (None, y, z) -> t_opt_charcount y + t_opt_charcount z
	| Fork (Some x, y, z) -> String.length x + t_opt_charcount y + t_opt_charcount z

let rec t_opt_concat (tree:string option tree) :string =
	match tree with
	| Leaf None -> ""
	| Leaf (Some x) -> x
	| Fork (None, y, z) -> t_opt_concat y ^ t_opt_concat z
	| Fork (Some x, y, z) -> x ^ t_opt_concat y ^ t_opt_concat z

(* Part C*)

let rec tfold (l:'a -> 'b) (f:'a -> 'b -> 'b -> 'b) (t:'a tree) :'b =
	match t with
	| Leaf x -> l x
	| Fork (x, y, z) -> f x (tfold l f y) (tfold l f z)

let tf_size (tree:'a tree) :int =
	tfold (fun x -> 1) (fun x y z -> 1 + y + z) tree

let tf_sum (tree:int tree) :int =
	tfold (fun x -> x) (fun x y z -> x + y + z) tree

let tf_char_count (tree:string tree) :int =
	tfold (fun x -> String.length x) (fun x y z -> String.length x + y + z) tree

let tf_concat (tree:string tree) :string =
	tfold (fun x -> x) (fun x y z -> x ^ y ^ z) tree

let tf_opt_size (tree:'a option tree) :int =
	tfold (fun x -> match x with None -> 0 | Some x -> 1) (fun x y z -> (match x with None -> 0 | Some x -> 1) + y + z) tree

let tf_opt_sum (tree:int option tree) :int =
	tfold (fun x -> match x with None -> 0 | Some x -> x) (fun x y z -> (match x with None -> 0 | Some x -> x) + y + z) tree

let tf_opt_char_count (tree:string option tree) :int =
	tfold (fun x -> match x with None -> 0 | Some x -> String.length x) (fun x y z -> (match x with None -> 0 | Some x -> String.length x) + y + z) tree

let tf_opt_concat (tree:string option tree) :string =
	tfold (fun x -> match x with None -> "" | Some x -> x) (fun x y z -> (match x with None -> "" | Some x -> x) ^ y ^ z) tree

(* Part D*) 

type 'a btree = Empty
	| Node of 'a btree * 'a * 'a btree

let t6 = Node (Node (Empty, 3, Empty), 4, Node (Empty, 5, Empty))

let rec bt_insert_by (f:'a -> 'a -> int) (x:'a) (tree:'a btree) :'a btree =
	match tree with
	| Empty -> Node (Empty, x, Empty)
	| Node (l, n, r) ->
		let c = f x n in
			if c <= 0 then Node(bt_insert_by f x l, n, r)
			else Node(l, n, bt_insert_by f x r)

let rec bt_elem_by (f:'a -> 'b -> bool) (x:'b) (tree:'a btree) :bool =
	match tree with
	| Empty -> false
	| Node (l, n, r) -> f n x || bt_elem_by f x l || bt_elem_by f x r

let rec bt_to_list (tree:'a btree) :'a list =
	match tree with
	| Empty -> []
	| Node (l, n, r) -> bt_to_list l @ (n :: bt_to_list r)

let rec btfold (x:'b) (f:'b -> 'a -> 'b -> 'b) (tree:'a btree) :'b =
	match tree with
	| Empty -> x
	| Node (l, n, r) -> f (btfold x f l) n (btfold x f r)

let btf_elem_by (f:'a -> 'b -> bool) (n:'b) (tree:'a btree) :bool =
	btfold false (fun x y z -> x || (f y n) || z) tree

let btf_to_list (tree:'a btree) :'a list =
	btfold [] (fun x y z -> x @ (y :: z)) tree

(* 
It'd be hard to write bt_insert_by with btfold because inserting traverses
the tree from the root to the leaves while folding is going in the opposite
direction.
 *)
