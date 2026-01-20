#! /bin/bash
mysqldump -u $DB_USER -p$DB_PASSWORD ShopDB --result-file=ShopDB_full_backup.sql
mysql -u $DB_USER -p$DB_PASSWORD ShopDBReserve < ShopDB_full_backup.sql

mysqldump -u $DB_USER -p$DB_PASSWORD ShopDB --result-file=ShopDB_no_data_backup.sql --no-create-info --replace
mysql -u $DB_USER -p$DB_PASSWORD ShopDBDevelopment < ShopDB_no_data_backup.sql


