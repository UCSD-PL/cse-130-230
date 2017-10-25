{
  open Nano        (* nano.ml *)
  open NanoParse   (* nanoParse.ml from nanoParse.mly *)
}

let letter = ['A'-'Z''a'-'z']
let digit = ['0'-'9']

rule token = parse
    eof          { EOF }
  | "let"        { LET }
  | "="          { EQ }
  (* ADD LEXING RULES FOR OTHER TOKENS HERE *)

  | digit+ as i                   { Num (int_of_string i) }
  | letter (letter|digit)* as s   { Id s }
  | [' ' '\n' '\r' '\t']          { token lexbuf }
  | _           { raise (MLFailure ("Illegal Character '"^(Lexing.lexeme lexbuf)^"'")) }
