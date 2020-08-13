##### criando estatisticas com o mapa do DF
require(maptools)
require(rgdal)
require(RcColorBrewer)
require(plotrix)
require(classInt)
library(GISTools)

mapa <- readShapeSpatial('C:\\Users\\kraise\\Desktop\\Meus programas\\R programas\\ras_pdad_2013.shp')
View(mapa)


levels(mapa$nome)<-gsub("Brazilia","Bras?lia",levels(mapa$nome))
levels(mapa$nome)<-gsub("Brazlandia","Brazl?ndia",levels(mapa$nome))
levels(mapa$nome)<-gsub("Candangolandia","Candangol?ndia",levels(mapa$nome))
levels(mapa$nome)<-gsub("Ceilandia","Ceil?ndia",levels(mapa$nome))
levels(mapa$nome)<-gsub("Guará","Guar?",levels(mapa$nome))
levels(mapa$nome)<-gsub("Nucleo Bandeirante","N?cleo Bandeirante",levels(mapa$nome))
levels(mapa$nome)<-gsub("Paranoa","Parano?",levels(mapa$nome))
levels(mapa$nome)<-gsub("São Sebastião","S?o Sebasti?o",levels(mapa$nome))

data <- rnorm(nrow(mapa@data))
intervalos <- c(-Inf,-2,-1,0,1,2,Inf)
cortes <- cut(data, intervalos, include.lowest=TRUE)
niveis <- levels(cortes)
cores <- heat.colors(length(levels(cortes)))
levels(cortes) <- cores
plot(mapa, border=gray(0.9), lwd=.1, axes = FALSE, las = 1,
     col=as.character(cortes))#mapa cru

# para deixar o mapa mais estilizados, segue abaixo:


#p/latrocinio+homicidio
mapa$total <- c(3,0,0,7,0,3,0,0,0,0,0,4,1,0,0,2,1,4,1,1,0,12,0,6,14,5,1,5,4,1,3)
data <- rnorm(nrow(mapa@data))
data <- mapa$total
View(mapa@data)#dados que serão mexidos
intervalos <- c(0,7,14,21)#define os intervalos
cortes <- cut(data, intervalos, include.lowest=TRUE)
niveis <- levels(cortes)
cores <- heat.colors(length(levels(cortes)))
cores <- c("#FFFF00FF","#FF8000FF","#FF0000FF")
levels(cortes) <- cores
x11()
plot(mapa, border=gray(0.1), lwd=.1, axes = FALSE, las = 1,
     col=as.character(cortes))
legend("right",niveis,fill=cores,bty="n",title="Densidade",cex=1.5)
pct <-as.character(mapa$nome)
text(coordinates(mapa), labels=pct, cex=.8)#caso precise calcular: trueCentroids = gCentroid(mapa,byid=TRUE), isso serve para caso queira modificar a posição dos nomes
title("Total de homic?dios e latroc?nios no DF")

#caso queira tirar os nomes:
plot(mapa, border=gray(0.1), lwd=.1, axes = FALSE, las = 1,
     col=as.character(cortes))
legend("right",niveis,fill=cores,bty="n",title="Densidade",cex=1.5)
pct <-as.character(mapa$nome)
text(coordinates(mapa),  cex=.8)#caso precise calcular: trueCentroids = gCentroid(mapa,byid=TRUE), isso serve para caso queira modificar a posição dos nomes
title("Total de homic?dios e latroc?nios no DF")



