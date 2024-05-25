#!/bin/bash

path=$(readlink -f $(dirname $0))

MYSQL_ROOT_PASSWORD=$(cat $path/.env | grep MYSQL_ROOT_PASSWORD | cut -d '=' -f 2)
MYSQL_DATABASE=$(cat $path/.env | grep MYSQL_DATABASE | cut -d '=' -f 2)
MYSQL_USER=$(cat $path/.env | grep MYSQL_USER | cut -d '=' -f 2)
MYSQL_PASSWORD=$(cat $path/.env | grep MYSQL_PASSWORD | cut -d '=' -f 2)
MYSQL_HOST=$(cat $path/.env | grep MYSQL_HOST | cut -d '=' -f 2)
MYSQL_PORT=$(cat $path/.env | grep MYSQL_PORT | cut -d '=' -f 2)

function inerir_dados_tabelas() {
  mysql \
    -h $MYSQL_HOST \
    -P $MYSQL_PORT \
    -u root \
    --password=$MYSQL_ROOT_PASSWORD \
    $MYSQL_DATABASE \
    <$path/iot-manager-api/src/main/resources/db/migration/V02__inserir_dados_tabelas.sql
}

function criar_tabelas() {
  mysql \
    -h $MYSQL_HOST \
    -P $MYSQL_PORT \
    -u root \
    --password=$MYSQL_ROOT_PASSWORD \
    $MYSQL_DATABASE \
    <$path/iot-manager-api/src/main/resources/db/migration/V01__criar_tabelas.sql
}

function dropar_tabelas() {
  dropConstraints=$(
    mysql \
      -h $MYSQL_HOST \
      -P $MYSQL_PORT \
      -u root \
      --password=$MYSQL_ROOT_PASSWORD \
      $MYSQL_DATABASE \
      <<EOF
        SELECT
          CONCAT(
            'ALTER TABLE ',
            table_name,
            ' DROP FOREIGN KEY ',
            constraint_name,
            ';'
          ) AS 'query'
        FROM (
          SELECT
            table_name,
            constraint_name
          FROM
            information_schema.referential_constraints
          WHERE
            constraint_schema = 'iot_manager_api'
        ) AS subquery;
EOF
  )

  query=$(echo -e $dropConstraints | sed -E 's/query//g')

  if [ -n "$query" ]; then
    mysql \
      -h $MYSQL_HOST \
      -P $MYSQL_PORT \
      -u root \
      --password=$MYSQL_ROOT_PASSWORD \
      $MYSQL_DATABASE \
      -e "$query"
  fi

  mysql \
    -h $MYSQL_HOST \
    -P $MYSQL_PORT \
    -u root \
    --password=$MYSQL_ROOT_PASSWORD \
    $MYSQL_DATABASE \
    <<EOF
      DROP TABLE if exists parameter;
      DROP TABLE if exists command;
      DROP TABLE if exists command_description;
      DROP TABLE if exists device;
      DROP TABLE if exists flyway_schema_history;
EOF
}

. $path/run_menu.sh
lista_menu=($(cat $0 | grep -E '^function' | cut -d ' ' -f 2 | sed -E 's/\(\)//g'))
mostrar_menu
$opcao_escolhida
