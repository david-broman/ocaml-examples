
open Printf

(* Token types *)
type token =
  | TokInt of int
  | TokEq          (* '=' *)
  | TokAdd         (* '+' *)
  | TokSub         (* '-' *)
  | TokMul         (* '*' *)
  | TokDiv         (* '/' *)
  | TokLParen      (* '(' *)
  | TokRParen      (* ')' *)
  | TokLet         (* 'let' *)
  | TokIn          (* 'in'  *)
  | TokIdent of string

(* Returns longest string prefix matching predicate 'pred' *)
let string_until pred lst =
  let retv a xs = (List.rev a |> List.to_seq |> String.of_seq, xs) in
  let rec work acc = function
    | x::xs -> if pred x then work (x::acc) xs else retv acc xs
    | [] -> retv acc []
  in work [] lst

(* Predefined predicates *)
let is_digit x = x >= '0' && x <= '9'
let is_letter x = (x = '_') || (x >= 'a' && x <= 'z') || (x >= 'A' && x <= 'Z')
let is_digit_letter x = is_digit x || is_letter x

(* Toking of a list of characters into a list of tokens *)
let lexing lst =
  let rec work acc = function
    | x::xs when is_digit x ->
       let (y,ys) = string_until is_digit (x::xs) in
       work (TokInt(int_of_string y)::acc) ys
    | '/'::'/'::xs ->
       let (_,ys) = string_until (fun x -> x <> '\n') xs in
       work acc ys
    | '='::xs -> work (TokEq::acc) xs
    | '+'::xs -> work (TokAdd::acc) xs
    | '-'::xs -> work (TokSub::acc) xs
    | '*'::xs -> work (TokMul::acc) xs
    | '/'::xs -> work (TokDiv::acc) xs
    | '('::xs -> work (TokLParen::acc) xs
    | ')'::xs -> work (TokRParen::acc) xs
    | ' '::xs | '\t'::xs | '\n'::xs -> work acc xs
    | x::xs when is_letter x ->
       let (y,ys) = string_until is_digit_letter (x::xs) in
       (match y with
        | "let" -> work (TokLet::acc) ys
        | "in" -> work (TokIn::acc) ys
        | x -> work (TokIdent(x)::acc) ys)
    | [] -> List.rev acc
    | x::_ -> failwith (sprintf "Toking error: unknown character '%c'." x)
  in
  work [] lst


(* Test function for printing tokens *)
let pprint_token = function
  | TokInt(x) -> sprintf "TokInt(%d)" x
  | TokEq -> "TokEq"
  | TokAdd -> "TokAdd"
  | TokSub -> "TokSub"
  | TokMul -> "TokMul"
  | TokDiv -> "TokDiv"
  | TokLParen -> "TokLParen"
  | TokRParen -> "TokRParen"
  | TokLet -> "TokLet"
  | TokIn -> "TokIn"
  | TokIdent(s) -> sprintf "TokIdent(%s)" s
