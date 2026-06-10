#!/bin/bash
if [ -z "$DB_USER" ] || [ -z "$DB_PASSWORD" ]; then
  echo "DB_USER and DB_PASSWORD must be set"
  exit 1
fi

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB | mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --no-create-info ShopDB | mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment
