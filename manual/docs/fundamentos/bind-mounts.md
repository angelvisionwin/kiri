# Bind mounts

Un bind mount conecta una ruta concreta del equipo anfitrión con una ruta dentro del contenedor.

A diferencia de un volumen nombrado, la carpeta y su contenido pertenecen al sistema anfitrión.

## Ejemplo en Windows

Crear `C:\\KiriBindTest` y colocar dentro un `index.html`. Después:

```powershell
docker run -d `
  --name alpine-bind `
  --mount type=bind,source="C:\KiriBindTest",target=/app `
  alpine `
  sh -c "while true; do sleep 3600; done"
```

Dentro del contenedor:

```powershell
docker exec alpine-bind ls -la /app
docker exec alpine-bind sh -c "echo 'Creado desde Linux' > /app/desde-contenedor.txt"
```

El nuevo archivo aparece en la carpeta de Windows. Los cambios realizados desde Windows también se ven desde el contenedor.

Eliminar el contenedor:

```powershell
docker rm -f alpine-bind
```

La carpeta de Windows permanece.

## Cuándo utilizar cada mecanismo

| Mecanismo | Uso habitual |
|---|---|
| Volumen nombrado | Datos persistentes gestionados por Docker, por ejemplo PostgreSQL |
| Bind mount | Compartir archivos del anfitrión, código fuente, configuración o documentos |

En producción, los bind mounts deben utilizarse con rutas y permisos deliberados. Para datos de bases de datos, los volúmenes nombrados suelen ser una opción más cómoda.
