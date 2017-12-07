(*


            Welcome to ML! Everything will be interactive -- The plan:

  * First, we'll go through a walkthrough about OCaml basics and common mistakes from "normal" languages.
  * Next, questions about the homework that I'll attempt to answer with live coding.
  * Finally, if time permits, a motivation for next week's assignment, tail recursion.

  *)


  (*
    "Normal"/imperative languages: values are computed from statements, and then
      returned.

    For example, factorial:

    int factorial(int x) {
        int result = 1;
        // while loop and continually decrement x until 0
        while (x > 0) {
        result = x * result;
        x = x - 1;
      }

      return result;

    }


  *)


(* In OCaml, *everything* is a value. *)

(* Examples: what value is produced by each of these expressions? what is the type? *)
1;;
1 + 2;;

(+) 1 2;; (* 3 *)
"cat" ^ "dog";; (* "catdog" *)

(+);; (* v *)
(if 1 > 0 then "true" else "false");;

(* int x = 3; "in" *)



(* What happens here?

   1 + "cat";;

   Some languages would turn this into "1cat" or perhaps throw an exception
   at runtime. OCaml refuses to even evaluate the expression, complaining about
   a type error.

   OCaml's type system prevents these kinds of mistakes.
*)


(* OK cool. Any questions about the homework? *)



let hd x = match x with h::t -> h

(*
  But what if you have to loop? For example, factorial...

  int factorial(int x) {
      ???
  }

  In OCaml, looping is done by *recursion*, i.e. calling a function on smaller inputs.

*)

(* factorial: int -> int *)

(* n! = n*(n-1)! for n > 1
n! = 1 for n = 1 *)

let rec factorial x = match x with
  | 1 -> 1
  | z when x > 1 -> z * factorial (z-1)

(*

  Let's talk about lists. You can loop over lists by pattern matching and recursing
  on sublists

   Let's try something easy: counting the elements in a list
*)

(*
  []  <- base case

  h::tail  <- recursive case
*)

(* length: 'a list -> int *)

let rec length x = match x with
  | []    -> 0
  | h::t  -> 1 + (length t)


(* Let's try something a little harder...

  Append is a useful function, which puts two lists together:

  [1,2,3] `append` [4,5,6] = [1,2,3,4,5,6]


  append: 'a list -> 'a list -> 'a list
 *)


(*
the algorithm for append is to go through the first list
and set the end to point to the second list
*)
let rec append l r = match l with
  | []    ->  r
  | h::t  -> h :: (append t r)


(* Wait, but this append is slow and uses a lot of memory...why? *)

(* There's a nice compiler technique called "Tail Call Elimination":
    basically, compilers can rewrite functions that use tail-calls into loops!

      return f(x, y);  // <- this is a tail call
      return x + y; // <- this is not a tail call

    In OCaml, this is a tail call:

      if x then (f y) else (f z)

    This is not a tail call:

      if x then (f y) + 1 else (f z)
                ^^^^
            A function call that is not in tail-position


    Notice, append isn't a tail-call...
*)


(* appendTR : list -> list -> list *)

let rec appendTR l r =
  let rec looper l r acc = match (l, r) with
    | ([], []) -> List.rev acc
    | ([], h::t)  -> looper l t (h::acc)
    | (h::t, r)  -> looper t r (h::acc)

  in
    looper l r []



(* appendTR: list -> list -> list -> list *)
(* let rec appendTR l r =
  let rec looper l r acc = match (l, r) with
    | ([], []) -> List.rev acc
    | ([], h::t)  -> looper l t (h::acc)
    | (h::t, _) -> looper t r (h::acc)
  in
    looper l r [];; *)

    (*
  match l with
  | [] -> r
  | h::t ->
    let rest = append t r
    in h :: rest *)
