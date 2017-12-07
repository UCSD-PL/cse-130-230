(* Let's say we want to take a list of lists, and return a list of
each first element. How do we do this? *)

let rec firsts l =
  match l with
  | [] -> []
  | (firstListHead :: firstListTail) :: restLists ->
     firstListHead :: (firsts restLists)

let firsts l = map (function l' -> head l') l

(* This isn't tail recursive, but let's not worry about that for now *)

(* What about if we want to get the length of each list? *)
let rec lengths l =
  match l with
  | [] -> []
  | firstList :: restLists ->
     List.len(firstList) :: (lengths restLists)

(* These programs look really similar! How do we write them in general? *)

(* Each program is doing something to every element of a list, and
returning a list of results. We can capture the notion of "something"
with a function *)


let map4 (f : 'a -> 'b) (l : 'a list) : ('b list) =
  List.rev (List.fold_left
              (fun acc item -> (f item) :: acc)
              []
              l)

map4 (function x -> x + 1) [ 1; 2; 3]

let length l =
  List.fold_left (fun length_so_far item ->
      length_so_far + 1) 0 l

let list_max l =
  List.fold_left (fun prev_max item ->
      if prev_max > item then
        prev_max
      else
        item)
                 0 l

let flatten list_of_lists =
  List.fold_left (fun list_so_far next_list ->
      list_so_far @ next_list)
  [] list_of_lists
