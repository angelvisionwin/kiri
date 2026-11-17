# Logs y diagnóstico

## Consultar logs

```powershell
docker compose logs
docker compose logs api
docker compose logs postgres
docker compose logs -f api
docker compose logs --tail 50 api
docker compose logs --since 10m api
docker compose logs -f --tail 100
```

`-f` sigue la salida en tiempo real. `Ctrl+C` detiene la visualización, no el contenedor.

Docker recoge normalmente la salida estándar (`stdout`) y la salida de errores (`stderr`) de los procesos del contenedor.

## Estado e inspección

```powershell
docker ps
docker ps -a
docker compose ps
docker inspect vw-api
docker inspect vw-api --format "{{.State.Status}}"
docker inspect vw-api --format "{{.State.Health.Status}}"
docker inspect vw-api --format "{{.State.ExitCode}}"
```

Un código de salida `0` suele indicar finalización correcta; uno distinto de cero suele indicar error. Debe interpretarse junto con logs y contexto.

## Entrar en un contenedor existente

```powershell
docker compose exec api sh
```

Dentro:

```sh
pwd
ls -la
printenv
node --version
cat server.js
exit
```

Ejecutar un comando sin abrir shell:

```powershell
docker compose exec api node --version
```

## `exec` frente a `run`

- `docker compose exec api sh`: ejecuta un proceso dentro del contenedor existente.
- `docker compose run --rm api sh`: crea un contenedor nuevo y temporal usando la configuración del servicio.
- `docker run --rm alpine sh`: crea un contenedor temporal independiente de Compose.

## Diagnóstico de un 502 Bad Gateway

En este laboratorio Nginx hace proxy hacia `http://api:3000`. Si el navegador muestra 502, una secuencia razonable es:

1. Consultar logs de Nginx para identificar el error concreto.
2. Comprobar el estado de la API con `docker compose ps`.
3. Consultar los logs de la API.
4. Comprobar que la API escucha en `0.0.0.0:3000` y que Nginx puede resolver y alcanzar `api:3000` en la red frontend.
5. Investigar PostgreSQL si los errores de la API apuntan a la base de datos.

Ejemplos de mensajes de Nginx:
- `connection refused`: el destino resuelve, pero no acepta la conexión en ese puerto.
- `host not found`: problema de resolución del nombre del upstream.
- `upstream timed out`: el destino no respondió dentro del tiempo esperado.

**Consejo operativo:** recopila primero estado y logs antes de reiniciar. Reiniciar demasiado pronto puede hacer perder pistas útiles.
