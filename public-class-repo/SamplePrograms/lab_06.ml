type 'a tree = Leaf of 'a
             | Fork of 'a * 'a tree * 'a tree

let t1 = Leaf 5
let t2 = Fork (3, Leaf 3, Fork (2, t1, t1))
let t3 = Fork ("Hello", Leaf "World", Leaf "!")


let rec t_size t =
          match t with
            | Leaf _ -> 1
            | Fork (_, ta, tb) -> 1 + t_size ta + t_size tb

let rec t_sum = function
          | Leaf v -> v
          | Fork (v, t1, t2) -> v + t_sum t1 + t_sum t2

let rec t_charcount = function
          | Leaf s -> String.length s
          | Fork (v, t1, t2) -> String.length v + t_charcount t1 + t_charcount t2

let rec t_concat = function
          | Leaf s -> s
          | Fork (v, t1, t2) -> v ^ t_concat t1 ^ t_concat t2

(* t_opt versions. *)

(* After writing the first 4 functions they are to write 4 more, but
with different names: t_opt_size, t_opt_sum, etc. Provide a few sample
trees for this type as well.  t_opt_size should count the number of
values in the tree - that is, those under a "Some" constructor.  I
didn't make this clear.  So we need something like the following: *)

let rec t_opt_size (t: 'a option tree) : int =
  match t with
  | Leaf None -> 0
  | Leaf (Some _) -> 1
  | Fork (None, t1, t2) -> t_opt_size t1 + t_opt_size t2
  | Fork (Some _, t1, t2) -> 1 + t_opt_size t1 + t_opt_size t2

let rec t_opt_sum (t: 'a option tree) : int =
  match t with
  | Leaf None -> 0
  | Leaf (Some x) -> x
  | Fork (None, t1, t2) -> t_opt_sum t1 + t_opt_sum t2
  | Fork (Some x, t1, t2) -> x + t_opt_sum t1 + t_opt_sum t2

let rec t_opt_charcount (t: string option tree) : int =
  match t with
  | Leaf None -> 0
  | Leaf (Some s) -> String.length s
  | Fork (None, t1, t2) -> t_opt_charcount t1 + t_opt_charcount t2
  | Fork (Some s, t1, t2) -> String.length s + t_opt_charcount t1 + 
                               t_opt_charcount t2

let rec t_opt_concat (t: string option tree) : string =
  match t with
  | Leaf None -> ""
  | Leaf (Some s) -> s
  | Fork (None, t1, t2) -> t_opt_concat t1 ^ t_opt_concat t2
  | Fork (Some s, t1, t2) -> s ^ t_opt_concat t1 ^ t_opt_concat t2


(* t_fold versions. *)
let rec tfold (l:'a -> 'b) (f:'a -> 'b -> 'b -> 'b)  (t:'a tree) : 'b = 
         match t with
         | Leaf v -> l v
         | Fork (v, t1, t2) -> f v (tfold l f t1) (tfold l f t2)

let tf_size t = tfold (fun x -> 1) (fun a b c -> 1+b+c) t

let tf_sum t = tfold (fun x -> x) (fun a b c -> a+b+c) t

let tf_char_count t = tfold (fun x -> String.length x) 
                            (fun a b c ->  String.length a + b + c) t

let tf_concat t = tfold (fun x -> x) (fun a b c -> a ^ b ^ c) t

let tf_opt_size t = 
  let f o = match o with
    | None -> 0
    | Some _ -> 1
  in tfold f (fun a b c -> f a + b + c) t

(*  something similar for the other 3 tf_opt_.... functions  *)

let tf_opt_sum t = 
        let f o = match o with
        | None -> 0
        | Some x -> x 
        in tfold f (fun a b c -> f a + b + c) t

let tf_opt_char_count t = 
        let f o = match o with
        | None -> 0
        | Some x -> String.length x
        in tfold f (fun a b c -> f a + b + c) t

let tf_opt_concat t = 
        let f o = match o with 
        | None -> ""
        | Some x -> x 
        in tfold f (fun a b c -> f a ^ b ^ c) t 

(* Implementations. *)

(* The type of tree that we have above is actually not so useful as it
doesn't allow for an empty tree.  So let's create
a more useful tree.

Note that we'll put the data on a Node in between the two sub-trees to indicate that they are sorted in that order. *)

type 'a btree = Empty
              | Node of 'a btree * 'a * 'a btree



let rec bt_insert_by (cmp: 'a -> 'a -> int) (elem: 'a) (t: 'a btree) : 'a btree =  
  match t with 
  | Empty -> Node (Empty, elem, Empty)
  | Node (t1, v, t2) ->
     if (cmp elem v) <= 0 
     then Node (bt_insert_by cmp elem t1, v, t2)
     else Node (t1, v, bt_insert_by cmp elem t2)

let rec bt_elem_by (eq: 'a -> 'b -> bool) (elem: 'b) (t: 'a btree) : bool =
  match t with
  | Empty -> false
  | Node (t1, v, t2) ->
     eq v elem || bt_elem_by eq elem t1 || bt_elem_by eq elem t2

let rec bt_to_list (t: 'a btree) : 'a list =
  match t with
  | Empty -> []
  | Node (t1, v, t2) -> bt_to_list t1 @ [v] @ bt_to_list t2



let rec btfold (e: 'b) (f:'b -> 'a -> 'b -> 'b)  (t:'a btree) : 'b = 
  match t with
  | Empty -> e
  | Node (t1, v, t2) -> f (btfold e f t1) v (btfold e f t2)





let btf_to_list (t: 'a btree) : 'a list =
  btfold [] (fun l1 v l2 -> l1 @ [v] @ l2) t

let btf_elem_by (eq: 'a -> 'b -> bool) (elem: 'b) (t: 'a btree) : bool =
        btfold false (fun b1 v b2 -> eq v elem || b1 || b2) t






