#! /bin/bash
set -euo pipefail

DB_USER="${DB_USER:?Environment variable DB_USER is not set}"
DB_PASSWORD="${DB_PASSWORD:?Environment variable DB_PASSWORD is not set}"

PROD_DB="ShopDB"
RESERVE_DB="ShopDBReserve"
DEV_DB="ShopDBDevelopment"

FULL_BACKUP="/tmp/shopdb_full_backup.sql"
DATA_ONLY_BACKUP="/tmp/shopdb_data_only.sql"

echo "Starting backup procedure..."

echo "Backing up $PROD_DB (full)..."
mysqldump -u"$DB_USER" -p"$DB_PASSWORD" --no-create-db "$PROD_DB" --result-file="$FULL_BACKUP"

echo "Restoring to $RESERVE_DB..."
mysql -u"$DB_USER" -p"$DB_PASSWORD" "$RESERVE_DB" < "$FULL_BACKUP"

echo "Backing up $PROD_DB (data only)..."
mysqldump -u"$DB_USER" -p"$DB_PASSWORD" --no-create-info "$PROD_DB" --result-file="$DATA_ONLY_BACKUP"

echo "Restoring data to $DEV_DB..."
mysql -u"$DB_USER" -p"$DB_PASSWORD" "$DEV_DB" < "$DATA_ONLY_BACKUP"

rm -f "$FULL_BACKUP" "$DATA_ONLY_BACKUP"
echo "Backup and restore completed successfully."
