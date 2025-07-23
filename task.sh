#!/bin/bash

# Stop on error
set -e

# 🔐 Check environment variables
if [[ -z "$DB_USER" || -z "$DB_PASSWORD" ]]; then
  echo "❌ Error: DB_USER and DB_PASSWORD must be set as environment variables."
  exit 1
fi

# 🧱 Variables
HOST="localhost"
PRODUCTION_DB="ShopDB"
RESERVE_DB="ShopDBReserve"
DEVELOPMENT_DB="ShopDBDevelopment"
BACKUP_DIR="/tmp/db_backups"
TIMESTAMP=$(date +"%F_%H-%M-%S")

mkdir -p "$BACKUP_DIR"

# 🧩 1. Full Backup of ShopDB → ShopDBReserve
FULL_BACKUP="$BACKUP_DIR/full_backup_$TIMESTAMP.sql"
echo "📦 Creating full backup of $PRODUCTION_DB..."
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --host="$HOST" "$PRODUCTION_DB" > "$FULL_BACKUP"

echo "♻️ Restoring full backup to $RESERVE_DB..."
mysql -u "$DB_USER" -p"$DB_PASSWORD" --host="$HOST" "$RESERVE_DB" < "$FULL_BACKUP"

# 🧩 2. Data-only Backup of ShopDB → ShopDBDevelopment
DATA_BACKUP="$BACKUP_DIR/data_backup_$TIMESTAMP.sql"
echo "📦 Creating data-only backup (no schema) of $PRODUCTION_DB..."
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --host="$HOST" --no-create-info "$PRODUCTION_DB" > "$DATA_BACKUP"

echo "♻️ Restoring data-only backup to $DEVELOPMENT_DB..."
mysql -u "$DB_USER" -p"$DB_PASSWORD" --host="$HOST" "$DEVELOPMENT_DB" < "$DATA_BACKUP"

echo "✅ Backup and restore complete."
