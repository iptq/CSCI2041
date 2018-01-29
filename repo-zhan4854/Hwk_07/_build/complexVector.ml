open Vector

module Complex_arithmetic: (Arithmetic with type t = float * float) = struct
  type t = float * float
  let zero = (0.0, 0.0)
  let str x =
    match x with
    | (a, b) -> "(" ^ (string_of_float a) ^ (if b >= 0.0 then "+" else "-") ^ (string_of_float (abs_float b)) ^ "i)"
  let add x y =
    match x, y with
    | (a, b), (c, d) -> (a +. c, b +. d)
  let mul x y =
    match x, y with
    | (a, b), (c, d) -> (a *. c -. b *. d, a *. d +. b *. c)
end

module Complex_vector = Make_vector (Complex_arithmetic)
