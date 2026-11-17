# Docker Compose multicontenedor

Compose permite definir varios servicios, sus redes, volúmenes y configuración en un único archivo YAML.

## Arquitectura `visionwin-lab`

- Nginx: proxy inverso, único servicio publicado en el anfitrión.
- API Node.js: escucha internamente en el puerto 3000.
- PostgreSQL: escucha internamente en el puerto 5432 y guarda los datos en un volumen.

Estructura:

```text
C:\\KiriCompose
├── compose.yaml
├── api
│   ├── Dockerfile
│   ├── package.json
│   └── server.js
└── nginx
    └── default.conf
```

## Configuración de Nginx

`nginx/default.conf`:

```nginx
server {
    listen 80;

    location / {
        proxy_pass http://api:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```

Nginx utiliza `api:3000`. `api` es el nombre DNS del servicio en la red de Compose.

## API

`api/package.json`:

```json
{
  "name": "visionwin-api",
  "version": "1.0.0",
  "main": "server.js",
  "dependencies": {
    "pg": "^8.16.3"
  }
}
```

La API lee las variables `DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER` y `DB_PASSWORD` y utiliza el paquete `pg` para consultar PostgreSQL. El endpoint `/db` ejecuta una consulta de prueba (`SELECT NOW(), version()`).

## Compose de partida

El siguiente ejemplo recoge la configuración funcional inicial. En las lecciones posteriores se separaron las redes y se añadió el healthcheck de la API; consulta las páginas correspondientes para la evolución.

```yaml
name: visionwin-lab

services:
  nginx:
    image: nginx:alpine
    container_name: vw-nginx
    ports:
      - "8080:80"
    volumes:
      - ./nginx/default.conf:/etc/nginx/conf.d/default.conf:ro
    depends_on:
      - api
    restart: unless-stopped

  api:
    build: ./api
    container_name: vw-api
    environment:
      DB_HOST: postgres
      DB_PORT: 5432
      DB_NAME: visionwin
      DB_USER: vwuser
      DB_PASSWORD: prueba123
    depends_on:
      postgres:
        condition: service_healthy
    restart: unless-stopped

  postgres:
    image: postgres:16-alpine
    container_name: vw-postgres
    environment:
      POSTGRES_DB: visionwin
      POSTGRES_USER: vwuser
      POSTGRES_PASSWORD: prueba123
    volumes:
      - postgres_data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U vwuser -d visionwin"]
      interval: 5s
      timeout: 5s
      retries: 10
    restart: unless-stopped

volumes:
  postgres_data:
```

> Las credenciales son solo de laboratorio. No utilices contraseñas de ejemplo en un servidor real.

## Comandos Compose

Desde la carpeta que contiene `compose.yaml`:

```powershell
docker compose config
docker compose up -d --build
docker compose ps
docker compose logs
docker compose logs -f api
docker compose exec postgres psql -U vwuser -d visionwin
```

Probar en el navegador:

- `http://localhost:8080`
- `http://localhost:8080/db`
