#! /bin/bash

set -e

# Read credentials from environment variables
user="$DB_USER"
password="$DB_PASSWORD"

if [[ -z "$user" || -z "$password" ]]; then
  echo "Error: DB_USER and DB_PASSWORD environment variables must be set."
  exit 1
fi

# 1. Full backup of ShopDB (structure + data) and restore to ShopDBReserve
mysqldump -u "$user" -p"$password" ShopDB --no-create-db --result-file=backup.sql
mysql -u "$user" -p"$password" ShopDBReserve < backup.sql

# 2. Data-only backup of ShopDB and restore to ShopDBDevelopment
mysqldump -u "$user" -p"$password" ShopDB --no-create-info --result-file=backup-data.sql
mysql -u "$user" -p"$password" ShopDBDevelopment < backup-data.sql

echo "Backup and restore completed successfully."