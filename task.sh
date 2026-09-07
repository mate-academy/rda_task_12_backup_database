#! /bin/bash
set -e

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB > backup.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < backup.sql

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --no-create-info ShopDB > data_backup.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < data_backup.sql

rm -f backup.sql data_backup.sql