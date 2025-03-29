#!/bin/bash
set -e

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB | mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve
mysqldump --no-create-info -u "$DB_USER" -p"$DB_PASSWORD" ShopDB | mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment
