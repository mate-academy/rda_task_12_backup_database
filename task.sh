#! /bin/bash

DB_USER=${DB_USER}
DB_PASSWORD=${DB_PASSWORD}

PROD="ShopDB"
RESERVE="ShopDBReserve"
STAGE="ShopDBDevelopment"

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --no-create-db "$PROD" > backup.reserve.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" "$RESERVE" < backup.reserve.sql

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --no-create-db --no-create-info "$PROD" > backup.stage.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" "$STAGE" < backup.stage.sql
