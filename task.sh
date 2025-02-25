#! /bin/bash

if [[ -z "$DB_USER" || -z "$DB_PASSWORD" ]]; then
    echo "Error: Database credentials not set. Please export DB_USER and DB_PASSWORD." >&2
    exit 1
fi


mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --databases ShopDB > shopdb_backup.sql

mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < shopdb_backup.sql


mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --no-create-info ShopDB > shopdb_data_backup.sql

mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < shopdb_data_backup.sql