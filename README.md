# Para rodar a aplicação localmente:
## Instalar as dependências:
```bash
rvm install 2.3.1
gem install bundler
bundle install
```
## Setar variável de ambiente domain:
```bash
echo domain: "example.com">config/application.yml
```
## Iniciar o banco de dados
```bash
rake db:migrate
```

Você pode ver nossa aplicação rodando em:


https://exploracao-bairros.herokuapp.com
