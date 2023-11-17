% calcula la fila actual
fila([], [1]):- !.              % 1er nivel es 1
fila(L, NLR):-                   % L es la Lista actual por la cual se harán sumas permutadas
    suma(L, LS),                 % LX contienue la Lista de las Sumas de las permutaciones superiores, 
    concatenar([1|LS], [1], NLR).    % NLR es la Nueva Lista Resultante para esta profundidad

% Encuentra la suma de los elementos que se traslapan del triangulo, e. g. 1 + 1 = 2
suma([_], []):- !.              % un elemento
suma([K, KCo|Co], [S |CoR]):-    % K es la cabeza, KCo es Cabeza de la Cola, 
    S is K + KCo,               % S es la suma del elemento izquiero y derecho inmediatos superiores
    suma([KCo|Co], CoR).        % CoR es Cola Resultado o el resto de las sumas que faltan 
    
pascal(0, _, []):- !.           % profundidad 0, no hacer nada
pascal(P, FA, [RFA | RFS]):-    % P es la profundidad
    P1 is P - 1,                % FA es la Fila Actual
    fila(FA, RFA),              % RFA es el Resultado Fila Actual
    pascal(P1, RFA, RFS).       % RFS es el Resultado Fila Salida o la concatenación de la suma de las permutaciones al final de la lista de salida [RFA | RFS]

pascal(P, T):-                  % T es el Triangulo resultante
    pascal(P, [], T).

% creando mi propio concatenar pues el de este prolog no sirve
concatenar([], X, X):- !.
concatenar([K|Co], LpC, [K|LR]):- 
    concatenar(Co, LpC, LR).