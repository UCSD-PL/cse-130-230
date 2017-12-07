type expr =
| Var   of string
| Num   of int
| Plus  of (expr * expr)
| Minus of (expr * expr)
| Mult  of (expr * expr)
