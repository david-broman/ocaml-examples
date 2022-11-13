
(* Simple lexing and pretty printing of tokens. By David Broman (C) 2022.
 *
 * This simple example shows how the lexer works as a stand-alone
 * application. The example takes a string as input and
 * creates a list of tokens.
 *
 * This video shows how the code is created:
 *   http://
 *
 * If you would like to read from the
 * standard input instead, change line
 *
 *   let lexbuf = Lexing.from_string "10 + 2 * 3" in
 *
 * to
 *
 *   let lexbuf = Lexing.from_channel stdin in
 *)

open Printf
open Tokens

let get_token_list lexbuf =
  let rec work acc =
    match Lexer.token lexbuf with
    | EOF -> acc
    | t -> work (t::acc)
  in List.rev (work [])

let pp_token = function
  | ADD -> "ADD"
  | MUL -> "MUL"
  | INT(i) -> sprintf "INT(%d)" i
  | EOF -> "EOF"

let main =
  let lexbuf = Lexing.from_string "10 + 2 * 3" in
  let token_list = get_token_list lexbuf in
  List.map pp_token token_list |> List.iter (printf "%s\n")
