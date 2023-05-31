## Data Wrangling R - Prof. Wilson Tarantin Junior
## MBA DSA USP ESALQ

# O pacote purrr oferece funções que realizam iterações mais facilmente
# https://purrr.tidyverse.org/

#--------------------Carregar os Pacotes----------------------------------------

library(tidyverse)
library(readxl)

#--------------------Importar os datasets---------------------------------------

# "dataset_inicial" - Fonte: Fávero & Belfiore (2017, Cap. 12)
caminho <- file.path('.')
nova_base <- read_excel(file.path(caminho, "data", "(1.2) Dataset Aula Data Wrangling.xls")) %>% 
  rename(observacoes = 1,
         tempo = 2,
         distancia = 3,
         semaforos = 4,
         periodo = 5,
         perfil = 6)

#--------------------Iterações com Purrr----------------------------------------

# O pacote purrr oferece funções que realizam iterações mais facilmente

# https://purrr.tidyverse.org/

# As iterações evitam a repetição de códigos
# São adequadas quando a intenção é realizar a mesma tarefa em vários inputs
# Por exemplo, evitam repetir o código que seria aplicado em diversas variáveis 

# No purrr, as funções map() realizam tais tarefas
# O map() parte de um vetor e aplica dada função para cada elemento dele
# Retorna um vetor de mesmo comprimento do vetor input. Vetores resultantes:

# map(): listas
# map_lgl(): lógicos
# map_int(): inteiros
# map_dbl(): doubles
# map_chr(): caracteres 

# A seguir, vamos criar o vetor que contém os inputs para a função map()
# Para a nova_base, vamos selecionar as variáveis numéricas:

vetor_input <- c("tempo", "distancia", "semaforos")

# O objetivo é criar um vetor (numérico) que contém estatísticas por variável

# A seguir, cada linha gera um tipo de estatística para cada variável do vetor
# A tarefa que realizamos em 3 linhas antes, é realizada em uma linha agora

map_dbl(nova_base[vetor_input], mean, na.rm = T)
map_dbl(nova_base[vetor_input], median, na.rm = T)
map_dbl(nova_base[vetor_input], sd, na.rm = T)
map(nova_base[vetor_input], quantile, probs = c(0.25, 0.50, 0.75), na.rm = T)

# ATENÇÃO: embora não seja necessário nesta base de dados, usamos na.rm = T
# O argumento solicita a remoção de NAs antes de fazer as contas (T é TRUE)
# É um argumento importante, pois evita erros quando há dados faltantes

# Nos caso os percentis, utilizamos apenas o map, pois é gerada uma lista
# A justificativa é que pedimos 3 informações no mesmo código
# Vamos analisar o objeto gerado em uma lista

lista_quartis <- map(nova_base[vetor_input], quantile, probs = c(0.25, 0.50, 0.75), na.rm = T)

lista_quartis[["tempo"]]
lista_quartis[["tempo"]][["25%"]]

# A seguir, vamos utilizar o map() e gerar descritivas completas das variáveis

map(nova_base[vetor_input], ~ summary(.))

# Portanto, o cógigo acima gerou mais informação em uma única linha
# O ~ indica que trata-se de uma função, ou seja, escreveremos uma função
# Os pontos substituem a indicação dos dados (usa nova_base[vetor_input])

# Acima, foram utilizadas funções já existentes (mean, median, sd, quantile)
# Porém, também poderiam conter funções (functions) criadas por nós
# A seguir, combinaremos o map() como a função do coeficiente de variação

coef_var <- function(x) {
  cv <- ((sd(x, na.rm=T))/(mean(x, na.rm=T)))*100
  return(cv)
}

# Após elaborar a nova função, basta utilizá-la no map()

map_dbl(nova_base[vetor_input], coef_var)

# Também poderíamos adicionar diretamente ao map() com os atalhos ~ e .

map_dbl(nova_base[vetor_input], ~ (sd(., na.rm=T) / mean(., na.rm=T))*100)

# A seguir, utilizamos o map pedindo os elementos da 5ª linha

map(nova_base, 5)

# Também podemos identificar os tipos de elementos contidos no vetor

map_chr(nova_base, typeof)

# E os elementos únicos deste objeto

map(nova_base, unique)

# Em resumo, podemos utilizar a função map() de forma bastante flexível
# A ideia é sempre replicar uma função aos elementos do vetor input

# O map() também pode ser aplicado quando há múltiplos inputs

# Por exemplo, vamos gerar variáveis com as seguintes médias e desvios padrão

médias_var <- list(5, 10, 15)
desv_pad_var <- list(1, 2, 3)

map2(médias_var, desv_pad_var, rnorm, n = 5)

# Os parâmetros interagiram em sequencia: 5 e 1, 10 e 2, 15 e 3
# No map2(), os inputs que variam estão antes da função e os dados fixos depois
# Para vários inputs, utiliza-se pmap()

# Vamos variar o tamanho "n" das variáveis

tamanho_var <- list(7, 9, 11)

parametros <- list(tamanho_var, médias_var, desv_pad_var) # sequência da fórmula

pmap(parametros, rnorm)

# Na prática, para evitar erros, é melhor nomear os argumentos

parametros2 <- list(mean = médias_var, sd = desv_pad_var, n = tamanho_var)

pmap(parametros2, rnorm)
