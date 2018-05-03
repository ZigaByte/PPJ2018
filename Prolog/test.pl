parent(tina, william).
parent(thomas, william).
parent(thomas, sally).
parent(thomas, jeffrey).
parent(sally, andrew).
parent(sally, melanie).
parent(andrew, joanne).
parent(jill, joanne).
parent(joanne, steve).
parent(william, vanessa).
parent(william, patricia).
parent(vanessa, susan).
parent(patrick, susan).
parent(patricia, john).
parent(john, michael).
parent(john, michelle).

parent(frank, george).
parent(estelle, george).
parent(morty, jerry).
parent(helen, jerry).
parent(jerry, anna).
parent(elaine, anna).
parent(elaine, kramer).
parent(george, kramer).

parent(margaret, nevia).
parent(margaret, alessandro).
parent(ana, aleksander).
parent(aleksandr, aleksander).
parent(nevia, luana).
parent(aleksander, luana).
parent(nevia, daniela).
parent(aleksander, daniela).

male(william).
male(thomas).
male(jeffrey).
male(andrew).
male(steve).
male(patrick).
male(john).
male(michael).
male(frank).
male(george).
male(morty).
male(jerry).
male(kramer).
male(aleksandr).
male(alessandro).
male(aleksander).

female(tina).
female(sally).
female(melanie).
female(joanne).
female(jill).
female(vanessa).
female(patricia).
female(susan).
female(michelle).
female(estelle).
female(helen).
female(elaine).
female(anna).
female(margaret).
female(ana).
female(nevia).
female(luana).
female(daniela).

mother(X, Y) :- parent(X, Y), female(X).

grandparent(X, Y) :- parent(X, Z), parent(Z, Y).
sister(X, Y) :- parent(Z, X), parent(Z, Y), female(X), X \== Y.
aunt(X, Y) :- parent(Z, Y), sister(X, Z).

ancestor(X, Y) :- parent(X, Y); (parent(X, Z), ancestor(Z, Y)).
descendant(X, Y) :- ancestor(Y, X).

member(X, [X|_]).
member(X, [_|T]) :- member(X, T).

insert(X, L, [X|L]).
insert(X, [A|L1], [A|L2]) :- insert(X, L1, L2).




