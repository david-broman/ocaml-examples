
{
open Tokens
}

rule token = parse
     [' ' '\t' '\n']
       { token lexbuf }
   | ['+']
       { PLUS}
   | ['*']
       { MUL }
   | ['0'-'9']+ as lxm
       { NUM(int_of_string lxm) }
   | eof
       { EOF }