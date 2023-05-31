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
dataset_inicial <- read_excel(file.path(caminho, "data", "(1.2) Dataset Aula Data Wrangling.xls"))

#--------------------Rename-----------------------------------------------------

# Função "rename": utilizada para alterar o nome das variáveis

# No dataset de exemplo, os nomes das variáveis contêm:
# Espaços, maiúsculas, acentos e caracteres especiais...
# É melhor não utilizá-los, podem gerar conflito e dificultam a escrita

# Inicialmente, sem utilizar a função, poderíamos fazer da seguinte forma:
# 1º:Combinamos os novos nomes desejados em um vetor

novos_nomes <- c("Observações",
                 "Tempo para chegar",
                 "Distância percorrida",
                 "Semáforos",
                 "Período",
                 "Perfil")

print(novos_nomes)

# 2º: Em seguida, atribuimos o vetor com nomes ao dataset

names(dataset_inicial) <- novos_nomes

head(dataset_inicial, n=5)

# A função "rename" torna este trabalho mais prático
# A seguir, o argumento da função é: novo nome = nome antigo

nova_base <- rename(dataset_inicial, 
                    observacoes = "Observações",
                    tempo = "Tempo para chegar",
                    distancia = "Distância percorrida",
                    semaforos = "Semáforos",
                    periodo = "Período",
                    perfil = "Perfil")

head(nova_base, n=5)

# Existe uma forma um pouco diferente de escrever as funções no R
# Trata-se do uso do operador pipe - %>% - atalho: Ctrl+Shift+M
# Com ele, tiramos o primeiro argumento do código
# É muito útil para realizar diversas funções em sequência

nova_base %>% rename(obs = observacoes,
                     temp = tempo,
                     dist = distancia,
                     sem = semaforos,
                     per = periodo,
                     perf = perfil) 

# No código acima, não criamos um novo objeto, mas poderíamos criar

nova_base_pipe <- nova_base %>% 
  rename(obs = observacoes,
         temp = tempo,
         dist = distancia,
         sem = semaforos,
         per = periodo,
         perf = perfil)

# Note que um novo objeto foi criado no ambiente do R

head(nova_base_pipe, n=5)

rm(nova_base_pipe) # Remove o objeto especificado do ambiente

# Também é possível utilizar a função "rename" com base na posição da variável
# Em datasets com muitas variáveis, esta função facilita a escrita do código

nova_base %>% rename(obs = 1,
                     temp = 2,
                     dist = 3,
                     sem = 4,
                     per = 5,
                     perf = 6)

# É possível alterar apenas uma ou outra variável

nova_base %>% rename(sem = 4,
                     perf = 6)v