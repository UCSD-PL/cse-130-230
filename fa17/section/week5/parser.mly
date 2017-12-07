%{
  open Syntax
%}

%token <string> VAR
%token <int> NUM
%token EOL
%token PLUS MINUS MULT LPAREN RPAREN

%start main

%type <Syntax.expr> main

%%

main:
  expr EOL                  { $1 }
  ;

expr: plusMinusExpr { $1 }
    | multExpr      { $1 }

plusMinusExpr :
    | plusMinusExpr PLUS multExpr { Plus($1, $3) }
    | plusMinusExpr MINUS multExpr     { Minus($1, $3) }
    | multExpr                         { $1 }

multExpr :
    | multExpr MULT multExpr           { Mult($1, $3) }
    | basicExpr                        { $1 }

basicExpr :
    | NUM                         { Num($1) }
    | VAR                         { Var($1) }
    | LPAREN plusMinusExpr RPAREN { $2 }
