#!/bin/bash

# docker stop dev_db_mysql

# docker compose --file '/home/marcos/desenv/desafios-tecnicos/desafio-fullstack-pleno-wernher-von-braun/docker-compose.dev.yml' --project-name 'desafio-fullstack-pleno-wernher-von-braun' down

# sudo rm -rfv ./db_data/*

# docker compose -f "docker-compose.dev.yml" up -d --build dev_db

container_db_up=$(docker compose ps | grep dev_db_mysql | grep Up)
if [ -z "$container_db_up" ]; then
  # docker compose -f "docker-compose.dev.yml" up -d --build dev_db_mysql
  docker start dev_db_mysql
fi

if [ "$1" == "-f" ]; then
  firefox -p "default-release" "http://localhost:8080/swagger-ui.html" &
fi

path=$(readlink -f $(dirname $0))

# rm -rfv "$path/iot-manager-api/target"

# "/home/marcos/desenv/desafios-tecnicos/desafio-fullstack-pleno-wernher-von-braun/iot-manager-api/mvnw" clean -f "/home/marcos/desenv/desafios-tecnicos/desafio-fullstack-pleno-wernher-von-braun/iot-manager-api/pom.xml"

export MYSQL_ROOT_PASSWORD=$(cat $path/.env | grep MYSQL_ROOT_PASSWORD | cut -d '=' -f 2)
export MYSQL_DATABASE=$(cat $path/.env | grep MYSQL_DATABASE | cut -d '=' -f 2)
export MYSQL_USER=$(cat $path/.env | grep MYSQL_USER | cut -d '=' -f 2)
export MYSQL_PASSWORD=$(cat $path/.env | grep MYSQL_PASSWORD | cut -d '=' -f 2)
export MYSQL_HOST=$(cat $path/.env | grep MYSQL_HOST | cut -d '=' -f 2)
export MYSQL_PORT=$(cat $path/.env | grep MYSQL_PORT | cut -d '=' -f 2)
"$path/iot-manager-api/mvnw" clean spring-boot:run -f "$path/iot-manager-api/pom.xml"

# como paro um container de docker que subiu pelo compose up sem remover o container?
# - docker-compose stop
# como listo os containers que estão rodando no docker-compose?
# - docker-compose ps