#! /bin/bash

set -e

DB_USER=${DB_USER}
DB_PASSWORD=${DB_PASSWORD}

# Database names
PROD_DB="ShopDB"
RESERVE_DB="ShopDBReserve"
DEV_DB="ShopDBDevelopment"

# Timestamp for backup file name
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Temporary file names
FULL_BACKUP_FILE="/tmp/${PROD_DB}_full_${TIMESTAMP}.sql"
DATA_BACKUP_FILE="/tmp/${PROD_DB}_data_${TIMESTAMP}.sql"

# MySQL command shortcut
MYSQL_CMD="mysql -u${DB_USER} -p${DB_PASSWORD}"
MYSQLDUMP_CMD="mysqldump -u${DB_USER} -p${DB_PASSWORD}"

echo "=========================================="
echo " Starting nightly backup process..."
echo " Time: $(date)"
echo "=========================================="

# ----------- STEP 1: Full Backup and Restore to ShopDBReserve -----------
echo "[1/2] Creating full backup of ${PROD_DB} and restoring to ${RESERVE_DB}..."

# Create a full dump (schema + data)
$MYSQLDUMP_CMD --routines --triggers --events $PROD_DB > $FULL_BACKUP_FILE

# Restore to reserve DB
$MYSQL_CMD $RESERVE_DB < $FULL_BACKUP_FILE

echo "✔ Full backup successfully restored to ${RESERVE_DB}"

# ----------- STEP 2: Data-only Backup and Restore to ShopDBDevelopment -----------
echo "[2/2] Creating data-only backup of ${PROD_DB} and restoring to ${DEV_DB}..."

# Create a dump with data only (no schema)
$MYSQLDUMP_CMD --no-create-info $PROD_DB > $DATA_BACKUP_FILE

# Restore only data to development DB
$MYSQL_CMD $DEV_DB < $DATA_BACKUP_FILE

echo "✔ Data-only backup successfully restored to ${DEV_DB}"

# ----------- CLEANUP -----------
echo "Cleaning up temporary files..."
rm -f $FULL_BACKUP_FILE $DATA_BACKUP_FILE

echo "=========================================="
echo " Backup and restore completed successfully!"
echo " Finished at: $(date)"
echo "=========================================="

