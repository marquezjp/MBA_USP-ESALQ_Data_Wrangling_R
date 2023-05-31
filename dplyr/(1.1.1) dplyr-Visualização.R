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

#--------------------Visualização-----------------------------------------------

# Algumas formas para visualizar informações do dataset

View(dataset_inicial) # Mostra a base de dados completa em uma nova aba
head(dataset_inicial, n=5) # Mostra as 5 primeiras observações da base de dados
str(dataset_inicial) # Mostra a estrutura da base de dados
glimpse(dataset_inicial) # Função parecida com a str
print(dataset_inicial) # Apresenta a base de dados no console
dim(dataset_inicial) # As dimensões do dataset: linhas e colunas, respectivamente
names(dataset_inicial) # Para ver os nomes das variáveis

# Poderíamos fazer o print de apenas uma variável
# O símbolo "$" é utilizado para especificar uma variável do dataset

dataset_inicial$`Tempo para chegar à escola (minutos)`

# Relembrando algumas definições sobre as variáveis:

# Variáveis <Chr> são caracteres ("characters"), isto é, contêm textos
# Variáveis <dbl> são "doubles", isto é, contêm números
# Variáveis <int> são integers, isto é, contêm números inteiros