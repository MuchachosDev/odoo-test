# Usar la imagen oficial de Odoo como base
FROM odoo:17.0

# Copiar el archivo de requerimientos al contenedor
COPY requirements.txt /etc/odoo/

# Actualizar el gestor de paquetes e instalar dependencias
USER root
RUN apt-get update && apt-get install -y python3-pip git \
    && rm -rf /var/lib/apt/lists/*

# Instalar las librerías de Python listadas en requirements.txt
RUN pip3 install -r /etc/odoo/requirements.txt

# --- INICIO DE LA SOLUCIÓN ---
# Corregir los permisos de la librería pyafipws para que el usuario odoo pueda escribir en el caché.
# La ruta puede variar ligeramente según la versión de Python de la imagen base.
RUN chown -R odoo:odoo /usr/local/lib/python3.10/dist-packages/pyafipws
# --- FIN DE LA SOLUCIÓN ---

# Copiar configuración personalizada
COPY config/odoo.conf /etc/odoo/

# Crear directorios para addons
# Es mejor que el usuario 'odoo' cree la carpeta que va a usar.
USER odoo
RUN mkdir -p /opt/odoo/addons

# Exponer el puerto
EXPOSE 8069

# Comando por defecto
CMD ["odoo"]
