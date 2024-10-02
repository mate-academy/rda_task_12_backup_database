#! /bin/bash
USER=$DB_USER
PASSWORD=$DB_PASSWORD

mysqldump -u"$USER" -p"$PASSWORD" ShopDB --no-create-db --result-file=backup-ShopDBReserve.sql
mysql -u "$USER" -p"$PASSWORD" ShopDBReserve < backup-ShopDBReserve.sql

mysqldump -u"$USER" -p"$PASSWORD" ShopDB --no-create-db --no-create-info --result-file=backup-ShopDBDevelopment.sql
mysql -u "$USER" -p"$PASSWORD" ShopDBDevelopment < backup-ShopDBDevelopment.sql
