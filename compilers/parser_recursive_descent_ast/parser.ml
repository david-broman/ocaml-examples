

open Lexer
open Ast

let rec parse_factor tokens =
  match tokens with
  (* Integer literal *)
  | TokInt(i)::next_tokens -> (next_tokens, EInt(i))
  (* Variables *)
  | TokIdent(x)::next_tokens -> (next_tokens, EVar(x))
  (* '(' and ')' *)
  | TokLParen::next_tokens ->
     let (tokens2, expr) = parse_expr next_tokens in
     (match tokens2 with
      | TokRParen::next_tokens2 -> (next_tokens2, expr)
      | _ -> failwith "Parse error: Missing closing parenthesis.")
  | _ -> failwith "Parse error: Unexpected token."

and parse_term_prime tokens expr =
  match tokens with
  (* '*' binary operation *)
  | TokMul::next_tokens ->
     let (tokens2, expr2) = parse_factor next_tokens in
     parse_term_prime tokens2 (EBinOp(BopMul, expr, expr2))
  (* '/' binary operation *)
  | TokDiv::next_tokens ->
     let (tokens2, expr2) = parse_factor next_tokens in
     parse_term_prime tokens2 (EBinOp(BopDiv, expr, expr2))
  | _ -> (tokens, expr)

and parse_term tokens =
  let (tokens2, expr) = parse_factor tokens in
  parse_term_prime tokens2 expr

and parse_expr_prime tokens expr =
  match tokens with
  (* '+' binary operation *)
  | TokAdd::next_tokens ->
     let (tokens2, expr2) = parse_term next_tokens in
     parse_expr_prime tokens2 (EBinOp(BopAdd, expr, expr2))
  (* '-' binary operation *)
  | TokSub::next_tokens ->
     let (tokens2, expr2) = parse_term next_tokens in
     parse_expr_prime tokens2 (EBinOp(BopSub, expr, expr2))
  | _ -> (tokens, expr)

and parse_expr tokens =
  match tokens with
  (* 'let' expression *)
  | TokLet::TokIdent(x)::TokEq::next_tokens ->
     let (tokens2, expr) = parse_expr next_tokens in
     (match tokens2 with
      | TokIn::next_tokens2 ->
         let (tokens2, expr2) = parse_expr next_tokens2 in
         (tokens2, ELet(x, expr, expr2))
      | _ -> failwith "Parse error: unexpected token. Expected 'in'")
  | _ ->
     let (tokens2, expr) = parse_term tokens in
     parse_expr_prime tokens2 expr

let parse tokens =
  let (tokens2, expr) = parse_expr tokens in
  if tokens2 <> [] then failwith "Parse error: unexpected end of file."
  else expr
