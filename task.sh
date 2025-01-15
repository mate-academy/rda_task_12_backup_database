#! /bin/bash

mysqldump -u $DB_USER -p$DB_PASSWORD ShopDB --no-create-db --result-file=backup-ShopDB_full.sql
mysql -u $DB_USER -p$DB_PASSWORD  ShopDBReserve < backup-ShopDB_full.sql
mysqldump -u $DB_USER -p$DB_PASSWORD ShopDB --no-create-db --no-create-info --result-file=backup-ShopDB_data.sql
mysql -u $DB_USER -p$DB_PASSWORD  ShopDBDevelopment < backup-ShopDB_data.sql
