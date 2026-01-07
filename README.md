# OCaml Examples

Copyright (C) David Broman, 2022-2026, MIT Licence

This repo consists of various small example files written in OCaml. Please feel free to use these examples directly within your projects.

## Compiler Examples

Under the folder [compilers](compilers/) there are a number of small examples showing you how to write parts of a compiler using OCaml. For each of the projects, there is a corrsponding YouTube video that expains the example in details. Please check out the [playlist on YouTube](https://www.youtube.com/playlist?list=PLmG_3qmc10qQKLgP2H_d2BHHzD3RQWBE_) where you can find all the videos.

* [compilers/lexing](compilers/lexing): This example shows how to write a small independent lexer in ocamllex. The example takes a string as input and generates a list of tokens. See also the [video](https://youtu.be/SDd9XLlAILc).

* [compilers/parser_ocamlyacc](compilers/parser_ocamlyacc): This example shows how to create a grammar in yacc where precedence is given explicitly using productions. The example does not have any error handling. Please check out the Menhir example for error handling and how to make the grammar definition simpler. See also the [video](https://youtu.be/be5kY3ZgQRg).

* [compilers/parser_menhir](compilers/parser_menhir): A simple example showing how to parse using Menhir. This example shows how to use precedence in the grammar file, how to give simple error messages, and how to use some of Menhir's syntax extensions. For more comprehensive error reporting, please see the Menhir manual. See also the [video](https://youtu.be/IiBQBldP4S0)

* [compilers/parser_menhir_ast](compilers/parser_menhir_ast): An extended example with Menhir that outputs an abstract syntax tree (AST). The example also shows how keywords are handled, and how to pretty print the AST. See also the [video](https://youtu.be/ly7yvyaDj08)

* [compilers/interpreter_arith_let](compilers/interpreter_arith_let): In this example, we extend the example `compilers/parser_menhir_ast` with an evaluation function, demonstrating how to create an interpreter that can handle both arithmetic expressions and let expressions. For the latter, we also introduce a simple environment for binding names to values.

* [compilers/interpreter_lambda](compilers/interpreter_lambda) : This example shows how to implement the untyped lambda calculus in a big-step operational semantics setting. That is, as an interpreter using an environment and closures. The example is an extension of `compilers/interpreter_arith_let`.

* [compilers/parser_recursive_descent_ast](compilers/parser_recursive_descent_ast): An example showing how to implement the same program as in `compilers/parser_menhir_ast`, but using a hand-written recursive descent parser instead. There is currently no video exactly for this code, but you can take a look this general video on [recursive descent parsing](https://youtu.be/T4J3BPy__CU?si=s0nQIlJDi9Ojg5vy). You may also be interested in this video on [Precedence, Associativity, and Rewriting Ambiguous Context-Free Grammars](https://youtu.be/NV91u1VSqfY?si=WnOZGzB8ie6AQxnM) and this one on [Eliminating Left Recursion in Context-Free Grammars](https://youtu.be/bzB9AiAPJVg?si=YJElSFhGhcix-8KM).