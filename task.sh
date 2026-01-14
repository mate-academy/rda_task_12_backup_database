#! /bin/bash
read DB_USER
read DB_PASSWORD

mysqldump -u $DB_USER -p$DB_PASSWORD ShopDB > ShopDB.sql
mysql -u $DB_USER -p$DB_PASSWORD ShopDBReserve < ShopDB.sql

mysqldump -u $DB_USER -p$DB_PASSWORD --no-create-db --no-create-info ShopDB > ShopDB-data.sql
mysql -u $DB_USER -p$DB_PASSWORD ShopDBDevelopment < ShopDB-data.sql