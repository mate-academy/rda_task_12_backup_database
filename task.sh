#! /bin/bash

# Databases names
SOURCE_DB="ShopDB"
RESERVE_DB="ShopDBReserve"
DEV_DB="ShopDBDevelopment"

echo "Creating reserve copy of $SOURCE_DB "
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --databases "$SOURCE_DB"  --result-file=shopDBReserve.sql

echo "Recover $RESERVE_DB on $SOURCE_DB"
mysql -u "$DB_USER" -p"$DB_PASSWORD" "$RESERVE_DB" < shopDBReserve.sql

echo "Creating developement copy of $SOURCE_DB "
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --databases "$SOURCE_DB" --no-create-info --result-file=shopDBDevelopment.sql

echo "Recover $DEV_DB on $SOURCE_DB"
mysql -u "$DB_USER" -p"$DB_PASSWORD" "$DEV_DB" < shopDBDevelopment.sql




