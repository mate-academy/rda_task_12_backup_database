#! /bin/bash

USER=$DB_USER
PASSWORD=$DB_PASSWORD



mysqldump -u "$USER" -p"$PASSWORD" ShopDB --no-create-db --result-file=backup-db.sql
mysql -u "$USER" -p"$PASSWORD" ShopDBReserve < backup-db.sql

mysqldump -u "$USER" -p"$PASSWORD" ShopDB --no-create-db --no-create-info --result-file=backup-create.sql
mysql -u "$USER" -p"$PASSWORD" ShopDBDevelopment < backup-create.sql
