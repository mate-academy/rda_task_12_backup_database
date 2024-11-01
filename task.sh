#!/bin/bash

USER=$DB_USER
PASSWORD=$DB_PASSWORD

mysqldump -u"$USER" -p"$PASSWORD" ShopDB --no-create-db --result-file=ShopDB_backup.sql
mysql -u "$USER" -p"$PASSWORD" ShopDBReserve < ShopDB_backup.sql

mysqldump -u"$USER" -p"$PASSWORD" --no-create-db --no-create-info ShopDB --result-file=ShopDBDevelopment_data_backup.sql

mysql -u "$USER" -p"$PASSWORD" ShopDBDevelopment < ShopDBDevelopment_data_backup.sql
