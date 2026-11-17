# Imágenes y contenedores

## Imagen

Una imagen es una plantilla de solo lectura que contiene lo necesario para ejecutar una aplicación: sistema base, dependencias, archivos y configuración.

## Contenedor

Un contenedor es una instancia creada a partir de una imagen. Añade una capa escribible propia. Los cambios guardados en esa capa pueden sobrevivir a una parada y posterior arranque del mismo contenedor, pero se pierden al eliminarlo.

Para datos que deban sobrevivir a la eliminación y recreación del contenedor se utilizan volúmenes o bind mounts.

## Comandos básicos

```powershell
docker images
docker ps
docker ps -a
docker run -it --name alpine-lab alpine sh
```

- `docker ps`: contenedores en ejecución.
- `docker ps -a`: también muestra los detenidos.
- `docker run`: crea un contenedor y lo inicia.
- `docker start`: inicia un contenedor existente.

Ejemplo de ciclo de vida:

```powershell
docker start -ai alpine-lab
docker stop alpine-lab
docker rm alpine-lab
```

`-i` mantiene la entrada estándar abierta y `-t` asigna una terminal. `-a` conecta la terminal al contenedor al iniciarlo.

## Inspección

```powershell
docker inspect alpine-lab
docker inspect alpine-lab --format "{{.State.Status}}"
```

`inspect` devuelve información detallada del objeto Docker: configuración, estado, redes, montajes, etc.

## Idea clave

Eliminar un contenedor no es lo mismo que eliminar una imagen. Y eliminar un contenedor no debería implicar perder datos persistentes si estos están correctamente separados en volúmenes.
