module type Arithmetic = sig
  type t
  val zero: t
  val add: t -> t -> t
  val mul: t -> t -> t
  val str: t -> string
end

module type Vector = sig
  type t
  type endpoint
  val create: int -> endpoint -> t
  val from_list: endpoint list -> t
  val to_list: t -> endpoint list
  val scalar_add: endpoint -> t -> t
  val scalar_mul: endpoint -> t -> t
  val scalar_prod: t -> t -> endpoint option
  val to_string: t -> string
  val size: t -> int
end

module Make_vector (Endpoint:Arithmetic) : (Vector with type endpoint := Endpoint.t) = struct
  type t = Vector of Endpoint.t list
  let create size init =
    let rec create' c n =
      if c = 0 then []
      else n :: create' (c - 1) n
    in Vector (create' size init)
  let size v =
    match v with
    | Vector lst -> List.length lst
  let from_list lst =
    Vector lst
  let to_list v =
    match v with
    | Vector lst -> lst
  let scalar_add a b =
    let rec s_add lst =
      match lst with
      | [] -> []
      | x :: xs -> Endpoint.add a x :: s_add xs
    in match b with 
    | Vector b' -> Vector (s_add b')
  let scalar_mul a b =
    let rec s_mul lst =
      match lst with
      | [] -> []
      | x :: xs -> Endpoint.mul a x :: s_mul xs
    in match b with
    | Vector b' -> Vector (s_mul b')
  let scalar_prod a b =
    if size a <> size b then None
    else let rec d_prod (m:Endpoint.t list) (n:Endpoint.t list) (s:Endpoint.t): Endpoint.t option =
      match (m, n, s) with
      | ([], [], s') -> Some s'
      | (_ :: _, [], s') -> None
      | ([], _ :: _, s') -> None
      | (m' :: ms, n' :: ns, s') -> d_prod ms ns (Endpoint.add s' (Endpoint.mul m' n'))
    in match a, b with
    | Vector alst, Vector blst -> d_prod alst blst Endpoint.zero
  let to_string v =
    let join lst sep: string =
      let rec join' lst =
        match lst with
        | [] -> ""
        | hd :: tl -> sep ^ (Endpoint.str hd) ^ (join' tl)
      in match lst with
      | [] -> ""
      | hd :: tl -> (Endpoint.str hd) ^ (join' tl)
    in match v with
    | Vector lst -> "<< " ^ (string_of_int (size v)) ^ " | " ^ (join lst ", ") ^ " >>"
end
