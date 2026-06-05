#! /bin/bash

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --skip-add-drop-table ShopDB --result-file=ShopDBReserve_backup.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < ShopDBReserve_backup.sql

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --skip-add-drop-table --no-create-info ShopDB --result-file=ShopDBDevelopment_backup.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < ShopDBDevelopment_backup.sql
