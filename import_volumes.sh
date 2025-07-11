#!/bin/bash
# importar_volumes.sh

echo "=== IMPORTANDO VOLÚMENES DE ODOO ==="
echo "Buscando archivos en directorio actual..."

# Verificar archivos
if [ ! -f "postgres_data.tar.gz" ]; then
    echo "❌ Error: No se encuentra postgres_data.tar.gz"
    exit 1
fi

if [ ! -f "filestore_data.tar.gz" ]; then
    echo "❌ Error: No se encuentra filestore_data.tar.gz"
    exit 1
fi

echo "✅ Archivos encontrados:"
echo "  - postgres_data.tar.gz ($(du -sh postgres_data.tar.gz | cut -f1))"
echo "  - filestore_data.tar.gz ($(du -sh filestore_data.tar.gz | cut -f1))"

# Crear volúmenes con nombres exactos
echo ""
echo "1. Creando volúmenes Docker..."
docker volume create postgres_data
docker volume create filestore-data

# Importar postgres_data
echo "2. Importando postgres_data..."
docker run --rm \
    -v postgres_data:/data \
    -v $(pwd):/backup \
    alpine sh -c "tar xzf /backup/postgres_data.tar.gz -C /data"

echo "   ✅ postgres_data importado"

# Importar filestore-data (con guión)
echo "3. Importando filestore-data..."
docker run --rm \
    -v filestore-data:/data \
    -v $(pwd):/backup \
    alpine sh -c "tar xzf /backup/filestore_data.tar.gz -C /data"

echo "   ✅ filestore-data importado"

echo ""
echo "=== IMPORTACIÓN COMPLETADA ==="
echo "🎉 ¡Volúmenes importados correctamente!"
