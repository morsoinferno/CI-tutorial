#!/bin/bash
set -e

# creamos un usuario para correr la aplicacion y lo agregamos al grupo www-data
adduser --system --no-create-home --ingroup www-data example-user

# seteamos el directorio donde esperamos encontrar el codigo
cd /prod/${PROJECT_NAME}
echo $PWD
ls -l

# agregamos las dependencias
echo "Downloading dependencies..."
pip install -r requirements.txt

# instalamos uWSGI y configuramos
# TODO: colocar esto en los requerimientos para produccion. Crear un requirements para produccion,
# ahora usamos el mismo para dev y prod. Aqui herramientas como pip-sync y pip-compile son utiles.
pip install uwsgi

# agregamos los archivos wsgi.py example.ini y example.conf
mv /tmp/wsgi.py /tmp/example.ini ./
mv /tmp/example.conf /etc/init/
echo "configuramos nginx"
# configuramos NGINX
# TODO: nginx puede quedar como microservicio fuera del contenedor de la aplicacion. Por ahora queda
# dentro de la misma aplicacion. uwsgi puede trabajar en http y exponer el servicio para que nginx
# maneje los requerimientos y los pase al otro microservicio.
mv /tmp/example /etc/nginx/sites-available/

# creamos un link
ln -s /etc/nginx/sites-available/example /etc/nginx/sites-enabled
echo "iniciamos nginx"
# iniciamos el servicio
service nginx start

# a really really bad fix, should it be a better way to overcome the problem
# container exit too early because this script ends.
while true; do sleep 1000; done