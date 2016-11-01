FROM ubuntu:16.04

# install pip
RUN apt-get update && \
    apt-get install -y --no-install-recommends python-pip \
                                               python-dev \
                                               python-setuptools \
                                               build-essential \
                                               upstart \
                                               libmysqlclient-dev \
                                               nginx \
                                               && \
	rm -rf /var/lib/apt/list/* 

# upgrade pip
RUN pip install --upgrade pip

ADD package.sh /tmp/package.sh
ADD wsgi.py /tmp/wsgi.py
ADD example.ini /tmp/example.ini
ADD example.conf /tmp/example.conf
ADD example /tmp/example

EXPOSE 8080

CMD /tmp/package.sh