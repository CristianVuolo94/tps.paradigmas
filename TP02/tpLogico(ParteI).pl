% Ejercicio 1: Salen juntos
personaje(marsellus).
personaje(mia).
personaje(pumkin).
personaje(honeyBunny).
saleCon(Alguien, Otro):- 
    personaje(Alguien), pareja(Alguien, Otro).
saleCon(Alguien, Otro):- 
    personaje(Otro), pareja(Otro, Alguien).

% Ejercicio 2: Mas Parejas
pareja(bernardo, bianca).
pareja(bernardo, charo).
pareja(bianca, bernardo).
pareja(charo, bernardo).

% Ejercicio 3: Nuevos Trabajadores.
trabajaPara(Alguien, bernardo):-trabajaPara(marsellus, Alguien), Alguien \= jules.
trabajaPara(Alguien, george):-saleCon(Alguien, bernardo).

% Ejercicio 4: Fidelidad
esFiel(Alguien):-saleCon(Alguien,Otro1),saleCon(Alguien,Otro2), Otro1==Otro2 , Alguien\= vincent, not(Alguien==bernardo).

% Ejercicio 5: Acatar Ordenes
acataOrden(Alguien,Otro):-trabajaPara(Alguien, Otro).
acataOrden(Alguien,Otro):-trabajaPara(Alguien, Otra), trabajaPara(Otra, Otro).
