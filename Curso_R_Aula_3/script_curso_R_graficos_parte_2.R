######################################################
#    INTRODUÇÃO AO PROGRAMA ESTATÍSTICO R - 2017     #
# Construção de gráficos utilizando o pacote ggplot2 #   
# Vander Fillipe de Souza  # vanderfsouza@gmail.com  #
######################################################

#install.packages("ggplot2") # para instalar o pacote ggplot2
library(ggplot2) # carregar o pacote

iris # Banco de dados nativo do R
class(iris) # ggplot2 trabalha com dataframes

# Informações úteis em: http://docs.ggplot2.org/current/
# No ggplot2 os argumentos são diferentes da função plot()
# Estrutura básica da função ggplot:
# I) ggplot (informa o banco de dados)
# II) aes (informa as variáveis e configura a estética do gráfico) 
# III) geom_point(); geom_bar(); geom_boxplot() determina o estilo do gráfico

# Exemplo básico

ggplot(iris) + # I
  aes(x=Sepal.Length,y=Petal.Length) + #II
  geom_point() #III  
#ou
A <- ggplot(iris) + aes(x=Sepal.Length,y=Petal.Length) + geom_point() # o gráfico pode ser armazenado em um objeto
A
#ou
(A <- ggplot(iris) + aes(x=Sepal.Length,y=Petal.Length) + geom_point()) # o script entre () executa o plot automaticamente 

# Incluindo informações no gráfico

ggplot(iris) +
 aes(x=Sepal.Length,y=Petal.Length, colour=Species) + # o argumento aes configura a estética do gráfico
 geom_point()
# ou
ggplot(iris) + aes(x=Sepal.Length,y=Petal.Length) + geom_point(aes(colour=Species)) 

###############################################

## Histogramas

ggplot(iris, aes(x=Sepal.Length)) + # observe que para o histograma consideramos apenas o eixo x
  geom_histogram(binwidth=.5) # binwidth=.5 determina o intervalo entre as classes

ggplot(iris, aes(x=Sepal.Length)) +
  geom_histogram(binwidth=.5, colour="black", fill="white") # colour: Borda, fill: Preenchimento

ggplot(iris, aes(x=Sepal.Length)) +
  geom_density() # Gráfico de densidade

ggplot(iris, aes(x=Sepal.Length)) +
  geom_histogram(aes(y=..density..),
  binwidth=.5, colour="black", fill="white") +
  geom_density()

ggplot(iris, aes(x=Sepal.Length,fill=Species)) + geom_density(alpha=I(.5)) # em função das espécies #alpha=controla a transparência das cores

###############################################

## Gráfico de barras - Barplot

ggplot(iris) + 
  aes(y=Sepal.Length,x=Species, colour=Species) +
  geom_bar(stat="identity",aes(fill=Species)) # stat="identity" a altura das barras correspondem ao eixo y 
  
# Adicionando barras de erro ou Barplot

Produtividade <- c(18, 10, 27, 25, 30)
Erro <- c(5, 2, 3, 6, 4)
Tratamento <- c("A", "B", "C", "D", "E")

data <- data.frame(Tratamento, Produtividade, Erro)
limits <- aes(ymax = Produtividade + Erro, ymin = Produtividade - Erro)

(p <- ggplot(data, aes(Tratamento,Produtividade)))
(p <- p + geom_bar(stat='identity'))
(p <- p + geom_errorbar(limits))
  
################################################

## Dispersão

ggplot(iris) +
  aes(x=Species,y=Petal.Length) +
  geom_point()

ggplot(iris) +
  aes(x=Species,y=Petal.Length) +
  geom_jitter() # pontos sobrepostos ficam espelhados 

ggplot(iris) +
  aes(x=Species,y=Petal.Length) +
  geom_jitter(aes(colour=Species))

## Boxplot

ggplot(iris) +
  aes(x=Species,y=Petal.Length) +
  geom_boxplot()

ggplot(iris) +
  aes(x=Species,y=Petal.Length) +
  geom_boxplot(aes(colour=Species))

ggplot(iris) +
  aes(x=Species,y=Petal.Length) +
  geom_boxplot() +
  geom_jitter(aes(colour=Species))

#########################################################

## Layout em grades - facet grid

