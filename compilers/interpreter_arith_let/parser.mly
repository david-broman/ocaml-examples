
%{
   open Ast
%}

%token <int> INT
%token EQUAL "="
%token ADD "+"
%token SUB "-"
%token MUL "*"
%token DIV "/"
%token LPAREN "("
%token RPAREN ")"
%token LET
%token IN
%token <string> IDENT
%token EOF

%left "+" "-"
%left "*" "/"
%nonassoc UMINUS

%start main
%type <expr> main

%%

main:
  | e = let_expr EOF
    { e }

let_expr:
  | LET id = IDENT "=" e1 = let_expr IN e2 = let_expr
    { ELet(id, e1, e2) }
  | e = expr
    { e }

expr:
  | i = INT
    { EInt(i) }
  | e1 = expr "+" e2 = expr
    { EBinOp(BopAdd, e1, e2) }
  | e1 = expr "-" e2 = expr
    { EBinOp(BopSub, e1, e2) }
  | e1 = expr "*" e2 = expr
    { EBinOp(BopMul, e1, e2) }
  | e1 = expr "/" e2 = expr
    { EBinOp(BopDiv, e1, e2) }
  | "-" e = expr %prec UMINUS
    { EUnOp(UnopMinus, e) }
  | x = IDENT
    { EVar(x) }
  | "(" e = let_expr ")"
    { e }
