:-dynamic padre/2.
:-dynamic madre/2.
:-dynamic progenitor/2.
:-dynamic hermano/2.
:-dynamic hermana/2.
:-dynamic antepasado/2.
:-dynamic hombre/1.
:-dynamic mujer/1.
padre(enrique7,enrique8).
padre(enrique7,arturo).
padre(enrique7,margarita).
progenitor(X,Y):- padre(X,Y); madre(X,Y).
hermano(X,Y):-progenitor(Z,Y) , progenitor(Z,X) , hombre(X),(X\=Y).
hermana(X,Y):-progenitor(Z,Y) , progenitor(Z,X), mujer(X),(X\=Y).
antepasado(X,Y):- padres(X,Y).
antepasado(X,Y):- padre(X,C),progenitor(C,Y).
agregarregla(N):- N=1, write(' A continuacion digite la regla: '),nl, read(X),assertz(X).
agregarpadre(N):- N=2, write('Nombre del padre'), read(X), write('Nombre del hijo'), read(Y), assert(padre(X,Y)).
menu(N):-
	N>0,
	write('desea gregar un hecho? 1.si otro valor no'), nl,
	write('-> '), read(N2), nl,
	agregarregla(N2),nl,
	menu(N2).
