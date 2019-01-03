################################################################################
### http://r-br.2285057.n4.nabble.com/R-br-regressao-polinomial-grafico-e-valor-maximo-td4666321.html 
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

