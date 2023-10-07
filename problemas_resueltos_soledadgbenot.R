############RESOLUCIÓN DE LOS PROBLEMAS###########

##Soledad Gallego Benot

#Cargamos el fichero que incluyen varias funciones útiles para la aplicación de diferentes métodos de resolución
#de problemas de Teoría de Decisión bajo Incertidumbre

source("teoriadecision_funciones_incertidumbre.R")

#######PROBLEMA 1 -- SITUACIÓN FAVORABLE########

tablaPb1 <- crea.tablaX(c(88,160,130,
                          125,200,233,
                          136,230,98,
                          95,190,106), numalternativas = 4, numestados = 3)
tablaPb1

##Primero vamos a considerar la situación favorable, es decir, suponiendo que se tratasen de posibles beneficios

####CRITERIO DE WALD O PESIMISTA####
criterio.Wald(tablaPb1, favorable = T)
#Según el criterio de Wald, la mejor opción es d2

####CRITERIO OPTIMISTA####
criterio.Optimista(tablaPb1, T)
#El criterio optimista coincide con el criterio de Wald, considera como mejor opción d2

####CRITERIO DE HURWICZ####
criterio.Hurwicz(tablaPb1, T) #con alfa=0.3 por defecto
#El criterio de Hurwicz considera d2 como la mejor opción para un alfa=0.3. 
#Probemos con alfa=0.8
criterio.Hurwicz(tablaPb1, alfa = 0.8, T)
#Sigue considerando d2 como mejor opción
#Cabe resaltar que al coincidir el criterio pesimista y optimista es coherente que aún variando
#alfa se siga obteniendo el mismo resultado

dibuja.criterio.Hurwicz(tablaPb1, T)
#Se puede observar gráficamente como la línea discontinua coincide con la de d2

####CRITERIO DE SAVAGE####
criterio.Savage(tablaPb1, T)
#El criterio de Savage también considera d2 como la mejor opción

####CRITERIO LAPLACE####
criterio.Laplace(tablaPb1, T)
#Laplace considera d2 la mejor opción, al igual que los anteriores

####CRITERIO DEL PUNTO IDEAL####
criterio.PuntoIdeal(tablaPb1, T)
#El criterio del Punto Ideal es coincidente con los anteriores

#CONCLUSIÓN: Podemos concluir, por lo tanto, que en situación favorable, es decir, tratándose de ganancias o beneficios,
#todos los criterios coinciden en que la mejor opción dada la anterior matriz de decisión es la d2 

#######PROBLEMA 1 -- SITUACIÓN DESFAVORABLE########
#Si consideramos los valores de la tabla como costes o similar entonces se trataría como desfavorable

####CRITERIO DE WALD O PESIMISTA####
criterio.Wald(tablaPb1, F)
#El criterio de Wald considera como mejor opción en caso desfavorable d1

####CRITERIO OPTIMISTA####
criterio.Optimista(tablaPb1,F)
#El criterio optimista coincide con el pesimista. La mejor opción es d1

####CRITERIO DE HURWICZ####
criterio.Hurwicz(tablaPb1, favorable = F) #con alfa=0.3 por defecto
#El criterio de Hurwicz considera d1 como la mejor opción para un alfa=0.3. 
#Probemos con alfa=0.8
criterio.Hurwicz(tablaPb1, alfa = 0.8, favorable = F)
#Sigue considerando d1 como mejor opción

dibuja.criterio.Hurwicz(tablaPb1, favorable = F)
#Se puede observar gráficamente como la línea discontinua coincide con la de d1

####CRITERIO DE SAVAGE####
savageDesf <- criterio.Savage(tablaPb1, favorable = F)
#El criterio de Savage considera d4 como la mejor opción. Aún así, si observamos el valor
#que toman cada una de las alternativas, aunque este criterio no está de acuerdo con los anteriores
#se ve como la diferencia de la alternativa d1 y la d4 es muy pequeño
savageDesf$ValorAlternativas[c(1,4)]

####CRITERIO LAPLACE####
criterio.Laplace(tablaPb1, favorable = F)
#Laplace considera d1 la mejor opción

