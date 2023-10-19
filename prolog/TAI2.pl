% E1 - Predicado que cuenta numero de elementos en lista. 
list_lenght([], 0).
list_lenght([_|T], N):-
    list_lenght(T, N1),
    N is N1 + 1.

% E2 - Crear un predicado que obtenga el i- ́esimo elemento de la sucesi ́on de Lucas cuya definición inductiva es:
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

% E3 - Crear un predicado que obtiene la n- ́esima fila del tri ́angulo de Pascal.
pascal_succession(N, 0, [1]).
pascal_succession(N, K, X):-
    K > -1,
    R is N - K,
    factorial(R, RF),
    factorial(N, NF),
    factorial(K, KF),
    C is NF/(KF*RF),
    K1 is K - 1,
    pascal_succession(N, K1, X1),
    append(C, X1, X), !.

% Factorial de n
factorial(0, 1).
factorial(N, X):- 
    N > -1,
    N1 is N - 1,
    factorial(N1, X1),
    X is X1*N.

%append([], X, X).                                   % (* your 2nd line *)
%append([X | Y], Z, [X | W]) :- append(Y, Z, W).    % (* your first line *) 

% E4 Crear un predicado que cuente el nu ́mero de veces que un elemento aparece en una lista.
ap(X, [], 0).
ap(X, [X|T], N):-
    ap(X, T, N1), 
    N is N1 + 1.
ap(X, [H|T], N):- 
    ap(X, T, N).

% E6 Palindromo
palindrome(List1):-
    findrev(List1,[],List2),
    compare(List1, List2).

findrev([],List1,List1).

findrev([X|Tail],List1,List2):-
    findrev(Tail,[X|List1],List2).

compare([],[]):- 
        write("\nList is Palindrome").
        
compare([X|List1],[X|List2]):-
    compare(List1,List2).    
    
compare([X|List1],[Y|List2]):-
    write("\nList is not Palindrome").