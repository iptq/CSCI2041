(* Constructing lazy values in OCaml *)

type 'a lazee = 'a hidden ref

 and 'a hidden = Value of 'a 
               | Thunk of (unit -> 'a)

let delay (unit_to_x: unit -> 'a) : 'a lazee = ref (Thunk unit_to_x)

let force (l: 'a lazee) : unit = match !l with
  | Value _ -> ()
  | Thunk f -> l := Value (f ())

let rec demand (l: 'a lazee) : 'a = force l; match !l with
  | Value v -> v
  | Thunk f -> raise (Failure "this should not happen")



(* Streams, using lazy values *)
type 'a stream = Cons of 'a * 'a stream lazee

let rec from n = 
  print_endline ("step " ^ string_of_int n) ; 
  Cons ( n, 
         delay (fun () -> from (n+1) )
       )

let nats = from 1

let head (s: 'a stream) : 'a = match s with
  | Cons (v, _) -> v

let tail (s: 'a stream) : 'a stream = match s with
  | Cons (_, tl) -> demand tl

let rec take (n:int) (s : 'a stream) : ('a list) =
 match n, s with
 | 0, _ -> []
 | _, Cons (v, tl) -> v :: take (n-1) (demand tl)

(* Can we write functions like map and filter for these 
   lazy streams? *)

let rec filter (f: 'a -> bool) (s: 'a stream) : 'a stream =
  match s with
  | Cons (hd, tl) ->
     let rest = delay (fun () -> filter f (demand tl))
     in
     if f hd then Cons (hd, rest) else demand rest

let even x = x mod 2 = 0

let rec squares_from n : int stream = 
  Cons (n*n, delay (fun () -> squares_from (n+1) ))

let squares = squares_from 1


let rec zip (f: 'a -> 'b -> 'c) (s1: 'a stream) (s2: 'b stream) : 'c stream =
  match s1, s2 with
  | Cons (hd1, tl1), Cons (hd2, tl2) ->
     Cons (f hd1 hd2, delay (fun () -> zip f (demand tl1) (demand tl2) ))


let factorials = 
  let rec factorials_from n = 
    Cons ( n, delay (fun () -> zip ( * ) nats (factorials_from (n) )))
  in factorials_from 1

