(* An extended example with Menhir that outputs an abstract syntax tree (AST).
 * Copyright (C) David Broman, 2022. MIT License.
 *
 * This example shows how to parse and generate an abstract syntax tree.
 * The example also shows how keywords are handled, and how to
 * pretty print the AST.
 *
 * Compile using 'make'. Run example using standard input
 *   ./main.native < test.txt
 *
 * This video shows how the code is created:
 *   https://youtu.be/ly7yvyaDj08
 *)

open Printf
open Ast

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
    let _ = res in
    Printf.printf "%s\n" (pprint_expr res)
