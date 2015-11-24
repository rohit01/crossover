#!/usr/bin/env bash
#
# Script to install and MyBB Forum.
#

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${SCRIPT_DIR}/mybb/"

DATABASE="${1}"
DB_TABLE_PREFIX="${2}"
DB_HOSTNAME="${3}"
DB_USER="${4}"
DB_PASSWORD="${5}"
MYBB_URL="${6}"

sed -i "s/REPLACE_WITH_DATABASE/${DATABASE}/g" ./inc/config.php
sed -i "s/REPLACE_WITH_DB_TABLE_PREFIX/${DB_TABLE_PREFIX}/g" ./inc/config.php
sed -i "s/REPLACE_WITH_DB_HOSTNAME/${DB_HOSTNAME}/g" ./inc/config.php
sed -i "s/REPLACE_WITH_DB_USER/${DB_USER}/g" ./inc/config.php
sed -i "s/REPLACE_WITH_DB_PASSWORD/${DB_PASSWORD}/g" ./inc/config.php

chmod 666 ./inc/settings.php
chmod 666 ./inc/config.php
chmod 666 ./inc/languages/english/*
chmod 666 ./inc/languages/english/admin/*
chmod 777 ./cache/
chmod 777 ./cache/themes/
chmod 777 ./uploads/
chmod 777 ./uploads/avatars/
chmod 777 ./admin/backups/ 

cd "${SCRIPT_DIR}/"
sed -i "s/REPLACE_WITH_MYBB_URL/${MYBB_URL}/g" ./mybb_initdb.sql
mysql -u "${DB_USER}" -h "${DB_HOSTNAME}" -p"${DB_PASSWORD}" "${DATABASE}" < mybb_initdb.sql 2>/dev/null || echo "DB already initialized. Ignoring import errors"
