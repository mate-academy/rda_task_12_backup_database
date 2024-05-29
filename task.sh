#! /bin/bash

mysqldump -u $DB_USER -p$DB_PASSWORD ShopDB --no-create-db --result-file=bkup_ShopDB.sql

mysql -u $DB_USER -p$DB_PASSWORD ShopDBReserve < bkup_ShopDB.sql

mysqldump -u $DB_USER -p$DB_PASSWORD ShopDB --no-create-db --no-create-info --result-file=bkup_ShopDBDevelopment.sql

mysql -u $DB_USER -p$DB_PASSWORD ShopDBDevelopment < bkup_ShopDBDevelopment.sql
