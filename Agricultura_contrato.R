###################################################################
# Agricultura de Contrato y experimentos de elección: Un modelo logit mixto aplicado a pequeños productores de la región del Bío-Bío
# Autores: Juan Cabas, Héctor Garrido &  José María Gil*/
# Archivo para reproducir resultados */
# Bases de datos necesarias: baseChoice.csv */
#####################################################################  

remove(list=ls())
library(mlogit) #Paquete requerido para la estimación. Héctor
data<-read.csv("/home/hector/Research/Own Papers/Artículo - Agricultura de Contrato/baseChoice.csv")
names(data)
head(data)[1:7]
#Nota 1: Aquí encontré un error en la base de datos. Si bien existía un identificador
#para cada decisión, este no era único por cada individuo. Cada individuo
#toma 16 decisiones, por lo que además del id, creé la variable 
#scenario que recoge este ítem. 
#Nota 2: Adicionalmente cree la variable no.option la que toma un valor de 1 cuando
#el individuo no escoge ninguna opción de las disponibles y cero en los demás casos. 
#Dicha variable cumple el rol de intercepto en el modelo.

#fix(data)
AC<-mlogit.data(data, choice="choice", shape="long", id.var="id"
            #chid.var="scenario"
            , alt.var="contract", drop.index=TRUE)

logit.condicional<-summary(mlogit(choice~no.option+F.1.1+F.1.2, data=AC))

logit.mixto<-mlogit(choice~F.1.1+F.1.2, data=AC, panel=TRUE
                   , rpar=c( F.1.1="n", F.1.2="n"), R=100, halton=NA)
