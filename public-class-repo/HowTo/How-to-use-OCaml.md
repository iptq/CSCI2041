# How to use OCaml

### Install OCaml

Go back to your account home directory:
```
% cd
```

Execute the following commands
```
% module add soft/ocaml
% module initadd soft/ocaml
```

The first makes the OCaml tools available for your current shell
session, the second makes them available for future shell sessions.

Execute the following:
```
% which ocaml
```
If it does not display the path to the ocaml compiler 
(it should be **/soft/ocaml-4.03.0/linux_x86_64/bin/ocaml**) 
then talk to your TA.


# PLEASE FIX BELOW ! ! !

### Use OCaml

Go back to the lab_01 directory in your individual repository.
Perhaps by the following commands: 
```
% cd
% cd csci2041/repo-user0123/Lab_01
```

Start the OCaml interpreter:
```
% ocaml
```

At the Ocaml prompt (#) enter the following (do type "#use", not just
"use"): 
```
#  #use "fib.ml" ;;
```
Note that the prompt is "#" and directives to the interpreter to load
files and quit also begin with a "#". 

OCaml will report an error in the program:
> File "fib.ml", line 10, characters 30-31:
> Error: Unbound value n 

Quit OCaml using the "quit" command as illustrated below:
```
# #quit ;;
```

Use an editor of your choice (emacs, vim, gedit, etc.) to replace 
the variable `n` with the correct variable `x`.

Also, replace the text between dots in the comment with your name if
you've not already done so.

Save the file and repeat the steps above to start OCaml and load the file.

Now compute the 5th Fibonacci number by typing the following:
```
# fib 5 ;;
```

There is a bug in this program.  It will return `16` instead of the
correct answer of `5`.  Let's fix that bug now.
