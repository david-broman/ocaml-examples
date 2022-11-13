
%token <int> INT
%token ADD "+"
%token SUB "-"
%token MUL "*"
%token DIV "/"
%token LPAREN "("
%token RPAREN ")"
%token EOF

%left "+" "-"
%left "*" "/"
%nonassoc UMINUS

%start main
%type <int> main

%%

main:
  | e = expr EOF
    { e }

expr:
  | i = INT
    { i }
  | e1 = expr "+" e2 = expr
    { e1 + e2 }
  | e1 = expr "-" e2 = expr
    { e1 - e2 }
  | e1 = expr "*" e2 = expr
    { e1 * e2 }
  | e1 = expr "/" e2 = expr
    { e1 / e2 }
  | "-" e = expr %prec UMINUS
    { - e}
  | "(" e = expr ")"
    { e }
