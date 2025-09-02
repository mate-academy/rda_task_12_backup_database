#! /bin/bash

BACKUP_DIR="/var/backups/mysql"
mkdir -p "$BACKUP_DIR"

FULL_BACKUP="$BACKUP_DIR/full_backup.sql"
mysqldump -u"$DB_USER" -p"$DB_PASSWORD" --databases ShopDB --result-file="$FULL_BACKUP"
mysql -u"$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < "$FULL_BACKUP"

DATA_BACKUP="$BACKUP_DIR/data_backup.sql"
mysqldump -u"$DB_USER" -p"$DB_PASSWORD" --no-create-info --databases ShopDB --result-file="$DATA_BACKUP"
mysql -u"$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < "$DATA_BACKUP"