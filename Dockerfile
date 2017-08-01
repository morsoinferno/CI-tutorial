FROM ubuntu:16.04

# instalamos dependencias y apps
RUN apt-get update && \
	apt-get install -y --no-install-recommends build-essential \
											   libmysqlclient-dev \
											   python \
											   python-dev \
											   python-setuptools \
											   python-pip \
											   nginx \
											   supervisor \
											   && \
	rm -rf /var/lib/apt/list/* 

# instalamos uwsgi
RUN pip install --upgrade pip && pip install uwsgi

# instalamos dependencias para nuestra app
# TODO: crear un archivo de requirements propio para produccion, no
# utilizar el de dev o buscar crear con el builder un autoejecutable (egg)
COPY requirements.txt /tmp/
RUN pip install -r /tmp/requirements.txt

# configuramos
COPY app.conf /etc/nginx/sites-available/
COPY supervisor.conf /etc/supervisor/conf.d/

RUN echo "daemon off;" >> /etc/nginx/nginx.conf && \
	rm /etc/nginx/sites-enabled/default && \
	ln -s /etc/nginx/sites-available/app.conf /etc/nginx/sites-enabled/

# agregamos la app al contenedor
COPY ./project2 /prod/project2

# agregamos un script para solucionar el siguiente problema
# https://docs.docker.com/compose/startup-order/
COPY ./wait-for-it.sh /

RUN chmod +x /wait-for-it.sh

EXPOSE 80

CMD ["supervisord", "-n"]
