open Vector

module Int_arithmetic: (Arithmetic with type t = int) = struct
  type t = int
  let zero = 0
  let add x y = x + y
  let mul x y = x * y
  let str x = string_of_int x
end

module Int_vector = Make_vector (Int_arithmetic)
