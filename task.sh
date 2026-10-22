#! /bin/bash
set -e
password="$DB_PASSWORD"
user="$DB_USER"
if [[ -z "$password" || -z "$user" ]]; then
  echo "Error: DB_PASSWORD and DB_USER environment variables must be set."
  exit 1
fi
mysqldump -u "$user" -p"$password" ShopDB > backup.sql
mysql -u "$user" -p"$password" ShopDBReserve < backup.sql
mysqldump -u "$user" -p"$password" --no-create-info ShopDB > data_backup.sql
mysql -u "$user" -p"$password" ShopDBDevelopment < data_backup.sql
echo "Backup and restore completed successfully."