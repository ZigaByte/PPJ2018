datatype avltree = Empty | Node of int * int * avltree * avltree

val t = Node (5, 3, 
			Node(3, 2, 
				Node(1, 1, Empty, Empty),
				Node(4, 1, Empty, Empty)), 
			Node(8, 1, Empty, Empty))
			
val a = Empty

	
(* height: avltree -> int *)
fun height Empty = 0
	| height (Node (_, h, _, _)) = h
(* leaf: int -> avltree*)
fun leaf x = Node (x, 1, Empty, Empty)
(* leaf: int * avltree * avltree -> avltree *)
fun node (x, t1, t2) = Node(x, Int.max(height t1, height t2) + 1, t1, t2)

val t2 = node (5, node (3, leaf 1, leaf 4 ), leaf 8)

(* toList: avltree -> int list *)
fun toList Empty = []
	| toList (Node(x, _, t1, t2)) = [x] @ toList t1 @ toList t2
	
(* int * avltree -> bool *)
fun search (a, Empty) = false
	| search (a, Node (x, _, t1, t2)) = 
		if a = x then true else
		if a < x then search(a, t1) else
		search(a, t2)
	
fun imbalance Empty = 0
	| imbalance (Node(x, _, l, r)) = (height l) - (height r)
	
fun rotateLeft (Node(x, _, a, Node(y, _, b, c))) =
	node (y, node(x, a, b), c)
	| rotateLeft t = t
fun rotateRight (Node(y, _, Node(x, _, a, b), c)) =
	node (x, a, node(y, b, c))
	| rotateRight t = t
	
fun balance Empty = Empty
	| balance (t as Node(x, h, l, r)) = 
		case imbalance t of
			   2 =>
				if imbalance l >= 0 then 
					rotateRight t
				else 
					rotateRight (node (x, rotateLeft l, r))
			| ~2 =>
				if imbalance r <= 0 then 
					rotateLeft t
				else 
					rotateLeft (node (x, l, rotateRight r))
			|  _ => t
		
	
	
	
	
	
	
	
	
