#! /bin/bash

DB_USER=${DB_USER}
DB_PASSWORD=${DB_PASSWORD}
HOST="192.168.1.120"

SOURCE_DB="ShopDB"
RESERVE_DB="ShopDBReserve"
DEV_DB="ShopDBDevelopment"

BACKUP_DIR="/tmp/db_backup"
mkdir -p $BACKUP_DIR

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" -h "$HOST" "$SOURCE_DB" > "$BACKUP_DIR/full_backup.sql"
mysql -u "$DB_USER" -p"$DB_PASSWORD" -h "$HOST" "$RESERVE_DB" < "$BACKUP_DIR/full_backup.sql"

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" -h "$HOST" --no-create-info "$SOURCE_DB" > "$BACKUP_DIR/data_backup.sql"
mysql -u "$DB_USER" -p"$DB_PASSWORD" -h "$HOST" "$DEV_DB" < "$BACKUP_DIR/data_backup.sql"

rm -rf "$BACKUP_DIR"