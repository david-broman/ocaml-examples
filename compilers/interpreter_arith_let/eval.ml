open Ast

let rec eval env = function
  | EInt(x) -> EInt(x)
  | EBinOp(op, e1, e2) ->
     (match eval env e1, eval env e2, op with
      | EInt(x1), EInt(x2), BopAdd -> EInt(x1 + x2)
      | EInt(x1), EInt(x2), BopSub -> EInt(x1 - x2)
      | EInt(x1), EInt(x2), BopMul -> EInt(x1 * x2)
      | EInt(x1), EInt(x2), BopDiv -> EInt(x1 / x2)
      | e1,e2,__ -> failwith ("Both '" ^ pprint_expr e1 ^ "' and '" ^
                               pprint_expr e2 ^ "' need to be integers."))
  | EUnOp(op, e) ->
     (match eval env e, op with
      | EInt(x), UnopMinus -> EInt(-x)
      | e, _ -> failwith ("Value '" ^ pprint_expr e ^
                            "' needs to be an integer."))
  | ELet(x, e1, e2) ->
     let v = eval env e1 in
     eval ((x, v)::env) e2
  | EVar(x) -> List.assoc x env


