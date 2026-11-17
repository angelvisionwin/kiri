# Redes separadas: frontend y backend

Compose crea por defecto una red para el proyecto. Podemos definir varias redes para limitar qué servicios pueden comunicarse directamente.

## Objetivo

- `frontend`: Nginx y API.
- `backend`: API y PostgreSQL.
- PostgreSQL no comparte red con Nginx.
- `backend` se declara `internal: true` para aislarla del exterior.

## Fragmentos de configuración

En `nginx`:

```yaml
networks:
  - frontend
```

En `api`:

```yaml
networks:
  - frontend
  - backend
```

En `postgres`:

```yaml
networks:
  - backend
```

Al final de `compose.yaml`:

```yaml
networks:
  frontend:
    driver: bridge
  backend:
    driver: bridge
    internal: true
```

La API está en las dos redes porque recibe peticiones de Nginx y consulta PostgreSQL.

## Redis como ejemplo

Si añadimos Redis para que lo utilice la API, y Nginx no necesita acceder a Redis, lo conectaríamos solo a `backend`. La API también tendría que estar conectada a esa red, como ya está.

## Aplicar y comprobar

```powershell
docker compose config
docker compose up -d
docker network ls
docker network inspect visionwin-lab_frontend
docker network inspect visionwin-lab_backend
```

Los nombres de red suelen llevar el prefijo del proyecto, por ejemplo `visionwin-lab_frontend`.

> `internal: true` aísla la red del exterior, pero no sustituye a un firewall del anfitrión ni a un diseño completo de seguridad. La API está conectada también a `frontend`, por lo que su conectividad debe evaluarse teniendo en cuenta ambas redes.
