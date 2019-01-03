#Objetos Numeric
a<-1
a
A=5; A
#Case-sensitive
a;A

#Objeto character
x=comando #sem "" o R procura por outro objeto
x
x="comando"
x

#
a<-"Nome"; a1<-10; b<-TRUE; c<-8i
mode(a); mode(a1); mode(b); mode(c)


#### Objetos Especiais #### 

#Vetores
vetor.x=c(2,3,5,7,10,13,15,20,21)
class(vetor.x); mode(vetor.x); typeof(vetor.x)
is.vector(vetor.x); is.list(vetor.x); is.matrix(vetor.x); is.data.frame(vetor.x)

#Lista
list.x=list(nome=c("João","Maria","Pedro","Ana"), idade=c(15,16,14), notas=c(9,7,6,8,10))
is.vector(list.x); is.list(list.x); is.matrix(list.x); is.data.frame(list.x)

#Matrizes
matriz.x=matrix(vetor.x,ncol=3)
is.vector(matriz.x); is.list(matriz.x); is.matrix(matriz.x); is.data.frame(matriz.x)

#Data.frame
setwd("C:\\Users\\Vander\\Desktop\\Curso R")
data.frame.x=read.table("pipoca.txt",h=T)
is.vector(data.frame.x); is.list(data.frame.x); is.matrix(data.frame.x); is.data.frame(data.frame.x)

#Função
add <- function(x, y) {
  x + y
}
add(5,9)
