# Git e Github

Sistema de Controle de Versão

## Configuração Inicial

``` Git
git config --global user.email 'meu email'

git config --global user.name 'meu nome'
```

## Iniciar um Repositório Git Local

``` Git
git init

git branch -M main
```

## Atualizar Repositório Git Local

``` Git
git add 'Exemplo.R'

git commit -m 'título'
```

## Atualizar Repositório Git Remoto

Definir o Repositório Remoto

``` Git
git push -u origin main
```

Atualizar o Repositório Remoto

``` Git
git push -u origin main
```

## Criar Ramificações

Criar uma Ramificação

``` Git
git checkout -b 'nova'
```

Atualizar uma Ramificação

``` Git
git push -u origin nova
```

## Importar Repositório Git Remoto para o Local

Importar um Repositório 

``` Git
git clone link do repositório

cd 'repositório'
```

Atualizar o Repositório Local com as informações do Repositório Remoto

``` Git
git pull
```

## Importar Outras Ramificações

Verificar as Ramificações existentes

``` Git
git branch -a
```

Importar a Ramificação escolhida

``` Git
git checkout 'nome da outra branch'

git pull
```
