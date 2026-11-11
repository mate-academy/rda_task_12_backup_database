#! /bin/bash
set -euo pipefail
DB_USER="${DB_USER:?DB_USER is not set}"
DB_PASSWORD="${DB_PASSWORD:?DB_PASSWORD is not set}"

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB > shopdb_full.sql

mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < shopdb_full.sql

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --no-create-info --insert-ignore ShopDB > shopdb_data.sql

mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < shopdb_data.sql
