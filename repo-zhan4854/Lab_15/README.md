CSCI 2041 - Homework 06
=======================

**TODO** Write an introduction.
I'm a fan of the "most programs are transformations from A to B, the only unusual thing about compilers is that A and B are languages."
Point out that an executable isn't magic, it's written in machine code.
Be all like "remember 2021," bask in uncomfortable squirming.

Step One - Become familiar with the project layout
--------------------------------------------------

Copy the `Hwk_06` directory from the public class repo to your personal repo.
It contains many files, but we will cover the most important ones here.
The `examples` directory contains several example programs written in `Src_lang`, as well as the numeric results they should produce.
The `src` directory contains the OCaml source of the project.
The `build.sh` script compiles and runs the `main.ml` file, compiles its output into an executable, and runs it.

There are a few OCaml files in the `src` directory:

 - `common.ml` contains the features common to both `Src_lang` and `Tgt_lang`, namely `BinOps` (i.e. +, -, *, /, and %) and the concept of an environment.
 - `driver.ml` contains glue code that parses and compiles `Src_lang` code, handling exceptions.
 - `lexer.mll` and `parser.mly` contain the parser. See "Going Further" below if you're interested in these.
 - `main.ml` simply reads a file in and runs it.
    If you want to do debugging, this is the place.
 - `src_lang.ml` contains the definition of `Src_lang`, as well as pretty-printing and type-checking.
 - `tgt_lang.ml` contains the definition of `Tgt_lang`, as well as pretty-printing and type-checking.
 - `translate.ml` is the main file you will be working with.
    It contains a function `translate : Src_lang.program -> Tgt_lang.program`.

Step Two - Compiling math expressions
-------------------------------------

To begin with, we want to be able to compile simple mathematical expressions.
These are largely the same in `Src_lang` and `Tgt_lang`, so this step should be fairly easy.

Create a `translate_expr` function that converts an expression.
Its type should be `Src_lang.typ_ env -> Src_lang.expr -> Tgt_lang.expr`.
The first argument is a "type environment," which allows looking up the types of variables.
For example, in the translation of `2+x` in `let x = 4 in 2 + x`, the type environment would have the value `[("x", Src_lang.IntType)]`.

Once this is complete, try running `./build.sh examples/one.src.txt`.

**TODO**

Going Further
-------------

Parser Resources:

 - [*Modern Compiler Implementation*](https://www.cs.princeton.edu/~appel/modern/) - The first few chapters cover traditional parsing techniques. This book is available in Java, Standard ML (similar to OCaml), or C.
 - [Parsing with Derivatives: A Functional Pearl](http://matt.might.net/papers/might2011derivatives.pdf) - A different approach to parsing. This paper doesn't assume too much knowledge, but skimming the parsing chapters in *Modern Compiler Implementation* might be advantageous.

Compiler Resources:

 - [An Incremental Approach to Compiler Construction](http://schemeworkshop.org/2006/11-ghuloum.pdf) - If you know Lisp and passed 2021, this is a good entry-level text. Deals with compiling Scheme to x86 Assembly.
 - [*Compilers: Principles, Techniques, and Tools*](https://dl.acm.org/citation.cfm?id=6448) - More in-depth than *Modern Compiler Implementation*, but requires more up-front knowledge too.
 - [Implementing a language with LLVM](http://llvm.org/docs/tutorial/OCamlLangImpl1.html) - A basic tutorial on how to use the LLVM framework as a backend. Assumes familiarity with OCaml, but not LLVM or compilation techniques.
 - [*Lisp In Small Pieces*](https://en.wikipedia.org/wiki/Lisp_in_Small_Pieces) - If you're a Lisp fan, this is an excellent reference to writing Lisp interpreters and compilers. Many of the techniques here are also applicable for compiling other functional languages as well, although this text does not cover type-checking or type inference.
 - [*Modern Compiler Implementation*](https://www.cs.princeton.edu/~appel/modern/) - A standard text for developing a compiler for imperative languages.
 - [*The Implementation of Functional Programming Languages*](https://www.microsoft.com/en-us/research/publication/the-implementation-of-functional-programming-languages/) - Covers the compilation (but not parsing) of a lazy functional language. Largely applicable to eagerly-evaluated functional languages as well.
