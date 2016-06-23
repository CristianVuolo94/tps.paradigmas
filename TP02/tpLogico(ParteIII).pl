%Ejercicio 1: Escuadron

escuadron(SubLista):- 
	lista(ListaCompleta),
	subconjunto(SubLista,ListaCompleta), 
	respetoTotal(SubLista,Total), 
	Total > 15.

%lista crea una lista con todos los personajes respetables.
lista(Lista):- findall(Nombre, (personaje(Nombre, _ ),respetable(Nombre)), Lista).

%subconjunto relaciona todos los posibles subconjuntos de una lista con la propia lista.
subconjunto([],[]). 
subconjunto([C|R],[C|R1]):-subconjunto(R,R1). 
subconjunto(L,[_|R1]):-subconjunto(L,R1). 

%respetoTotal relaciona una lista de personajes con la suma de sus respetos.
respetoTotal([],0).
respetoTotal([Elem],Total):-nivelRespeto(Elem, Total).
respetoTotal([Cab|Cola],Total):-nivelRespeto(Cab,Resp), respetoTotal(Cola,TotalCola), Total is (TotalCola + Resp).