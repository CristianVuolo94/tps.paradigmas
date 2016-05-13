import Text.Show.Functions
import Data.List
import Data.Char

type Nombre = String 
type Habilidad = String
type Fuerza = Int
type Pertenencia = Barbaro -> Barbaro 
data Barbaro = Barbaro Nombre Fuerza [Habilidad] [Pertenencia] deriving (Show)

judith = Barbaro "Judith" 100 ["tejer","escribirPoesia"] [ardilla, varitasDefectuosas "hacer magia"]
emanuel = Barbaro "Emanuel" 777 ["Comer","Dormir"] [espadas 70, varitasDefectuosas "Legeremancia"]
juan = Barbaro "Juan" 150 ["Volar Mucho"] [ardilla,ardilla,ardilla]
astro = Barbaro "Astro" 1000 ["Robar"] [espadas 70, ardilla]
astor = Barbaro "astor" 81 ["Conversar","Cantar","Tocar la flauta"] []
luis = Barbaro "luis" 100 ["Correr","Saltar","Saltar","Despertar"] [espadas 50, amuletosMisticos] 

-----------------------------------FUNCIONES AUXILIARES---------------------------------------------
upperString :: String -> String
upperString [] = []
upperString (x:xs) = toUpper x : upperString xs 

poderGritoDeGuerra :: [String] -> Int
poderGritoDeGuerra habilidades = (length.concat) habilidades

vocales = "aeiou"++"AEIOU"

numeroDeVocales :: String -> Int
numeroDeVocales palabra = length [c | c <- palabra, elem c vocales]

comprobarVocales :: [String]-> Bool
comprobarVocales habilidades = all (>3) [numeroDeVocales habilidad | habilidad <- habilidades]

esCapitalizada :: String -> Bool
esCapitalizada (x:xs) = isUpper x 

comprobarCapitalizado :: [String] -> Bool
comprobarCapitalizado  habilidades= all (==True) [esCapitalizada habilidad | habilidad <- habilidades]

-----------------------------------FUNCIONES (1): Pertenencia--------------------------------------------

--Las espadas aumentan la fuerza de los bárbaros en 2 unidades por cada kilogramo de peso.
espadas :: Int -> Barbaro -> Barbaro
espadas kgBarbaro (Barbaro nombre fuerza habilidades pertenencias) = Barbaro nombre (fuerza+2*kgBarbaro) habilidades  pertenencias

--Los amuletosMisticos otorgan la habilidad  de clarividencia al bárbaro.
amuletosMisticos :: Barbaro -> Barbaro
amuletosMisticos (Barbaro nombre fuerza habilidades pertenencias) = Barbaro nombre fuerza (habilidades++["Clarividencia"]) pertenencias

--Las varitasDefectuosas, añaden una habilidad dada, pero desaparecen todos las demás pertenencias del bárbaro.
varitasDefectuosas :: String -> Barbaro -> Barbaro
varitasDefectuosas nuevaHabilidad (Barbaro nombre fuerza habilidades pertenencias) = Barbaro nombre fuerza (habilidades++[nuevaHabilidad]) []

--La pertenencia cuerda combina dos pertenencias distintas, obteniendo uno que realiza las transformaciones de los otros dos
cuerda :: Pertenencia -> Pertenencia -> Barbaro -> Barbaro
cuerda pertenencia1 pertenencia2 = pertenencia2.pertenencia1

--La pertencia cuerda no modifica el registro
ardilla :: Barbaro -> Barbaro
ardilla barbaro = barbaro

--El megafono es una pertenencia que potencia al bárbaro, concatenando sus habilidades y poniéndolas en mayúsculas
megafono :: Barbaro -> Barbaro
megafono (Barbaro nombre fuerza habilidades pertenencias) = Barbaro nombre fuerza [(concatMap upperString habilidades)] pertenencias

--El objeto megafonoBarbarico, está formado por una cuerda, una ardilla y un megáfono.
megafonoBarbarico :: Barbaro -> Barbaro
megafonoBarbarico = (cuerda ardilla megafono)

-----------------------------------FUNCIONES (2): Aventuras--------------------------------------------- 

type Aventura = Barbaro -> Bool
--Un bárbaro sobrevive a una invasionDeDuendes si sabe  “tocar la flauta”
invasionDeDuendes :: Barbaro -> Bool
invasionDeDuendes (Barbaro _ _ habilidades _) = any (=="Tocar la flauta") habilidades
  
--Un bárbaro sobrevive a una cremalleraDelTiempo si no tiene pulgares. Los bárbaros llamados Faffy y Astro no tienen pulgares, los demás sí.
cremalleraDelTiempo :: Barbaro -> Bool
cremalleraDelTiempo (Barbaro nombre _ _ _) 
	| nombre == "Faffy" = False
	| nombre == "Astro" = False
	| otherwise = True

--Saqueo, el bárbaro debe tener la habilidad de robar y tener más de 80 de fuerza.
saqueo :: Barbaro -> Bool
saqueo (Barbaro _ fuerza habilidades _) = (fuerza>80) && (any (=="Robar") habilidades)

--gritoDeGuerra, el bárbaro debe tener un poder de grito de guerra igual a la cantidad de letras de sus habilidades. El poder necesario para aprobar es 4 veces la cantidad de pertenencias del bárbaro.
gritoDeGuerra :: Barbaro -> Bool
gritoDeGuerra (Barbaro _ _ habilidades pertenencias) = (poderGritoDeGuerra habilidades) > (length pertenencias)*4

--caligrafia, el bárbaro tiene caligrafía perfecta si sus habilidades contienen más de 3 vocales y comienzan con mayúscula
caligrafia :: Barbaro -> Bool
caligrafia (Barbaro _ _ habilidades _) = (comprobarVocales habilidades) && (comprobarCapitalizado habilidades)

--Un bárbaro puede sobrevivir a un ritualDeFechorias si pasa una o más pruebas como las siguientes: saqueo, gritoDeGuerra, caligrafia
ritualDeFechorias :: Barbaro -> Bool
ritualDeFechorias barbaro = saqueo barbaro||gritoDeGuerra barbaro||caligrafia barbaro  

--La funcion sobrevivientes toma una lista de bárbaros y una aventura, y diga cuáles bárbaros la sobreviven
sobrevivientes :: [Barbaro] -> Aventura -> [Barbaro]
sobrevivientes barbaros aventura = [barbaro | barbaro <- barbaros, (aventura barbaro == True)]


-----------------------------------FUNCIONES (3): Dinastia--------------------------------------------- 
-- Elimina elementos repetidos de una lista
sinRepetidos :: (Eq a) => [a] -> [a]
sinRepetidos listaNum 
	| listaNum == [] = []
	| any (== head listaNum) (tail listaNum) = sinRepetidos (tail listaNum)
	| otherwise = (take 1 listaNum) ++ sinRepetidos (tail listaNum)

--Aplicar las pertenencias sobre el mismo registro al cual pertenecen
crearDescendiente :: [Pertenencia] -> Barbaro -> Barbaro
crearDescendiente lista (Barbaro nombre fuerza habilidades pertenencias)  = (\(Barbaro n f habilidades p) -> (Barbaro n f (sinRepetidos habilidades) p)) $ (foldr ($) (Barbaro (nombre++"*") fuerza habilidades pertenencias) lista)

--Dado un barbaro se definen sus infinitos descendientes 
descendientes :: Barbaro -> [Barbaro]
descendientes barbaro@(Barbaro nombre fuerza habilidades pertenencias) = (crearDescendiente pertenencias) barbaro : descendientes ((crearDescendiente pertenencias) barbaro)

