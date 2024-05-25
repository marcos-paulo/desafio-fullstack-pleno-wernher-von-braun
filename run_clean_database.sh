#!/bin/bash
path=$(readlink -f $(dirname $0))

docker stop dev_db_mysql

docker compose --file "$path/docker-compose.dev.yml" --project-name 'desafio-fullstack-pleno-wernher-von-braun' down

sudo rm -rfv $path/db_data/*

docker compose -f "$path/docker-compose.dev.yml" up -d --build dev_db

# docker start dev_db_mysql

# como paro um container de docker que subiu pelo compose up sem remover o container?
# - docker-compose stop
# como listo os containers que estão rodando no docker-compose?
# - docker-compose ps
