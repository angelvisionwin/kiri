# Healthchecks y disponibilidad

## `running` no significa `healthy`

Un contenedor puede estar ejecutando su proceso principal y, sin embargo, la aplicación todavía no estar preparada para atender peticiones.

Estados habituales:

- `created`: creado, pero no iniciado.
- `running`: el proceso principal está ejecutándose.
- `healthy`: ha superado el healthcheck.
- `unhealthy`: ha fallado repetidamente el healthcheck.

## Healthcheck de PostgreSQL

En el servicio `postgres`:

```yaml
healthcheck:
  test: ["CMD-SHELL", "pg_isready -U vwuser -d visionwin"]
  interval: 5s
  timeout: 5s
  retries: 10
  start_period: 20s
```

- `test`: comando de comprobación.
- `interval`: intervalo entre comprobaciones.
- `timeout`: tiempo máximo de cada prueba.
- `retries`: fallos consecutivos permitidos antes de marcar `unhealthy`.
- `start_period`: periodo inicial de gracia.

## Dependencia de la API

```yaml
depends_on:
  postgres:
    condition: service_healthy
```

Con esta condición, Compose espera a que PostgreSQL supere su healthcheck antes de iniciar la API.

La forma corta de `depends_on` solo establece orden de inicio; no espera necesariamente a que la aplicación esté lista.

## Healthcheck de la API

En el servicio `api` se añadió esta prueba, utilizando Node para no depender de `curl` o `wget` en la imagen:

```yaml
healthcheck:
  test: ["CMD", "node", "-e", "require('http').get('http://127.0.0.1:3000/', r => process.exit(r.statusCode === 200 ? 0 : 1)).on('error', () => process.exit(1))"]
  interval: 10s
  timeout: 5s
  retries: 3
  start_period: 10s
```

## Consultar el estado

```powershell
docker inspect vw-postgres --format "{{.State.Health.Status}}"
docker inspect vw-api --format "{{.State.Health.Status}}"
docker compose ps
```

## Healthcheck, restart y depends_on

Son mecanismos distintos:

- `healthcheck`: comprueba la salud del contenedor.
- `restart: unless-stopped`: define una política de reinicio cuando el proceso principal termina.
- `depends_on`: define dependencias y condiciones de arranque.

Un contenedor marcado `unhealthy` no se reinicia automáticamente solo por ese estado. Tampoco se reinicia automáticamente otro servicio dependiente si la base de datos deja de responder después del arranque. La aplicación debe gestionar errores y reconexiones; la operación debe monitorizar el estado.
