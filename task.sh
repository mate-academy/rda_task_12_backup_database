#! /bin/bash
set -euo pipefail

# 1. Full backup of ShopDB -> ShopDBReserve
mysqldump -u"$DB_USER" -p"$DB_PASSWORD" ShopDB | mysql -u"$DB_USER" -p"$DB_PASSWORD" ShopDBReserve

# 2. Data-only backup of ShopDB -> ShopDBDevelopment (no schema)
mysqldump -u"$DB_USER" -p"$DB_PASSWORD" --no-create-info ShopDB | mysql -u"$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment
