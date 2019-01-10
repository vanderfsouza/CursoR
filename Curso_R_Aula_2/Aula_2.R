########################################
##                                    ##
## INTRODUÇÃO AO PROGRAMA ESTATÍSCO R ##
##                                    ##  
########################################

# Limpar o ambiente
rm(list=ls())

#### Teste t de Student ####

dados1<-read.table(file.choose(),sep=",",header = F)
round(dados1,digits=3)
colnames(dados1)=c("prod1","prod2")

#### Teste t #####

# teste de normalidade#
library(fBasics)
shapiroTest(dados1$prod1) #teste de aderência (w próximo de 1). Se o p-valor for significativo rejeita-se a hipótese de normalidade.
qqnormPlot(dados1$prod1)
#

t=qt(0.975,(n-1))
media1=mean(dados1$prod1)
sd1=sd(dados1$prod1)
n=nrow(dados1)

# Intervalo de confiança 
(vcritico_inf=media1 + (t*sd1/sqrt(n)))
(vcritico_sup=media1 - (t*sd1/sqrt(n)))
#

# Teste t para uma média qualquer (mu)
t.test(dados1$prod1, mu = 16.08827)

######################################

#### Teste de 2 grupos independentes ####

# Verificando se as variancias sao homogeneas
var.test(dados1$prod1, dados1$prod2)
# 

s2a=var(dados1$prod1)
s2b=var(dados1$prod2)
sp=((n-1)*s2a+(n-1)*s2b)/(2*n-2) # Variância ponderada dos grupos  

media1=mean(dados1$prod1)
media2=mean(dados1$prod2)
dife=media1-media2 # diferença das médias dos grupos

tc = dife/sqrt(sp*(1/n+1/n)) # t calculado
tt = c(qt(0.975,2*n-2),-qt(0.975,2*n-2))
  
(IC=c(dife-qt(0.975,2*n-2)*sqrt(sp*(1/n + 1/n)),dife+qt(0.975,2*n-2)*sqrt(sp*(1/n + 1/n)))) # {-qt(0.975,2*n-2)*sqrt(sp*(1/n + 1/n)} = margem de erro conjunta
t.test(dados1$prod1,dados1$prod2,alternative="two.sided",var.equal=T)

#### Teste t pareado ####
t.test(dados1$prod1,dados1$prod2,paired=T)

#########################

#### Anova ####

####  DIC  ####

#  Verificar Diretorio
getwd()
#  Mudar o Diretorio
setwd("C:\\Users\\...")

# Importantar banco de dados
leite<- read.table("leite.txt", header=T, dec=",") #separador decimais 'dec' deve corresponder ao usado no arquivo
head(leite)
str(leite)
# Transformar em fator
leite$trat<-as.factor(leite$trat)
str(leite)

## Estatística Descritiva ##
library("pastecs")
stat.desc(leite)

## ANOVA
aov.leite<- aov(prod ~ trat, contrasts=list(trat="contr.sum"),data=leite) #análise de variância
A<- summary (aov.leite) #organiza o quadro da ANAVA
A
B<-anova(aov.leite)
B
##
tapply(leite$prod, leite$trat,mean)
mean(leite$prod) # Média geral ou intercept
##
names(aov.leite)
aov.leite$coefficients

#### verificar Pressupostos da análise de variância ####
names(aov.leite)
leite.residuals<- aov.leite$residuals #armazenando os erros ou resíduos
leite.residuals
par(mfrow=c(2,2)) # esse comando divide a janela gráfica numa matriz 2x2
plot(aov.leite)
par(mfrow=c(1,1))

#### teste de Normalidade dos Resíduos ####
#-----------------------------------------#
shapiro.test (leite.residuals) 
# H0 = Hipótese é de que os erros seguem distribuição normal.
# H1 = Hipótese alternativa é de que os erros não seguem distribuica normal.

#nesse caso, como o p-value = 0.88
# ou seja, >0.05 ou 0.01 ou qualquer alpha adotado, não se rejeita a hipotese de normalidade 
# Tudo OK nesse caso!

#install.packages("fBasics")
library(fBasics) #carregando pacote fBasics pois ele contém a função qqnormPlot().
qqnorm(leite.residuals) #verificando a normalidade
qqnormPlot(leite.residuals)

#install.packages("nortest")
require(nortest)#mesma função do library
lillie.test(leite.residuals) #outra opção para teste de normalidade

#### teste de homogeneidade de variâncias (homocedasticidade) ####
#----------------------------------------------------------------#
bartlett.test(prod~trat, data=leite)
bartlett.test(leite$prod, leite$trat) #não é muito recomentado para dados não normais.
# H0 = Hipótese é de que os erros são homogeneos.
# H1 = Hipótese alternativa é de que os erros não são homogeneos.
# Pelo resultado pvalue = 0.2324 não se rejeita H0.

#install.packages("car")
require(car)
leveneTest(leite$prod~leite$trat, center=mean) 
#outra opção menos suscetivel a falta de normalidade.

## Independência dos erros#
#-----------------------------------------#
library("car")#já foi chamado anteriormente
dwt(lm(aov.leite)) #
# H0 = Hipótese é de que os erros são independentes.
# H1 = Hipótese alternativa é de que os erros não são independentes.
# Pelo resultado pvalue = 0.258 não se rejeita H0.

