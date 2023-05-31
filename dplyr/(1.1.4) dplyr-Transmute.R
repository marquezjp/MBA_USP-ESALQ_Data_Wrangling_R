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

#--------------------Transmute--------------------------------------------------

# Função "transmute": inclui variáveis no dataset, excluindo as existentes
# Depois de informar o dataset, informe as variáveis mantidas e adicionadas

base_exclui_1 <- transmute(nova_base,
                           observacoes, tempo,
                           variavel_nova_1, variavel_nova_2)

# Podemos praticar um pouco mais com o pipe

base_exclui_rename <- nova_base %>% 
  transmute(observacoes, tempo, variavel_nova_1) %>% 
  mutate(tempo_novo = recode(tempo,
                             `10` = "dez",
                             `15` = "quinze",
                             `20` = "vinte",
                             `25` = "vinte e cinco",
                             `30` = "trinta",
                             `35` = "trinta e cinco",
                             `40` = "quarenta",
                             `50` = "cinquenta",
                             `55` = "cinquenta e cinco")) %>% 
  mutate(posicao = cut(tempo, 
                       breaks = c(0, median(tempo), Inf),
                       labels = c("menores", "maiores")))

# Para referência do cálculo, a mediana da amostra

median(nova_base$tempo)

# Utilizamos a função "cut", que converte uma variável de valores em intervalos
# No exemplo acima, pedimos 2 intervalos tendo a mediana como referência
# Em seguida, já adicionamos novos nomes aos intervalos (labels)
# Note que a variável resultante é uma "factor"

# Ao aplicar a função "summary" à variável factor, o resultado é uma contagem
# summary: gera estatísticas descritivas para variáveis

summary(base_exclui_rename$posicao)
