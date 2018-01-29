## Feedback for Homework 07

Run on April 26, 10:31:29 AM.

+ Pass: Change into directory "Hwk_07".

+ Pass: Check that file "hwk_07.ml" exists.

+ Pass: Check that it's possible to build and execute an ocaml script using your code.
- Pass: `Int_vector.size (Int_vector.create 10 1)` equivalent to `10`
- Pass: `Int_vector.to_list (Int_vector.create 10 1)` equivalent to `[1;1;1;1;1;1;1;1;1;1]`
- Pass: `Int_vector.size (Int_vector.from_list [1;2;3;4;5])` equivalent to `5`
- Pass: `Int_vector.to_list (Int_vector.scalar_add 3 (Int_vector.from_list [1;2;3;4;5]))` equivalent to `[4; 5; 6; 7; 8]`
- Pass: `Int_vector.to_list (Int_vector.scalar_mul 10 (Int_vector.from_list [1;2;3;4;5]))` equivalent to `[10; 20; 30; 40; 50]`
- Pass: `Int_vector.scalar_prod (Int_vector.scalar_add 3 (Int_vector.from_list [1;2;3;4;5])) (Int_vector.scalar_mul 10 (Int_vector.from_list [1;2;3;4;5]))` equivalent to `Some 1000`
- Pass: `(let 
                regex = (Str.regexp "^ *<< *10 *\| *1 *, *1 *, *1 *, *1 *, *1 *, *1 *, *1 *, *1 *, *1 *, *1 *,? *>> *") and 
                resu = (Int_vector.to_string (Int_vector.create 10 1)) in 
                Str.string_match regex resu 0)` equivalent to `true`
- Pass: `(Complex_vector.size (Complex_vector.from_list [ (1.0, 2.0); (3.0, 4.0); (5.0, 6.0) ]))` equivalent to `3`
- Pass: `(Complex_vector.to_list (Complex_vector.create 5 (1., 0.)))` equivalent to `[(1., 0.); (1., 0.); (1., 0.); (1., 0.); (1., 0.)]`
- Pass: `(Complex_vector.to_list (Complex_vector.scalar_add (0., 4.) (Complex_vector.from_list [ (1.0, 2.0); (3.0, 4.0); (5.0, 6.0) ])))` equivalent to `[(1., 6.); (3., 8.); (5., 10.)]`
- Pass: `(Complex_vector.scalar_prod (Complex_vector.create 3 (1.0, 0.0)) (Complex_vector.create 5 (0., 1.)))` equivalent to `None`
- Pass: `(Complex_vector.to_list (Complex_vector.scalar_mul (3., 5.) (Complex_vector.from_list [ (1.0, 2.0); (3.0, 4.0); (5.0, 6.0) ])))` equivalent to `[(-7., 11.); (-11., 27.); (-15., 43.)]`

**Total: 12 / 12**




