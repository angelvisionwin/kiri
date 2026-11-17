# Próximos pasos del curso

El curso quedó pausado a la espera de disponer de un VPS de pruebas. La siguiente etapa será desplegar el laboratorio en Linux, sin intervenir en servidores de producción.

## Preparación orientativa del VPS

Para las prácticas se propuso como punto de partida:

- Debian 12 o 13.
- 2 vCPU.
- 4 GB de RAM.
- 40 GB SSD.

No es una especificación obligatoria; se ajustará según disponibilidad y necesidades.

## Temario pendiente

1. Instalar Docker Engine y el plugin Docker Compose en Linux.
2. Trasladar el proyecto y sus variables de configuración.
3. Preparar firewall y puertos publicados.
4. Configurar dominio, Nginx y HTTPS.
5. Actualizar servicios y desplegar nuevas versiones.
6. Diseñar backups de PostgreSQL en Linux, con validación, retención y copia externa.
7. Mejorar Dockerfiles y seguridad básica.
8. Valorar un registro de imágenes y flujos de despliegue.

## Buenas prácticas para la continuación

- No experimentar inicialmente en un VPS de producción.
- No publicar PostgreSQL directamente a Internet.
- No reutilizar las credenciales del laboratorio.
- No guardar la única copia de seguridad en el mismo servidor.
- Recopilar logs y estado antes de reiniciar servicios.
- Mantener los datos persistentes separados de los contenedores.
