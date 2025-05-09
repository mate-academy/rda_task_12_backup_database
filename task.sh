#!/bin/bash

if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

USER="${DB_USER}"
PASSWORD="${DB_PASSWORD}"

DATE=$(date +%F)

# Full backup of ShopDB
mysqldump -u"$USER" -p"$PASSWORD" ShopDB > /tmp/shopdb_full_backup.sql

# Restore to ShopDBReserve (drop if exists, then recreate and import)
mysql -u"$USER" -p"$PASSWORD" -e "DROP DATABASE IF EXISTS ShopDBReserve; CREATE DATABASE ShopDBReserve;"
mysql -u"$USER" -p"$PASSWORD" ShopDBReserve < /tmp/shopdb_full_backup.sql

# Data-only backup of ShopDB
mysqldump -u"$USER" -p"$PASSWORD" --no-create-info ShopDB > /tmp/shopdb_data_only.sql

# Restore only data to ShopDBDevelopment (data insert only)
mysql -u"$USER" -p"$PASSWORD" ShopDBDevelopment < /tmp/shopdb_data_only.sql

