# E1 - Predicado que cuenta numero de elementos en lista. 
tl([], 0).
tl([_|T], N):-
    tl(T, N1),
    N is N1 + 1.

# E2