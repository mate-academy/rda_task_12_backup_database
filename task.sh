#! /bin/bash

DB_USER=$DB_USER
DB_PASSWORD=$DB_PASSWORD

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB --no-create-db --result-file=backup.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < backup.sql

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB --no-create-db --no-create-info --result-file=backup-no-create-db.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < backup-no-create-db.sql
