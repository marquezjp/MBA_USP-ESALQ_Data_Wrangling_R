## Data Wrangling R - Prof. Wilson Tarantin Junior
## MBA DSA USP ESALQ

# Atividade de Análise nº 1 - Introdução ao pacote dplyr
# https://dplyr.tidyverse.org/

# O pacote dplyr está contido no tidyverse
# dplyr: contém muitas funções comuns na manipulação de dados

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

#--------------------Filter-----------------------------------------------------

# A função "filter" tem o objetivo de gerar subconjuntos do dataset
# São especificados os critérios e as linhas que os atenderem serão filtradas

# Os principais operadores lógicos são:

# ==: igual
# !=: diferente
# > e <: maior e menor (podem conter o igual >= e <=)
# &: indica "E"
# |: indica "OU"

# Inicialmente, sem utilizar a função, poderia ser feito:

filtro_1 <- nova_base[nova_base$tempo > 20,] # critérios antes da vírgula
filtro_2 <- nova_base[nova_base$tempo > 20 & nova_base$distancia < 25,]
filtro_3 <- nova_base[nova_base$tempo <=15 | nova_base$periodo == "Tarde",]

# Função "filter": filtra a base de dados de acordo com os critérios escolhidos

base_filtro_1 <- filter(nova_base, tempo > 20)
base_filtro_2 <- filter(nova_base, tempo > 20 & distancia < 25)
base_filtro_3 <- filter(nova_base, periodo == "Manhã")
base_filtro_4 <- filter(nova_base, periodo != "Manhã" & between(tempo, 20, 50))
base_filtro_5 <- filter(nova_base, tempo <= 15 | periodo == "Tarde")
base_filtro_6 <- filter(nova_base, tempo > mean(tempo))

# A função filter também pode ser aplicada em datasets com grupos (group by)
# Neste caso, a função é aplicada dentro de cada grupo

base_filtro_7 <- nova_base %>% 
  group_by(periodo) %>% 
  filter(tempo > mean(tempo)) %>% 
  ungroup()

# Analisando as bases 6 e 7:

# base_filtro_6: observações tempo > 30 (média geral) foram filtradas
# base_filtro_7: observações com tempo p/ manhã > 22.1 foram filtradas
# base_filtro_7: observações com tempo p/ tarde > 48.3 foram filtradas

nova_base %>% 
  group_by(periodo) %>% 
  summarise(mean(tempo))

# A seguir, vamos realizar algumas operações sequencialmente
# O objetivo é obter estatísticas condicionais para grupos separados
# Note que estamos adicionando o argumento na.rm = T nas funções
# Embora não seja o caso aqui, é necessário quando há valores faltantes

descritivas_condic <- nova_base %>% 
  filter(tempo > 20) %>% 
  group_by(perfil) %>% 
  summarise(observações = sum(!is.na(distancia)),
            média = mean(distancia, na.rm = T),
            mediana = median(distancia, na.rm = T),
            desv_pad = sd(distancia, na.rm = T),
            mínimo = min(distancia, na.rm = T),
            máximo = max(distancia, na.rm = T),
            quartil_1 = quantile(distancia, probs = 0.25, na.rm = T),
            quartil_3 = quantile(distancia, probs = 0.75, na.rm = T)) %>% 
  arrange(média)

# Outro operador útil para realizar comparações e filtros é: %in%
# É utilizado para verificar se os elementos de um objeto constam em outro

selecao_pessoas <- c("Gabriela", "Gustavo", "Letícia", "Antônio", "Ana")

nova_base %>% 
  filter(observacoes %in% selecao_pessoas)

# Podemos calcular estatísticas na sequência

nova_base %>% 
  filter(observacoes %in% selecao_pessoas) %>% 
  summarise(tempo_medio_pessoas = mean(tempo))

# Também é possível encontrar o complemento do %in%
# Utilizando o ponto de exclamação

nova_base %>% 
  filter(!(observacoes %in% selecao_pessoas))

nova_base %>% 
  filter(!(observacoes %in% selecao_pessoas)) %>% 
  summarise(tempo_medio_pessoas = mean(tempo))
