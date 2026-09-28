#! /bin/bash

set -euo pipefail

if [[ -z "${DB_USER:-}" || -z "${DB_PASSWORD:-}" ]]; then
  echo "Error: DB_USER and DB_PASSWORD environment variables must be set." >&2
  exit 1
fi

DB_HOST="${DB_HOST:-localhost}"

export MYSQL_PWD="${DB_PASSWORD}"

mysqldump -h "${DB_HOST}" -u "${DB_USER}" --single-transaction ShopDB | \
mysql -h "${DB_HOST}" -u "${DB_USER}" ShopDBReserve

mysqldump -h "${DB_HOST}" -u "${DB_USER}" --no-create-info --single-transaction ShopDB | \
mysql -h "${DB_HOST}" -u "${DB_USER}" ShopDBDevelopment

unset MYSQL_PWD