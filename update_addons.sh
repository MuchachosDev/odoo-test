#!/bin/bash

set -e

echo "🔄 Actualizando Odoo y addons..."

# Actualizar core
echo "📦 Actualizando Odoo Core..."
cd odoo-core
git fetch origin
git reset --hard origin/17.0
cd ..

# Actualizar addons
echo "📦 Actualizando addons..."
cd addons

for dir in */; do
    if [ -d "$dir/.git" ]; then
        echo "  🔄 $dir"
        cd "$dir"
        git fetch origin
        git reset --hard origin/17.0
        cd ..
    fi
done

cd ..

echo "🐳 Reconstruyendo imagen Docker..."
docker-compose build

echo "🚀 Reiniciando servicios..."
docker-compose down
docker-compose up -d

echo "⏳ Esperando reinicio..."
sleep 15

echo "✅ ¡Actualización completada!"
echo "🌐 Odoo disponible en: http://localhost:8069"
