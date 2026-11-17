Cursillo de docker que hice al instalar Kiri

Antes de levantar KiriCompose hay que crear el fichero de variables de entorno
(no se versiona porque contiene la contraseña de PostgreSQL):

    Copy-Item KiriCompose\.env.example KiriCompose\.env