ggplot(iris) +
  aes(x=Sepal.Width, y=Sepal.Length, colour=Species) +
  geom_boxplot() +
  geom_jitter() +
  facet_wrap(~Species)
  
### Plotar múltiplas variáveis

#install.packages("reshape") # reestrutura os dados 
library(reshape) 

iris2<-melt(iris,id.vars="Species") # separar as observações em função da variável espécies
head(iris)  # anterior
head(iris2) # após melt

ggplot(iris2) +
  aes(y=value, x=Species, colour=Species) +
  facet_wrap(~variable) +
  geom_boxplot() +
  geom_jitter()

################################################

## Regressão linear com geom_smooth()

ggplot(iris) +
  aes(x=Sepal.Length, y=Petal.Length) +
  geom_point(aes(colour=Species)) +
  geom_smooth(method="lm") # lm para modelo linear

## regressão por espécies

ggplot(iris)+
  aes(x=Sepal.Width, y=Sepal.Length, colour=Species) +
  geom_point() +
  geom_smooth(method="lm") +
  facet_wrap(~Species, scale="free")

#################################################

# Formatação de gráficos

head(mtcars)

# Formatando pontos
(p <- ggplot(mtcars, aes(wt, mpg,label = rownames(mtcars))))

(p + geom_point(shape = 23, colour = "darkgreen", fill = "yellow", size = 2, stroke = 2))

(p + geom_point(aes(colour = cyl)))
(p + geom_point(aes(colour = cyl)) + scale_colour_gradient(low = "red", high = "blue"))

(p + geom_point(aes(colour = factor(cyl))))
(p + geom_point(aes(colour = factor(cyl))) + scale_colour_manual(values = c("blue", "red","green")))

(p + geom_point(aes(shape = factor(cyl))))
(p + geom_point(aes(shape = factor(cyl))) + scale_shape(solid = FALSE))

(p + geom_point(aes(size = qsec)))

(p + geom_point(aes(size = qsec, shape=factor(am), colour=factor(cyl))))

# Utilizando geom_text() para plotar nomes dos pontos
(p + geom_text(aes(label = rownames(mtcars)),check_overlap = TRUE)) # check_overlap = TRUE evita a sobreposição dos textos 

#####################################################

# Cor do fundo da figura 

(p + theme_bw()) # fundo em branco
(p + theme(panel.background = element_rect(fill = "blue"))) # modifica a cor do fundo

#####################################################

# Exemplo da construção de um gráfico utilizando ggplot2

setwd("C:\\...") # especifique o caminho da pasta aula 3
load("Exemplo_de_gráfico_ggplot2.RData") # carregar a imagem dos dados
bp
rm(list=ls())

PlantGrowth
str(PlantGrowth)

(bp <- ggplot(data=PlantGrowth, aes(x=group, y=weight, fill=group)) + geom_boxplot())

# Títulos
(bp <- bp + ggtitle("Boxplot")) # Título do gráfico
(bp <- bp + ylab("Peso (Kg)") + xlab("")) # Títulos dos eixos

# Eixos
(bp + coord_flip()) # inverter eixos
(bp + ylim(3, 7)) # determina o intervalo do eixo y
(bp + scale_y_continuous(breaks=seq(4, 6, 0.25)))  # determina o intervalo da escala

# Alterando os títulos do eixo x 
(bp<-bp + scale_x_discrete(breaks=c("ctrl", "trt1", "trt2"),
                           labels=c("Controle", "Tratamento 1", "Tratamento 2")))

# Alterando a legenda
(bp<-bp + scale_fill_manual(values=c("#e41a1c", "#006d2c", "#08519c"),        # cores 
                            name="Condições \nExperimentais",                      # título
                            breaks=c("ctrl", "trt1", "trt2"),                      # nomes atuais 
                            labels=c("Controle", "Tratamento 1", "Tratamento 2"))) # novos nomes

# Formatando Eixos e Legendas usando theme()
(bp + theme(legend.position = "none")) # Posições: c(x,y) de 0 a 1 ou "left","right","top","bottom". Sem legenda: "none" 
(bp <- bp + theme(legend.title = element_text(colour="#737373", size=16, face = "bold"))) # para o título da legenda em branco: element_blank()  
(bp <- bp + theme(legend.text = element_text(colour="#737373", size = 16))) # formata o texto das legendas
(bp <- bp + theme(axis.title.y = element_text("bold", colour="#737373", size=12))) # formata o título do eixo y
(bp <- bp + theme(axis.text.x = element_text(angle=45, vjust=0.5, size=12))) # formata o texto do eixo x
(bp <- bp + theme(plot.title = element_text(face="bold", size=20))) # formata o título do gráfico

