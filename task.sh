#! /bin/bash
USER=$DB_USER
PASSWORD=$DB_PASSWORD

mysqldump -u "$USER" -p"$PASSWORD" ShopDB --no-create-db --result-file=backup-ShopDB.sql
mysql -u "$USER" -p"$PASSWORD" ShopDBReserve < backup-ShopDB.sql

mysqldump -u "$USER" -p"$PASSWORD" ShopDB --no-create-db --no-create-info --result-file=backup-no-data.sql
mysql -u "$USER" -p"$PASSWORD" ShopDBDevelopment < backup-no-data.sql
