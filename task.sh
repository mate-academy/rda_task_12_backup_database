#! /bin/bash

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB --no-create-db --result-file=backup.sql

mysql -u "$DB_USER" -p"$DB_PASSWORD"  ShopDBReserve < backup.sql

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB --no-create-info --result-file=backup-noschema.sql

mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < backup-noschema.sql
