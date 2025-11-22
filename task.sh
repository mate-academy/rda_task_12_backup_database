#!/bin/bash
set -e


if [[ -z "$DB_USER" || -z "$DB_PASSWORD" ]]; then
  echo "Error: DB_USER and DB_PASSWORD environment variables must be set."
  exit 1
fi


DB_HOST="${DB_HOST:-localhost}"


MYSQL="mysql -h${DB_HOST} -u${DB_USER} -p${DB_PASSWORD}"
MYSQLDUMP="mysqldump -h${DB_HOST} -u${DB_USER} -p${DB_PASSWORD}"


FULL_BACKUP_FILE="/tmp/shopdb_full_backup.sql"
DATA_ONLY_BACKUP_FILE="/tmp/shopdb_data_only.sql"

echo "1) Creating full backup of ShopDB (schema + data) ..."

$MYSQLDUMP ShopDB > "$FULL_BACKUP_FILE"
echo "   Restoring full backup into ShopDBReserve ..."
$MYSQL ShopDBReserve < "$FULL_BACKUP_FILE"

echo "2) Creating data-only backup of ShopDB ..."

$MYSQLDUMP --no-create-db --no-create-info ShopDB > "$DATA_ONLY_BACKUP_FILE"
echo "   Restoring data-only backup into ShopDBDevelopment ..."
$MYSQL ShopDBDevelopment < "$DATA_ONLY_BACKUP_FILE"

echo "3) Cleaning up temporary files ..."
rm -f "$FULL_BACKUP_FILE" "$DATA_ONLY_BACKUP_FILE"

echo "Backup and restore finished successfully."
