(* A sample use of the new IntInterval that hides the
   implementation type.

   To compile:
   % corebuild useIntInterval.byte
 *)

(* This 'open' makes visible all the names declared at the top level
   of the Intervals modules, which is the contents of the intervals.ml
   file.
 *)
open Intervals

let i1 = IntInterval.create 3 4

let i2 = IntInterval.create 3 6

let () = 
  print_endline ("An interval: " ^ IntInterval.to_string i1) ;
  print_endline ("Another interval: " ^ IntInterval.to_string i2) ;
  print_endline ("Their intresection: " ^ 
		   IntInterval.to_string (IntInterval.intersect i1 i2)) ;

