#!/bin/bash

# Full backup of ShopDB and restore to ShopDBReserve
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --single-transaction ShopDB | \
    mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve

# Data-only backup of ShopDB and restore to ShopDBDevelopment
# (schema is not copied — only INSERT statements)
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --single-transaction --no-create-info ShopDB | \
    mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment
