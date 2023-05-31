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
         
#--------------------Mutate-----------------------------------------------------

# Função "mutate": apresenta duas utilidades principais
# 1. Inclui variáveis no dataset, mantendo as existentes
# 2. Transforma o conteúdo das variáveis

# Numa primeira situação, são adicionados duas variáveis a um dataset existente 
# As observações no dataset e nas variáveis devem estar igualmente ordenadas

variavel_nova_1 <- c(1,2,3,4,5,6,7,8,9,10)
variavel_nova_2 <- c(11:20)
print(variavel_nova_1)
print(variavel_nova_2)

base_inclui <- mutate(nova_base,
                      variavel_nova_1, 
                      variavel_nova_2)
View(base_inclui)

# Podemos utilizar o operador %>% para criar uma nova base (alterando nomes)
# E, no mesmo código, vamos inserir as duas "variáveis novas"
# Também criaremos a variável "temp_novo" como função de outra variável da base

nova_base %>% 
  rename(obs = observacoes,
         temp = tempo,
         dist = distancia,
         sem = semaforos,
         per = periodo,
         perf = perfil) %>%
  mutate(variavel_nova_1,
         variavel_nova_2,
         temp_novo = temp*2)

# ATENÇÃO: na etapa do mutate, a variável já se chama "temp"
# O nome original foi alterado na etapa do "rename"

# A função "mutate" também pode tranformar as variáveis existentes no dataset
# Vamos supor que gostaríamos de transformar a variável "semáforos" em texto
# Para isto, podemos utilizar a função "replace"
# Vamos substituir todos os valores da variável, mas poderiam ser só alguns

base_texto_1 <- mutate(nova_base, 
                       semaforos = replace(semaforos, semaforos==0, "Zero"),
                       semaforos = replace(semaforos, semaforos==1, "Um"),
                       semaforos = replace(semaforos, semaforos==2, "Dois"),
                       semaforos = replace(semaforos, semaforos==3, "Três"))

head(base_texto_1)

# Em conjunto com o mutate, também pode ser utilizada a função "recode"
# Vamos iniciar substituindo números por textos

base_texto_2 <- mutate(nova_base,
                       semaforos = recode(semaforos,
                                          `0` = "Zero",
                                          `1` = "Um", 
                                          `2` = "Dois",
                                          `3` = "Três"))

head(base_texto_2)

# A seguir, trocaremos um texto por outro texto e criaremos uma nova variável

base_texto_3 <- mutate(nova_base, 
                       perfil_novo = recode(perfil,
                                            "calmo" = "perfil 1",
                                            "moderado" = "perfil 2",
                                            "agressivo" = "perfil 3"))

head(base_texto_3)

# Poderíamos manter na variável original (ao invés de criar "perfil_novo")

# Vamos utizar o "recode" para transformar um texto em valores

base_texto_valores <- mutate(nova_base,
                             periodo = recode(periodo,
                                              "Manhã" = 0,
                                              "Tarde" = 1))

head(base_texto_valores)

# Um código semelhante poderia ser utilizado para gerar dummies (var. binárias)

base_dummy <- mutate(nova_base, perfil_agressivo = recode(perfil,
                                                          "agressivo"=1,
                                                          "moderado"=0,
                                                          "calmo"=0),
                     perfil_moderado = recode(perfil,
                                              "agressivo"=0,
                                              "moderado"=1,
                                              "calmo"=0),
                     perfil_calmo = recode(perfil,
                                           "agressivo"=0,
                                           "moderado"=0,
                                           "calmo"=1))

View(base_dummy)

# ATENÇÃO: há funções mais diretas para criar dummies, esta acima é para prática
# Criando variáveis binárias (dummies) por meio de função específica

install.packages("fastDummies")
library("fastDummies")

base_dummy_2 <- dummy_columns(.data = nova_base,
                              select_columns = c("periodo",
                                                 "perfil"),
                              remove_selected_columns = F,
                              remove_first_dummy = F)

# Algumas vezes, é necessário utilizar o mutate para critérios mais detalhados
# Para critérios mais complexos, a função case_when pode ser mais adequada

base_categorias <- mutate(nova_base,
                          categorias_tempo = case_when(tempo <= 20 ~ "Rápido",
                                                       tempo > 20 & tempo <= 40 ~ "Intermediário",
                                                       tempo > 40 ~ "Demorado"))

View(base_categorias)

# Por fim, também é possível deletar colunas com o mutate
# Para isto, vamos utilizar o operador NULL

base_categorias <- mutate(base_categorias,
                          tempo = NULL)
