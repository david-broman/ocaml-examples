
{
  open Parser
  exception Error of char
}

let letter = ['A'-'Z'] | ['a'-'z']
let digit = ['0'-'9']
let non_digit = '_' | letter
let ident = non_digit (digit | non_digit)*

let line_comment = "//" [^ '\n']*

rule token = parse
   |  [' ' '\t'] | line_comment
       { token lexbuf }
   | ['\n']
       { Lexing.new_line lexbuf; token lexbuf }
   | ident as str
       { match str with
         | "let" -> LET
         | "in" -> IN
         | s -> IDENT(s)
       }
   | ['=']
       { EQUAL }
   | ['+']
       { ADD }
   | ['-']
       { SUB }
   | ['*']
       { MUL }
   | ['/']
       { DIV }
   | digit+ as lxm
       { INT(int_of_string lxm) }
   | ['(']
       { LPAREN }
   | [')']
       { RPAREN }
   | eof
       { EOF }
   | _ as c
       { raise (Error c) }