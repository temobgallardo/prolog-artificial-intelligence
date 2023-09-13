% Hechos Hombres: relación(objeto), e. g. bart es hombre
hombre(bart).
hombre(homero).
hombre(abraham).
hombre(herb).
hombre(clancy).

% Hechos Mujeres
mujer(ling).
mujer(jackeline).
mujer(lisa).
mujer(maggie).
mujer(marge).
mujer(selma).
mujer(patty).
mujer(mona).

% La interpretación del predicado padre(X,Y) es Y es el padre de X.
% La interpretación del predicado madre(X,Y) es Y es la madre de X.
% Hechos Padres
padre(bart, homero).
padre(lisa, homero).
padre(maggie,homero).
padre(homero,abraham).
padre(herb,abraham).
padre(marge,clancy).
padre(patty,clancy).
padre(selma,clancy).

% Hechos Madres
madre(bart,marge).
madre(lisa,marge).
madre(maggie,marge).
madre(homero,mona).
madre(herb,mona).
madre(marge,jackeline).
madre(patty,jackeline).
madre(selma,jackeline).
madre(ling,selma).

% A) Relación abuelo
abuelo(N, A):- 
    hombre(A),
    padre(N, P),
    padre(P, A).

% B) Relación abuela
abuela(N, A):- 
    mujer(A),
    madre(N, P),
    madre(P, A).

% C) Relación nieto
nieto(A, N):-
    hombre(N),
    (abuelo(N, A); abuela(N, A)).

% D) Relación nieta
nieta(A, N):-
    mujer(N),
    (abuelo(N, A); abuela(N, A)).

% E) Hermano
hermano(P1, X):- 
    P1 \== X,
    hombre(X),
    madre(P1, M),
    madre(X, M).
    
% F) X es Hermana de P1?
hermana(P1, X):-
    P1 \== X,
    mujer(X),
    padre(P1, P),
    padre(X, P).
    
% G) Tia T es tia de P
tia(P, T):-
    P \== T,
    mujer(T),
    not(madre(P, T)),
    ((hermana(T, HA), madre(P, HA))
    ; (hermano(T, HO), padre(P, HO))).

tio(P, T):-
    P \== T,
    hombre(T),
    not(padre(P, T)),
    ((hermana(T, HA), madre(P, HA))
    ; (hermano(T, HO), padre(P, HO))).

% H) S es primo de P
primo(P, S):-
    P \= S,
    hombre(S),
    not(hermano(P, S)),
    nieto(X, S),
    ((nieto(X, P); nieta(X, P)), !).

% I) S es sobrino de R
sobrino(R, S):-
    S \== R,
    hombre(S),
    (tia(S, R); tio(S, R)).

hermanos(Y, X):-
    Y \== X,
    hermana(Y, X);
    hermano(Y, X).

% J) X y Y son pareja si han tenido por lo menos un hijo
pareja(Y, X):-
    Y \== X,
    not(hermanos(Y, X)),
    ((mujer(Y), madre(HO, Y), padre(HO, X));
    (padre(HA, Y), madre(HA, X))).