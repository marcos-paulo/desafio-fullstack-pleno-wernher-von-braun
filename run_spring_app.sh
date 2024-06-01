#!/bin/bash
path=$(readlink -f $(dirname $0))

inicializar_variaveis() {
  CONTEXTO_SELECIONADO="./docker/dev"
  # variaveis de ambiente em arquivo .env terão precedencia sobre variaveis de ambiente
  LOCAL_COMPOSE_PROJECT_NAME=$(cat "$path/$CONTEXTO_SELECIONADO/.env" | grep "COMPOSE_PROJECT_NAME" | cut -d "=" -f 2 | xargs)
  LOCAL_COMPOSE_PROJECT_NAME=${LOCAL_COMPOSE_PROJECT_NAME:-$COMPOSE_PROJECT_NAME}

  if [ -z "$LOCAL_COMPOSE_PROJECT_NAME" ]; then
    echo "COMPOSE_PROJECT_NAME não está definido como variável de ambiente. Defina em $CONTEXTO_SELECIONADO/.env"
    exit 1
  fi

  log_file="$path/.logs/$LOCAL_COMPOSE_PROJECT_NAME.log"
  compose_file="$path/$CONTEXTO_SELECIONADO/docker-compose.yml"

  mkdir -p "$path/$CONTEXTO_SELECIONADO/.logs"
}

inicializar_variaveis

function clear_target() {
  rm -rfv "$path/iot-manager-api/target"

  read -rsn1 char
  exibir_menu
}

function up_dev_db_mysql() {
  docker compose -f "$compose_file" up -d --build db

  read -rsn1 char
  exibir_menu
}

function down_dev_db_mysql() {
  docker compose -f "$compose_file" down

  read -rsn1 char
  exibir_menu
}

function start_dev_db_mysql() {
  container_db_up=$(docker container ls | grep dev_db_mysql | grep Up)
  if [ -z "$container_db_up" ]; then
    docker start dev_db_mysql
  fi

  read -rsn1 char
  exibir_menu
}

function stop_dev_db_mysql() {
  container_db_up=$(docker container ls | grep dev_db_mysql | grep Up)
  if [ -n "$container_db_up" ]; then
    docker stop dev_db_mysql
  fi

  read -rsn1 char
  exibir_menu
}

function start_firefox() {
  firefox -p "default-release" "http://localhost:8080/swagger-ui.html" &

  read -rsn1 char
  exibir_menu
}

# "/home/marcos/desenv/desafios-tecnicos/desafio-fullstack-pleno-wernher-von-braun/iot-manager-api/mvnw" clean -f "/home/marcos/desenv/desafios-tecnicos/desafio-fullstack-pleno-wernher-von-braun/iot-manager-api/pom.xml"

function run_spring_app() {
  env_path="$path/docker/dev/.env"

  export MYSQL_ROOT_PASSWORD=$(cat $env_path | grep MYSQL_ROOT_PASSWORD | cut -d '=' -f 2)
  export MYSQL_DATABASE=$(cat $env_path | grep MYSQL_DATABASE | cut -d '=' -f 2)
  export MYSQL_USER=$(cat $env_path | grep MYSQL_USER | cut -d '=' -f 2)
  export MYSQL_PASSWORD=$(cat $env_path | grep MYSQL_PASSWORD | cut -d '=' -f 2)
  export MYSQL_HOST=$(cat $env_path | grep MYSQL_HOST | cut -d '=' -f 2)
  export MYSQL_PORT=$(cat $env_path | grep MYSQL_PORT | cut -d '=' -f 2)
  # "$path/iot-manager-api/mvnw" clean package -f "$path/iot-manager-api/pom.xml"
  "$path/iot-manager-api/mvnw" clean spring-boot:run -f "$path/iot-manager-api/pom.xml"
  read -rsn1 char
  exibir_menu
}

function sair() {
  clear
  exit 0
}

exibir_menu() {
  . $path/run_menu.sh
  lista_menu=($(cat $0 | grep -E '^function' | cut -d ' ' -f 2 | sed -E 's/\(\)//g'))
  titulo_menu="SPRING BOOT APP DESENVOVIMENTO"
  menu_selecionado="$ITEM_SELECIONADO"
  mostrar_menu
  ITEM_SELECIONADO=$opcao_escolhida
  $opcao_escolhida
}

exibir_menu
