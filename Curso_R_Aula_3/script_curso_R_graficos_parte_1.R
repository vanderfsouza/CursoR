#####################################################
#   INTRODU��O AO PROGRAMA ESTAT�STICO R - 2017     #
#       Constru��o de gr�ficos no ambiente R        #   
# Vander Fillipe de Souza / vanderfsouza@gmail.com  #
#####################################################

# Gr�ficos utilizando a fun��o plot()
# ?plot # Para informa��es sobre a fun��o digite ?plot no R
demo(graphics) # Exemplos de gr�ficos
dev.off() # finalizar os gr�ficos
rm(list=ls()) # para remover os arquivos armazenados do demo(graphics)

# Criando alguns objetos para os exemplos
(x<-1:10)
(y<-x**3)
(w<-x)
(z<-10/x)

# Plot b�sico
plot(x,y)	# plota os eixos x e y

# Dimens�o dos pontos
plot(x,y,cex=2.5) # o argumento cex altera a tamanho dos pontos 

# Padr�o dos pontos - argumento pch
plot(x,y,pch=3)
plot(x,y,pch="%")

# Tipos de gr�ficos - argumento type
plot(x,y,type="p") #points
plot(x,y,type="l") #lines  
plot(x,y,type="b") #both
plot(x,y,type="o") #overplotted 
plot(x,y,type="s") #stair
plot(x,y,type="h") #histogram 

# Cores dos pontos - argumento col
plot(x,y,pch=3, col=3)
plot(x,y,pch=3, col="red") # verificar paleta de cores no documento Rcolor.pdf

# Exemplos de padr�es e cores de pontos
plot(0:20,0:20,pch=0:20,col=0:20, cex=2)

# Adicionando mais informa��es ao gr�fico
plot(x,y)
points(x,rev(y),pch=3)
lines(x,800-y)

# Estilos da linha - argumento lty 
plot(x,y,type="n")
lines(x,y,lty=2) # linhas tracejadas (op��es de lty de 1 a 6)

# Espessura da linha - argumento lwd
plot(x,y,type="n")
lines(x,y,lwd=4) # 

# T�tulo e Textos
plot(x,y,xlab="Eixo X",ylab= expression(km^2))
title("T�tulo \n do Gr�fico")		# use \n para inserir um par�grafo
text (4,400, "Texto", family="mono")  # Exemplos (de fontes) para family: "serif", "sans" and "mono"

## Editando eixos

y<-c(2,5,9,6,7,8,4,1,3,10)
y2<-c(0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0,1.1)

options(OutDec=",") # Transformar o s�mbolo decimal dos eixos para ","
plot(x,y2)

options(OutDec=".") # Retornar para o padr�o do R "."
plot(x,y2)

# Valores do eixo na horizontal e na vertical
plot(x,w,type="b", pch=21,col="red")
plot(x,w,type="b", pch=21,col="red",las=1) # las modifica a posi��o dos valores nos eixos (horizontal e vertical)  

# Gr�fico com mais de um eixo 
plot(x,w,type="b",pch=21,col="red",
     yaxt="n", xlab="", ylab="")	# yaxt remove o eixo y
lines(x,z,type="b",pch=22,col="blue")

# Utilizando a fun��o axis() para editar e incluir eixos
# Criando o eixo da esquerda "2"
axis(2, at=w, labels=x, col.axis="red", las=2)

# Criando o eixo da direita  "4"
axis(4, at=z, labels=round(z,digits=2),	# round � utilizado apenas para arredondar os n� para duas casas ap�s a v�rgula 
     col.axis="blue", las=2)

# Utilizando legend() para criar e editar legendas
legend(3,10,				# posi��o da legenda no gr�fico conforme ou eixos ou utilize: "bottom", "left", "right", "center", "top", "topright", "topleft"
       c("Eixo A","Eixo B"),		# os t�tulos das legendas  
       lty=c(1,1),			# s�mbolos das legendas (lines)
       lwd=c(1,1),col=c("blue","red"),  # espessura e cor dos s�mbolos
       ncol=2,				# N� de colunas da legenda 
       cex=0.5)				# Dimens�o da legenda       

