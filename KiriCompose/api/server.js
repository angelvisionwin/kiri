const http = require('http');
const { Pool } = require('pg');

const pool = new Pool({
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    database: process.env.DB_NAME,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD
});

const server = http.createServer(async (req, res) => {
    res.setHeader('Content-Type', 'application/json; charset=utf-8');

    if (req.url === '/db') {
        try {
            const result = await pool.query(
                'SELECT NOW() AS fecha, version() AS version'
            );

            res.writeHead(200);
            res.end(JSON.stringify({
                estado: 'Conectado a PostgreSQL',
                fecha: result.rows[0].fecha,
                version: result.rows[0].version
            }));
        } catch (error) {
            res.writeHead(500);
            res.end(JSON.stringify({
                error: error.message
            }));
        }
        return;
    }

    res.writeHead(200);
    res.end(JSON.stringify({
        aplicacion: 'Visionwin API',
        version: '2.0',
        mensaje: 'Visionwin API versión 2.0'
    }));
});

server.listen(3000, '0.0.0.0', () => {
    console.log('API escuchando en puerto 3000');
});