#! /bin/bash

mysqldump -u $DB_USER -p$DB_PASSWORD ShopDB --no-create-db --result-file=backup.sql
mysql -u $DB_USER -p$DB_PASSWORD ShopDBReserve < backup.sql

mysqldump -u $DB_USER -p$DB_PASSWORD ShopDB --no-create-db --no-create-info --result-file=backupdev.sql
mysql -u $DB_USER -p$DB_PASSWORD ShopDBDevelopment < backupdev.sql