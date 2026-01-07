(* A simple arithmetic interpreter with let bindings and environments.
 * Copyright (C) David Broman, 2026. MIT License.
 *
 * In this example, we extend the example 'parser_menhir_ast' with an
 * evaluation function, demonstrating how to create an interpreter
 * that can handle both arithmetic expressions and let expressions.
 * For the latter, we also introduce a simple environment for binding
 * names to values.
 *
 * Compile using 'make'. Run example using standard input
 *   ./main.native < test1.txt
 *
 *)

open Printf
open Ast
open Eval

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
  printf "%s\n" (pprint_expr res);
  printf "----------\n";
  printf "%s\n" (pprint_expr (eval [] res));
