#! /bin/bash

# Reading environment variables
DB_USER="${DB_USER}"
DB_PASSWORD="${DB_PASSWORD}"

# Backup path set
BACKUP_PATH="C:\\Users\\shche\\mate\\mysql.backup"

# Ensure the directory exists
mkdir -p "$BACKUP_PATH"

# Full backup of ShopDB and restore to ShopDBReserve
mysqldump -u"$DB_USER" -p"$DB_PASSWORD" --no-create-db ShopDB >"$BACKUP_PATH/ShopDB.sql"
mysql -u"$DB_USER" -p"$DB_PASSWORD" ShopDBReserve <"$BACKUP_PATH/ShopDB.sql"

# Backup only data from ShopDB and restore to ShopDBDevelopment
mysqldump -u"$DB_USER" -p"$DB_PASSWORD" --no-create-info --skip-add-drop-table ShopDB >"$BACKUP_PATH/ShopDBDataOnly.sql"
mysql -u"$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment <"$BACKUP_PATH/ShopDBDataOnly.sql"
