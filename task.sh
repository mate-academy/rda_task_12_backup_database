#! /bin/bash

if [[ -z "$DB_USER" || -z "$DB_PASSWORD" ]]; then
  echo "ERROR: user or password for databases not set"
  exit 1
fi

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB > ShopDB.Backup

mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < ShopDB.Backup

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --no-create-info ShopDB > ShopDBDevelopment.backup

mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment  < ShopDBDevelopment.backup
