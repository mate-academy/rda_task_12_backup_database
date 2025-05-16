#! /bin/bash

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB > /tmp/shopdb_full.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" -e "DROP DATABASE IF EXISTS ShopDBReserve; CREATE DATABASE ShopDBReserve;"
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < /tmp/shopdb_full.sql

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --no-create-info ShopDB > /tmp/shopdb_data.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < /tmp/shopdb_data.sql
