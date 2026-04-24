#! /bin/bash

DB_USER="$DB_USER"
DB_PASSWORD="$DB_PASSWORD"

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --no-create-db ShopDB > full_backup.sql

mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < full_backup.sql

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --no-create-db --no-create-info ShopDB > data_backup.sql

mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < data_backup.sql
