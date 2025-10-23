#! /bin/bash

if [[ -z "$DB_USER" || -z "$DB_PASSWORD" ]];
then
  echo "DB_USER and DB_PASSWORD environment variables must be set"
  exit 1
fi

DB_HOST="localhost"
DB_PROD="ShopDB"
DB_RESERVE="ShopDBReserve"
DB_DEV="ShopDBDevelopment"

echo "Creating full backup of $DB_PROD and restoring to $DB_RESERVE..."
mysqldump -u"$DB_USER" -p"$DB_PASSWORD" ShopDB > /tmp/full_backup.sql
mysql -u"$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < /tmp/full_backup.sql


echo "Creating data-only backup of $DB_PROD and restoring to $DB_DEV..."
mysqldump -u"$DB_USER" -p"$DB_PASSWORD" --no-create-info "$DB_PROD" > /tmp/data_backup.sql
mysql -u"$DB_USER" -p"$DB_PASSWORD" "$DB_DEV" < /tmp/data_backup.sql


echo "Backup and restore completed successfully."