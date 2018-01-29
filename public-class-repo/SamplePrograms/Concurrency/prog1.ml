(* From 

  http://www.cs.cornell.edu/courses/cs3110/2011sp/lectures/lec17-concurrency/concurrency.htm
 *)

let prog1 n =
  let result = ref 0 in
  let f i =
    for j = 1 to n do
      let v = !result in
      Thread.delay (Random.float 1.);
      result := v + i;
      Printf.printf "Value %d\n" !result;
      flush stdout
    done in
  ignore (Thread.create f 1);
  ignore (Thread.create f 2)
