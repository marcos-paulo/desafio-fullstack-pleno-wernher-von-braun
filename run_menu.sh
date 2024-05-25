#!/bin/bash

# LISTA DE VARIÁVEIS GLOBAIS QUE PODEM SER DEFINIDAS EXTERNAMENTE NO SCRIPT QUE CHAMA O MENU
# lista_menu - variável que armazena a lista de itens do menu
# menu_selecionado - variável que armazena o item selecionado pelo usuário para ser o item que ja vem selecionado quando o menu é aberto
# opcao_escolhida - variável que armazena a opção escolhida pelo usuário

function print_highlighted_line() {
  local text="$1"
  echo -e "\e[48;5;226m$text\e[0m" # Código ANSI para fundo destacado (cor amarela)
}

function mostrar_menu() {
  opcao_escolhida=""
  local indice=0
  local indice_max=$((${#lista_menu[@]} - 1))

  function imprimir_menu() {
    if [ "$1" = "up" ]; then
      indice=$(($indice - 1))
    elif [ "$1" = "down" ]; then
      indice=$(($indice + 1))
    else
      indice=0
    fi

    if [ $indice -lt 0 ]; then
      indice=0
    elif [ $indice -gt $indice_max ]; then
      indice=$indice_max
    fi

    if [ "$menu_selecionado" ]; then
      item_selecionado=$menu_selecionado
      menu_selecionado=""
    else
      item_selecionado=${lista_menu[$indice]}
    fi

    tput cuu ${#lista_menu[@]}
    local i=0
    for item in ${lista_menu[@]}; do
      if [ "$item" = "$item_selecionado" ]; then
        print_highlighted_line $item
        indice=$i
      else
        echo $item
      fi
      i=$(($i + 1))
    done
  }

  clear
  imprimir_menu

  local key=""

  while true; do
    read -rsn1 char

    if [[ "$char" == "" ]]; then
      # Quando o usuário pressionar ENTER ou SPACE, a opção escolhida é a que está selecionada
      clear
      opcao_escolhida=${item_selecionado}
      break
    fi

    # Adiciona o caractere à sequência
    local key="${key}${char}"

    if [[ "$key" == $'\033[A' ]]; then
      # Adicione aqui o código que vai ser executado quando a tecla para cima for pressionada
      imprimir_menu "up"
      key=""
    elif [[ "$key" == $'\033[B' ]]; then
      # Adicione aqui o código que vai ser executado quando a tecla para baixo for pressionada
      imprimir_menu "down"
      key=""
    elif [[ "$char" == $'\033' ]]; then
      # limpa $key toda vez que $char for \033
      key="${char}"
    elif [[ "${key:0:1}" == $'\033' ]]; then
      # não faz nada enquanto o primeiro caractere de $key for \033
      key=$key
    else
      # Quando nenhuma das condições acima for satisfeita, significa que o
      # usuário pressionou uma tecla que não é de navegação então limpa $key
      # para que o usuário possa pressionar outra tecla
      key=""
    fi
  done
}
