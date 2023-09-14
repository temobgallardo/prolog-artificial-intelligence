% E1 - Predicado que cuenta numero de elementos en lista. 
list_lenght([], 0).
list_lenght([_|T], N):-
    list_lenght(T, N1),
    N is N1 + 1.

% E2- Crear un predicado que obtenga el i- ́esimo elemento de la sucesi ́on de Lucas cuya definición inductiva es:
% L0 = 2, L1 = 1, Ln = Ln−1 +Ln−2 con n > 1
get_lucky(0, 2). 
get_lucky(1, 1). 
get_lucky(N, X):-
    N > -1,
    L1 is N - 1,
    L2 is N - 2,
    get_lucky(L1, X1),
    get_lucky(L2, X2),
    X is X1 + X2.

