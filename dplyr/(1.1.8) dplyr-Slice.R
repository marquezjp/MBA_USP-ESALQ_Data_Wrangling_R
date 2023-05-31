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

#--------------------Slice------------------------------------------------------

# A função "filter" seleciona linhas com base em critérios lógicos
# A função "slice" pode ser utilizada para a seleção de linhas usando posições

nova_base %>% slice(5:9) # com base na posição das linhas
nova_base %>% slice(1:2, 5:9) # com base na posição das linhas com intervalo
nova_base %>% slice_head(n=3) # as três primeiras linhas
nova_base %>% slice_tail(n=3) # as três últimas linhas
nova_base %>% slice_min(order_by = distancia, prop = 0.40) # os prop % menores
nova_base %>% slice_max(order_by = distancia, prop = 0.10) # os prop % maiores