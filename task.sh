#!/bin/bash
User="$DB_USER"
Pass="$DB_PASSWORD"

echo "Start backup and restoration"

# Full backup (structure + data) -> ShopDBReserve
mysqldump -u "$User" -p"$Pass" ShopDB --result-file=ShopDB_back.sql
mysql -u "$User" -p"$Pass" ShopDBReserve < ShopDB_back.sql

# Data-only backup -> ShopDBDevelopment
mysqldump -u "$User" -p"$Pass" --no-create-info ShopDB --result-file=ShopDBDev_back.sql
mysql -u "$User" -p"$Pass" ShopDBDevelopment < ShopDBDev_back.sql

echo "Backup and restoration completed"