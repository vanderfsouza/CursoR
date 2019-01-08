#####################################################
#   INTRODUÇÃO AO PROGRAMA ESTATÍSTICO R - 2019     #
#       Construção de gráficos no ambiente R        #   
#              vanderfsouza@gmail.com               #
#####################################################

# Gráficos utilizando a função plot()
# ?plot # Para informações sobre a função digite ?plot no R
demo(graphics) # Exemplos de gráficos
dev.off() # finalizar os gráficos
rm(list=ls()) # para remover os arquivos armazenados do demo(graphics)

# Criando alguns objetos para os exemplos
(x<-1:10)
(y<-x**3)
(w<-x)
(z<-10/x)

# Plot básico
plot(x,y)	# plota os eixos x e y

# Dimensão dos pontos
plot(x,y,cex=2.5) # o argumento cex altera a tamanho dos pontos 

# Padrão dos pontos - argumento pch
plot(x,y,pch=3)
plot(x,y,pch="%")

# Tipos de gráficos - argumento type
plot(x,y,type="p") #points
plot(x,y,type="l") #lines  
plot(x,y,type="b") #both
plot(x,y,type="o") #overplotted 
plot(x,y,type="s") #stair
plot(x,y,type="h") #histogram 

# Cores dos pontos - argumento col
plot(x,y,pch=3, col=3)
plot(x,y,pch=3, col="red") # verificar paleta de cores no documento Rcolor.pdf

# Exemplos de padrões e cores de pontos
plot(0:20,0:20,pch=0:20,col=0:20, cex=2)

# Adicionando mais informações ao gráfico
plot(x,y)
points(x,rev(y),pch=3)
lines(x,800-y)

# Estilos da linha - argumento lty 
plot(x,y,type="n")
lines(x,y,lty=2) # linhas tracejadas (opções de lty de 1 a 6)

# Espessura da linha - argumento lwd
plot(x,y,type="n")
lines(x,y,lwd=4) # 

# Título e Textos
plot(x,y,xlab="Eixo X",ylab= expression(km^2))
title("Título \n do Gráfico")		# use \n para inserir um parágrafo
text (4,400, "Texto", family="mono")  # Exemplos (de fontes) para family: "serif", "sans" and "mono"

## Editando eixos

y<-c(2,5,9,6,7,8,4,1,3,10)
y2<-c(0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0,1.1)

options(OutDec=",") # Transformar o símbolo decimal dos eixos para ","
plot(x,y2)

options(OutDec=".") # Retornar para o padrão do R "."
plot(x,y2)

# Valores do eixo na horizontal e na vertical
plot(x,w,type="b", pch=21,col="red")
plot(x,w,type="b", pch=21,col="red",las=1) # las modifica a posição dos valores nos eixos (horizontal e vertical)  

# Gráfico com mais de um eixo 
plot(x,w,type="b",pch=21,col="red",
     yaxt="n", xlab="", ylab="")	# yaxt remove o eixo y
lines(x,z,type="b",pch=22,col="blue")

# Utilizando a função axis() para editar e incluir eixos
# Criando o eixo da esquerda "2"
axis(2, at=w, labels=x, col.axis="red", las=2)

# Criando o eixo da direita  "4"
axis(4, at=z, labels=round(z,digits=2),	# round é utilizado apenas para arredondar os nº para duas casas após a vírgula 
     col.axis="blue", las=2)

# Utilizando legend() para criar e editar legendas
legend(3,10,				# posição da legenda no gráfico conforme ou eixos ou utilize: "bottom", "left", "right", "center", "top", "topright", "topleft"
       c("Eixo A","Eixo B"),		# os títulos das legendas  
       lty=c(1,1),			# símbolos das legendas (lines)
       lwd=c(1,1),col=c("blue","red"),  # espessura e cor dos símbolos
       ncol=2,				# Nº de colunas da legenda 
       cex=0.5)				# Dimensão da legenda       

###

# Exemplo - Gráfico básico
plot(x,y)

# Exemplo - Gráfico editado
plot(x,y,  	# plota x e y
     xlab="Eixo x",	# nomeia o eixo x
     ylab="Eixo y",	# nomeia o eixo y
     main="Título",	# título 
     xlim=c(0,10),	# limite do eixo x
     ylim=c(0,10),	# limite do eixo y
     col="red",		# cor dos pontos
     pch=22,		# formato dos pontos
     bg="blue",		# cor de preenchimento
     tcl=0.4,		# tamanho dos traços dos eixos
     las=1,		# orientação do texto em y 
     cex=1.5,		# tamanho do ponto
     bty="l")		# altera as bordas	
box()

###########################################################

# Exemplo com o banco de dados "iris" - Gráfico de dispersão

iris     	# Banco de dados interno do R, utilizado como exemplo 
str(iris)	# Estrutura do banco de dados iris

plot(iris$Sepal.Length, iris$Petal.Length, pch=16)

plot(iris$Sepal.Length, iris$Petal.Length, col = iris$Species,pch=16) # cores dos pontos em função das especies
legend("bottomright", legend = levels(iris$Species), col = c(1:3), pch = 16, ncol=3,cex=0.7,box.lty=0)

###########################################################

# Gráfico de Barras - Barplot

medias <- c(18, 10, 27, 25, 30)

barplot(medias)
barplot(medias,
        main="Produtividade Média",
        ylab="kg por parcela",
        xlab="Tratamentos",
        names.arg=c("A", "B", "C", "D", "E"),
        col="darkred",
        horiz=F)

##########################################################

# Gráfico de caixas - Boxplot

iris
summary(iris)

