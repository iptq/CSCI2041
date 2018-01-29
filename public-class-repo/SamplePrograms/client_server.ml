(* You must load "streams.ml" before this file.  The functions
   below use Cons streams.

   A client sends requests to a server, which returns its responses.
 *)

(* The requests are a (lazy) stream, as are the responses.
   This allows the required communication between these
   two processes.
 *)

(* We need an initial_value to get things started. *)
let initial_value = 0 



let rec client resps = 

  (* The client determines its next request based on 
     the most recent response from the server. *)
  let next_request current_response = current_response + 2 in

  match resps with 
  | Cons (this_response, more_responses_f) ->
     (* return the stream with the next request at the front,
        and the rest of the requests underneath a lambda expression
        to prevent them from being evaluated just yet.
      *)
     print_endline ("client: " ^ string_of_int this_response) ;
     Cons ( next_request this_response, fun () -> client (more_responses_f ())  )
	    
and server requests =

  (* The server determines is next response based on
     the previous request.  *)
  let next_response current_request = current_request + 3 in

  match requests with
  | Cons (this_request, more_requests_f) -> 
     print_endline ("server: " ^ string_of_int this_request ) ;
     Cons ( next_response this_request, fun () -> server (more_requests_f ()) )

and requests_f () = Cons (initial_value,
			 fun () -> client (responses_f () ) )

and responses_f () = server (requests_f ())


(* We can start this process in a number of ways, here are a few: *)
let some_requests = take 10 (requests_f ())

let some_responses = take 10 (responses_f ())

let some_client_results = take 10 (client (responses_f ()))

let some_server_results = take 10 (server (requests_f ()))

(* 
So, the code above appears to work, except that we see many more print
statements being executed than we would hope to.  

Why is this?  The short answer is that our streams are not
implementing lazy evaluation but instead are implementing call by name
semantics.

Thus, the optimization in laziness is not applied and we see the
evaluation happening many times instead of one time.

See the examples in "lazy.ml" as inspiration for addressing this problem.

*)
