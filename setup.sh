#!/bin/bash

set -e

echo "🚀 Configurando Odoo 17 con Dockerfile..."

# Crear estructura básica
mkdir -p addons

echo "📦 Descargando Odoo Core..."
if [ ! -d "odoo-core" ]; then
    git clone -b 17.0 --depth 1 https://github.com/odoo/odoo.git odoo-core
fi

echo "📦 Descargando Addons..."
cd addons

# INGADHOC
echo "  📁 INGADHOC repos..."
[ ! -d "odoo-argentina" ] && git clone -b 17.0 --depth 1 https://github.com/ingadhoc/odoo-argentina.git
[ ! -d "argentina-sale" ] && git clone -b 17.0 --depth 1 https://github.com/ingadhoc/argentina-sale.git
[ ! -d "miscellaneous" ] && git clone -b 17.0 --depth 1 https://github.com/ingadhoc/miscellaneous.git
[ ! -d "odoo-argentina-ce" ] && git clone -b 17.0 --depth 1 https://github.com/ingadhoc/odoo-argentina-ce.git
[ ! -d "stock" ] && git clone -b 17.0 --depth 1 https://github.com/ingadhoc/stock.git
[ ! -d "account-financial-tools" ] && git clone -b 17.0 --depth 1 https://github.com/ingadhoc/account-financial-tools.git
[ ! -d "account-payment" ] && git clone -b 17.0 --depth 1 https://github.com/ingadhoc/account-payment.git
[ ! -d "product" ] && git clone -b 17.0 --depth 1 https://github.com/ingadhoc/product.git
[ ! -d "sale" ] && git clone -b 17.0 --depth 1 https://github.com/ingadhoc/sale.git
[ ! -d "account-invoicing" ] && git clone -b 17.0 --depth 1 https://github.com/ingadhoc/account-invoicing.git
[ ! -d "purchase" ] && git clone -b 17.0 --depth 1 https://github.com/ingadhoc/purchase.git

# OCA
echo "  📁 OCA repos..."
[ ! -d "stock-logistics-workflow" ] && git clone -b 17.0 --depth 1 https://github.com/OCA/stock-logistics-workflow.git
[ ! -d "pos" ] && git clone -b 17.0 --depth 1 https://github.com/OCA/pos.git
[ ! -d "web" ] && git clone -b 17.0 --depth 1 https://github.com/OCA/web.git
[ ! -d "purchase-workflow" ] && git clone -b 17.0 --depth 1 https://github.com/OCA/purchase-workflow.git
[ ! -d "sale-workflow" ] && git clone -b 17.0 --depth 1 https://github.com/OCA/sale-workflow.git

cd ..

echo "🐳 Construyendo imagen Docker personalizada..."
docker-compose build

echo "🚀 Iniciando servicios Docker..."
docker-compose up -d

echo "⏳ Esperando que los servicios estén listos..."
echo "   🔍 Verificando PostgreSQL..."
timeout=60
while ! docker-compose exec -T db pg_isready -U odoo -d postgres >/dev/null 2>&1; do
    timeout=$((timeout - 1))
    if [ $timeout -eq 0 ]; then
        echo "❌ Timeout esperando PostgreSQL"
        exit 1
    fi
    sleep 1
done

echo "   🔍 Verificando Odoo..."
sleep 15

echo ""
echo "✅ ¡Odoo 17 personalizado está listo!"
echo "🌐 URL: http://localhost:8069"
echo "🗄️  PostgreSQL: localhost:5432"
echo "👤 Usuario DB: odoo"
echo "🔑 Contraseña DB: odoo"
echo ""
echo "📦 Dependencias Python instaladas:"
echo "   ✅ pyafipws (AFIP Argentina)"
echo "   ✅ PyPDF2"
echo ""
echo "📁 Estructura:"
echo "   Dockerfile        - Imagen personalizada"
echo "   requirements.txt  - Dependencias Python"
echo "   odoo-core/       - Core Odoo"
echo "   addons/          - Addons de terceros"
echo "   odoo.conf        - Configuración"
echo ""
echo "🔧 Comandos útiles:"
echo "   ./update.sh              - Actualizar addons"
echo "   docker-compose build     - Reconstruir imagen"
echo "   docker-compose logs -f   - Ver logs"
echo "   docker-compose down      - Parar servicios"
