minimax_gato fue creado por Fermin, Ramses, Artemio,  los usando la versión v9.0.4-1 de swiprolog [https://www.swi-prolog.org/Download.html, https://www.swi-prolog.org/download/stable/bin/swipl-9.0.4-1.x64.exe.envelope] 

Se implementa el algoritmo minimax con poda-corte para que la máquina tenga 'inteligencia'
y pueda decidir sobre qué jugadas hacer.

El humano inicia el juego con las piezas X.
La máquina tiene las piezas O.

¿Cómo jugar?
1. Cargar el programa
   ?- ['minimax_gato.pl']. 

2. Ejecutar el predicado 'iniciar'
    ?- iniciar.

3. Con esto el juego iniciara e imprimira el tablero
    ?- iniciar.
    [1|2|3]
    [4|5|6]
    [7|8|9]
    Turno del jugador x. Ingresa la posicion de su ficha:

4. Escriba la posición a jugar [1, 2, ..., 9] como se muestra en el tablero
    |: 2.

   El programa imprimira el tablero y mostrará la jugada que eligio la máquina
    [1|x|3]
    [4|5|6]
    [7|8|9]
    Turno de la computadora.
   
   Y volverá a preguntar la posición que deseas jugar, se muestran un ejemplo de juego abajo:
    [o|x|3]
    [4|5|6]
    [7|8|9]
    Turno del jugador x. Ingresa la posicion de su ficha:
    |: 5.
    [o|x|3]
    [4|x|6]
    [7|8|9]
    Turno de la computadora.
    [o|x|3]
    [4|x|6]
    [7|o|9]
    Turno del jugador x. Ingresa la posicion de su ficha:
    |: 4.
    [o|x|3]
    [x|x|6]
    [7|o|9]
    Turno de la computadora.
    [o|x|3]
    [x|x|o]
    [7|o|9]
    Turno del jugador x. Ingresa la posicion de su ficha:
    |: 3.
    [o|x|x]
    [x|x|o]
    [7|o|9]
    Turno de la computadora.
    [o|x|x]
    [x|x|o]
    [o|o|9]
    Turno del jugador x. Ingresa la posicion de su ficha:
    |: 9.
    [o|x|x]
    [x|x|o]
    [o|o|x]
    Ha habido un empate.
    true .


Extra: para el juego programado en Java

1. Comiplar el programa en tu IDE de preferencia
2. Ejecutar el programa

La máquina tirá primero

¿Cómo jugar?
1. Primer pone una ficha la màquina
2. El programa te preguntará por la fila y la columna 
3. Continua jugando.