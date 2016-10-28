#!/bin/bash

set -e

# seteamos el directorio donde esperamos encontrar el codigo
cd /dev/${PROJECT_NAME}
echo $PWD
ls -l
# agregamos las dependencias
echo "Downloading dependencies..."
pip install -r requirements.txt

# corremos los test y code coverage
echo "Running tests and code coverage..."
nosetests --with-coverage --cover-package=${PROJECT_NAME} --cover-erase

# corremos code quality
echo "Running code quality..."
pylint -r n ${PROJECT_NAME}