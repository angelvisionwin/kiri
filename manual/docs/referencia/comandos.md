# Chuleta de comandos

## General

```powershell
docker version
docker context ls
docker context use kiri
docker images
docker ps
docker ps -a
docker inspect NOMBRE
docker stats
```

## Contenedores

```powershell
docker run -it --name prueba alpine sh
docker start -ai prueba
docker stop prueba
docker rm prueba
docker rm -f prueba
docker exec -it prueba sh
```

## Volúmenes y redes

```powershell
docker volume ls
docker volume inspect NOMBRE
docker network ls
docker network inspect NOMBRE
docker network create NOMBRE
```

## Compose

```powershell
docker compose config
docker compose up -d
docker compose up -d --build
docker compose ps
docker compose logs
docker compose logs -f SERVICIO
docker compose exec SERVICIO sh
docker compose stop
docker compose start
docker compose restart SERVICIO
docker compose down
```

## PostgreSQL del laboratorio

```powershell
docker compose exec postgres psql -U vwuser -d visionwin
docker compose exec postgres psql -U vwuser -d visionwin -c "SELECT * FROM pruebas;"
```

Dentro de `psql`, salir con `\q`.

## Diagnóstico rápido

```powershell
docker compose ps
docker compose logs --tail 100 SERVICIO
docker inspect NOMBRE --format "{{.State.Status}}"
docker inspect NOMBRE --format "{{.State.Health.Status}}"
docker inspect NOMBRE --format "{{.State.ExitCode}}"
```

## URLs del laboratorio

- API detrás de Nginx: `http://localhost:8080`
- Prueba de PostgreSQL desde la API: `http://localhost:8080/db`
- Prueba anterior de Nginx independiente: `http://localhost:8089`
- API Dockerfile independiente: `http://localhost:3000`
