#!/bin/bash

SOURCE_DB="ShopDB"
RESERVE_DB="ShopDBReserve"
DEV_DB="ShopDBDevelopment"

DB_USER="${DB_USER}"
DB_PASSWORD="${DB_PASSWORD}"

echo "Creating full backup of $SOURCE_DB ..."
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --databases "$SOURCE_DB" > shopDBReserve.sql
if [ $? -ne 0 ]; then
  echo "Error creating backup of $SOURCE_DB"
  exit 1
fi

echo "Restoring backup to $RESERVE_DB ..."
mysql -u "$DB_USER" -p"$DB_PASSWORD" "$RESERVE_DB" < shopDBReserve.sql
if [ $? -ne 0 ]; then
  echo "Error restoring to $RESERVE_DB"
  exit 1
fi

echo "Creating data-only backup of $SOURCE_DB (no schema) ..."
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --no-create-info "$SOURCE_DB" > shopDBDevelopment.sql
if [ $? -ne 0 ]; then
  echo "Error creating data-only backup of $SOURCE_DB"
  exit 1
fi

echo "Restoring data-only backup to $DEV_DB ..."
mysql -u "$DB_USER" -p"$DB_PASSWORD" "$DEV_DB" < shopDBDevelopment.sql
if [ $? -ne 0 ]; then
  echo "Error restoring data-only to $DEV_DB"
  exit 1
fi

echo "Backup and restore completed successfully."