(*

For this section, we will cover map and fold_left in detail. The outline:

0), a very brief motivation for map and fold_left.
1), a brief recap of the definition of map.
2), a number of easy map problems.
3), a brief recap of the definition of fold_left.
4), a number of easy fold_left problems.
5), a number of harder map problems.
6), a number of harder fold_left problems.

HINT: A lot of these problems were pulled from past midterms! You'll probably
see a map and/or fold_left problem on the midterm :).


*)

(*

0): Why are map and fold_left cool?

Lists are very common in functional programming. One way to manipulate and
process list data is by recursive functions. This is a general technique, but
can get tedious and error-prone very quickly. Recursion is hard!

Map and fold_left are two ways to calculate over lists that abstract over recursion.

*)

(*

1): THE DEFINITION OF MAP

The idea behind the map function is that, for list transformation functions, it's easy
to define a function on each individual element. For example, consider incrementNumbers,
which takes a list of ints, increments each int, and returns a list of the results.
A natural way to phrase the problem is "increment each int in the list", i.e.


incrementNumbers xs:

[1; 2; 4; 7; 3]    <- xs
 |  |  |  |  |
   increment
 |  |  |  |  |
 v  v  v  v  v
[2; 3; 5; 8; 4]    <- result

Map generalizes this problem by abstracting over the input list and input function:

map func xs:

[a; b; c; d; e]    <- xs
 |  |  |  |  |
   func
 |  |  |  |  |
 v  v  v  v  v
[g; h; i; j; k]    <- result

*)


(*
  2) Easy map problems. These all look like:

  let func xs =
    let worker x = failwith "TODO" in
  map worker xs

  first, an alias

*)

let map = List.map

(* double, triple: double, triple each element of a list. mulBy: multiply each
element of a list by a value. square: square each element of a list.

Produces a list of results.
 *)
let double xs =
  let worker x = x * 2 in
  map worker xs



let triple xs =
  let worker x = x * 3 in
  map worker xs


let mulBy xs v =
  let worker x = x * v in
  map worker xs


let square xs =
  let worker x = x * x in
  map worker xs

(* applyAll : takes a list of functions, and a value, and applies each functions
  to the value. Produces a list of results.
*)

(* applyAll [incr; decr] 10 *)

(* [10; 10] *)

let applyAll xs v =
  let worker x = x v in
  map worker xs

(*
heads, tails: given a list of tuples, take the first (or second) element of each
tuple. Produces a list of results.
*)

(* let test = [(1,2); (3,4)]

heads test = [1;3]
tails test = [2; 4] *)

let heads xs =
  let worker x = let (ret, _) = x in ret in
  map worker xs
let tails xs =
  let worker (_, ret) =  ret in
  map worker xs

(*

countChars: given a list of strings, return a list of character counts.
Helpful for this function: String.length.

*)

(* countChars ["foo"; "ab"] = [3; 2] *)

let countChars xs =
  let worker x = String.length x in
  map worker xs

(*

3): THE DEFINITION OF FOLD_LEFT

The idea behind fold_left is that some functions *need* to be recursive, but
it's easy to make errors with recursion. For general list-processing, fold_left
abstracts over the recursion

let rec recFunc xs = match xs with
  | []  -> ...base case...
  | h:t -> ...recursive case, a function of h and *the result so far*...

for example, sumInts:
let rec sumInts xs = match xs with
  | []  -> 0
  | h:t -> h + (sumInts t)

fold_left abstracts over the pattern matching and recursion and takes as input
the worker function for the recursive case, the base case, and the list to fold over:

fold_left : ('a -> 'b -> 'a) ->  'a       -> list 'b -> 'a
                  ^^             ^^             ^^
            recursive case    base case     input list

graphically, this looks like:
https://upload.wikimedia.org/wikipedia/commons/5/5a/Left-fold-transformation.png

(the "left" in fold_left refers to the fact that the list is processed in a left-associated
manner, i.e. from left-to-right. Don't think too much about it.)


*)

(*
4): Some easy left-folds. These all take the form of

let func xs =
  let base = failwith "TODO" in
  let worker acc next = failwith "TODO" in
  fold worker base xs

*)

(* first, an alias *)
let fold = List.fold_left

(* count: given a list, count the elements in the list
*)

let count xs =
  let base = 0 in
  let worker acc next = acc+1 in
  fold worker base xs

(* filter: given a predicate to apply to a list, take only the elements that satisfy
  the predicate.
*)

(* let [1; 2; 3]
filter (fun x -> x < 3) test = [1;2] *)

(* algorithm:
for x in xs:
  if pred of x then add to acc otherwise acc
  *)
let filter pred xs =
  let base = [] in
  (* if pred of x then add to acc otherwise acc  *)
  let worker acc next = if (pred next)
    then List.append acc [next]
    else acc

    in
  fold worker base xs

(* average: given a list of ints, average the elements of the list.
*)

let average xs =
  let base = (0, 0) in
  let worker (summ, countt) next = (summ+next, countt+1) in
  let ret = fold worker base xs in
  let (total, elems) = ret in
    total/elems



(* zipWithIndex: given a list of elements, add an index to each element. *)

(* [4;8;4] => [(4,0); (8,1); (4,2)] *)

(* for x in xs:
  ret.append((x,count))
  count++ *)

let zipWithIndex xs =
  let base = ([], 0) in
  let worker acc x =
    let (accList, accCount) = acc in
    let nextList = List.append accList [(x, accCount)] in
    let nextCount = accCount + 1 in
    (nextList, nextCount)
  in
  let (ret, _) = fold worker base xs in ret

(* zip: given two lists, merge the lists into a list of pairs.
(this is also the library function List.combine and is useful for your homework.)
*)

(* let (tl, tr) = ([1;2;3] [4;5;6])

zip tl tr = [(1,4); (2,5); (3,6)]

unzip [(1,4); (2,5); (3,6)]  = ([1;2;3] [4;5;6])


*)

(* for (eleml, elemr) in l, r:
  ret <- (eleml, elemr) *)

let zip l r =
  let base = [] in
  let worker acc (nextElem, nextIdx) = List.append [(nextElem, ith r nextIdx)] acc in
  fold worker base (zipWithIndex l)

(* unzip: given a list of pairs, return a pair of unzipped lists.
(this is also the library function List.split.)
*)

let unzip xs = failwith "TODO"



(*

5) Harder map problems.

*)


(* range: given a start and a finish, produce a list from start to finish. *)
let range lo hi = failwith "TODO"
(* buildMatrix: given a list of (lo, hi) tuples for elements build a matrix where each
row is the list lo-to-hi.
*)
let buildMatrix ranges = failwith "TODO"



(*

6) Harder fold problems.

*)

(* ith: given a list and an index, return the ith element of the list. *)
(* ith [1;2;3] 1 = 2 *)

(* for x in xs:
  if x.index ??? == idx then return x *)


let ith xs idx =
  let base = (0,0) in
  let worker acc next =
    let (elem, currentIdx) = acc in
    if (currentIdx = idx) then (next,currentIdx+1)
    else (elem,currentIdx+1)
  in fold worker base xs







(* update: given a list, an index, and a new element, replace the
element at position index with the new element. *)
let update xs idx newElem = failwith "TODO"

(* stretch: given a list, replace each occurance of an element with a duplicate
e.g. [1; 2] => [1; 1; 2; 2]
*)
let stretch xs = failwith "TODO"

(* sum_matrix: given a matrix, sum up the values in the matrix.
*)
let sum_matrix mat = failwith "TODO"
