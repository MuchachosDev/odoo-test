#!/bin/bash
# export_volumes.sh

DATE=$(date +%Y%m%d_%H%M%S)
EXPORT_DIR="odoo_volumes_$DATE"

echo "=== EXPORTANDO VOLÚMENES DE ODOO ==="
mkdir -p $EXPORT_DIR

# 1. Verificar que los volúmenes existen
echo "Verificando volúmenes..."
if ! docker volume ls | grep -q postgres_data; then
    echo "❌ Error: Volumen postgres_data no encontrado"
    exit 1
fi

if ! docker volume ls | grep -q filestore-data; then
    echo "❌ Error: Volumen filestore_data no encontrado"
    exit 1
fi

# 2. Exportar postgres_data
echo "1. Exportando postgres_data..."
docker run --rm \
    -v postgres_data:/data \
    -v $(pwd)/$EXPORT_DIR:/backup \
    alpine tar czf /backup/postgres_data.tar.gz -C /data .

# 3. Exportar filestore_data
echo "2. Exportando filestore_data..."
docker run --rm \
    -v filestore_data:/data \
    -v $(pwd)/$EXPORT_DIR:/backup \
    alpine tar czf /backup/filestore_data.tar.gz -C /data .
