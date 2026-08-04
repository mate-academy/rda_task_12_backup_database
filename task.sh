#! /bin/bash

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB > backup.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < backup.sql

mysqldump --no-create-info -u "$DB_USER" -p"$DB_PASSWORD" ShopDB > data.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < data.sql
