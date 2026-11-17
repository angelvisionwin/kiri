# Manual práctico de Docker y Kiri

Este paquete contiene un sitio de documentación **MkDocs** en español, organizado a partir del curso práctico realizado con Kiri sobre Windows 11.

## Contenido

- Fundamentos: imágenes, contenedores, volúmenes, bind mounts y redes.
- Construcción de imágenes y Docker Compose.
- Proyecto práctico `visionwin-lab` con Nginx, API Node.js y PostgreSQL.
- Variables de entorno, redes separadas y healthchecks.
- Logs, diagnóstico, administración y backups de PostgreSQL.
- Chuleta de comandos y próximos pasos para continuar en un VPS Linux.

## Requisitos para visualizarlo

- Python 3.9 o superior.
- MkDocs y el tema Material.

## Instalación y vista previa

Desde la carpeta descomprimida:

```bash
python -m venv .venv
```

En Windows PowerShell:

```powershell
.venv\Scripts\Activate.ps1
pip install mkdocs-material
mkdocs serve
```

En Linux/macOS:

```bash
source .venv/bin/activate
pip install mkdocs-material
mkdocs serve
```

Abre la dirección local que indique MkDocs (normalmente `http://127.0.0.1:8000`).

## Generar el sitio estático

```bash
mkdocs build
```

El sitio generado queda en la carpeta `site/`.

## Notas

- Los ejemplos utilizan el proyecto de laboratorio `visionwin-lab` y sus nombres de contenedor.
- El motor Docker está gestionado por Kiri. En el curso, `docker context use kiri` dejó Kiri como contexto predeterminado.
- Las credenciales del laboratorio (`vwuser` / `prueba123`) son ficticias y **no deben reutilizarse en producción**.
- Este manual recoge lo trabajado hasta la pausa del curso. El despliegue en VPS Linux, HTTPS, firewall y automatización de backups externos quedan para una continuación posterior.
