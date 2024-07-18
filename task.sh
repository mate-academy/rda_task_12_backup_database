#! /bin/bash

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB --no-create-db --result-file=ShopDB-full-no-create-db-backup.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < ShopDB-full-no-create-db-backup.sql

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB --no-create-db --no-create-info --result-file=ShopDB-no-create-db-and-info-backup.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < ShopDB-no-create-db-and-info-backup.sql
