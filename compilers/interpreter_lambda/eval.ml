open Ast

let bop = function
  | BopAdd -> (+) | BopSub -> (-) | BopMul -> ( * ) | BopDiv -> (/)

let rec eval env = function
  | EInt(x) -> EInt(x)
  | EBinOp(op, e1, e2) ->
     (match eval env e1, eval env e2, op with
      | EInt(x1), EInt(x2), op -> EInt((bop op) x1 x2)
      | e1,e2,__ -> failwith ("Binary operands need to be integers."))
  | EUnOp(op, e) ->
     (match eval env e, op with
      | EInt(x), UnopMinus -> EInt(-x)
      | e, _ -> failwith ("Unary operand needs to be an integer."))
  | ELet(x, e1, e2) ->
     let v = eval env e1 in
     eval ((x, v)::env) e2
  | EVar(x) -> List.assoc x env
  | ELam(x,e) -> EClos(x, e, env)
  | EApp(e1,e2) ->
     (match eval env e1, eval env e2 with
      | EClos(x, e, env2), v -> eval ((x,v)::env2) e
      | _ -> failwith "Incorrect application.")
  | EClos(x,e,env) -> EClos(x,e,env)
