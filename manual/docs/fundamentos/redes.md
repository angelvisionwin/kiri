# Redes de Docker

Las redes permiten que los contenedores se comuniquen entre sí.

## Red bridge personalizada

Crear una red:

```powershell
docker network create red-lab
```

Iniciar Nginx dentro de ella y publicar su puerto:

```powershell
docker run -d `
  --name web-lab `
  --network red-lab `
  -p 8089:80 `
  nginx:alpine
```

Abrir `http://localhost:8089`.

Desde otro contenedor conectado a la misma red:

```powershell
docker run --rm `
  --network red-lab `
  alpine `
  wget -qO- http://web-lab
```

En una red bridge definida por el usuario, Docker proporciona resolución DNS por nombre de contenedor. Por eso el cliente puede utilizar `web-lab` en lugar de conocer su IP.

## Tres conceptos diferentes

- `ports`: publica un puerto del contenedor en el anfitrión.
- `networks`: conecta contenedores a redes para que puedan comunicarse.
- `EXPOSE`: documenta el puerto que la aplicación utiliza dentro de la imagen; por sí solo no publica el puerto.

Una API puede escuchar en el puerto 3000 y PostgreSQL en el 5432 sin publicar ninguno de ellos al anfitrión. Otros contenedores de la misma red pueden acceder mediante sus nombres DNS y puertos internos.

## Publicación solo en loopback

Para permitir acceso desde herramientas del propio Windows, pero no desde otras interfaces del anfitrión:

```yaml
ports:
  - "127.0.0.1:5432:5432"
```

Esto es útil, por ejemplo, si DBeaver se ejecuta en el mismo equipo. En producción, si solo otros contenedores necesitan PostgreSQL, normalmente no hace falta publicar el puerto.
