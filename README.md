# Para rodar a aplicação localmente:
## Instalar as dependências:
```bash
rvm install 2.3.1
gem install bundler
bundle install
```
## Setar variável de ambiente domain:
```bash
echo domain: "exploracao-bairros" > config/application.yml
echo cipher: "secret" >> config/application.yml
echo googleapikey: "AIzaSyAntuka0SlCnh1H3mRdlb1hrWFznQtf4PM" >> config/application.yml
```
## Iniciar o banco de dados:
```bash
rake db:migrate
```

## Para tornar-se Administrador:
```bash
rails console
user = User.where(email: 'your.email@example.com')
user.first.update_attribute(:admin, true)
```

## Para executar testes:
```bash
bundle exec rspec
```

## Você pode ver nossa aplicação rodando em:

https://exploracao-bairros.herokuapp.com
