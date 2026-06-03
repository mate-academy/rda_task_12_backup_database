#! /bin/bash

DB_USER=$1
export DB_PASSWORD=$2

mysqldump -u "$DB_USER" ShopDB | mysql -u "$DB_USER" ShopDBReserve
mysqldump -u "$DB_USER" --no-create-info ShopDB | mysql -u "$DB_USER" ShopDBDevelopment