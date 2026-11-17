# Copias de seguridad y restauración de PostgreSQL

Se practicó una copia lógica con `pg_dump` en formato personalizado y una restauración con `pg_restore`.

## Crear un backup

Desde PowerShell, en la carpeta del proyecto:

```powershell
docker compose exec -T postgres pg_dump -U vwuser -d visionwin -Fc > backup_visionwin.dump
```

- `exec -T`: ejecuta dentro del contenedor sin asignar una TTY.
- `pg_dump`: exporta la base de datos.
- `-U vwuser`: usuario.
- `-d visionwin`: base de datos.
- `-Fc`: formato personalizado, que se restaura con `pg_restore`.
- `>`: redirige la salida al archivo del anfitrión.

Comprobar el archivo:

```powershell
Get-Item .\backup_visionwin.dump
```

Listar el contenido lógico del archivo:

```powershell
docker compose exec -T postgres pg_restore -l < backup_visionwin.dump
```

## Restaurar

La práctica eliminó deliberadamente la tabla `pruebas` y después restauró la base de datos desde el archivo.

Eliminar tabla (solo en laboratorio):

```powershell
docker compose exec postgres psql -U vwuser -d visionwin -c "DROP TABLE pruebas;"
```

Restaurar el contenido:

```powershell
docker compose exec -T postgres pg_restore -U vwuser -d visionwin --clean --if-exists < backup_visionwin.dump
```

Comprobar:

```powershell
docker compose exec postgres psql -U vwuser -d visionwin -c "SELECT * FROM pruebas;"
```

`--clean` solicita eliminar los objetos antes de recrearlos; `--if-exists` evita errores por objetos que no existan. Esta operación puede reemplazar objetos existentes: úsala con cuidado.

## Qué protege cada tipo de copia

| Tipo | Qué contiene |
|---|---|
| `pg_dump` | Copia lógica de una base de datos |
| Copia física del volumen | Archivos de datos de PostgreSQL; requiere procedimiento compatible con la base de datos y su estado |
| Copia externa | Protege frente a la pérdida del servidor o del almacenamiento local |

Una copia guardada únicamente en el mismo VPS no protege frente a la pérdida de ese VPS. Para producción se necesita una copia externa y pruebas periódicas de restauración.

## Automatización: alcance de lo realizado

Se bosquejó un script PowerShell para el laboratorio Windows que generaba ficheros con fecha y aplicaba retención. Se decidió no continuar con la programación de tareas de Windows. El script no debe considerarse un sistema de backup de producción.

En la continuación Linux se diseñará un mecanismo apropiado para el VPS, con comprobación del resultado, retención, protección de credenciales y envío fuera del servidor.
