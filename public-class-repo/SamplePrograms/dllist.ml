(* A doubly-linked list.  

   This imperative data type supports the following operations:

   dl_nil : unit -> 'a dllist
   dl_cons : 'a -> 'a dllist -> unit
   dl_snoc : 'a -> 'a dllist -> unit
 *)

type 'a cell 
  = Nil
  | Cell of 'a * 'a cell ref * 'a cell ref

type 'a dllist = 'a cell ref * 'a cell ref

let dl_nil () = (ref Nil, ref Nil)

let dl_cons elem dll =
  match dll with
  | rhead, rlast when !rhead = Nil && !rlast = Nil -> 
     let c = Cell (elem, ref Nil, ref Nil) in
     let () = rhead := c in
     let () = rlast := c in
     ()
  | rhead, rlast ->
     let next = ref (!rhead) in
     let c = Cell (elem, ref Nil, next) in
     let () = rhead := c in
     match !next with
     | Cell (_, prev, _) ->
        let () = prev := c in ()


let dl_snoc elem dll =
  match dll with
  | rhead, rlast when !rhead = Nil && !rlast = Nil -> 
     let c = Cell (elem, ref Nil, ref Nil) in
     let () = rhead := c in
     let () = rlast := c in
     ()
  | rhead, rlast ->
     let prev = ref (!rlast) in
     let c = Cell (elem, prev, ref Nil) in
     let () = rlast := c in
     match !prev with
     | Cell (_, _, next) ->
        let () = next := c in ()
     
let rec to_list_from_front dll = 
  match dll with
  | rhead, rlast -> 
     match !rhead with
     | Nil -> []
     | Cell (elem, _, next) -> elem :: to_list_from_front (next, ref Nil)

let rec to_list_from_back dll = 
  match dll with
  | rhead, rlast -> 
     match !rlast with
     | Nil -> []
     | Cell (elem, prev, _) -> elem :: to_list_from_back (ref Nil, prev)


let i0 = dl_nil ()
let () = dl_cons 3 i0
let () = dl_cons 2 i0
let () = dl_cons 1 i0

let () = dl_snoc 4 i0
let () = dl_snoc 5 i0

