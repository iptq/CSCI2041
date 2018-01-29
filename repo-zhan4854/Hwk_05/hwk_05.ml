let rec ands lst =
  match lst with
  | [] -> true
  | x::xs -> if x then ands xs else false
