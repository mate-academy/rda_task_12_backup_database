#!/bin/bash
# Read environment
USER=$DB_USER
PASSWORD=$DB_PASSWORD
# Backp ShopDB
mysqldump -u "$USER" -p"$PASSWORD" ShopDB --result-file=ShopDB_backup.sql;
# Restory ShopDB to ShopDBReserve
mysql -u "$USER" -p"$PASSWORD"  ShopDBReserve < ShopDB_backup.sql;
# Backup data from ShopDB
mysqldump -u "$USER" -p"$PASSWORD" ShopDB --no-create-info --result-file=ShopDB_no_create.sql;
# Restore date to ShopDBDevelopment
mysql -u "$USER" -p"$PASSWORD"  ShopDBDevelopment < ShopDB_no_create.sql;
