# Tasker

Esse aplicativo foi desenvolvido com Flutter como teste técnico da empresa Ezoom, na qual o Tasker foi criado para atender esse teste, e o nome surgiu por esse acaso.

## Funcionalidades

- Registro;
- Login;
- Visualizar Tarefas;
- Adicionar Tarefas;
- Editar Tarefas;
- Excluir Tarefas;
- Detalhes das Tarefas;
- Visualização das tarefas separados por: Dia atual, Dia posterior e todas tarefas.

## Tecnologias Utilizadas

- Laravel para o backend.
- MySQL para o banco de dados.
- Flutter para o aplicativo móvel.

## Como Configurar e Rodar o Projeto

### Requisitos

- PHP ^7.3|^8.0
- Composer
- Flutter SDK (para Flutter)

### Configuração do Ambiente

#### Backend (Laravel)

1. Clone o repositório e entre na pasta do projeto:
   ```bash
   git clone URL_DO_REPOSITORIO
   cd pasta_do_projeto

2. Instale as dependências do PHP com Composer:
   composer install

3. Copie .env.example para .env e configure as variáveis de ambiente (banco de dados, etc.):
    cp .env.example .env

4. Gere uma chave para a aplicação:
    php artisan key:generate

5. Rode as migrações para criar as tabelas no banco de dados:
    php artisan migrate

6. Inicie o servidor de desenvolvimento:
    php artisan serve

## Frontend (Flutter)

- Realizar clone do projeto;
- Abrir repositório no computador;
- Executar 'flutter clean' e depois 'flutter pub get';
- Fazer o build do aplicativo.

## API Endpoints

### Autenticação

Base URL:  https://lychee-cookie-15918-17f2b39d104a.herokuapp.com/

| Método | Endpoint        | Descrição                               | Parâmetros/Corpo                                      | Resposta Esperada                             |
|--------|-----------------|-----------------------------------------|-------------------------------------------------------|-----------------------------------------------|
| POST   | `/api/register` | Registra um novo usuário.               | `name`, `email`, `password`, `password_confirmation` | 201: Usuário criado, 422: Erro de validação   |
| POST   | `/api/login`    | Autentica um usuário e retorna um token.| `email`, `password`                                   | 200: Token, 401: Não autorizado               |

### Gerenciamento de Tarefas

| Método | Endpoint          | Descrição                          | Parâmetros/Corpo                                       | Resposta Esperada                        |
|--------|-------------------|------------------------------------|--------------------------------------------------------|------------------------------------------|
| GET    | `/api/tasks`      | Lista todas as tarefas do usuário. | N/A                                                      | 200: Lista de tarefas                     |
| POST   | `/api/tasks`      | Cria uma nova tarefa.              | `title`, `description`, `due_date`, `status`           | 201: Tarefa criada, 422: Erro de validação|
| GET    | `/api/tasks/{id}` | Obtém detalhes de uma tarefa.      | N/A                                                      | 200: Detalhes da tarefa, 404: Não encontrado |
| PUT    | `/api/tasks/{id}` | Atualiza uma tarefa existente.     | `title`, `description`, `due_date`, `status`           | 200: Tarefa atualizada, 422: Validação, 404: Não encontrado |
| DELETE | `/api/tasks/{id}` | Deleta uma tarefa.                 | N/A                                                      | 200: Tarefa deletada, 404: Não encontrado    |


## Agradecimentos

Gostaria de agradecer a oportunidade de estar realizando esse teste técnico, é um teste bem legal de ser feito e que pode colocar várias técnicas e comnecimentos em prática.