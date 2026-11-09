#! /bin/bash

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB > backup.sql;
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < backup.sql;

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --no-create-info ShopDB > backup_develop.sql;
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < backup_develop.sql;