boxplot(iris)
boxplot(iris$Sepal.Length ~ iris$Species, notch = F) #modifique: notch = T

##########################################################

# Histograma

hist(iris$Sepal.Length)
hist(iris$Sepal.Length,
     nc=5,              # Número de classes
     main="Título",     # Título do gráfico
     ylim=c(0,100),     # limites do eixo y
     xlab="Classes",    # Título do x
     ylab="Frequencia", # Título do y
     col=8)             # cor das barras

###########################################################

## Plot de um data.frame
iris
str(iris)

plot(iris$Sepal.Length,iris$Petal.Length) # Exemplo 1
plot(Petal.Length~Sepal.Length,data=iris) # Exemplo 2

## Plot de uma série temporal
AirPassengers
str(AirPassengers)
plot(AirPassengers)

abline(h=mean(AirPassengers),lty=2,col="red")   # plot uma linha na horizontal "h" mean(AirPassengers) calcula a média 
abline(v=1954,lty=1,col="blue")                 # plot uma linha na vertical "v"

### Gráfico de Regressão Linear

plot(iris$Sepal.Length,iris$Petal.Length)	# Plot normal
lines(iris$Sepal.Length,iris$Petal.Length) # lines não plota diretamente uma regressão

reglin<-lm(iris$Petal.Length~iris$Sepal.Length)		# A função lm é utilizada para regressão linear 
reglin			# Apresenta os coeficientes da regressão: intercepto e coeficiente de relação entre comprimento da pétala e comprimento da sépala (ou seja, quanto do comprimento da pétala irá variar para cada variação unitária do comprimento da sépala) 
summary(reglin)		# sumário dos resultados da análise
predict(reglin)		# valores preditos pela regressão para comprimento da Sépala "Sepal.Length" 

plot(iris$Sepal.Length,iris$Petal.Length)
lines(iris$Sepal.Length,predict(reglin),type="l")    # utilizando os valores preditos pela regressão
# ou
plot(iris$Sepal.Length,iris$Petal.Length)
abline(reglin)                                       # reta de regressão ajustada

# Plot Final
plot(iris$Sepal.Length,iris$Petal.Length,col="darkblue",lwd=2,
     main= "Regressão Linear",xlab="Comprimento da Sépala (cm)",ylab="Comprimento da Pétala (cm)",las=1) 
text(5,7,"y=-7.101+1.858x, R2=0.76", col="red")	# Plota o texto dentro da figura
mtext("y=-7.101+1.858x, R2=0.76",family="serif")	    # Plota o texto fora da figura # family corresponde a fonte do texto
abline(reglin)				                # Reta de regressão ajustada

################################################

### Exportar Gráfico

jpeg(filename = "figura_exemplo.jpeg",      # o formato .tiff oferece maior resolução
     width = 2000, height = 2000, units = "px", res = 300)  # Configuração da resolução da figura

plot(iris$Sepal.Length,iris$Petal.Length,col="darkblue",lwd=2,
     main= "Regressão Linear",xlab="Comprimento da Sépala (cm)",ylab="Comprimento da Pétala (cm)",las=1) 
text(5,7,"y=-7.101+1.858x, R2=0.76", col="red")
mtext("y=-7.101+1.858x, R2=0.76",family="serif")
abline(reglin)

dev.off() # finaliza a figura

################################################

### Gerando gráficos múltiplos 
# para plotar mais de um gráfico conjuntamente utilize a função par() e o argumento mfrow.

pdf("figura_graficos_multiplos.pdf") # Cria o arquivo da imagem .pdf

par(mfrow=c(2,2))  #### arranjo dos gráficos = 2 (linhas) x 2 (colunas).

plot(x,y)
hist(medias)
barplot(medias)
boxplot(medias)

dev.off() # finaliza a figura

# par(mfrow=c(1,1)) # para retornar ao padrão de 1 gráfico por janela ou feche a janela gráfica 

# par() # também pode ser utilizada para alterar o tamanho das margens de uma figura
# par(mar=c(5, 4, 4, 8) + 0.1)  # Exemplo: par(mar=c(em baixo,à esquerda,superior,direita))
# par(mar=c(5, 4, 4, 2) + 0.1)	# Dimensão padrão (Default do R)

#################################################################

### Exemplo de pacote gráfico

iris
plot(iris)
#install.packages("psych")
require(psych)
pairs.panels(iris,smooth=F,scale=F,density=F,ellipses=F,method="pearson",pch=20,rug=F,cex.labels = 1.5, font.labels=2, cex.cor=0.5)

###########################################################

# Arquivo de dados para o exercício 

getwd() # verifique onde está "setado" o diretório de trabalho do R
setwd("C:\\...") # digite a localização do seu arquivo de dados no seu computador
dados<-read.table("Dados.txt",header = T) # carregando os dados do arquivo .txt
str(dados) # verificando a estrutura dos dados
plot(dados$Trat,dados$Var1)

###########################################################
# Sugestão de exercício:                                  #
# faça um gráfico múltiplo utilizando o arquivo Dados.txt;#
# utilize diferentes tipos de gráficos a sua escolha;     #
# edite diferentes estilos, eixos, cores, etc..;           #
# exporte a figura como .jpeg ou pdf                      #
###########################################################

## Referências 
#  Peternelli e Mello (2011) Conhecendo o R - Uma visão estatística # 
#  http://www.statmethods.net/graphs/
#  http://www.statmethods.net/advgraphs/parameters.html # (exemplos de pontos, linhas, cores e fontes)
#  http://stackoverflow.com/
#  http://rstudio-pubs-static.s3.amazonaws.com/
#  http://www.cookbook-r.com/Graphs/
