
is_sorted([]).
is_sorted([_]).
is_sorted([A,B|T]) :- A =< B, is_sorted([B|T]). 

insert(X, L, [X|L]).
insert(X, [A|L1], [A|L2]) :- insert(X, L1, L2).

permute([], []).
permute([H|T], L) :- permute(T, PT), insert(H, PT, L).

bogosort(A, B) :- is_sorted(B), permute(A, B).

% Turingov stroj!

program(plus1, q0, 1, s(q0), 1, right).
program(plus1, q0, b, final, 1, stay).

action(stay, L-R, L-R).
action(right, L-[], [b|L]-[]).
action(right, L-[A|R], [A|L]-R).
action(left, []-R, []-[b|R]).
action(left, [A|L]-R, L-[A|R]).

head_rest([], b, []).
head_rest([H|R], H, R).

step(N, L-R, s(InState), OutL-OutR, OutState) :- 
	head_rest(R, H, O),
	program(N, InState, H, OutState, OutSymbol, D),
	action(D, L-[OutSymbol|O], OutL-OutR).
	
run(_, final, A, A).
run(N, s(InState), L-R, OutL-OutR) :- 
	step(N, L-R, s(InState), OL-OR, OutState),
	run(N, OutState, OL-OR, OutL-OutR).
	
combine([], R, R).
combine([A|L], R, O) :- combine(L, [A|R], O).	
	
turing(N, T, O):-
	run(N, s(q0), []-T, L-R), combine(L, R, O).