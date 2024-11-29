#! /bin/bash

USER=$DB_USER
PASSWORD=$DB_PASSWORD

mysqldump -u"$USER" -p"$PASSWORD" ShopDB --no-create-db --result-file=shopdb_full_backup.sql
mysql -u "$USER" -p"$PASSWORD" ShopDBReserve < shopdb_full_backup.sql

mysqldump -u"$USER" -p"$PASSWORD" --no-create-db --no-create-info ShopDB --result-file=shopdb_data_backup.sql
mysql -u "$USER" -p"$PASSWORD" ShopDBDevelopment < shopdb_data_backup.sql
