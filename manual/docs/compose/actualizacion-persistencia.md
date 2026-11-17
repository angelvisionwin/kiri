# Actualización de servicios y persistencia

## Actualizar solo la API

Al modificar `api/server.js`, hay que reconstruir la imagen y recrear el contenedor:

```powershell
docker compose up -d --build api
```

Compose reconstruye la imagen de la API y recrea el contenedor si es necesario. Los servicios PostgreSQL y Nginx no necesitan reconstruirse por ese cambio.

## Crear un dato de prueba en PostgreSQL

Entrar en la base de datos:

```powershell
docker compose exec postgres psql -U vwuser -d visionwin
```

Ejecutar SQL:

```sql
CREATE TABLE IF NOT EXISTS pruebas (
    id SERIAL PRIMARY KEY,
    mensaje VARCHAR(100)
);

INSERT INTO pruebas (mensaje)
VALUES ('Mi primer dato persistente');

SELECT * FROM pruebas;
```

Salir con `\q`.

## Comprobar persistencia tras recrear contenedores

```powershell
docker compose down
docker compose up -d
docker compose exec postgres psql -U vwuser -d visionwin -c "SELECT * FROM pruebas;"
```

El registro permanece porque PostgreSQL guarda sus datos en el volumen `postgres_data`, no en la capa escribible del contenedor.

## Importante sobre variables iniciales de PostgreSQL

Las variables `POSTGRES_DB`, `POSTGRES_USER` y `POSTGRES_PASSWORD` de la imagen oficial se utilizan al inicializar un directorio de datos vacío. Cambiar los valores en `.env` no modifica automáticamente usuarios, contraseñas ni bases de datos que ya existan en un volumen inicializado.

Para cambiar la contraseña de un usuario existente se debe realizar una operación SQL, por ejemplo `ALTER USER`, y coordinar el cambio con la configuración de la aplicación. No borres el volumen como método para cambiar credenciales.