##################################################

# Exportar imagem

ggsave("exemplo_curso.pdf") # salva a imagem ggplot

#ou

pdf("exemplo_ggplot2.pdf") # Cria o arquivo da imagem .pdf
bp
dev.off()

##################################################

# Outros exemplos utilizando ggplot2 

## Árvores filogenéticas e cladogramas com ggtree

#source("https://bioconductor.org/biocLite.R") ## try http:// if https:// URLs are not supported
#biocLite("ggtree") 

library("ggtree")
library("ggplot2")

nwk <- system.file("extdata", "sample.nwk", package="ggtree")
tree <- read.tree(nwk)

ggplot(tree, aes(x, y)) + geom_tree() + theme_tree2() + xlab("") + ylab("")

browseVignettes("ggtree") # veja as opções de formatação

#############

## Plot de Matrizes

mydata <- mtcars[, c(1,3,4,5,6,7)]
head(mydata)
cormat <- round(cor(mydata),2)
head(cormat)
melted_cormat <- melt(cormat)
ggplot(data = melted_cormat, aes(x=X1, y=X2, fill=value)) + 
  geom_tile() +  
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", 
                       midpoint = 0, limit = c(-1,1), space = "Lab", 
                       name="Pearson\nCorrelation")

#############

# Contornos - geom_contour() # Exemplos em: http://docs.ggplot2.org/current/geom_contour.html 

str(faithfuld)
head(faithfuld)

v <- ggplot(faithfuld, aes(waiting, eruptions, z = density))
v + geom_contour()
v + geom_contour(binwidth = 0.001)
v + geom_raster(aes(fill = density)) +  geom_contour(colour = "white")

############

## Mapas - rgdal

#install.packages("colorRamps")
#install.packages("rgdal")
library(colorRamps)
library(rgdal)
library(ggplot2)

data<-read.table("coordenadasvcu.txt",header=TRUE)
data
latitude<-data$Latitude
longitude<-data$Longitude

estado<-readOGR("estado.shp", layer="estado")
ggplot() + geom_polygon(data=estado, aes(x=long, y=lat, group=group), fill="grey40", colour="grey90", alpha=1)+
  geom_point(aes(x=Longitude, y=Latitude, color=Local), data=data, alpha=1, size=2) +
  coord_equal(ratio=1) #
  
#############

## Integração com o Google earth - R2G2

#install.packages("R2G2")
library(R2G2)

nesting<-data$TBH
coordsMat<-cbind(longitude,latitude)

Shapes2GE(center=coordsMat, nesting, maxAlt=nesting*5000, nedges=4, radius=40000, goo="TBH.kml", colors="auto")

browseURL("TBH.kml")

#################################################

## Exemplos interessantes
# http://tutorials.iq.harvard.edu/R/Rgraphics/Rgraphics.html # Exemplo bem interessante da contrução de uma gráfico com alta qualidade
# https://github.com/hadley/ggplot2/wiki/Crime-in-Downtown-Houston,-Texas-:-Combining-ggplot2-and-Google-Maps # combinando ggplot2 com google maps
# http://www.seasonaladjustment.com/2012/09/05/clock-plot-visualising-seasonality-using-r-and-ggplot2-part-3/

## Referências
# http://docs.ggplot2.org/current/index.html # Help topics ggplot2
# http://www.cookbook-r.com/Graphs/Plotting_distributions_(ggplot2)/ # Distribuições (Histogramas, Densidade, Boxplot)
# http://www.ats.ucla.edu/STAT/r/faq/smooths.htm # Smooths (linear, quadrática e polinomial)
# http://www.cookbook-r.com/Graphs/Legends_(ggplot2)/ # Legendas
# http://www.cookbook-r.com/Graphs/Axes_(ggplot2)/ # Eixos
# http://www.sthda.com/english/wiki/ggplot2-quick-correlation-matrix-heatmap-r-software-and-data-visualization # Plot de Matrizes e Heatmap