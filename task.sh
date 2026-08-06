#!/bin/bash

: "${DB_USER:?переменная DB_USER не задана}"
: "${DB_PASSWORD:?переменная DB_PASSWORD не задана}"

# Часть 1: полный бэкап ShopDB -> восстановление в ShopDBReserve
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB | mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve

# Часть 2: перенос только данных ShopDB -> ShopDBDevelopment
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --no-create-info --insert-ignore ShopDB | mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment