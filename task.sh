#!/usr/bin/env bash

set -euo pipefail

# Read credentials from environment variables (required by the task)
DB_USER="${DB_USER:?DB_USER is not set}"
DB_PASSWORD="${DB_PASSWORD:?DB_PASSWORD is not set}"

SOURCE_DB="ShopDB"
RESERVE_DB="ShopDBReserve"
DEVELOPMENT_DB="ShopDBDevelopment"

MYSQL_AUTH=(-u"${DB_USER}" -p"${DB_PASSWORD}")

# 1) Full backup from production and restore to reserve
mysqldump "${MYSQL_AUTH[@]}" "${SOURCE_DB}" | mysql "${MYSQL_AUTH[@]}" "${RESERVE_DB}"

# 2) Data-only backup from production and restore to development (without schema)
mysqldump "${MYSQL_AUTH[@]}" --no-create-info --skip-triggers "${SOURCE_DB}" \
  | mysql "${MYSQL_AUTH[@]}" "${DEVELOPMENT_DB}"
