#! /bin/bash


DB_USER="${DB_USER}"
DB_PASSWORD="${DB_PASSWORD}"


mysqldump \
    -u "$DB_USER" \
    -p"$DB_PASSWORD" \
    ShopDB > /tmp/ShopDB_full_backup.sql


mysql \
    -u "$DB_USER" \
    -p"$DB_PASSWORD" \
    ShopDBReserve < /tmp/ShopDB_full_backup.sql


mysqldump \
    -u "$DB_USER" \
    -p"$DB_PASSWORD" \
    --no-create-info \
    ShopDB > /tmp/ShopDB_data_backup.sql


mysql \
    -u "$DB_USER" \
    -p"$DB_PASSWORD" \
    ShopDBDevelopment < /tmp/ShopDB_data_backup.sql


rm -f /tmp/ShopDB_full_backup.sql
rm -f /tmp/ShopDB_data_backup.sql

