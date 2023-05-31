## Data Wrangling R - Prof. Wilson Tarantin Junior
## MBA DSA USP ESALQ

# Atividade de Análise nº 1 - Introdução ao pacote dplyr
# https://dplyr.tidyverse.org/

# O pacote dplyr está contido no tidyverse
# dplyr: contém muitas funções comuns na manipulação de dados

#--------------------Carregar os Pacotes----------------------------------------

library(tidyverse)

#--------------------Bind-------------------------------------------------------

# Existem formas simples de combinar datasets, adequados em casos particulares
# As funções "bind" combinam datasets sem a especificação de uma "chave"
# Isto significa que as observações ou variáveis devem estar na mesma ordem

# Vamos criar alguns datasets para exemplificar:

dataset_bind_1 <- tibble(var1 = c("obs1", "obs2", "obs3", "obs4"),
                         var2 = 1:4,
                         var3 = 10:13)

dataset_bind_2 <- tibble(var4 = c("obs1", "obs2", "obs3", "obs4"),
                         var5 = 100:103)

dataset_bind_3 <- tibble(var6 = c("obs50", "obs51", "obs52", "obs53"),
                         var7 = 1500:1503)

dataset_bind_4 <- tibble(var1 = c("obs5", "obs6", "obs7", "obs8", "obs9"),
                         var2 = 5:9,
                         var3 = 14:18)

# Combinar colunas (variáveis): deve haver o mesmo número de observações

dataset_bind_colunas <- bind_cols(dataset_bind_1, dataset_bind_2)

# No exemplo a seguir, o resultado da combinação fica incorreto

dataset_bind_1 %>% bind_cols(dataset_bind_3)

# Combinar linhas (observações): as variáveis devem estar na ordem

dataset_bind_linhas <- bind_rows(dataset_bind_1, dataset_bind_4)
