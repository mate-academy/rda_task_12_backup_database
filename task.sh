#! /bin/bash

mysqldump --no-tablespaces -u "$DB_USER" -p"$DB_PASSWORD" ShopDB | mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve

mysqldump --no-tablespaces --no-create-info -u "$DB_USER" -p"$DB_PASSWORD" ShopDB | mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment
