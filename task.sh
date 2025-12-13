#! /bin/bash

# create full backup 
mysqldump -u $DB_USER -p$DB_PASSWORD ShopDB --result-file=ShopDBFullBackup.sql

# create data backup
mysqldump -u $DB_USER -p$DB_PASSWORD ShopDB --no-create-info --result-file=ShopDBDataBackup.sql


# restoref full backup to ShopDBReserve
mysql -u $DB_USER -p$DB_PASSWORD ShopDBReserve < ShopDBFullBackup.sql

# restore data backup to ShopDBDevelopment
mysql -u $DB_USER -p$DB_PASSWORD ShopDBDevelopment < ShopDBDataBackup.sql
