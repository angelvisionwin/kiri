
$ErrorActionPreference = "Stop"

$BackupDir = "C:\KiriCompose\backups"
$Fecha = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$BackupFile = Join-Path $BackupDir "visionwin_$Fecha.dump"

# Crear carpeta si no existe
New-Item -ItemType Directory -Force -Path $BackupDir | Out-Null

# Comprobar que PostgreSQL está disponible
docker compose exec -T postgres pg_isready -U vwuser -d visionwin

if ($LASTEXITCODE -ne 0) {
    throw "PostgreSQL no está disponible. Backup cancelado."
}

# Generar copia de seguridad
docker compose exec -T postgres pg_dump -U vwuser -d visionwin -Fc > $BackupFile

if ($LASTEXITCODE -ne 0) {
    Remove-Item $BackupFile -ErrorAction SilentlyContinue
    throw "Error al generar la copia de seguridad."
}

Write-Host "Backup creado correctamente: $BackupFile"

Get-ChildItem $BackupDir -Filter "visionwin_*.dump" |
    Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-15) } |
    Remove-Item -Force