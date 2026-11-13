#!/bin/bash

# DB_USER and DB_PASSWORD are read from the environment variables

# 1. Full backup of ShopDB (structure and data), restored to ShopDBReserve
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB | mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve

# 2. Data-only backup of ShopDB, restored to ShopDBDevelopment
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --no-create-info --skip-triggers ShopDB | mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment
