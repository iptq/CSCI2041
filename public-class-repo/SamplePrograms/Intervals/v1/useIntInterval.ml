

let i1 = IntInterval.Interval (3, 4)

let i2 = IntInterval.Interval (3, 6)

let () = 
  print_endline ("An interval: " ^ IntInterval.to_string i1) ;

  print_endline ("Another interval: " ^ IntInterval.to_string i2) ;

  print_endline ("Their intresection: " ^ 
		   IntInterval.to_string (IntInterval.intersect i1 i2)) ;
