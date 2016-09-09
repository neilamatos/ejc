## Aplicação Base para criação de Sistemas baseados em Rails 5 + Bootstrap.

Versão 2.0


## Dependências

* Ruby 2.3.1
* PostgreSQL >= 9.3
* Rails v5.0.0.1
* Devise v4.2.0
* CanCanCan v1.15.0
* Bootstrap 3 com bootstrap-sass v3.3.6
* Font-Awesome com font-awesome-sass v4.6.2
* SB Admin v2.0 (Tema Bootstrap)

## Funcionalidades

* Sistema de login completo usando Devise com link "Esqueci minha senha" e Botão de logout
* Sistema de Papeis e Permissões para permitir a criação de papéis com permissões específicas
* CRUD de Usuários no Backend
* CRUD de Papéis no Backend
* Tela de início com possibilidade de ser extendida para Dashboard

## Como instalar

1. Clone o repositório

  ```
  git clone git@gitlab.ifce.edu.br:dgti/app_template_rails5
  ```
2. Exporte o repositório para o destino desejado do seu novo projeto (Obs: Não esqueça do / no final do path)

  ```
  git checkout-index -a -f --prefix=/destination/path/
  ```
3. Instalar rvm seguindo este tutorial:

  ```
  https://rvm.io/rvm/install
  ```
4. Instalar ruby 2.3.1

  ```
  rvm install 2.3.1
  ```
5. Instalar as dependências

  ```
  bundle install
  ```
6. Alterar aquivo config/database.yml para refletir os usuários e senhas do seu projeto
7. Criar usuário do PostgreSQL

  ```
  Usuário: <usuario_do_bd>
  Senha: <senha_do_bd>
  ```
8. Criar banco de dados

  ```
  rake db:create
  ```
9. Rodar as migrations

  ```
  rake db:migrate
  ```
10. Criar permissões

  ```
  rake permissions:create
  ```
11. Criar usuário padrão do sistema e popular banco de dados

  ```
  rake db:seed
  Usuário: admin@r5template.com
  Senha: abcd1234
  ```
