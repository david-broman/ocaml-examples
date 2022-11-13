
(* A simple example showing how to parse using Menhir
 * By David Broman (C) 2022.
 *
 * This example shows how to use precedence in the grammar
 * file, how give simple error messages, and how to use
 * some of Menhir's syntax extensions. For more comprehensive
 * error reporting, please see the Menhir manual.
 * http://gallium.inria.fr/~fpottier/menhir/
 *
 * This video shows how the code is created:
 *   http://
 *)

open Printf


let main =
  let lexbuf = Lexing.from_channel stdin in
  let res =
    try Parser.main Lexer.token lexbuf
    with
    | Lexer.Error c ->
       fprintf stderr "Lexical error at line %d: Unknown character '%c'\n"
         lexbuf.lex_curr_p.pos_lnum c;
       exit 1
    | Parser.Error ->
       fprintf stderr "Parse error at line %d:\n" lexbuf.lex_curr_p.pos_lnum;
       exit 1
  in
    Printf.printf "Result: %d\n" res
