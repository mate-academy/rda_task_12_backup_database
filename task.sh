#!/bin/bash

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB > /tmp/shopdb_full_backup.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < /tmp/shopdb_full_backup.sql

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --no-create-info ShopDB > /tmp/shopdb_data_backup.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < /tmp/shopdb_data_backup.sql
