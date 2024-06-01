#!/bin/bash
path=$(readlink -f $(dirname $0))

inicializar_variaveis() {
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

function compose_up() {
  docker compose -f "$compose_file" up -d >"$log_file" 2>&1 &&
    pgrep -f "tail.*$LOCAL_COMPOSE_PROJECT_NAME" | xargs -r kill -9 >/dev/null 2>&1 ||
    pgrep -f "tail.*$LOCAL_COMPOSE_PROJECT_NAME" | xargs -r kill -9 >/dev/null 2>&1 &

  tail -f "$log_file"

  sleep 2
  exibir_menu
}

function compose_down() {
  docker compose -f "$compose_file" down

  sleep 2
  exibir_menu
}

function remove_images() {
  docker images |
    grep ${LOCAL_COMPOSE_PROJECT_NAME} |
    awk '{print $3}' |
    xargs -r docker rmi

  sleep 5
  exibir_menu
}

function verificar_espaco_utilizado_docker() {
  docker system df

  sleep 5
  exibir_menu
}

function limpar_docker() {
  docker system prune -a

  sleep 2
  exibir_menu
}

# docker bulder prune --all
function limpar_docker_builder() {
  docker builder prune --all

  sleep 2
  exibir_menu
}

function alterar_contexto() {
  exibir_menu_docker_compose
}

function sair() {
  clear
  exit 0
}

. $path/run_menu.sh

exibir_menu() {
  titulo_menu="Docker Compose - $LOCAL_COMPOSE_PROJECT_NAME"
  lista_menu=($(cat $0 | grep -E '^function' | cut -d ' ' -f 2 | sed -E 's/\(\)//g'))
  menu_selecionado=$ITEM_MENU_DOCKER_SELECIONADO
  mostrar_menu
  ITEM_MENU_DOCKER_SELECIONADO=$opcao_escolhida
  $opcao_escolhida

}

exibir_menu_docker_compose() {
  titulo_menu="Docker Compose"
  lista_menu=($(find ./docker -type f -name "docker-compose.*" -exec dirname {} \;))
  menu_selecionado=$CONTEXTO_SELECIONADO
  mostrar_menu
  CONTEXTO_SELECIONADO=$opcao_escolhida

  inicializar_variaveis
  exibir_menu
}

exibir_menu_docker_compose
