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
## Iniciar o banco de dados:
```bash
rake db:migrate
```

## Para tornar-se Administrador:
```bash
rails console
user = User.where(email: 'example@example.com')
user.first.update_attribute(:admin, true)
```

## Você pode ver nossa aplicação rodando em:
```bash
https://exploracao-bairros.herokuapp.com
```