
victoria([X1,X2,X3,X4,X5,X6,X7,X8,X9], P):-  
    iguales(X1,X2,X3,P); iguales(X4,X5,X6,P); iguales(X7,X8,X9,P);
    iguales(X1,X4,X7,P); iguales(X2,X5,X8,P); iguales(X3,X6,X9,P);
    iguales(X1,X5,X9,P); iguales(X3,X5,X7,P).
iguales(X,X,X,X).
empate(Tablero):-
    \+ (member(1, Tablero);member(2, Tablero);member(3, Tablero);member(4, Tablero);member(5, Tablero);
    member(6, Tablero);member(7, Tablero);member(8, Tablero);member(9, Tablero)).





actualizar(_,_,[],[]).
actualizar(Pos,Ficha,[Pos|Xs],[Ficha|Ys]):- actualizar(Pos,Ficha,Xs,Ys).
actualizar(Pos,Ficha,[X|Xs],[X|Ys]):- actualizar(Pos,Ficha,Xs,Ys),!.


imprimir_linea(X1,X2,X3):-
    write('['), write(X1), write('|'), write(X2),write('|'), write(X3), write(']').

imprimir_tablero([X1,X2,X3,X4,X5,X6,X7,X8,X9]):-
    imprimir_linea(X1,X2,X3), nl ,imprimir_linea(X4,X5,X6), nl ,imprimir_linea(X7,X8,X9).

fin(Tablero):-
    (victoria(Tablero,x), write('El jugador x ha ganado.'));
    (victoria(Tablero,o), write('El jugador o ha ganado.'));
    (empate(Tablero), write('Ha habido un empate.')).


    
siguiente(x,o).
siguiente(o,x).

turno(Tablero, Jugador, TableroSig):-
    write('Turno del jugador '), write(Jugador),
    write('. Ingresa la posicion de su ficha: '), nl,
    read(Pos),
    (Pos==salir, fail ;actualizar(Pos, Jugador, Tablero, TableroSig)).

elimina(_,[],[]).
elimina(X,[X|T],Y):- elimina(X,T,Y).
elimina(X,[H|T],[H|L]):-elimina(X,T,L).

posDisponibles(Tablero, Disponibles):-
    elimina(x, Tablero, Aux),
    elimina(o, Aux, Disponibles),!.

swap([X|T], Y):- unir(T, [X], Y).

unir([],L,L).
unir([X|L1],L2,[X|L3]):- unir(L1,L2,L3). 

ultimo([X], X):-!.
ultimo([_|T], X):- ultimo(T, X).


ramas([X|T], X, [Ramas]):- swap([X|T], Ramas), !.
ramas([X|T], Ultimo, Ramas):-
    X \= Ultimo,
    swap([X|T], C1),
    ramas(C1, Ultimo,R1),
    append(R1,[C1],Ramas).


%Caso base min. Nota pueden ser los casos de vict, der,emp
%aquí ya no revisa a la derecha.

min([[X|Y]], Tablero, (Pos, Val)):-
    actualizar(X,o, Tablero,TableroSig),    
    (
        (
            victoria(TableroSig,o), Pos = X, Val = 1;
            empate(TableroSig), Pos = X, Val = 0
        );
        ultimo(Y,U),
        ramas(Y,U,RamasY),                     
        max(RamasY, TableroSig, (Pos,Val))
    ),!.  

min([[X|Y]|T],Tablero,(Pos,Val)):-
    actualizar(X,o, Tablero,TableroSig),    %Genera un tablero con una posicion tentativa
    (
        (
            victoria(TableroSig,o), Pos = X, Val = 1; %Se da un valor para cada tablero final
            empate(TableroSig), Pos = X, Val = 0
        );
        ultimo(Y, U),
        ramas(Y,U,RamasY),                      %Calculan el resto de posiciones segun el movimiento tentativo
        max(RamasY, TableroSig, (PosO,ValO))
    ),
    (
        (ValO == -1, Val = ValO, Pos = PosO);  %Se decide si la posición tentativa es o no llega a un resultado deseado para min
        min(T, Tablero, (Pos,Val))  %Se llama a Max para revisar el siguente nivel
    ),!.          

max([[X|Y]], Tablero, (Pos, Val)):-
    actualizar(X,x, Tablero,TableroSig),
    (
        (
            victoria(TableroSig,x), Pos = X, Val = -1; 
            empate(TableroSig), Pos = X, Val = 0
        );
        ultimo(Y,U),
        ramas(Y,U,RamasY),
        min(RamasY, TableroSig, (Pos,Val))
    ),!.    

max([[X|Y]|T],Tablero,(Pos,Val)):-
    actualizar(X,x, Tablero,TableroSig),        %Genera un tablero con una posicion tentativa
    (
        (
            %victoria(TableroSig,o), Pos = X, Val = 1;
            victoria(TableroSig,x), Pos = X, Val = -1;  %Se da un valor para cada tablero final
            empate(TableroSig), Pos = X, Val = 0
        );
        ultimo(Y, U),
        ramas(Y,U,RamasY),                  %Calculan el resto de posiciones segun el movimiento tentativo
        min(RamasY, TableroSig, (PosX,ValX))
    ),
    (
        (ValX == 1, Val = ValX, Pos = PosX);  %Se decide si la posición tentativa es o no llega a un resultado deseado para min
        max(T, Tablero, (Pos,Val)) %Se llama a Max para revisar el siguente nivel
    ),!.         
    

minimax(Tablero, TableroSig):-
    write('Turno de la computadora.'),nl,
    posDisponibles(Tablero, Disponibles),
    ultimo(Disponibles, Last),
    ramas(Disponibles, Last, Ramas),
    max(Ramas, Tablero, (Pos,_)),
    actualizar(Pos,o,Tablero,TableroSig), !.


jugar(Tablero, Jugador):-
    (fin(Tablero));
    (
        (
            (
                Jugador == x, 
                turno(Tablero, Jugador, TableroSig)
            ); %no es necesario considerar al jugador
            minimax(Tablero, TableroSig)
        ),
        siguiente(Jugador, JugadorSig),
        imprimir_tablero(TableroSig),nl,
        jugar(TableroSig, JugadorSig)
    ).

iniciar:-
    Tablero = [1,2,3,4,5,6,7,8,9], 
    Jugador = x,
    imprimir_tablero(Tablero), nl,
    jugar(Tablero, Jugador).
