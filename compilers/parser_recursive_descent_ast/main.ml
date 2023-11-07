(* A parser example using a hand-written recursive descent parser that
 * outputs an abstract syntax tree (AST).
 * Copyright (C) David Broman, 2023. MIT License.
 *
 * This example shows how to parse and generate an abstract syntax tree.
 * The example also shows how keywords are handled, and how to
 * pretty print the AST. It also illustrates how to read from a file or
 * standard input.
 *
 * Compile using 'make'. Run example using standard input
 *   ./main.native < test.txt
 * or using filename
 *   ./main.native test.txt
 *)

open Printf
open Ast
open Lexer

(* Reads from channel into a list of characters *)
let read_channel_to_list channel =
  let len = in_channel_length channel in
  let data = really_input_string channel len in
  List.init len (String.get data)


let main =
  (* Read from stdin or from file. Returns a list of chars,
     which is easy to do lexing from *)
  let lst =
    if Array.length Sys.argv = 1 then read_channel_to_list stdin
    else
      let ch = open_in (Array.get (Sys.argv) 1) in
      let lst = read_channel_to_list ch in
      close_in ch;
      lst
  in
  (* Comment out below if you want to print the input character list *)
  (* List.iter (printf "%c") lst*)

  (* Comment out below if you want to print the token sequence *)
  lst |> lexing |> List.map pprint_token |> List.iter (printf "%s," );
  printf "\n"



(*

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
 *)
