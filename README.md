# Auth App

Una aplicación Rails 8 con registro, inicio de sesión, sesión persistente y restablecimiento de contraseña.

## Requisitos

* Ruby compatible con Rails 8
* PostgreSQL
* Bundler

## Configuración

1. Instala las dependencias:

```powershell
bundle install
```

2. Crea las bases de datos y ejecuta las migraciones:

```powershell
bundle exec rails db:create db:migrate
```

3. Inicia el servidor:

```powershell
bundle exec rails server
```

4. Abre `http://localhost:3000` en tu navegador.

## Funcionalidad incluida

* Registro con validaciones
* Inicio de sesión y cierre de sesión
* Restablecimiento de contraseña con token firmado
* Interfaz moderna con Tailwind CSS

## Notas

* El proyecto usa PostgreSQL por defecto. Ajusta `config/database.yml` si necesitas otro usuario, contraseña o puerto.
* Si aún no tienes Ruby en Windows, instala Ruby y agrega `ruby` y `bundle` a tu PATH.
* Última actualización para forzar deploy en Render.

