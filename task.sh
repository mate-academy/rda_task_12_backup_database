#!/bin/bash

set -e

# Check required environment variables
if [ -z "$DB_USER" ]; then
    echo "Error: DB_USER is not set"
    exit 1
fi

if [ -z "$DB_PASSWORD" ]; then
    echo "Error: DB_PASSWORD is not set"
    exit 1
fi

# Temporary backup files
FULL_BACKUP="/tmp/shopdb_full_backup.sql"
DATA_BACKUP="/tmp/shopdb_data_backup.sql"

MYSQL="mysql -u $DB_USER -p$DB_PASSWORD"
MYSQLDUMP="mysqldump -u $DB_USER -p$DB_PASSWORD"


# ------------------------------------------------
# Check databases
# ------------------------------------------------

if ! $MYSQL -e "USE ShopDB;" 2>/dev/null; then
    echo "Error: ShopDB does not exist"
    exit 1
fi

if ! $MYSQL -e "USE ShopDBDevelopment;" 2>/dev/null; then
    echo "Error: ShopDBDevelopment does not exist"
    echo "Run create-database.sql first"
    exit 1
fi


# ------------------------------------------------
# 1. Full backup: ShopDB -> ShopDBReserve
# ------------------------------------------------

echo "Creating full backup of ShopDB..."

$MYSQLDUMP ShopDB > "$FULL_BACKUP"

echo "Recreating ShopDBReserve..."

$MYSQL -e "
DROP DATABASE IF EXISTS ShopDBReserve;
CREATE DATABASE ShopDBReserve;
"

echo "Restoring full backup to ShopDBReserve..."

$MYSQL ShopDBReserve < "$FULL_BACKUP"


# ------------------------------------------------
# 2. Data-only backup: ShopDB -> ShopDBDevelopment
# ------------------------------------------------

echo "Creating data-only backup of ShopDB..."

$MYSQLDUMP \
    --no-create-info \
    ShopDB > "$DATA_BACKUP"

echo "Cleaning existing data in ShopDBDevelopment..."

{
    echo "SET FOREIGN_KEY_CHECKS=0;"

    $MYSQL -N -e "
        SELECT CONCAT('TRUNCATE TABLE \`', TABLE_NAME, '\`;')
        FROM information_schema.TABLES
        WHERE TABLE_SCHEMA = 'ShopDBDevelopment';
    "

    echo "SET FOREIGN_KEY_CHECKS=1;"
} | $MYSQL ShopDBDevelopment

echo "Restoring data to ShopDBDevelopment..."

$MYSQL ShopDBDevelopment < "$DATA_BACKUP"


# ------------------------------------------------
# Verification
# ------------------------------------------------

echo
echo "Databases:"
$MYSQL -e "
SHOW DATABASES LIKE 'ShopDB';
SHOW DATABASES LIKE 'ShopDBReserve';
SHOW DATABASES LIKE 'ShopDBDevelopment';
"

echo
echo "Tables in ShopDB:"
$MYSQL -e "SHOW TABLES;" ShopDB

echo
echo "Tables in ShopDBReserve:"
$MYSQL -e "SHOW TABLES;" ShopDBReserve

echo
echo "Tables in ShopDBDevelopment:"
$MYSQL -e "SHOW TABLES;" ShopDBDevelopment

echo
echo "Backup and restore completed successfully."