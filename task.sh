#! /bin/bash

username="${DB_USER}"
password="${DB_PASSWORD}"

mysqldump -u"$username" -p"$password" ShopDB > shopdb_full.sql
mysql -u"$username" -p"$password" ShopDBReserve < shopdb_full.sql
mysqldump -u"$username" -p"$password" --no-create-info ShopDB > shopdb_data.sql
mysql -u"$username" -p"$password" ShopDBDevelopment < shopdb_data.sql