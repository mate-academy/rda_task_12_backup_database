#!/bin/bash
set -euo pipefail

if [ -z "${DB_USER:-}" ] || [ -z "${DB_PASSWORD:-}" ]; then
    echo "Error: DB_USER and DB_PASSWORD environment variables must be set."
    exit 1
fi

# Ensure target databases exist
mysql -u "$DB_USER" -p"$DB_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS ShopDBReserve;"
mysql -u "$DB_USER" -p"$DB_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS ShopDBDevelopment;"

# Backup ShopDB to ShopDBReserve
# Use sed to remove any USE statements to ensure the import targets ShopDBReserve
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB | sed 's/^USE `ShopDB`;//' | mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve

# Backup ShopDB data to ShopDBDevelopment
# First ensure the schema exists if it is missing (required for --no-create-info imports)
if ! mysql -u "$DB_USER" -p"$DB_PASSWORD" -e "DESCRIBE ShopDBDevelopment.Products" > /dev/null 2>&1; then
    echo "Schema missing in ShopDBDevelopment. Importing schema..."
    mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --no-data ShopDB | sed 's/^USE `ShopDB`;//' | mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment
fi

# Import data only
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --no-create-info ShopDB | sed 's/^USE `ShopDB`;//' | mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment
