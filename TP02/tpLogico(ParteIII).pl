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


%Ejercicio 2: Batallon

batallon(SubLista, Encargos):- 
	lista(ListaCompleta),
	subconjunto(SubLista,ListaCompleta), 
	encargoTotal(SubLista,Total), 
	Total > Encargos.

lista(Lista):- findall(Nombre, (personaje(Nombre, _ ),respetable(Nombre)), Lista).

subconjunto([],[]). 
subconjunto([C|R],[C|R1]):-subconjunto(R,R1). 
subconjunto(L,[_|R1]):-subconjunto(L,R1). 

encargoTotal([],0).
encargoTotal([Elem],Total):-cantidadEncargos(Elem, Total).
encargoTotal([Cab|Cola],Total):-cantidadEncargos(Cab,Resp), encargoTotal(Cola,TotalCola), Total is (TotalCola + Resp).

%Ejercicio 3: Quienes superan

quienesSuperan(Lista, Elem, cuantosAmigos, ListaFinal):- findall(A, (member(A,Lista), cuantosAmigos(A,X), X > Elem), ListaFinal).
quienesSuperan(Lista, Elem, cantidadEncargos, ListaFinal):- findall(A, (member(A,Lista), cantidadEncargos(A,X), X > Elem), ListaFinal).

member(Elem,[Elem|_]).
member(Elem, [_|Cola]):- member(Elem, Cola).
