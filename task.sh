#! /bin/bash

set -e

if [[ -z "$DB_USER" || -z "$DB_PASSWORD" ]]; then
    echo "Error: DB_USER and DB_PASSWORD environment variables must be set."
    exit 1
fi

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB | mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve

mysqldump --no-create-info -u "$DB_USER" -p"$DB_PASSWORD" ShopDB | mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment

echo "Backup and restoration completed successfully."
