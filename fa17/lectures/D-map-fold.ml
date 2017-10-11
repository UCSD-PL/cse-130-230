let max x y = if x < y then y else x;;

(* regular recursion *)
let rec max_list l =
  match l with
   | [] -> 0
   | h::t -> max h (max_list t);;

(* every recursive call, you take the return value and return it 
 * immediately!!! *)

max_list [1;7;2];;
















(* tail recursive *)

let rec max_list l =
   let rec helper max_so_far remaining =
   match remaining with
   | [] -> max_so_far
   | h::t -> helper (max max_so_far h) t
   in helper 0 l;;
















(* soln *)

let rec max_list l =
   let rec helper max_so_far remaining_elmts =
          match remaining_elmts with
          | [] -> max_so_far
          | h::t -> helper (max max_so_far h) t 
   in
   helper 0 l;;


max_list [1;3;2];;
helper 0 [1;3;2];;
helper 1 [3;2]
helper 3 [2]
helper 3 []

















(* regular recursion *)

let rec concat l =
   match l with 
   | [] -> ""
   | h::t -> h ^ (concat t);;













(* tail recursion *)

let concat l =
  let rec helper concat_so_far remaining =
  match remaining with
  | [] -> concat_so_far
  | h::t -> helper (concat_so_far ^ h) t
  in helper "" l;;


















(* soln *)

let rec concat l =
  let rec helper concat_so_far remaining_elmts =
          match remaining_elmts with
          | [] -> concat_so_far
          | h::t -> helper (concat_so_far^h) t
  in
  helper "" l;;

concat ["123";"abc"];;
helper "" ["123";"abc"]
helper "123" ["abc"]
helper "123abc" []







(* What's the pattern ?

   let rec helper max_so_far remaining_elmts =
          match remaining_elmts with
          | [] -> max_so_far
          | h::t -> helper (max max_so_far h) t 

   let rec helper concat_so_far remaining_elmts =
          match remaining_elmts with
          | [] -> concat_so_far
          | h::t -> helper (concat_so_far^h) t

*)

(* extract pattern into an uber-helper function! *)

let rec fold f so_far remaining =
    match remaining with
    | [] -> so_far
    | h::t -> fold f (f so_far h) t;;


let list_max l = fold max 0 l;;
let concat l = fold (^) "" l;;
let sum l = fold (+) 0 l;;
let mult l = fold ( * ) 1 l;;











(* soln*)
let rec fold f result_so_far remaining_elmts =
          match remaining_elmts with
          | [] -> result_so_far
          | h::t -> fold f (f result_so_far h) t;;




let list_max l = fold max 0 l;;
let concat l = fold (^) "" l;;
let sum l = fold (+) 0 l;;
let mult l = fold ( * ) 1 l;;




















(* soln *)
let list_max l = fold max 0 l;;
let list_max = fold max 0;;
let concat = fold (^) "";;
let multiplier = fold (fun x y -> x * y) 1;;

let cons x y = y::x;;
let myst l = fold cons [] l;;

myst [1;2;3];;
curr = []
cons [] 1 => 1::[] => [1]
curr = [1]
cons [1] 2 => 2::[1] => [2;1]
curr = [2;1]
cons [2;1] 3 => 3::[2;1] => [3;2;1]

























let rec reverse l = 
        match l with 
        | [] -> []
        | h::t -> (reverse t)@[h]

 (* What does f do? *)








(* return a list in which each element is produced from
 * the corresponding element in l by applying f *)
let rec map f l = 
    match l with
    | [] -> [] 
    | h::t -> (f h)::(map f t);;

let incr_list l = map ((+) 1) l;; 
let incr_list = map ((+) 1);; 


let myst l = map (fun x -> [x]) l;;
let inv_myst l = map (fun (h::t) -> h) l;;
let strs_len l = map String.length l;;

[1;2;3] => [[1];[2];[3]]



















let f x y = x + y;;
f: int -> (int -> int)

let g = f 1;;
g 2;;

(f 1) 2;;
f 1 2;;

(+)














(* soln *)
let rec map f l =
        match l with
        | [] -> []
        | h::t -> (f h)::(map f t);;


(* increment all ints in a list *)
map ...





















(* soln *)
map ((+) 1) [1;2;3];;
let f = (+) 5;;
map f [1;2;3]

let f = map ((+) 1);; (*Crazy currying example!!!*)













let rec interval_init i j f =
        if i = j then [f i]
        else (f i)::interval_init (i+1) j f;;

let rec interval_init f i j =
        if i = j then [f i]
        else (f i)::interval_init f (i+1) j;;




(* implement map using fold *)
let map f l = 
  let fold_fn acc elmt = acc@[f elmt] in
  let acc = [] in
  List.fold_left fold_fn acc l;;

let map f l = 
  let fold_fn acc elmt = f elmt::acc in
  let acc = [] in
  List.fold_left fold_fn acc (List.reverse l);;

acc = []
l = [1;2;3]
f = (-) 1
f = (+) (-1)
fun x -> x-1

fold_fn [] 1
acc = [0]
fold_fn [0] 2
acc = [0;-11]
fold_fn [0;-1] 3
acc = [0;-1;-2]


map ((-) 1) [1;2;3] ;;









































(* soln *)

let map f l =
   let base = [] in
   let fold_fn acc elmt = acc@[f elmt] in
   List.fold_left fold_fn base l;;

(* map f [] should return []
List.fold_left fold_fn base [] should return []
base should be [] *)

map f [1;2;3]


(* implement partition using fold *)
let partition f l =
        let base = (,)in
        let fold_fn (l1,l2) elmt = (,)
        in fold_left fold_fn base l;;























(* soln *)
let partition f l =
        let base = ([], []) in
        let fold_fn (x,y) elmt =
                if (f elmt) 
                then (x@[elmt], y)
                else ( x, y@[elmt])
        in
        List.fold_left fold_fn base l;;

let compose f g = fun x -> f (g x)

let compose f g x = f (g x)

let map_incr = List.map ((+) 1);;
let map_incr_2 = compose map_incr map_incr;;
