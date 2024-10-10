#! /bin/bash

USER=$DB_USER
PASSWORD=$DB_PASSWORD

mysqldump -u "$USER" -p"$PASSWORD" --no-create-db ShopDB | \
mysql -u "$USER" -p"$PASSWORD" ShopDBReserve

mysqldump -u "$USER" -p"$PASSWORD" --no-create-db --no-create-info ShopDB | \
mysql -u "$USER" -p"$PASSWORD" ShopDBDevelopment
