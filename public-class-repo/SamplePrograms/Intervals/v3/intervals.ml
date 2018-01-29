(* Defining the IntInterval module with an explicit signature as a
   nested module.
 *)


module IntInterval : sig
  type t
  val create : int -> int -> t
  val is_empty : t -> bool
  val contains : t -> int -> bool
  val intersect : t -> t -> t
  val to_string : t -> string
end = struct
  type intInterval = Interval of int * int 
		   | Empty

  type t = intInterval

  let create (low: int) (high:int) : t =
    Interval (low, high)

  let is_empty (i:intInterval) : bool =
    match i with
    | Empty -> true
    | Interval _ -> false

  let contains (i:intInterval) (x:int) : bool =
    match i with
    | Empty -> false
    | Interval (l,h) -> l <= x && x <= h

  let intersect (i1:intInterval) (i2:intInterval) : intInterval =
    match i1, i2 with
    | Empty, _ | _, Empty -> Empty
    | Interval (l1, h1), Interval (l2, h2) ->
       Interval (max l1 l2, min h1 h2)

  let to_string (i:intInterval) : string =
    match i with
    | Empty -> "Empty"
    | Interval (l,h) -> "(" ^ string_of_int l ^ ", " ^ string_of_int h ^ ")"
end

