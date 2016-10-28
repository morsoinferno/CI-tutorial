FROM python:2.7

# install pip
RUN apt-get update && apt-get install -y python-pip

# upgrade pip
RUN pip install --upgrade pip

ADD compile.sh /tmp/compile.sh
CMD /tmp/compile.sh