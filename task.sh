#! /bin/bash

mysqldump -u $DB_USER -p$DB_PASSWORD ShopDB --no-create-db > backup_1.sql
mysql -u $DB_USER -p$DB_PASSWORD ShopDBReserve < backup_1.sql

mysqldump -u $DB_USER -p$DB_PASSWORD ShopDB --no-create-info --result-file=backup_2.sql
mysql -u $DB_USER -p$DB_PASSWORD ShopDBDevelopment < backup_2.sql
