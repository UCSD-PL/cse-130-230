let rec unzip l =
        match l with 
        | [] -> ([],[])
        | (a,b)::t -> let (l1,l2) = unzip t in
                  (a::l1, b::l2);;

let average_if f l =
   let fold_fn (count, sum) elmt =
           if f elmt then (count+1, sum+elmt)
                     else (count, sum)
   let base = (0,0)
   let (count, sum) = List.fold_left folding_fn base l in
   if count = 0 then 0 else sum / count;;


let rec ith l i d =
match l with
   | [] -> d
   | h::t -> if i = 0 then h else ith t (i-1) d;;

let remove l x =
  List.fold_left (fun a e -> if e=x then a else a@[e]) [] l;; 

let fold_2 f b l =
   let base = (b,0) in
   let fold_fn (acc,indx) elmt = (f acc elmt indx,indx+1) in 
   let (res, _) = List.fold_left fold_fn base l in
   res;;

let ith l i d =
   let base = d in
   let fold_fn acc elmt idx = if i = idx then elmt else acc in
   fold_2 fold_fn base l;;

let rec apply_all t x =
   match t with
   | Leaf (f) -> f x
   | Node (l,r) -> apply_all r (apply_all l x);;

let rec compose t1 t2 =
   match (t1,t2) with
   | (Leaf f1, Leaf f2) -> Leaf (fun x -> f1 (f2 x))
   | (Node (l1,r1), Node (l2,r2)) -> Node(compose l1 l2, compose r1 r2);;

let categorize f l =
   let base = [] in
   let fold_fn acc elmt =
       let n = f elmt in
       let old_bin = ith acc n []
       let new_bin = old_bin@[elmt]
       update2 acc n new_bin [] in
   List.fold_left fold_fn base l;;

