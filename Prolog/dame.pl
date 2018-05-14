:- use_module(library(clpfd)).

safe_pair(X1/Y1, X2/Y2) :-
	[X1, X2, Y1, Y2] ins 1..sup,
	X1 #\= X2,
	Y1 #\= Y2,
	X1 - Y1 #\= X2 - Y2,
	X1 + Y1 #\= X2 + Y2.
	
safe_list(_, []).
safe_list(X1/Y1, [X2/Y2 | R]) :-
	safe_pair(X1/Y1, X2/Y2),
	safe_list(X1/Y1, R).

safe_list([]).
safe_list([P|R]) :-
	safe_list(P, R),
	safe_list(R).

place_queens(N, N, L) :-
	L = [].
	
place_queens(N, I, L) :-
	I #< N,
	NI #= I+1,
	place_queens(N, NI, L2),
	Y in 1..N,
	L = [NI/Y|L2].
	
queens(N, L) :-
	place_queens(N, 0, L), 
	safe_list(L).