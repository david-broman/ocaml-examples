(* An extended interpreter that handles lambdas and closures.
 * Copyright (C) David Broman, 2026. MIT License.
 *
 * This example shows how to implement the untyped lambda calculus in
 * a big-step semantics setting. That is, as an interpreter using an
 * environment and closures. The example is an extension of
 * `compilers/interpreter_arith_let`.
 *
 * Compile using 'make'. Run example using standard input
 *   ./main.native < test.txt
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
