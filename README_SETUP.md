# Proyecto DCCinema Setup

## Requisitos 
* ruby 3.1.2
* rails 7 (se deberia instalar solo con el bundler)
* PostgreSQL

## Instalación

Primero tienes que definir las variables de entorno DB_USER y DB_PASSWORD  en tu computador las cuales seran usadas para la base de datos de PostgreSQL

Luego ejecutar lo siguiente:

```
bundle install
```

```
rails db:create
```

```
rails db:migrate
```

```
rails db:seed
```
Con las seeds se crean las 8 salas de cine

## Correr la pagina

Para levantar el servidor correr el siguiente comando, se debería levantar en el puerto ```3000```

```
rails server
```

## Correr tests
Antes de ejecutar los tests correr
```
rails db:migrate RAILS_ENV=test
```

Para ejecutar los tests unitarios y de integracion utilizar

```
rails test
```

Lo anterior no incluye los tests de sistema 


## Heroku deploy
Recomiendo seguir la [guia de heroku](https://devcenter.heroku.com/articles/getting-started-with-rails7) para los deploys de rails v7

Recuerden que necesitan agregar el add on de postgres en heroku

El proyecto ya viene configurado para utilizar cloudinary para almacenar las imagenes en el ambiente de producción.
Para que esto funcione tienen que incluir el CLOUDINARY_URL en las variables de entorno de heroku. El CLOUDINARY_URL
lo pueden obtener creandose una cuenta gratuita en cloudinary. Para el ambiente de desarrollo las imagenes seran guardadas localmente.
