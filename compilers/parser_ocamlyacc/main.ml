
(* A simple example showing how to parse using OCamlyacc.
 * By David Broman (C) 2022.
 *
 * This example shows how to create a grammar in yacc
 * where precedence is given explicitly using productions.
 *
 * This video shows how the code is created:
 *   http://
 *
 * This example does not have any error handling. Please
 * check out the Menhir example for error handling and
 * how to make the grammar definition simpler.
 *)


let main =
  let lexbuf = Lexing.from_channel stdin in
  let res = Parser.main Lexer.token lexbuf in
  Printf.printf "Result: %d\n" res
