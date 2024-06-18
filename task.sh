#! /bin/bash

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB --result-file=ShopDBReserve.sql
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB --no-create-info --result-file=ShopDBDevelopment.sql

mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < ShopDBReserve.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < ShopDBDevelopment.sql
