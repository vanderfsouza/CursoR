############################################################
##                                                        ##
## INTRODUÇÃO AO PROGRAMA ESTATÍSCO R - 2017              ##
##                                                        ##  
## VANDER FILLIPE SOUZA - vanderfsouza@gmail.com          ##
## KAIO OLÍMPIO DAS GRAÇAS DIAS - Kaioolimpio@hotmail.com ##
##                                                        ##
############################################################

# Limpar o ambiente
rm(list=ls())

#################
#####       #####  
#####  DIC  #####
#####       #####
#################

#  Verificar Diretorio
getwd()
#  Mudar o Diretorio
setwd("C:\\Users\\Vander\\Desktop\\Curso R\\Curso_R_Aula_2")

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

####################################################
###verificar Pressupostos da análise de variância###
####################################################
names(aov.leite)
leite.residuals<- aov.leite$residuals #armazenando os erros ou resíduos
leite.residuals
par(mfrow=c(2,2)) # esse comando divide a janela gráfica numa matriz 2x2
plot(aov.leite)
par(mfrow=c(1,1))

## Link interessante
# https://onlinecourses.science.psu.edu/stat501/node/36  (Residuals vs Fitted)

## teste de Normalidade DOS ERROS##
#---------------------------------#
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

###
##teste de homogeneidade de variâncias (homocedasticidade)#
#---------------------------------------------------------#
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

########################################
####Teste de comparações multiplas######
########################################

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

###### 
## Exercícios
## 1)	Importar banco de dados "phosphorus.txt" (encontra-se na pasta Apostila R).
## 2) Verifique a normalidade dos residuos
## 3) Fazer uma análise de variância
## 4) Fazer o teste de agrupamento de Scott knott

############################
#SORTEIO DE EXPERIMENTOS####
############################

library(agricolae)
trt<-c("0","1","2","5","10","20","50","100","Dina")
rcbd <-design.rcbd(trt,6,serie=1,seed=1,"default") # seed = 1
rcbd # Planilha de campo

write.table(rcbd$book,"SORTEIO.txt", row.names=FALSE, sep="\t")
#file.show("SORTEIO.txt", quote=F)
write.csv(rcbd$book,"SORTEIO.csv",row.names=T)
#####


###### 
## Exercícios
# 5) Fazer um sorteio em DBA (Delineamento de blocos aumentados) ?
# 6) Fazer um sorteio em lattice triple ?

##############################

###############
###         ###
###   DBC   ###
###         ###
###############

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

# Nâo tem normalidades dos erros
# O que fazer? 

## 1) Modelo lineares generalizados
## 2) Eliminar outliers

######

## teste para homogeneidade de variâncias
bartlett.test(dbc$resp , dbc$bloco , dbc$estag)

#análise de variância utilizando o ExpDes
library(ExpDes)
rbd(dbc$estag, dbc$bloco, dbc$resp, mcomp = "sk", sigT = 0.05, sigF = 0.05)