###

# Exemplo - Gr�fico b�sico
plot(x,y)

# Exemplo - Gr�fico editado
plot(x,y,  	# plota x e y
     xlab="Eixo x",	# nomeia o eixo x
     ylab="Eixo y",	# nomeia o eixo y
     main="T�tulo",	# t�tulo 
     xlim=c(0,10),	# limite do eixo x
     ylim=c(0,10),	# limite do eixo y
     col="red",		# cor dos pontos
     pch=22,		# formato dos pontos
     bg="blue",		# cor de preenchimento
     tcl=0.4,		# tamanho dos tra�os dos eixos
     las=1,		# orienta��o do texto em y 
     cex=1.5,		# tamanho do ponto
     bty="l")		# altera as bordas	
box()

###########################################################

# Exemplo com o banco de dados "iris" - Gr�fico de dispers�o

iris     	# Banco de dados interno do R, utilizado como exemplo 
str(iris)	# Estrutura do banco de dados iris

plot(iris$Sepal.Length, iris$Petal.Length, pch=16)

plot(iris$Sepal.Length, iris$Petal.Length, col = iris$Species,pch=16) # cores dos pontos em fun��o das especies
legend("bottomright", legend = levels(iris$Species), col = c(1:3), pch = 16, ncol=3,cex=0.7,box.lty=0)

###########################################################

# Gr�fico de Barras - Barplot

medias <- c(18, 10, 27, 25, 30)

barplot(medias)
barplot(medias,
        main="Produtividade M�dia",
        ylab="kg por parcela",
        xlab="Tratamentos",
        names.arg=c("A", "B", "C", "D", "E"),
        col="darkred",
        horiz=F)

##########################################################

# Gr�fico de caixas - Boxplot

iris
summary(iris)

boxplot(iris)
boxplot(iris$Sepal.Length ~ iris$Species, notch = F) #modifique: notch = T

##########################################################

# Histograma

hist(iris$Sepal.Length)
hist(iris$Sepal.Length,
     nc=5,              # N�mero de classes
     main="T�tulo",     # T�tulo do gr�fico
     ylim=c(0,100),     # limites do eixo y
     xlab="Classes",    # T�tulo do x
     ylab="Frequencia", # T�tulo do y
     col=8)             # cor das barras

###########################################################

## Plot de um data.frame
iris
str(iris)

plot(iris$Sepal.Length,iris$Petal.Length) # Exemplo 1
plot(Petal.Length~Sepal.Length,data=iris) # Exemplo 2

## Plot de uma s�rie temporal
AirPassengers
str(AirPassengers)
plot(AirPassengers)

abline(h=mean(AirPassengers),lty=2,col="red")   # plot uma linha na horizontal "h" mean(AirPassengers) calcula a m�dia 
abline(v=1954,lty=1,col="blue")                 # plot uma linha na vertical "v"

### Gr�fico de Regress�o Linear

plot(iris$Sepal.Length,iris$Petal.Length)	# Plot normal
lines(iris$Sepal.Length,iris$Petal.Length) # lines n�o plota diretamente uma regress�o

reglin<-lm(iris$Petal.Length~iris$Sepal.Length)		# A fun��o lm � utilizada para regress�o linear 
reglin			# Apresenta os coeficientes da regress�o: intercepto e coeficiente de rela��o entre comprimento da p�tala e comprimento da s�pala (ou seja, quanto do comprimento da p�tala ir� variar para cada varia��o unit�ria do comprimento da s�pala) 
summary(reglin)		# sum�rio dos resultados da an�lise
predict(reglin)		# valores preditos pela regress�o para comprimento da S�pala "Sepal.Length" 

