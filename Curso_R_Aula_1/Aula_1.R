########################################
##                                    ##
## INTRODUÇÃO AO PROGRAMA ESTATÍSCO R ##
##                                    ##
########################################

#### Limpar Banco de Dados do R ####
ls()
rm(list=ls())
ls()

##########################

#### Operações Básicas #####
#   DICAS:
#   use '#' para realizar comentários. O que é escrito após o '#' não é "lido" como comando pelo R. 
#   abuse dos comentários, um código brilhante não tem utilidade se você não lembrar para que servem os comandos!

4+3
7-3
7*3
7^2; 7**2 # mesmo resultado (PONTO E VIRGULA TERMINA UM COMANDO)
7/2
7%/%2 #divisão de inteiro
1:10
##
x<-7/3
x
x<-round(x,3)
x
sqrt(9) #raiz quadrada
factorial(4)#fatorial
0/0 ### NaN (not a number)

a<- 5; b=5  #ATRIBUIÇÃO!
a; b

a+b #não armazena na memória
a*b

ab<-a+b #objeto criado e armazenado
ab
(axb<-a*b) ##
axb

exemplo<-1
Exemplo<-2
EXEMPLO<-3
exemplo<-4 #sobreposição

ls() # observar workspace
rm(exemplo) # remoção de objeto
ls() # observar workspace
rm(list=ls()) #remover todos os objetos

#### Indentação ####
abc<- (5+3       ### "+" demanda um complemento no código
       +4+5)

def<-(3*11+(4-2+
              22-11)-
        1+100-21-10+1)
def

### Gerar sequencias: 
x<-seq(1, 5, 0.5) #começa em 1 e vai até 5, variando em 0.5
x
y<-seq(length=9, from=1, to=5) 

y
z<-c(1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5) #concatenar
z

y <- c("A","B","C") 
y

rep(1, 30)
rep(1:3, each =10)
rep(1:3, times =10)

##### Estrutura de Dados #####

x <- 10:15
x
y<- c("W","Y","K")
y
g<-c(TRUE,TRUE,FALSE)
g
## Atributos.
class(x) ;class(y); class(g)

mode(x); mode(y) # The (Storage) Mode of an Object
# types "integer" and "double" are returned as "numeric".
# types "special" and "builtin" are returned as "function".
# type "symbol" is called mode "name".

typeof(x)
length(x)
str(x)
attributes(x) 

is.vector(x)
is.numeric(x)
is.integer(x)
is.factor(x) # O que é um fator?

x[3:5]
x[-2]
x[c(2,4)]
x[c(2,4)]<-30
x

## Vetor nomeado.

x <- c(Flamengo=7.8, Atletico=4, Santos=8.5, Cruzeiro=10, Democrata=7.1)
x

## Atributos.
class(x)
mode(x) 
typeof(x) #double (tem casa decimais)
length(x)
str(x)
attributes(x)

is.vector(x)
is.numeric(x)
is.integer(x)
is.double(x)

x[3:5]
x[-4]
x[c(2,4)]
x[-2]
x["Atletico"]
x[c("Atletico","Cruzeiro")]

##Matriz
## Um arranjo de duas dimensões.
X <- matrix(1:9, nrow=3, ncol=3)
X
class(X)
mode(X)
typeof(X) # tipo de armazenamento é inteiro (integer)
dim(X) ## ncol(X) e nrow(X).
str(X)
attributes(X)

is.matrix(X)
is.array(X)
is.numeric(X)
is.integer(X)

## Como indexar
X[1,]
X[1:2,]
X[-2,]
X[,-2]
X[,c(3,2,1)]
X[3:1,c(3,2,1)]

###########
## Um arranjo de 3 dimensões (cúbico).
X <- array(1:24, dim=c(3,4,2))
X
# uma matriz 3 por 4 na frente e outra atraz
class(X)
mode(X)
typeof(X)
dim(X) ## ncol(X) e nrow(X).
str(X)
attributes(X)

is.matrix(X)
is.array(X)
is.numeric(X)
is.integer(X)

##Como indexar
X
X[1,,] # fixa a primeira linha das duas paginas
X[,1,] # fixa a primeira coluna das duas paginas
X[,,1] # fixa a primeira pagina

###### 
## Exercícios
##
# 1) Crie 3 objetos com as respectivas sequências: 
# a) 1,2,3,4,5,6,7,8,9,10 
# b) A,B,C,D,E,F 
# c) 10,20,30,40,50
# 
# 1.1) Qual o tipo da cada objeto? 
# 1.2) Transforme o vetor b em um fator 
# 1.3) Acesse o quarto elemento do conjunto b.
# 1.4) Usando a função length, obtenha o tamanho de cada um dos vetores
# 1.5) Crie um objeto D com os vetores a b e c.
#
# 2) Crie um vetor de tamanho 100, sendo uma sequência de 1 a 10 repetida 10 vezes. 
# Dica use a função rep().

rm(list=ls())
ls()

#### Data Frame ####

brasileiro <- data.frame(id=1:4,
                 times=c("Atlético", "Cruzeiro", "São Paulo","Internacional"),
                 pontos=c(45,80,52,50), 
                 sg=c(6,26,12,9))

class(brasileiro)
mode(brasileiro) 
typeof(brasileiro) # tipo de conteudo
dim(brasileiro) ## ncol() e nrow().
str(brasileiro)
attributes(brasileiro)

