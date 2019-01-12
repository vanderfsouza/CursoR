require(ExpDes)

# teste
fator1 = c(rep(1,12),rep(2,12),rep(3,12),rep(4,12))
fator2 = c(rep(10,4),rep(20,4),rep(40,4),rep(10,4),rep(20,4),rep(40,4),rep(10,4),rep(20,4),rep(40,4),rep(10,4),rep(20,4),rep(40,4))
repet = c(rep(1:4,12))
contagem = c(73,63,47,53,67,73,71,89,93,95,91,81,97,89,97,93,
             89,89,93,101,91,99,93,101,91,95,91,93,93,95,87,101,
             93,93,89,93,91,83,93,93,91,93,97,91,85,95,87,81)
respAd = c(85,87,81,79)

fat2.ad.crd(fator1, fator2, repet, resp, respAd, quali = c(TRUE, TRUE), mcomp = "tukey",
            fac.names = c("Epoca", "Trat"), sigT = 0.05, sigF = 0.05)

#
setwd("C:\\Users\\...")

germinacao = read.table("var2.txt", h=T)
controle=germinacao[germinacao$trat=="controle",]
fatores=germinacao[germinacao$trat=="10"|germinacao$trat=="20"|germinacao$trat=="40",]

fat2.ad.crd(fatores$epoca, fatores$trat, fatores$Rep, fatores$Var2, controle$Var2,
            quali = c(TRUE, TRUE), mcomp = "tukey", fac.names = c("Epoca", "Trat"), sigT = 0.05, sigF = 0.05)
#

######################

##### Teste de Dunnett #####

library(multcomp)

germinacao = read.table("var2.txt", h=T)
controle=germinacao[germinacao$trat=="controle",]
controle$trat=0
controle$trat=as.factor(controle$trat)
fatores=germinacao[germinacao$trat=="10"|germinacao$trat=="20"|germinacao$trat=="40",]

epoca1=rbind(controle,fatores[fatores$epoca=="1",])
aov1 <- aov(Var2 ~ trat, epoca1)
set.seed(1)
summary(glht(aov1, linfct=mcp(trat="Dunnett")))

epoca2=rbind(controle,fatores[fatores$epoca=="2",])
aov2 <- aov(Var2 ~ trat, epoca2)
set.seed(1)
summary(glht(aov2, linfct=mcp(trat="Dunnett")))

epoca3=rbind(controle,fatores[fatores$epoca=="3",])
aov3 <- aov(Var2 ~ trat, epoca3)
set.seed(1)
summary(glht(aov3, linfct=mcp(trat="Dunnett")))

epoca4=rbind(controle,fatores[fatores$epoca=="4",])
aov4 <- aov(Var2 ~ trat, epoca4)
set.seed(1)
summary(glht(aov4, linfct=mcp(trat="Dunnett")))
