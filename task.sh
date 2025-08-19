#! /bin/bash
set -e  

if [[ -z "$DB_USER" || -z "$DB_PASSWORD" ]]; then
  echo "Error: DB_USER and DB_PASSWORD must be set"
  exit 1
fi

mysqldump -u"$DB_USER" -p"$DB_PASSWORD" ShopDB > full_backup.sql
mysql -u"$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < full_backup.sql
mysqldump -u"$DB_USER" -p"$DB_PASSWORD" --no-create-info ShopDB > no_schema_backup.sql
mysql -u"$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < no_schema_backup.sql


