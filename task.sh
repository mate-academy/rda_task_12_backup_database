#! /bin/bash
# Exit immediately if a command exits with a non-zero status
set -e

# Check if required environment variables are set
if [[ -z "$DB_USER" || -z "$DB_PASSWORD" ]]; then
  echo "Error: DB_USER and DB_PASSWORD environment variables must be set."
  exit 1
fi

# Define database names
SOURCE_DB="ShopDB"
RESERVE_DB="ShopDBReserve"
DEV_DB="ShopDBDevelopment"

# Define timestamp for backup files
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Define backup file paths
FULL_BACKUP_FILE="/tmp/${SOURCE_DB}_full_backup_${TIMESTAMP}.sql"
DATA_BACKUP_FILE="/tmp/${SOURCE_DB}_data_backup_${TIMESTAMP}.sql"

# Create a full backup of ShopDB and restore it to ShopDBReserve
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" "$SOURCE_DB" > "$FULL_BACKUP_FILE"
mysql -u "$DB_USER" -p"$DB_PASSWORD" "$RESERVE_DB" < "$FULL_BACKUP_FILE"
echo "Full backup of $SOURCE_DB restored to $RESERVE_DB."

# Create a data-only backup of ShopDB and restore it to ShopDBDevelopment
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --no-create-info "$SOURCE_DB" > "$DATA_BACKUP_FILE"
mysql -u "$DB_USER" -p"$DB_PASSWORD" "$DEV_DB" < "$DATA_BACKUP_FILE"
echo "Data-only backup of $SOURCE_DB restored to $DEV_DB."

# Clean up temporary files
rm -f "$FULL_BACKUP_FILE" "$DATA_BACKUP_FILE"
echo "Backup process completed successfully."