# Administración diaria de Compose

Ejecuta los comandos desde la carpeta que contiene `compose.yaml`.

## Ciclo de vida

| Acción | Comando |
|---|---|
| Crear/iniciar servicios | `docker compose up -d` |
| Construir e iniciar | `docker compose up -d --build` |
| Detener contenedores | `docker compose stop` |
| Arrancar contenedores existentes | `docker compose start` |
| Reiniciar servicios | `docker compose restart` |
| Eliminar contenedores y redes | `docker compose down` |
| Ver estado | `docker compose ps` |

## Diferencias esenciales

- `stop`: detiene contenedores, pero los conserva.
- `start`: arranca contenedores ya existentes.
- `down`: elimina los contenedores del proyecto y su red; conserva por defecto los volúmenes nombrados.
- `down -v`: elimina también los volúmenes declarados por el proyecto.
- `up -d`: crea o arranca el entorno en segundo plano; puede recrear servicios si la configuración o imagen lo requiere.

## Práctica realizada

```powershell
docker compose stop
docker compose ps -a
docker compose start
docker compose ps
```

Después:

```powershell
docker compose down
docker volume ls
docker compose up -d
docker compose exec postgres psql -U vwuser -d visionwin -c "SELECT * FROM pruebas;"
```

El registro de prueba seguía disponible gracias al volumen.

> **Peligro:** `docker compose down -v` puede eliminar los datos persistentes del laboratorio. No lo utilices como una forma rutinaria de “limpiar” un entorno con información valiosa.
