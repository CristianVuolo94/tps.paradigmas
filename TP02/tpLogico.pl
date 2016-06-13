% Ejercicio 1: Salen juntos
saleCon(Alguien, Otro):-pareja(Alguien, Otro).
saleCon(Alguien, Otro):-pareja(Otro, Alguien).

% Ejercicio 2: Mas Parejas
pareja(bernardo, bianca).
pareja(bernardo, charo).
pareja(bianca, bernardo).
pareja(charo, bernardo).

% Ejercicio 3: Nuevos Trabajadores.
trabajaPara(Alguien, bernardo):-trabajaPara(marsellus, Alguien), Alguien \= jules.
trabajaPara(Alguien, george):-saleCon(Alguien, bernardo).

% Ejercicio 4: Fidelidad
esFiel(A):-saleCon(A,B),saleCon(A,C),B==C, A \= vincent, not(A==bernardo).

% Ejercicio 5: Acatar Ordenes
acataOrden(Alguien,Otro):-trabajaPara(Alguien, Otro).
acataOrden(Alguien,Otro):-trabajaPara(Alguien, Otra), trabajaPara(Otra, Otro).
