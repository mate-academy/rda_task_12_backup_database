#! /bin/bash
set -x
DB_USER="$DB_USER"
DB_PASSWORD="$DB_PASSWORD"

mysqldump -u"$DB_USER" -p"$DB_PASSWORD" ShopDB | mysql -u"$DB_USER" -p"$DB_PASSWORD" ShopDBReserve

mysqldump -u"$DB_USER" -p"$DB_PASSWORD" --no-data ShopDB | mysql -u"$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment

mysqldump -u"$DB_USER" -p"$DB_PASSWORD" --no-create-info ShopDB | mysql -u"$DB_USER" -p"$DB_PASSWORD"