plot(iris$Sepal.Length,iris$Petal.Length)
lines(iris$Sepal.Length,predict(reglin),type="l")    # utilizando os valores preditos pela regress�o
# ou
plot(iris$Sepal.Length,iris$Petal.Length)
abline(reglin)                                       # reta de regress�o ajustada

# Plot Final
plot(iris$Sepal.Length,iris$Petal.Length,col="darkblue",lwd=2,
     main= "Regress�o Linear",xlab="Comprimento da S�pala (cm)",ylab="Comprimento da P�tala (cm)",las=1) 
text(5,7,"y=-7.101+1.858x, R2=0.76", col="red")	# Plota o texto dentro da figura
mtext("y=-7.101+1.858x, R2=0.76",family="serif")	    # Plota o texto fora da figura # family corresponde a fonte do texto
abline(reglin)				                # Reta de regress�o ajustada

################################################

### Exportar Gr�fico

jpeg(filename = "figura_exemplo.jpeg",      # o formato .tiff oferece maior resolu��o
     width = 2000, height = 2000, units = "px", res = 300)  # Configura��o da resolu��o da figura

plot(iris$Sepal.Length,iris$Petal.Length,col="darkblue",lwd=2,
     main= "Regress�o Linear",xlab="Comprimento da S�pala (cm)",ylab="Comprimento da P�tala (cm)",las=1) 
text(5,7,"y=-7.101+1.858x, R2=0.76", col="red")
mtext("y=-7.101+1.858x, R2=0.76",family="serif")
abline(reglin)

dev.off() # finaliza a figura

################################################

### Gerando gr�ficos m�ltiplos 
# para plotar mais de um gr�fico conjuntamente utilize a fun��o par() e o argumento mfrow.

pdf("figura_graficos_multiplos.pdf") # Cria o arquivo da imagem .pdf

par(mfrow=c(2,2))  #### arranjo dos gr�ficos = 2 (linhas) x 2 (colunas).

plot(x,y)
hist(medias)
barplot(medias)
boxplot(medias)

dev.off() # finaliza a figura

# par(mfrow=c(1,1)) # para retornar ao padr�o de 1 gr�fico por janela ou feche a janela gr�fica 

# par() # tamb�m pode ser utilizada para alterar o tamanho das margens de uma figura
# par(mar=c(5, 4, 4, 8) + 0.1)  # Exemplo: par(mar=c(em baixo,� esquerda,superior,direita))
# par(mar=c(5, 4, 4, 2) + 0.1)	# Dimens�o padr�o (Default do R)

#################################################################

### Exemplo de pacote gr�fico

iris
plot(iris)
#install.packages("psych")
require(psych)
pairs.panels(iris,smooth=F,scale=F,density=F,ellipses=F,method="pearson",pch=20,rug=F,cex.labels = 1.5, font.labels=2, cex.cor=0.5)

###########################################################

# Arquivo de dados para o exerc�cio 

getwd() # verifique onde est� "setado" o diret�rio de trabalho do R
setwd("C:\\...") # digite a localiza��o do seu arquivo de dados no seu computador
dados<-read.table("Dados.txt",header = T) # carregando os dados do arquivo .txt
str(dados) # verificando a estrutura dos dados
plot(dados$Trat,dados$Var1)

###########################################################
# Sugest�o de exerc�cio:                                  #
# fa�a um gr�fico m�ltiplo utilizando o arquivo Dados.txt;#
# utilize diferentes tipos de gr�ficos a sua escolha;     #
# edite diferentes estilos, eixos, cores, etc..;           #
# exporte a figura como .jpeg ou pdf                      #
###########################################################

## Refer�ncias 
#  Peternelli e Mello (2011) Conhecendo o R - Uma vis�o estat�stica # 
#  http://www.statmethods.net/graphs/
#  http://www.statmethods.net/advgraphs/parameters.html # (exemplos de pontos, linhas, cores e fontes)
#  http://stackoverflow.com/
#  http://rstudio-pubs-static.s3.amazonaws.com/
#  http://www.cookbook-r.com/Graphs/