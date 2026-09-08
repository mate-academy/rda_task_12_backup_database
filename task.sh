#! /bin/bash

# Ensure required environment variables are set
if [ -z "$DB_USER" ] || [ -z "$DB_PASSWORD" ]; then
  echo "Error: DB_USER and DB_PASSWORD environment variables must be set." >&2
  exit 1
fi


# 1. Full database backup of ShopDB restored to ShopDBReserve
mysqldump -u"$DB_USER" -p"$DB_PASSWORD" ShopDB | mysql -u"$DB_USER" -p"$DB_PASSWORD" ShopDBReserve

# 2. Full backup + data-only backup of ShopDB (no schema) restored to ShopDBDevelopment

# 2.1 Create full backup with creating tables
mysqldump -u"$DB_USER" -p"$DB_PASSWORD" ShopDB | mysql -u"$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment

# 2.2 Just INSERT values to the table
mysqldump -u"$DB_USER" -p"$DB_PASSWORD" --no-create-info ShopDB | mysql -u"$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment