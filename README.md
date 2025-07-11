# Odoo 17 - Entorno Argentino con Dockerfile

Entorno de desarrollo Odoo 17 con addons argentinos, imagen Docker personalizada y dependencias Python específicas.

## 🚀 Setup rápido

```bash
git clone <tu-repo>
cd <proyecto>
chmod +x setup.sh
./setup.sh
```

**¡Listo!** Odoo estará en http://localhost:8069 con todas las dependencias instaladas.

## 📁 Lo que se versiona

Tu repo contiene **tu configuración completa**:

```
✅ Dockerfile           - Imagen personalizada Odoo
✅ requirements.txt     - Dependencias Python
✅ docker-compose.yml   - Configuración servicios
✅ setup.sh             - Script instalación  
✅ update.sh            - Script actualización
✅ odoo.conf            - Configuración Odoo
✅ .gitignore           - Exclusiones Git
✅ README.md            - Documentación

❌ odoo-core/           - Se descarga automático
❌ addons/              - Se descarga automático
```

## 🐳 Imagen Docker personalizada

La imagen incluye:
- **Odoo 17.0** como base
- **pyafipws** - Biblioteca AFIP Argentina
- **PyPDF2** - Manipulación PDF
- **Git** - Para clones automáticos

## 🔧 Comandos

```bash
# Actualizar todo (código + imagen)
./update.sh

# Docker avanzado
docker-compose build     # Reconstruir imagen
docker-compose up -d     # Iniciar servicios
docker-compose down      # Parar servicios
docker-compose logs -f   # Ver logs en tiempo real

# Acceso a contenedores
docker-compose exec odoo bash    # Acceder a Odoo
docker-compose exec db psql -U odoo postgres  # Acceder a DB
```

## 📦 Addons incluidos

### 🇦🇷 INGADHOC (Argentina)
- **odoo-argentina** - Localización Argentina completa
- **argentina-sale** - Ventas Argentina
- **miscellaneous** - Herramientas varias  
- **odoo-argentina-ce** - Argentina Community Edition
- **stock** - Gestión avanzada de stock
- **account-financial-tools** - Herramientas contables
- **account-payment** - Gestión de pagos y cobranzas

### 🌐 OCA (Community)
- **stock-logistics-workflow** - Flujos avanzados de stock
- **pos** - Punto de venta mejorado

## 🌐 Acceso

- **Odoo**: http://localhost:8069
- **PostgreSQL**: localhost:5432
- **Usuario DB**: odoo / odoo

## 👥 Flujo de equipo

### Desarrollador nuevo:
```bash
git clone repo
./setup.sh    # Descarga código + construye imagen
```

### Actualizar proyecto:
```bash
git pull      # Tu configuración
./update.sh   # Código + imagen actualizada
```

### Cambiar dependencias:
```bash
# Editar requirements.txt o Dockerfile
docker-compose build  # Reconstruir imagen
docker-compose up -d   # Aplicar cambios
```

### Cambiar configuración:
```bash
# Editar odoo.conf o docker-compose.yml
git add .
git commit -m "Actualizar config"
git push
```

## ✨ Ventajas del Dockerfile

✅ **Dependencias integradas** - pyafipws y PyPDF2 pre-instalados  
✅ **Imagen versionada** - Control total sobre el entorno  
✅ **Reproducible** - Mismo entorno en todos lados  
✅ **Extensible** - Fácil agregar más dependencias  
✅ **Profesional** - Setup enterprise-ready  

## 🔧 Agregando más dependencias

1. Edita `requirements.txt`:
```txt
git+https://github.com/ingadhoc/pyafipws.git
PyPDF2
mi-nueva-libreria==1.0.0
```

2. Reconstruye:
```bash
docker-compose build
docker-compose up -d
```

¡Listo! 🚀
