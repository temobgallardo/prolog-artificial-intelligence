import java.util.*;
public class MMGato {
    static int limite = 3;
    static char[][] tablero;
    static int lP=10;//Límite de profundidad que "determina" el nivel de inteligencia de nuestra máquina.
    static boolean turno;

    public static void main(String []argos) {
        inicializar();
        juego(tablero);
    }

    public static void inicializar() { //Se llena de espacios vacíos el tablero.
        tablero=new char[3][3];
        for(int i=0; i<tablero.length; ++i) {
            for(int j=0; j<tablero.length; ++j) {
                tablero[i][j]=' ';
            }
        }
    }

    public static void juego(char[][] x) { //Inicia el juego por turnos y verificando que se puede seguir con el juego.
        turno=true;
        imprimeMatriz(x);
        while(true) {
            if(ganador(x)==0 && !turno && !estaLleno(x)) {
                turnoUsuario();
            }
            if(ganador(x)==0 && turno && !estaLleno(x)) {
                turnoCompu(x);
            }
            imprimeMatriz(x);
        }
    }

    public static void turnoUsuario() {
        Scanner entrada = new Scanner(System.in);
        int fil,col;
        boolean vacio=true;
        while(vacio) { //No se sale del ciclo hasta que el usuario ponga coord. válidas.
            System.out.println("Ingresa la fila donde quieres poner tu ficha: ");
            fil=entrada.nextInt()-1;
            System.out.println("Ingrese la columna donde quieres poner tu ficha: ");
            col=entrada.nextInt()-1;
            if(fil<3 && fil>-1 && col<3 && col>-1) { //Comprueba que las coord. ingresadas sean válidas.
                if(tablero[fil][col]==' ') { //Checa si se puede poner ahí una ficha.
                    tablero[fil][col]='O';
                    vacio=false;
                }

                else {
                    System.out.println("Por favor ingrese una posición vacía.");
                }
            }
            else
                System.out.println("Por favor ingrese una posición que exista en el tablero.");
        }
        turno=true;
    }

    public static void turnoCompu(char[][] x) {
        int filChida=10,filTemp,colChida=10,colTemp,m,actual, alfa, beta;
        m=-9999;//m, alfa, beta toman valores grandes para forzarlos a cambiar de valor más adelante.
        alfa=-9999;
        beta=9999;
        char fanta;
        for(int i=0; i<limite; ++i) { //El ciclo for anidado recorre todas las posibles opciones que tiene la computadora derivadas del edo. inicial
            for(int j=0; j<limite; ++j) {
                if(x[i][j]==' ') { //Revisa si hay un espacio vacío para contemplar esa opción
                    fanta=x[i][j];//Almacena el valor de esa pos. para después
                    x[i][j]='X';//Agrega el posible escenario al tablero para seguir haciendo el árbol de búsqueda
                    filTemp=i;
                    colTemp=j;
                    actual = min(x,0,alfa,beta);//Baja un nivel en el arbol a buscar el min
                    x[i][j]=fanta;//Regresa al tablero al estado inicial
                    if(m<actual) { //Revisa si ha encontrado una posición que tenga mejor resultado que una posición anterior.
                        m=actual;
                        filChida=filTemp;
                        colChida=colTemp;
                    }
                }

            }

        }
        x[filChida][colChida]='X';//Coloca la ficha en la posición más conveniente
        turno=false;
    }

    public static int min(char[][] x,int p, int a, int b) {
        int candidato;
        char fanta;
        if(p>lP || estaLleno(x) || ganador(x)!=0) { //Revisa que no se haya llegado al límite de profundidad, que ya se haya llenado el tablero o que haya encontrado un ganador
            return (lineas(x,'X')-lineas(x,'O'));//regresa un resultado de una función heurística dada por la diferencia de las posibles líneas ganadoras de usuario y maquina.
        }
        else { //Si no hay inconveniente se sigue con el max.
            for(int i=0; i<limite; ++i) {
                for(int j=0; j<limite; ++j) {
                    if(x[i][j]==' ') {
                        fanta=x[i][j];
                        x[i][j]='O';
                        candidato = max(x,p+1,a,b);//Almacena el valor obtenido de la funcion heurística arrojada por los niveles debajo en el algoritmo.
                        if(candidato<b) { //Si el candidato tiene mejores resultados lo vuelve nuestra nueva beta
                            b=candidato;
                        }
                        x[i][j]=fanta;
                        if(a>=b) { //Si se llega un punto donde alfa tenga mejor resultado que beta, poda el árbol y regresa a alfa.
                            return a;
                        }
                    }

                }
            }
            return b;
        }
    }

