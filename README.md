# Testes API ServeRest

## ServeRest

O ServeRest oferece uma API REST simulada para propósitos de aprendizado e prática de desenvolvimento de aplicativos web. Com endpoints para recursos como usuários, produtos e pedidos, os desenvolvedores podem experimentar e aprimorar suas habilidades em integração de APIs, manipulação de dados JSON e elaboração de testes. Essa ferramenta é frequentemente utilizada por estudantes e profissionais em busca de um ambiente de desenvolvimento rápido e seguro, onde podem testar ideias e construir protótipos sem a necessidade de configurar um backend completo.

## Estrutura de Diretórios

```
.
├── postman_tests
│   ├── users_tests.postman_collection   # Coleção de testes do Postman para testar o endpoints de usuários.
├── resources
│   ├── routes
│   │   ├── cart.robot                  # Arquivo contendo keywords para interagir com a rota de carrinho.
│   │   ├── product.robot               # Arquivo contendo keywords para interagir com a rota produtos.
│   │   ├── user.robot                  # Arquivo contendo keywords para interagir com a rota usuários.
│   ├── common_resource.robot           # Arquivo contendo recursos comuns utilizados em vários testes.
├── tests
│   ├── purchase_flow.robot            # Arquivo de teste para validar o fluxo completo de compra.
├── README.md                          # Este arquivo, fornecendo informações sobre o projeto.
├── package-lock.json                  # Arquivo de bloqueio para dependências do Node.js.
├── package.json                       # Arquivo de configuração do projeto Node.js.
├── requirements.txt                   # Arquivo contendo as dependências do Python.
```

## Requisitos de Instalação

Para configurar e executar este projeto, você precisará dos seguintes requisitos:

- **Postman**: Ferramenta para testes de API.
- **Node.js** acima da versão 20
- **Npm**: Gerenciador de pacotes do Node.js
- **Python** acima da versão 3.8
- **Pip**: Gerenciador de pacotes do Python
- **Robot Framework**: Framework de testes. Certifique-se de que ele seja adicionado ao PATH do sistema
- **IDE** de sua preferência para desenvolvimento e execução de testes

## Comandos para Configurar o Projeto

Para configurar o ambiente de desenvolvimento e preparar o projeto para execução, execute os seguintes comandos:

1. `pip install -r requirements.txt`: Instala todas as dependências do Python listadas no arquivo `requirements.txt`.
2. `npm install`: Instala todas as dependências do Node.js listadas no arquivo `package.json`.
3. `python3 -m Browser.entry init`: Inicializa o ambiente de teste do Browser.
4. `npx playwright install-deps`: Instala as dependências necessárias para o Playwright.

## Para Executar o Projeto

Para executar os testes do projeto, utilize o seguinte comando:

```
robot -d results tests
```

Este comando executará todos os testes presentes na pasta `tests` e gerará os resultados na pasta `results`.