####CRITERIO DEL PUNTO IDEAL####
criterio.PuntoIdeal(tablaPb1, favorable = F)
#El criterio del Punto Ideal coincide con Savage considerando que d4 es la mejor opción. Aún así,
#la diferencia entre el valor de las alternativas d1 y d4 en este caso es casi despreciable,
#teniendo en cuenta la gran diferencia con respecto a todas las demás opciones posibles

#CONCLUSIÓN: Dado que la mayoría de los criterios consideran d1 como la opción más apropiada
#y que los que no lo hacen la consideran como segunda mejor alternativa y con muy poca diferencia
#con respecto a la que sería su alternativa óptima (d4), la opción óptima final sería d1.

# criterio.Todos(tablaPb1)
# criterio.Todos(tablaPb1, favorable = F)



#######PROBLEMA 2########

# Un estudiante con un nivel medio-avanzado en inglés, pero sin certificar, está 
# considerando sacarse el título correspondiente para mejorar su currículum y tener 
# mejores oportunidades académicas y laborales. Tiene la obligación de obtener alguna 
# titulación para la obtención de su título de grado y está considerando las opciones 
# de tratar de obtener un First Certificate (B2) o un Advanced Certificate (C1), ambos 
# muy bien valorados.
# 
# El examen correspondiente al nivel B2, junto con un curso asociado, cuesta 400€. Si 
# aprueba este examen, se le concederá al estudiante una beca de 400€, lo que implica 
# cubrir todos los gastos. Por otro lado, el examen correspondiente a C1, con su curso 
# de preparación, tiene un coste superior: 600€. No obstante, la beca que se obtendría 
# en caso de superar esta prueba alcanza los 1000€, otorgando un beneficio de 400€. 
# 
# Existe una tercera opción: un examen que contempla obtener un nivel u otro según 
# la calificación que tenga el alumno, siempre y cuando lo apruebe. Su coste es de 900€, 
# incluyendo el curso. Dado que no es lo mismo obtener un nivel u otro (B2 o C1), la 
# beca varía en función del nivel que se alcanza. Si el estudiante obtiene, en esta 
# modalidad de examen, un B2, la beca asciende a 1000€, dándole un beneficio de 100€. Si 
# obtiene un C1, la beca es de 1150€, con un beneficio de 250€. 
# 
# Si tenemos en cuenta los beneficios que podría obtener el estudiante, ¿qué opción 
# sería la más acertada teniendo en cuenta la incertidumbre asociada a su capacidad 
# para aprobar o no los exámenes?

# -	DECISOR: Estudiante
# -	ALTERNATIVAS: 
#   *d1 = “Presentarse al B2”
#   *d2 = “Presentarse al C1”
#   *d3 = “Presentarse al especial”
# -	ESTADOS DE LA NATURALEZA: 
#   *e1 = “Suspender el examen” 
#   *e2= “Aprobar dicho examen” 
#   *e3 = “Sacar nivel superior”

tablaPb2 <- crea.tablaX(c(-400, 0, 0,
                          -600, 400, 400,
                          -900, 100, 250), numalternativas = 3, numestados = 3)
resultado <- criterio.Todos(tablaPb2, favorable = T)
resultado

criterio.Todos(tablaPb2, favorable = T, alfa=0.35)

#CONCLUSIÓN: La mayoría de los criterios considera que realizar el C1 es lo mejor que el 
#estudiante puede hacer a nivel económico. El criterio pesimista o criterio de Wald, tal y cómo su
#propio nombre indica, cree que tratar de obtener el B2 es la mejor alternativa dado que en caso de suspender
#es el que menos coste tiene. Con el alfa=0.3 por defecto, el criterio de Hurwicz apoya más 
#el B2 por la misma razón que lo hace Wald. Sin embargo, si aumentamos lo mínimo alfa, por ejemplo a 0.35,
#el criterio de Hurwicz coincide con los demás criterios en que la opción más ventajosa es el examen de C1.

#Por tanto, realizar el examen de C1 es la alternativa más acertada para el estudiante.  
