#!/bin/bash
set -e

# ===== CONFIG =====
DB_USER=${DB_USER:-backup}
DB_PASSWORD=${DB_PASSWORD:-password}
DB_HOST="localhost"

SOURCE_DB="ShopDB"
RESERVE_DB="ShopDBReserve"
DEV_DB="ShopDBDevelopment"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_DIR="/tmp/db_backups"
mkdir -p "$BACKUP_DIR"

FULL_BACKUP_FILE="$BACKUP_DIR/${SOURCE_DB}_full_${TIMESTAMP}.sql"
DATA_BACKUP_FILE="$BACKUP_DIR/${SOURCE_DB}_data_${TIMESTAMP}.sql"

echo "=== Starting backup process at $TIMESTAMP ==="

# ===== 1. FULL BACKUP: ShopDB → ShopDBReserve =====
echo "[1/2] Creating full backup of $SOURCE_DB..."
mysqldump -h "$DB_HOST" -u"$DB_USER" -p"$DB_PASSWORD" --routines --triggers --events "$SOURCE_DB" > "$FULL_BACKUP_FILE"

echo "[1/2] Restoring backup into $RESERVE_DB..."
mysql -h "$DB_HOST" -u"$DB_USER" -p"$DB_PASSWORD" "$RESERVE_DB" < "$FULL_BACKUP_FILE"

echo "[1/2] ✅ Full backup and restore to $RESERVE_DB completed."

# ===== 2. DATA BACKUP: ShopDB → ShopDBDevelopment =====
echo "[2/2] Creating data-only backup of $SOURCE_DB..."
mysqldump -h "$DB_HOST" -u"$DB_USER" -p"$DB_PASSWORD" --no-create-info "$SOURCE_DB" > "$DATA_BACKUP_FILE"

echo "[2/2] Restoring data-only dump into $DEV_DB..."
mysql -h "$DB_HOST" -u"$DB_USER" -p"$DB_PASSWORD" "$DEV_DB" < "$DATA_BACKUP_FILE"

echo "[2/2] ✅ Data-only restore to $DEV_DB completed."

echo "=== Backup process finished successfully! ==="
