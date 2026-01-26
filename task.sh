#! /bin/bash

read DB_USER
read DB_PASSWORD

mysqldump -u $DB_USER -p$DB_PASSWORD ShopDB --no-create-db --result-file=backup_for_reserve.sql
mysql -u $DB_USER -p$DB_PASSWORD ShopDBReserve < backup_for_reserve.sql

mysqldump -u $DB_USER -p$DB_PASSWORD ShopDB --no-create-db --no-create-info --result-file=backup_for_developers.sql
mysql -u $DB_USER -p$DB_PASSWORD ShopDBDevelopment < backup_for_developers.sql