    public static int max(char[][] x,int p, int a, int b) { //El procedimiento es análogo a min, con los cambios mínimos correspondientes a max.
        int candidato;
        char fanta;
        if(estaLleno(x) || ganador(x)!=0 /*|| p>lP*/) {
            return (lineas(x,'X')-lineas(x,'O'));
        }
        else {
            for(int i=0; i<limite; ++i) {
                for(int j=0; j<limite; ++j) {
                    if(x[i][j]==' ') {
                        fanta=x[i][j];
                        x[i][j]='X';
                        candidato = min(x,p+1,a,b);
                        if(candidato>a) {
                            a=candidato;
                        }
                        x[i][j]=fanta;
                        if(a>=b) {
                            return b;
                        }
                    }

                }
            }
            return a;
        }
    }

    public static int lineas(char[][] x, char pl) { //Revisa cuantas líneas tiene un jugador posibles para llenar o que ha llenado
        int y=0;
        for(int i=0; i<limite; ++i) {
            for(int j=0; j<limite; ++j) {
                if((i+2)<limite) {
                    if((x[i][j]==pl || x[i][j]==' ') && (x[i+1][j]==pl || x[i+1][j]==' ') && (x[i+2][j]==pl || x[i+2][j]==' ')) {
                        ++y;
                    }
                }
                if((j+2)<limite) {
                    if((x[i][j]==pl || x[i][j]==' ') && (x[i][j+1]==pl || x[i][j+1]==' ') && (x[i][j+2]==pl || x[i][j+2]==' ')) {
                        ++y;
                    }
                }
                if((i+2)<limite && (j+2)<limite) {
                    if((x[i][j]==pl || x[i][j]==' ') && (x[i+1][j+1]==pl || x[i+1][j+1]==' ') && (x[i+2][j+2]==pl || x[i+2][j+2]==' ')) {
                        ++y;
                    }
                }
                if((j+2)<limite && (i-2)>-1) {
                    if((x[i][j]==pl || x[i][j]==' ') && (x[i-1][j+1]==pl || x[i-1][j+1]==' ') && (x[i-2][j+2]==pl || x[i-2][j+2]==' ')) {
                        ++y;
                    }
                }
            }
        }
        return y;
    }

    public static int ganador(char[][] x) { //Revisa si hay un ganador
        for(int i=0; i<limite; ++i) {
            for(int j=0; j<limite; ++j) {
                if((i+2)<limite) {
                    if(x[i][j]=='O' && x[i+1][j]=='O' && x[i+2][j]=='O') {
                        return 1;
                    }
                    if(x[i][j]=='X' && x[i+1][j]=='X' && x[i+2][j]=='X') {
                        return 2;
                    }
                }
                if((j+2)<limite) {
                    if(x[i][j]=='O' && x[i][j+1]=='O' && x[i][j+2]=='O') {
                        return 1;
                    }
                    if(x[i][j]=='X' && x[i][j+1]=='X' && x[i][j+2]=='X') {
                        return 2;
                    }
                }
                if((i+2)<limite && (j+2)<limite) {
                    if(x[i][j]=='O' && x[i+1][j+1]=='O' && x[i+2][j+2]=='O') {
                        return 1;
                    }
                    if(x[i][j]=='X' && x[i+1][j+1]=='X' && x[i+2][j+2]=='X') {
                        return 2;
                    }
                }
                if((j+2)<limite && (i-2)>-1) {
                    if(x[i][j]=='O' && x[i-1][j+1]=='O' && x[i-2][j+2]=='O') {
                        return 1;
                    }
                    if(x[i][j]=='X' && x[i-1][j+1]=='X' && x[i-2][j+2]=='X') {
                        return 2;
                    }
                }
            }
        }
        return 0;
    }

    public static boolean estaLleno(char[][] x) { //Revisa si está lleno o no el tablero de juego
        for(int i=0; i<x.length; ++i) {
            for(int j=0; j<x.length; ++j) {
                if(x[i][j]==' ')
                    return false;
            }
        }
        return true;
    }

    public static void imprimeMatriz(char[][] x) {
        boolean game=true;
        if(ganador(x)==1) {
            System.out.println("Ganó el usuario.");
            game=false;
        }
        else if(ganador(x)==2) {
            System.out.println("Ganó la computadora.");
            game=false;
        }
        else if(estaLleno(x)) {
            System.out.println("Ha habido un empate.");
            game=false;
        }
        System.out.print(" " + " | ");
        for(int j=0; j<x.length; ++j) {
            System.out.print((j+1) + " | ");
        }
        System.out.println("\n---------------");
        for(int i=0; i<x.length; ++i) {
            System.out.print((i+1) + " | ");
            for(int j=0; j<x.length; ++j) {
                System.out.print(x[i][j] + " | ");
            }
            System.out.println("\n---------------");
        }
        if(!game) System.exit(0);
    }
}
