#!/bin/bash

docker start dev_db_mysql

path=$(readlink -f $(dirname ../run_spring-app.sh))

MYSQL_ROOT_PASSWORD=$(cat $path/.env | grep MYSQL_ROOT_PASSWORD | cut -d '=' -f 2) \
MYSQL_DATABASE=$(cat $path/.env | grep MYSQL_DATABASE | cut -d '=' -f 2) \
MYSQL_USER=$(cat $path/.env | grep MYSQL_USER | cut -d '=' -f 2) \
MYSQL_PASSWORD=$(cat $path/.env | grep MYSQL_PASSWORD | cut -d '=' -f 2) \
MYSQL_PORT=$(cat $path/.env | grep MYSQL_PORT | cut -d '=' -f 2) \
  "./mvnw" spring-boot:run -f "./pom.xml"

# como paro um container de docker que subiu pelo compose up sem remover o container?
# - docker-compose stop
# como listo os containers que estão rodando no docker-compose?
# - docker-compose ps
