datatype 'a stream = Cons of 'a * (unit -> 'a stream)

(* Prvih n elementov toka pretvori v seznam *)
fun to_list 0 _ = []
  | to_list n (Cons (x, s)) = x :: (to_list (n-1) (s ()))

(* n-ti element toka *)
fun elementAt 0 (Cons (x, _)) = x
  | elementAt n (Cons (_, s)) = elementAt (n-1) (s ())
  
fun from_list seznam r =
	case seznam 
		of [] => Cons(r, fn () => from_list [] r)
		| (x :: xs) => Cons(x, fn () => from_list xs r)
		
val four = from_list [1,2,3] 4 ;
		
fun head (Cons(a, _)) = a
fun tail (Cons(_, t)) = t()

fun map f (Cons(a, t)) = Cons(f a, fn () => (map f (t())))

fun substream k (x as Cons(_, t)) = 
	case k of 0 => x
		| k => substream (k-1) (t());

fun from k = Cons(k, fn () => from (k+1))
val nat = from 0

val fib = 
	let fun gen a b = Cons(a+b, fn () => gen b (a+b))
	in gen 0 1 
	end
	
	
	
		