#! /bin/bash

USER="backup"
PASSWORD="P@ssw0rd"
PROD_DB="ShopDB"
RESERVE_DB="ShopDBReserve"
DEV_DB="ShopDBDevelopment"
BACKUP_FILE="shopdb_backup.sql"
DATA_ONLY_FILE="shopdb_data_only.sql"


echo "Dump creating $PROD_DB..."
mysqldump -u $USER -p$PASSWORD $PROD_DB > $BACKUP_FILE

echo "Dump backup in $RESERVE_DB..."
mysql -u $USER -p$PASSWORD $RESERVE_DB < $BACKUP_FILE


echo "Dump creating without structure..."
mysqldump -u $USER -p$PASSWORD --no-create-info $PROD_DB > $DATA_ONLY_FILE

echo "Data import in $DEV_DB..."
mysql -u $USER -p$PASSWORD $DEV_DB < $DATA_ONLY_FILE

echo "All operations have been completed."
