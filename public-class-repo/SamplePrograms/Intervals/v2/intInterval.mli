(* An interface file for the intInterval that hides the implementation
   type.
 *)

type t

val create : int -> int -> t

val is_empty : t -> bool

val contains : t -> int -> bool

val intersect : t -> t -> t

val to_string : t -> string
