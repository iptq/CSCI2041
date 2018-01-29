(* A sample use of the new IntInterval that hides the
   implementation type.
 *)

(* We now use the 'create' function instead of the hidden "Interval"
   value constructor. *)

let i1 = IntInterval.create 3 4

let i2 = IntInterval.create 3 6

let () = 
  print_endline ("An interval: " ^ IntInterval.to_string i1) ;
  print_endline ("Another interval: " ^ IntInterval.to_string i2) ;
  print_endline ("Their intresection: " ^ 
		   IntInterval.to_string (IntInterval.intersect i1 i2)) ;

(* Try uncommenting out these lines to see if we really can't use the
   Interval value constructor.

   In utop, we (gasp!) can, if we "mod_use" the source file since this
   ignores the .mli file.

   When using the compiler, via corebuild, then IntInterval.Interval
   is not defined.  It is hidden.  We only see the abstract type t.

   The command
   % corebuild useIntInterval.byte
   shows the error.
 *)
(*
let i3 = IntInterval.Interval (3, 4)

let i4 = IntInterval.Interval (3, 6)
 *)


