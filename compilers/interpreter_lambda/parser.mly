
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
%token DOT "."
%token LET
%token IN
%token LAM
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
  | LAM id = IDENT "." e = let_expr
    { ELam(id, e) }
  | e = expr
    { e }

expr:
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
  | e = left
    { e }

left:
  | e = factor
    { e }
  | e1 = left e2 = factor
    { EApp(e1, e2) }

factor:
  | i = INT
    { EInt(i) }
  | x = IDENT
    { EVar(x) }
  | "(" e = let_expr ")"
    { e }
