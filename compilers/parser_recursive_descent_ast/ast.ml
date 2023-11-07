
open Printf


type bop = BopAdd | BopSub | BopMul | BopDiv
type uop = UnopMinus

type expr =
  | EInt   of int
  | EBinOp of bop * expr * expr
  | EUnOp  of uop * expr
  | ELet   of string * expr * expr
  | EVar   of string

let pprint_bop = function
  | BopAdd -> "+"
  | BopSub -> "-"
  | BopMul -> "*"
  | BopDiv -> "/"

let pprint_uop = function
  | UnopMinus -> "-"

let rec pprint_expr = function
  | EInt(i) -> sprintf "EInt(%d)" i
  | EBinOp(bop, e1, e2) ->
     "EBinOp(" ^ pprint_bop bop ^ ", " ^ pprint_expr e1 ^ "," ^ pprint_expr e2 ^ ")"
  | EUnOp(uop, e) ->
     "EUnOp(" ^ pprint_uop uop ^ ", " ^ pprint_expr e ^ ")"
  | ELet(x, e1, e2) -> "ELet(" ^ x ^ ", " ^ pprint_expr e1 ^ ",\n" ^
                            pprint_expr e2 ^ ")"
  | EVar(x) -> "EVar(" ^ x ^ ")"
