# Dockerfile e imágenes propias

Un Dockerfile describe cómo construir una imagen.

## Ejemplo Node.js

Archivo `server.js`:

```javascript
const http = require('http');

const server = http.createServer((req, res) => {
  res.writeHead(200, {'Content-Type': 'text/plain; charset=utf-8'});
  res.end('Visionwin API funcionando');
});

server.listen(3000, '0.0.0.0', () => {
  console.log('API escuchando en puerto 3000');
});
```

Dockerfile:

```dockerfile
FROM node:22-alpine
WORKDIR /app
COPY server.js .
EXPOSE 3000
CMD ["node", "server.js"]
```

Construir y ejecutar:

```powershell
docker build -t visionwin-api:1.0 .
docker run -d --name visionwin-api -p 3000:3000 visionwin-api:1.0
```

Probar:

```powershell
Invoke-WebRequest http://localhost:3000 -UseBasicParsing
```

## Las imágenes son instantáneas de construcción

Si modificas `server.js` en Windows, el contenedor que ya está ejecutándose no cambia automáticamente: el archivo se copió a la imagen durante `docker build`.

Hay que construir una nueva versión y recrear el contenedor:

```powershell
docker build -t visionwin-api:1.1 .
docker rm -f visionwin-api
docker run -d --name visionwin-api -p 3000:3000 visionwin-api:1.1
```

Etiquetar una imagen:

```powershell
docker tag visionwin-api:1.1 visionwin-api:latest
```

`latest` es solo una etiqueta convencional. No significa que Docker detecte automáticamente cuál es la versión más nueva.

## Dockerfile utilizado por el laboratorio Compose

```dockerfile
FROM node:22-alpine
WORKDIR /app
COPY package.json ./
RUN npm install --omit=dev
COPY server.js .
EXPOSE 3000
CMD ["node", "server.js"]
```

Este Dockerfile instala la dependencia `pg` y copia el servidor de la API.

Más adelante conviene mejorar este ejemplo con `package-lock.json`, `npm ci`, `.dockerignore` y ejecución como usuario no privilegiado. Esas optimizaciones quedaron fuera del nivel básico del curso.
