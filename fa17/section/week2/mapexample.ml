(* An Example of tail recursion and folds: map! *)

(* What does `map` do? Takes a list of items [a ; b; c; d] and a
function `f`, and produce a new list [f a; f b; f c; f d]. *)

(* What's the type? *)
let rec map (f : 'a -> 'b) (l : 'a list) : ('b list) =
  match l with
  | [] -> []
  | head :: rest -> (f head) :: (map f rest) ;;


(* This is the most basic version of map. Let's try it a few times. *)

(* map String.length ["Hey"; "Friends"; "Programming"; "Is"; "Fun"] *)
(* map (fun x -> x * 2) [1; 2; 3; 4; 5] *)


(* What about really big lists? *)
  (* #use "tail-recursion.ml" *)
  (* map (fun x -> x * 2) (range_tailrec_2 0 1_000_000) *)

  (* Doesn't work. How would we make map tail recursive? *)

let map2 (f : 'a -> 'b) (l : 'a list) : ('b list) =
  let rec helper l acc =
    match l with
    | [] -> acc
    | head :: rest -> helper rest ((f head) :: acc)
  in
  helper l []

(* But it's backwards! How to fix? *)

let map3 (f : 'a -> 'b) (l : 'a list) : ('b list) =
  let rec helper l acc =
    match l with
    | [] -> List.rev acc
    | head :: rest ->
       helper rest ((f head) :: acc)
  in
  helper l [] ;;

(* map3 (fun x -> x * 2) (range_tailrec_2 0 1_000_000) *)

(* It works! But it's still a little ugly. What if we use fold to
factor out the recursion? *)

let map4 (f : 'a -> 'b) (l : 'a list) : ('b list) =
  List.rev (List.fold_left (fun acc item -> (f item) :: acc) [] l)

let ffff acc item =
  (f item) :: acc

let map4 f l =
  List.rev (List.fold_left (fun acc item -> (f item) :: acc) [] l)
