/*
 *Inicio del programaa
 * main funcs
 * 
 * */ 
inicio(S0, S):- saludoc(S0, S). %ej : hola
inicio(S0, S):- saludoc(S0, S1), sintagma_nominal(S1, S).%ej: hola mrTrainer
inicio(S0, S):- saludoc(S0, S1), saludoc(S1, S). %ej: buenos dias
inicio(S0, S):- saludoc(S0, S1), saludoc(S1, S2), sintagma_nominal(S2, S).
%ej: buenas tardes MrTrainer

fin(S0, S):- despidoc(S0, S). %ej: adios
fin(S0, S):- despidoc(S0, S1), sintagma_nominal(S1, S). %ej: adios MrTrainer
fin(S0, S):- despidoc(S0, S1), despidoc(S1, S).%ej: Hasta luego
fin(S0, S):- despidoc(S0, S1), despidoc(S1, S2), sintagma_nominal(S2, S).
%ej: hasta luego mrTrainer

consulta(S0,S):- sintagma_nominal(S0,S1), sintagma_verbal(S1,S).
%ej: yo quiero
consulta(S0,S):- sintagma_verbal(S0,S). %ej: quiero nadar
consulta(S0,S):- sintagma_nominal(S0,S). %ej: el ciclismo

sintagma_nominal(S0,S):- determinantec(S0,S1),nombrec(S1,S). %ej: el ciclismo
sintagma_nominal(S0,S):- nombrec(S0,S).%ej: asma

sintagma_verbal(S0,S):- verboc(S0,S).% ej: corro
sintagma_verbal(S0,S):- verboc(S0,S1), verboc(S1 ,S). %ej: quiero empezar
sintagma_verbal(S0,S):- verboc(S0,S1), sintagma_nominal(S1,S).%ej: correr la maraton
sintagma_verbal(S0,S):- verboc(S0,S1), verboc(S1, S2),
    sintagma_nominal(S2,S).%ej: correr la maraton

/*
 * determina si la palabra existe en el diccionario
 */
determinantec([Det|S],S):- determinante(Det).
nombrec([Nombre|S], S) :- nombre(Nombre).
verboc([Verbo|S],S) :- verbo(Verbo).
saludoc([Saludo|S], S) :-saludo(Saludo).
despidoc([Despido|S], S) :- despido(Despido).

%se utiliza para las palabras clave
miembro(H, [H|_]).
miembro(H, [_|R]) :- miembro(H, R).
concatenar([],L,L).
concatenar([H|R1],L,[H|R2]):- concatenar(R1,L,R2).


/*
 * verifica que tipo de oracion escribe el usuario (saludar, despedirse o preguntar)
 */
tipo(inicio, Lista):- inicio(Lista, []).
tipo(fin, Lista):- fin(Lista, []).
tipo(consulta, Lista):- consulta(Lista, []).


tipo_consulta(servicio, Lista, X):- consulta(Lista, []),
    palabra_clave(X), miembro(X, Lista).
tipo_consulta(deporte_practicado, Lista, X):- consulta(Lista, []),
    deporte(X), miembro(X, Lista).
tipo_consulta(padecimiento_actual, Lista, X):- consulta(Lista, []),
    padecimiento(X), miembro(X, Lista).
tipo_consulta(frecuencia, Lista, X):- consulta(Lista, []),
    nivel(X), miembro(X, Lista).
%tipo_consulta(rutina ,Lista):- consulta(Lista, []).

/*
 * lo que escribe el entrenador personal segun el tipo de oracion
 */
