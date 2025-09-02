#! /bin/bash

BACKUP_DIR="/var/backups/mysql"
mkdir -p "$BACKUP_DIR"

if [ -z "${DB_USER}" ] || [ -z "${DB_PASSWORD}" ]; then echo "Error: DB_USER and DB_PASSWORD must be set" >&2; exit 1; fi

FULL_BACKUP="$BACKUP_DIR/full_backup.sql"
mysqldump -u"$DB_USER" -p"$DB_PASSWORD" --databases ShopDB --result-file="$FULL_BACKUP"
mysql -u"$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < "$FULL_BACKUP"

DATA_BACKUP="$BACKUP_DIR/data_backup.sql"
mysqldump -u"$DB_USER" -p"$DB_PASSWORD" --no-create-info ShopDB --result-file="$DATA_BACKUP"
mysql -u"$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < "$DATA_BACKUP"