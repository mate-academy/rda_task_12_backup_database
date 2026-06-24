#! /bin/bash

BACKUP_DIR="$HOME/backups/mysql/shopdb"
mkdir -p "$BACKUP_DIR" || { echo "Error: could not create backup directory $BACKUP_DIR"; exit 1; }

if [ -z "$DB_USER" ] || [ -z "$DB_PASSWORD" ]; then
    echo "Error: DB_USER and DB_PASSWORD must be set as environment variables."
    exit 1
fi

TIMESTAMP=$(date +%Y%m%d_%H%M%S)

echo "INFO: Creating full backup of ShopDB"
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB --result-file="$BACKUP_DIR/full_backup_$TIMESTAMP.sql"

echo "INFO: Restoring full backup into ShopDBReserve"
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < "$BACKUP_DIR/full_backup_$TIMESTAMP.sql"


echo "INFO: Creating data-only backup of ShopDB"
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --no-create-info ShopDB --result-file="$BACKUP_DIR/data_backup_$TIMESTAMP.sql"

echo "INFO: Restoring data backup into ShopDBDevelopment"
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < "$BACKUP_DIR/data_backup_$TIMESTAMP.sql"

echo "INFO: Backup and restore procedure completed successfully."
