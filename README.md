# OCaml Examples

Copyright (C) David Broman, 2022, MIT Licence

This repo consists of various small example files written in OCaml. Please feel free to use these examples directly within your projects.

## Compiler Examples

Under the folder [compilers](compilers/) there are a number of small examples showing you how to write parts of a compiler using OCaml. For each of the videos, there is a corrsponding YouTube video that expains the example in details. Please check out the [playlist on YouTube](https://www.youtube.com/playlist?list=PLmG_3qmc10qQKLgP2H_d2BHHzD3RQWBE_) where you can find all the videos.

* `compilers/lexing`: This example shows how to write a small independent lexer in ocamllex. The example takes a string as input and generates a list of tokens. See also the [video](https://youtu.be/SDd9XLlAILc).

* `compilers/parsing_ocamlyacc`: This example shows how to create a grammar in yacc where precedence is given explicitly using productions. The example does not have any error handling. Please check out the Menhir example for error handling and how to make the grammar definition simpler. See also the [video](https://youtu.be/be5kY3ZgQRg).

* `compilers/parser_menihir`: A simple example showing how to parse using Menhir. This example shows how to use precedence in the grammar file, how to give simple error messages, and how to use some of Menhir's syntax extensions. For more comprehensive error reporting, please see the Menhir manual. See also the [video](https://youtu.be/IiBQBldP4S0)

* `compilers/parser_menihir_ast`: An extended example with Menhir that outputs an abstract syntax tree (AST). The example also shows how keywords are handled, and how to pretty print the AST. See also the [video](https://youtu.be/ly7yvyaDj08)
