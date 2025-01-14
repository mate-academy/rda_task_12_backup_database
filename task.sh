#!/bin/bash

PROD_DB="ShopDB"
RESERVE_DB="ShopDBReserve"
DEV_DB="ShopDBDevelopment"
DB_USER="backup"
DB_PASSWORD="password"


BACKUP_DIR="/tmp"
BACKUP_FILE="${BACKUP_DIR}/${PROD_DB}_backup.sql"

mysqldump -u"$DB_USER" -p"$DB_PASSWORD" --databases "$PROD_DB" > "$BACKUP_FILE"

mysql -u"$DB_USER" -p"$DB_PASSWORD" "$RESERVE_DB" < "$BACKUP_FILE"

DATA_BACKUP_FILE="${BACKUP_DIR}/${PROD_DB}_data_backup.sql"
mysqldump -u"$DB_USER" -p"$DB_PASSWORD" --no-create-info --databases "$PROD_DB" > "$DATA_BACKUP_FILE"

mysql -u"$DB_USER" -p"$DB_PASSWORD" "$DEV_DB" < "$DATA_BACKUP_FILE"

rm -f "$BACKUP_FILE" "$DATA_BACKUP_FILE"

