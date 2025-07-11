# Usar la imagen oficial de Odoo como base
FROM odoo:17.0

# Copiar el archivo de requerimientos al contenedor
COPY requirements.txt /etc/odoo/

# Actualizar el gestor de paquetes e instalar pip si es necesario
USER root
RUN apt-get update && apt-get install -y python3-pip git \
    && rm -rf /var/lib/apt/lists/*

# Instalar las librerías de Python listadas en requirements.txt
RUN pip3 install -r /etc/odoo/requirements.txt

# Copiar configuración personalizada
COPY config/odoo.conf /etc/odoo/

# Crear directorios para addons
RUN mkdir -p /opt/odoo/addons

# Volver al usuario odoo
USER odoo

# Exponer el puerto
EXPOSE 8069

# Comando por defecto
CMD ["odoo"]
