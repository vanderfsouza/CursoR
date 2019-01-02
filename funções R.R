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
