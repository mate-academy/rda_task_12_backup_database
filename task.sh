#! /bin/bash
echo "Creating full backup of ShopDB..."
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB > ShopDB_full_backup.sql
echo "Restoring full backup of ShopDB..."
mysql -u "$DB_USER" -p"$DB_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS ShopDBReserve;"
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < ShopDB_full_backup.sql
# Backup only data from ShopDB and restore to ShopDBDevelopment
echo "Creating data-only backup of ShopDB..."
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --no-create-info ShopDB > ShopDB_data_backup.sql
echo "Restoring data-only backup to ShopDBDevelopment..."
mysql -u "$DB_USER" -p"$DB_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS ShopDBDevelopment;"
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < ShopDB_data_backup.sql

