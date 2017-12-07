{
open Parser
exception Eof
}

let digit      = ['0'-'9']
let digits     = digit+
let lower      = ['a'-'z']
let identifier = lower ((lower | digit)*)

rule token = parse
  | [' ' '\t']      { token lexbuf }
  | ['\n']          { EOL }
  | eof             { raise Eof }
  | identifier as i { VAR(i) }
  | digits     as n { NUM(int_of_string n) }
  | '+'             { PLUS }
  | '-'             { MINUS }
  | '*'             { MULT }
  | '('             { LPAREN }
  | ')'             { RPAREN }