respuesta(inicio, "Hola, soy MrTrainer, un sistema experto en deporte, 
                   en que te puedo ayudar?").
respuesta(fin, "Hasta luego, avisame si te puedo seguir ayudando").
%respuesta(consulta, Respuesta) :- 



/*
 * preguntas predefinidas para saber informacion del usuario
 */ 
pregunta(servicio, "¿Que deporte practicas?").
pregunta(deporte_practicado, "¿sufres de algun padecimiento?").
pregunta(padecimiento_actual, "¿Indique su nivel de intensidad del 1 al 8?").
%pregunta(frecuencia, Rutina):- rutina().


%lee la frase que escribe el usuario y la separa en una lista segun los espacios
leer_frase_como_lista(ListaPalabras):-
    read_line_to_string(user_input, Frase),
    split_string(Frase, " ", "", ListaPalabras).

%corre el entrenador dinamicamente
%corre el entrenador dinamicamente
script(Lista,_):-
    tipo(fin, Lista),
    respuesta(fin, Trainer),
    write(Trainer), nl,!.

script(Lista,ListaParametros):-
    tipo(Tipo, Lista),
    respuesta(Tipo, Trainer),
    write(Trainer), nl, main_script(ListaParametros).

script(Lista,ListaParametros):-
    tipo(consulta, Lista),
    palabra_clave(X),
    tipo_consulta(Tipo_consulta, Lista, X),
    pregunta(Tipo_consulta, Trainer),
    write(Trainer), nl,
    concatenar([X],ListaParametros,Y),main_script(Y).

script(Lista,ListaParametros):-
    tipo(consulta, Lista),
    deporte(X),
    tipo_consulta(Tipo_consulta, Lista, X),
    pregunta(Tipo_consulta, Trainer),
    write(Trainer), nl,
    concatenar([X],ListaParametros,Y),main_script(Y).

script(Lista,ListaParametros):-
    tipo(consulta, Lista),
    padecimiento(X),
    tipo_consulta(Tipo_consulta, Lista, X),
    pregunta(Tipo_consulta, Trainer),
    write(Trainer), nl,
    concatenar([X],ListaParametros,Y),main_script(Y).

script(Lista,ListaParametros):-
    tipo(consulta, Lista),
    nivel(X),
    tipo_consulta(Tipo_consulta, Lista, X),
    pregunta(Tipo_consulta, Trainer),
    write(Trainer), nl,
    concatenar([X],ListaParametros,Y),main_script(Y).

main_script:- main_script([]).

main_script(ListaParametros):- 
    leer_frase_como_lista(Lista),
    script(Lista,ListaParametros).


    

/*
 * 
 * Base de Datos
 * */
saludo("hola").
saludo("buenos").
saludo("dias").
saludo("buenas").
saludo("tardes").
saludo("noches").


despido("adios").
despido("chao").
despido("hasta").
despido("luego").

determinante("la").
determinante("el").
determinante("las").
determinante("los").
determinante("un").
determinante("una").
determinante("unos").
determinante("unas").
determinante("algunos").

nombre("yo").
nombre("tu").
nombre("usted").
nombre("MrTrainer").
nombre("mrTrainer").
nombre("intermedio").
nombre("rutina").
nombre("plan").
nombre("entrenamiento").
nombre("programa").
nombre("ejercicio").
nombre(PalabraClave) :- palabra_clave(PalabraClave).
nombre(Deporte) :- deporte(Deporte).
nombre(Padecimiento) :- padecimiento(Padecimiento).
nombre(Nivel) :- nivel(Nivel).


verbo("come").
verbo("correr").
verbo("saltar").
verbo("bailar").
verbo("nadar").
verbo("bucear").
verbo("caminar").
verbo("andar").
verbo("levantar").
verbo("flexionar").
verbo("estirar").
verbo("golpear").
verbo("boxear").
verbo("entrenar").
verbo("patinar").
verbo("montar").
verbo("escalar").
verbo("cortar").
verbo("lanzar").
verbo("balancear").
verbo("trepar").
verbo("remar").
verbo("surfear").
verbo("jugar").
verbo("disputar").
verbo("lanzarse").
verbo("cuerpear").
verbo("trotar").
verbo("patear").
verbo("frenar").
verbo("pulsar").
verbo("conducir").
verbo("tirar").
verbo("apuntar").
verbo("disparar").
verbo("cargar").
verbo("lanzar").
verbo("tocar").
verbo("correr").
verbo("giro").
verbo("jugar").
verbo("hacer").

%primera persona singular presente
verbo("corro").
verbo("salto").
verbo("bailo").
verbo("nado").
verbo("buceo").
verbo("camino").
verbo("ando").
verbo("levanto").
verbo("flexiono").
verbo("estiro").
verbo("golpeo").
verbo("boxeo").
verbo("entreno").
verbo("patino").
verbo("monto").
verbo("escalo").
verbo("corto").
verbo("lanzo").
verbo("balanceo").
verbo("trepo").
verbo("remo").
verbo("surfeo").
verbo("juego").
verbo("disputo").
verbo("lanzo").
verbo("cuerpeo").
verbo("troteo").
verbo("pateo").
verbo("freno").
verbo("pulso").
verbo("conduzco").
verbo("tiro").
verbo("apunto").
verbo("disparo").
verbo("cargo").
verbo("lanzo").
verbo("toco").
verbo("corro").
verbo("giro").
verbo("juego").
verbo("hago").
verbo("quiero").
verbo("tengo").

/*
 * 
 * Tablas
 * */
deporte("futbol").
deporte("baloncesto").
deporte("tenis").
deporte("natacion").
deporte("ciclismo").
deporte("niguno").

nivel("1").
nivel("2").
nivel("3").
nivel("4").
nivel("5").
nivel("6").
nivel("7").
nivel("8").

padecimiento("taquicardia").
padecimiento("hipertension").
padecimiento("diabetes").
padecimiento("artritis").

%rutinas(nombre, deporte, padecimiento, nivel, dias)
rutina("a", "natacion", [], "1", [lunes, martes]).
rutina("a", "natacion", [], "1", [lunes, martes]).
rutina("a", "natacion", [], "1", [lunes, martes,sabado,domingo]).
rutina("a", "natacion", [], "1", [lunes, martes,sabado,domingo]).
rutina("a", "natacion", [], "1", [lunes, martes,miercoles,sabado,domingo]).



rutina("a", "natacion", [], "1", [lunes, martes]).
rutina("a", "natacion", [], "2", [lunes, martes]).
rutina("a", "natacion", [], "3", [lunes, martes,sabado,domingo]).
rutina("a", "natacion", [], "4", [lunes, martes,sabado,domingo]).
rutina("a", "natacion", [], "5", [lunes, martes,miercoles,sabado,domingo])

rutina("a", "natacion", [], "1", [lunes, martes]).
rutina("a", "natacion", [], "2", [lunes, martes]).
rutina("a", "natacion", [], "3", [lunes, martes,sabado,domingo]).
rutina("a", "natacion", [], "4", [lunes, martes,sabado,domingo]).
rutina("a", "natacion", [], "5", [lunes, martes,miercoles,sabado,domingo])

rutina("a", "natacion", [], "1", [lunes, martes]).
rutina("a", "natacion", [], "2", [lunes, martes]).
rutina("a", "natacion", [], "3", [lunes, martes,sabado,domingo]).
rutina("a", "natacion", [], "4", [lunes, martes,sabado,domingo]).
rutina("a", "natacion", [], "5", [lunes, martes,miercoles,sabado,domingo])

rutina("a", "natacion", [], "1", [lunes, martes]).
rutina("a", "natacion", [], "2", [lunes, martes]).
rutina("a", "natacion", [], "3", [lunes, martes,sabado,domingo]).
rutina("a", "natacion", [], "4", [lunes, martes,sabado,domingo]).
rutina("a", "natacion", [], "5", [lunes, martes,miercoles,sabado,domingo])


palabra_clave("plan").
palabra_clave("entrenamiento").
palabra_clave("programa").
palabra_clave("rutina").
palabra_clave("ejercicio").