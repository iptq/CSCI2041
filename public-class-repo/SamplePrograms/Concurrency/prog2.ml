(* From 

  http://www.cs.cornell.edu/courses/cs3110/2011sp/lectures/lec17-concurrency/concurrency.htm
 *)

let prog2 n =
  let result = ref 0 in
  let m = Mutex.create () in
  let f i =
    for j = 1 to n do
      Mutex.lock m;
      let v = !result in
      Thread.delay (Random.float 1.);
      result := v + i;
      Printf.printf "Value %d\n" !result;
      flush stdout;
      Mutex.unlock m;
      Thread.delay (Random.float 1.)
    done in
  ignore (Thread.create f 1);
  ignore (Thread.create f 2)
