(* From Real World OCaml, Chapter 4 
 *)

module type ID = sig
    type t
    val of_string : string -> t
    val to_string : t -> string
  end

module String_id = struct
  type t = string
  let of_string x = x
  let to_string x = x
  let append s1 s2 = s1 ^ s2
end

module Username : ID = String_id

module Hostname : ID = String_id

type session_info = { user: Username.t;
		      host: Hostname.t;
		      when_started: int;
		    }

let sessions_have_same_user s1 s2 =
  s1.user = s2.user

let app (s1:Username.t) (s2:Username.t) = 
  Username.of_string (Username.to_string s1 ^ Username.to_string s2)




(* This access of append from the Username module is not allowed
     let app2  = Username.append
   But
     let app2 = String_id.append
   is allowed.
 *)

let app2 = String_id.append


