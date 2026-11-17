# Manual práctico de Docker y Kiri

Bienvenido al manual de referencia del curso. Está pensado para consultar los conceptos y comandos trabajados, no como una guía exhaustiva de todas las posibilidades de Docker.

## Entorno del curso

- Windows 11 x64.
- Kiri 0.2.1 como motor de contenedores Linux sobre WSL2.
- Docker CLI, Docker Compose y Buildx instalados.
- Contexto predeterminado: `kiri`.
- Proyecto de prácticas: `C:\\KiriCompose`.
- Aplicación de ejemplo: Nginx + API Node.js + PostgreSQL.

> **Importante:** los comandos del curso se ejecutan en PowerShell salvo que se indique expresamente que se está dentro de un contenedor (`sh`) o en Linux.

## Mapa del proyecto

```text
C:\\KiriCompose
├── compose.yaml
├── .env
├── api
│   ├── Dockerfile
│   ├── package.json
│   └── server.js
├── nginx
│   └── default.conf
├── backups
└── backup.ps1
```

La estructura puede variar a medida que evolucione el laboratorio.

## Arquitectura final del laboratorio

```text
Navegador de Windows
        |
        | http://localhost:8080
        v
      Nginx
        |
        | red frontend
        v
   API Node.js
        |
        | red backend
        v
    PostgreSQL
        |
        v
 volumen persistente
```

La API está conectada a las redes `frontend` y `backend`. Nginx solo está en `frontend`; PostgreSQL solo está en `backend`. PostgreSQL no publica su puerto al host.

## Cómo utilizar este manual

Puedes leerlo en orden como un curso o utilizar la navegación lateral para consultar una materia concreta. La sección de referencia contiene los comandos más habituales.

## Límites de lo estudiado

El curso quedó pausado antes del despliegue real en un VPS. No se han cubierto todavía en profundidad TLS/HTTPS, configuración de firewall de producción, registro de imágenes, secretos de producción, restauraciones en un servidor limpio ni automatización de copias externas.
