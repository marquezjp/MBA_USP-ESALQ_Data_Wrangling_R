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

#--------------------Summarise--------------------------------------------------

# Função "summarise": função que resume o dataset, podendo criar outros
# Abaixo, as observações da variável "tempo" são resumidas em descritivas

descritivas_nova_base <- summarise(nova_base,
                                   observações = n(),
                                   média = mean(tempo),
                                   mediana = median(tempo),
                                   desv_pad = sd(tempo),
                                   mínimo = min(tempo),
                                   máximo = max(tempo),
                                   quartil_3 = quantile(tempo, probs = 0.75))

print(descritivas_nova_base)

# Então, acima, criamos um data frame com uma linha de descritivas da variável

# Poderia ser utilizada para criar informações mais específicas sobre o dataset
# Para isto, o "summarise" é utilizado em conjunto com a função "group by"
# A seguir, vamos agrupar as informações do dataset pelo critério de "período"

base_grupo <- group_by(nova_base, periodo)

# Aparentemente, nada mudou na "base_grupo" em relação à "nova_base"

View(base_grupo)
View(nova_base)

glimpse(base_grupo)

# Porém, o "group by" fica registrado no objeto

descritivas_base_grupo <- base_grupo %>% 
  summarise(média = mean(tempo),
            desvio_pad = sd(tempo),
            n_obs = n())

# O resultado do "summarise" acima é para cada grupo especificado no objeto
# Também criamos um data frame com duas linhas, uma para cada grupo
# Caso queira retirar o agrupamento criado, basta aplicar o "ungroup"

base_sem_grupo <- base_grupo %>% ungroup()

glimpse(base_sem_grupo)

summarise(base_sem_grupo,
          mean(tempo)) # informações para a base completa

# Também poderia agrupar por mais de um critério e gerar o dataset

descritivas_novos_grupos <- nova_base %>% 
  group_by(periodo, perfil) %>% 
  summarise(tempo_médio = mean(tempo),
            mínimo = min(tempo),
            máximo = max(tempo),
            contagem = n()) %>% 
  arrange(desc(máximo))

View(descritivas_novos_grupos)

# A função "arrange" apenas fez a organização de apresentação do dataset
# Foi pedido que fosse organizado de forma decrescente (desc)
# Se retirar o desc(), fica na ordem crescente

# No contexto de resumo do dataset, a função "table" é útil para as contagens
# Portanto, é utilizada para criar tabelas de frequências:

table(nova_base$periodo)
table(nova_base$perfil)
table(nova_base$periodo,
      nova_base$perfil)

# Caso necessário, seria possível armazenar a tabela em um objeto:

dados_freq_1 <- as.data.frame(table(nova_base$periodo,
                                    nova_base$perfil))

# Um trabalho semelhante poderia ser feito por meio da função count()
# A função count() será muito útil para usar em conjunto com o "pipe"

nova_base %>% 
  count(periodo)

nova_base %>% 
  count(perfil)

dados_freq_2 <- nova_base %>% 
  count(periodo, perfil, name = "contagem")