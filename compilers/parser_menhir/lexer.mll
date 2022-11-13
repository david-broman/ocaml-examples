
{
  open Parser
  exception Error of char
}

let line_comment = "//" [^ '\n']*

rule token = parse
   |  [' ' '\t'] | line_comment
       { token lexbuf }
   | ['\n']
       { Lexing.new_line lexbuf; token lexbuf }
   | ['+']
       { ADD }
   | ['-']
       { SUB }
   | ['*']
       { MUL }
   | ['/']
       { DIV }
   | ['0'-'9']+ as lxm
       { INT(int_of_string lxm) }
   | ['(']
       { LPAREN }
   | [')']
       { RPAREN }
   | eof
       { EOF }
   | _ as c
       { raise (Error c) }