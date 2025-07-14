#!/bin/bash

set -euo pipefail

: "${DB_USER:?Error: DB_USER is not set}"
: "${DB_PASSWORD:?Error: DB_PASSWORD is not set}"

DB_USER_LOCAL="$DB_USER"
DB_PASSWORD_LOCAL="$DB_PASSWORD"

echo "=== Creating the full backup for ShopDB database as $DB_USER_LOCAL and restoring to the ShopDBReserve ==="
mysqldump -u "$DB_USER_LOCAL" -p"$DB_PASSWORD_LOCAL" ShopDB --no-create-db --result-file=ShopDB_full_backup.sql

mysql -u "$DB_USER_LOCAL" -p"$DB_PASSWORD_LOCAL" -e "CREATE DATABASE IF NOT EXISTS ShopDBReserve;"

mysql -u "$DB_USER_LOCAL" -p"$DB_PASSWORD_LOCAL" ShopDBReserve < ShopDB_full_backup.sql

echo "=== Full backup restoring finished ==="

echo "=== Creating the data backup for ShopDB database as $DB_USER_LOCAL and restoring to the ShopDBDevelopment ==="
mysqldump -u "$DB_USER_LOCAL" -p"$DB_PASSWORD_LOCAL" ShopDB --no-create-db --no-create-info --result-file=ShopDB_data_backup.sql

mysql -u "$DB_USER_LOCAL" -p"$DB_PASSWORD_LOCAL" -e "CREATE DATABASE IF NOT EXISTS ShopDBDevelopment;"

mysql -u "$DB_USER_LOCAL" -p"$DB_PASSWORD_LOCAL" ShopDBDevelopment < ShopDB_data_backup.sql

echo "=== Data backup restoring finished ==="
