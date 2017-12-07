open Syntax

let rec expr_to_string s =
  begin match s with
  | Var(v) -> Printf.sprintf "Var(\"%s\")" v
  | Num(n) -> Printf.sprintf "Num(%d)" n
  | Plus(e1, e2) ->
     binop_to_string "Plus" e1 e2
  | Minus(e1, e2) ->
     binop_to_string "Mult" e1 e2
  | Mult(e1, e2) ->
     binop_to_string "Mult" e1 e2
  end
  and binop_to_string op e1 e2 =
    Printf.sprintf "%s(%s, %s)" op
                   (expr_to_string e1)
                   (expr_to_string e2)
  
let _ =
  try
    let lexbuf = Lexing.from_channel stdin in
    while true do
      let result = Parser.main Lexer.token lexbuf in
        print_string "Succesfully parsed:\n";
        print_string (expr_to_string result);
        print_newline();
        flush stdout
    done
  with Lexer.Eof ->
    exit 0
