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

# Dois datasets serão utilizados na apresentação central dos tópicos:
caminho <- file.path('.')
# "dataset_inicial" - Fonte: Fávero & Belfiore (2017, Cap. 12)
dataset_inicial <- read_excel(file.path(caminho, "data", "(1.2) Dataset Aula Data Wrangling.xls"))

dataset_inicial <- rename(dataset_inicial,
       "Observações" = 1,
       "Tempo para chegar" = 2,
       "Distância percorrida" = 3,
       "Semáforos" = 4,
       "Período" = 5,
       "Perfil" = 6)

# "dataset_merge" - utilizado em análises futuras, mas já podemos importá-lo
dataset_merge <- read_excel(file.path(caminho, "data", "(1.3) Dataset Aula Data Wrangling (Join).xls"))

#--------------------Join-------------------------------------------------------

# Funções "join": utilizadas para realizar a junção (merge) de datasets
# Para ser possível, é necessária pelo menos uma variável em comum nos datasets

# Left Join: traz as variáveis do dataset Y para o dataset X 
# Nas funções, X é o primeiro argumento a ser inserido na função

# Primeiramente, vamos igualar o nome da variável que será usada como "chave"

dataset_inicial <- dataset_inicial %>% rename(observacoes=Observações)
dataset_merge <- dataset_merge %>% rename(observacoes=Estudante)

# Em seguida, podemos realizar o merge

base_left_join <- left_join(dataset_inicial, dataset_merge,
                            by = "observacoes")

View(base_left_join)

# O argumento "by" indica a variável que será a "chave" para a combinação

# Da mesma forma, mas usando o pipe

dataset_inicial %>% left_join(dataset_merge, by = "observacoes")

# Podemos verificar que a variável que está em Y foi trazida para X
# Como uma observação de X não está presente em Y, o dataset final aponta "NA"
# NA = é um missing value
# Então, no dataset final, todas as observações de X estão presentes
# Por outro lado, observações de Y que não estejam em X são excluídas
# As observações que estão na "chave" de X são aquelas no dataset final

# Right Join: leva as variáveis de X para Y (X é o primeiro argumento)

base_right_join <- right_join(dataset_inicial, dataset_merge,
                              by = "observacoes")

View(base_right_join)

dataset_inicial %>% right_join(dataset_merge, by = "observacoes")

# Neste caso, o dataset final contém somente as observações de Y
# Isto é, uma observação de X que não está presente em Y foi excluída
# As observações que estão na "chave" de Y são aquelas no dataset final
# São gerados NA na a observação de Y que não está em X

# Inner Join: cria um novo dataset com as observações que estão em X e Y
# Para fazer parte do dataset final, deve estar em ambos os datasets iniciais
# Colocando de outra forma, é a interseção de X e Y

base_inner_join <- inner_join(dataset_inicial, dataset_merge,
                              by = "observacoes")

View(base_inner_join)

# Não há missing values, só as observações que estão em X e Y ficam após o merge

# Full Join: cria um novo dataset contendo todas as informações de X e Y
# Ou seja, pode estar em X e não estar em Y e vice-versa

base_full_join <- full_join(dataset_inicial, dataset_merge,
                            by = "observacoes")

View(base_full_join)

# As próximas duas funções, Semi Join e Anti Join, são formas de comparação
# Isto significa que elas não realizam o merge, apenas comparam datasets

# Semi Join: mantém em X as observações que coincidem com Y, sem realizar merge

base_semi_join <- semi_join(dataset_inicial, dataset_merge,
                            by = "observacoes")

View(base_semi_join)

# No dataset final, constam apenas as variáveis que já estavam em X
# Porém, as observações são somente aquelas que também estão em Y

# Anti Join: mantém em X suas observaçoes que não coincidem com Y
# Também não ocorre o merge

base_anti_join <- anti_join(dataset_inicial, dataset_merge,
                            by = "observacoes")

View(base_anti_join)