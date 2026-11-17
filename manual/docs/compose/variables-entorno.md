# Variables de entorno y `.env`

Las credenciales no deberían estar escritas directamente en `compose.yaml`.

## Archivo `.env`

En la raíz del proyecto, crear `.env`:

```dotenv
POSTGRES_DB=visionwin
POSTGRES_USER=vwuser
POSTGRES_PASSWORD=prueba123
```

Compose carga automáticamente este archivo para interpolar referencias `${VARIABLE}` del YAML.

## Referenciar variables desde Compose

En el servicio `api`:

```yaml
environment:
  DB_HOST: postgres
  DB_PORT: 5432
  DB_NAME: ${POSTGRES_DB}
  DB_USER: ${POSTGRES_USER}
  DB_PASSWORD: ${POSTGRES_PASSWORD}
```

En `postgres`:

```yaml
environment:
  POSTGRES_DB: ${POSTGRES_DB}
  POSTGRES_USER: ${POSTGRES_USER}
  POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
```

Validar la configuración:

```powershell
docker compose config
docker compose up -d
```

`docker compose config` muestra la configuración ya interpolada. Ten cuidado al compartir su salida: puede contener valores sensibles.

## `.env` y `env_file` no son lo mismo

- `.env`: se utiliza para interpolar variables dentro del archivo Compose.
- `environment`: declara qué variables recibe el contenedor.
- `env_file`: permite cargar variables desde un archivo directamente en el entorno del servicio.

## Buenas prácticas

- Añadir `.env` a `.gitignore`.
- Mantener un `.env.example` sin secretos reales.
- No considerar `.env` un almacén cifrado: los valores pueden ser visibles mediante inspección del contenedor.
- Para producción, valorar Docker Secrets o un gestor de secretos.
- Utilizar contraseñas distintas y robustas en cada entorno.
