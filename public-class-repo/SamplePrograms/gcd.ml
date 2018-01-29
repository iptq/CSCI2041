let gcd m n = 
  let smallest = if m < n then m else n
  in
  let rec helper guess = 
        if m mod guess = 0 && n mod guess = 0 then guess
        else helper (guess - 1)

  in helper smallest
