#!/bin/bash

# Full backup of ShopDB (schema + data), restore to ShopDBReserve
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB --result-file=ShopDBFull.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < ShopDBFull.sql

# Data-only backup of ShopDB (no schema), restore to ShopDBDevelopment
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --no-create-info ShopDB --result-file=ShopDB-NO-Schema.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < ShopDB-NO-Schema.sql
