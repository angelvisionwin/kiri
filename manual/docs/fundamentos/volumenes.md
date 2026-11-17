# Volúmenes y persistencia

Los volúmenes permiten conservar datos independientemente del ciclo de vida de un contenedor. Docker/Kiri los administra.

## Crear e inspeccionar un volumen

```powershell
docker volume create datos-alpine
docker volume ls
docker volume inspect datos-alpine
```

## Montar un volumen

```powershell
docker run -d `
  --name alpine-vol `
  -v datos-alpine:/datos `
  alpine `
  sh -c "while true; do sleep 3600; done"
```

Escribir un fichero:

```powershell
docker exec alpine-vol sh -c "echo 'dato persistente' > /datos/prueba.txt"
docker exec alpine-vol cat /datos/prueba.txt
```

Eliminar el contenedor y crear otro utilizando el mismo volumen:

```powershell
docker rm -f alpine-vol

docker run -d `
  --name alpine-vol `
  -v datos-alpine:/datos `
  alpine `
  sh -c "while true; do sleep 3600; done"

docker exec alpine-vol cat /datos/prueba.txt
```

El fichero continúa existiendo porque estaba en el volumen.

## Volúmenes nombrados en Compose

En el laboratorio PostgreSQL utiliza:

```yaml
services:
  postgres:
    volumes:
      - postgres_data:/var/lib/postgresql/data

volumes:
  postgres_data:
```

Compose crea un volumen con el nombre del proyecto, normalmente `visionwin-lab_postgres_data`.

## Advertencia

- `docker compose down` elimina contenedores y redes, pero conserva los volúmenes nombrados.
- `docker compose down -v` elimina también los volúmenes declarados por el proyecto. Puede destruir los datos de PostgreSQL.

No ejecutes `down -v` en un entorno con datos que quieras conservar sin tener una copia verificada.
