type nat = Zero | Succ of nat

let rec toInt n = match n with
  | Zero -> 0
  | Succ n' -> 1 + toInt n'

