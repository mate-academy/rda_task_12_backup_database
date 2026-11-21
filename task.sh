#! /bin/bash

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB --result-file=backup.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < backup.sql

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB --no-create-info --skip-triggers --result-file=data.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < data.sql