let is_elem v l =
  List.fold_right (fun x in_rest -> if x = v then true else in_rest) l false

let rec is_not_elem set v =
  match set with
  | [] -> true
  | s::ss -> if s = v then false else is_not_elem ss v

type sq = (int * int)
let final = [ (5, 1); (3, 5) ]

let next (sq:sq): sq list =
  match sq with
  | (1, 1) -> (2, 1)::[]
  | (1, 2) -> (1, 3)::(2, 2)::[]
  | (1, 3) -> (1, 4)::(2, 3)::(1, 4)::[]
  | (1, 4) -> (1, 5)::(1, 3)::[]
  | (1, 5) -> (2, 5)::(1, 4)::[]
  | (2, 1) -> (1, 1)::(3, 1)::[]
  | (2, 2) -> (1, 2)::(3, 2)::[]
  | (2, 3) -> (1, 3)::[]
  | (2, 4) -> (2, 5)::(3, 4)::[]
  | (2, 5) -> (1, 5)::(2, 4)::[]
  | (3, 1) -> (2, 1)::(3, 2)::[]
  | (3, 2) -> (2, 2)::(3, 3)::(4, 2)::(3, 1)::[]
  | (3, 3) -> (3, 4)::(4, 3)::(3, 2)::[]
  | (3, 4) -> (2, 4)::(4, 4)::(3, 3)::[]
  | (3, 5) -> [] (* DONE *)
  | (4, 1) -> (4, 2)::[]
  | (4, 2) -> (3, 2)::(4, 1)::[]
  | (4, 3) -> (3, 3)::(5, 3)::[]
  | (4, 4) -> (3, 4)::(5, 4)::[]
  | (4, 5) -> (3, 5)::(5, 5)::(4, 4)::[]
  | (5, 1) -> [] (* DONE *)
  | (5, 2) -> (5, 3)::(5, 1)::[]
  | (5, 3) -> (4, 3)::(5, 4)::(5, 2)::[]
  | (5, 4) -> (5, 3)::[]
  | (5, 5) -> (4, 5)::[]
  | (_, _) -> [] (* screw off *)

let maze (): sq list option =
  let rec maze' (square:sq) (moves:sq list): sq list option =
    if is_elem square final
    then Some (moves @ [square])
    else (match List.filter (is_not_elem moves) (next square) with
      | [] -> raise KeepLooking  
    )
  in maze' (2, 3) []