#### Teste de comparações multiplas #####

Total<-tapply(leite$prod,leite$trat,mean) #total por tratamento
Total

###
aov.leite<- aov(prod ~ trat, data=leite, contrasts=list(trat="contr.sum")) #análise de variância
anova(aov.leite)

#--------------
# Teste Scheffe
#--------------
#install.packages("agricolae")
library(agricolae)
### 
teste.scheffe <- scheffe.test(aov.leite, "trat", main="") #faz o teste de médias (scheffé)
teste.scheffe
###
###
bar.group(teste.scheffe$groups, ylim=c(0,40), density=4, border="blue",
          las=1, main='Teste Scheffe',
          xlab='Tipos de Ração', ylab='Produção de leite (kg)') #plota o gráfico com as médias
abline(h=0, col='black')

########################
#-----------------------------
# Utilizando o pacote ExpDes
#-----------------------------
#install.packages("ExpDes")
library(ExpDes)
names(aov.leite)

(resumo<-summary(aov.leite))
(df=df.residual(aov.leite))
df<-20
(MSerror <- deviance(aov.leite)/df)
MSerror<-3.53
##
## Scott Knott
scottknott(leite$prod, leite$trat, df, MSerror, alpha = 0.05, group= T, main= NULL)

## Teste de Tukey
##
tukey(leite$prod,leite$trat, df, MSerror, alpha = 0.05, group= T, main= NULL)

####################

#### Exercícios ####
## 1) Importar banco de dados "phosphorus.txt"
## 2) Verifique a normalidade dos residuos
## 3) Fazer uma análise de variância
## 4) Fazer o teste de agrupamento de Scott knott

####################

#### SORTEIO DE EXPERIMENTOS ####

library(agricolae)
trt<-c("0","1","2","5","10","20","50","100","Dina")
rcbd <-design.rcbd(trt,6,serie=1,seed=1,"default") # seed = 1
rcbd # Planilha de campo

write.table(rcbd$book,"SORTEIO.txt", row.names=FALSE, sep="\t")
#file.show("SORTEIO.txt", quote=F)
write.csv(rcbd$book,"SORTEIO.csv",row.names=T)

###### 
## Exercícios
# 5) Fazer um sorteio em DBA (Delineamento de blocos aumentados) ?
# 6) Fazer um sorteio em lattice triple ?

##############################

#### DBC ####

dbc<-read.table("dbc.txt",h=T) # os nomes não podem conter espaço
names(dbc)
summary(dbc)
str(dbc)

dbc$estag<-as.factor(dbc$estag)
dbc$bloco<-as.factor(dbc$bloco)
str(dbc)

###outra opção
dbc<-transform(dbc, estag=factor(estag),bloco=factor(bloco))
str(dbc)

ex.dbc <- aov(resp ~ bloco + estag,data=dbc)
anova(ex.dbc)

par(mfrow=c(2,2))
plot(ex.dbc)
par(mfrow=c(1,1))

(residuos <- (ex.dbc$residuals))

## teste para normalidade dos erros
shapiro.test(residuos)

## teste para homogeneidade de variâncias
bartlett.test(dbc$resp , dbc$bloco , dbc$estag)

#análise de variância utilizando o ExpDes
library(ExpDes)
rbd(dbc$estag, dbc$bloco, dbc$resp, mcomp = "sk", sigT = 0.05, sigF = 0.05)

#### Regressão Linear ####

## http://r-br.2285057.n4.nabble.com/R-br-regressao-polinomial-grafico-e-valor-maximo-td4666321.html 

#Experimento inteiramente casualizado com 4 repetições para estudar os efeitos de 
#7 doses de gesso (tratamentos):
#0, 50, 100, 150, 200, 250 e 300 kg/ha sobre diversas características do feijoeiro
#Para a característica "peso de 1000 sementes", tem-se os resultados obtidos em gramas

peso = c(134.8, 139.7, 147.6, 132.3,
         161.7, 157.7, 150.3, 144.7,
         160.7, 172.7, 163.4, 161.3,
         169.8, 168.2, 160.7, 161.0,
         165.7, 160.0, 158.2, 151.0,
         171.8, 157.3, 150.4, 160.4,
         154.5, 160.4, 148.8, 154.0)
tratamento = factor(rep(seq(0,300,50), each=4)) 
dados = data.frame(peso, tratamento)
attach(dados)

niveis.tratamento = seq(0,300,50)
contrasts(dados$tratamento) = contr.poly(niveis.tratamento)
contrasts(dados$tratamento)

modelo.aov = aov(peso ~ tratamento, dados)
summary(modelo.aov)
summary(modelo.aov, split = list(tratamento = list(L = 1, Q = 2, C=3, Dev=c(4,5,6))))

plot(c(0,300), c(130,175), type="n", xlab="Doses de gesso (kg/ha)", ylab="Peso (g) de 1000 sementes")
d = rep(seq(0,300,50), each=4)
med_t = rep(tapply(peso,tratamento,mean),each=4)
points(d,med_t)
x = seq(0,300,0.1)
lines(x, (predict(lm(peso ~ I(d)+I(d^2)),data.frame(d=x))),lty=2, col="blue")

#
