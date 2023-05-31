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

#--------------------Select-----------------------------------------------------

# Função "select": tem a finalidade principal de extair variáveis selecionadas 
# Também pode ser utilizada para reposicionar as variáveis no dataset

# Relembrando, sem utilizar a função, poderia ser feito:

selecao_1 <- nova_base[,c("observacoes","tempo")] # critérios após a vírgula
selecao_2 <- nova_base[,1:3] # selecionando pela posição das colunas de 1 a 3
selecao_3 <- nova_base[,c(1:3, 5)] # pulando posições

# É possível selecionar parte do dataset (incluindo a seleção de linhas):
# Linhas antes da vírgula, colunas após a vírgula

extrai_parte_1 <- nova_base[3:7, c("observacoes", "perfil")]
extrai_parte_2 <- nova_base[3:7, 1:2]

# Função "select" utilizada para selecionar e manter variáveis no dataset
# Portanto, seleciona as variáveis que devem ficar no dataset

base_select_1 <- select(nova_base, observacoes, tempo) # especificando
base_select_2 <- select(nova_base, -perfil, -semaforos) # todas menos algumas
base_select_3 <- select(nova_base, observacoes:distancia) # de uma a outra
base_select_4 <- select(nova_base, starts_with("per")) # para algum início comum
base_select_5 <- select(nova_base, ends_with("o")) # para algum final comum

# Reposicionar variáveis do dataset com "select"

nova_base %>% select(observacoes, perfil, everything())

# O mesmo trabalho poderia ser feito com a função "relocate"

nova_base %>% relocate(perfil, .after = observacoes)
nova_base %>% relocate(perfil, .before = tempo)

# A seguir, com "select", informaremos a ordem (inclusive, excluindo variáveis)

nova_base %>% select(tempo, semaforos, perfil, observacoes)

# A função "pull" executa trabalho semelhante ao "select", porém gera um vetor

vetor_pull <- nova_base %>% 
  pull(var = 3)