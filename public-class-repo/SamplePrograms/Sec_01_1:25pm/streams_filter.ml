(* This is the filter function we wrote in class.

   It differs a bit from the one in the file "streams.ml".
 *)

let rec filter (f: 'a -> bool) (s: 'a stream) : 'a stream = 
  match s with
  | Cons (h, t) -> if f h then Cons (h, (fun () -> filter f (t ())))
                          else filter f (t ())
