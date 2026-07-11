#!/bin/bash

set -euo pipefail

FULL_BACKUP="backup-full.sql"
DATA_BACKUP="backup-data-only.sql"

# 1. Full backup of ShopDB
mysqldump -u"$DB_USER" -p"$DB_PASSWORD" ShopDB --result-file="$FULL_BACKUP"

# copy only data from ShopDB
mysqldump -u"$DB_USER" -p"$DB_PASSWORD" --no-create-info ShopDB --result-file="$DATA_BACKUP"

# Full backup restore into ShopDBReserve
mysql -u"$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < "$FULL_BACKUP"

# loading data-only backup into ShopDBDevelopment
mysql -u"$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < "$DATA_BACKUP"