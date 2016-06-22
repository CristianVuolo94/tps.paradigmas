%Ejercicio 1: Personajes peligrosos 
esPeligroso(Alguien) :-
    personaje(Alguien, ladron(Objetivos)),
    member(licorerias,Objetivos).
esPeligroso(Alguien) :- 
    personaje(Alguien, mafioso(maton)).
esPeligroso(Alguien) :-
    trabajaPara(Empleador, Alguien),
    personaje(Empleador,_), esPeligroso(Empleador).

%Ejercicio 2: San Cayetano 
sanCayetano(Alguien):- persona(Alguien),
forall(cerca(Alguien, Persona1), encargo(Alguien, Persona1, _)).

cerca(Persona1, Persona2):- amigo(Persona1, Persona2).
cerca(Persona1, Persona2):- trabajaPara(Persona2, Persona1).
cerca(Persona1, Persona2):- trabajaPara(Persona1, Persona2).
persona(Alguien):- cerca(Alguien, _).

%Ejercicio 3: Nivel de respeto 
nivelRespeto(vincent,15).
nivelRespeto(Personaje,Nivel) :-
    personaje(Personaje, actriz(Lista)),
    length(Lista,Cantidad), Nivel is (Cantidad/10).
nivelRespeto(Personaje,10) :-
    personaje(Personaje, mafioso(resuelveProblemas)).
nivelRespeto(Personaje,20) :-
    personaje(Personaje, mafioso(capo)).

%Ejercicio 4: Personajes respetables 
respetable(Personaje) :- personaje(Personaje,_),
    nivelRespeto(Personaje,Nivel),
    Nivel > 9.
    
respetabilidad(Respetables,NoRespetables) :- 
    findall(P,respetable(P), ListaRespetables),
    length(ListaRespetables,Respetables),
    findall(P,(personaje(P,_),not(respetable(P))), ListaNoRespetables),
    length(ListaNoRespetables,NoRespetables).

%Ejercicio 5: Ms atareado 
cantidadEncargos(Personaje,Cantidad) :- 
    findall(Personaje,encargo(_,Personaje,_),ListaE),
    length(ListaE,Cantidad).
masAtareado(Quien) :-
    personaje(Quien,_),
    cantidadEncargos(Quien,Max),
    forall((personaje(Elem,_),Elem\=Quien), 
    (cantidadEncargos(Elem,Cantidad),Cantidad < Max)).
