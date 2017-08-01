#!/bin/bash

function quit {
	docker-compose stop
	docker-compose rm -f -v --all
	exit $1
}

docker-compose up -d

# Make sure containers are ready for the test
sleep 40

# OS X (Darwin) o Linux
if [ "$(uname -s)" = "Darwin" ] ; then
	service_ip=$(boot2docker ip)
else 
	service_container=$(docker ps -a | awk {}'{ print $1,$2 }' | grep morsoinferno/prueba:0.1 | awk '{print $1 }')
	service_ip=$(docker inspect -f '{{ .NetworkSettings.IPAddress }}' ${service_container})
fi

echo "Using Service IP $service_ip"

query=$(curl -i -silent -X GET ${service_ip}/api/v0.1/tasks | grep "HTTP/1.1")

status_query=$(echo "$query" | cut -f 2 -d ' ')

if [[ "$status_query" -ne 200 ]]; then
	echo "${status_query}"
	echo "Fail: Se esperaba status 200 (OK) para la lista de tasks desde ${service_ip}"
	quit 1
else
	echo "Pass: lista de Tasks"
fi

quit 0
