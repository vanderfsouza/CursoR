require(MASS)
require(ExpDes)

setwd("C:\\Users\\...")

dados=read.table("var1.txt", h=T)
dados$Ambiente=as.factor(dados$Ambiente)
dados$Tratamento=as.factor(dados$Tratamento)
dados$Placa=as.factor(dados$Placa)
dados$Tecido=as.factor(dados$Tecido)
str(dados)

oz1 = lm(VAR1 ~ Placa + Ambiente * Tratamento * Tecido, dados)

plot(oz1)

boxplot(dados$VAR1) # é possível observar muitos outlier

##### Testando boxcox

boxcox(oz1, lambda = seq(0.1, 0.5, by = 0.01))

dados$VAR1Transf = (dados$VAR1^0.38)/0.38 # 0.38 = resultado do boxcox neste caso. # Opções para as transformações em: https://www.statisticshowto.datasciencecentral.com/box-cox-transformation/

boxplot(dados$VAR1Transf) # a distribuição não apresenta outlier

oz2 = lm(VAR1Transf ~ Placa + Ambiente * Tratamento * Tecido, dados)

plot(oz2)  # apesar do boxplot não apresentar outlier, a parcela 14 ainda é um possível problema

fat3.rbd(dados$Ambiente, dados$Tratamento, dados$Tecido, dados$Placa, dados$VAR1Transf, quali = c(TRUE, TRUE, TRUE), mcomp = "sk", fac.names = c("Ambiente", "Tratamento", "Tecido"), sigT = 0.05, sigF = 0.05)

##### Testando substituição da parcela 14

dados$VAR1Transf[14] = mean(dados$VAR1Transf) # vamos substituir o trat 14 pela média geral da variável 

fat3.rbd(dados$Ambiente, dados$Tratamento, dados$Tecido, dados$Placa, dados$VAR1Transf, quali = c(TRUE, TRUE, TRUE), mcomp = "sk", fac.names = c("Ambiente", "Tratamento", "Tecido"), sigT = 0.05, sigF = 0.05) # agora sim!