is.data.frame(brasileiro)
is.list(brasileiro)

##como indexar
brasileiro[1,]
brasileiro[,2]
brasileiro[,"pontos"]
brasileiro[,c("pontos", "sg")]
brasileiro[1:3,c("pontos", "sg")]
brasileiro$pontos

#### Lista ####

X <- array(1:24, dim=c(3,4,2))
X
##
x<-1:20
x

L <- list(item1=x,
          item2=X,
          item3=brasileiro)

class(L)
mode(L)
typeof(L)
length(L) #mostra o numero de itens (cada item tem um objeto diferente)
str(L)
attributes(L)

is.data.frame(L)
is.list(L)

##como indexar
L$item1
L[[1]]
L$item3
L[["item3"]]
L[["item3"]][,3]
L[["item3"]][1,3]
max(L[["item3"]][,3])
L$item3[,"pontos"]

L[-2] # exlcuir o segundo item da lista

#######################

#### Funções ####

## Mostra informações da sessão, versões e pacotes.
sessionInfo()

## Mais informações.
cbind(Sys.info())

# Criando Funções

media = function(x=0,y=0){
  result= (x + y)/2
  return(result)
}
media(9,-10)
media()

negativo_ou_positivo = function(x){
  if(x == 0){
    print("nulo")
  } else if (x < 0){
    print("negativo")
  } else {
    print("positivo")
  }
}

negativo_ou_positivo(3)
negativo_ou_positivo(-3)
negativo_ou_positivo(0)

negativo_ou_positivo(media(20,-30))

gerar_numero = function(valor = "nulo"){
  if(valor == "nulo"){
    return(0)
  } else if (valor == "positivo"){
    return(runif(n = 1,min = 1,max = 10))
  } else if (valor == "negativo"){
    return(-runif(n = 1,min = 1,max = 10))
  }
}
gerar_numero("positivo")
gerar_numero("negativo")

sequencia = function(menor_numero, maior_numero, crescente = T){
  if(crescente == TRUE){
    while(menor_numero<=maior_numero){
      print(menor_numero)
      menor_numero = menor_numero + 1
    }
  }
  if(crescente == FALSE){
    while(menor_numero<=maior_numero){
      print(maior_numero)
      maior_numero = maior_numero - 1
    } 
  }
}
sequencia(1,10,crescente = F)
sequencia(1,10,F)

# Obs.: Falar sobre pacotes

###################################

#### Carregando Banco de Dados ####

##Exemplo de milho pipoca 
## Mostra o diretório de trabalho.
getwd()
setwd("C:\\Users\\Desktop\\...")
getwd()

## Mostra os arquivos dentro no diretório.
list.files()

####Importar arquivo de dados
pipoca<-read.table("pipoca.txt", header=TRUE, dec=".")
str(pipoca)

####
pipoca<-read.table("pipoca.txt", header=TRUE, dec=",", na.string="-", sep="\t")
str(pipoca)

pipoca$CE
mean(pipoca$CE)
mean(pipoca$CE, na.rm=T)
sd(pipoca$CE, na.rm=T)

pipoca1<-na.omit(pipoca)

## Selecionando as pipocas com CE maior que 30.
sel <- pipoca$CE>200; sel
pipoca[sel,]

## Selecionando as pipocas com CE maior que 200
#com peso maior ou igual a 70.
sel <- pipoca$CE>200 & pipoca$peso>=70
sel
pipoca[sel,]

## O operador ! inverte um vetor lógico.
!sel # como se multiplicar por -1
pipoca[!sel,]

sel <- pipoca$CE<200 & pipoca$peso<=70; sel

all(pipoca$CE>100) #todos
any(pipoca$CE<10) # pelo menos 1
any(pipoca$CE>10)
sum(pipoca$CE>200)

which(pipoca$CE>100)

############################

#### Conversão de Dados ####

## o que é um fator?

apropos("^as\\.") # lista de funções q fazem conversões
# a função apropos lista as funções (mais para os pacotes que já foram carregados)

#################

#### Atenção ####

## Nunca converter fator em numerico diretamente
# Factor==>character
# character==>numeric
## Conversão.

##################

## Salva a imagem (objetos criados) para serem carregados no futuro ou
## compartilhados.
save.image("Embrapa.RData")

rm(list=ls());ls()

## Carrega sessão.
load("Embrapa.RData")
ls() #carrega os objetos que ficou na memoria

##################
###### HELP ######
##################

#RSiteSearch ("qtls")# procura no site

#auto-completar + help
help(rep)
?rep 
rep ##TAB + F1
??rep #lista pacote e função
#internet [R]
citation()

###### 
## Exercícios
## 3)	Importar banco de dados "phosphorus.txt"...
# a)	Qual a classe desse banco de dados?
# b)	Quais os nomes das variáveis presentes nesse arquivo?
# c)	Qual é o tipo de cada variável?
# d)	Qual o valor da linha 5 e coluna 3?
# e)	Transforme a coluna 2 em caracter.
# f)	Transforme em numérico novamente.
#

## 4)	Importar banco de dados "phosphorus.txt"...
#    a) Qual a média de cada genotipo para cada variavel resposta?
#    b) Subistituir os valores de zero na coluna 2 por 30.
##
