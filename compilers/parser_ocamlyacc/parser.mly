

%token <int> INT
%token ADD MUL
%token LPAREN RPAREN
%token EOF

%start main
%type <int> main

%%

main:
  | expr EOF
    { $1 }

expr:
  | expr ADD term
    { $1 + $3 }
  | term
    { $1 }

term:
  | term MUL factor
    { $1 * $3 }
  | factor
    { $1 }

factor:
  | INT
    { $1 }
  | LPAREN expr RPAREN
    { $2 }
