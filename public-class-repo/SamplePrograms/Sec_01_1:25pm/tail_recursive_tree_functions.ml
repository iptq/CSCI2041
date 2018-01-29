(* More tail recurive tree functions.

   These are from Charlie Harper and over a differnt type of tree.
 *)

type 'a tree = Leaf of 'a
             | Fork of 'a * 'a tree * 'a tree

let t1 = Leaf 5
let t2 = Fork (3, Leaf 3, Fork (2,t1,t1))
let t3 = Fork ("Hello", Leaf "World", Leaf "!")

let ident = (fun x -> x)

let t_size t =
  let rec t_size_rec t k =
    match t with
    | Leaf _ -> k 1
    | Fork (_,tl,tr) -> 
       t_size_rec tl (fun l ->
        t_size_rec tr (fun r -> 
         k (1 + l + r) )) 
  in
  t_size_rec t ident

let t_sum t =
  let rec t_sum_rec t k =
    match t with
    | Leaf v -> k v
    | Fork (v,tl,tr) ->
       t_sum_rec tl (fun l ->
        t_sum_rec tr (fun r ->
         k (v + l + r) )) 
  in
  t_sum_rec t ident

let t_charcount t =
  let rec t_charcount_rec t k =
    match t with
    | Leaf v -> k (String.length v)
    | Fork (v,tl,tr) ->
       t_charcount_rec tl (fun l ->
        t_charcount_rec tr (fun r ->
         k (l + r + String.length v) )) 
  in
  t_charcount_rec t ident

let t_concat t =
  let rec t_concat_rec t k =
    match t with
    | Leaf v -> k v
    | Fork (v,tl,tr) ->
       t_concat_rec tl (fun l ->
        t_concat_rec tr (fun r ->
         k (v ^ l ^ r) )) 
  in
  t_concat_rec t ident


let t_elem_by (eq: 'a -> 'b -> bool) (elem: 'b) (t: 'a tree) : bool =
  let rec t_elem_by_rec t k =
    match t with
    | Leaf v when eq v elem -> true
    | Fork (v,_,_) when eq v elem -> true
    | Leaf v -> k ()
    | Fork (v,tl,tr) ->
       t_elem_by_rec tl (fun u ->
        t_elem_by_rec tr k) 
  in
  t_elem_by_rec t (fun u -> false)

(* The ordering is left then fork value then right *)
(* t_to_list (Fork(1,Leaf 2,Leaf 3)) -> [2;1;3] *)
let t_to_list (t: 'a tree) : 'a list =
  let rec t_to_list_rec t r k =
    match t with
    | Leaf v -> k (v::r)
    | Fork (v,tl,tr) ->
       t_to_list_rec tr r (fun r1 ->
        t_to_list_rec tl (v::r1) k) 
  in
  t_to_list_rec t [] ident

let tfold (l:'a -> 'b) (f:'a -> 'b -> 'b -> 'b)  (t:'a tree) : 'b =
  let rec tfold_rec t k =
    match t with
    | Leaf v -> k (l v)
    | Fork (v,tl,tr) ->
       tfold_rec tl (fun l ->
        tfold_rec tr (fun r ->
         k (f v l r) )) 
  in
  tfold_rec t ident

(* A version of t_to_list that places the fork value first... *)
(* t_to_list (Fork(1,Leaf 2,Leaf 3)) -> [1;2;3] *)
let t_to_list_ff (t: 'a tree) : 'a list =
  let rec t_to_list_rec t r k =
    match t with
    | Leaf v -> k (v::r)
    | Fork (v,tl,tr) ->
       t_to_list_rec tr r (fun r1 ->
        t_to_list_rec tl r1 (fun r2 -> k (v::r2) )) 
  in
  t_to_list_rec t [] ident

(* And a version that places the fork value last... *)
(* t_to_list (Fork(1,Leaf 2,Leaf 3)) -> [2;3;1] *)
let t_to_list_fl (t: 'a tree) : 'a list =
  let rec t_to_list_rec t r k =
    match t with
    | Leaf v -> k (v::r)
    | Fork (v,tl,tr) ->
       t_to_list_rec tr (v::r) (fun r1 ->
        t_to_list_rec tl r1 k) 
  in
  t_to_list_rec t [] ident
