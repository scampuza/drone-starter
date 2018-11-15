#!/bin/sh
docker-compose --file docker-compose.yml rm -f # remove old containers
docker-compose --file docker-compose.yml up --build -d

echo "Inspecting exited containers:"
docker-compose --file docker-compose.yml ps
docker-compose --file docker-compose.yml ps -q | xargs docker inspect -f '{{ .State.ExitCode }}' | while read code; do
    if [ "$code" != "0" ]; then
       exit $code
    fi
done
