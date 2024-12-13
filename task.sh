#! /bin/bash

BACKUP_PATH="ShopDB_backup.sql"
DATA_BACKUP_PATH="ShopDB_data_backup.sql"

if [ -z "$DB_USER" ] || [ -z "$DB_PASSWORD" ]; then
  echo "Error: Environment DB_USER or DB_PASSWORD do not exist."
  exit 1
fi

check_error() {
  if [ $? -ne 0 ]; then
    echo "Error: $1"
    exit 1
  fi
}

echo "Creating full backup of ShopDB..."
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" \
  --databases ShopDB --result-file="$BACKUP_PATH" --no-create-db
check_error "Failed to create full backup of ShopDB."

echo "Restoring backup to ShopDBReserve..."
mysql -u "$DB_USER" -p"$DB_PASSWORD" \
  -e "DROP DATABASE IF EXISTS ShopDBReserve;"
mysql -u "$DB_USER" -p"$DB_PASSWORD" \
  -e "CREATE DATABASE ShopDBReserve;"
mysql -u "$DB_USER" -p"$DB_PASSWORD" \
  ShopDBReserve < "$BACKUP_PATH"
check_error "Failed to restore backup to ShopDBReserve."

echo "Creating data-only backup of ShopDB..."
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" \
  --databases ShopDB --result-file="$DATA_BACKUP_PATH" --no-create-info
check_error "Failed to create data-only backup of ShopDB."

echo "Restoring data to ShopDBDevelopment..."
mysql -u "$DB_USER" -p"$DB_PASSWORD" \
  ShopDBDevelopment < "$DATA_BACKUP_PATH"
check_error "Failed to restore data to ShopDBDevelopment."

echo "Backup and restoration completed successfully."